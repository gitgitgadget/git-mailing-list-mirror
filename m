Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786CC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352804AbiCXTEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbiCXTEp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 15:04:45 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAC1706B
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:03:11 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z19so1459799qtw.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zsj8whDssEwrHc/RsYcR8iMjNT6UQk3ynItWOO2kGxM=;
        b=0Kh73Qno9fAf0J3pdtJq6DCQwXVJsEGR9jw7RdxShkPvyZ/TJZzbD5ags2G/JNAsyj
         e0VRKQHYGK3GDiGxLz09I9TQLH5aLB40t5kBF7/9eYKuTVPup5sI1TDwaZzOVeEEdSBe
         p/ew4O0mLQ+9c1Sy872xKzRu+uaeQEIKhIUqpbB1XmcR1d7nCKIiPZ4Y7OdxsA3rd8LK
         WvXyuu31Tn1QdA6SX0yVmQxxke+U8/WP1MpjFGaxwxRcN9RU9rJQDuHDfM8bFHnWm/A6
         b4tvD5pi28WZn4I/sjQXAN/qX4/3OnvHqoODZmVoJ9rtr4PzFvkscUACh3NMPRNIUQZ4
         k3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zsj8whDssEwrHc/RsYcR8iMjNT6UQk3ynItWOO2kGxM=;
        b=QTm/nFCqym/BaOMe7lpeDfItFQSlvHmi+ZycUPWI362rDCKRuLLHZMK8DPN0i/eFBM
         Ts6UY/AKnY4vg29Dt1HyE9ys+ip57GpuYDVnB3qyQac406DUeWF95EIimXXZTzjHAbYc
         wqm50purl8VeIWS+Bj1eJVc1oU+KObqdY86HdLIKbVDd376AX4VPcXLwV2pLl+IVWWZJ
         JAHpUH67flxmMix0iVDqeRB3jR7SNy4IT2Wsn7eBro4BvJ38eY0vZq280GvcEn7QLVJv
         WqtspDR4smh9cwyFx3yjPArgL7m8bUfA/x/ebI0I5lZSGytlK0ADeCSwo9yD8OO05UBH
         cM7A==
X-Gm-Message-State: AOAM533OO4T8kZWNxk8JLN35XKZSzVxA1R53QUnhpGZW7DfpjfoJGlco
        w7YEfOtiaI7LuA0KpUBHZwZ8Mg==
X-Google-Smtp-Source: ABdhPJzzGgxNq6VfCDNANd3xngiMUhWjD3xedmfPgIQuOZgTil0dpcH1t2WlXVFBZwCXuAWcDjbKag==
X-Received: by 2002:ac8:5bd0:0:b0:2e1:b639:9d5d with SMTP id b16-20020ac85bd0000000b002e1b6399d5dmr5990311qtb.640.1648148590690;
        Thu, 24 Mar 2022 12:03:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a24d000b0067ecf605ef5sm2231970qkn.105.2022.03.24.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 12:03:10 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:03:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 2/3] pack-bitmap.c: add "break" statement in
 "open_pack_bitmap()"
Message-ID: <YjzAbSJfuu06smnD@nand.local>
References: <cover.1648119652.git.dyroneteng@gmail.com>
 <70500b63434f6e454631b3a8fde07c62b5adfef0.1648119652.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70500b63434f6e454631b3a8fde07c62b5adfef0.1648119652.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 07:44:00PM +0800, Teng Long wrote:
> There will be only one operant ".bitmap" file in repo, so let's
> add "break" statement in "open_pack_bitmap()" when looping all
> the packs in repo.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  pack-bitmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 931219adf0..b1357137bf 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -484,8 +484,10 @@ static int open_pack_bitmap(struct repository *r,
>  	assert(!bitmap_git->map);
>
>  	for (p = get_all_packs(r); p; p = p->next) {
> -		if (open_pack_bitmap_1(bitmap_git, p) == 0)
> +		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
>  			ret = 0;
> +			break;

The lack of a break here is intentional, I think, since having more than
one bitmap of the same kind in a repository is an error.

(This is behavior we inherited from the pre-MIDX bitmap days, when
having more than one pack bitmap caused Git to signal an error, since it
could only use the results from a single bitmap).

You can see in pack-bitmap.c::open_pack_bitmap_1() that we have a
condition saying:

    if (bitmap_git->pack || bitmap_git->midx) {
        /* ignore extra bitmap file; we can only handle one */
        warning("...")
        close(fd;)
        return -1;
    }

We do want to call that open_pack_bitmap_1() function on every pack we
know about to make sure that one and only one of them corresponds to a
.bitmap.

Thanks,
Taylor
