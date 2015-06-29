From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/11] for-each-ref: add '--points-at' option
Date: Mon, 29 Jun 2015 11:38:11 -0700
Message-ID: <xmqqk2um9x7w.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
	<1435222633-32007-1-git-send-email-karthik.188@gmail.com>
	<1435222633-32007-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:38:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dwh-00087L-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 20:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbbF2SiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 14:38:16 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34693 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbF2SiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 14:38:14 -0400
Received: by igcsj18 with SMTP id sj18so87415411igc.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NnNxEw4O167/1SQeu6Qfk8A/UWigmMvB13DnSfg8n/k=;
        b=AqIpinKALgBzayPxJ9Fkgv+CD7OBPs733ChDF/fK7w5VgdzG4TssvOCla3e5ZtPiQ+
         PXn0LjNJiFDLMYwsrDeOqE5Q8lecoLT7gVtSRkvAV+1W+qEiBN1oyAMD4FqTcv4SuBA3
         kAl8iKWkSHW9dDToJqLlf0qCbkGa4Bk38GaiLR9aicab4yKEKKrI5VWLUw4dWQOZUFtx
         KFvbQIIAM/Gwx2LFR5vGT5R415dvKioaog+LAMrzuDWqIZujhuC2w00YVVTmR6kaSpNi
         VGQTuC/xqnute9XhgABEGSNRKZJm4l9zGdVvREsMhWgYhWSGVqhNaQlYKsxvOkSsxrL8
         JytA==
X-Received: by 10.107.3.41 with SMTP id 41mr23744227iod.48.1435603093710;
        Mon, 29 Jun 2015 11:38:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id j4sm6014886igo.0.2015.06.29.11.38.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 11:38:12 -0700 (PDT)
In-Reply-To: <1435222633-32007-4-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 14:27:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272992>

Karthik Nayak <karthik.188@gmail.com> writes:

> +test_expect_success 'check signed tags with --points-at' '
> +	cat >expect <<-\EOF &&
> +	refs/heads/side
> +	refs/tags/four
> +	refs/tags/signed-tag four
> +	EOF
> +	git for-each-ref --format="%(refname) %(*subject)" --points-at=side >actual &&
> +	test_cmp expect actual
> +'

This piece seems to fail without a trailing whitespace in the
expected file.  I initially suspected that they were dropped
on my end while applying with "git am --whitespace=fix", but going
back to my mailbox, it seems that what gmane received does not have
them in the first place:

	sed -e "s/Z$//" <<-\EOF &&
        refs/heads/side Z
        refs/tags/four Z
        refs/tags/signed-tag four
        EOF

or something like that to make the EOL more visible to those who are
reading the tests, perhaps?
