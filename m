Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74547C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKNTuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbiKNTtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 14:49:46 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3451658F
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 11:49:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ci1-20020a17090afc8100b00212e5b4c3afso5224401pjb.3
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 11:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONRYNl2L83lREZjk+XJgHyz5duuG6YECZQsYdPf/dCE=;
        b=UH7j90YO44R49GXfQ/1+UMg4yaWnSgR4j+frRmb4bj2MgjEJk0iwPCOTEOCHmrBlet
         oYdT4liPGUhjDfVouuVytNq/l1QTFlatPv4dD4QdeuEh/y6RGt3/045BhJ3w4QEovAjD
         WubC7dPCM645sZpt2cFvmlj7cheP3jFFqLUoUjVysx+Q2KqVYXWei03Ri8eX9GlxgPeS
         MLynOPY5L4IzaYnFogsGXgpFraPMi4Imo6fBeGPVZWk0mEaGg7DoymFT6RHPnOXE28Ch
         Bi2VfG5HjG8Odx8vnmsCp72+PyPvjYu35zXjabAiOepXg8VXuX9sQ36jIHjoFtsgRU5D
         EepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ONRYNl2L83lREZjk+XJgHyz5duuG6YECZQsYdPf/dCE=;
        b=spDeETz7/DNbc2z5R07ibXr+agzYqSZpNkO8QLb63ZiV8WH5h+laxZN29bNor90ZL3
         ER4/H/iefHP2l15rEjPomuQwaMguyqJ5DrdfhE9wNwh2NmTsIfM7ONVWpbtcCbj4fkxf
         Sxzqya0z57vhvtL1M+eaJLyczFCVwZZyTEQPFg48A6HGs9GfDCVOU/WH9uLO1NdWioRv
         sI8kMiagY86sFwjyf1eZhSBCBto5PAbP+Wvhw/XO9g75khk0xliXM134XCOm0FUG2mMS
         kq+J8tQdD+dLsVuJlG+3kmG4KaJAAXHn5pYRivci12E4GV6c03pj+WYlgY6hGj7zCTck
         BbZA==
X-Gm-Message-State: ANoB5pns2YmlRw6YVeph60hhmYJpURUhif6xwU6ckKbSaSl7Xw458b+f
        b+DWlNhgJ1yeXSuCPbKughJAMand1DuNVA==
X-Google-Smtp-Source: AA0mqf7C0NE8hUSHw8WMfQD5OGASXtLHBuGATCmGeoEt5AaT8pc1tvblehQB1QgtU0+tlljKHmBj6WnXIi3P6w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:d01:b0:20a:fee1:8f69 with SMTP id
 t1-20020a17090a0d0100b0020afee18f69mr19936pja.0.1668455375666; Mon, 14 Nov
 2022 11:49:35 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:49:34 -0800
In-Reply-To: <221114.86cz9pl4vn.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <patch-v2-01.10-1114a4ff666-20221114T100803Z-avarab@gmail.com>
 <kl6lo7t91hvd.fsf@chooglen-macbookpro.roam.corp.google.com> <221114.86cz9pl4vn.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lk03x1fld.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 01/10] read-tree + fetch tests: test failing
 "--super-prefix" interaction
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Nov 14 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> From: Glen Choo <chooglen@google.com>
>>>
>>> Ever since "git fetch --refetch" was introduced in 0f5e8851737 (Merge
>>> branch 'rc/fetch-refetch', 2022-04-04) the test being added here would
>>> fail. This is because "restore" will "read-tree .. --reset <hash>",
>>> which will in turn invoke "fetch". The "fetch" will then die with:
>>>
>>> 	fatal: fetch doesn't support --super-prefix
>>>
>>> This edge case and other "--super-prefix" bugs will be fixed in
>>> subsequent commits, but let's first add a "test_expect_failure" test
>>> for it. It passes until the very last command in the test.
>>>
>>> Signed-off-by: Glen Choo <chooglen@google.com>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>>> ---
>>>  t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 43 insertions(+)
>>>
>>> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
>>> index 037941b95d2..e56466580cf 100755
>>> --- a/t/t5616-partial-clone.sh
>>> +++ b/t/t5616-partial-clone.sh
>>> @@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promis=
or objects' '
>>>  	grep "loosen_unused_packed_objects/loosened:0" trace
>>>  '
>>> =20
>>> +test_expect_failure 'lazy-fetch in submodule succeeds' '
>>> +	# setup
>>> +	test_config_global protocol.file.allow always &&
>>> +
>>> +	git init src-sub &&
>>> +	git -C src-sub config uploadpack.allowfilter 1 &&
>>> +	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
>>> +
>>> +	# This blob must be missing in the subsequent commit.
>>> +	echo foo >src-sub/file &&
>>> +	git -C src-sub add file &&
>>> +	git -C src-sub commit -m "submodule one" &&
>>> +	SUB_ONE=3D$(git -C src-sub rev-parse HEAD) &&
>>> +
>>> +	echo bar >src-sub/file &&
>>> +	git -C src-sub add file &&
>>> +	git -C src-sub commit -m "submodule two" &&
>>> +	SUB_TWO=3D$(git -C src-sub rev-parse HEAD) &&
>>> +
>>> +	git init src-super &&
>>> +	git -C src-super config uploadpack.allowfilter 1 &&
>>> +	git -C src-super config uploadpack.allowanysha1inwant 1 &&
>>> +	git -C src-super submodule add ../src-sub src-sub &&
>>> +
>>> +	git -C src-super/src-sub checkout $SUB_ONE &&
>>> +	git -C src-super add src-sub &&
>>> +	git -C src-super commit -m "superproject one" &&
>>> +
>>> +	git -C src-super/src-sub checkout $SUB_TWO &&
>>> +	git -C src-super add src-sub &&
>>> +	git -C src-super commit -m "superproject two" &&
>>> +
>>> +	# the fetch
>>> +	test_when_finished "rm -rf src-super src-sub client" &&
>>
>> (Genuinely curious) are we okay with test_when_finished in the middle of
>> the test body instead of at the top?
>
> Yeah, and it's not just supported, but preferred, usually we do:
>
> 	test_when_finished "rm -rf repo" &&
> 	git init repo &&
>
> So at the top makes sense, but if there's a bunch of stuff we might fail
> on first it makes sense not to attempt the cleanup.
>
> But I see in this case the "src-super" part of it should be earlier, and
> "src-sub", but the "client" should be just before the clone below, don't
> know how I missed that. Will fix.

Ah, I see. Yeah that makes sense.

>
>>> +
>>> +	test_config_global protocol.file.allow always &&
>>
>> We have this exact same test_config_global line at the top of this test,
>> so we can drop this one.
>
> Ditto, thanks, I'll fix that. A mistake when combining the tests.
>
> You had these as two tests, but one was mandatory setup for the other,
> and when making it test_expect_failure I wanted to have it atomic..

Makes sense too. I initially had them separate for readability purposes,
but the inline comments work too.
