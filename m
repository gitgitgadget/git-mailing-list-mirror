Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F0C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 21:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLOVF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOVFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 16:05:54 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7D30545
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 13:05:52 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n5-20020a170902d2c500b00189e5b86fe2so151725plc.16
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 13:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bvzGDLFO8rxj2H6HKYbIy/0PWxTnAhNRmY+pgHRO5E=;
        b=U40GHdYEQPSOT22N/uF1aMfd3SLPJIznuv6mqpBt2UJxBBPgu6U/6Kvra7RHT8FHc6
         +iQq0GmnVd4KVQRcKIckg9vK6CsQzXX9EbyCmMdHjfO0Ao1e2lKf3r4rGd/tJESTd+aM
         b6h3WHBlMwM9LKgysL/Tg5uPwdUgaLJI2wp+Pm1KinjNDs2O2Qq+isuC8yaGjc0HxjrC
         DOAQ+R0Fynxt8kGxuDuyy/uZmHee1GsWi+0mlWtQer3ptv6YHC1NWM1HHC9iAhmTcETs
         uxHoDsjmXgQdAUWf3v4nSrth1LL3P0/FfujdaJ1hlkZS7sOqA+hs+pFeDUUybCvchNXZ
         ipDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+bvzGDLFO8rxj2H6HKYbIy/0PWxTnAhNRmY+pgHRO5E=;
        b=DIWkHX4mlnl2kZKhucFlE8/qzfVtdjkOgpJ5UdyErtQF8dOKOtVPrhIJYM4jNqfXPL
         Jf5KtXw2e1ygTyWHurbGwrZNADMLDVmxrG9Q0n0WFJYAEbNPZEJTamK+SDNhwGXYhlY6
         H6UzAyDpuCMV4GXRBNIx0Huh42odSNCsLTBJKQ7Z8r679vl26gbMu5CPk6WFuzQC2jo4
         UNYHN/nXao4OBXlJhuIP8qBCf/K3vI3vVev7iO9j600PuhGwkZz9NifOLqTj/R6jhqKQ
         AlWkWDwuIjKx6iEbrKLnaKlbwYwDsn3dbJgR/lUSS6bmtRQ5U8Oac7r03nxqwFhVxxAn
         9vYg==
X-Gm-Message-State: ANoB5pl8RIIxQRFpN7pJ6k0e/MdZw4BdBLajeOGt6o2CFnx87ZMCCx3u
        p+MfLd34N8VQIdZD0UyDldjMIXFgj7K3kQ==
X-Google-Smtp-Source: AA0mqf6IcXER3ml96uxml594JfQeAJfE3Um7kBH7Ue9K4lqa9Z/LnUy0uyk8gRJZklJLHJYQEWWdTUvt7ib9Xg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:140c:b0:56b:b520:3751 with SMTP
 id l12-20020a056a00140c00b0056bb5203751mr80731645pfu.29.1671138351853; Thu,
 15 Dec 2022 13:05:51 -0800 (PST)
Date:   Thu, 15 Dec 2022 13:05:50 -0800
In-Reply-To: <patch-v4-4.9-bde9038c4e3-20221215T083502Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <patch-v4-4.9-bde9038c4e3-20221215T083502Z-avarab@gmail.com>
Message-ID: <kl6l359ge5sh.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 4/9] submodule--helper: don't use global --super-prefix
 in "absorbgitdirs"
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

>                            Let's instead assert the full output that
> we *do* have, which we can do here as this is based on a change[4] to
> make it predictable (until [4] it contained absolute paths).
> ...
> 4. https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-ava=
rab@gmail.com/

This sentence is stale now, since the test uses absolute paths.

> @@ -904,10 +886,20 @@ test_expect_success "stray submodule super-prefix w=
arning" '
> =20
>  	test_path_is_dir super/dir_1/dir_2/sub/.git &&
> =20
> +	cwd=3D"$(cd super && pwd)" &&
> +	cat >expect <<-EOF &&
> +	Migrating git directory of '\''dir_1/dir_2/sub'\'' from
> +	'\''$cwd/dir_1/dir_2/sub/.git'\'' to
> +	'\''$cwd/.git/modules/dir_1/dir_2/sub'\''
> +	EOF

Namely, this test uses absolute paths.

>  	GIT_TRACE2_EVENT=3D"$PWD/super-sub.trace" \
> -		git -C super submodule absorbgitdirs &&
> +		git -C super submodule absorbgitdirs >out 2>actual &&
> +	test_cmp expect actual &&
> +	test_must_be_empty out &&
> =20
> -	! have_t2_error_event super-sub.trace
> +	# Confirm that the trace2 log contains a record of the
> +	# daemon starting.
> +	test_subcommand git fsmonitor--daemon start <super-sub.trace
>  '
> =20
>  # On a case-insensitive file system, confirm that the daemon
> --=20
> 2.39.0.rc2.1048.g0e5493b8d5b
