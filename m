From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v14 4/6] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Wed, 13 Apr 2016 14:09:39 +0530
Message-ID: <CAFZEwPMjDxFHOdbOgqXmBoud=2gmrpfiR4Aa83_7+bjka1bk4g@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60971-0bf3b786-4acd-4317-bd3c-3397dc2b51f9-000000@eu-west-1.amazonses.com>
	<CAPig+cQM_E9VgsxifBcT_XGyTCCaanNcfQEm6rU85pSNaQG7MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 10:39:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqGL3-0007SI-05
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 10:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbcDMIjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 04:39:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34812 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbcDMIjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 04:39:40 -0400
Received: by mail-yw0-f196.google.com with SMTP id h6so5688026ywc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=c+w0PfYO5gVsMFITfE1HHUqr6Y+kCqVckxBKeoNtwEI=;
        b=lSijPzp77RzhgjZaqw+s2NhRXlge2vRK2D4ndRxtXGskmWYL2bjkqWEcLeKgAiUNNn
         N2+xQ69Urmuy+wmSIruFHa7R2fLStRw5YQS/QnUcuigswzplio8lz/twJxfmSkVV9+Tx
         I7K7gyYZiRjQ8IlrhKn+9MEFCEtzfwUULAFCp+TR5OgtCGrZar7a78Eyz4BxScWlwjl/
         Kf9nwRThLglon8mQspI2ifoJ/206zzSnbjsAoAZ6z95eBceD6PMlVMwC2VvN5guHMbC4
         3OJRGLe2Vy2US4Ah3MS4YhHl84lOY3DQ0SlTwQUnR25DbdaUXyqxqad1bH916S27fUM+
         QDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=c+w0PfYO5gVsMFITfE1HHUqr6Y+kCqVckxBKeoNtwEI=;
        b=M0t4jQX8zoqH9HdNUOnMR00dcy5nKZ/n3dUU9Go84LIiINtwQalooceD0NkIuBMVia
         XGc5rAn8EpBr+h8LHAMZuR8J/vfeSl0P22OnC4JTCan9FqXhVWCl0lwuEFAK3ea2x/QC
         HlxPgD2IcqgG98/kn9lk4ZX6OIsOM6xBPnYSG7Vpo1AOdXly3arRPKW97XiiWG1GZIeY
         RzmvZC8YT2c0N5x9mev5SJ0Jl2C1+r+wnQ6x8K5c5zxcNf41UZZjLcW9EjSIhzjwkYuy
         mMpUj/tVK3rgRyXUv0m/zvPqVJVa/TsWm4aiNox0JZ9LJiz1ncJD4rVQWeriPmAqrahu
         ZYfQ==
X-Gm-Message-State: AOPr4FWrU+fAbUOmol8M7aIB530Sghdo3R8dgORA5EFumLuzzYdP/krzH39XfgRieMhsA1TbSfAc7jy7TBbgLw==
X-Received: by 10.13.235.209 with SMTP id u200mr4595570ywe.20.1460536779217;
 Wed, 13 Apr 2016 01:39:39 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Wed, 13 Apr 2016 01:39:39 -0700 (PDT)
In-Reply-To: <CAPig+cQM_E9VgsxifBcT_XGyTCCaanNcfQEm6rU85pSNaQG7MQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291380>

On Wed, Apr 13, 2016 at 11:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> OPT_COUNTUP() merely increments the counter upon --option, and resets it
>> to 0 upon --no-option, which means that there is no "unspecified" value
>> with which a client can initialize the counter to determine whether or
>> not --[no]-option was seen at all.
>>
>> Make OPT_COUNTUP() treat any negative number as an "unspecified" value
>> to address this shortcoming. In particular, if a client initializes the
>> counter to -1, then if it is still -1 after parse_options(), then
>> neither --option nor --no-option was seen; If it is 0, then --no-option
>> was seen last, and if it is 1 or greater, than --option was seen last.
>
> Nit: I'm pretty sure that when I wrote this commit message for you[1]
> the "if" following the semicolon was correctly lowercase. It's not
> clear why it got incorrectly capitalized here.

A typo. Will fix it if re-rolled

> More below...
>
>> This change does not affect the behavior of existing clients because
>> they all use the initial value of 0 (or more).
>>
>> Note that builtin/clean.c initializes the variable used with
>> OPT__FORCE (which uses OPT_COUNTUP()) to a negative value, but it is set
>> to either 0 or 1 by reading the configuration before the code calls
>> parse_options(), i.e. as far as parse_options() is concerned, the
>> initial value of the variable is not negative.
>>
>> To test this behavior, in test-parse-options.c, "verbose" is set to
>> "unspecified" while quiet is set to 0 which will test the new behavior
>> with all sets of values.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
>> @@ -144,8 +144,12 @@ There are some macros to easily define options:
>>  `OPT_COUNTUP(short, long, &int_var, description)`::
>>         Introduce a count-up option.
>> -       `int_var` is incremented on each use of `--option`, and
>> -       reset to zero with `--no-option`.
>> +       Each use of `--option` increments `int_var`, starting from zero
>> +       (even if initially negative), and `--no-option` resets it to
>> +       zero. To determine if `--option` or `--no-option` was set at
>
> Repeating from [1]: s/was set/was encountered/
>
>> +       all, set `int_var` to a negative value, and if it is still
>
> Repeating from [1] and [2]: s/set `int_var`/initialize `int_var`/

Will include this if re-rolled.
>
>> +       negative after parse_options(), then neither `--option` nor
>> +       `--no-option` was seen.
>> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
>> @@ -454,6 +454,25 @@ dry run: no
>> +test_expect_success 'OPT_COUNTUP() resets to 0 with --no- flag' '
>
> What is "--no- flag"?
>
>> +       test-parse-options --no-verbose >output 2>output.err &&
>> +       test_must_be_empty output.err &&
>> +       test_cmp expect output
>> +'
>
> In my v12 review, I noticed that neither --no-verbose nor --no-quiet
> was being tested by t0040 (which is conceptually independent of the
> OPT__COUNTUP change) and suggested[3] that you add a new patch to
> address that shortcoming. This idea was followed up by [1] saying that
> this test (here) could then be dropped since the case it checks would
> already be covered by the new patch. My impression was that you
> agreed[4] that that made sense, however, this test is still here. Did
> I misunderstand your response[4]?
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/290662
> [2]: http://article.gmane.org/gmane.comp.version-control.git/289991
> [3]: http://article.gmane.org/gmane.comp.version-control.git/290655
> [4]: http://article.gmane.org/gmane.comp.version-control.git/290787

I actually did include the tests in the patch 3/6[1]. I mentioned in
my response[2] that I will include the tests between 2/5 and 3/5.
Since, after that no email was exchanged, I thought you agreed.

[1]: http://article.gmane.org/gmane.comp.version-control.git/291310
[2]:http://article.gmane.org/gmane.comp.version-control.git/290787
