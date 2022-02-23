Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03787C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbiBWOaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiBWO36 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E275B2535
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s1so13525788wrg.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j7/AXvKEQBi85YP83sPnyiMP8njPIWHcj9dLP0WjuCU=;
        b=GXykAKfBaA/qrtGoy/FppX5UDtrVP/XROmd67mTdVYowWbpXEIe1O56vQ+E4PrHJDP
         xxpw9NYbp2m2k1HXg7Y6SSAospH1grFk1N/GwtgV/8z99eq+KDlJGNkMbdDeOPVwcT8X
         Dn6tum2TioznIAiFUfDpJJUhzBUcqmX10Q45Ja0Vr7p9oQeQksHRxrz0emsZ989Ueh+z
         +QoSkUNyo1UY3StZNndFP2fl5GsUmbrK3PIPCXIjz0PidrFvY0T2JR9cCI8HyATCKNmJ
         TYIMj7L8RRhsH+ymTdJRgu3zrg2tz7zsrhxixqq8WHOFIGebyPpIJjw7Nrqug5ALi9s/
         Jkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j7/AXvKEQBi85YP83sPnyiMP8njPIWHcj9dLP0WjuCU=;
        b=71wPWXe3g/MOoYQrNisF9d6Ic7xH1lm2ZLzedKlzl4MI/xo+saTolWNnXyt3wHEi5H
         fiGSml88EPu+opC9VPXaD806JNi7Kma5SvBT10RdkM7NNCSOPBzhFhvJAvgnZggwIFYc
         TDuC6q2yb5+uwwtgWTFeQkuh8LsXUh5jr+JdE9S93XoBwsXugC7Dd8BXRZ10SkBw0FT0
         y0gqHepnGjiyvEfEX/K8k5cYVYOQns8mvvA2G068ktV4/Cwu3Qoh91bMtmFBI9LCSYJQ
         Y+PTZnCo9SAh7XZ8+/XaubNDkPxiExi1HK6XX8/RdjvxERVEAjWtR4+j0afJNqdK4yvh
         SGkQ==
X-Gm-Message-State: AOAM533t/UeZrbmep/TXWGCESTf3a7oG4B1XVxzsg20KuholysDniHCX
        /8h0kgu3dt/8VNzSQnpShU9Am9CeTQI=
X-Google-Smtp-Source: ABdhPJzcyMHQZdxDPudYFVGjUo/o9gfZvob0AD3oTFfSa/RW5wU/Y9VQRJJuP+TIi3VfC2Du4/0kJQ==
X-Received: by 2002:a05:6000:1843:b0:1ea:3bdd:dae with SMTP id c3-20020a056000184300b001ea3bdd0daemr12005203wri.235.1645626568490;
        Wed, 23 Feb 2022 06:29:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm48817648wrx.92.2022.02.23.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:28 -0800 (PST)
Message-Id: <0eb374620a7e05fe0fb4695d36313e54a982a2e7.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:16 +0000
Subject: [PATCH v3 08/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is helpful to distinguish between a 'working tree' and a 'worktree'.
A worktree contains a working tree plus additional metadata. This
metadata includes per-worktree refs and worktree-specific config.

This is the fourth of multiple changes to git-worktree.txt, restricted
to the REFS section.

This section previously described "per working tree" refs but they are
now replaced with "per-worktree" refs, which matches the definition in
glossary-content.txt.

The first paragraph of this section was also a bit confusing, so it is
cleaned up to make it easier to understand.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 329d3a9e4ea..563c93a1bc4 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -256,24 +256,23 @@ have two worktrees, at `/abc/def/ghi` and `/abc/def/ggg`, then `ghi` or
 
 REFS
 ----
-In multiple working trees, some refs may be shared between all working
-trees and some refs are local. One example is `HEAD` which is different for each
-working tree. This section is about the sharing rules and how to access
-refs of one working tree from another.
-
-In general, all pseudo refs are per working tree and all refs starting
-with `refs/` are shared. Pseudo refs are ones like `HEAD` which are
-directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are
-exceptions, however: refs inside `refs/bisect` and `refs/worktree` are not
-shared.
-
-Refs that are per working tree can still be accessed from another
-working tree via two special paths, `main-worktree` and `worktrees`. The
-former gives access to per-working tree refs of the main working tree,
-while the latter to all linked working trees.
+When using multiple worktrees, some refs are shared between all worktrees,
+but others are specific to an individual worktree. One example is `HEAD`,
+which is different for each worktree. This section is about the sharing
+rules and how to access refs of one worktree from another.
+
+In general, all pseudo refs are per-worktree and all refs starting with
+`refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
+under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are exceptions,
+however: refs inside `refs/bisect` and `refs/worktree` are not shared.
+
+Refs that are per-worktree can still be accessed from another worktree via
+two special paths, `main-worktree` and `worktrees`. The former gives
+access to per-worktree refs of the main worktree, while the latter to all
+linked worktrees.
 
 For example, `main-worktree/HEAD` or `main-worktree/refs/bisect/good`
-resolve to the same value as the main working tree's `HEAD` and
+resolve to the same value as the main worktree's `HEAD` and
 `refs/bisect/good` respectively. Similarly, `worktrees/foo/HEAD` or
 `worktrees/bar/refs/bisect/bad` are the same as
 `$GIT_COMMON_DIR/worktrees/foo/HEAD` and
-- 
gitgitgadget

