Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A5620282
	for <e@80x24.org>; Wed, 21 Jun 2017 02:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbdFUCh4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 22:37:56 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35436 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbdFUChz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 22:37:55 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so24936861pgc.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 19:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/wLmBWuFPkNFHKfb0+addDO3wNsfFlsdE+9zgSSnJc=;
        b=rXnwrYl5OAzGxmn7l6TJYaNGhHVkh0TOj2A1tbCg7KjU30xKrt5JDppypv//OmoK9G
         aIcqZY3VaUnM1M23fFPHRxVvlsjv0p/PIukj4FtfDlAYA/hwprqI51Co4sJ5KmbFcDtg
         rBXreVDUKcVBmu0WLaHrf4I7XCCjQtOQn3oORUYtY0FKuJX1RvNdknVCxyQ9DGRbDjpx
         nSHZCnBdUdiOFIzStlSBIu9qTrcwbQueFNQLllU41IQiSrXJ5Gv3hhKNV7hi3HkeFtYI
         9TNETNGpWv+emP4TcXmnZ91LEmLsaks/8MhbFvbPVkJ+Ks2RcKQedqc1hpt40N6SRYJi
         riEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/wLmBWuFPkNFHKfb0+addDO3wNsfFlsdE+9zgSSnJc=;
        b=W9Pizxkc9x+9+Ml/+BIb4d2pRlVm3bzOYgglfgbnUEGdmM3qcL2qUz5QQDRHtnMRMU
         hh3laXX6yXhvE/mELwIzjYIweL+xmiYNmaRgtfjey85RGlGi0z8JnTDuj37s1sLiomps
         XX4oF80r5pskat6l0o/Yny+Z8cYA8izdGUSweX/lsxL+KwKS9xzRUNb3S2G76vvdLLMq
         YQbXeU1mzXnVipmtEbtlWQAEt7WH1qc1WnwKUsebnB1rWUtliOQ3L80Va1c2hRNIsgrg
         4JIn8SYAdGUeAws9wcTzCVLtab8FFxOMhSA4glqvzWUTyt3rFJg0tdTorRm6XOlHULgR
         fNhQ==
X-Gm-Message-State: AKS2vOxUbndF96FquPMJDUDEz0JBGdtS6GZg/XBGI78FMDuUyBlHFbYj
        SlMue1bXYeB9kw==
X-Received: by 10.99.106.66 with SMTP id f63mr34602561pgc.150.1498012675104;
        Tue, 20 Jun 2017 19:37:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:850b:870a:56ff:b236:2b2d:3a08])
        by smtp.gmail.com with ESMTPSA id z4sm26580899pgc.22.2017.06.20.19.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 19:37:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH/FINAL] status: contextually notify user about an initial commit
Date:   Wed, 21 Jun 2017 08:07:29 +0530
Message-Id: <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1498012463.1487.2.camel@gmail.com>
References: <1498012463.1487.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing message, "Initial commit", makes sense for the commit template
notifying users that it's their initial commit, but is confusing when
merely checking the status of a fresh repository (or orphan branch)
without having any commits yet.

Change the output of "status" to say "No commits yet" when "git
status" is run on a fresh repo (or orphan branch), while retaining the
current "Initial commit" message displayed in the template that's
displayed in the editor when the initial commit is being authored.

A few alternatives considered were,

 * Waiting for initial commit
 * Your current branch does not have any commits
 * Current branch waiting for initial commit

The most succint one among the alternatives was chosen.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

 The 'FINAL' part in the subject is just my opinion about 
 this patch

 builtin/commit.c  |  1 +
 t/t7501-commit.sh |  2 +-
 t/t7508-status.sh | 30 ++++++++++++++++++++++++++++++
 wt-status.c       |  5 ++++-
 wt-status.h       |  1 +
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..3d614a2ac 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1648,6 +1648,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
+	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0b6da7ae1..fa61b1a4e 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -18,7 +18,7 @@ test_expect_success 'initial status' '
 	echo bongo bongo >file &&
 	git add file &&
 	git status >actual &&
-	test_i18ngrep "Initial commit" actual
+	test_i18ngrep "No commits yet" actual
 '
 
 test_expect_success 'fail initial amend' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 5edcc6edf..0ffa585e2 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1499,4 +1499,34 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success '"No commits yet" should be noted in status output' '
+	git checkout --orphan empty-branch-1 &&
+	git status >output &&
+	test_i18ngrep "No commits yet" output
+'
+
+test_expect_success '"No commits yet" should not be noted in status output' '
+	git checkout --orphan empty-branch-2 &&
+	test_commit test-commit-1 &&
+	git status >output &&
+	test_must_fail test_i18ngrep "No commits yet" output
+'
+
+test_expect_success '"Initial commit" should be noted in commit template' '
+	git checkout --orphan empty-branch-3 &&
+	touch to_be_committed_1 &&
+	git add to_be_committed_1 &&
+	git commit --dry-run >output &&
+	test_i18ngrep "Initial commit" output
+'
+
+test_expect_success '"Initial commit" should not be noted in commit template' '
+	git checkout --orphan empty-branch-4 &&
+	test_commit test-commit-2 &&
+	touch to_be_committed_2 &&
+	git add to_be_committed_2 &&
+	git commit --dry-run >output &&
+	test_must_fail test_i18ngrep "Initial commit" output
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 068de38b5..a2e294bb2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1578,7 +1578,10 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commits yet"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 8a3864783..2389f0839 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -76,6 +76,7 @@ struct wt_status {
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
 	int null_termination;
+	int commit_template;
 	int show_branch;
 	int hints;
 
-- 
2.11.0

