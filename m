Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01B61F404
	for <e@80x24.org>; Wed, 27 Dec 2017 22:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdL0W5X (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:57:23 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:43007 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbdL0W5T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:57:19 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so26538479itb.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b6goWZdhGhrzuzSG2BdADtY2XGEAOBvg1pFtN6uHNwE=;
        b=Qag/GvY4ztJQHcgiVERSCXHSNjn4AvExgeJVN2GBExnnvb91BmBWD3ciKsCoI2AoJU
         oLPZkf3b/BEKwQ8gXKHOUMf7snvm7yaiTIt3RzKjQL6sOPASQ6B9nlZVhaLRWp1nD4Zc
         7ajP1c52ybojpdDNYyb/ZiUCdVQqIsksNse+f6wyeuZlJyGl/TDpMVzfLEeJDtmz6NRw
         Z2BeNqLC4Xk/ErnGb9Q1Q+Cd0PgD6YtZcAzoNMBRaZ/31Jk1uNEQHCEn230C+pfF1zO1
         UqMR6/+psPmBRy0voVT8zRK0BTRcCIn+B68SVPnOT6O/ccRga9ktQnUAsx8gNbSNKiH+
         2wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b6goWZdhGhrzuzSG2BdADtY2XGEAOBvg1pFtN6uHNwE=;
        b=fHPI+kAj7kLfBy7//gl4zG+7lw445lgEC4Ack64ebFDdiFS/e4xnEEruTAXw2/CEpU
         1NErzVEhLlJl/b7tvqrbntwT1BFWXarWcz8XApmfLXPHlIGymUg5m35d3KGDwAGkRGxO
         AEZ9a5sPs22EcvLfLomnEs8fKTAv7TLI89hSOd/9JaPwFnTN6ovsRblWb5raxf2yC4i1
         +20lRi9SxIQSo1AIhM5PoyLu8LQaB9xK6tBsuaWa6KYwel/+OoXsFdQ9dPhOlnCQrj+L
         iy5nI4XFItfb+l6u7cIfERrOsYvKE8kR4EW0YFcWwyBX465naJqvovlqFPTvUOGYqzMF
         f1wg==
X-Gm-Message-State: AKGB3mKSSPRkdjNbOc0AyDOXiLQayBJiwXqcPg1RIg77SMeyuhiviwW/
        KYnHL7VLGQi06tUTzI8x5eQ1mw==
X-Google-Smtp-Source: ACJfBot0P9Y3qU26/ORz7ulNflAQmOgOoalZLb+mTUaq3drf2aJ60a9pPJ8y3TiwLHAZ9f7pcrP6tA==
X-Received: by 10.36.53.12 with SMTP id k12mr33076418ita.136.1514415438528;
        Wed, 27 Dec 2017 14:57:18 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l15sm4166455iog.56.2017.12.27.14.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 14:57:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: [PATCHv2 5/5] submodule: submodule_move_head omits old argument in forced case
Date:   Wed, 27 Dec 2017 14:57:05 -0800
Message-Id: <20171227225705.73235-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171227225705.73235-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171227225705.73235-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using hard reset or forced checkout with the option to recurse into
submodules, the submodules need to be reset, too.

It turns out that we need to omit the duplicate old argument to read-tree
in all forced cases to omit the 2 way merge and use the more assertive
behavior of reading the specific new tree into the index and updating
the working tree.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               |  4 +++-
 t/lib-submodule-update.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index fa25888783..db0f7ac51e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1653,7 +1653,9 @@ int submodule_move_head(const char *path,
 	else
 		argv_array_push(&cp.args, "-m");
 
-	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
+		argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+
 	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
 
 	if (run_command(&cp)) {
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb0173ea87..1f38a85371 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -1015,4 +1015,18 @@ test_submodule_forced_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
+
+	test_expect_success "$command: changed submodule worktree is reset" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			rm sub1/file1 &&
+			: >sub1/new_file &&
+			git -C sub1 add new_file &&
+			$command HEAD &&
+			test_path_is_file sub1/file1 &&
+			test_path_is_missing sub1/new_file
+		)
+	'
 }
-- 
2.15.1.620.gb9897f4670-goog

