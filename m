Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA93C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 03:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhLUDab (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhLUDaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 22:30:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F51C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q123-20020a252a81000000b00609e97bb74bso2566288ybq.5
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TAoKLozyxjGYkJWhEXkW5/D6svKLgZZQ3aaXvbXQZ6w=;
        b=Gd9GKGlCa72UA9SNcYMNCzEJZHJW9VqxcErVV/MCgEbYnla7leTHkq5lMxJDfPdii2
         0p2kedKvUWTSfMkjMasNv0VjjbRMSflXObvVpJTrHA5H7PB/gs1O8vnOacpBVaLYvgU2
         peNpnN8cm7rdvCmRyG90t8kYMQW/Lem5fVilWRO2+W1gAFP46Ia4XpmjFGdh818ebK8o
         Oo3Y6I2S0MoawvlQa4TEtkaghsLcUzM9oYqGa1vxpqSR7VRAwWKPr251PdGjVYPcYNvw
         abhoGWWHsUkMmLn0aDaPDparWR6gN85akreyjwMb/OPUwz03qT+eSiUwRduuCgwPp3Sp
         fZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TAoKLozyxjGYkJWhEXkW5/D6svKLgZZQ3aaXvbXQZ6w=;
        b=YaG+HTKbbtexyppWNdB3pC657KeS30WsSROGnA7l7CWESNsghSRv6XbhXQ9M5odJGF
         uWFy/fEUnUNeuQXea2+MzZmwGkjwC6+P5FgwdvEyppYANSpjolORS5QKbRa0bEDpxHU7
         pZ3CkSQVl41pxWVHcQrg9HGn0bLRGLljEmLeM4Y/vllXc3Ytnnde7fthg3BgWYre79Mp
         Vilyt/CvbOU1KBcYZQVvnf9jbFT26LO+sl9uGy69Zvh26+ogDZ2di2X4bO9wNWlQjFP6
         rO92sbNh8+qWk35718cjB5oF+iRYnwqChnldGFgdhgJsUcyyHzUKbp6+9qb3VRrKKgil
         xKOw==
X-Gm-Message-State: AOAM5304XANP8A1XlBI8Nwclfwa4zgwAHNa0my3IjzOZZGHuEp/tD7zH
        Pfp1GG4faW053Xtt2psvp6+22C628s0X8II34P5Ky+LS1s97chVJjlVGo+0cv9pahFDkHxiYTfI
        U8Dwj0tZhxwpkRoW8PK19cZX2MpxePti9IgEy37kuxQaLq2BfUsJ7HsUwjjQO3wQ=
X-Google-Smtp-Source: ABdhPJzs3lRlSYK2igvY4BAAtbZAXS7eFg6Snk88IOj+RmAOk9eyCRDBpBN44v61HlDWGg99w3Y3TRvbnxciqw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:e4d8:c4fc:fa70:c18e])
 (user=steadmon job=sendgmr) by 2002:a25:7313:: with SMTP id
 o19mr1763505ybc.590.1640057429396; Mon, 20 Dec 2021 19:30:29 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:30:22 -0800
In-Reply-To: <cover.1640039978.git.steadmon@google.com>
Message-Id: <a5265e1c7f4dc1a69e85511d2cc3f659cc46788f.1640039978.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v8 1/3] branch: accept multiple upstream branches for tracking
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, chooglen@google.com
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
 branch.c          | 143 +++++++++++++++++++++++++++++++++-------------
 t/t3200-branch.sh |   6 +-
 2 files changed, 106 insertions(+), 43 deletions(-)

diff --git a/branch.c b/branch.c
index 7a88a4861e..a41a300f9c 100644
--- a/branch.c
+++ b/branch.c
@@ -49,25 +49,46 @@ static int should_setup_rebase(const char *origin)
 	return 0;
 }
 
-static const char tracking_advice[] =
-N_("\n"
-"After fixing the error cause you may try to fix up\n"
-"the remote tracking information by invoking\n"
-"\"git branch --set-upstream-to=%s%s%s\".");
-
-int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
+/**
+ * Install upstream tracking configuration for a branch; specifically, add
+ * `branch.<name>.remote` and `branch.<name>.merge` entries.
+ *
+ * `flag` contains integer flags for options; currently only
+ * BRANCH_CONFIG_VERBOSE is checked.
+ *
+ * `local` is the name of the branch whose configuration we're installing.
+ *
+ * `origin` is the name of the remote owning the upstream branches. NULL means
+ * the upstream branches are local to this repo.
+ *
+ * `remotes` is a list of refs that are upstream of local
+ */
+static int install_branch_config_multiple_remotes(int flag, const char *local,
+		const char *origin, struct string_list *remotes)
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
+	struct string_list_item *item;
 	int rebasing = should_setup_rebase(origin);
 
-	if (skip_prefix(remote, "refs/heads/", &shortname)
-	    && !strcmp(local, shortname)
-	    && !origin) {
-		warning(_("Not setting branch %s as its own upstream."),
-			local);
-		return 0;
-	}
+	if (!remotes->nr)
+		BUG("must provide at least one remote for branch config");
+	if (rebasing && remotes->nr > 1)
+		die(_("cannot inherit upstream tracking configuration of "
+		      "multiple refs when rebasing is requested"));
+
+	/*
+	 * If the new branch is trying to track itself, something has gone
+	 * wrong. Warn the user and don't proceed any further.
+	 */
+	if (!origin)
+		for_each_string_list_item(item, remotes)
+			if (skip_prefix(item->string, "refs/heads/", &shortname)
+			    && !strcmp(local, shortname)) {
+				warning(_("not setting branch '%s' as its own upstream."),
+					local);
+				return 0;
+			}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
 	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
@@ -75,8 +96,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	if (git_config_set_gently(key.buf, remote) < 0)
+	/*
+	 * We want to overwrite any existing config with all the branches in
+	 * "remotes". Override any existing config, then write our branches. If
+	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
+	 * we've written so far.
+	 */
+	if (git_config_set_gently(key.buf, NULL) < 0)
 		goto out_err;
+	for_each_string_list_item(item, remotes)
+		if (git_config_set_multivar_gently(key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
+			goto out_err;
 
 	if (rebasing) {
 		strbuf_reset(&key);
@@ -87,29 +117,40 @@ int install_branch_config(int flag, const char *local, const char *origin, const
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
+		struct strbuf tmp_ref_name = STRBUF_INIT;
+		struct string_list friendly_ref_names = STRING_LIST_INIT_DUP;
+
+		for_each_string_list_item(item, remotes) {
+			shortname = item->string;
+			skip_prefix(shortname, "refs/heads/", &shortname);
+			if (origin) {
+				strbuf_addf(&tmp_ref_name, "%s/%s",
+					    origin, shortname);
+				string_list_append_nodup(
+					&friendly_ref_names,
+					strbuf_detach(&tmp_ref_name, NULL));
+			} else {
+				string_list_append(
+					&friendly_ref_names, shortname);
+			}
+		}
+
+		if (remotes->nr == 1) {
+			/*
+			 * Rebasing is only allowed in the case of a single
+			 * upstream branch.
+			 */
+			printf_ln(rebasing ?
+				_("branch '%s' set up to track '%s' by rebasing.") :
+				_("branch '%s' set up to track '%s'."),
+				local, friendly_ref_names.items[0].string);
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
+			printf_ln(_("branch '%s' set up to track:"), local);
+			for_each_string_list_item(item, &friendly_ref_names)
+				printf_ln("  %s", item->string);
 		}
+
+		string_list_clear(&friendly_ref_names, 0);
 	}
 
 	return 0;
@@ -118,14 +159,36 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	strbuf_release(&key);
 	error(_("Unable to write upstream branch configuration"));
 
-	advise(_(tracking_advice),
-	       origin ? origin : "",
-	       origin ? "/" : "",
-	       shortname ? shortname : remote);
+	advise(_("\nAfter fixing the error cause you may try to fix up\n"
+		"the remote tracking information by invoking:"));
+	if (remotes->nr == 1)
+		advise("  git branch --set-upstream-to=%s%s%s",
+			origin ? origin : "",
+			origin ? "/" : "",
+			remotes->items[0].string);
+	else {
+		advise("  git config --add branch.\"%s\".remote %s",
+			local, origin ? origin : ".");
+		for_each_string_list_item(item, remotes)
+			advise("  git config --add branch.\"%s\".merge %s",
+				local, item->string);
+	}
 
 	return -1;
 }
 
+int install_branch_config(int flag, const char *local, const char *origin,
+		const char *remote)
+{
+	int ret;
+	struct string_list remotes = STRING_LIST_INIT_DUP;
+
+	string_list_append(&remotes, remote);
+	ret = install_branch_config_multiple_remotes(flag, local, origin, &remotes);
+	string_list_clear(&remotes, 0);
+	return ret;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..4b0ef35913 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -950,15 +950,15 @@ test_expect_success 'disabled option --set-upstream fails' '
 	test_must_fail git branch --set-upstream origin/main
 '
 
-test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
+test_expect_success '--set-upstream-to notices an error to set branch as own upstream' "
 	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
 	cat >expect <<-\EOF &&
-	warning: Not setting branch my13 as its own upstream.
+	warning: not setting branch 'my13' as its own upstream.
 	EOF
 	test_expect_code 1 git config branch.my13.remote &&
 	test_expect_code 1 git config branch.my13.merge &&
 	test_cmp expect actual
-'
+"
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
-- 
2.34.1.307.g9b7440fafd-goog

