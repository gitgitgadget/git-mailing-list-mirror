Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F716C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A97D2222A
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL3UBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3UBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 15:01:33 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30CC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:00:52 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q25so19762886oij.10
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6oefk1SIh2C7JEX2iknkaER4gYopCHuE0+UTeD3a0k=;
        b=RagQj2z1c7hkyCV4/k8wpRuMf1L6rrCSGMKxUx57Xj7uNpDbsMSYxxeCLu3SYP6Ysf
         AdryPYKnibh+HwgSH9kyuogIs3E4U8mwVSWPH+PeynnqdB1wAsWRQnpobl56lAp4vCBP
         QdR5+yBUN+9Ec7egNXY8f2BJtLcURmxVu2CCnUQBONw+hpohKPgeU0H58Am28wUJB08d
         vW2WeCfrlqY+0qv9kbd3gd5pg96jGcqvpGOpeRpwQoWzdE7357/yhXppeIJbihq0r1Qg
         1L5GXecdSxdU8+apOXYmdTp9UZDn8tBmjexGLhvHj/Vz+kZbezoWesKKLh3FQoLQLsQt
         IhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6oefk1SIh2C7JEX2iknkaER4gYopCHuE0+UTeD3a0k=;
        b=XFmx34Z4PA+ZcNRgi/FtQev9DTA+gzvzClytG2vhbk/4l5B/l8BYDaXFEaYli5ZgXv
         2V76jAGg46/mwnPI66tqRgjnlN6NXLMmnX3WeHcF2E30ff5p58usH0EKmHWGWlV0wuZ9
         BnSpJI//bXYg253BW14JECs6cBrGOviZw6KcrIE4rTfq3QZVXQ7TV+w77FyLdp7sj9hM
         X6nh4NHie0PzxPNgF6HlaKd/hsTTr3uIWEHX8Nig115B8L9WQnxckrmBI+zuRPguIGAM
         Wa7vhGj4qYs/j1kegYfbJ2w6dagzsV8Durj1D5EJx1rr3+h9sn91tiC2MXLO8PlhN5GL
         JSwg==
X-Gm-Message-State: AOAM532lyiOYuxHKawBBB/VBKwGmOfX9GPH2QRQFhSXhU4TN5Cbp9Sdq
        zfqpNH289v1PBbb0jC82/pfk7TF2a81JEKltnu0=
X-Google-Smtp-Source: ABdhPJyzkswLKtwlRejw7U1Z6+1fPg25xl8MxQVsG/hVDHJlEIlUrua3JXL4NvVmocBh4gNKllE8/ImviSNzYl+4Q6c=
X-Received: by 2002:a54:4185:: with SMTP id 5mr6244540oiy.31.1609358451970;
 Wed, 30 Dec 2020 12:00:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.829.git.1609356413.gitgitgadget@gmail.com> <fb9d5468184c4cbb3d80569f685743b9a5b45c8e.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <fb9d5468184c4cbb3d80569f685743b9a5b45c8e.1609356414.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 12:00:41 -0800
Message-ID: <CABPp-BFdn-CBWMPeAKoPvuSqwkeHnAPMZovAEaiNquz_JKaPkA@mail.gmail.com>
Subject: Re: [PATCH 6/8] index-format: update preamble to cached tree extension
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> I had difficulty in my efforts to learn about the cached tree extension
> based on the documentation and code because I had an incorrect
> assumption about how it behaved. This might be due to some ambiguity in
> the documentation, so this change modifies the beginning of the cached
> tree format by expanding the description of the feature.
>
> My hope is that this documentation clarifies a few things:
>
> 1. There is an in-memory recursive tree structure that is constructed
>    from the extension data. This structure has a few differences, such
>    as where the name is stored.
>
> 2. What does it mean for an entry to be invalid?
>
> 3. When exactly are "new" trees created?
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/index-format.txt | 36 ++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
> index 69edf46c031..c614e136e24 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -138,12 +138,36 @@ Git index format
>
>  === Cached tree
>
> -  Cached tree extension contains pre-computed hashes for trees that can
> -  be derived from the index. It helps speed up tree object generation
> -  from index for a new commit.
> -
> -  When a path is updated in index, the path must be invalidated and
> -  removed from tree cache.
> +  Since the index does not record entries for directories, the cache
> +  entries cannot describe tree objects that already exist in the object
> +  database for regions of the index that are unchanged from an existing
> +  commit. The cached tree extension stores a recursive tree structure that
> +  describes the trees that already exist and completely match sections of
> +  the cache entries. This speeds up tree object generation from the index
> +  for a new commit by only computing the trees that are "new" to that
> +  commit.
> +
> +  The recursive tree structure uses nodes that store a number of cache
> +  entries, a list of subnodes, and an object ID (OID). The OID references
> +  the exising tree for that node, if it is known to exist. The subnodes
> +  correspond to subdirectories that themselves have cached tree nodes. The
> +  number of cache entries corresponds to the number of cache entries in
> +  the index that describe paths within that tree's directory.
> +
> +  Note that the path for a given tree is part of the parent node in-memory
> +  but is part of the child in the file format. The root tree has an empty
> +  string for its name and its name does not exist in-memory.
> +
> +  When a path is updated in index, Git invalidates all nodes of the
> +  recurisive cached tree corresponding to the parent directories of that
> +  path. We store these tree nodes as being "invalid" by using "-1" as the
> +  number of cache entries. To create trees corresponding to the current
> +  index, Git only walks the invalid tree nodes and uses the cached OIDs
> +  for the valid trees to construct new trees. In this way, Git only
> +  constructs trees on the order of the number of changed paths (and their
> +  depth in the working directory). This comes at a cost of tracking the
> +  full directory structure in the cached tree extension, but this is
> +  generally smaller than the full cache entry list in the index.

Ooh, I really like it; this probably would have helped me.  However,
we'll need to get someone else to take a look at this, because I don't
know enough to say whether any part of it is incorrect, misleading, or
incomplete or whether it's all good.  My knowledge in the area is
limited to moving a function from merge-recursive.c to cache-tree.c in
commit 724dd767b2 ("cache-tree: share code between functions writing
an index as a tree", 2019-08-17), but I seem to recall that I had to
rely on Junio's reviews and guidance to make the minor adaptations
found in that commit.
