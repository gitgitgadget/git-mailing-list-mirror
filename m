Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46180C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGKO4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGKO4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:56:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491671BC7
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:56:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y8so6596404eda.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xy8KLNFbDuvZ/EQ49bCCLLufQCXhcBPicsp7dlRUEbU=;
        b=F2iOzYO03FcFJGDZwgqrt9F4fGPqJnQKI75j9LnQ0cKA0ZlDyX16bmhPEvsG+hfqC0
         cYMDx550uVYKrACKTgJ8b30XEoq8BTnq3QtZPEo2+8zPMRWuIDwqMMkCW1TL5k0d4o0J
         OPtTDFb6EBmvNdcHpq2Ter+lDkWZQZ0fezTSgkpCX4RSQ7LZldU990Hdkcvl1pnIlKmJ
         yjo/0Ud9aisqG5uKq1P2qhDzTB5+P7ifLnjMA2xLi7RE84DQ0OIoL3u5u6yBfn5jsWku
         5dBqFgAa+fJavThL0WvsmerwSSRYmVwRoCb0QSgSDkGKkRqQ9xn+zdODRnCMZgnwjOCh
         VTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xy8KLNFbDuvZ/EQ49bCCLLufQCXhcBPicsp7dlRUEbU=;
        b=RfPrz9XEUVnfMP1rfZfcRuVFTTZLrEpbvFb20FJdHn6atVnO/jspmWRwfNVT3DrXDy
         csN8BOzX6DfNKww5uCZBL/L5gF3pvPt1NUYGvVL6X0vTwU8eN5psg3D1qjBAV5oRP/Ds
         FDDDKZIg2xZm6OVcxckDwFWcSGkUX9HOYVM4I5i1NVSN3J+Hr6mLQQ5ArnckfiPJpscI
         rWXHFobAXBayeBbW1i/3jOMiDc1FlUrWWpcUwk7T7n2mLWClRKgb6QrukwYFCsGQz+4G
         B5uFpCPhmrlbPapQ6IulNSG14HeDZhFcA+v2nsNu7HJyDZ1kKhyihxgFL6CEVxBe8/fp
         zX6A==
X-Gm-Message-State: AJIora8Jdf5ituoGBXBygtDgUBSNHyzHVBAd1/hsYCO1x437VPZYjq6b
        iMPWWojLysacJvuyaJUtJM4=
X-Google-Smtp-Source: AGRyM1vhntufo5LIvZLFYbukbdHj0oUtfi5P+xVorVegj/MHpeco2dSRONDtH/TTNLZEz0k39PG5Cg==
X-Received: by 2002:aa7:d143:0:b0:43a:88f4:4ec1 with SMTP id r3-20020aa7d143000000b0043a88f44ec1mr25784549edo.141.1657551389548;
        Mon, 11 Jul 2022 07:56:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q20-20020a17090676d400b0072a815f3344sm2733163ejn.137.2022.07.11.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:56:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAupo-000v64-2a;
        Mon, 11 Jul 2022 16:56:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 5/7] pack-bitmap.c: using error() instead of silently
 returning -1
Date:   Mon, 11 Jul 2022 16:53:48 +0200
References: <cover.1657540174.git.dyroneteng@gmail.com>
 <52783555e206060465743b5587580a6bd4a1f008.1657540174.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <52783555e206060465743b5587580a6bd4a1f008.1657540174.git.dyroneteng@gmail.com>
Message-ID: <220711.86bktv7l5v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Teng Long wrote:

Good to report errno now, however...

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  pack-bitmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 319eb721d8..fbe3f58aff 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -327,7 +327,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  
>  	if (fstat(fd, &st)) {
>  		close(fd);
> -		return -1;
> +		return error_errno(_("cannot fstat bitmap file"));

This is a logic error, as fstat() failed, but you're reproting errno()
after our call to close(), at which point it's anyone's guess what
"errno" is. It's only meaningful immediately after a system call.

So either:

    error_errno(....);
    close(fd);
    return -1;

Or even better:

    error_errno(...)
    if (close(fd))
        warning_errno("cannot close() bitmap file");
    return -1;

Although that last one may be too pedantic.

>  	}
>  
>  	if (bitmap_git->pack || bitmap_git->midx) {
> @@ -350,8 +350,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	if (load_bitmap_header(bitmap_git) < 0)
>  		goto cleanup;
>  
> -	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
> +	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
> +		error(_("checksum doesn't match in MIDX and bitmap"));
>  		goto cleanup;
> +	}
>  
>  	if (load_midx_revindex(bitmap_git->midx) < 0) {
>  		warning(_("multi-pack bitmap is missing required reverse index"));
> @@ -390,7 +392,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  
>  	if (fstat(fd, &st)) {
>  		close(fd);
> -		return -1;
> +		return error_errno(_("cannot fstat bitmap file"));

Same issue here.
