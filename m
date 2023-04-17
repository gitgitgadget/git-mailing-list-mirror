Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E5C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 22:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDQWyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 18:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDQWyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 18:54:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515222D63
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:54:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso2534665ad.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681772077; x=1684364077;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g63dVPhRUR2p2Phfgss/dHOefRoZQGYyC67acqPaUnM=;
        b=TEHv8moPZMRlYasGMGDxIbzzxRM++7NAQpQS+OQVeAJNuOzoYpyMnlQX947vUl7Zka
         duZlyOIKobJmHKuwUsaNalJ0RqEjR0gxDNZah2LmYrBj5kx4riw14pcvH0wBIglz5wRZ
         cjvbfwcqSQfCEZVpfheiluqz3G6aYM+kUaZ2Z8ETiDJOmcfOuRzhIJXSH9KustUZCrwc
         0PXoS0TJtzPQ8r/vLsZEJ9vtryNLoy0d4TGe75yDKs2D824nGhvXmxET4EpQ3RroLiYm
         i7jU3al95rBQ1HxeuwmHF3zCvUbYdJ8Ve9LK9tNLjBzvNNMVlNdCTN5402A/RcIoJpiv
         QapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681772077; x=1684364077;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g63dVPhRUR2p2Phfgss/dHOefRoZQGYyC67acqPaUnM=;
        b=LtsM+2c+m/TIMF79/GYe2ojRno68y2NMLzzC65AHgum6o6wb7M72yTvry1h4fZAIwk
         AGKG/3ZpusKiIDwSqNDRkZSKvmtj1scuVRLPU59f14r5dHqlpM0FcVI0ElkyRibm0i05
         M8b4JOYs9JwYnkWXIbpNOqySEVS5mTyeua1K1BP8B5QhopB/vqRir03Ftu9NEHhU6T9i
         Jd8Dv1i2Lm4pR8oeTwX7LU8IugdkEcO8OiC+684tMICXQrgyXSpJsag/+CJ21AWT3NUI
         VWXL6V2ieNKbuXMRi2ux+y00/Kaw49VeXiC0nkS4KKmQ40gdaUDs8gi3lLvou18nNDuf
         1VQQ==
X-Gm-Message-State: AAQBX9cB0waN0KjGu9e2iT0WpcphXmB1ftAQUiKlaniUuwV68H8VeRVS
        6A/isi7/EQol2o01T8ECKJtGt+ih6Y8=
X-Google-Smtp-Source: AKy350aySSGWfd3fHU5ZYTa8TVyrZpuiYQmDtYdAACfJnU8bEIz7N7cIXA3N8Og+6S3YRodrbkdOng==
X-Received: by 2002:a17:902:a98b:b0:1a1:c7b2:e7c7 with SMTP id bh11-20020a170902a98b00b001a1c7b2e7c7mr91584plb.49.1681772076655;
        Mon, 17 Apr 2023 15:54:36 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902aa4300b0019aaab3f9d7sm8167441plr.113.2023.04.17.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 15:54:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 03/10] builtin/gc.c: ignore cruft packs with
 `--keep-largest-pack`
References: <cover.1681764848.git.me@ttaylorr.com>
        <796df920ad6af0ee9101a0f3f80edbc793987336.1681764848.git.me@ttaylorr.com>
Date:   Mon, 17 Apr 2023 15:54:35 -0700
In-Reply-To: <796df920ad6af0ee9101a0f3f80edbc793987336.1681764848.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 17 Apr 2023 16:54:21 -0400")
Message-ID: <xmqqildui0gk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When cruft packs were implemented, we never adjusted the code for `git
> gc`'s `--keep-largest-pack` and `gc.bigPackThreshold` to ignore cruft
> packs. This option and configuration option share a common
> implementation, but including cruft packs is wrong in both cases:
>
>   - Running `git gc --keep-largest-pack` in a repository where the
>     largest pack is the cruft pack itself will make it impossible for
>     `git gc` to prune objects, since the cruft pack itself is kept.

Makes sense.  We want to keep the largest pack that is actually in
use, and we want to consolidate other non-cruft packs into one.

>   - The same is true for `gc.bigPackThreshold`, if the size of the cruft
>     pack exceeds the limit set by the caller.

This is not as cut-and-dried clear as the previous one.  "This pack
is so large that it is not worth rewriting it only to expunge a
handful of objects that are no longer reachable from it" is the main
motivation to use this configuration, but doesn't some part of the
same reasoning apply equally to a large cruft pack?  But let's
assume that the configuration is totally irrelevant to cruft packs
and read on.

>  --keep-largest-pack::
> -	All packs except the largest pack and those marked with a
> -	`.keep` files are consolidated into a single pack. When this
> -	option is used, `gc.bigPackThreshold` is ignored.
> +	All packs except the largest pack, any packs marked with a
> +	`.keep` file, and any cruft pack(s) are consolidated into a
> +	single pack. When this option is used, `gc.bigPackThreshold` is
> +	ignored.

"except the largest pack" -> "except the largest, non-cruft pack"

