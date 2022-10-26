Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE5FC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiJZVcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiJZVct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:32:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E4143A47
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e15so14806263iof.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4eeS7Tlo6XOhUop9/hsPUWJ03Wk3aXdJfiCl9rKGEE=;
        b=OUqK05dDHFTD5K2tPe4lXaxK31vgZCTncRdwTsKVrbtV/5h9sF7QeteilDFADLCfZJ
         fqm1wKhdyTE6e3sy3xPpMbiJD2a2vT0l0VxA1KF7LVEzO+DNTVV0vjTZzvFZLKZTl80+
         WecDckesfIBpj03tAH7Mfsyz5FHsyDG1dOJ3liyma/5Wid9VXYHuHHnqit1SiDj5QkXG
         Fzcs4ouqN99uE2HV6jgySqK/wwYOqt7hMW9vpcgY+wJLZnlhajHnJ5wfyNEeyzYdyJkC
         KtG1OZY22YoET06VwS8C17MpVpoJuJrAQQdLalCcs0PumVvAp7kbuLgJvOm7GdeYt6oN
         nnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4eeS7Tlo6XOhUop9/hsPUWJ03Wk3aXdJfiCl9rKGEE=;
        b=7Mj+4Ga07s58VoQe1wGh7OceG4VkBmUi1lkJs1ThF8g68PMlvHRlq9FuHWc0z9J0EZ
         /7uxMh8hxCgx2252sY2WJXQ5q24X4Py/RgmTfihE+3lmYplTyrGmLhW4zWdV6UlULCVF
         fMHIhFj5Zmgw4ydnXPEstRLfpij88SQ7ATASpKUYv5/TWQnD3GcfFG//JinQOjz3mDdF
         15pXRGX93dvFhmZND7kzxQdrStf/cSJUiyhy3KRfrnU7taQ82qEqUy/FVRTsjg1+3SmF
         Gs/099ctwi1e/U2XCRkCCOAJrPugPgPECbK34JrT99Dw2ctBP1IZg0mONlBDQHfCLEO/
         D0gA==
X-Gm-Message-State: ACrzQf0GAA0fWy0qNfAr8mTegiofMLFmSw3Q1w9tjrsTOp31Xfgq0k5h
        P5lxELv9tF70Zwmh9LMWC0Sv4jjqr2pqIAg6
X-Google-Smtp-Source: AMsMyM4H8Ru3tnLgpVZ116boxutw4xktY9cGkZqy6bphq1w/6d/Ysp0X3mpq9IEPAsCsdXiG1y3Cxw==
X-Received: by 2002:a05:6638:258c:b0:363:e62f:4b2f with SMTP id s12-20020a056638258c00b00363e62f4b2fmr30570810jat.63.1666819967237;
        Wed, 26 Oct 2022 14:32:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i20-20020a0566022c9400b006c05ff4cd91sm2086923iow.35.2022.10.26.14.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:32:46 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:32:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v3 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
Message-ID: <13a25a425bc0901ee38760095eb1bcf314c00da2.1666819953.git.me@ttaylorr.com>
References: <cover.1666815209.git.me@ttaylorr.com>
 <cover.1666819953.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666819953.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

We are interested in exploring whether gc.cruftPacks=true should become
the default value.

To determine whether it is safe to do so, let's encourage more users to
try it out.

Users who have set feature.experimental=true have already volunteered to
try new and possibly-breaking config changes, so let's try this new
default with that set of users.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/feature.txt |  3 ++
 builtin/gc.c                     |  7 +++--
 repo-settings.c                  |  1 +
 repository.h                     |  1 +
 t/t6500-gc.sh                    | 53 ++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index cdecd04e5b..95975e5091 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -14,6 +14,9 @@ feature.experimental::
 +
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
++
+* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
+garbage collection, preventing loose object explosions.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/builtin/gc.c b/builtin/gc.c
index 243ee85d28..5a84f791ef 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -42,7 +42,7 @@ static const char * const builtin_gc_usage[] = {
 
 static int pack_refs = 1;
 static int prune_reflogs = 1;
-static int cruft_packs = 0;
+static int cruft_packs = -1;
 static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
@@ -593,6 +593,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
 		die(_("failed to parse prune expiry value %s"), prune_expire);
 
+	prepare_repo_settings(the_repository);
+	if (cruft_packs < 0)
+		cruft_packs = the_repository->settings.gc_cruft_packs;
+
 	if (aggressive) {
 		strvec_push(&repack, "-f");
 		if (aggressive_depth > 0)
@@ -704,7 +708,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 	}
 
-	prepare_repo_settings(the_repository);
 	if (the_repository->settings.gc_write_commit_graph == 1)
 		write_commit_graph_reachable(the_repository->objects->odb,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
diff --git a/repo-settings.c b/repo-settings.c
index e8b58151bc..3021921c53 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -43,6 +43,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults modified by feature.* */
 	if (experimental) {
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		r->settings.gc_cruft_packs = 1;
 	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
diff --git a/repository.h b/repository.h
index 24316ac944..6c461c5b9d 100644
--- a/repository.h
+++ b/repository.h
@@ -34,6 +34,7 @@ struct repo_settings {
 	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
+	int gc_cruft_packs;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
 	int sparse_index;
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 928a522194..d9acb63951 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -221,6 +221,11 @@ assert_cruft_packs () {
 	done <packs
 }
 
+assert_no_cruft_packs () {
+	find .git/objects/pack -name "*.mtimes" >mtimes &&
+	test_must_be_empty mtimes
+}
+
 test_expect_success 'gc --cruft generates a cruft pack' '
 	test_when_finished "rm -fr crufts" &&
 	git init crufts &&
@@ -245,6 +250,54 @@ test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
 	)
 '
 
+test_expect_success 'feature.experimental=true generates a cruft pack' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c feature.experimental=true gc &&
+		assert_cruft_packs
+	)
+'
+
+test_expect_success 'feature.experimental=false allows explicit cruft packs' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
+		assert_cruft_packs
+	)
+'
+
+test_expect_success 'feature.experimental=true can be overridden' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c feature.expiremental=true -c gc.cruftPacks=false gc &&
+		assert_no_cruft_packs
+	)
+'
+
+test_expect_success 'feature.experimental=false avoids cruft packs by default' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c feature.experimental=false gc &&
+		assert_no_cruft_packs
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.38.0.16.g393fd4c6db
