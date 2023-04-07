Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D5AC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 02:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbjDGCTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 22:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjDGCTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 22:19:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0098A9
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 19:19:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id cw23so5536135ejb.12
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 19:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680833981; x=1683425981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtX98K5Nsd8Hlgx5J5WRnRm9O0Koai/O3qbYVbnIDS4=;
        b=AeyBzo8QGFIehVYEALs1V4XuOG+7ktvZu7ev+y7nR72b8cEu4ckizcRD+FugOU9Oid
         fTkTCwgiQ4pvxCEICUqCeiPKVVupRelJhhuN7mCEjMtenDzEciFHKyheXWRJ/71Px6s7
         99XQlm7paiCaLDB1J2yJ9ZeUzA8YfRqFw14jL8ktZgo6Uyz/5WQusjwgw5xsYvV864aN
         o/DMSfSp/yNgIZXscRnZeXNnFZdeITHIQE4T8rKRM8uDpHUgUw1Y8mO0YEB0IdCdbQHs
         nR8DTBMExsWnf5eTRYhhTxKMZXEzO5+Q8+ooFk9OmxTsEf0RoPwBCu/cpPnCG2ONgiSg
         TRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680833981; x=1683425981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtX98K5Nsd8Hlgx5J5WRnRm9O0Koai/O3qbYVbnIDS4=;
        b=hU4yjoxfrLVD8UUmyvylTOBv8HjAULHpp0Y+YWyFrnQmSIb0xQcBzmRndpGyZL3Su0
         BAivbSyv6A/B7+U873PcAgZ/ByF5aDfPUyyfUbtZxev09N4OlR8hPr339d5zD7fTfmYs
         6ljFJjMZ6bns83xE/oM6Dlv3MYQtK9fAQeio2DsKoez/MqJ6YD0M7FnXGrjExPaLnNtT
         pTkSfJzbLPIswjYgC22fWNB04aNmAQDrmWko/iuhSkbcI3qcCmz+AstX+AcZVBgm+AJt
         0ZjB2/EZyHTbHrI3cEbeWOTkeWyvaO7zHrVeelBmy9dzYKFI9TNjrxYkcNCTaluu4mU6
         EN/g==
X-Gm-Message-State: AAQBX9cjD8XmdU8LeXNUCTgQysZtUxGCo+NdyU6WQOb5QUjRoyNNwzej
        /vV3x3SOuyTc2mYuVmf5fsk=
X-Google-Smtp-Source: AKy350ZzTRJDk21SI8/Xs3CogubtiovRb0nFDzIGVMwP5yQwBz7dTOf0LRUgi/vOJ0pqfDdazpdcYQ==
X-Received: by 2002:a17:907:9864:b0:945:2f54:5eae with SMTP id ko4-20020a170907986400b009452f545eaemr920433ejc.77.1680833980808;
        Thu, 06 Apr 2023 19:19:40 -0700 (PDT)
Received: from [10.6.18.184] ([45.88.97.12])
        by smtp.gmail.com with ESMTPSA id gt19-20020a170906f21300b00905a1abecbfsm1501044ejb.47.2023.04.06.19.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 19:19:40 -0700 (PDT)
Message-ID: <4ef5464b-31dd-3c3e-05be-9891162e4f05@gmail.com>
Date:   Fri, 7 Apr 2023 04:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 6/6] t2019: don't create unused files
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-7-rybak.a.v@gmail.com>
 <230406.86h6tttn21.gmgdl@evledraar.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <230406.86h6tttn21.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Disclaimer: while trying to write a response to this email, I went a bit
off track, and a big portion of message below is an investigation of
test coverage of what is printed to standard output and standard error
by "git checkout".  It's still mostly relevant to the discussion about
t2019, or at least I hope so.

There are four parts to this investigation, starting with:


1. Standard output of "git checkout"
Other than "git checkout -p" (tested in t3701-add-interactive.sh), it
seems that the only thing that "git checkout" prints to standard output
is in:

   a) function "show_local_changes" in builtin/checkout.c -- a couple
      of tests in t7201-co.sh validate this
   b) function "report_tracking" in builtin/checkout.c -- there are
      tests that validate tracking information in output of "git
      checkout" in t6040-tracking-info.sh.  One test in
      t2020-checkout-detach.sh, titled 'tracking count is accurate after
      orphan check' validates it as well.

While trying to find all tests that validate standard output of
"git checkout", I found out a couple of things.


2. Standard error of "git checkout"
Honestly, I haven't noticed it before, but I found it surprising that
messages about branch switching:

    - "Switched to branch '%s'\n"
    - "Switched to a new branch '%s'\n"
    - "Switched to and reset branch '%s'\n"

are printed to standard error.

Several tests in t2020-checkout-detach.sh validate what is printed into
standard error by "git checkout" via a variation of ">actual 2>&1".
Tests for advice printed by "git checkout" (looking at "advice.c", it
all goes to stderr), also do a variation of ">actual 2>&1".


3. t2024-checkout-dwim.sh
Test 'loosely defined local base branch is reported correctly' in t2024
has an interesting validation of output of "git checkout":

	git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
	status_uno_is_clean &&
	git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
	status_uno_is_clean &&

	test_cmp expect actual

which is fine, except that neither file "expect" nor "actual" contain
the string "BRANCHNAME".  And this test was broken when it was
introduced in 05e73682cd (checkout: report upstream correctly even with
loosely defined branch.*.merge, 2014-10-14).  It was probably intended
for this test to redirect standard error of "git checkout".  It should
be cleaned up as a separate patch/topic.

On 06/04/2023 10:44, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 04 2023, Andrei Rybak wrote:
> 
>> Tests in t2019-checkout-ambiguous-ref.sh redirect two invocations of
>> "git checkout" to files "stdout" and "stderr".  Several assertions are
>> made using file "stderr".  File "stdout", however, is unused.
>>
>> Don't redirect standard output of "git checkout" to file "stdout" in
>> t2019-checkout-ambiguous-ref.sh to avoid creating unnecessary files.
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
>> ---
>>   t/t2019-checkout-ambiguous-ref.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
>> index 2c8c926b4d..9540588664 100755
>> --- a/t/t2019-checkout-ambiguous-ref.sh
>> +++ b/t/t2019-checkout-ambiguous-ref.sh
>> @@ -16,7 +16,7 @@ test_expect_success 'setup ambiguous refs' '
>>   '
>>   
>>   test_expect_success 'checkout ambiguous ref succeeds' '
>> -	git checkout ambiguity >stdout 2>stderr
>> +	git checkout ambiguity 2>stderr
>>   '
> 
> Ditto earlier comments that we should just fix this, if I make this
> ">out" and "test_must_be_empty out" this succeeds, shouldn't we just use
> that?

4. t2019-checkout-ambiguous-ref.sh
Back on topic: is empty standard output something that this test in
t2019 should worry about?  Let's take a look at other tests.

Aside from what was mentioned in section 1, tests in t7201 don't look
at standard output of "git checkout".  There isn't a lot of
"test_must_be_empty" in t/t2*check*:

     $ git grep 'test_must_be_empty' t/t2*check*
     t/t2004-checkout-cache-temp.sh: test_must_be_empty stderr &&
     t/t2013-checkout-submodule.sh:  test_must_be_empty actual
     t/t2013-checkout-submodule.sh:  test_must_be_empty actual
     t/t2013-checkout-submodule.sh:  test_must_be_empty actual
     t/t2024-checkout-dwim.sh:       test_must_be_empty status.actual

The first one, in t2004, asserts output of "git checkout-index".
All three in t2013 assert output of "git checkout HEAD >actual 2>&1".
The last one, in t2024, asserts output of "git status".

(There's also one "test_line_count = 0" in the same test in t2004,
  but otherwise these tests seem to be pretty up-to-date w.r.t.
  to using test_must_be_empty helper)

> 
>>   test_expect_success 'checkout produces ambiguity warning' '
> 
> As an aside, we should really just combine these two tests.

My dumb script for finding unused files gives false-positives for such
tests.  And there a lot of tests that got split during introduction of
C_LOCALE_OUTPUT prerequisite or were introduced before C_LOCALE_OUTPUT
was phased out.

For t2019, however, the tests were created this way before
C_LOCALE_OUTPUT in 0cb6ad3c3d ("checkout: fix bug with ambiguous refs",
2011-01-11).  Then the prerequisite was added in 6b3d83efac
("t2019-checkout-ambiguous-ref.sh: depend on C_LOCALE_OUTPUT",
2011-04-03) and removed in d3bd0425b2 ("i18n: use test_i18ngrep in
lib-httpd and t2019", 2011-04-12).

> 
>> @@ -37,7 +37,7 @@ test_expect_success 'checkout reports switch to branch' '
>>   '
>>   
>>   test_expect_success 'checkout vague ref succeeds' '
>> -	git checkout vagueness >stdout 2>stderr &&
>> +	git checkout vagueness 2>stderr &&
>>   	test_set_prereq VAGUENESS_SUCCESS
>>   '
> 

