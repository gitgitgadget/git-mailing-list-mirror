Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E8C3F68F
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD89B22B48
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXp+j6Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfLLOge (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33166 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfLLOgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so3029733wrq.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=BXp+j6QfSAIXMSlBfnFU5I7iig+106KHKZGoQOjxRUxXcNHcr76DrGlhQYeSIszwoA
         DU4J6s7VwVghaLPg1r3N02g8Z2uRIKGep7+mI8hURwL7gcg2dL9jTPlZ9YJxvouUdb0y
         n3tPREG9Kc6bVUIWKIvMJ7XaWdyP4iZr610VyLrtI5p4CpLg0rRyHGJ0k+ZaFc1Pcypg
         K289P8txe4nKghvIOs8vOLDinzS6IdgzKjXv/xxH3b2+WPs+FW42QHcuEuA/xnyUeqqT
         oijEkLlfu9pkOs4i5epi1AkkH4Ta+XlygpDTbvgQIhZ/L+vkbpynZRIH54wrxj18vv5W
         W7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=YGdkK3mU+PPczBZJWW6ZtFG7s/Ii/VHXBg3oNkeRw4ortEMk3Y0w+On1jg8R8ziBHu
         q42jBJwfe1VHbNfdO5fgrTvWAz2BqmTMmCPoPFBMzYhMQDcrcfpEJalFW27AnUJfPoEJ
         NUpgi+kTq6UOU/E78sJ8EkGbJVjGdSkAbIxm2rDWZcBpp5dv0HtZjwNooRVkTOSzvtUy
         r7LciOfJq8JAdVOb7Ioo7e0hElTs6eoIuVUfa0jNs1p5Std9GhareeyLAcubr4TCEdnB
         RsElexmtxDYgMeGAi02/0MW5fGxOgPgMF7tXMLGX89yqHWwMkgZRlqKUiIfm+HmSapHY
         m5vQ==
X-Gm-Message-State: APjAAAXoJlc7z4+TqkBW2FzB22pWNf6uqRRBcLyt81zCTP/EhJNFZlrL
        hH+J30B/JIA+JtoCOqjc/CwIMZR1
X-Google-Smtp-Source: APXvYqxCZqwo6cw2x3BXji2I0GhkpXbJ+LlRrjQDdKfdl2qPqOdCT7YeMhsR9kppsRRgHtNj2U1NPA==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr4714350wrv.316.1576161390062;
        Thu, 12 Dec 2019 06:36:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm6073151wrr.87.2019.12.12.06.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:29 -0800 (PST)
Message-Id: <8677db4b9efb220f10a80d377c5d4038df860a48.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:14 +0000
Subject: [PATCH 05/16] doc: checkout: remove duplicate synopsis
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

It was added in [1]. I understand that the duplicate change was not
intentional and comes from an oversight.

Also, in explanation, there was only one section for two synopsis
entries.

Fix both problems by removing duplicate synopsis.

<paths> vs <pathspec> is resolved in next patch.

[1] Commit b59698ae ("checkout doc: clarify command line args for "checkout paths" mode" 2017-10-11)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index cf3cac0a2b..2011fdbb1d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -13,7 +13,6 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' [<tree-ish>] [--] <pathspec>...
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
@@ -79,7 +78,7 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
 +
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
-'git checkout' [<tree-ish>] [--] <pathspec>...::
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...::
 
 	Overwrite paths in the working tree by replacing with the
 	contents in the index or in the `<tree-ish>` (most often a
-- 
gitgitgadget

