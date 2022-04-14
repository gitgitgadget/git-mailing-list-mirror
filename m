Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23005C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244358AbiDNS7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiDNS7s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 14:59:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E2186E9
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:57:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q12so5514141pgj.13
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OHmDLHlB7FOjxaiTd4IoNW7NhiZtPPmEwtBFOlxymo=;
        b=jzhdMR+37v5LGzNc7MDOG3x7D3frPVSI38NaV9WcLtpDkPqgQdh2pee99TIUp2tmdp
         HoKH0OVbvj/5miH06XPXqUHYHcNCOmeu1zlWu34hZNFx+ujK3lYNE51ao3o9ZoCusalb
         tN4tCIOYi5HdlRPeCqy3dV71IYapBRwCAqXdyz9iurm5iWZZgMxppcDMcl9KIHaOFHZ8
         7HZqIwaRyUKekDlgVkFBxmD9WD8Rr1PlFtCOwoUaCfPGegnBViEWUT8szndjpPMzG2Aa
         tkHgD4pVMpJdLk6y6bfXoogwsl8+13a/i2CWiKcCfV+BPALxyTbbi0LO/P2KU4yvCxhi
         izwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9OHmDLHlB7FOjxaiTd4IoNW7NhiZtPPmEwtBFOlxymo=;
        b=sbzCqYS8SQde3p61xxtkK82Qd/Hm6okBlyObv3nKeluM1gSzci0qeNI4kSJH3SNkMS
         iMEtxCDGN4St7gVa4KUUiPbJrYR09ukbiOebODrjXfemdjmi2ddNi/E8V5YToYgSiK0b
         o4pqABg1Eg/Hn3CqesErID6LpsJ8aUKgyoirr/WZNyP0XsDESop01/cngVxdSsWDY1Dm
         QHaa2gqLQIte4sX7feO5TnDmOVv6xyJPmZB4rSA1ZrRlt7FaY5TierfCdYYeZi6aFuEx
         xAaASGw0JRF3cXpGwFdS2zBiVpMl1d9ZoLNl2tNjDx/SVIyPrqUMSKSWg2Gi7fh182Bj
         P34A==
X-Gm-Message-State: AOAM532sSEXB3O1gj01S+aOokqAirijpzQ8fUH/pqwnpkZ07fpTja+Te
        upcOC5t7dj5b2LaJC9RLg3Frsw==
X-Google-Smtp-Source: ABdhPJww2ZcCbkPLTnXF7Kw/5CsxB2d/TNneDAZV7Sdr01owwNPsAQHcnr80QhiI7gTFRgaxYm0bcQ==
X-Received: by 2002:a63:5917:0:b0:39c:c450:3143 with SMTP id n23-20020a635917000000b0039cc4503143mr3390690pgb.531.1649962642644;
        Thu, 14 Apr 2022 11:57:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c26e:8dc1:2f6e:26bc])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm591613pfw.188.2022.04.14.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:57:22 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:57:15 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/4] object-name: reject trees found in the index
Message-ID: <Ylhui1cBGDca4m19@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <f5da532767367844af7ecc477e1c8434a5454fd1.1649349442.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5da532767367844af7ecc477e1c8434a5454fd1.1649349442.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.04.07 16:37, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The get_oid_with_context_1() method is used when parsing revision
> arguments. One particular case is to take a ":<path>" string and search
> the index for the given path.
> 
> In the case of a sparse index, this might find a sparse directory entry,
> in which case the contained object is a tree. In the case of a full
> index, this search within the index would fail.

Another case where my naive understanding of sparse-indexes caused a lot
of confusion for me. I don't know if we want to add reminders everywhere
in this series, but there should probably be at least one commit message
in the series that points out that sparse indexes are not subsets of
full indexes.


> In order to maintain identical return state as in a full index, inspect
> the discovered cache entry to see if it is a sparse directory and reject
> it. This requires being careful around the only_to_die option to be sure
> we die only at the correct time.
> 
> This changes the behavior of 'git show :<sparse-dir>', but does not
> bring it entirely into alignment with a full index case. It specifically
> hits the wrong error message within diagnose_invalid_index_path(). That
> error message will be corrected in a future change.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  object-name.c                            | 19 ++++++++++++++++++-
>  t/t1092-sparse-checkout-compatibility.sh | 11 ++---------
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/object-name.c b/object-name.c
> index f0e327f91f5..2dc5d2549b8 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1881,6 +1881,20 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
>  			   rel);
>  }
>  
> +static int reject_tree_in_index(struct repository *repo,
> +				int only_to_die,
> +				const struct cache_entry *ce,
> +				int stage,
> +				const char *prefix,
> +				const char *cp)
> +{
> +	if (!S_ISSPARSEDIR(ce->ce_mode))
> +		return 0;
> +	if (only_to_die)
> +		diagnose_invalid_index_path(repo, stage, prefix, cp);
> +	return -1;
> +}
> +
>  static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>  				  const char *name,
>  				  unsigned flags,
> @@ -1955,9 +1969,12 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>  			    memcmp(ce->name, cp, namelen))
>  				break;
>  			if (ce_stage(ce) == stage) {
> +				free(new_path);
> +				if (reject_tree_in_index(repo, only_to_die, ce,
> +							 stage, prefix, cp))
> +					return -1;
>  				oidcpy(oid, &ce->oid);
>  				oc->mode = ce->ce_mode;
> -				free(new_path);
>  				return 0;
>  			}
>  			pos++;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index f6a14e08b81..9d32361110d 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1164,15 +1164,8 @@ test_expect_success 'show (cached blobs/trees)' '
>  	test_must_fail git -C full-checkout show :folder1/ &&
>  	test_must_fail git -C sparse-checkout show :folder1/ &&
>  
> -	git -C sparse-index show :folder1/ >actual &&
> -	git -C full-checkout show HEAD:folder1 >expect &&
> -
> -	# The output of "git show" includes the way we referenced the
> -	# objects, so strip that out.
> -	test_line_count = 4 actual &&
> -	tail -n 2 actual >actual-trunc &&
> -	tail -n 2 expect >expect-trunc &&
> -	test_cmp expect-trunc actual-trunc
> +	test_must_fail git -C sparse-index show :folder1/ 2>err &&
> +	grep "is in the index, but not at stage 0" err
>  '

It might be worth a note that we're demonstrating the current behavior
here, but this is not the desired end-state. In other words, explicitly
note that this is the "wrong error message" referred to in the commit
message.


>  
>  test_expect_success 'submodule handling' '
> -- 
> gitgitgadget
> 
