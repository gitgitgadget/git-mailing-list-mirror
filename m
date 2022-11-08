Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E344C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKHWoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKHWob (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:44:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E383D209A8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:44:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so23140032wrt.12
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/zicVtu+r7gO5FwNJ/+MUMzuPbt221qJMX9gz8tkU0=;
        b=NkdBXINqsm6+EGtYp69ZZyFC1t7EMn4VW+zD+4vb/Tr1Lryd69txVYlivG0nimWNJV
         yVr5f2JvdQV9ec9U/LilLy/ugrXnK/pz6wCEJnWquku9B76gmvAK7YE7GscHeztyK1xY
         7LVVgyXkmS/+cPNYqbJv3AWSgns6lGT8+4CqvDwkTXcsZwxMTOAghJjMxgMVbeOFsBF7
         /nqghC4pd1YPL5Qp9eiZ3d82PsHtHKvLW5FvuY7EBthSJiKrGfNJiPQsU0Ycm6A8cq8e
         JDnZxXABpESHaU9DXP4u067Ojc3YK+RckUxMPGunfZFBLhl0ZM82ZWvAYJEsUVGxvFd3
         q33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/zicVtu+r7gO5FwNJ/+MUMzuPbt221qJMX9gz8tkU0=;
        b=agvHefkGr1q7CqPmMZaOKtmX+nC7ZTi/HnAD/L5MnmTQR/bCATGANouqve8E6LwYOY
         u2FD1ueRdYwth/vwk2tz1Q/jBR71URdpRlykO3qz4Bo6RGPRE2IxQvGMhcoBoKGXWZae
         d8j8dNzIUoK7J/m9mmgQS6WXSu0Aou4vjElMg/a6swJfje3wOAqzuqHaRi2mN3D1invr
         U9d0RDoawcYyAp5Er8rlPV3re2b3LO2ErvuUpVr3oIh+hXR8QPmZusjicjw2zkgiIcCe
         o+dGsaFkPIAH0mnSjcPwAkzvoLQ2OUVFp48F1FGMEpxNTWYWBvsOplknA7rMTTF+6tCQ
         w65Q==
X-Gm-Message-State: ACrzQf1zjRgmquWtnZq0plZGNbHHndHGViLUmM4I2L/rp0KbtNxfZR3a
        C0Cd0gFVqRYrbGdaJIZu4jE8tlwTc/M=
X-Google-Smtp-Source: AMsMyM7zv1EjaVsr5+S4l7IWCJYV4cZahk1CwyfWJvZvv7eznoXWeKYxb6qoYe4qBKPDqgN4u6Qeew==
X-Received: by 2002:adf:dd4d:0:b0:236:6e72:be17 with SMTP id u13-20020adfdd4d000000b002366e72be17mr35268804wrm.460.1667947468261;
        Tue, 08 Nov 2022 14:44:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003b3307fb98fsm12137459wmi.24.2022.11.08.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:44:27 -0800 (PST)
Message-Id: <d0a20cafd394165855620d76d9f5ab7c003338e6.1667947465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 22:44:22 +0000
Subject: [PATCH 2/5] unpack-trees: add 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add (disabled by default) option to skip the 'cache_tree_update()' at the
end of 'unpack_trees()'. In many cases, this cache tree update is redundant
because the caller of 'unpack_trees()' immediately follows it with
'prime_cache_tree()', rebuilding the entire cache tree from scratch. While
these operations aren't the most expensive part of operations like 'git
reset', the duplicate calls still create a minor unnecessary slowdown.

Introduce an option for callers to skip the 'cache_tree_update()' in
'unpack_trees()' if it is redundant (that is, if 'prime_cache_tree()' is
called afterwards). At the moment, no 'unpack_trees()' callers use the new
option; they will be updated in subsequent patches.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 3 ++-
 unpack-trees.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index bae812156c4..8a762aa0772 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2043,7 +2043,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
 				cache_tree_verify(the_repository, &o->result);
-			if (!cache_tree_fully_valid(o->result.cache_tree))
+			if (!o->skip_cache_tree_update &&
+			    !cache_tree_fully_valid(o->result.cache_tree))
 				cache_tree_update(&o->result,
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
diff --git a/unpack-trees.h b/unpack-trees.h
index efb9edfbb27..6ab0d74c84d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -71,7 +71,8 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
-		     dry_run;
+		     dry_run,
+		     skip_cache_tree_update;
 	enum unpack_trees_reset_type reset;
 	const char *prefix;
 	int cache_bottom;
-- 
gitgitgadget

