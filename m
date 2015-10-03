From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/7] git-p4: add support for large file systems
Date: Sat, 03 Oct 2015 10:17:52 -0700
Message-ID: <xmqqh9m73m7z.fsf@gitster.mtv.corp.google.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih78tsDe-RAUOEjrGMBJU0sage37V1sL9QLPZhRQhb5GUCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Oct 03 19:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiQRb-0003tN-Ru
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 19:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbbJCRR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 13:17:56 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32874 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJCRRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 13:17:55 -0400
Received: by pacex6 with SMTP id ex6so135199464pac.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8ccjEVBLY3zw0H0ceerpehplpb+9J00MMAT8jhGhSd4=;
        b=BEkiiFrchy3ldodrsg61F7hJneOmr430quA/CP72YBf0+KMRT275CB2sK2+DVt+OkI
         ZHYmBqOallsfsYjp87Ml+XpESnrb4WAqxR653Vedus9XG42r3x/Iux6HN0S/EUNQWrVp
         KkzTgTFjRGf/vyiox7RUgETKHXWGDzJKHnIopn5hyKtkhZ0miflGSKLU4qf5jKfOw3tX
         dJOShuRWi+tNOpnWwxxFVI1o5F8p0sdW1LXb3n2UQmANSh4lk3+TvdzGp5CKFFsQJHM8
         SWlubdvoJMw8+h0/hdBMydBxlRICc81BieXKYJ0i6aka0710IxarnhChMdzjFBlNEMEc
         vO3w==
X-Received: by 10.68.219.169 with SMTP id pp9mr28532596pbc.115.1443892674900;
        Sat, 03 Oct 2015 10:17:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6403:45be:a5c3:ebf3])
        by smtp.gmail.com with ESMTPSA id fk8sm18523381pab.33.2015.10.03.10.17.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Oct 2015 10:17:52 -0700 (PDT)
In-Reply-To: <CAE5ih78tsDe-RAUOEjrGMBJU0sage37V1sL9QLPZhRQhb5GUCA@mail.gmail.com>
	(Luke Diamand's message of "Sat, 3 Oct 2015 17:27:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278978>

Luke Diamand <luke@diamand.org> writes:

> On 26 September 2015 at 08:54,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> diff to v7:
>> * fix commit message line length (thanks Junio)
>> * fix sync command for large file system support (thanks Luke!)
>> * add test case for sync command
>> * rename git-p4.pushLargeFiles to git-p4.largeFilePush for consistency with
>>   other git-p4.largeFile* configs
>> * fix relative path handling for clone operation which caused a crash in the
>>   disk space check and t9819 (thanks Luke!)
>> * use test_path_is_missing instead of !test_path_is_file (thanks Luke!)
>>
>> The patch is again based on maint (ee6ad5f) as patches v1-v6 before.
>
>
> All looks good to me, Ack.
>
> One tiny thing perhaps Junio could comment on: the git commit message
> for 75abe9fa5b39980de27dfc33dd5b4f4b5926f34c, "git-p4: add optional
> type specifier to gitConfig reader" uses what looks like UTF-8 encoded
> left and right quotes, rather than regular ASCII quotes ("). I don't
> know if that matters.

Yeah, I noticed them, too.  In general, I'd prefer to avoid these
pretty-quotes myself, as they typically do not add much information
(unless nesting matters, which is usually not the case in the log
message, or something) and the primary effect of them is to force us
to step outside ASCII, which causes editors and pagers to misalign
for some people.

But it is not too huge an issue that it is worth to go back and fix
them, either.

Thanks.
