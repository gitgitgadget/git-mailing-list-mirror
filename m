Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD7C636C8
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4D661181
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhGRIBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhGRIBO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 04:01:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82286C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so8470928wmc.2
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Faxj3kQNzn2u6POh0UyjzFW/5xS59b0bu1X8MpZrKqQ=;
        b=qWCEj/Sm9ABPEI3QHd+arnQxTniwtBp19LcjCgyiKV8HwCAxvgQBdcNmHszCF4taYi
         OFNw+P2q8GAkPHT+SjgMVxl5Tb2aw/J/kwWXul7jf3Lc2uBcpsnvN1B3GQYguPO0OTFH
         qdNwFJgLoIAP25a4bg4FCNSGdU1wZBVVKxLe95CFh9D8O4tK+R0bSHT/tU6DyR+1LFv2
         pejlRNqIwBMZzYiFPOH8leojH3IgBU5llN06fhRPZ26nHpfBV1IQwf4DXyr08gwp8A2E
         xkrXBg4s43+1jIdaIG5KwI6HM3DCPFyAK4ecsR0V6l5tWUX7k9oLgaOAcrr2V7TuKuml
         2Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Faxj3kQNzn2u6POh0UyjzFW/5xS59b0bu1X8MpZrKqQ=;
        b=QBKl7heI+3PnMoKbsd/rsgeCrviP9ac5KsW1OPyC/v/Pmr8k+sd8NWDAYmMuQacJHD
         KT6YrIsgA/zkm0sDKkj344+RRZhMFjVMRWlhv/mIVKytFeQ0Jg0LE3xkP5dlSKDELaHd
         w8aK2RC+m0RBnI7w9xhRvEyQVXh05TfWfx/B+dQqLZpvnEQhXXKVoBQGHGgDCrf2Dei3
         BoLxs5Itnn4JCwuPpMtX1yb7ChffJpsPjzq5GlqTEY+Wlkh5isGymoPc43+hji3mNU6x
         sEYKPcunZlNG77Va3SILyQ6DPvJFeAuMulgASdIZCHJ3X4W3CRWiIcwf1OrPy1vxaEan
         ZU2w==
X-Gm-Message-State: AOAM531ZJQ59a/7sCXFzYKJxByvc7ae3PamPPsdBj0+xDHLFTI+xe6Wm
        1A2XO/Kqa+ME2tq/0k9qel+5iwEzQGX8dg==
X-Google-Smtp-Source: ABdhPJxAE5FWWnH7V7U9UDmlyFOHaZG/oYQ5/arxfhrS2XRSsCs8zhikLd8nGp99G5pNGAjMvpldag==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr25313364wme.119.1626595094942;
        Sun, 18 Jul 2021 00:58:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm15904685wrt.55.2021.07.18.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 00:58:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] commit-graph: remove redundant handling of -h
Date:   Sun, 18 Jul 2021 09:58:06 +0200
Message-Id: <patch-2.5-6f386fc32c8-20210718T074936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.873.g94a0c75983d
In-Reply-To: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we don't handle the -h option here like most parse_options() users
we'll fall through and it'll do the right thing for us.

I think this code added in 4ce58ee38d (commit-graph: create
git-commit-graph builtin, 2018-04-02) was always redundant,
parse_options() did this at the time, and the commit-graph code never
used PARSE_OPT_NO_INTERNAL_HELP.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 4 ----
 t/t5318-commit-graph.sh | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c3fa4fde3e4..baead04a03b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -319,10 +319,6 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_graph_usage,
-				   builtin_commit_graph_options);
-
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_commit_graph_options,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index af88f805aa2..5fccce95724 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -5,6 +5,11 @@ test_description='commit graph'
 
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
+test_expect_success 'usage' '
+	test_expect_code 129 git commit-graph -h 2>err &&
+	! grep error: err
+'
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
-- 
2.32.0.873.g94a0c75983d

