Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4339C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiBXSVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiBXSVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 13:21:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B43F2556EE
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:21:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cm8so4087718edb.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8aLeqEREQYEnctRFn06j6VhR/1cAyxaIRIwQIl6y0o=;
        b=eRtEgZ7oYRhnK5hVg6rkBklZkJqp0wVP41zXu0cwTKrf0zNgEU+aUXGWtQXQqz+Y4l
         HVt1X82p81A5jgvDLEvyjc+EjZ3XZwvCycjmca6RLjYqJD49Qv6Y1HRJMduaM3/vQoXr
         cRhBwyUh09Ge66pxXgdFjOA74qlCNkE9VrznIqNNyIp3XUCmqGmsIMwNmbhocKxxGQ5r
         6mdj5PvCwT+hPoL0Ho/AF3Caog5P8AWrHSbYgLDb3+aQOi5pBHX+TcrCUlZkrVioX/gX
         wEzmaNAAMC2OQfhk8CH0LJGiCZl/EGrruCKMePA90X3wPj5trTGXn26Eb/VX18X9qQRs
         f0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8aLeqEREQYEnctRFn06j6VhR/1cAyxaIRIwQIl6y0o=;
        b=Bp3lDpEvPiVt+ZDXZi9wp5vFVitFJaV2FU5nlwoXXZyYIZFatLck5uAeiA7xb4dp8f
         9NtNL49UiSXHwsYXT5NQ748Y5ftkoLNuDuBnnzOMzPM8t7F60G4ZMHJssz354Ql6NKCB
         bAiExtaz4uR3e3eKc2Tkv9ncZGWrS4VKUPf9Mo4yOEZb5Os7ZO0NdwtJhuohY8qBP2Aa
         NC5qdPNG+GoZxX8lICgbK5FLqwRdQsDrz8plkGZXFyiItuqnXKsN+Nfy2wO09aNIh3aK
         +fLfgV5xbqa8pOlSF8nPuU3yI9eHTUjo2QAxLZ4Etq2wXdhHkDY4B1ZtFjjpggI53J8d
         rOcQ==
X-Gm-Message-State: AOAM532XxaQzFpZg8Ctv5UBrbHd1CC3rLMgAQSRiPl4v2v7IRiLoAdVd
        docHTJNyz0DCkn3i7j8TzjNA9mE7FYg=
X-Google-Smtp-Source: ABdhPJyMsQu0zf5weEJgTq0HOofOp4XqTtNatBLhuxYWj4nJO/1fWRDYSl8CJbBNzvXzkShG5dR5GA==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr3574553eda.362.1645726864825;
        Thu, 24 Feb 2022 10:21:04 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id q1-20020a50c341000000b00412ea00941dsm127366edb.18.2022.02.24.10.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Feb 2022 10:21:04 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite --updatref behavior
Date:   Thu, 24 Feb 2022 13:21:02 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <865928A5-3F54-4B51-B502-07E24D98CEDB@gmail.com>
In-Reply-To: <220223.86ley1b653.gmgdl@evledraar.gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
 <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> <xmqq4k4ptgsv.fsf@gitster.g>
 <220223.86ley1b653.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On 23 Feb 2022, at 16:50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Feb 23 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> This test was already a bit broken in needing the preceding tests, bu=
t
>>> it will break now if REFFILES isn't true, which you can reproduce
>>> e.g. with:
>>>
>>>     ./t3903-stash.sh --run=3D1-16,18-50 -vixd
>>>
>>> Perhaps the least sucky solution to that is:
>>>
>>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>>> index ec9cc5646d6..1d11c9bda20 100755
>>> --- a/t/t3903-stash.sh
>>> +++ b/t/t3903-stash.sh
>>> @@ -205,13 +205,19 @@ test_expect_success 'drop stash reflog updates =
refs/stash with rewrite' '
>>>  	cat >expect <<-EOF &&
>>>  	$(test_oid zero) $oid
>>>  	EOF
>>> -	test_cmp expect actual
>>> +	test_cmp expect actual &&
>>> +	>dropped-stash
>>>  '
>>
>> If "git stash drop", invoked in earlier part of this test before the
>> precontext, fails, then test_cmp would fail and we leave
>> dropped-stash untouched, even though we did run "git stash drop"
>> already.
>
> Yes, that's an edge case that's exposed here, but which I thought wasn'=
t
> worth bothering with. I.e. if you get such a failure on test N getting
> N+1 failing as well isn't that big of a deal.
>
> The big deal is rather that we know we're adding a REFFILES dependency
> to this, which won't run this at all, which will make the "stash pop"
> below fail.
>
>> Why does the next test need to depend on what has happened earlier?
>
> They don't need to, and ideally wouldn't, but most of our test suite ha=
s
> this issue already. Try e.g. running it with:
>
>     prove t[0-9]*.sh :: --run=3D10-20 --immediate
>
> And for this particular file running e.g. this on master:
>
>     ./t3903-stash.sh --run=3D1-10,30-40
>
> Will fail 7 tests in the 30-40 range.
>
> So while it's ideal that we can combine tests with arbitrary --run
> parameters, i.e. all tests would tear down fully, not depend on earlier=

> tests etc. we're really far from that being the case in practice.
>
> So insisting on some general refactoring of this file as part of this
> series seems a bit overzelous, which is why I'm suggesting the bare
> minimum to expect and work around the inevitable REFFILES failure, as
> Han-Wen is actively working in that area.

Curious what your thoughts are on an effort to isolate these tests from e=
ach other.
I like your approach in t/t1417 in creating a test repo and copying it ov=
er each time.
Something like this?

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ac345eced8cb..40254f8dc99c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -41,7 +41,9 @@ diff_cmp () {
        rm -f "$1.compare" "$2.compare"
 }

-test_expect_success 'stash some dirty working directory' '
+test_expect_success 'setup' '
+       git init repo &&
+       cd repo &&
        echo 1 >file &&
        git add file &&
        echo unrelated >other-file &&
@@ -54,48 +56,54 @@ test_expect_success 'stash some dirty working directo=
ry' '
        test_tick &&
        git stash &&
        git diff-files --quiet &&
-       git diff-index --cached --quiet HEAD
+       git diff-index --cached --quiet HEAD &&
+       cat >expect <<-EOF &&
+       diff --git a/file b/file
+       index 0cfbf08..00750ed 100644
+       --- a/file
+       +++ b/file
+       @@ -1 +1 @@
+       -2
+       +3
+       EOF
+       cd ../
 '

-cat >expect <<EOF
-diff --git a/file b/file
-index 0cfbf08..00750ed 100644
---- a/file
-+++ b/file
-@@ -1 +1 @@
--2
-+3
-EOF
+test_stash () {
+       cp -R repo copy &&
+       cd copy &&
+       test_expect_success "$@" &&
+       cd ../ &&
+       rm -rf copy
+}

-test_expect_success 'parents of stash' '
+test_stash 'parents of stash' '
        test $(git rev-parse stash^) =3D $(git rev-parse HEAD) &&
        git diff stash^2..stash >output &&
        diff_cmp expect output
 '

Not sure if it's worth it though?


>
>>>  test_expect_success 'stash pop' '
>>>  	git reset --hard &&
>>>  	git stash pop &&
>>> -	test 9 =3D $(cat file) &&
>>> +	if test -e dropped-stash
>>> +	then
>>> +		test 9 =3D $(cat file)
>>> +	else
>>> +		test 3 =3D $(cat file)
>>> +	fi &&
>>>  	test 1 =3D $(git show :file) &&
>>>  	test 1 =3D $(git show HEAD:file) &&
>>>  	test 0 =3D $(git stash list | wc -l)
