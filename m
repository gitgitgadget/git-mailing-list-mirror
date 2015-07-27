From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/10] ref-filter: add support to sort by version
Date: Mon, 27 Jul 2015 08:24:22 -0700
Message-ID: <xmqqvbd5ipy1.fsf@gitster.dls.corp.google.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-6-git-send-email-Karthik.188@gmail.com>
	<xmqqd1zfkgi3.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQ89Vz82ro_V8mTgYKZ0UUgbsbAW6zgSgyiZ1gpwjTOHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 17:24:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkGT-00081A-EW
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 17:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbbG0PYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 11:24:25 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36636 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbbG0PYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 11:24:24 -0400
Received: by pdjr16 with SMTP id r16so54669053pdj.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4VHMeVSpeVVut68RXvOWNG7BXaEXBF0WpKnoYjlEBgE=;
        b=KsOmbRSH6YGMCNIM0TaLkGuxJHxxrwGQC8BU8UYOEp3RgpjDHVAmmGjhVzmEPykqQm
         Ym6mvcndl3lPG4lLkr9cRhOxryY437nIJ/06goryRxO8gVL1Jm6QlhDo1doH+ssoFchR
         7N7rX9X9NAsvfD/rAzu7y8qrYyl8DN6gltrpa9sgFfaM6f53HdQqygBNtD/MtLkpHloM
         997dr0LpXvjxkCuZz7wnUuWqYYtb079wconkfJg27C7asm49cAwmcnjzqubh0Ra6/G3g
         dwxUtDypQ9jtXVH9NC8BK6OBH3Xj/1XdG5suQ/DzfE08ww20ePUYZriUuh9UZGef9cOH
         IR0g==
X-Received: by 10.70.102.209 with SMTP id fq17mr70351123pdb.77.1438010664193;
        Mon, 27 Jul 2015 08:24:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id hl6sm30093697pdb.28.2015.07.27.08.24.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 08:24:23 -0700 (PDT)
In-Reply-To: <CAOLa=ZQ89Vz82ro_V8mTgYKZ0UUgbsbAW6zgSgyiZ1gpwjTOHA@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 26 Jul 2015 10:37:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274682>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Sun, Jul 26, 2015 at 4:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Without looking at the callers, s->version looks like a misdesign
>> that should be updated to use the same cmp_type mechanism?  That
>> would lead to even more obvious construct that is easy to enhance,
>> i.e.
>>
>>         switch (cmp_type) {
>>         case CMP_VERSION:
>>                 ...
>>         case CMP_STRING:
>>                 ...
>>         case CMP_NUMBER:
>>                 ...
>>         }
>>
>> I dunno.
>>
>> Other than that (and the structure of that "format-state" stuff we
>> discussed separately), the series was a pleasant read.
>>
>> Thanks.
>
> That was the previous design, but Duy asked me to do this so
> that we could support all atoms. And I agree with him on this.
>
> http://article.gmane.org/gmane.comp.version-control.git/273888

I am not objecting, but $gmane/273888 does not immediately read, at
least to me, as suggesting using a mechanism different from cmp_type
but a dedicated field s->version.  Puzzled...
