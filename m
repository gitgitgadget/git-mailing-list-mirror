Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD295C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 21:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiGRVwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiGRVws (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 17:52:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5C2E6B6
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:52:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id va17so23856523ejb.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=79bSPJ0C0EG9YyOgRLvrAfyVd7fMcMtF90GhyNpgU/g=;
        b=RFkTFiNyPsFyRTGpGcg5epuUHBBk++UH3fWL+zGlfEN9hFhrh7fOOvUKRwqHvwaHMd
         ynR2Tro/OYc0aTWuOUToD0f5sgJZhp2Hym+voY/txzrUMDMfUn3AQbxZ0MUlTcHfxvBu
         SqI9La0P0f5Y16Aw5eLcMJrHsTT7IYxRDIk8lkdz6utHQt0KsZqzl/aE5/eeWz7KOU21
         9MLqrG5HIHIHMB+1Y4ScVPuACKkS4iDweLD1EVxIBava8aGa0ym2jPeGkbuWrFXu203r
         EvMi++cFKyMYfIaKUAR7vlIklIH5I+6FmLJANodT3hVl7Ui4pkbpZst/9Cbe1NvnztPC
         dchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=79bSPJ0C0EG9YyOgRLvrAfyVd7fMcMtF90GhyNpgU/g=;
        b=O/9/iNMh0oRjwapxLGRkr2NpuxNH/Wq6FibGDGpR/iJ0veSVqlpRwxSLFr7SGfzPa/
         fG94uOhkIxBTXhA76yEFRzIIbADnRyxo7Rxnz4ohFZHR7vH/YMR03/kPC1T48l9pukI3
         75H9udsunJ7ZYygPDi3EMadN94hPEDirGRd4ULCknEanCsJdvOIAC178p9O45imh0hDt
         X5drzBDL+1fE7kJ4sAtvB1dQGvjvWWwYTyGD0EGBJg7fu6iOX/HXwgKNf0DH2gkb5avY
         /bfYktDTxZ0zcSSiT7i2Bmw0+czzg9FruUVHHai3mwQaghlWQId6o0qUQJSf1cuZJj0v
         7OXQ==
X-Gm-Message-State: AJIora9PZJl5qz+JTsgtz2QpQl/GSpT31KMPKuJYVAHCLZSvTaFsW7Yl
        si11tB70G4kRbSDHK87OFXFHw0M5GTH1ig==
X-Google-Smtp-Source: AGRyM1vY9tZYZ5J4l6Ob3X05iV4Hdflgkk6WWHNOY1slXU2edTCb4prt4yel1C00ZMLQmXD4/0R2ww==
X-Received: by 2002:a17:907:284a:b0:72b:74ac:a83 with SMTP id el10-20020a170907284a00b0072b74ac0a83mr26476710ejc.560.1658181165398;
        Mon, 18 Jul 2022 14:52:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7cfce000000b0043a4de1d421sm9341594edy.84.2022.07.18.14.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:52:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDYfU-003QAz-2t;
        Mon, 18 Jul 2022 23:52:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] midx:  reduce memory pressure while writing bitmaps
Date:   Mon, 18 Jul 2022 23:47:12 +0200
References: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
Message-ID: <220718.867d4aw0k3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> It is unfortunate that the lifetime of the 'entries' array is less
> clear. To make this simpler, I added a few things to try and prevent an
> accidental reference:
>
>  1. Using FREE_AND_NULL() we will at least get a segfault from reading a
>     NULL pointer instead of a use-after-free.
>
>  2. 'entries_nr' is also set to zero to make any loop that would iterate
>     over the entries be trivial.
>
>  3. Set the 'ctx' pointer to NULL within write_midx_bitmap() so it does
>     not get another reference later. This requires adding a local copy
>     of 'pack_order' giving us a reference that we can use later in the
>     method.
>
>  4. Add significant comments in write_midx_bitmap() and
>     write_midx_internal() to add warnings for future authors who might
>     accidentally add references to this cleared memory.
> [...]
> +	/*
> +	 * Remove the ctx.entries to reduce memory pressure.
> +	 * Nullify 'ctx' to help avoid adding new references to ctx->entries.
> +	 */
> +	FREE_AND_NULL(ctx->entries);
> +	ctx->entries_nr = 0;
> +	pack_order = ctx->pack_order;
> +	ctx = NULL;

After this change this is a ~70 line function, but only 3 lines at the
top actually use ctx for anything:
    
	/* the bug check for ctx.nr... */
	prepare_midx_packing_data(&pdata, ctx);
	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);

Did you consider just splitting it up so that that there's a "prepare
write" function? Then you don't need to worry about the scoping of ctx.

I'd think that would be better, then you also wouldn't need to implement
your own free-ing, nothing after this seems to use ctx->entries_nr (but
I just skimmed it), so it could just fall through to the free() at the
end of write_midx_internal() (the only caller), couldn't it?
