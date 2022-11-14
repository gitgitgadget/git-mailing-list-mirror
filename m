Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B9CC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 19:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiKNTA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiKNTA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 14:00:26 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C72122
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 11:00:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q63-20020a632a42000000b0045724b1dfb9so6192598pgq.3
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWvVL4+suu2YOI1NGQJRrIdskC47zgYVNhi5NR0GmS0=;
        b=leJ0ux/92QZ/+/z591PtgA9FkIcoEGokXSrHsD24KzaIQV8p/qNGAKHTb4a01qfRhq
         8nGUt4XtlB24ZaN9CqdQCb2PwqwkvvA3L6zTe1v7LVI4Fi1jgqI52MsmgbnDmhhQTyw2
         SDbe+Mtpx9QulKNrF3+pCXCxbp7h91uLdnyUcY+PwyrjpolyNVu/nO5HrEd/6iKm/SeE
         +yZsowTjzlhVzJw3kLZ2xfitcErb3ln67vgR9sl1jjrGTxw4GULv7DnXcQ3LW/vIA3BY
         iFmDHMdejILIGUU2npRg7KViYhRT+xmj34FO6UxH3L86+1rf068ITKkpcBW6l7eYuvHh
         UWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWvVL4+suu2YOI1NGQJRrIdskC47zgYVNhi5NR0GmS0=;
        b=osdLYb5CZ4JhCnALGQLStQE9PmVAitciGrtTNOe5+0BEvD6cz7XVwNC3rgEHFUZRFU
         L2mHbuBj26X53J3HQIaEw/k//PtjxGiZK7pZN/MqlonwILHkBmm0atec0DEMBjVcdGmK
         09Sm77IXsbW8I+B8uxpOhP6Yp1j2IrFNWrDbTVshrNcctDBBFaZ87rMwmxT/eGw75WM6
         gOvg6bsrLCHAGrRomVT9/QzGPy0V79ms5iu1WYrxO8EmF8XoFdYcmYNg1OkpM2RsIz22
         UhtZoPoZEGOzpOhZSCNy3qqt+yECwHepa4lTC+8P/KN17kb2Z00cbJFjFarW4HsyVISn
         ptgQ==
X-Gm-Message-State: ANoB5pn2qc+Ai6RSkL2whX15SbKvVZ2PT9TuzIw5vv77ApDfQnuwSlkB
        pJ31ZxxqKcMRaFgRntaXVr3OTi/TJyzNiQ==
X-Google-Smtp-Source: AA0mqf481qDth5svIJosK8lL5Olzj0f4y7qZKI/owAY9X12A+05SejacIFtig078bkMP+sWDPM/wOElIauPa0Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:aa8f:b0:17f:700a:2cd3 with SMTP
 id d15-20020a170902aa8f00b0017f700a2cd3mr660015plr.36.1668452424283; Mon, 14
 Nov 2022 11:00:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:00:22 -0800
In-Reply-To: <patch-v2-01.10-1114a4ff666-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <patch-v2-01.10-1114a4ff666-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6lo7t91hvd.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 01/10] read-tree + fetch tests: test failing
 "--super-prefix" interaction
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Ever since "git fetch --refetch" was introduced in 0f5e8851737 (Merge
> branch 'rc/fetch-refetch', 2022-04-04) the test being added here would
> fail. This is because "restore" will "read-tree .. --reset <hash>",
> which will in turn invoke "fetch". The "fetch" will then die with:
>
> 	fatal: fetch doesn't support --super-prefix
>
> This edge case and other "--super-prefix" bugs will be fixed in
> subsequent commits, but let's first add a "test_expect_failure" test
> for it. It passes until the very last command in the test.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 037941b95d2..e56466580cf 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor=
 objects' '
>  	grep "loosen_unused_packed_objects/loosened:0" trace
>  '
> =20
> +test_expect_failure 'lazy-fetch in submodule succeeds' '
> +	# setup
> +	test_config_global protocol.file.allow always &&
> +
> +	git init src-sub &&
> +	git -C src-sub config uploadpack.allowfilter 1 &&
> +	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
> +
> +	# This blob must be missing in the subsequent commit.
> +	echo foo >src-sub/file &&
> +	git -C src-sub add file &&
> +	git -C src-sub commit -m "submodule one" &&
> +	SUB_ONE=3D$(git -C src-sub rev-parse HEAD) &&
> +
> +	echo bar >src-sub/file &&
> +	git -C src-sub add file &&
> +	git -C src-sub commit -m "submodule two" &&
> +	SUB_TWO=3D$(git -C src-sub rev-parse HEAD) &&
> +
> +	git init src-super &&
> +	git -C src-super config uploadpack.allowfilter 1 &&
> +	git -C src-super config uploadpack.allowanysha1inwant 1 &&
> +	git -C src-super submodule add ../src-sub src-sub &&
> +
> +	git -C src-super/src-sub checkout $SUB_ONE &&
> +	git -C src-super add src-sub &&
> +	git -C src-super commit -m "superproject one" &&
> +
> +	git -C src-super/src-sub checkout $SUB_TWO &&
> +	git -C src-super add src-sub &&
> +	git -C src-super commit -m "superproject two" &&
> +
> +	# the fetch
> +	test_when_finished "rm -rf src-super src-sub client" &&

(Genuinely curious) are we okay with test_when_finished in the middle of
the test body instead of at the top?

> +
> +	test_config_global protocol.file.allow always &&

We have this exact same test_config_global line at the top of this test,
so we can drop this one.

> +	git clone --filter=3Dblob:none --also-filter-submodules \
> +		--recurse-submodules "file://$(pwd)/src-super" client &&
> +
> +	# Trigger lazy-fetch from the superproject
> +	git -C client restore --recurse-submodules --source=3DHEAD^ :/
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
> =20
> --=20
> 2.38.0.1471.ge4d8947e7aa
