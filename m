From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH bc/connect-plink] t5601-clone: remove broken and pointless check for plink.exe
Date: Tue, 11 Aug 2015 15:56:08 -0700
Message-ID: <xmqq37zpo2nr.fsf@gitster.dls.corp.google.com>
References: <55CA6066.5070500@kdbg.org>
	<CAPig+cS2CPFPBK+4W56dRVUas8UDpV1FZfMmOqxm6mprW+O_mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:56:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPISu-0004nL-1j
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 00:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbbHKW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 18:56:11 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34145 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbbHKW4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 18:56:10 -0400
Received: by pawu10 with SMTP id u10so110843paw.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qZJ5ngoyBxTXUpfDuur63vVHpjtJDpPnyM4pAly4xFw=;
        b=R4KFaWRXYU14WyT0pFbJvff1nPhrPIgMy9fXbBmFEVPnWbA9bw1XRhr9o0KtPeT8Hn
         Rm9a2msFtOlncSQZkM8BQ5akd4qa+hOevdXqKwB9ww2spZhWKnqkLv8zV0eakee1140y
         EIQJt6t6MbnujrV/255ya+piX0MjfGSBnVaiML4RFbQPd0sXlxfOKz7JpeCnyc1cnl9t
         Hj0TBNmjGk2dBb+7aPPHbob1fZktfpA6CRzvjXbzOZ4zUJ0NYKvlPVucIi2mUq5uAyHq
         UyHwjnfXrENlA7uxWYd7VfWFtS8mKoK/mmN60ZRROTPtsHcRyQTKCGkAe/v6zPbs5M4f
         3b2A==
X-Received: by 10.66.55.66 with SMTP id q2mr61058359pap.94.1439333770323;
        Tue, 11 Aug 2015 15:56:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id fa1sm3944288pbb.35.2015.08.11.15.56.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 15:56:09 -0700 (PDT)
In-Reply-To: <CAPig+cS2CPFPBK+4W56dRVUas8UDpV1FZfMmOqxm6mprW+O_mw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 11 Aug 2015 18:50:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275743>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 11, 2015 at 4:51 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Invoking plink requires special treatment, and we have support and even
>> test cases for the commands 'plink' and 'tortoiseplink'. We also support
>> .exe variants for these two and there is a test for 'plink.exe'.
>>
>> On Windows, however, where support for plink.exe would be relevant, the
>> test case fails because it is not possible to execute a file with a .exe
>> extension that is actually not a binary executable---it is a shell
>> script in our test. We have to disable the test case on Windows.
>>
>> Considering, that 'plink.exe' is irrelevant on non-Windows, let's just
>> remove the test and assume that the code "just works".
>
> putty and plink are used on Unix as well. A quick check of Mac OS X,
> Linux, and FreeBSD reveals that package managers on each platform have
> putty and plink packages available.

But they do not force their users to say "plink.exe", but instead
let them invoke "plink", no?

The test before the one that was removed is about "plink" (sans .exe),
and what was removed is with ".exe", so I think J6t's patch is OK.

Or am I still missing something?

>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  t/t5601-clone.sh | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
>> index 9b34f3c..df69bf6 100755
>> --- a/t/t5601-clone.sh
>> +++ b/t/t5601-clone.sh
>> @@ -353,12 +353,6 @@ test_expect_success 'plink is treated specially (as putty)' '
>>         expect_ssh "-P 123" myhost src
>>  '
>>
>> -test_expect_success 'plink.exe is treated specially (as putty)' '
>> -       copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
>> -       git clone "[myhost:123]:src" ssh-bracket-clone-plink-1 &&
>> -       expect_ssh "-P 123" myhost src
>> -'
>> -
>>  test_expect_success 'tortoiseplink is like putty, with extra arguments' '
>>         copy_ssh_wrapper_as "$TRASH_DIRECTORY/tortoiseplink" &&
>>         git clone "[myhost:123]:src" ssh-bracket-clone-plink-2 &&
>> --
>> 2.3.2.245.gb5bf9d3
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
