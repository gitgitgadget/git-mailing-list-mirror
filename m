Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88828C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 05:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLCFsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 00:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLCFsH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 00:48:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F313D7A
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 21:48:04 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n3so2513136pfq.10
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 21:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHTG8rtXBO74H3Uv7wCnf4WKyOjfvqYrvOorYUu/L6Q=;
        b=mYb1CCUYToZn89narNZamlIOxSZTJxWfo419lP52TR5LZP8tjIY8Zhx9+2N2I4Casr
         +1VpJlA9vc8Up8xHnFmtalKhbQYnprYUGsMeHI8Z0h5nn+reUFSDgEuRgd04aQbLKayt
         OakFYmJUCOsPTzRDFTBM2kCjQFmiu2ICm9l+vVXqTigvakC8VzdbeJbTdHQgj5KXyy2o
         m17O8FWReTek4FALqSm4q+pZsCZd0UtrdkKXXUpUcZj8fLez3d/pMzUt7WlMyzTrXmFV
         Fjle0QVl1qshNSHp/5higVJhhghAfR4d9em09Xe7zSuDc23SICFjuTVs+4ntipK+6C6y
         0ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHTG8rtXBO74H3Uv7wCnf4WKyOjfvqYrvOorYUu/L6Q=;
        b=zdnJJowcjG4WLmefIiXdF7hzaIWyBhYmnHoOfNLAgOlDZcF5Uo1RrV1h4vH61vLFoM
         n0hIASF5Dz5gibRMy9d4TQ9WXJypjaZuO+fRGxgX7FKSa/UxhAXaRPfBvre9G/zifHE/
         Nhex7ju7mkB/QFCvOmTHwSBmDMt6+nJRJRyCxCA83l6M0guckNfUGfXmTP3yoOtqsyyb
         zNO6pG0JSZNb+x2Xe/Gwy2SvHr5yHNE8MGOSJquOczVIjnNjA57IC5UzmRXAJEbh4XHk
         FhLTyhUujuJN0otHLin0MCHMhqDYimXYjb7S/SlpHiY3n/yswiM0C9o58n4jTfJLVKk2
         PpqA==
X-Gm-Message-State: ANoB5pkSMo+H93IyGoFRQx/rvPVYbMin5B+TnB6CLaAtIZzyw0mRAaLD
        MrWsQC+H9/5Fdn6VuxeW14dfHaDuDwaatm3+XDw=
X-Google-Smtp-Source: AA0mqf5thx39+10A84DXhCglWuqmeNx5S6u9KLYotOVuFsNlgQ54AcwNezdHL7glKtdzTVYkG2MVzDmLlLMXe85bMJE=
X-Received: by 2002:a63:f048:0:b0:477:5e23:f9d1 with SMTP id
 s8-20020a63f048000000b004775e23f9d1mr46710633pgj.268.1670046483388; Fri, 02
 Dec 2022 21:48:03 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
 <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <patch-v5-15.15-a6f343b6221-20221202T110947Z-avarab@gmail.com>
In-Reply-To: <patch-v5-15.15-a6f343b6221-20221202T110947Z-avarab@gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Sat, 3 Dec 2022 00:47:52 -0500
Message-ID: <CAPig+cQNiidJz0dW+FwkdCVtk4uKA8d-thEz=0spKS+uSfS1fQ@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] CI: add a "linux-cmake-test" to run cmake &
 ctest on linux
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> Since [1] the "cmake" build method should work properly on Linux, but
> as seen in preceding commits there were various bugs in it, which are
> hopefully now all fixed.
>
> To ensure that it doesn't break again let's add a "linux-cmake-ctest"
> target to build and test "cmake" on Linux, in addition to that we'll
> also run the tests with "ctest" instead of "make" or "prove", so we
> can assert that testing with that method works..

s/\.\.$/./

> This also stress tests running "cmake" (and "ctest") out of a build
> directory that isn't the top-level. The "vs-build" job uses "cmake"
> since [2], but clobbers the top-level "Makefile" and builds in the
> top-level directory.
>
> That was the reason for why we didn't spot that various tests still
> required missing "mergetools/*" etc, which was fixed by using
> "$GIT_SOURCE_DIR" in a preceding commit.
>
> Since the "ci/lib.sh" already creates and exports a
> GIT_TEST_OPTS=3D"..." we'll pick that up in our CI, see the preceding

Probably want: s/CI,/CI;/

> commit. Because we pass the "--verbose-log -x
> --github-workflow-markup" in the GitHub CI as a result the interaction
> with "handle_failed_tests" here works correctly. I.e. on failure we'll
> have saved "t/test-results/*.{exit,out,markup}" files relevant to the
> failing test(s).
>
> 1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
> 2. 4c2c38e800f (ci: modification of main.yml to use cmake for vs-build
>    job, 2020-06-26)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
