Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF935C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94B623B85
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgLIWeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbgLIWZo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 17:25:44 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00520C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 14:25:03 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so2996892otl.11
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 14:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PsrUdENnUX6iuYsbrla7YaJmECsAlXfyKjXaPvzR4ew=;
        b=WFDQ+LkZ8OEUI2N3qQOd7qFgjDLsGashgWbdx2p3Nv6ybWzdh6MsarVNygfLW5WDgx
         ykeAJle3auOmDV/wh+kwYSjWeUqAVJSzBKoooZRZNcJxlYmc914d/4NNdrduvliacxrl
         pYbvb+iqvDsua96bs4TxeKqaEEPkdpHZ1yXEouC1E9jR8vuB5dcdlkU5OerSWsZLdtBB
         ATOWz5hDdoimSbg1NuXwtlFkJo5ymEsJPO60XfCevoI2WQsAI3/XimWrnWmb1TFx+kMY
         aERWXwCbYy35sFLmwsLC2VdB5Pp8XH+CO5ynx2cAMph5gseO/d6k8m9tQ7aOpWRDlMru
         i+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PsrUdENnUX6iuYsbrla7YaJmECsAlXfyKjXaPvzR4ew=;
        b=bH1vH1tg/3brEJhwMYppXgn3psLFvvLaPcG2ZyukEi/qwnsu/Gvv1SHP0ieBPhoFq6
         tBnFuYD+n1kgNGpAxIxQc9zOJyh6EeTaMIhbuBI8xAW9VBTqGbKKQGNJ6jlcJWiuiKk+
         CZzfDZty4Rsv8uu5sFP+zAocJP86F23jcNq7NRrzQdZn/X2cZmeOHc4CSlhR/mX1vJvb
         jQPm8X+qG/JVZK8hB4E/1MHP+dypXOjwi0zq18UgJIM7tlhXCC0TWpD153Z8YDdaQcIV
         FcB9YzAEGBLi5rPbOxqjl1jczOWVg8G+227YKn682lCct+pwlBPhk9+sn+sAhwXTsjiq
         K9zg==
X-Gm-Message-State: AOAM532sywRI1Le6o9lgK1d62Rl+nc6TknXVyguBQZ+JNdnXD2Htrj5C
        ZLVk/VpnTt2Pak1IX9uWtEilArEbdVZ3SKDv
X-Google-Smtp-Source: ABdhPJwdLUw9UPTlSetWTClnek4ykilDYyGvMosaCVKYXynmatxoI6gfcf6NG5QQXnMyD6cmuJt+Mw==
X-Received: by 2002:a9d:65d7:: with SMTP id z23mr3722935oth.131.1607552703317;
        Wed, 09 Dec 2020 14:25:03 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m109sm665615otc.30.2020.12.09.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:25:02 -0800 (PST)
Date:   Wed, 9 Dec 2020 17:24:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] diffcore-rename: reduce jumpiness in progress
 counters
Message-ID: <X9FOtEiN7C7cp+KS@nand.local>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <e8257516c1f983d590b8a81fb32ecd5cb91dc737.1607223276.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8257516c1f983d590b8a81fb32ecd5cb91dc737.1607223276.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 06, 2020 at 02:54:34AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> Inexact rename detection works by comparing all sources to all
> destinations, computing similarities, and then finding the best matches
> among those that are sufficiently similar.
>
> However, it is preceded by exact rename detection that works by
> checking if there are files with identical hashes.  If exact renames are
> found, we can exclude some files from inexact rename detection.
>
> The inexact rename detection loops over the full set of files, but
> immediately skips those for which rename_dst[i].is_rename is true and
> thus doesn't compare any sources to that destination.  As such, these
> paths shouldn't be included in the progress counter.
>
> For the eagle eyed, this change hints at an actual optimization -- the
> first one I presented at Git Merge 2020.  I'll be submitting that
> optimization later, once the basic merge-ort algorithm has merged.

;-) I was hoping that that was the case.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diffcore-rename.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 7270eb6af48..3d637ba4645 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -587,7 +587,7 @@ void diffcore_rename(struct diff_options *options)
>  	if (options->show_rename_progress) {
>  		progress = start_delayed_progress(
>  				_("Performing inexact rename detection"),
> -				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
> +				(uint64_t)num_targets * (uint64_t)rename_src_nr);
>  	}
>
>  	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_targets), sizeof(*mx));
> @@ -626,7 +626,8 @@ void diffcore_rename(struct diff_options *options)
>  			diff_free_filespec_blob(two);
>  		}
>  		dst_cnt++;
> -		display_progress(progress, (uint64_t)(i+1)*(uint64_t)rename_src_nr);
> +		display_progress(progress,
> +				 (uint64_t)dst_cnt * (uint64_t)rename_src_nr);

Both of these spots need only one cast, but the patch itself looks
correct (with or without dropping a cast on one of the operands in each
expression).

Thanks,
Taylor
