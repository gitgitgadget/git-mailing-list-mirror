Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D0AC433E9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F3864E67
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCOHz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCOHzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:55:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5DEC061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so14284371pjg.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZJo+qTDGw2lHSsR8ykR059isACinLNeAYoWK62zVdA=;
        b=q1zqLvd8dbpsuKXI4OGdEhVoX8k8dbceQfPGw7qx6ApM+22fdoK8sDbbZMNL23z14Q
         sH762cnfcla/5bUnOuMYLZ0ziq1wX3SEo9H3Rp1ucOR8GnS1FjlMsvw4XvDSi4Vvwors
         9NLJAsVuaTsMOSD7s7IrmOSF/JlCxAxRp3eOdT8VC9xIeHPx5NnRMCjZ+Gewu93Ix384
         AyHqzvcZAv6VxWB6a0SE3nDTTv6VpLIfx81kIumuMURFgZ65/ptQysdhU3JPgKKJIEJM
         ARRylYMCHqYDL5xFMlIwqN08K6MrcK4ez7o43TnZ2RvQgQx5KJxLGTeQ8YAALDLpHKcf
         cNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZJo+qTDGw2lHSsR8ykR059isACinLNeAYoWK62zVdA=;
        b=Q7ILWtiO1aKyfyJhcNrqoziWvLtR9BrFsNvn6CnEaEDCzao2/OhMYsfqB/28HqUAnT
         PSdHb4QBP4GUna/CEpzx2f5kXG17rVny0hYRt2+1bR4VE1EbrTQ0FGVRcfr/JJDkNtwP
         VNI7q4n3ak6GwbI58CzrUGV6hnRXKilR+6tDfV/c9c1Cf7Nm7xxUaJ7osxel62MPer+R
         dSz0kp0+6ivOMuuxP3CMOBK+jASv7icMH0b076q7ewU2SPA2AG2iZESBFgJNNAnJz75u
         5YCKQ2ctPY0C2Q2auffIgZZqFIQ41BjZFxHlF17SWWJNblQDTGr6bh3ITvbBg5c/qUM0
         DAgQ==
X-Gm-Message-State: AOAM532tYLeD2ZkJIHISkJz/Fuz7JhWB9pgUCWYZJqXwX5LLRBCTKKlb
        PmVH2kw+V+UVszvFcwa/i+E2XWRpuSV8eg==
X-Google-Smtp-Source: ABdhPJwfg3AF/Bm1qW83qYEa1C/RtbAo25OPr0ORSTadeNuqLkplFo7d/Wsh4GpgV1tv/Anzquxhnw==
X-Received: by 2002:a17:903:228c:b029:e6:a755:1cc6 with SMTP id b12-20020a170903228cb02900e6a7551cc6mr7074640plh.83.1615794949078;
        Mon, 15 Mar 2021 00:55:49 -0700 (PDT)
Received: from localhost.localdomain ([223.233.99.139])
        by smtp.googlemail.com with ESMTPSA id fs9sm9350911pjb.40.2021.03.15.00.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 00:55:48 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 3/6] commit: add a reword suboption to --fixup
Date:   Mon, 15 Mar 2021 13:24:33 +0530
Message-Id: <20210315075435.18229-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --fixup=reword:<commit>` aliases
`--fixup=amend:<commit> --only`, where it creates an empty "amend!"
commit that will reword <commit> without changing its contents when
it is rebased with `--autosquash`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9697bba10b..b17e6e32f8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1188,6 +1188,19 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+static void check_fixup_reword_options(int argc, const char *argv[]) {
+	if (whence != FROM_COMMIT) {
+		if (whence == FROM_MERGE)
+			die(_("You are in the middle of a merge -- cannot reword."));
+		else if (is_from_cherry_pick(whence))
+			die(_("You are in the middle of a cherry-pick -- cannot reword."));
+	}
+	if (argc)
+		die(_("cannot combine reword option of --fixup with path '%s'"), *argv);
+	if (patch_interactive || interactive || all || also || only)
+		die(_("reword option of --fixup is mutually exclusive with --patch/--interactive/--all/--include/--only"));
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1269,8 +1282,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		 * We limit --fixup's suboptions to only alpha characters.
 		 * If the first character after a run of alpha is colon,
 		 * then the part before the colon may be a known suboption
-		 * name `amend` or a misspelt suboption name. In this case,
-		 * we treat it as --fixup=<suboption>:<arg>.
+		 * name like `amend` or `reword`, or a misspelt suboption
+		 * name. In either case, we treat it as
+		 * --fixup=<suboption>:<arg>.
 		 *
 		 * Otherwise, we are dealing with --fixup=<commit>.
 		 */
@@ -1280,9 +1294,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		if (p > fixup_message && *p == ':') {
 			*p = '\0';
 			fixup_commit = p + 1;
-			if (!strcmp("amend", fixup_message)) {
+			if (!strcmp("amend", fixup_message) ||
+			    !strcmp("reword", fixup_message)) {
 				fixup_prefix = "amend";
 				allow_empty = 1;
+				if (*fixup_message == 'r') {
+					check_fixup_reword_options(argc, argv);
+					only = 1;
+				}
 			} else {
 				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
 			}
@@ -1571,10 +1590,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
 		/*
-		 * TRANSLATORS: Leave "[amend:]" as-is, and
-		 * only translate <commit>.
+		 * TRANSLATORS: Leave "[(amend|reword):]" as-is,
+		 * and only translate <commit>.
 		 */
-		OPT_STRING(0, "fixup", &fixup_message, N_("[amend:]commit"), N_("use autosquash formatted message to fixup or amend specified commit")),
+		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
-- 
2.29.0.rc1

