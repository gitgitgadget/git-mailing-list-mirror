Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70445C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiGKLDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGKLDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:03:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38380500
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:10:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so6336497wrh.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8PUGP+lgwpcQgRLbCIQDulCMfGGWbwAAKyr25qO1xwc=;
        b=FLl6Sl+CG6czHZ4hsedP+Ef8kYmzsTnq34+uLO2dERZ19a2c8ulJ8l4zshkIdw5wUX
         3tGWbLEA1YNJSZK04cmLcdwKhS6Y2fu0CBh9OA5eafPnAA2gfwRMEMRKYvnWgYpFiBbn
         QRNwOZbsThPl+XJdXKQbBycm0YCnVwnBQfgZbZJmGo6axZYZlGaOljuNGIWaqwo0ay2s
         wzGUDNTLR4cZXwhA2CiTnDXvQt1iYPP5Q+/YAXe0rrLhBuvR6etpp0Gl0foZjxlGEsNN
         wwauwOQzxs2PEeBNDD38H4iKDaB07xJVQ0FwQtcNy8RttytjpxiCQ5ABTR0rdkoBGk0V
         LCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8PUGP+lgwpcQgRLbCIQDulCMfGGWbwAAKyr25qO1xwc=;
        b=2/4ZtUV0/L6jZoXDKdvCvdyGTNhx0sxRaSXeRaeniU6OTGHwZc9tHOUZjLuLalNTOO
         dRj4Jic1v09wh29xDqylMFNVs54TdX1/ogSw2oSXlDxC08MX7Avgu0lY2DWbKBQC9I3w
         dOKGBRC4iJ8sr0Tk/8Ki6gvkoLl6wTg0ZD9YN5/Ti/zGZX6eStDSH9xe6zL/fb5CwNsL
         SAjTML+h2fQICX382I6XmkZFhe408D6mXE3RWszQfM05BTkn7ecv9OVq9v/LetIISN0D
         /suYwopgssH/T86qGkEgz+NyOE4YV2yr1WbLrgUtOdHU8hWNjHjSfpljaABvn9GRAY5z
         d8ng==
X-Gm-Message-State: AJIora8JpX+vLtnjN0Bqh3XpORkhh6bT4EBP6IlW7jlyenlV/+pDO8q3
        FzdosX9CjiwLMmAwEUjmsHMd0oHgFUo=
X-Google-Smtp-Source: AGRyM1twCrDZF3xskuPPt5x3Y8bgV5n6YQClAThmPYH7zEKmc07OlxLlNE1HkUMvfRn1MZjx2fJugQ==
X-Received: by 2002:a5d:66c1:0:b0:21d:6c98:7aa4 with SMTP id k1-20020a5d66c1000000b0021d6c987aa4mr15790443wrw.136.1657534221352;
        Mon, 11 Jul 2022 03:10:21 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id p7-20020a05600c1d8700b0039c4d022a44sm6356757wms.1.2022.07.11.03.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:10:21 -0700 (PDT)
Message-ID: <37667911-3049-4e78-e67d-9fcb7389dfc0@gmail.com>
Date:   Mon, 11 Jul 2022 11:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] xdiff: use G[C]ALLOC_ARRAY(), not XDL_CALLOC_ARRAY()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-4.7-19567077b84-20220708T140354Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-4.7-19567077b84-20220708T140354Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
> Use the newly created GCALLOC_ARRAY() helpers rather than the recently
> introduced XDL_[C]ALLOC_ARRAY().
> 
> As shown in this diff the calling convention differs, we cannot use
> GCALLOC_ARRAY() as an expression, but that's an advantage in not
> having to relay the "sizeof()" down via a wrapper function.
> 
> This also:
> 
>   * Fixes long-standing potential overflow issues, as we're using
>     st_mult() in the underlying G_[C]ALLOC().  Note that the

What issues is this fixing? XDL_ALLOC_ARRAY() already checks for overflow.

>   * Slightly optimizes the "XDL_CALLOC_ARRAY", as we'll now use
>     calloc() rather than malloc() + memset() (although smart compilers
>     will probably do the same for both...).

That's addressed in V2 of my series, unfortunately I sent it just after 
you'd sent this series.

>   * Changes the "XDL_CALLOC_ARRAY" behavior where we'd shortcut if the
>     size was already large enough, but this behavior was changed when
>     XDL_ALLOC_ARRAY() was introduced, so this is safe.

I'm not sure what you mean here - how did we shortcut before?

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   xdiff/xdiffi.c     |  3 ++-
>   xdiff/xhistogram.c |  9 ++++++---
>   xdiff/xmacros.h    | 12 ------------
>   xdiff/xpatience.c  |  6 ++++--
>   xdiff/xprepare.c   | 24 ++++++++++++++++--------
>   5 files changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 6fded43e87d..077cc456087 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -333,7 +333,8 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   	 * One is to store the forward path and one to store the backward path.
>   	 */
>   	ndiags = xe->xdf1.nreff + xe->xdf2.nreff + 3;
> -	if (!XDL_ALLOC_ARRAY(kvd, 2 * ndiags + 2))
> +	GALLOC_ARRAY(kvd, 2 * ndiags + 2);
> +	if (!kvd)
>   		return -1;
>   	kvdf = kvd;
>   	kvdb = kvdf + ndiags;
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index df909004c10..f20592bfbdd 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -266,14 +266,17 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
>   
>   	index.table_bits = xdl_hashbits(count1);
>   	index.records_size = 1 << index.table_bits;
> -	if (!XDL_CALLOC_ARRAY(index.records, index.records_size))
> +	GCALLOC_ARRAY(index.records, index.records_size);
> +	if (!index.records)

I don't think that having GALLOC_ARRAY() as a statement is an 
improvement here.

Best Wishes

Phillip

>   		goto cleanup;
>   
>   	index.line_map_size = count1;
> -	if (!XDL_CALLOC_ARRAY(index.line_map, index.line_map_size))
> +	GCALLOC_ARRAY(index.line_map, index.line_map_size);
> +	if (!index.line_map)
>   		goto cleanup;
>   
> -	if (!XDL_CALLOC_ARRAY(index.next_ptrs, index.line_map_size))
> +	GCALLOC_ARRAY(index.next_ptrs, index.line_map_size);
> +	if (!index.next_ptrs)
>   		goto cleanup;
>   
>   	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
> diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
> index d13a6724629..75506bdf17e 100644
> --- a/xdiff/xmacros.h
> +++ b/xdiff/xmacros.h
> @@ -49,18 +49,6 @@ do { \
>   		((unsigned long) __p[2]) << 16 | ((unsigned long) __p[3]) << 24; \
>   } while (0)
>   
> -/* Allocate an array of nr elements, returns NULL on failure */
> -#define XDL_ALLOC_ARRAY(p, nr)				\
> -	((p) = SIZE_MAX / sizeof(*(p)) >= (size_t)(nr)	\
> -		? xdl_malloc((nr) * sizeof(*(p)))	\
> -		: NULL)
> -
> -/* Allocate an array of nr zeroed out elements, returns NULL on failure */
> -#define XDL_CALLOC_ARRAY(p, nr)				\
> -	(XDL_ALLOC_ARRAY((p), (nr))			\
> -		? memset((p), 0, (nr) * sizeof(*(p)))	\
> -		: NULL)
> -
>   /*
>    * Ensure array p can accommodate at least nr elements, growing the
>    * array and updating alloc (which is the number of allocated
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index fe39c2978cb..bb328d9f852 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -151,7 +151,8 @@ static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
>   
>   	/* We know exactly how large we want the hash map */
>   	result->alloc = count1 * 2;
> -	if (!XDL_CALLOC_ARRAY(result->entries, result->alloc))
> +	GCALLOC_ARRAY(result->entries, result->alloc);
> +	if (!result->entries)
>   		return -1;
>   
>   	/* First, fill with entries from the first file */
> @@ -208,7 +209,8 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
>   	 */
>   	int anchor_i = -1;
>   
> -	if (!XDL_ALLOC_ARRAY(sequence, map->nr))
> +	GALLOC_ARRAY(sequence, map->nr);
> +	if (!sequence)
>   		return -1;
>   
>   	for (entry = map->first; entry; entry = entry->next) {
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index c84549f6c50..d6cbee32a2a 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -78,15 +78,17 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
>   
>   		return -1;
>   	}
> -	if (!XDL_CALLOC_ARRAY(cf->rchash, cf->hsize)) {
> +	GCALLOC_ARRAY(cf->rchash, cf->hsize);
> +	if (!cf->rchash) {
>   
>   		xdl_cha_free(&cf->ncha);
>   		return -1;
>   	}
>   
>   	cf->alloc = size;
> -	if (!XDL_ALLOC_ARRAY(cf->rcrecs, cf->alloc)) {
>   
> +	GALLOC_ARRAY(cf->rcrecs, cf->alloc);
> +	if (!cf->rcrecs) {
>   		xdl_free(cf->rchash);
>   		xdl_cha_free(&cf->ncha);
>   		return -1;
> @@ -170,12 +172,14 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   
>   	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
>   		goto abort;
> -	if (!XDL_ALLOC_ARRAY(recs, narec))
> +	GALLOC_ARRAY(recs, narec);
> +	if (!recs)
>   		goto abort;
>   
>   	hbits = xdl_hashbits((unsigned int) narec);
>   	hsize = 1 << hbits;
> -	if (!XDL_CALLOC_ARRAY(rhash, hsize))
> +	GCALLOC_ARRAY(rhash, hsize);
> +	if (!rhash)
>   		goto abort;
>   
>   	nrec = 0;
> @@ -196,14 +200,17 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   		}
>   	}
>   
> -	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
> +	GCALLOC_ARRAY(rchg, nrec + 2);
> +	if (!rchg)
>   		goto abort;
>   
>   	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
>   	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
> -		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
> +		GALLOC_ARRAY(rindex, nrec + 1);
> +		if (!rindex)
>   			goto abort;
> -		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
> +		GALLOC_ARRAY(ha, nrec + 1);
> +		if (!ha)
>   			goto abort;
>   	}
>   
> @@ -369,7 +376,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	xdlclass_t *rcrec;
>   	char *dis, *dis1, *dis2;
>   
> -	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
> +	GCALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2);
> +	if (!dis)
>   		return -1;
>   	dis1 = dis;
>   	dis2 = dis1 + xdf1->nrec + 1;

