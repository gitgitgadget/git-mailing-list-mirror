Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48481C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbiDMTVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiDMTVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:21:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03284993A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:19:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u15so5907650ejf.11
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ieBjededwBT/8CxkqWBlo+D080ApBD/w0WSBG7d1Gf0=;
        b=lRFLpSBknExnO9EmDuNWohB14OagtSTJvh9cfQBS0gyaKSIn1W7Zpte2C2fs3RES2I
         B13x51DR3vIsTMC9hZFPz2d6uwKT53g1OzHkCNO4p4DK5AELrHbVH86oylwYHQxeZAuR
         w/OFhzBfYJ3haYgg5iGklUMgL4ms7xKc3CWBA462EDbwFUFzF+gD51EopBuix6ZbOBef
         V6TpXPm8G39RAtiTGhHvsXh/lzhxXYcBWZBehyFw2iBRv056wMfWdOg8GVkoAzFC+ZIS
         6Gywkfff19Hfy+V5D0+sLVchpn8shwIq+BY3V6HD9MjNYLYIVfW2TmS8PedQ09n9ZmML
         552w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ieBjededwBT/8CxkqWBlo+D080ApBD/w0WSBG7d1Gf0=;
        b=ikiiVPVpv8LHV1DhSWiw6Z20kye/qEDdLtZtayWIIwoMVO9kL6jPgxvn0aPpX7ScnF
         V8a9tt+J8ZEqwEMVu0mgbnSczGiin5gSOmUiYE4VDEAluOar2mdasyfH/gergHeDfPVU
         +VAQR6blWyOZiEPkvuj3Nxx97jHnTZG/reLtEHgEPV0JNa/6pjr0Vn1NWKrpTiHdJ6+H
         +M5ZHUR3ZMawcWPpI/LEKSasWRMEP7XqmWrxbYaXC4aqnKXA5Pw7JTM5Jy26LoCBoEc3
         A7dLlroGbX8SgJBrOnjYuNc0cFqVltzaZF2HOhBv3vl7wt3MV1Y6twbeRK9TCEN2YH8f
         3y3A==
X-Gm-Message-State: AOAM533AtuHtEGOyP/bKtlej2REa7gsfArjieqy5SYfF/SWPu5TwGuMh
        wJ6jhpUxIuHzozLCLfUXf+FdYvG+Ezs=
X-Google-Smtp-Source: ABdhPJzlpDfGhVk29KjhylJTswyAD7SeK9J7Uo6FbQK3UbXlGhcSvXFNPbhlI28Fr5UtZpv6/4li8A==
X-Received: by 2002:a17:907:6093:b0:6e0:dabf:1a9f with SMTP id ht19-20020a170907609300b006e0dabf1a9fmr40490252ejc.424.1649877553417;
        Wed, 13 Apr 2022 12:19:13 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n11-20020a50cc4b000000b0041d8bc4f076sm1568657edi.79.2022.04.13.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:19:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neiWG-005AK6-12;
        Wed, 13 Apr 2022 21:19:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] t0033: add tests for safe.directory
Date:   Wed, 13 Apr 2022 21:16:20 +0200
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
Message-ID: <220413.86k0bseqq8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> It is difficult to change the ownership on a directory in our test
> suite, so insert a new GIT_TEST_ASSUME_DIFFERENT_OWNER environment
> variable to trick Git into thinking we are in a differently-owned
> directory. This allows us to test that the config is parsed correctly.

I think this is a good trade-off, but FWIW I'd think we could test also
without the git_env_bool() by having the test depend on !NOT_ROOT, then
check the owner of t/test-lib.sh, and chown to that user (i.e. the
"real" user).

But that's all sorts of more fragile than just this test variable..
> +test_description='verify safe.directory checks'
> +
> +. ./test-lib.sh
> +
> +GIT_TEST_ASSUME_DIFFERENT_OWNER=1
> +export GIT_TEST_ASSUME_DIFFERENT_OWNER

Instead of this "export" perhaps just add it in front of the "git
status"?

These tests also pass with SANITIZE=leak, so please add
TEST_PASSES_SANITIZE_LEAK=true at the top.

> +expect_rejected_dir () {
> +	test_must_fail git status 2>err &&
> +	grep "safe.directory" err
> +}
> +
> +test_expect_success 'safe.directory is not set' '
> +	expect_rejected_dir
> +'
> +
> +test_expect_success 'safe.directory does not match' '
> +	git config --global safe.directory bogus &&
> +	expect_rejected_dir
> +'
> +
> +test_expect_success 'safe.directory matches' '
> +	git config --global --add safe.directory "$(pwd)" &&

nit: $PWD instead of $(pwd)
