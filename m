Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88992C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 01:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKCBQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 21:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCBQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 21:16:43 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407625F6
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 18:16:42 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x16so350664ilm.5
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tpqon2Sl585nB7bDTBZXNJ8LS8pYYWcWQ1Mi5uthNCA=;
        b=u3PKHBbV/3gtVJCIsW2xGZ87WqpO/W6kShyWhK/ZiHctegqcB1PzkBoIU8PHBiMCtG
         VNUjcBAbhpLz1ZUHJAOh7YM+9i+t32U2bs0hjfa/OgJ0uGZ49BGC8rJYnGXerPXeLodu
         Xm/RK5IuklyX7hKrejRl9BWyh00JSsqIArmWYC9H5C+WIOjHtKH00ZNgxRJC9ASFKZcB
         2DbQ5EDeHUXubr2ME0EvKl6BuLNOoWz/+5xGbwoLj9b731WjDskXBGuOx5SaXdt8ApkJ
         vMeDTs6na4StuDBXIuuNfPG4VgN9Hxr2WlESOo3Hg6fAP0n0Dbq1kTTKZMVrzaTjn5SV
         g3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpqon2Sl585nB7bDTBZXNJ8LS8pYYWcWQ1Mi5uthNCA=;
        b=PqHRyAmxe4gI32+PXtd/hQyF2I4hPQJOFOzDqJDWfi2PqBMJ+IX+BgpQOn2DE9X5Wb
         DDseBORPhRJYLSqGGyYlOhH/sp+h5tWwHAMbEdbsfy872keYsZw7ByiAS8KVeKWi2B9Z
         ItWZKln39BbE62y3r/KMK57D0CUiRfgyuMTKP/NS3V8mm9xL405NuV3GQ9/aTJ/6pUse
         /NDA4Ghm8pDbf6jFYD1zLY9N5vsZwKT2iDAU9k51FIf5ZxrhfIwmW4nhSm+z+F8GmEkK
         dP/VGyeG93AAnaEzsKTS0gMz9jvy/HJjlDZCFPooCpQLTQS9/sut9cG4moOqHs4TEhpL
         6ldA==
X-Gm-Message-State: ACrzQf2BHGF02NsGp6FnOFiKT4hJrWCzLIEcCJYPNe9+U8fhYtZKJIj7
        iFJF3jFzOz9NvZdcALrVW2RmAA==
X-Google-Smtp-Source: AMsMyM4AiAYmE9jW8XQZuCiC2Ezp/HHz77KxTUW7802hbz//hYwPQD4bao9t+mMzud0oiSb+9/6+6g==
X-Received: by 2002:a05:6e02:787:b0:300:c853:a24e with SMTP id q7-20020a056e02078700b00300c853a24emr5882379ils.59.1667438202314;
        Wed, 02 Nov 2022 18:16:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r5-20020a02b105000000b00372e2c4232asm5445499jah.121.2022.11.02.18.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:16:41 -0700 (PDT)
Date:   Wed, 2 Nov 2022 21:16:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, XingXin <moweng.xx@antgroup.com>
Subject: Re: [PATCH v2 1/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y2MWeE2f/P1iXPCY@nand.local>
References: <cover.1667393419.git.dyroneteng@gmail.com>
 <87a494e5ac0cc992689944ab13600d097c51e54a.1667393419.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a494e5ac0cc992689944ab13600d097c51e54a.1667393419.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 08:56:05PM +0800, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> In "open_midx_bitmap_1()" and "open_pack_bitmap_1()", when we find that
> there are multiple bitmaps, we will only open the first one and then
> leave warnings about the remaining pack information, the information
> will contain the absolute path of the repository, for example in a
> alternates usage scenario. So let's hide this kind of potentially
> sensitive information in this commit.
>
> Found-by: XingXin <moweng.xx@antgroup.com>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  pack-bitmap.c           | 12 ++++++++----
>  t/t5310-pack-bitmaps.sh | 11 ++++++++---
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 36134222d7a..a8c76056637 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -331,8 +331,9 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	if (bitmap_git->pack || bitmap_git->midx) {
>  		struct strbuf buf = STRBUF_INIT;
>  		get_midx_filename(&buf, midx->object_dir);
> -		/* ignore extra bitmap file; we can only handle one */
> -		warning("ignoring extra bitmap file: %s", buf.buf);

OK... here we're getting rid of the user-visible warning, which makes
sense and is the point of this patch.

> +		/* ignore extra midx bitmap files; we can only handle one */
> +		trace2_data_string("bitmap", the_repository,
> +				   "ignoring extra midx bitmap file", basename(buf.buf));

But we replace it with a trace2_data_string() that only includes the
basename? I'd think that the point of moving this warning into
trace2-land is that we could emit the full path without worrying about
who sees it, since trace2 data is typically not plumbed through to
end-users.

IOW, I would have expected to see a patch something along the lines of:

> -		/* ignore extra bitmap file; we can only handle one */
> -		warning("ignoring extra bitmap file: %s", buf.buf);
> +		/* ignore extra midx bitmap files; we can only handle one */
> +		trace2_data_string("bitmap", the_repository,
> +				   "ignoring extra midx bitmap file", buf.buf);

> @@ -402,8 +403,9 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  	}
>
>  	if (bitmap_git->pack || bitmap_git->midx) {
> -		/* ignore extra bitmap file; we can only handle one */
> -		warning("ignoring extra bitmap file: %s", packfile->pack_name);
> +		/* ignore extra bitmap files; we can only handle one */
> +		trace2_data_string("bitmap", the_repository,
> +				   "ignoring extra bitmap file", basename(packfile->pack_name));

Same note here.

> +	trace2_data_string("bitmap", the_repository, "opened bitmap file",
> +			   basename(packfile->pack_name));

If we get later bitmap-related information in the trace2 stream, we know
that we opened a bitmap. And at the moment we read a bitmap, there is
only one such bitmap in the repository.

I suppose that this is race-proof in the sense that if the bitmaps
change after reading, we can still usefully debug the trace2 stream
after the fact.

So even though my first reaction was that this was unnecessary, on
balance I do find it useful.

> -test_expect_success 'complains about multiple pack bitmaps' '
> +test_expect_success 'complains about multiple pack bitmaps when debugging by trace2' '
>  	rm -fr repo &&
>  	git init repo &&
>  	test_when_finished "rm -fr repo" &&
> @@ -420,8 +420,13 @@ test_expect_success 'complains about multiple pack bitmaps' '
>  		test_line_count = 2 packs &&
>  		test_line_count = 2 bitmaps &&
>
> -		git rev-list --use-bitmap-index HEAD 2>err &&
> -		grep "ignoring extra bitmap file" err
> +		ls -tr .git/objects/pack | grep -e "^pack-.*\.pack$" > sorted-packs &&
> +		ignored_pack="$(cat sorted-packs | awk 'NR==1{print}')" &&
> +		open_pack="$(cat sorted-packs | awk 'NR==2{print}')" &&

Hmmph. This test only passes if 'ls -tr' gives us the packs in order
that they are read by readdir(), which doesn't seem all that portable to
me. At the very least, it is tightly coupled to the implementation of
open_pack_bitmap() and friends.

> +		GIT_TRACE2_PERF=1 git rev-list --use-bitmap-index HEAD 2>err &&
> +		grep "opened bitmap file:$opened_pack" err &&
> +		grep "ignoring extra bitmap file:$ignored_pack" err

Do we necessarily care about which .bitmap is read and which isn't? The
existing test doesn't look too closely, which I think is fine (though as
the author of that test, I might be biased ;-)).

I would be equally happy to write:

> +		GIT_TRACE2_PERF=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
> +		grep "opened bitmap" trace2.txt &&
> +		grep "ignoring extra bitmap" trace2.txt

Thanks,
Taylor
