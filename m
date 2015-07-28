From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] Documentation/config: mention "now" and "never" for
 'expire' settings
Date: Tue, 28 Jul 2015 16:33:06 -0400
Message-ID: <CAPig+cQPj3wA8EfdNTskCUc__QXLwR07Ck4QrYvc9wnZqOxtug@mail.gmail.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
	<1437710457-38592-3-git-send-email-sunshine@sunshineco.com>
	<55B58C3B.7040200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBYm-0003Hv-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbbG1UdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:33:08 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36645 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbG1UdH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:33:07 -0400
Received: by ykay190 with SMTP id y190so105892589yka.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nL5rH28y/cpl3p4bWtG63h+0RPEVmn3ovr/M1cFHNek=;
        b=TOd7JBufbOMvKs1GXspeIU2buQAAGDwbO4PShbxMfdD5EtPgUS5NzsuHdsQX6Sx7ZF
         8PWhZodEr4UwjmFQTAi1f63tk0iRqSxEvh0di1ZXO/qUDU5DWjZtMtP7R/IBbippOZGm
         WLKGwoA0sHcokAZA/9d3hSze82Ci5HT3urzQFwhCpouTOM7CSXLX2nU1RI3j99f7legV
         JTuMjVlI949Km36zxtgrg/IEaygKE54OrIVye0LIS1X8/Zwo1nVLyma0ERJtGHK/7LVs
         zW8wEfK0JGAKFYNljAGC1+9dZgRV8N96AChjeQTo+SXUmOUQuvdtr4civqiOvscgyOen
         lojQ==
X-Received: by 10.129.76.140 with SMTP id z134mr41057213ywa.17.1438115586688;
 Tue, 28 Jul 2015 13:33:06 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 28 Jul 2015 13:33:06 -0700 (PDT)
In-Reply-To: <55B58C3B.7040200@alum.mit.edu>
X-Google-Sender-Auth: dOJG-WNKkyjlVDIW4gd6lUgDFFo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274840>

On Sun, Jul 26, 2015 at 9:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 07/23/2015 09:00 PM, Eric Sunshine wrote:
>> In addition to approxidate-style values ("2.months.ago", "yesterday"),
>> consumers of 'gc.*expire*' configuration variables also accept and
>> respect 'now'/'all' ("do it immediately") and 'never'/'false' ("suppress
>> entirely").
>>
>> Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>  gc.pruneExpire::
>>       When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
>>       Override the grace period with this config variable.  The value
>> -     "now" may be used to disable this  grace period and always prune
>> -     unreachable objects immediately.
>> +     "now" may be used to disable this grace period and always prune
>> +     unreachable objects immediately; or "never" to suppress pruning.
>
> A semicolon should be used without a conjunction, and the parts of a
> sentence joined by a semicolon should be independent clauses. So this
> should probably be
>
>                                                      [...] The value
>     "now" may be used to disable this grace period and always prune
>     unreachable objects immediately, or "never" may be used to
>     suppress pruning.

I was absent from school that day...

>> @@ -1328,7 +1330,8 @@ gc.reflogExpireUnreachable::
>>  gc.<ref>.reflogExpireUnreachable::
>>       'git reflog expire' removes reflog entries older than
>>       this time and are not reachable from the current tip;
>> -     defaults to 30 days.  With "<pattern>" (e.g. "refs/stash")
>> +     defaults to 30 days. The value "all" expires all entries; and
>> +     "false" disables expiration. With "<pattern>" (e.g. "refs/stash")
>>       in the middle, the setting applies only to the refs that
>>       match the <pattern>.
>
> Also, I wonder why you suggest "now"/"never" for the first two settings,
> but "all"/"false" for the second two. Wouldn't it be less confusing to
> be consistent?

It was intentional due to the way I worded the sentence. It sounded
slightly strange to my ear to say:

    The value "now" expires all entries; and "never"
    disables expiration.

whereas:

    The value "all" expires all entries; ...

sounded nice. But, upon reflection, with a slight re-wording[1], "all"
and "never" work, as well.

[1]: http://article.gmane.org/gmane.comp.version-control.git/274828
