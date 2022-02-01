Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB04C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiBAVTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiBAVTs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:19:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A7C06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 13:19:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jx6so58670182ejb.0
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=luctQn8VKcv4CBDxBaDC8Z1D9kvuaJ9Pph+LcfIJnfo=;
        b=qx+xmFX6eGkLId4v8kVAvabhdp55bsn2IsVM7TRBgk54w+6kFvXRguCCoBdBXES5Wb
         5viFhL6VgGhdawWf7Qp9NcJrJzwqC9koxJENgxcbrJEz8hmP82kNIlI2GMpK+v2JXDd1
         OU3ZIDYhbm14IsiuGjNQ21NetdRPIKuGUeVzqETg2o66YZQmKoECFpLA8iwPFG4GSPpc
         hVnGJVeLI/IRNFBibabhEexJdx+1XbEDcZQBa+Ih+Q7r5/cLiBqOfVRUXfhZ0GXdlsm1
         R/4pa2kFr9XgU6hqOVQK+I5npd8A03ctx3EB3MhJB6xtISCVr6SB/9SEPgvN7mOdDUW5
         pS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=luctQn8VKcv4CBDxBaDC8Z1D9kvuaJ9Pph+LcfIJnfo=;
        b=DHmnlsLHDPMrzV5LphPx2tYuQo8FFU0DkFuILMXuCPC7qiyGj8/wj+K9NNGwRVVWHr
         YEyuPZ6xZbAVDcSeE4gtoyQa4UVOIYryQh15JWbMk2uS1Vsz7PnYb/XD9qw300Ym53Ap
         NZnyTekS9k0aMTqn9cYrRQc9MeZUUnQm7KwAYB4OMtYrbKQHLhe9U0bDXwNX+9Tlnwv2
         G2c0rXb5FJz5UrNsPEcWjvyjnl2Y7EL6XOUlw6ORO/H8ySJb0WntMSc34TplyHnA87jb
         3PdwDrW4EIjaOxK9/avYfcPJ5+s52r+thomOIqvTcsDq294BhChKIcQ7LHXmocwLOR3l
         RWBQ==
X-Gm-Message-State: AOAM533Uw8a2hjMqDrEbml3wyTp4xen8qJwfxLawYRLkqZHPH4XtCixP
        Y5QC80v8TuwSzC7OpEhtNFsdZhkVpGb+mA==
X-Google-Smtp-Source: ABdhPJztMRxTebIoGyH9q5SjwMN2xh2AqKe6JARwuf/ZxKQnLF6BfN0s2SQubbjRMH3SlY2LFCdoBQ==
X-Received: by 2002:a17:907:6e0e:: with SMTP id sd14mr22622554ejc.274.1643750385837;
        Tue, 01 Feb 2022 13:19:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx18sm16644590edb.93.2022.02.01.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:19:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nF0Yy-004Mzi-Qg;
        Tue, 01 Feb 2022 22:19:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/3] t5312: prepare for reftable
Date:   Tue, 01 Feb 2022 22:17:34 +0100
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <b2c6e14c7e7752c9e42cb38372edc8971895932f.1643651420.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b2c6e14c7e7752c9e42cb38372edc8971895932f.1643651420.git.gitgitgadget@gmail.com>
Message-ID: <220201.865ypy9te7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 31 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Mark some tests as REFFILES if they rely on packed refs. Use ref-store
> helper to create bogus refs.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t5312-prune-corruption.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
> index ea889c088a5..9d8e249ae8b 100755
> --- a/t/t5312-prune-corruption.sh
> +++ b/t/t5312-prune-corruption.sh
> @@ -22,8 +22,8 @@ test_expect_success 'disable reflogs' '
>  '
>  
>  create_bogus_ref () {
> -	test_when_finished 'rm -f .git/refs/heads/bogus..name' &&
> -	echo $bogus >.git/refs/heads/bogus..name
> +	test-tool ref-store main update-ref msg "refs/heads/bogus..name" $bogus $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
> +	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/bogus..name"
>  }
>  
>  test_expect_success 'create history reachable only from a bogus-named ref' '
> @@ -113,7 +113,7 @@ test_expect_success 'pack-refs does not silently delete broken loose ref' '
>  # we do not want to count on running pack-refs to
>  # actually pack it, as it is perfectly reasonable to
>  # skip processing a broken ref
> -test_expect_success 'create packed-refs file with broken ref' '
> +test_expect_success REFFILES 'create packed-refs file with broken ref' '
>  	rm -f .git/refs/heads/main &&
>  	cat >.git/packed-refs <<-EOF &&
>  	$missing refs/heads/main
> @@ -124,13 +124,13 @@ test_expect_success 'create packed-refs file with broken ref' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'pack-refs does not silently delete broken packed ref' '
> +test_expect_success REFFILES 'pack-refs does not silently delete broken packed ref' '
>  	git pack-refs --all --prune &&
>  	git rev-parse refs/heads/main >actual &&
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'pack-refs does not drop broken refs during deletion' '
> +test_expect_success REFFILES  'pack-refs does not drop broken refs during deletion' '
>  	git update-ref -d refs/heads/other &&
>  	git rev-parse refs/heads/main >actual &&
>  	test_cmp expect actual

The setup for these is reffiles-specific, but it seems to me this is
something we'd really like to test with reftable rather than skipping it
entirely.

I.e. the scenario described in the "we create..." comment in this file
is something that might happen with reftable too, no?
