Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F451F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeJXMFT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 08:05:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37587 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeJXMFS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 08:05:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so525957wmc.2
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=irNFGnLYJwmLg4sumohoLPGPSNQCIWpNKjipVlDz2t4=;
        b=BcKlvWB3DxomUGpfAPS4FRoOw/EbpAatVT/tTNThdZKCTKeXQGslRj4fnEXVhqK6Ks
         eiuuf4+xswLIwLuzRRuvyrJXsIdqwbmsvQhF8BsQj2c2qy+aRmNHmBUTCw3ANUjzwm3F
         HxZW2CK77s035GsdVgZL4E5glcmp4nbN135CASxnDpTZ7P5g05RexDuErpuRPeKq0ts6
         Ib1rgJUfAsww4ux1yvaRcwOHMsm3HL7azQf0/JUT9Lsm9elgJ+ii7vxETGB6SB+CUPgu
         XmpnsEzmC5ImHFISH5W+1GqHjk/Is2hqfxyz80RakPe6v0wZwasuUtRG586YYJI14YZV
         qScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=irNFGnLYJwmLg4sumohoLPGPSNQCIWpNKjipVlDz2t4=;
        b=OaqbD5oYtEENVZXvpPC4U5B+1Bm8pT3ArrVN8HmaiqycDvzzAAXjsnzlRBgpqxQIH1
         1hkd+Bae/XEaIzyHXNBFYsDaUkw1rTZpFCdn9UKi/YKS5OYSqwuogWYL+beeqaA63l97
         Sn9lMcsbounjoFZBT7CZb1EcarGStv5V2IMkPKGxheUuLiDJI2BJyILTuL3s20yjtyh2
         PYopCQePyYrdIP5simpcFeTbQI+0GWyFmmJu45hviqqYneZTnLe8AtaiBPo1pG+6NOMZ
         SE/QwGLGzyAu4yIt0LMA6d0VpwMW5NNXZdttX1AbBNRVZq8TOoZt0ByiSXeey/4lsXgJ
         q9/g==
X-Gm-Message-State: AGRZ1gIjkCuKa/wyt+ZlDWZpUmEBiQ70MvSXmmuvVUnHmK/5WwztU+wm
        8j12BIrR0XU0cLuXlQ4ZpdBCW8VbIX8=
X-Google-Smtp-Source: AJdET5fxZ8gbhmcnHY9pWDL8WyFUn93dJ1AJOJmxjJysWQnJNvDKFsLgxvtnun4XnlKuiCsshgmPjw==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190-v6mr669328wmg.149.1540352344880;
        Tue, 23 Oct 2018 20:39:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c184-v6sm3852649wma.15.2018.10.23.20.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 20:39:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/3] repack: point out a bug handling stale shallow info
References: <pull.9.v2.git.gitgitgadget@gmail.com>
        <pull.9.v3.git.gitgitgadget@gmail.com>
        <ed8559b91b7a3b51a5950d62e78fc726ed5b44c2.1540245934.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Oct 2018 12:39:03 +0900
In-Reply-To: <ed8559b91b7a3b51a5950d62e78fc726ed5b44c2.1540245934.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 22 Oct 2018
        15:05:37 -0700 (PDT)")
Message-ID: <xmqqr2ggovxk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> A `git fetch --prune` can turn previously-reachable objects unreachable,
> even commits that are in the `shallow` list. A subsequent `git repack
> -ad` will then unceremoniously drop those unreachable commits, and the
> `shallow` list will become stale. This means that when we try to fetch
> with a larger `--depth` the next time, we may end up with:
>
> 	fatal: error in object: unshallow <commit-hash>

Nicely analysed and described.  One minor thing nagged me in the
implementation but it is not a big issue.

> +...
> +	d="$(git -C shallow-server rev-parse --verify D)" &&
> +	git -C shallow-server checkout master &&
> +
> +...
> +	! grep $d shallow-client/.git/shallow &&

We know D (and $d) is not a tag, but perhaps the place that assigns
to $d (way above) can do the rev-parse of D^0, not D, to make it
more clear what is going on, especially given that...

> +	git -C shallow-server branch branch-orig D^0 &&

... this does that D^0 thing here to makes us wonder if D needs
unwrapping before using it as a commit (not commit-ish). 

If we did so, we could use $d here instead of D^0.

> +	git -C shallow-client fetch --prune --depth=2 \
> +		origin "+refs/heads/*:refs/remotes/origin/*"
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd

