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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E3C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE44E64EB2
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhCJTpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhCJTon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:44:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD4C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ha17so1458360pjb.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFp76Qv8hHZc5alYHtPgWg02sSI+wvny6olDlJAq4Cs=;
        b=kAQUScOA4flE71fI9hlLYRy7UuH+8nSbP8UmF4Rth55qbLxXsb4aBes/z9+B+KQo7d
         sURBIEOzYAp5n8K9adn+WAF9DNQ4cTFvtM1cA70Yi+17cvPxjUMKB1PZYqKwCsL1AFCF
         eFYOhQn+Ci7POPwiEq+z043KFv5AATDaD5GL/F4QYd6NEgFFeBqd0kbKyV7ZwP0nnViN
         XVos182cGK+GqDRTDEEimY7GwvFbqOEDKj8G3p3zb/3QlaQGjGPFzgpgLCIPAAN2m0WJ
         /7CzeaYaZwzh2pR70oj7OeuOnaMJkkzQLSjUkQR/cmhX2npiFvT96GH+0aBXV9qyqDK2
         X5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFp76Qv8hHZc5alYHtPgWg02sSI+wvny6olDlJAq4Cs=;
        b=hHhrbn/dai1TkZTUovpoMfjDxBmQsV1CKSHXSXunskWS6yzvdveR4rWtS9sD4lID35
         VjLE3g5hzI2ffKMJ5eXkztsriEseKYHmaK8SPeO++fmjPy41fRqlg/dAjntN9y6dr7we
         jhf72Old/34p4PfVLFUeYOopTXt6G+MwQ3k0G8WjRd/xG3fKlRhibVWjkrHpeNPx6iqK
         rOOh/9UF8vBMtBKSLiIIDlPQPzvVMlj0VX8g64VFC29J7JN8KmTQpuFn3w4VQ6UVNbuJ
         Ape9cd8/2waN+mdH/KLt4be7U7K2JjR279lqiA4YN5/5V6OU6DJjLM10RirMtEIxbxTm
         CCyw==
X-Gm-Message-State: AOAM533OSCn66mm/K9vuK/qw6ql+hcLUi0hBN+izzzHM+/tH9ilLH8xH
        VyeIpOls7PekAaVG6oZ3UubPP6k6i0dKPA==
X-Google-Smtp-Source: ABdhPJwtOz12U4wXoQmsPx5dPJlpnTQf6Q49Xz8VuNpO8RsuRyEAp5HigPa1pHKSobgZ65NfXNEaXg==
X-Received: by 2002:a17:902:9786:b029:e6:508a:7b8c with SMTP id q6-20020a1709029786b02900e6508a7b8cmr4498870plp.44.1615405482276;
        Wed, 10 Mar 2021 11:44:42 -0800 (PST)
Received: from localhost.localdomain ([2405:204:130f:1562:5082:417f:76e8:c75])
        by smtp.googlemail.com with ESMTPSA id p5sm296480pfq.56.2021.03.10.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:44:41 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 3/6] commit: add a reword suboption to --fixup
Date:   Thu, 11 Mar 2021 01:13:07 +0530
Message-Id: <20210310194306.32565-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
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
 builtin/commit.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 05594fa8ab..d8cec75888 100644
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
 /* returns the length of intial segment of alpha characters only */
 static size_t get_alpha_len(char *fixup_message) {
 	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
@@ -1276,17 +1289,22 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		 * reference for example: --fixup="HEAD^{/^area: string}" or
 		 * a suboption of `--fixup`.
 		 *
-		 * As `amend` suboption contains only alpha character.
-		 * So check if first non alpha character in fixup_message
-		 * is ':'.
+		 * As `amend`/`reword` suboptions contains only alpha
+		 * characters. So check if first non alpha character
+		 * in fixup_message is ':'.
 		 */
 		size_t len = get_alpha_len(fixup_message);
 		if (len && fixup_message[len] == ':') {
 			fixup_message[len++] = '\0';
 			fixup_commit = fixup_message + len;
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
@@ -1575,10 +1593,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

