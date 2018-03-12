Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C911F404
	for <e@80x24.org>; Mon, 12 Mar 2018 19:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeCLTa1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 15:30:27 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:39715 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeCLTa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 15:30:26 -0400
Received: by mail-wr0-f170.google.com with SMTP id r66so9292571wrb.6
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oPms9SPpBQv2GWBmHZ+RoZIQl2fm43NW+6J8M2/3nMA=;
        b=U0VXnt5CafGDytcZPhtyC0jQSE8PXFkQvJhI4idhNEtgQ5pKghIFDtBLMNEKmPhrsm
         01Li/LNLAMAum4HcCxVm/CYD2Y0u1exs39U1rPRAmgfB3igZYqWoiDNG/QiLHl157E/E
         5zIWanU7UYQSO3hMW5km8fTEUQrnx3p9o79VAxPSoNLela4MyWJ2zNNqq0jKpj45i3rD
         fQF0gC3iWcFpZuLBHGZGE9njN04t0XNJ+M5mcjTVrrFgafX/24AqMuZdf8meGaY78BLI
         rjM8bx7PcAuIaV05oFl9sKkRkg0AnuxPzrasyZ0L3yPYuu8e5jW4IkoyI/XfZiH37Dkk
         3rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oPms9SPpBQv2GWBmHZ+RoZIQl2fm43NW+6J8M2/3nMA=;
        b=nh7tQOR1VIUtG7sIYr9jqcHUC7a0C26H8DZtnCj+i59tHEdM6U1u3UJjhD2Jr5ffG5
         8oKk9xyqdPIUUKr8OvIY5jETF7tMgbi3HEsWWxL26nwBrpupEZofWY/uWnuSOR6DdEKL
         1ZS2HrCATj5EsGhGKBGNGb7/KRva7OvW7uBnHLe+FsKR9HqJJi/ymTbhiqGw7FBVtFJl
         80+OEnk3meZzQ3Bz9D+OnaC+RaCInj0tuUaSho+9NTomuauqhYxfcooIdjGbQxZvC+C4
         2MM86mGNj27adCCyzaErjFztNVD8XM+3e1LSX64pNBu3WGIEI3B434ZZzhZVC4yD9mJd
         3w1g==
X-Gm-Message-State: AElRT7Hj9FfJ1kJywadeqdKu4KlRsAEWDgUeqNGLb75iFs1NdMglWlqK
        fcy5L5xsZcRsrqk9F72KX0/lTdGg
X-Google-Smtp-Source: AG47ELsje0e4Boes993MNfAIRPGZWI8W3rn3wRVZuo/8FYJHjBUAmOH34Cvt0hPgcpN0NiZslWs1Sw==
X-Received: by 10.223.150.161 with SMTP id u30mr4455400wrb.151.1520883025374;
        Mon, 12 Mar 2018 12:30:25 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id q9sm10432472wrf.11.2018.03.12.12.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 12:30:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com> <20180306104158.6541-4-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180306104158.6541-4-pclouds@gmail.com>
Date:   Mon, 12 Mar 2018 20:30:21 +0100
Message-ID: <87a7vdqegi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 06 2018, Nguyễn Thái Ngọc Duy jotted:

> pack-objects could be a big memory hog especially on large repos,
> everybody knows that. The suggestion to stick a .keep file on the
> giant base pack to avoid this problem is also known for a long time.
>
> Let's do the suggestion automatically instead of waiting for people to
> come to Git mailing list and get the advice. When a certain condition
> is met, "gc --auto" tells "git repack" to keep the base pack around.
> The end result would be two packs instead of one.
>
> On linux-2.6.git, valgrind massif reports 1.6GB heap in "pack all"
> case, and 535MB [1] in "pack all except the base pack" case. We save
> roughly 1GB memory by excluding the base pack.
>
> gc --auto decides to do this based on an estimation of pack-objects
> memory usage, which is quite accurate at least for the heap part, and
> whether that fits in half of system memory (the assumption here is for
> desktop environment where there are many other applications running).
>
> Since the estimation may be inaccurate and that 1/2 threshold is
> really arbitrary, give the user a finer control over this mechanism:
> if the largest pack is larger than gc.bigBasePackThreshold, it's kept.
>
> PS. A big chunk of the remaining 535MB is the result of pack-objects
> running rev-list internally. This will be dealt with when we could run
> rev-list externally. Right now we can't because pack-objects internal
> rev-list does more regarding unreachable objects, which cannot be done
> by "git rev-list".
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt |   7 ++
>  Documentation/git-gc.txt |  13 ++++
>  builtin/gc.c             | 153 +++++++++++++++++++++++++++++++++++++--
>  builtin/pack-objects.c   |   2 +-
>  config.mak.uname         |   1 +
>  git-compat-util.h        |   4 +
>  pack-objects.h           |   2 +
>  t/t6500-gc.sh            |  29 ++++++++
>  8 files changed, 204 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f57e9cf10c..120cf6bac9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1549,6 +1549,13 @@ gc.autoDetach::
>  	Make `git gc --auto` return immediately and run in background
>  	if the system supports it. Default is true.
>
> +gc.bigBasePackThreshold::
> +	Make `git gc --auto` only enable `--keep-base-pack` when the
> +	base pack's size is larger than this limit (in bytes).
> +	Defaults to zero, which disables this check and lets
> +	`git gc --auto` determine when to enable `--keep-base-pack`
> +	based on memory usage.
> +

I'm really keen to use this (and would be happy to apply a patch on
top), but want to get your thoughts first, see also my just-sent
87bmftqg1n.fsf@evledraar.gmail.com
(https://public-inbox.org/git/87bmftqg1n.fsf@evledraar.gmail.com/).

The thing I'd like to change is that the underlying --keep-pack= takes a
list of paths (good!), but then I think this patch needlessly
complicates things by talking about "base packs" and having the
implementation limitation that we only ever pass one --keep-pack down to
pack-objects (bad!).

Why don't we instead just have a gc.* variable that you can set to some
size of pack that we'll always implicitly *.keep? That way I can
e.g. clone a 5GB pack and set the limit to 2GB, then keep adding new
content per the rules of gc.autoPackLimit, until I finally create a
larger than 2GB pack, at that point I'll have 5GB, 2GB, and some smaller
packs and loose objects.

We already have pack.packSizeLimit, perhaps we could call this
e.g. gc.keepPacksSize=2GB?

Or is there a use-case for still having the concept of a "base" pack? Is
it magic in some way? Maybe I'm missing something but I don't see why,
we can just stop thinking about whether some one pack is larger than X,
and consider all packs larger than X specially.

But if we do maybe an extra gc.keepBasePack=true?

Finally I wonder if there should be something equivalent to
gc.autoPackLimit for this. I.e. with my proposed semantics above it's
possible that we end up growing forever, i.e. I could have 1000 2GB
packs and then 50 very small packs per gc.autoPackLimit.

Maybe we need a gc.keepPackLimit=100 to deal with that, then e.g. if
gc.keepPacksSize=2GB is set and we have 101 >= 2GB packs, we'd pick the
two smallest one and not issue a --keep-pack for those, although then
maybe our memory use would spike past the limit.

I don't know, maybe we can leave that for later, but I'm quite keen to
turn the top-level config variable into something that just considers
size instead of "base" if possible, and it seems we're >95% of the way
to that already with this patch.

Finally, I don't like the way the current implementation conflates a
"size" variable with auto detecting the size from memory, leaving no way
to fallback to the auto-detection if you set it manually.

I think we should split out the auto-memory behavior into another
variable, and also make the currently hardcoded 50% of memory
configurable.

That way you could e.g. say you'd always like to keep 2GB packs, but if
you happen to have ended up with a 1GB pack and it's time to repack, and
you only have 500MB free memory on that system, it would keep the 1GB
one until such time as we have more memory.

Actually maybe that should be a "if we're that low on memory, forget
about GC for now" config, but urgh, there's a lot of potential
complexity to be handled here...
