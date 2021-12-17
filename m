Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9692FC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 05:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhLQFMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 00:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLQFMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 00:12:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95BC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:12:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p133-20020a255b8b000000b006086e19f89fso2540041ybb.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RXV6xTpRJ8KseZ403ed6Hfrh5nSbt0A7fLyMmTKSuJ8=;
        b=K6/M8DpYDFbwUizuimt3vyrJiik6sor57yyz/tfFRUwJ5WlZOakc1RWBZG/EyqKsXF
         PakSp9OMQq/KbsVngTnntOduDrFoV4UIpkQBregxyOUlxNZHG7OvG4ifFcnzLDYxITrM
         Z4ev9XgHpcYKC/kJ9XSjQOBKngRywwz8EBTk2MTiSPrgA5qg6Y/ACx37vTCA0YC0qXLj
         cmxj392WTLRiPnl7SKS72f9Plxi+3KUMoVBYGYwOJrF7xYMW0/sk0v92yza65+yM9tOq
         PHRkDeHQQrezDvToTEngClawnETSSBtGF6bj2tOPjQNVzMRjhjqz4QsWp6U+ufStgetV
         g1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RXV6xTpRJ8KseZ403ed6Hfrh5nSbt0A7fLyMmTKSuJ8=;
        b=2u8aLsEPOJdufBEbH361RUd9zGAmN1AGnrm9FkWxBXXzwlAlf7odZMRjiDk4H1W4La
         ZEVWCV5WJnUSPTEBFETiw/1TdBIlMkzXV8+mokWRncHVEEPcvj/d43Ve9cfb9EWuJPBu
         cKsMd96V4VAGUa6sJC6QJG9z1hK0XCcipBXFMHOHGf/Rlrk6zabQ5k7cQhNFgde4/jo1
         NY+1u0ZzkUPqycBSkXSJaRZa1oVlKLO6srvEiI/rvEnhnbSyBJGO7gxEFAxcuba/Kcu+
         6v1fUC7dk5r40R77qRi6+Zyv+qk4INZoWx30YI7jj3/zUYvO5TgTWUULH1RV3Xij+dpz
         q0UA==
X-Gm-Message-State: AOAM533blKeUQDOIO3UfSoAAx/zM0/uzypQk+1zfCUN8tDUyLHQsIwL8
        K9oZ9GzqRLeqFM/JtYhjU2LsSl0jw0XkFGk8cM0Ug/pliG09t6TAR8oYlLW9lrJ3MPOvtvCyRc9
        Cubdy5ckLahcG6+vp0eyEdXyszWNUueFAsAYHtpDLkI7PhSe649wv8OyvvJPbE/Q=
X-Google-Smtp-Source: ABdhPJy2w0/lnMy4dgVt4S40Jc9SdrOXycHirFr6mqfbj/TmEMil6yNuLwG3qNnk1qLaNNDaVuw37MuvlfYAqA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:a37:b5e2:96be:e5d5])
 (user=steadmon job=sendgmr) by 2002:a25:ec03:: with SMTP id
 j3mr2059212ybh.203.1639717932727; Thu, 16 Dec 2021 21:12:12 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:12:06 -0800
In-Reply-To: <cover.1639717481.git.steadmon@google.com>
Message-Id: <9152367ba9e8e4285d691cd3b6ec6956b599f93c.1639717481.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639717481.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v7 1/3] branch: accept multiple upstream branches for tracking
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
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
 branch.c          | 140 +++++++++++++++++++++++++++++++++-------------
 t/t3200-branch.sh |   6 +-
 2 files changed, 104 insertions(+), 42 deletions(-)

diff --git a/branch.c b/branch.c
index 7a88a4861e..9e57c54848 100644
--- a/branch.c
+++ b/branch.c
@@ -49,25 +49,42 @@ static int should_setup_rebase(const char *origin)
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
@@ -75,8 +92,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 
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
@@ -87,29 +113,43 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (shortname) {
+		const char *name;
+		struct strbuf ref_string = STRBUF_INIT;
+
+		for_each_string_list_item(item, remotes) {
+			name = item->string;
+			skip_prefix(name, "refs/heads/", &name);
+			strbuf_addf(&ref_string, "  %s\n", name);
+		}
+
+		if (remotes->nr == 1) {
+			struct strbuf refname = STRBUF_INIT;
+
 			if (origin)
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
-					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
-					  local, shortname, origin);
-			else
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
-					  _("Branch '%s' set up to track local branch '%s'."),
-					  local, shortname);
+				strbuf_addf(&refname, "%s/", origin);
+			skip_prefix(remotes->items[0].string, "refs/heads/", &name);
+			strbuf_addstr(&refname, name);
+
+			/*
+			 * Rebasing is only allowed in the case of a single
+			 * upstream branch.
+			 */
+			printf_ln(rebasing ?
+				_("branch '%s' set up to track '%s' by rebasing.") :
+				_("branch '%s' set up to track '%s'."),
+				local, refname.buf);
+
+			strbuf_release(&refname);
+		} else if (origin) {
+			printf_ln(_("branch '%s' set up to track from '%s':"),
+				local, origin);
+			printf("%s", ref_string.buf);
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
+			printf("%s", ref_string.buf);
 		}
+
+		strbuf_release(&ref_string);
 	}
 
 	return 0;
@@ -118,14 +158,36 @@ int install_branch_config(int flag, const char *local, const char *origin, const
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
2.34.1.173.g76aa8bc2d0-goog

