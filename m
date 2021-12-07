Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45397C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 07:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhLGHPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 02:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLGHPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 02:15:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596FEC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 23:12:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so24333124ybd.9
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 23:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=abEHzKa4cBkgbhBZq0FDw8rNbri2bKUujK1nu7Y7UoM=;
        b=E8q5PEAZ15/C63R8Niwre9HD65uvuHoF6LubB0GNQ2/0C+HLPwzVcQsWHw9mgmXzEv
         kW7/cjl3Suu8kzyL5KqJvofRL8cHYzencFdQYdmSFCjprtkj0o5+tLK0gPvjWtkEV3wK
         zTQ1QuiFxGQfjke7IrrQ+VhWAqJs4BEGl/SqYeMeD5fS+7dDXuOpG+srYJIYRS+nW3ui
         Pv5lsTOYvT3lq7rirhVphqw0LAlo1GbK3WVwRcyxx+hPEK0uLbU2m8n474zu42w8ri4W
         jyinJTWwNkwoocINOVDiKhkRNiPWwOrXignq+qFCeNdnmPdFOoVnfnF2c7KRkOkEVDHp
         62iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=abEHzKa4cBkgbhBZq0FDw8rNbri2bKUujK1nu7Y7UoM=;
        b=Gn51aExJMjCOcY5Nc9SQcjeWiQMAP8VI5mSZFPUp/vH0UAuNZqcJfSQuFOX02yOso3
         yRKgV1Dxj3I0q4YbbjpIrAi33j1iFR5ZBzTsD73WhUYffD6Psm6Y3/g/Jfyb8ssI00uN
         srCF1KJ/YeFgP5X5xdOKQYXXtdvehpXKXbEsDUO4/PEqPcIDTZ7H2qcaM+EzJm7KYwNP
         PGy6jW+5Ii6shtiQ8w9unqPl3L3gBUSM4xU/+0OYh6dcT327X3+SSS77/7JGl6IJZfcX
         WCvjxgY13RVi+oi3V8ZChS0plRFv+UTXnWQvQdpXcyzL3ENVA7M1mjwpMkprbin0XqT4
         vtKQ==
X-Gm-Message-State: AOAM530Q6b00m0nEiFPU9bA9r0PP91rFnmMMUKxvxGh+20bA96a4N50K
        Y+OaNmUHCjsB4WVPzOthEedMW1UkqWJtqxP9CLwYJDc961cuUjBLZ8NIxvPxu8ecLe4GxvYYG+f
        9xlcQhVURK+16ESLX6ZG0abKYUZifpwpAUhA6LWE+ymqwconKpoT1YoA1f+m83OY=
X-Google-Smtp-Source: ABdhPJzRSeU+jdIGxPwyNAwjXvt6iAgC1XDaE+xa7zR5zDN57QQCdtTvF68QMrPiPkwGkgzxAbCoR94dj1Ww/A==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:7544:926d:50a3:e38b])
 (user=steadmon job=sendgmr) by 2002:a25:d98c:: with SMTP id
 q134mr45570137ybg.329.1638861133524; Mon, 06 Dec 2021 23:12:13 -0800 (PST)
Date:   Mon,  6 Dec 2021 23:12:07 -0800
In-Reply-To: <cover.1638859949.git.steadmon@google.com>
Message-Id: <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, emilyshaffer@google.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new static variant of install_branch_config() that accepts
multiple remote branch names for tracking. This will be used in an
upcoming commit that enables inheriting the tracking configuration from
a parent branch.

Currently, all callers of install_branch_config() pass only a single
remote. Make install_branch_config() a small wrapper around
install_branch_config_multiple_remotes() so that existing callers do not
need to be changed.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 branch.c | 120 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 87 insertions(+), 33 deletions(-)

diff --git a/branch.c b/branch.c
index 7a88a4861e..1aabef4de0 100644
--- a/branch.c
+++ b/branch.c
@@ -55,19 +55,24 @@ N_("\n"
 "the remote tracking information by invoking\n"
 "\"git branch --set-upstream-to=%s%s%s\".");
 
-int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+static int install_branch_config_multiple_remotes(int flag, const char *local, const char *origin,
+		struct string_list *remotes)
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
-	int rebasing = should_setup_rebase(origin);
-
-	if (skip_prefix(remote, "refs/heads/", &shortname)
-	    && !strcmp(local, shortname)
-	    && !origin) {
-		warning(_("Not setting branch %s as its own upstream."),
-			local);
-		return 0;
-	}
+	int i, rebasing = should_setup_rebase(origin);
+
+	if (remotes->nr < 1)
+		BUG("must provide at least one remote for branch config");
+
+	if (!origin)
+		for (i = 0; i < remotes->nr; i++)
+			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)
+			    && !strcmp(local, shortname)) {
+				warning(_("Not setting branch %s as its own upstream."),
+					local);
+				return 0;
+			}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
 	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
@@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	if (git_config_set_gently(key.buf, remote) < 0)
+	/*
+	 * We want to overwrite any existing config with all the branches in
+	 * "remotes". Override any existing config with the first branch, but if
+	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
+	 * we've written so far.
+	 */
+	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
 		goto out_err;
+	for (i = 1; i < remotes->nr; i++)
+		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string, CONFIG_REGEX_NONE, 0) < 0)
+			goto out_err;
 
 	if (rebasing) {
 		strbuf_reset(&key);
@@ -87,29 +101,62 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (shortname) {
-			if (origin)
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
-					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
-					  local, shortname, origin);
-			else
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
-					  _("Branch '%s' set up to track local branch '%s'."),
-					  local, shortname);
+		int plural = remotes->nr > 1;
+		int all_shortnames = 1;
+		const char *msg_fmt;
+		struct strbuf ref_string = STRBUF_INIT;
+
+		for (i = 0; i < remotes->nr; i++)
+			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)) {
+				strbuf_addf(&ref_string, "'%s', ", shortname);
+			} else {
+				all_shortnames = 0;
+				strbuf_addf(&ref_string, "'%s', ", remotes->items[i].string);
+			}
+		/* The last two characters are an extraneous ", ", so trim those. */
+		strbuf_setlen(&ref_string, ref_string.len - 2);
+
+		if (all_shortnames && origin) {
+			if (rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s' by rebasing.";
+			else if (rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s' by rebasing.";
+			else if (!rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s'.";
+			else if (!rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s'.";
+
+			printf_ln(_(msg_fmt), local, ref_string, origin);
 		} else {
-			if (origin)
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
-					  _("Branch '%s' set up to track remote ref '%s'."),
-					  local, remote);
-			else
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
-					  _("Branch '%s' set up to track local ref '%s'."),
-					  local, remote);
+			if (all_shortnames && !origin && rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track local branches %s by rebasing.";
+			if (all_shortnames && !origin && rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track local branch %s by rebasing.";
+			if (all_shortnames && !origin && !rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track local branches %s.";
+			if (all_shortnames && !origin && !rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track local branch %s.";
+			if (!all_shortnames && origin && rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track remote refs %s by rebasing.";
+			if (!all_shortnames && origin && rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track remote ref %s by rebasing.";
+			if (!all_shortnames && origin && !rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track remote refs %s.";
+			if (!all_shortnames && origin && !rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track remote ref %s.";
+			if (!all_shortnames && !origin && rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track local refs %s by rebasing.";
+			if (!all_shortnames && !origin && rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track local ref %s by rebasing.";
+			if (!all_shortnames && !origin && !rebasing && plural)
+				msg_fmt = "Branch '%s' set up to track local refs %s.";
+			if (!all_shortnames && !origin && !rebasing && !plural)
+				msg_fmt = "Branch '%s' set up to track local ref %s.";
+
+			printf_ln(_(msg_fmt), local, ref_string);
 		}
+
+		strbuf_release(&ref_string);
 	}
 
 	return 0;
@@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	advise(_(tracking_advice),
 	       origin ? origin : "",
 	       origin ? "/" : "",
-	       shortname ? shortname : remote);
+	       remotes->items[0].string);
 
 	return -1;
 }
 
+int install_branch_config(int flag, const char *local, const char *origin, const char *remote) {
+	struct string_list remotes = STRING_LIST_INIT_DUP;
+	string_list_append(&remotes, remote);
+	return install_branch_config_multiple_remotes(flag, local, origin, &remotes);
+	string_list_clear(&remotes, 0);
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
-- 
2.34.1.400.ga245620fadb-goog

