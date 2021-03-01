Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816DFC43381
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5426E61494
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhCAIuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhCAIsC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:48:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594DAC06121D
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:46:43 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g20so9428958plo.2
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=YxqQsDI0zFyuBn5mSvfS9/jBCh8E3c+8ydIfalKbHAQ=;
        b=oJKmrYaK9upxEeMXb1wBgLNXtYqNB2jVtyt8XbKBbaDrLI4zwr6LPYAZzwu4DbBgx2
         HrsRJKGj0M+wtY2nSQqBl4ZignKVskScu+bEzruKyiNld0eT2ENbAaKFdNriVTt+UFzV
         8AqmkD+PaOXycUw4l3nkSK4mdxG2snCjJMAFXDXb7OQZUxHwjeS5Rbix7xK+FW5/8Ykz
         o6A6NkMNmk4uc1aii3dAfe9K6kFjM0fTHamQqMRvKRXc04w0DTEsXQ3ShSRyuD/TSIB7
         yAIBu0xK16PPXwRWsrX/SF+ESTHMkROmlzR4Vh60qebhzxeQoRULhk5OWJgcz9a0CJqC
         UZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=YxqQsDI0zFyuBn5mSvfS9/jBCh8E3c+8ydIfalKbHAQ=;
        b=femirNLgeSYT0xXtsGIoP8CCH+bO6z+DBjQhPrWiculDViaNwFP/zLODltMF/SUg8h
         ttw55Tyk4XusEUTEpSPp36T45LvaamgTTGwjfZ/1Um8xkRTXksZqF4hjuTwTZVp0v6Q/
         fHTUOd2OWBtHhAJAllniMKecLVrBQGhbAwUZIFEwAqg1FGwknVhpAfitFiR+6m4xhQ6w
         /Eh+BdByuBnBeT4WCRpMckawCT0nVFqIK1oz1xnnl8hR/LfEqpFH8m8IpdDG9OGVYRmE
         cZeExhv+7VmxcH3bxEI6eMJ2qbe4wXu0+zszw9m0iwtyUz8pambyHR8OmZvGtftYL9Qg
         iJiw==
X-Gm-Message-State: AOAM530I1L8Qt8IPlFCoQx3lDaDyM/y4heyWn024YW85ySqYCnnMZYw9
        XVCyUTsPn8SXYAcgOPxOqjIm0p4SfIkBwA==
X-Google-Smtp-Source: ABdhPJx60w4OnItFzNrndXHGVyRctp6I971TIQ5kvOen6LMduRyHkj20zMVpKOFwp6YyBeUhIdDefw==
X-Received: by 2002:a17:90a:4083:: with SMTP id l3mr16651583pjg.109.1614588402668;
        Mon, 01 Mar 2021 00:46:42 -0800 (PST)
Received: from localhost.localdomain ([2405:204:302d:d8af:c047:a272:aff7:4de6])
        by smtp.googlemail.com with ESMTPSA id b34sm16781426pgl.63.2021.03.01.00.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:46:42 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/6] commit: add a reword suboption to --fixup
Date:   Mon,  1 Mar 2021 14:15:11 +0530
Message-Id: <20210301084512.27170-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
Reply-To: 20210217072904.16257-1-charvi077@gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --fixup=reword:<commit>` creates an empty "amend!" commit
that will reword <commit> without changing its contents when it is
rebased with --autosquash.

Apart from ignoring staged changes it works similarly to
`--fixup=amend:<commit>`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 200ef83cc0..a4d18d96df 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1186,6 +1186,27 @@ static void finalize_deferred_config(struct wt_status *s)
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
+		die(_("cannot combine reword option of --fixup with path %s"), *argv);
+	if (patch_interactive)
+		die(_("cannot combine reword option of --fixup with --patch"));
+	if (interactive)
+		die(_("cannot combine reword option of --fixup with --interactive"));
+	if (all)
+		die(_("cannot combine reword option of --fixup with --all"));
+	if (also)
+		die(_("cannot combine reword option of --fixup with --include"));
+	if (only)
+		die(_("cannot combine reword option of --fixup with --only"));
+}
+
 /* returns the length of intial segment of alpha characters only */
 static size_t get_alpha_len(char *fixup_message) {
 	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
@@ -1270,18 +1291,25 @@ static int parse_and_validate_options(int argc, const char *argv[],

 	if (fixup_message) {
 		/*
-		 * As `amend` suboption contains only alpha
-		 * character. So check if first non alpha
-		 * character in fixup_message is ':'.
+		 * As `amend`/`reword` suboptions contains only alpha
+		 * characters. So check if first non alpha character
+		 * in fixup_message is ':'.
 		 */
 		size_t len = get_alpha_len(fixup_message);
 		if (len && fixup_message[len] == ':') {
 			fixup_message[len++] = '\0';
 			fixup_commit = fixup_message + len;
-			if (starts_with("amend", fixup_message))
+			if (starts_with("amend", fixup_message) ||
+			    starts_with("reword", fixup_message)) {
 				fixup_prefix = "amend";
-			else
+				if (*fixup_message == 'r') {
+					check_fixup_reword_options(argc, argv);
+					allow_empty = 1;
+					only = 1;
+				}
+			} else {
 				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
+			}
 		} else {
 			fixup_commit = fixup_message;
 			fixup_prefix = "fixup";
@@ -1567,10 +1595,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

