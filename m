Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0531F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbdLSW1E (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:27:04 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43404 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbdLSW0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:26:55 -0500
Received: by mail-io0-f194.google.com with SMTP id k202so6986884ioe.10
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RaK4YIuob2H0wji9r4QdZOyg7WRn1AE9f3KfrZCwDTs=;
        b=DoSVVfJqKOMM9mpt6VEa4Df7ouoYu8h3w8yTx3TDl/L0d79mN5k8mgjTKa7f9BVjVq
         AruiMa+vGLx6MMzSV/CSrZ11FpLkTQ0Gmajy+BjoisnvHtWj1Kmx88/4//lY93dPAUd1
         xZcinElsor/8ho3somxW1URCrvc4/NtPTfYQ4HxBifRjZyHyun/UqlsBuXNat13sw/1V
         L/Fpt+C4l470U8ccknDbHNAjfmi7z0yRoaaLoXbu4b65g6OtiQuae8DnDSp1UnmgB9kr
         lfkCVqh5mGJ06Ub/wgijBfNvOZ5vZ76cxDDP4POHCEBCUjN51FD2CviHQZOIFh4ZL51j
         84oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RaK4YIuob2H0wji9r4QdZOyg7WRn1AE9f3KfrZCwDTs=;
        b=YlGS8ZpJ4Uxsjwd0xPzUXEsQPvup9LgJDorZ8E+C1kM1gB0vBVjrsipwErx1HL7rXw
         spr/f8OXRNfJVexFygkvNHB0HUDrX1VCDrodPknNtvCH4TfMdzjJZMUsEbFzB5nVuUC8
         gM+azRH6CvkCC1yLYVsaidHZjpNWKzSvSgjfsKaaKILTCWsAlO6R7lwpeh2mXUSDnQHj
         M+3LnLZC9UFi9+jV/k9wJhgdsAJNjEQKxEv/fToA1afwDGQwnMZ0K38siDlHzGXpOMZd
         /Ju9HGIL/R3NuX9MctSoV5xqzeTkDMmmULyZMZVdEUNhIRhh+aPxOTxkUK9ZMdIXE2pC
         3D8g==
X-Gm-Message-State: AKGB3mInDMhxZXk1k1hfPeOnnpMx+SF6XqTo9q2ocvyaOdYsICBAu+cp
        WKi2qFP0OTqwFC2y6yQSPtdC5Xsv/hs=
X-Google-Smtp-Source: ACJfBosNCtrewLwK6G5L5BDsyxhSgpxkNW/N+vsBIzTunN6bnOvOIvpQoI8qN9RONSTBrbjXzM3sqw==
X-Received: by 10.107.6.208 with SMTP id f77mr5752364ioi.54.1513722414618;
        Tue, 19 Dec 2017 14:26:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d14sm1652837itj.11.2017.12.19.14.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:26:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] submodule: submodule_move_head omits old argument in forced case
Date:   Tue, 19 Dec 2017 14:26:36 -0800
Message-Id: <20171219222636.216001-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171219222636.216001-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the previous patch applied (fix of the same() function), the
function `submodule_move_head` may be invoked with the same argument
for the `old` and `new` state of a submodule, for example when you
run `reset --hard --recurse-submodules` in the superproject that has no
change in the gitlink entry, but only worktree related change in the
submodule. The read-tree call in the submodule is not amused about
the duplicate argument.

It turns out that we can omit the duplicate old argument in all forced
cases anyway, so let's do that.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 4 +++-
 t/lib-submodule-update.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index 15cf3e0b8b..7b6661cc84 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -1016,7 +1016,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		)
 	'
 
-	test_expect_failure "$command: changed submodule worktree is reset" '
+	test_expect_success "$command: changed submodule worktree is reset" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
-- 
2.15.1.620.gb9897f4670-goog

