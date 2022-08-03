Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCFC19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 22:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiHCWi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWiy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 18:38:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A222BC5
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 15:38:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h132so16349663pgc.10
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=yN+O54pfWQnOXMYkGE66tG3w2pJ37RHs9vT4BvM2A8k=;
        b=Vk93vmndFWqbLs7JbuMRjUs0WzZYgKcYwqMbWRSJjOLFVSof4YAi5dGS9GztC7VMCZ
         N0sHlZ7N1JVZ82Kh28nQBXAPDwpwuuIfrmnhgpufp/6ULrBMUEZQf5JHhrYgmT31bQ+Z
         H3zLYxA7EbArT3+mvaWvQL7eHEm7BL1/3xiDhN4NVSUvaokwkpAeJhMzWyihXxowFLr+
         yiUCIAh7sow57vJNVHIEVyWLftN1J4u9JZwXpCgqqFMJeeSsGyIRdv775jf5HPFoAOmw
         1izDuWOCOWY3HUnYDfLWy3BXF+CG5YDXjlkHrWXrVfkmNRCqo6u9QaL2ZzGWD0HtdHFF
         VV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=yN+O54pfWQnOXMYkGE66tG3w2pJ37RHs9vT4BvM2A8k=;
        b=GDueOUp2r5ap1s+87ufr6d+pUXUo8aukNNUSzkprU6vMwTFErgZfgG63UWVjUUnhXA
         TD50OoNQRLin5Jb7kRqCoFQb7oqH8Hvktrr6Bfw12xFR1dFChR2DIiBGfC6WKMozDHxy
         lhxs2JH/43F2TUbkCEJ5ncAEark7sLWHrh9GWXHvdDNQCKuysPLJWdT/YUURlPffgKPs
         kMxlW5g8p/PnQXBoto8izR04VSwb+AG3HDp+ymxko37PiOgxeteOQLMbkpeqRrtG2br9
         YyQbL4o3llybZcApvSwYd27Fy139zHkaZcen6a2Bxmbc/h9ZBioasuivzwIXctMcch9A
         PwDQ==
X-Gm-Message-State: AJIora+Xha18YTQWRKUewxoYkjl2KRda6eSjnhecKgjVEfBJLS0dBIsz
        PeLih1Plk6VPb32aXEVDlA+Dqw==
X-Google-Smtp-Source: AGRyM1sqSgmfDrU8Dslav5kh1JMCIBoJL70u6mgqzt00q5SETwB0LP0/v+e0o0Tbm3UrvbWK1QdozA==
X-Received: by 2002:a62:6545:0:b0:52b:6daa:1540 with SMTP id z66-20020a626545000000b0052b6daa1540mr27487399pfb.29.1659566333547;
        Wed, 03 Aug 2022 15:38:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8993:c42:1e1d:1a70])
        by smtp.gmail.com with ESMTPSA id y75-20020a62ce4e000000b0052e59500b1csm624271pfg.38.2022.08.03.15.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 15:38:52 -0700 (PDT)
Date:   Wed, 3 Aug 2022 15:38:46 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 04/10] refs: use ref_namespaces for replace refs base
Message-ID: <Yur49obfOHwu2B5t@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <8da0b0a31810c8221ad3ab13b8c41cf1a266c2c0.1659122979.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da0b0a31810c8221ad3ab13b8c41cf1a266c2c0.1659122979.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.29 19:29, Derrick Stolee via GitGitGadget wrote:
> diff --git a/log-tree.c b/log-tree.c
> index d0ac0a6327a..bb80f1a94d2 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -141,10 +141,12 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>  	enum object_type objtype;
>  	enum decoration_type deco_type = DECORATION_NONE;
>  	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
> +	const char *git_replace_ref_base;
>  
>  	if (filter && !ref_filter_match(refname, filter))
>  		return 0;
>  
> +	git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;

Is there a reason not to initialize this as soon as we declare it?


>  	if (starts_with(refname, git_replace_ref_base)) {
>  		struct object_id original_oid;
>  		if (!read_replace_refs)
