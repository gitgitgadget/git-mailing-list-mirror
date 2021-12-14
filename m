Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D61C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 23:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhLNXpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 18:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhLNXpC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 18:45:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA07C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 15:45:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso39770790ybl.7
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 15:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=viyp0FVHVFGMrj8d3m9yg23/wRlOBcuWbEnKtaiVfOM=;
        b=DSY/vHUtUQq0awqdyvPPjq1X1s7mVUVkhyw0cQTDALx7n7rP2I3NspZrP0B/nXjjLM
         kAMy9BCsLBCMMLRUK4eOgL/KNbMXSzt+9RTTQBNLFgrXnWxZUm6uKN3MxSDDV70MJrcO
         L9mbMfpd1fFScN0gEquLoBIIXNsnM/f7hNMyb/ekklT4s2w3QBaO1NqgXzXPUgKZ3Zut
         7EMbNt46P6EYIvAaBisTZFX1YkHp19Jz7pO3ZLzAeiV3koVfNuCkBTg+1x6JVCSFlWVA
         onERK7MKLVjxhtb3UHmp3kPCv3Z8ahMfjvrQ9M3o04kfE1+EoxywrFdjaSLagkK1rbNN
         KsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=viyp0FVHVFGMrj8d3m9yg23/wRlOBcuWbEnKtaiVfOM=;
        b=p4XNUv1XQdThxNd8dpL3rxGC5sErvWxQeWaQP83ygQC0K6hi+iqa1HHEfshAQJ6c9G
         cVmNCMvybp6Av/m2t5oXshBEjEu9zn72ZhcqwXoYI1eKCFikcz685/f+lxfgpJFPOP29
         9ESUrsaD7ppjPMFAfhwGWkcZef9+A8AKe0cueMm3WO89uP+4DiH+qTbtTtPoeTTH61hl
         TOUDtbC17jqSl9N2fVHfaUky+85hf+hE60C0Z+zSF69pVBSmAbi60EOWGv2T1fIGJtot
         XUxxtmfvEGKUHMuWLBGKNGFK9plV/F5rNJ1H35ggPnjfPnWU6eHQxjkGVfw2YyUnwxbY
         Gk2g==
X-Gm-Message-State: AOAM533NUJ8CQuMI7rhehzx8+UCnKfm1XRlB0V0o+pN4vW5AKLrKBVSw
        vN7/NtTfl84WsqRQrdi92ppb/gBza5YnxzUQMxnNoIVYHD3NnghzPeEL+BHqHfBXEdUqWdtBXSe
        zW1FQa372vA8JJTgATKvJl9C/unnQWmd9smFc9cfE4Bkpcsra9jBLe/121rc20qw=
X-Google-Smtp-Source: ABdhPJxv4+59bepuBNvcYbg5vWbugbszF4EwT5X8s7PnnAVVj73a8wei63rU2rNhzSz/o9NEm9J4cLx3y2gDQA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
 (user=steadmon job=sendgmr) by 2002:a25:bbc6:: with SMTP id
 c6mr2478574ybk.222.1639525501043; Tue, 14 Dec 2021 15:45:01 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:44:54 -0800
In-Reply-To: <cover.1639524556.git.steadmon@google.com>
Message-Id: <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v6 1/3] branch: accept multiple upstream branches for tracking
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
 branch.c          | 135 ++++++++++++++++++++++++++++++++--------------
 t/t3200-branch.sh |   6 +--
 2 files changed, 99 insertions(+), 42 deletions(-)

diff --git a/branch.c b/branch.c
index 7a88a4861e..fa165ebdab 100644
--- a/branch.c
+++ b/branch.c
@@ -49,25 +49,41 @@ static int should_setup_rebase(const char *origin)
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
+		die(_("cannot inherit upstream tracking configuration when rebasing is requested"));
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
@@ -75,8 +91,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 
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
@@ -87,29 +112,42 @@ int install_branch_config(int flag, const char *local, const char *origin, const
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
+			strbuf_addstr(&refname, remotes->items[0].string);
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
@@ -118,14 +156,33 @@ int install_branch_config(int flag, const char *local, const char *origin, const
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
+	else
+		for_each_string_list_item(item, remotes)
+			advise("  git config --add branch.\"%s\".merge %s",
+				local, item->string);
 
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

