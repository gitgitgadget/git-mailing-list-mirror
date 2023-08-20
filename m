Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFA6EE49A8
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 09:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHTJAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjHTJAB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 05:00:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96826A2
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so3118161fa.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521697; x=1693126497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7XFeevufjAjcE2XkTtR0tFM7aOlYpNqLsPQ1W9Wbzs=;
        b=RntkbZzIYRXt8WrHDk8gksoNyvOOFdH5CcPVsgP5TAnofbb2yezWaYm+jyqVLbrBB8
         T9fBwVKtXuR97eIp9rvodluDaqOxLNFDEZik3UQ6tp+QMRAxWtjVQ5Et2rp+vaYN20E5
         NZDTFh4/8J5Jmeq0odOLBrCMxRL0suggsN2YXEm6c3+xAyaZ/MCh9dM4fFkGzAd8rH75
         xLyKlDvB/2PQhiLtGw2NF4inn9bIGVUc8hINuZifnn5bSld6b9WFNYUe0oxMvJ1KjcLR
         lg4yq2AEqNcWY2L8n8YhiPDwrH93KoqzIAKHJm/qAE+dX3OQIY6XhKUCWhjVq1PbuX/B
         aLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521697; x=1693126497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7XFeevufjAjcE2XkTtR0tFM7aOlYpNqLsPQ1W9Wbzs=;
        b=AbolgSAa4BG/zcXNEZODX/m6fFMilglyEOIJx42vQQIzMX0Cv494f/WqT5IfvbBH2O
         k5wqu9rsHrvLcWNBeR0ZqxUzHp5b3lg50tqqOUM5OkZUdXNCMPWGkDpC7sDXu7Tf8QI2
         FSpT3gTSkRsDfzqd5OUhtXkW3EO8FW4IW3ThsaFlBhT1Z05091n9kn3bgg39yh3zTMxf
         1+xWmNTCIe+gG4Rg6kP6sb+F4k6ROPWhvQLr4qeMbVNe0VnjsufocNJyvUt2WMC88AeK
         fdKY02EOcRYdbNHzUdW/HG/L60407bO5fZ5h0YXsg2kgxflSiG1PWHSPqHH1UtkN+bas
         wgcA==
X-Gm-Message-State: AOJu0Yy62Mkjeq7HqfeEyVkdK+ABRIlAKgehlmuHzrHbsG+Q0GwKC4py
        L2De0lyDaA6pUq9T4153R0fuYyBKbOypFYb9
X-Google-Smtp-Source: AGHT+IETm5fpQRKZWPCvLKT2hMX3MnoiNaf+ZEI1RnbnQJrwALcBB6CGEHCNJwQeT42sosQynStzyg==
X-Received: by 2002:a05:6512:3e9:b0:4ff:7046:984a with SMTP id n9-20020a05651203e900b004ff7046984amr2322028lfq.7.1692521696628;
        Sun, 20 Aug 2023 01:54:56 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:56 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 5/8] decorate: color each token separately
Date:   Sun, 20 Aug 2023 09:53:33 +0100
Message-ID: <20230820085336.8615-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap "tag:" prefixes and the arrows in "HEAD -> branch" decorations in
their own color sequences. Otherwise, if --graph is used, tag names or
arrows can end up uncolored when %w width formatting breaks a line just
before them. This is because --graph resets the color after doing its
drawing at the start of a line.

Amend test t4207-log-decoration-colors.sh accordingly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c                       | 14 +++++++---
 t/t4207-log-decoration-colors.sh | 44 ++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7c6d3f1ac3..44f4693567 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -342,26 +342,34 @@ void format_decorations(struct strbuf *sb,
 		 * appeared, skipping the entry for current.
 		 */
 		if (decoration != current_and_HEAD) {
+			const char *color =
+				decorate_get_color(use_color, decoration->type);
+
 			if (*prefix) {
 				strbuf_addstr(sb, color_commit);
 				strbuf_addstr(sb, prefix);
 				strbuf_addstr(sb, color_reset);
 			}
 
-			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-			if (decoration->type == DECORATION_REF_TAG)
+			if (decoration->type == DECORATION_REF_TAG) {
+				strbuf_addstr(sb, color);
 				strbuf_addstr(sb, "tag: ");
+				strbuf_addstr(sb, color_reset);
+			}
 
+			strbuf_addstr(sb, color);
 			show_name(sb, decoration);
+			strbuf_addstr(sb, color_reset);
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
+				strbuf_addstr(sb, color);
 				strbuf_addstr(sb, " -> ");
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
 				show_name(sb, current_and_HEAD);
+				strbuf_addstr(sb, color_reset);
 			}
-			strbuf_addstr(sb, color_reset);
 
 			prefix = separator;
 		}
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index ded33a82e2..df804f38e2 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -53,15 +53,17 @@ cmp_filtered_decorations () {
 # to this test since it does not contain any decoration, hence --first-parent
 test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
-${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit}, \
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
 ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset} \
-On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -76,12 +78,14 @@ test_expect_success 'test coloring with replace-objects' '
 	git replace HEAD~1 HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
-${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -100,13 +104,15 @@ test_expect_success 'test coloring with grafted commit' '
 	git replace --graft HEAD HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
-${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.42.0-rc2

