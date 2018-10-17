Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C9A1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 21:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJRFx3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 01:53:29 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43810 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeJRFx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 01:53:29 -0400
Received: by mail-qk1-f201.google.com with SMTP id n64-v6so29294733qkd.10
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ek4kPoHaB8nRBsnVHpEXIDPnpjaXGKAKvDJvM7iwjXo=;
        b=pPGuV3BWNFnt6jR69HMBh5J27UGc+TI2hQDAabezw7n3lIvSQbNtq0aFKtMN28rzXa
         2yE4MACVjiP+/3xQtzrqUQTgKd9Hr3eBQKS2lzLRbtGfJrXFqczY4wbtTaPKbPNC6aiE
         ezBBA+mAQ4w7PJPBItUvRq1m+ilzZ8eSqNpTyoN1Mcz9ch2N84Q/RE7hNErf0TvC0DRN
         RwlLFqSoapSKg30FSgbT+IGWLKouNCo986T0yiI4ihbmXI1ZSBCWs4JIFeHogM7uXizw
         iaXWCwzrecNHiedtVsXUZuohTmQeePmiCqABNFTie7P3/ox+dVkYNSh2z5lcnBkwhEta
         wgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ek4kPoHaB8nRBsnVHpEXIDPnpjaXGKAKvDJvM7iwjXo=;
        b=An9RnccvwMvXFXlH+7Q/e6ljCfM1fmoL3rcb8h53078v7TgJ9UgBtK0A88i2jEqqku
         oevwI+2ByOltWHNua2iW3w4vv5qmtDpgaUoBiUB4HAlkUBmPrOlsUYxDiewGeSRpEw5z
         VZDsDMXrtZH6A6VBM/+WFfDozbym/Xznb2WFBfzvrOpDcp/w2Yk6mYHe8uvDraoBay2W
         AUTg5w6ghv56Qvr49UHT1mjrNelNeY7FxH9EJu6ms8nlWndLVFggyWq4CiAAakxFT2sq
         qaEhpbTuRLU7utZPOPN5AIFQVXeGweWpQ1zlU0YIF6oDViB78DzIjmNUS710/e/ETewI
         JwgA==
X-Gm-Message-State: ABuFfoiN/jHYpU9u1wIqD5YhpikSXCX7ROghduHyexpGuQgB5z1N5NLv
        owZq14Mqw5uTNpWQx/C1VC15TqvkFP0ofs5Yz6Dd
X-Google-Smtp-Source: ACcGV620sVVdEMFUePY61mlE3upStHu1cJyM4VpgiHCIk3YINYz8/Bd9pd5K4MLnoUc8gS41zhei8kuUu7QRCFV6CwQ9
X-Received: by 2002:a0c:99ed:: with SMTP id y45mr6251121qve.7.1539813348852;
 Wed, 17 Oct 2018 14:55:48 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:55:45 -0700
In-Reply-To: <20181016181327.107186-7-sbeller@google.com>
Message-Id: <20181017215545.202278-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-7-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 6/9] repository: repo_submodule_init to take a submodule struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When constructing a struct repository for a submodule for some revision
> of the superproject where the submodule is not contained in the index,
> it may not be present in the working tree currently either. In that
> siutation giving a 'path' argument is not useful. Upgrade the
> repo_submodule_init function to take a struct submodule instead.

Are there ways for other code to create a struct submodule without using
submodule_from_path()? If yes, maybe outline them here and say that this
makes repo_submodule_init() more useful, since it can now be used with
those methods.

> While we are at it, overhaul the repo_submodule_init function by renaming
> the submodule repository struct, which is to be initialized, to a name
> that is not confused with the struct submodule as easily.

"Overhaul" is probably not the right word for just a rename of a local
variable. Also mention the other functions in which you did this rename
(or just say "repo_submodule_init() and other functions").

> +/*
> + * Initialize the repository 'subrepo' as the submodule given by the
> + * struct submodule 'sub' in parent repository 'superproject'.
> + * Return 0 upon success and a non-zero value upon failure.
> + */
> +struct submodule;
> +int repo_submodule_init(struct repository *subrepo,
>  			struct repository *superproject,
> -			const char *path);
> +			const struct submodule *sub);

From this description, I would expect "sub" to not be allowed to be
NULL, but from the code I don't think that's the case. Should we
prohibit NULL (and add checks to all repo_submodule_init()'s callers) or
document that a NULL sub is allowed (and what happens in that case)?
