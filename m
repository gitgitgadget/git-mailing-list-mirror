From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Wed, 29 Jul 2015 15:05:45 -0700
Message-ID: <xmqqwpxi7h6u.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
	<xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
	<xmqqy4hy973q.fsf@gitster.dls.corp.google.com>
	<xmqqtwsm94j1.fsf@gitster.dls.corp.google.com>
	<vpqh9omek39.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKZU2-00030V-Bl
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 00:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbbG2WFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 18:05:49 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34750 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbG2WFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 18:05:49 -0400
Received: by pdbbh15 with SMTP id bh15so12530938pdb.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UAQxtUeazc+XAKkE4xlIr2YOg16ouS82VthjsrNp9qo=;
        b=Z7mLDKlAg+8v5gjO+CqLE4euqx5LxPwk9UqzSAwmQkyDvWM5RcgvP1vGq/G4Bt7Dg2
         ehEMkKHc0SdwYhlAi2iiwyFfujysDa5cCcPGYcrGO/2QCNWlqqfxOD4vmwm/5xgCae2O
         6UE9pqAtPZ6CkU/vGaoIbiz5SiF2A6tBKzC4s32dc1sxKXXDMQ6r4PcvnfEGpco+MFEJ
         ZgBeqr+mnqQ6E8n5TN2ZcklbuUlJLPJYIt1FexStJ4YUXfuNYZwbNiLzFhdZrE31pgTp
         VD6CWH9enGMbBDgHgysNoFGAGgpSr0LWOx9NrJoPBalOLRC2+fj4BSHiC5Sb53ejuGhT
         4wWg==
X-Received: by 10.70.23.196 with SMTP id o4mr98818451pdf.164.1438207548595;
        Wed, 29 Jul 2015 15:05:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id db1sm42513275pdb.50.2015.07.29.15.05.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 15:05:47 -0700 (PDT)
In-Reply-To: <vpqh9omek39.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	29 Jul 2015 23:21:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274961>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> Couldn't think of a better replacer, any suggestions would be welcome :)
>>>
>>> See below.
>>> ...
>>> One way to do all of the above is ...
>>
>> Note that is just "one way", not the only or not necessarily the
>> best.  It certainly is not the easiest, I think.
>>
>>     %(if:atom)...%(endif)
>>
>> might be easier to implement.
>
> And I find it easier to read or write too. Nested parenthesis in a
> format string make them really tricky. That removes the need for
> escaping since the content of the if/endif is a format string like the
> others, it can use the same escaping rules (IIRC, %% to escape a %).

Yeah, that is also a good point.
