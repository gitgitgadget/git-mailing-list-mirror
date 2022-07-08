Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C8C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 17:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbiGHRmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiGHRmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 13:42:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE756B24E
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 10:42:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so31501207wrc.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wkmXQr8HXnJBw2qKN8krusYPIwnG03RNH19r3V3e13E=;
        b=ocSvVeif4L4hTmkC3uB6yQCFbBQD3Qm2TY0bEnpe7n46QNmoLO8TiSc3VSrmUJZisq
         71mCTD+AxqLSXBF3z1W72ri+qIoF9+bis1euOmsULpDtvaGp2UOfhZF7FnbOAjeC0Bbs
         4tr/qBSqiCjqJW5halx+Tmgg0r8IInI31T7OTK3lSLHOizdSPbDBx/qLPI81sm70LjKw
         FEgVeuONJswftjIi+fO2Vzr7Xh7QktDoRfaoH2w/b0RFx9lJ3qwhq1kd7dVurn28sD6e
         oR8nQdDjMTz4ViR/THaTIGSU7G82hClnoBMYP/pVDbTd1D7b4A+LQqJJpq/n8RM5PA9z
         HS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wkmXQr8HXnJBw2qKN8krusYPIwnG03RNH19r3V3e13E=;
        b=PU2Og9dFlkiW4Y1IU3NVlZdb0DA4MVhVdxCTJWktCBIH+TbKxw18kRv9klTV47Aa5V
         DL7iesjLqLu//a2RRRHDFZLM15RqqidRCY0/GsQAQtpj4W/cBognHKcxLdaAjaXFy2VP
         +t00JNLUTCj/SBS78GFxYKWYHoutTmi81S8vjqOTVOurN/QSFf4XQd1R3dSoveIM+oMl
         8OWfRRB1iSMoNtRdBJnMbNgar2lEUVz+QbEgrhmU/zmVq6oOJNgUPPnTgWAUpw9fGGJa
         F1Z3VXSdGAn4brBMIQNhzWVOwm6fs3b+kH1YWDX0CDskhCl2csL+NALVYPwxH9EMPBgS
         olaw==
X-Gm-Message-State: AJIora88LpM1tmjEQOqWj6WENlun+twrnIGh64RJKWwJxo5VZUO+CAmP
        0fROryPBlnsz1hjUsAHhAceaKQEW32Q=
X-Google-Smtp-Source: AGRyM1tS+R6Qy4qPfLP3i/loV3rGRtrONGHTtSRbuAs6bF2nRwdimqICd11mIydVB8l1bBsE8tWa5A==
X-Received: by 2002:adf:dc0d:0:b0:21d:ea5:710f with SMTP id t13-20020adfdc0d000000b0021d0ea5710fmr4412559wri.48.1657302140692;
        Fri, 08 Jul 2022 10:42:20 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id q123-20020a1c4381000000b00397402ae674sm42189wma.11.2022.07.08.10.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 10:42:20 -0700 (PDT)
Message-ID: <1bf5d574-4202-31e3-4dc3-d7890465d28f@gmail.com>
Date:   Fri, 8 Jul 2022 18:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/7] xdiff: remove xdl_malloc() wrapper, use malloc(), not
 xmalloc()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
> As noted in 36c83197249 (xdiff: use xmalloc/xrealloc, 2019-04-11) the
> reason we have xdl_malloc() in the first place was to make the xdiff
> code safer, it was not handling some allocation failures correctly at
> the time.

This is untrue, we do not have xdl_malloc to make the xdiff code safer, 
that macro was introduced with the initial import of xdiff. 36c83197249 
  just changed its definition, the entire commit consists of

-#define xdl_malloc(x) malloc(x)
+#define xdl_malloc(x) xmalloc(x)
  #define xdl_free(ptr) free(ptr)
-#define xdl_realloc(ptr,x) realloc(ptr,x)
+#define xdl_realloc(ptr,x) xrealloc(ptr,x)

I can see the argument for reverting that change now that we have fixed 
the error checking but that is not a good reason to remove xdl_malloc().

Best Wishes

Phillip

> But as noted in that commit doing this was intended as a stopgap, as
> various code in xdiff/* did not correctly handle allocation failures,
> and would have segfaulted if malloc() returned NULL.
> 
> But since then and after preceding commits we can be confident that
> malloc() failures are handled correctly. All of these users of
> xdl_malloc() are checking their return values, and we're returning
> -1 (or similar ) to the top-level in case of failures.
> 
> This also has the big advantage of making the compiler and analysis
> tools less confused, and potentially avoiding undefined (compiler)
> behavior. I.e. we define our own xmalloc() to call die() on failure,
> and that function uses the non-standard "noreturn" attribute on our
> most common compiler targets.
> 
> But xdl_malloc()'s use conflicted with that, confusing both human
> readers of this code, and potentially compilers as well.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   xdiff/xdiff.h  |  1 -
>   xdiff/xdiffi.c |  2 +-
>   xdiff/xmerge.c | 10 +++++-----
>   xdiff/xutils.c |  2 +-
>   4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 832cf9d977e..df048e0099b 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -119,7 +119,6 @@ typedef struct s_bdiffparam {
>   } bdiffparam_t;
>   
>   
> -#define xdl_malloc(x) xmalloc(x)
>   #define xdl_free(ptr) free(ptr)
>   
>   void *xdl_mmfile_first(mmfile_t *mmf, long *size);
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 077cc456087..6590811634f 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -368,7 +368,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2) {
>   	xdchange_t *xch;
>   
> -	if (!(xch = (xdchange_t *) xdl_malloc(sizeof(xdchange_t))))
> +	if (!(xch = (xdchange_t *) malloc(sizeof(xdchange_t))))
>   		return NULL;
>   
>   	xch->next = xscr;
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index ac0cf52f3be..676ad39020d 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -60,7 +60,7 @@ static int xdl_append_merge(xdmerge_t **merge, int mode,
>   		m->chg1 = i1 + chg1 - m->i1;
>   		m->chg2 = i2 + chg2 - m->i2;
>   	} else {
> -		m = xdl_malloc(sizeof(xdmerge_t));
> +		m = malloc(sizeof(xdmerge_t));
>   		if (!m)
>   			return -1;
>   		m->next = NULL;
> @@ -409,7 +409,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>   		m->i2 = xscr->i2 + i2;
>   		m->chg2 = xscr->chg2;
>   		while (xscr->next) {
> -			xdmerge_t *m2 = xdl_malloc(sizeof(xdmerge_t));
> +			xdmerge_t *m2 = malloc(sizeof(xdmerge_t));
>   			if (!m2) {
>   				xdl_free_env(&xe);
>   				xdl_free_script(x);
> @@ -670,7 +670,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>   						 ancestor_name,
>   						 favor, changes, NULL, style,
>   						 marker_size);
> -		result->ptr = xdl_malloc(size);
> +		result->ptr = malloc(size);
>   		if (!result->ptr) {
>   			xdl_cleanup_merge(changes);
>   			return -1;
> @@ -718,14 +718,14 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>   	}
>   	status = 0;
>   	if (!xscr1) {
> -		result->ptr = xdl_malloc(mf2->size);
> +		result->ptr = malloc(mf2->size);
>   		if (!result->ptr)
>   			goto out;
>   		status = 0;
>   		memcpy(result->ptr, mf2->ptr, mf2->size);
>   		result->size = mf2->size;
>   	} else if (!xscr2) {
> -		result->ptr = xdl_malloc(mf1->size);
> +		result->ptr = malloc(mf1->size);
>   		if (!result->ptr)
>   			goto out;
>   		status = 0;
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index c0cd5338c4e..865e08f0e93 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -98,7 +98,7 @@ void *xdl_cha_alloc(chastore_t *cha) {
>   	void *data;
>   
>   	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
> -		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
> +		if (!(ancur = (chanode_t *) malloc(sizeof(chanode_t) + cha->nsize))) {
>   
>   			return NULL;
>   		}

