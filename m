Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4286BC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiJZVDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiJZVDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:03:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4070FEE8B2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:03:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jo13so11806213plb.13
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiIXmjwjPr9inGq8TF78JNmCCa82kk6YHnsK8+TKYxM=;
        b=WCXVjFXCHvlATWxiScTm47wusJzvtfgxUDP6Lqugw44Q2iU9s0CmJed6Da/nczZxwK
         6v66PXf3mcrTijn7MH4UsEY1wgdmsmimJz0a457tv2hxjdR/Ch2BQUWVoWC8Wjvo4ULf
         z+nKMepPV2dnvd3eO9IDiz0dEi7zFD3lNnUOMzjkTTbzdBWnUnKP/imd6a7XwStw1ilO
         czNzfIj7wMbdxv3LmfX3WnKJfPabBY/ti8Q6LZY1ozXBz+nKPs5WYbizeup5rR/rEzU0
         m3URdIFsIojVLE2nHb1B3SyAdOUMouM3Wlz8CAy4ouO1/ZssumpSmaeoq70BnV0jXURs
         T1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OiIXmjwjPr9inGq8TF78JNmCCa82kk6YHnsK8+TKYxM=;
        b=BYTjJKza5XDWkaxBs8ngd+5SW9QgWN0nxhQJYaMAZYL3dMZLuKYAkhKLfHaoaGlDjT
         MiU2bw1ndRKhF287lc8VHxgcTbEAFrZUVbbxHZij+nTz7Egis2+dHVYqKRvCnYFM95wy
         ZGgpRgw+NSByz7vv+YxyuZTl3wP6saKvlF3xGGtMsXrcHKvnFtK5LvGXE7Tng+pm7ebL
         04h1hxBXYIpTfwly8Dju/L5mYQgaXl+KiRm7sTAbbkxxJzFhoYOpadiaTtu6SCIKaFO+
         kXIOqeH9FJRgRrvcAe7QlFr1qwP0TUigbg6AgzWTpVnZ0nVMoFPiem9eHnZ4clPpUfrF
         z19Q==
X-Gm-Message-State: ACrzQf2CXMOnGDPgKz1bGt4i/in/tN4T7CJIAU38fYfefHbBBiBDH/nB
        ISQHnDhxP1vWt9ONggtTEfU=
X-Google-Smtp-Source: AMsMyM5NnTgzwmMG57Uc58GPxTJBrrrRT+2SDDmjZO5oTY+CwJUu8vyU1yr7DOqcGmMrYl211zRQ4g==
X-Received: by 2002:a17:902:e88a:b0:186:e5ac:694f with SMTP id w10-20020a170902e88a00b00186e5ac694fmr2462482plg.32.1666818195654;
        Wed, 26 Oct 2022 14:03:15 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o72-20020a17090a0a4e00b00200461cfa99sm1493364pjo.11.2022.10.26.14.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:03:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/2] gc: add tests for --cruft and friends
References: <cover.1666815209.git.me@ttaylorr.com>
        <35d2c97715008db3957a69a8260e2046c0e5e738.1666815209.git.me@ttaylorr.com>
Date:   Wed, 26 Oct 2022 14:03:14 -0700
In-Reply-To: <35d2c97715008db3957a69a8260e2046c0e5e738.1666815209.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 26 Oct 2022 16:13:38 -0400")
Message-ID: <xmqqo7tyfgbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +prepare_cruft_history () {
> +	test_commit base &&
> +
> +	test_commit --no-tag foo &&
> +	test_commit --no-tag bar &&
> +	git reset HEAD^^
> +}

OK.  Three pearls on a single strand, then the tip-two gets rewound
away.

> +assert_cruft_pack_exists () {
> +	find .git/objects/pack -name "*.mtimes" >mtimes &&
> +	sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&

Somebody recently made comment that we already depend on the fact
that the default action for "find" is "-print".  I do not see the
need for the 'mtimes' intermediary file.  It does not hurt, but it
is not needed.

> +	test_file_not_empty packs &&
> +	while read pack
> +	do
> +		test_path_is_file "$pack" || return 1
> +	done <packs
> +}

OK.  We enumerate .mtimes files and ensure corresponding .pack
exists for each of them.  That might miss a case where we thought we
created a cruft pack (i.e. .pack exists) but somehow failed to
create the matching .mtimes file by mistake, but it is hard to tell
such a "broken cruft pack" file from a normal pack file, so I think
the above is the best we can do.

> +test_expect_success 'gc --cruft generates a cruft pack' '
> +	test_when_finished "rm -fr crufts" &&
> +	git init crufts &&
> +	(
> +		cd crufts &&
> +
> +		prepare_cruft_history &&
> +		git gc --cruft &&
> +		assert_cruft_pack_exists
> +	)
> +'
> +
> +test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
> +	test_when_finished "rm -fr crufts" &&
> +	git init crufts &&
> +	(
> +		cd crufts &&
> +
> +		prepare_cruft_history &&
> +		git -c gc.cruftPacks=true gc &&
> +		assert_cruft_pack_exists
> +	)
> +'

We could instead do away without when-finished clean-up and use
separate test subdirectory.  Consistently doing so may make CI
forensic easier.  I do not think it is necessary in the test history
used here that is too simple to be realisic.  If something breaks at
CI, it is simple enough to reproduce it manually, so I do not think
it is worth a reroll for that.

>  run_and_wait_for_auto_gc () {
>  	# We read stdout from gc for the side effect of waiting until the
>  	# background gc process exits, closing its fd 9.  Furthermore, the
