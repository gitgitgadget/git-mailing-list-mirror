Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0755EC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 23:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiB1XuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiB1XuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 18:50:02 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95184119863
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:49:22 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x5so19776292edd.11
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jbdC1cOjIV1PITsyGeIwTrcs4eV38RWEyJphfmAqp64=;
        b=aeN6vZMGK/spVdIZHCJvTxzkVMXHWVY7UOMuxhZ59ofv1xQ92JGon4Tu4ByUUV8VCA
         a4jDM2NqHDkIznFwqOw8/611dgPHJ9GDvTR9EXTfkao2YyWGXFNbUmIBoJVfe4qteVvt
         jpIMkmdy0A8g0DV79DirKkFg3evkyhE8mrxXMFQ6QSsJ47p5u8/8FBoIBW2c9gbzzYUG
         LbQLHh5EV50vIXjyrv0IeRT8cVB1EE3bulxUpL3Amha67PcOGe/zBZSxZvwIHYXIbLme
         +cAlPDVnZ/yypjogx3lLS1OFpaFrMf8L0Qp6gdlckn+cshePmfRfPVm97NXaAN3lIAdI
         dRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jbdC1cOjIV1PITsyGeIwTrcs4eV38RWEyJphfmAqp64=;
        b=RuNU2euWnImy29KyPfkIUAF1hGhiRcujUoCX7yHaJgylW1bpFyM8VssiQR7sj1taq9
         ezyPStdyovtxQekHm/fwX1V4exVtztrdtY5fpJvNLO7g6/QrZczPjgIcOqurXSK8czgs
         S/4Lm1SS/Vjh6KXYQHlt/C1W3NUp2nVSUuuwVjtszz90tALTUHouFL6lSbeAuWoKgIPt
         qpIZUFm1Rs+P7uOpFySzMejLGXcAhqIX1u27RxCib7WxnIBIjF6y2/xgLoGZMDKGlFB3
         ZcwlJ4EoOPuVeyRbSCN4KeTqIc0NLLlT7KFhwbjoBXX1iuAksbQItMeSUVpmKquO0xAE
         3AMQ==
X-Gm-Message-State: AOAM533+jOie93kguDMRig6cmnTFftXwqUIHMaS/nHKu+iM0lIXr/hyZ
        Nr6fs7DOuu7mY+sggCFxkdVDgy1cxUE=
X-Google-Smtp-Source: ABdhPJyvSS2xj+hCm0BTl5Hf4SU8bWLy5Znj2gw44CfWOlO198DrlOdUOfCtdJ2cNh0lkrBJaeYiTw==
X-Received: by 2002:aa7:db47:0:b0:413:7649:c2bb with SMTP id n7-20020aa7db47000000b004137649c2bbmr17281603edt.123.1646092160762;
        Mon, 28 Feb 2022 15:49:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id iy8-20020a170907818800b006d1c553ed1esm4757111ejc.102.2022.02.28.15.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:49:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOplX-001fet-GP;
        Tue, 01 Mar 2022 00:49:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/7] read-tree: expand sparse checkout test coverage
Date:   Tue, 01 Mar 2022 00:46:40 +0100
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
 <220301.861qzm37qt.gmgdl@evledraar.gmail.com>
 <509e860c-5bda-b92f-96c5-39f9a54f1e9b@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <509e860c-5bda-b92f-96c5-39f9a54f1e9b@github.com>
Message-ID: <220301.86sfs21ri8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Feb 24 2022, Victoria Dye via GitGitGadget wrote:
>>=20
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> Add tests focused on how 'git read-tree' behaves in sparse checkouts. E=
xtra
>>> emphasis is placed on interactions with files outside the sparse cone, =
e.g.
>>> merges with out-of-cone conflicts.
>>>
>>> Signed-off-by: Victoria Dye <vdye@github.com>
>>> ---
>>>  t/perf/p2000-sparse-operations.sh        |  1 +
>>>  t/t1092-sparse-checkout-compatibility.sh | 85 ++++++++++++++++++++++++
>>>  2 files changed, 86 insertions(+)
>>>
>>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-op=
erations.sh
>>> index 2a7106b9495..382716cfca9 100755
>>> --- a/t/perf/p2000-sparse-operations.sh
>>> +++ b/t/perf/p2000-sparse-operations.sh
>>> @@ -117,6 +117,7 @@ test_perf_on_all git diff
>>>  test_perf_on_all git diff --cached
>>>  test_perf_on_all git blame $SPARSE_CONE/a
>>>  test_perf_on_all git blame $SPARSE_CONE/f3/a
>>> +test_perf_on_all git read-tree -mu HEAD
>>>  test_perf_on_all git checkout-index -f --all
>>>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>>>=20=20
>>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-=
checkout-compatibility.sh
>>> index b1dcaa0e642..9d58da4e925 100755
>>> --- a/t/t1092-sparse-checkout-compatibility.sh
>>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>>> @@ -819,6 +819,91 @@ test_expect_success 'update-index --cacheinfo' '
>>>  	test_cmp expect sparse-checkout-out
>>>  '
>>>=20=20
>>> +test_expect_success 'read-tree --merge with files outside sparse defin=
ition' '
>>> +	init_repos &&
>>> +
>>> +	test_all_match git checkout -b test-branch update-folder1 &&
>>> +	for MERGE_TREES in "base HEAD update-folder2" \
>>> +			   "update-folder1 update-folder2" \
>>> +			   "update-folder2"
>>> +	do
>>> +		# Clean up and remove on-disk files
>>> +		test_all_match git reset --hard HEAD &&
>>> +		test_sparse_match git sparse-checkout reapply &&
>>> +
>>> +		# Although the index matches, without --no-sparse-checkout, outside-=
of-
>>> +		# definition files will not exist on disk for sparse checkouts
>>> +		test_all_match git read-tree -mu $MERGE_TREES &&
>>> +		test_all_match git status --porcelain=3Dv2 &&
>>> +		test_path_is_missing sparse-checkout/folder2 &&
>>> +		test_path_is_missing sparse-index/folder2 &&
>>> +
>>> +		test_all_match git read-tree --reset -u HEAD &&
>>> +		test_all_match git status --porcelain=3Dv2 &&
>>> +
>>> +		test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
>>> +		test_all_match git status --porcelain=3Dv2 &&
>>> +		test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
>>> +		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return=
 1
>>> +	done
>>> +'
>>=20
>> Nit: Isn't this nicer/easier by unrolling the for-loop to the top-level,=
 i.e.:
>>=20
>> for MERGE_TREES in "base HEAD update-folder2" [...]
>> do
>> 	test_expect_success "'read-tree -mu $MERGE_TREES' with files outside sp=
arse definition" '
>> 		init_repos &&
>> 		test_when_finished "test_all_match git reset --hard HEAD" &&
>>                 ...
>> 	'
>> done
>>=20
>> It makes failures easier to reason about since you see which for-loop
>> iteration you're in right away, and can e.g. pick one with --run.
>>=20
>
> I like how this separates the test cases (while not adding any
> redundant/copied code). I'll update in the next version, thanks!
>
>> And we can do the cleanup in test_when_finished instead of at the start
>> of every loop.

Sounds good!

Note for <reasons> we eval the body of the test into existence, but
*not* the description. So:

    for x in [...] test_expect_success "$x" '$x'

Works to expand "$x" in both cases, but not:

    for x in [...] test_expect_success '$x' '$x'

And you don't need to do:

    for x in [...] test_expect_success "$x" "$x"

Which is handy as double-quoting the body is often a hassle with
escaping stuff.

I only think I got that wrong the first 1, 2, 3.... etc. times I used
this pattern, so I thought I'd mention it :)

> Because `init_repos` completely resets the test repos, this actually lets=
 me
> remove the extra cleanup steps completely.

\o/
