Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5AC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 13:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840512072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 13:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+vclHAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKKNxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgKKNxE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 08:53:04 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E14C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 05:53:03 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id e5so897334qvs.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 05:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/MtZQEyqcmUm4S/xTsvsRatbG2aFEPaihnx3iAPbwH8=;
        b=k+vclHAejOWs3+AakSucaciN/k3XZZtFP8epQa+1wsmr6EpSuwGQDuSgdkweZ+ixFH
         g7IVUNfg0s+HgjssSh3zKwFPictEw5DkV5pKgvCy9RkfIyNcE7Jtweoo2g7/hLfFd2gl
         E/7UQUAkMvQsNXosSnOQsUaWLB7LDNvynS64cVdNy4Q92KBU83FCBTTFB9XVblQasVXg
         aGUY7tbaqObJZax8F497vQfp8YWRd3ys9w7dtG8pPmSfNuvPMFBUSNOMMiI64cQMwRZW
         bLycjaBdTpQ1ztu+pu7jPhNv31akysqrpwocR4/yI6hsFoOrOlbbXrnRBepRtS2wy6df
         UX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/MtZQEyqcmUm4S/xTsvsRatbG2aFEPaihnx3iAPbwH8=;
        b=a1jSUgZaQJLfI9u9i1tcuvhfs+hPJVIe7wMECiQLVsw6+NjstZvC3nyJIb8n8BeI/i
         nfF5o3w3l6GxwLkwbjN0tGg+LG25CmBGjKWsnU1xQsQUHy8YDmTri/LyDaqB/pljDaSn
         fBRquL0FlB4wtjWJr804uwmG9hqrkapxYYXUykEximnOopdDv/qlNw3GAVHczaMKnBMB
         Dr+LNKMXaqm+YPXE8lQGRaK3C6wRfQOs1MYRl/gyYSQ5Khn/TQHhuGPc/o3rJ6YsFcu6
         aYah0c3byNiGQGFEKsxMlVKx4hJlOjMO6MimeE7lIH3kP38V29MMNBQMmc6s6uoPicuU
         FxbQ==
X-Gm-Message-State: AOAM530EgsppAel0M8XbcidIyeQjkkmMfGaSQDRDz42v7f4tzVdRB5tb
        dwlinZP82K2a599/k9jqWxxaauMQyF+qow==
X-Google-Smtp-Source: ABdhPJwxm9V4qKjCfIWQxfhu07mke7WSknMjN7EVgAEwIFGVTKzEFG0TemUp8SFxvbBs2RTePq+Rtw==
X-Received: by 2002:a0c:aedf:: with SMTP id n31mr19118232qvd.31.1605102781936;
        Wed, 11 Nov 2020 05:53:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d86f:4f77:7172:19ff? ([2600:1700:e72:80a0:d86f:4f77:7172:19ff])
        by smtp.gmail.com with UTF8SMTPSA id l79sm2247813qke.1.2020.11.11.05.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 05:53:00 -0800 (PST)
Subject: Re: [PATCH v2 03/20] merge-ort: port merge_start() from
 merge-recursive
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-4-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3f1cd4b6-695d-7524-4cb7-7c31f370fe36@gmail.com>
Date:   Wed, 11 Nov 2020 08:52:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-4-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> merge_start() basically does a bunch of sanity checks, then allocates
> and initializes opt->priv -- a struct merge_options_internal.
> 
> Most the sanity checks are usable as-is.  The allocation/intialization

s/Most the/Most of the/

> The weirdest part here is that merge-ort and merge-recursive use the
> same struct merge_options, even though merge_options has a number of
> fields that are oddly specific to merge-recursive's internal
> implementation and don't even make sense with merge-ort's high-level
> design (e.g. buffer_output, which merge-ort has to always do).  I reused
> the same data structure because:
>   * most the fields made sense to both merge algorithms
>   * making a new struct would have required making new enums or somehow
>     externalizing them, and that was getting messy.
>   * it simplifies converting the existing callers by not having to
>     have different code paths for merge_options setup.

I think this is appropriate. The other option would be to split the
struct into "common options" and "specific options" but that starts
to get messy if we add yet another merge strategy that changes what
should be "common". Hopefully we can group options within the struct
merge_options definition to assist with this?

For now, the assertions are a good approach.

> I also marked detect_renames as ignored.  We can revisit that later, but
> in short: merge-recursive allowed turning off rename detection because
> it was sometimes glacially slow.  When you speed something up by a few
> orders of magnitude, it's worth revisiting whether that justification is
> still relevant.  Besides, if folks find it's still too slow, perhaps
> they have a better scaling case than I could find and maybe it turns up
> some more optimizations we can add.  If it still is needed as an option,
> it is easy to add later.

As long as it is easy to add later, I don't see much of a problem. Usually
adding a knob to disable a feature is necessary to mitigate risk, and here
we can simply adjust config to use the non-ort algorithm if we notice a data
shape where rename detection makes the algorithm slow/unusable.

>  static void merge_start(struct merge_options *opt, struct merge_result *result)
>  {
> -	die("Not yet implemented.");
> +	/* Sanity checks on opt */
> +	assert(opt->repo);
> +
> +	assert(opt->branch1 && opt->branch2);
> +
> +	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
> +	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
> +	assert(opt->rename_limit >= -1);
> +	assert(opt->rename_score >= 0 && opt->rename_score <= MAX_SCORE);
> +	assert(opt->show_rename_progress >= 0 && opt->show_rename_progress <= 1);
> +
> +	assert(opt->xdl_opts >= 0);
> +	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
> +	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
> +
> +	/*
> +	 * detect_renames, verbosity, buffer_output, and obuf are ignored
> +	 * fields that were used by "recursive" rather than "ort" -- but
> +	 * sanity check them anyway.
> +	 */
> +	assert(opt->detect_renames >= -1 &&
> +	       opt->detect_renames <= DIFF_DETECT_COPY);
> +	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
> +	assert(opt->buffer_output <= 2);
> +	assert(opt->obuf.len == 0);
> +
> +	assert(opt->priv == NULL);
> +
> +	/* Initialization of opt->priv, our internal merge data */
> +	opt->priv = xcalloc(1, sizeof(*opt->priv));

nit: I would insert an empty line between this code and the
multi-line comment below.

> +	/*
> +	 * Although we initialize opt->priv->paths with strdup_strings=0,
> +	 * that's just to avoid making yet another copy of an allocated
> +	 * string.  Putting the entry into paths means we are taking
> +	 * ownership, so we will later free it.
> +	 *
> +	 * In contrast, unmerged just has a subset of keys from paths, so
> +	 * we don't want to free those (it'd be a duplicate free).
> +	 */
> +	strmap_init_with_options(&opt->priv->paths, NULL, 0);
> +	strmap_init_with_options(&opt->priv->unmerged, NULL, 0);
>  }

This approach looks fine to me.

Thanks,
-Stolee

