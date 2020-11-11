Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B66C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3045A20809
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 13:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3rzlw6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKKN6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgKKN6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 08:58:34 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6AAC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 05:58:34 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id f16so2166294otl.11
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OZywLo4NGuU0nFp5obQYAjLX/ce1fEYkLT1QC8UDjM8=;
        b=W3rzlw6rVJ8fvbpR4ROlwUl/p7g8HEpNpO5vLl+Wig4BxSRdDJTglqsAA52NkNgQ8O
         XYd4UVmWuzSmKyOW3eRWlZfQKLvVF4ReJ6Wv3U4qxgO+kt0aEoFY2JFwT1HaoYSwBBvU
         gh37EdBa9G/5l856iLMKA72zXM5rGWC1HxuMvdXyj+fsdadLcP1MOO6POTy1SH+SbJdl
         E9OeXLGnUCyM7BqiYFwYvJ1yWoST3pStotl0LhQ0QkRGgRNUPiuNqa89i6wvFlt1G56t
         +63EabcMHxsw7sGMAoDhDX9KaVp/c6pneBz0yLiqBT+F4A6Ao0JS5CD/TE8xfP/9Wleq
         s6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZywLo4NGuU0nFp5obQYAjLX/ce1fEYkLT1QC8UDjM8=;
        b=a8/WEE7bu5bnCYlr/AALc1doGWJaqafCcr1q5sP1P8oPXRJrH5rwp8FBsojpuaNrkV
         fjxbatvF6rRd54OT8agEj+2odut1KdIanvFyAD59USGim23x5ix2DrG9GjqSpGNWq3s9
         GlR1H+pMGc8ZkXB84VJFfR78PGwYxg/EUuFuIzcKCgODKnWo6hmaDnX2nhLcjWewtRqt
         fVT+N69F5KP2JXrALwXGAr1j0e98a5Wt5grN51Uh/Ik3fopbBdzoQl6h1+8dXxiM6HtA
         VNhBWNWj5EA7sj18Mtrope17aQDm7aTus7LWWSnGySOdlYa3EUXhwcyYUiPZnpBRVU2y
         9W7w==
X-Gm-Message-State: AOAM531cGqk1TgWBzJCPRvGz4CIITwj9A+eojhl43O4dAcNl6jD96414
        i63Dpt+sIX7G/Car/oAbuHM=
X-Google-Smtp-Source: ABdhPJx1X7DldNpnGEdL+iNLEzmkTlT+PKcghb5BKP2qogfkaGCz8COZG9foCaej5cuQo2z9FgpeHw==
X-Received: by 2002:a9d:62c9:: with SMTP id z9mr18074671otk.18.1605103113243;
        Wed, 11 Nov 2020 05:58:33 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d86f:4f77:7172:19ff? ([2600:1700:e72:80a0:d86f:4f77:7172:19ff])
        by smtp.gmail.com with UTF8SMTPSA id k11sm508557otr.14.2020.11.11.05.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 05:58:32 -0800 (PST)
Subject: Re: [PATCH v2 05/20] merge-ort: add an err() function similar to one
 from merge-recursive
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-6-newren@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <267dbe58-e319-0904-3552-bf56530181c3@gmail.com>
Date:   Wed, 11 Nov 2020 08:58:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-6-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> Various places in merge-recursive used an err() function when it hit
> some kind of unrecoverable error.  That code was from the reusable bits
> of merge-recursive.c that we liked, such as merge_3way, writing object
> files to the object store, reading blobs from the object store, etc.  So
> create a similar function to allow us to port that code over, and use it
> for when we detect problems returned from collect_merge_info()'s
> traverse_trees() call, which we will be adding next.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index df97a54773..537da9f6df 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -61,11 +61,28 @@ struct conflict_info {
>  	unsigned match_mask:3;
>  };
>  
> +static int err(struct merge_options *opt, const char *err, ...)
> +{
> +	va_list params;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addstr(&sb, "error: ");
> +	va_start(params, err);
> +	strbuf_vaddf(&sb, err, params);
> +	va_end(params);
> +
> +	error("%s", sb.buf);
> +	strbuf_release(&sb);
> +
> +	return -1;
> +}
> +

This seems simple enough to have a duplicate copy lying
around. Do you anticipate that all common code will live
in the same file eventually? Or will these two static err()
method always be duplicated?

Aside: I wonder if these errors could be logged using trace2
primitives, to assist diagnosing problems with merges. CC'ing
Jeff Hostetler if he has an opinion.

>  static int collect_merge_info(struct merge_options *opt,
>  			      struct tree *merge_base,
>  			      struct tree *side1,
>  			      struct tree *side2)
>  {
> +	/* TODO: Implement this using traverse_trees() */
>  	die("Not yet implemented.");
>  }

This comment looks to be applied to the wrong patch.

Thanks,
-Stolee
