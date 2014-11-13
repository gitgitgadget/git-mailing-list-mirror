From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH] allow TTY tests to run under recent Mac OS
Date: Thu, 13 Nov 2014 14:40:50 -0800
Message-ID: <CAO2U3QgbCVnF=TFWD5ZFjMSc=ez21KObSdF=v75DfDSJhH8A5Q@mail.gmail.com>
References: <1415916087-18953-1-git-send-email-blume.mike@gmail.com> <xmqq1tp6zqq1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:41:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp34l-0001w5-P9
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 23:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934159AbaKMWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 17:41:12 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:44268 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065AbaKMWlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 17:41:11 -0500
Received: by mail-oi0-f47.google.com with SMTP id v63so1897638oia.6
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 14:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QzUaRYdFjfReuHy8Eml1exE0oKIg4I8NgV5pOPiW1Ec=;
        b=I8Jzdquz+5IvIGcvDJaxhyamnhuuZpeGqeMKA3du4Xev5T3kWPG8+1X4iVKRe6whmv
         wG5kcKrkLxkWg9VSaSlO7HIsopotuXfTSu8fFoA00QJhHnul8FbgLFA+V8dzGNQVvrVC
         L5YtBELODQpLwzOz6AMeID/MPBvFa/+5G9NJjHiC7mwqU6j/4mtoVobtCTMlbvlJvWGX
         a0MFJ9wImJI2gxajZVvDTxdBP0DYqO/LylbI8EMpbiSb2+Leh7+Sn9sAnhlN+db8hKI0
         tKlrWbo8c70ZgYCtTDWj2zVE/JA/db77KZkt17nPow3rULTnvrkGhLLN2oNeMjrsooOH
         Dtsg==
X-Received: by 10.202.214.19 with SMTP id n19mr4116521oig.9.1415918470640;
 Thu, 13 Nov 2014 14:41:10 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Thu, 13 Nov 2014 14:40:50 -0800 (PST)
In-Reply-To: <xmqq1tp6zqq1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ah, sorry, didn't realize those were bash-only

On Thu, Nov 13, 2014 at 2:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Blume <blume.mike@gmail.com> writes:
>
>> listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
>> TTY on Yosemite and higher
>>
>> Signed-off-by: Mike Blume <blume.mike@gmail.com>
>> ---
>>  t/lib-terminal.sh | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
>> index 5184549..1311ce0 100644
>> --- a/t/lib-terminal.sh
>> +++ b/t/lib-terminal.sh
>> @@ -29,7 +29,10 @@ test_lazy_prereq TTY '
>>       # After 2000 iterations or so it hangs.
>>       # https://rt.cpan.org/Ticket/Display.html?id=65692
>>       #
>> -     test "$(uname -s)" != Darwin &&
>> +     # Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
>> +     # appears to be gone.
>> +     #
>> +     [[ test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1") -ge 14 ]] &&
>
> This is designed to be a plain vanilla POSIX shell script.  Please
> avoid these double brackets.
>
>>
>>       perl "$TEST_DIRECTORY"/test-terminal.perl \
>>               sh -c "test -t 1 && test -t 2"
