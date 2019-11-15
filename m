Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703841F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKOBAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42773 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOBAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so5456833pfh.9
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F/bLStvcYy0901zEyhVmOpN+BfvGp1kwoHmdZ00JNG0=;
        b=jVyi0pCjdq719gLKKe0d1GzWrx7lKBNOv0A6x/GXg//99PhTa/iJ6lgnd900pNf5+d
         Pt+g2M4DlYMShsvykgBZy9zb/uM7wrMhP3NdvFyCzWYWKkK8TeHR9SWeYwibzU6iCHHW
         vYecnKFBwoO0nJXeTXAu40Y8Xmrguus75qFHZAEH5Q5woPq2DqDfPQIqoXblty2jO53y
         xrk94+Vniw76B+by0/1hjXgxp5/oOgLxIyL8OfwHjpSFczFxpN3HyJIlG35tvN91BHge
         gKGhUPx6Q55ngpgJDXbItoYJ06X9UM+sKQVQ/y1Apm00l+6AbdrO2zbl3acQYWc4eRM3
         0k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F/bLStvcYy0901zEyhVmOpN+BfvGp1kwoHmdZ00JNG0=;
        b=FTJgA1hBewWJMZ18xwTODT+dQjZw99VUv9QMNI6tCCpCuwTRQudrmnZr/1YI68+Hh+
         uxkQa8DAwHcA8Ophdf5mM/3zBWhted6dIr9UgSob2NPXn0XydG1aTdNrOERhWl6l26SF
         uOhZ3jganRwqCFmZInTzteLJ0OXpaeSds+BwfA+u2z+8AiXhLEREtTBVP68C7jQOaDIN
         4tZkA5UnjDOctvZRMWWONPx/WUl4YyOYwV7D3PFhbz5yY5CBK81ySpcYn+7R466Ez3Ex
         3s1CqjOT9PIsta9IL2gtprf3Oji7h9Miex244bVS8e78muMur6YIrGHw/Lf3mwLjMuvd
         lGZA==
X-Gm-Message-State: APjAAAVfACSe75z4YFJqVR/5e49oyqz/h9p7dd8pnU9+NAOhQn5dRydN
        IMhkCuA+Rold58HOujreQIHWVgni
X-Google-Smtp-Source: APXvYqxOJuTvUp4bD4vsSMbNeER4BXgM/Yfad5sxavGiLv4t8gzdaQhb/EwBZLnjGuaThQ6RbC993w==
X-Received: by 2002:aa7:9618:: with SMTP id q24mr14511894pfg.229.1573779640567;
        Thu, 14 Nov 2019 17:00:40 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id a23sm7293207pjv.26.2019.11.14.17.00.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:40 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 03/27] t0090: stop losing return codes of git commands
Message-ID: <d987b5748b30d0b18102f823e1c42bc9ceaa1d5e.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In generate_expected_cache_tree_rec(), there are currently two instances
of `git ls-files` in the upstream of a pipe. In the case where the
upstream git command fails, its return code will be lost. Extract the
`git ls-files` into its own call so that if it ever fails, its return
code is not lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0090-cache-tree.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index ce9a4a5f32..5a633690bf 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -21,9 +21,10 @@ generate_expected_cache_tree_rec () {
 	parent="$2" &&
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
-	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
+	git ls-files >files &&
+	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
 	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
-	entries=$(git ls-files|wc -l) &&
+	entries=$(wc -l <files) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
 	do
-- 
2.24.0.399.gf8350c9437

