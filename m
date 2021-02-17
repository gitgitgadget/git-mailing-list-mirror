Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C49C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFA664E28
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBQLTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBQLTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 06:19:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A0C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:18:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fa16so1277619pjb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XFM8fYRyTuvdJp8zYS+DNOAMSeiImng+nps5gqjC9hc=;
        b=fNk5NOXOu04XYUZ350z+nyzNpMmqj4xxkc1bUo1/Jux5I0oDVQ7Es1qK32HYYyaOLw
         FrEMnrVGoIhXSYh+cYGqVnyFNb2qBcF25UYxBgN4pckzYS1MtdHhaS3S/+apsK3+L8NZ
         Brx+62IHJG1MJT2ysvoDul+zP6AJEb1x00yui/bIDiiiYMIIUZJ7GDXHHwEEk7qEOXOB
         e/RhNxKbECUr1IMxavalsfObGiHFDKSPlaLNEgowPEQd020N59IGO43aCwK/QeVnVHVR
         lXHZRVvTJlNwepPOdMdbwN/V+0eL+S2EqMDm5/csGuJa5q/dEmwr21YkzRXfkONQpFYI
         3WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFM8fYRyTuvdJp8zYS+DNOAMSeiImng+nps5gqjC9hc=;
        b=pnUJ5YhYY5JsvPYJ9cznRz8yr5EiX5gNwBUIlQsBvz6nBFG2nky/2uphfebed7yk9B
         2hH6VoLOfeuwCDc0WisWrKkTIVs1EPhxKkjFvt/5ugKvBAb9ZQ9MAvx9dPNFNlfLoHM/
         B0yb9ibBb/ZftB6zi6B6NMU1o077ECQekBnttLlSvWaQbA2ddkWbxV9Ci3XkSJwU4nDJ
         8TIP6WuaCwjOvmpPNPJuHB0b8QFkgnxundj4LWW5h5pwxFnCTavZy3drvGrINPZkZUD4
         Eog1weYoPB1zO0mr6DwIoPTsHrqWjdDrCOUxWJQvMTazHk6wNo3C5wWs5CPK9ZVrLDOk
         EKjA==
X-Gm-Message-State: AOAM533PnnyywW+jVST9NTclMBnljtq4J7o7BJyRHH3zBymKq+2t9KxP
        zWdUzyqw/tVgHoX3q9EFb+4=
X-Google-Smtp-Source: ABdhPJz8Us+6kKYdMq07/0b/8uH3isNwr5oSyDnXTw3n1M+Dmf/ZLr4ZIby2LRSHnnBfDodBX31sjw==
X-Received: by 2002:a17:90a:430e:: with SMTP id q14mr8752993pjg.11.1613560707466;
        Wed, 17 Feb 2021 03:18:27 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id x9sm1874574pjp.3.2021.02.17.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:18:26 -0800 (PST)
Date:   Wed, 17 Feb 2021 03:18:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] stash show: teach --include-untracked and
 --only-untracked
Message-ID: <YCz7gOlXDTTd5urZ@generichostname>
References: <cover.1612855690.git.liu.denton@gmail.com>
 <cover.1613459474.git.liu.denton@gmail.com>
 <85b81f2f06bd1b40ee2de220cc84dd74b425daf3.1613459475.git.liu.denton@gmail.com>
 <xmqqczwzpxsz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczwzpxsz.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Feb 16, 2021 at 12:22:52PM -0800, Junio C Hamano wrote:
>  builtin/stash.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git c/builtin/stash.c w/builtin/stash.c
> index c788a3e236..7e0204bd8a 100644
> --- c/builtin/stash.c
> +++ w/builtin/stash.c
> @@ -807,10 +807,11 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
>  		init_tree_desc(&tree_desc[i], tree[i]->buffer, tree[i]->size);
>  	}
>  
> +	/* mimic "git read-tree W U" without "-m" */
>  	unpack_tree_opt.head_idx = -1;
>  	unpack_tree_opt.src_index = &the_index;
>  	unpack_tree_opt.dst_index = &the_index;
> -	unpack_tree_opt.fn = twoway_merge;
> +	unpack_tree_opt.fn = NULL;

Perhaps it would be even more clear if we just removed this line
entirely, otherwise it may give future readers a false impression that
.fn is significant in any way.

Aside from that, both of your SQUASH??? commits look good to me. Thanks
for tying up the loose ends.

-Denton

>  	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
>  		die(_("failed to unpack trees"));
