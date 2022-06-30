Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9063C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiF3K3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiF3K3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:29:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC9457B2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:29:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g26so38089283ejb.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IwMQX0DVg2mXBJQgZ6G5DJKI6uTacCI6icHPNKCt1z0=;
        b=AaqAb08ZecLfG3FDinfnu1WUzu863W/gBVeCPu4sSSrGWJOKwYLBUWBXylZ0Bq0WlN
         HR50fCpNT9n/pnunbIZnUHDEm19P79lQCbaWwPmlkLaf+52aRwsa40jV2yhp9+KrIREV
         gL7Qq5ccK/G5VDxBo2V42760cellj7WflAsiF7uhtx7aAIm0yonj2uKQi+Awxg0IE6sQ
         ZJJY1KDkPmzDtW/HbuZwGbKLdiphGU8VtMa0hZjEsDRzOejjd9a1kDiKaZePG8/lMIsV
         ewCuVCJo2CHeQol3NceM2brfAw0lAHrHZtgykQllj9XShLn2cYQtnd3/kcnyQE4lVBYM
         MOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IwMQX0DVg2mXBJQgZ6G5DJKI6uTacCI6icHPNKCt1z0=;
        b=ODzSlt4HVq1wN2HABQh+Du83ah29dcmoeQlJyErSR/4tSc9JqXE19bJ/w22Hp4gtqP
         iCoYLDk1itibuIEmruE00UPrKyfFu6Et0Juzj1c4ziQ531BlfdQOgUDuRRDIMWRrfgyN
         vv73Kqbje3D1p2uUkByXPvpGRG5xyeXxSvYJxWeMga//z2X5c/xZG7by1+AisvF3TXW+
         mEKrAmCYHsxC4iOrHuWbE/p6p8wOQr4nE9EjrUhOXFPz8JhruoMLcZkBDSOUw+mVmKyT
         uRAcFVps1fWnoBfC80yzRH4vKtT29HPCEGwWsYYWtKfOCNT14agF1NZCGjl4vQ+c88vu
         R/vw==
X-Gm-Message-State: AJIora+sSNx25eN1avNfPJSlf9aDHPk5YaF3AHxpAQ+THSq0wbYZf3uH
        iVq6n5LDxO0g1gnrsViNMdV3d3g9Mx6k/A==
X-Google-Smtp-Source: AGRyM1s0TFt5Wkh7byDyPqNY+o+X1y3gCgyvENGXG8zsc/Eilbp7HaHataiOvohEag8Oex0EifvfPw==
X-Received: by 2002:a17:907:2706:b0:72a:3216:96bd with SMTP id w6-20020a170907270600b0072a321696bdmr7326926ejk.658.1656584951504;
        Thu, 30 Jun 2022 03:29:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id dy10-20020a05640231ea00b004358c3bfb4csm12972846edb.31.2022.06.30.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:29:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6rQ6-002F0n-FQ;
        Thu, 30 Jun 2022 12:29:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/3] merge-ort: shuffle the computation and cleanup
 of potential collisions
Date:   Thu, 30 Jun 2022 12:28:04 +0200
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
 <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
 <cfa38f01481d6a13a676e250e8254182733e0dd1.1656572226.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cfa38f01481d6a13a676e250e8254182733e0dd1.1656572226.git.gitgitgadget@gmail.com>
Message-ID: <220630.86pmiqe96x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Run compute_collisions() for renames on both sides of history before
> any calls to collect_renames(), and do not free the computed collisions
> until after both calls to collect_renames().  This is just a code
> reorganization at this point that doesn't make sense on its own, but
> will permit us to use the computed collision info from both sides
> within each call to collect_renames() in a subsequent commit.

I think this would be easier to follow if split in two, since...

> +static void free_collisions(struct strmap *collisions)
> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +
> +	/* Free each value in the collisions map */
> +	strmap_for_each_entry(collisions, &iter, entry) {
> +		struct collision_info *info = entry->value;
> +		string_list_clear(&info->source_files, 0);
> +	}
> +	/*
> +	 * In compute_collisions(), we set collisions.strdup_strings to 0
> +	 * so that we wouldn't have to make another copy of the new_path
> +	 * allocated by apply_dir_rename().  But now that we've used them
> +	 * and have no other references to these strings, it is time to
> +	 * deallocate them.
> +	 */
> +	free_strmap_strings(collisions);
> +	strmap_clear(collisions, 1);
> +}

...a large part of it...
>  
> -	/* Free each value in the collisions map */
> -	strmap_for_each_entry(&collisions, &iter, entry) {
> -		struct collision_info *info = entry->value;
> -		string_list_clear(&info->source_files, 0);
> -	}
> -	/*
> -	 * In compute_collisions(), we set collisions.strdup_strings to 0
> -	 * so that we wouldn't have to make another copy of the new_path
> -	 * allocated by apply_dir_rename().  But now that we've used them
> -	 * and have no other references to these strings, it is time to
> -	 * deallocate them.
> -	 */
> -	free_strmap_strings(&collisions);
> -	strmap_clear(&collisions, 1);

..is moving existing code into a utility function...

>  	return clean;
>  }
>  
> @@ -3100,6 +3105,7 @@ static int detect_and_process_renames(struct merge_options *opt,
>  {
>  	struct diff_queue_struct combined = { 0 };
>  	struct rename_info *renames = &opt->priv->renames;
> +	struct strmap collisions[3];
>  	int need_dir_renames, s, i, clean = 1;
>  	unsigned detection_run = 0;
>  
> @@ -3149,12 +3155,22 @@ static int detect_and_process_renames(struct merge_options *opt,
>  	ALLOC_GROW(combined.queue,
>  		   renames->pairs[1].nr + renames->pairs[2].nr,
>  		   combined.alloc);
> +	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
> +		int other_side = 3 - i;
> +		compute_collisions(&collisions[i],
> +				   &renames->dir_renames[other_side],
> +				   &renames->pairs[i]);
> +	}
>  	clean &= collect_renames(opt, &combined, MERGE_SIDE1,
> +				 collisions,
>  				 &renames->dir_renames[2],
>  				 &renames->dir_renames[1]);
>  	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
> +				 collisions,
>  				 &renames->dir_renames[1],
>  				 &renames->dir_renames[2]);
> +	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
> +		free_collisions(&collisions[i]);
>  	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
>  	trace2_region_leave("merge", "directory renames", opt->repo);

...which when looking at it makes the functional change harder to follow
than it otherwise would be.
