Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F24C433E0
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD772186A
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 15:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpTz+FZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgF0Pxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgF0Pxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jun 2020 11:53:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA39C061794
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 08:53:52 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so2551161edz.12
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DwOcwBrLukgG7VXM7JbW9jD6yPPWBDDduqOhsSQKNf4=;
        b=XpTz+FZIMTTn4lDMnuoBG0l2GumrUGtZHAnQwZ+2LapuDsNQWed5t8Tyb87nwHW/JD
         eeYILYbKsscQ2qmlcXZ+O8yvQziTbwbZ1VQlDBKSLKP2qm9n/8hQNKvD51yaPxparur6
         LCz3CmAB+wRjBMT+M/OFwXYolZ9MdyI3Usu8rUilEgIRJVp3p5+ZdalzzYDyh1r+SoIF
         FMYJrEmpC6tQknwzWmqE3tTnKu+pIO4BTG9P3QqTqECqxfKAUDCpO58+AwQw1z3yGUEi
         vmj8kv8RPzwbY4Yr9shb/wCi0Gz2ulaVOkzQ+e86/2E1drwwnoC3DsAysULsqGBmMMxY
         e7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DwOcwBrLukgG7VXM7JbW9jD6yPPWBDDduqOhsSQKNf4=;
        b=LHni3o5te62q4yfuk1Zm/yLoi64860ZBxiGmi0QgG/H1FQqz3qRxv+n0u5iEEdie2d
         NfKAigHgeAC+W5igSXeNSSvrrz9ASH9T69uerAn99ALTjVibSN+WuSSdC4ryWIGFRxR5
         6Q5KRASJasOfvtQth5Fl8bnQU7QTC7uHE6EUfsvnFOQWxTYQEsrNOF2749tofee2Keit
         Hm0+WqlS2sB9a6Ha1KI4qfce7PE/dn7B6yIQ7cylZCrekFxiNl+jfyHGNQQ9yaIzKvrQ
         7Ft5k7k0kjydQR+b5rNjZK+tC39U4cFToQRvf3borN3pqL+fRWz/egPzAwN6WRCoZdpj
         yocg==
X-Gm-Message-State: AOAM5303f526otHXGU9e0zpi+cogYZC5XHeCpna2Ip8UClLcLSaCfcc8
        36Mg17HyB9/qofB5xKUwmzI=
X-Google-Smtp-Source: ABdhPJzUprHULFlzO+ut9W9jBDNNlHQwvoc9TTh3Mmz6eljbD4cBiTpKfe9vQuhEuTu/WyEvNxBZFw==
X-Received: by 2002:a05:6402:1b94:: with SMTP id cc20mr8868251edb.177.1593273231167;
        Sat, 27 Jun 2020 08:53:51 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id a1sm15011128ejk.125.2020.06.27.08.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 08:53:50 -0700 (PDT)
Date:   Sat, 27 Jun 2020 17:53:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/10] commit-slab: add a function to deep free entries
 on the slab
Message-ID: <20200627155348.GM2898@szeder.dev>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
 <32a6f11cc475f5292075093dcdc3b2a5c6d02ed0.1591362033.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32a6f11cc475f5292075093dcdc3b2a5c6d02ed0.1591362033.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 05, 2020 at 01:00:26PM +0000, SZEDER Gábor via GitGitGadget wrote:
> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
> 
> clear_##slabname() frees only the memory allocated for a commit slab
> itself, but entries in the commit slab might own additional memory
> outside the slab that should be freed as well.  We already have (at
> least) one such commit slab, and this patch series is about to add one
> more.

This was only true in my original submission, but not anymore: this
patch series doesn't add another such slab, and, more importantly, now
we have at least two such commit slabs.  deep_clear_##slabnmae() could
be used to clear the bloom_filter_slab and all memory attached to it,
which at the moment is just leaked.

> To free all additional memory owned by entries on the commit slab the
> user of such a slab could iterate over all commits it knows about,
> peek whether there is a valid entry associated with each commit, and
> free the additional memory, if any.  Or it could rely on intimate
> knowledge about the internals of the commit slab implementation, and
> could itself iterate directly through all entries in the slab, and
> free the additional memory.  Or it could just leak the additional
> memory...
> 
> Introduce deep_clear_##slabname() to allow releasing memory owned by
> commit slab entries by invoking the 'void free_fn(elemtype *ptr)'
> function specified as parameter for each entry in the slab.
> 
> Use it in get_shallow_commits() in 'shallow.c' to replace an
> open-coded iteration over a commit slab's entries.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-slab-decl.h |  1 +
>  commit-slab-impl.h | 13 +++++++++++++
>  commit-slab.h      | 10 ++++++++++
>  shallow.c          | 14 +++++---------
>  4 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/commit-slab-decl.h b/commit-slab-decl.h
> index adc7b46c83b..286164b7e27 100644
> --- a/commit-slab-decl.h
> +++ b/commit-slab-decl.h
> @@ -32,6 +32,7 @@ struct slabname {							\
>  void init_ ##slabname## _with_stride(struct slabname *s, unsigned stride); \
>  void init_ ##slabname(struct slabname *s);				\
>  void clear_ ##slabname(struct slabname *s);				\
> +void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(elemtype *ptr)); \
>  elemtype *slabname## _at_peek(struct slabname *s, const struct commit *c, int add_if_missing); \
>  elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
>  elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
> diff --git a/commit-slab-impl.h b/commit-slab-impl.h
> index 5c0eb91a5d1..557738df271 100644
> --- a/commit-slab-impl.h
> +++ b/commit-slab-impl.h
> @@ -38,6 +38,19 @@ scope void clear_ ##slabname(struct slabname *s)			\
>  	FREE_AND_NULL(s->slab);						\
>  }									\
>  									\
> +scope void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(elemtype *)) \
> +{									\
> +	unsigned int i;							\
> +	for (i = 0; i < s->slab_count; i++) {				\
> +		unsigned int j;						\
> +		if (!s->slab[i])					\
> +			continue;					\
> +		for (j = 0; j < s->slab_size; j++)			\
> +			free_fn(&s->slab[i][j * s->stride]);		\
> +	}								\
> +	clear_ ##slabname(s);						\
> +}									\
> +									\
>  scope elemtype *slabname## _at_peek(struct slabname *s,			\
>  						  const struct commit *c, \
>  						  int add_if_missing)   \
> diff --git a/commit-slab.h b/commit-slab.h
> index 05b3f2804e7..8e72a305365 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -47,6 +47,16 @@
>   *
>   *   Call this function before the slab falls out of scope to avoid
>   *   leaking memory.
> + *
> + * - void deep_clear_indegree(struct indegree *, void (*free_fn)(int*))
> + *
> + *   Empties the slab, similar to clear_indegree(), but in addition it
> + *   calls the given 'free_fn' for each slab entry to release any
> + *   additional memory that might be owned by the entry (but not the
> + *   entry itself!).
> + *   Note that 'free_fn' might be called even for entries for which no
> + *   indegree_at() call has been made; in this case 'free_fn' is invoked
> + *   with a pointer to a zero-initialized location.
>   */
>  
>  #define define_commit_slab(slabname, elemtype) \
> diff --git a/shallow.c b/shallow.c
> index 7fd04afed19..c4ac8a73273 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -84,6 +84,10 @@ int is_repository_shallow(struct repository *r)
>   * supports a "valid" flag.
>   */
>  define_commit_slab(commit_depth, int *);
> +static void free_depth_in_slab(int **ptr)
> +{
> +	FREE_AND_NULL(*ptr);
> +}
>  struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  		int shallow_flag, int not_shallow_flag)
>  {
> @@ -150,15 +154,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  			}
>  		}
>  	}
> -	for (i = 0; i < depths.slab_count; i++) {
> -		int j;
> -
> -		if (!depths.slab[i])
> -			continue;
> -		for (j = 0; j < depths.slab_size; j++)
> -			free(depths.slab[i][j]);
> -	}
> -	clear_commit_depth(&depths);
> +	deep_clear_commit_depth(&depths, free_depth_in_slab);
>  
>  	return result;
>  }
> -- 
> gitgitgadget
> 
