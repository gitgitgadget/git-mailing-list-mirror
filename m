Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19DBC2D0D3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960B820718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvObRTxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfL3SiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:38:18 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33485 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3SiS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:38:18 -0500
Received: by mail-ed1-f50.google.com with SMTP id r21so33478321edq.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8J848FH78z24lwPfysuVv9Fqmh6nIaFsO171ROCY8U8=;
        b=nvObRTxYTeL0I/oFGN1uMquQXcbxKFEkEPg1ExbyOjO0MGW+KgaY8dQhyp5a/aqGzG
         D8BTEr4tsYYK32wOuPJ7PfDSEykuHB9S/sSba9n+AmO6LisL0f8rclvHId4CKMELHaVm
         KNO6TT9tfRuDUzZcDilMYvsU5lj8G4Cs/YWT6c85OuAkGBtABhdKvHCxwfwXmANc+//o
         lmIFfuh6lymKzDB8qMTg0QjcSgVby/ZxAtU1O+p8hnAwL+4yky8hikddlMAjQr0tFzIG
         QV4mmAbZH/i3WWSNVOCZpJii6nDTdMPaldR6IKdvA7ejku7tgWuS74C8BWAb2zXsrjxD
         DOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8J848FH78z24lwPfysuVv9Fqmh6nIaFsO171ROCY8U8=;
        b=dkLT0wWSY9SaF9wvVXPeWytZz1BVLi57CCephlpa3qVtMxpVXQevJTiQdH9kKxdrf4
         eMNjGEc+zHD8inhziJX8T80GrB9sDBGiJ+xPb2XkFlkOwRFSim90c8s/ZdwKKmubm++H
         WDIxCOPLwEn2CeM43BnQoZW0yPvGYfDEoAPGj8RvrWQKw+nNGR6umpB8RaeyGa6KV4fi
         S0SdfraNZQ70WW92ZYx9yQuvJI64g0bg/zKe0XvqxgPfC54g/PTXP9DjlZMgLylxdjyK
         5ZoTfite45DCPF+GPvyPvGffpdb2LRo2roZ8JjLmoKrM5OAUhwGor1Nju8booB+Nmgnx
         GSyw==
X-Gm-Message-State: APjAAAU6SuxWvZVampicgZfkIz75Sjabpd6ow0XULeFlpRvUwNDCMPge
        Ij1MjzkXP3/17ZDYFEsCcbKH3zM2
X-Google-Smtp-Source: APXvYqwg1G0ZSGCgVRpc5ZnWBoKUpCVQ38wIdrDAvkpW1rLle5Btzi1FPIp+6voUKfdQf5St+Pa0Kw==
X-Received: by 2002:a17:906:5604:: with SMTP id f4mr71567718ejq.255.1577731095928;
        Mon, 30 Dec 2019 10:38:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j21sm5443175eds.8.2019.12.30.10.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 10:38:15 -0800 (PST)
Message-Id: <12229e45fdcdce4b3e67f92b3945162eb6ff11cc.1577731093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.504.git.1577731093.gitgitgadget@gmail.com>
References: <pull.504.git.1577731093.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 18:38:13 +0000
Subject: [PATCH 2/2] checkout: don't revert file on ambiguous tracking
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

For easier understanding, here are the existing good scenarios:

  1) Have *no* file 'foo', *no* local branch 'foo' and a *single*
     remote branch 'foo'
  2) `git checkout foo` will create local branch foo, see [1]

  and

  1) Have *a* file 'foo', *no* local branch 'foo' and a *single*
     remote branch 'foo'
  2) `git checkout foo` will complain, see [3]

This patch prevents the following scenario:

  1) Have *a* file 'foo', *no* local branch 'foo' and *multiple*
     remote branches 'foo'
  2) `git checkout foo` will successfully... revert contents of
     file `foo`!

That is, adding another remote suddenly changes behavior significantly,
which is a surprise at best and could go unnoticed by user at worst.
Please see [3] which gives some real world complaints.

To my understanding, fix in [3] overlooked the case of multiple remotes,
and the whole behavior of falling back to reverting file was never
intended:

  [1] introduces the unexpected behavior. Before, there was fallback
  from not-a-ref to pathspec. This is reasonable fallback. After, there
  is another fallback from ambiguous-remote to pathspec. I understand
  that it was a copy&paste oversight.

  [2] noticed the unexpected behavior but chose to semi-document it
  instead of forbidding, because the goal of the patch series was
  focused on something else.

  [3] adds `die()` when there is ambiguity between branch and file. The
  case of multiple tracking branches is seemingly overlooked.

The new behavior: if there is no local branch and multiple remote
candidates, just die() and don't try reverting file whether it
exists (prevents surprise) or not (improves error message).

[1] Commit 70c9ac2f ("DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"" 2009-10-18)
    https://public-inbox.org/git/7vaazpxha4.fsf_-_@alter.siamese.dyndns.org/
[2] Commit ad8d5104 ("checkout: add advice for ambiguous "checkout <branch>"", 2018-06-05)
    https://public-inbox.org/git/20180502105452.17583-1-avarab@gmail.com/
[3] Commit be4908f1 ("checkout: disambiguate dwim tracking branches and local files", 2018-11-13)
    https://public-inbox.org/git/20181110120707.25846-1-pclouds@gmail.com/

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c       | 56 ++++++++++++++++++----------------------
 t/t2024-checkout-dwim.sh | 28 ++++++++++++++++++--
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f832040e94..5c41645c7d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1117,10 +1117,10 @@ static void setup_new_branch_info_and_source_tree(
 
 static const char *parse_remote_branch(const char *arg,
 				       struct object_id *rev,
-				       int could_be_checkout_paths,
-				       int *dwim_remotes_matched)
+				       int could_be_checkout_paths)
 {
-	const char *remote = unique_tracking_name(arg, rev, dwim_remotes_matched);
+	int num_matches = 0;
+	const char *remote = unique_tracking_name(arg, rev, &num_matches);
 
 	if (remote && could_be_checkout_paths) {
 		die(_("'%s' could be both a local file and a tracking branch.\n"
@@ -1128,6 +1128,22 @@ static const char *parse_remote_branch(const char *arg,
 		    arg);
 	}
 
+	if (!remote && num_matches > 1) {
+	    if (advice_checkout_ambiguous_remote_branch_name) {
+		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
+			     "you can do so by fully qualifying the name with the --track option:\n"
+			     "\n"
+			     "    git checkout --track origin/<name>\n"
+			     "\n"
+			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+			     "one remote, e.g. the 'origin' remote, consider setting\n"
+			     "checkout.defaultRemote=origin in your config."));
+	    }
+
+	    die(_("'%s' matched multiple (%d) remote tracking branches"),
+		arg, num_matches);
+	}
+
 	return remote;
 }
 
@@ -1135,8 +1151,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
-				struct object_id *rev,
-				int *dwim_remotes_matched)
+				struct object_id *rev)
 {
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
@@ -1242,8 +1257,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 		if (recover_with_dwim) {
 			const char *remote = parse_remote_branch(arg, rev,
-								 could_be_checkout_paths,
-								 dwim_remotes_matched);
+								 could_be_checkout_paths);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1509,7 +1523,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			 const char * const usagestr[])
 {
 	struct branch_info new_branch_info;
-	int dwim_remotes_matched = 0;
 	int parseopt_flags = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
@@ -1617,8 +1630,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, opts, &rev,
-					     &dwim_remotes_matched);
+					     &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1695,28 +1707,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	UNLEAK(opts);
-	if (opts->patch_mode || opts->pathspec.nr) {
-		int ret = checkout_paths(opts, new_branch_info.name);
-		if (ret && dwim_remotes_matched > 1 &&
-		    advice_checkout_ambiguous_remote_branch_name)
-			advise(_("'%s' matched more than one remote tracking branch.\n"
-				 "We found %d remotes with a reference that matched. So we fell back\n"
-				 "on trying to resolve the argument as a path, but failed there too!\n"
-				 "\n"
-				 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
-				 "you can do so by fully qualifying the name with the --track option:\n"
-				 "\n"
-				 "    git checkout --track origin/<name>\n"
-				 "\n"
-				 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
-				 "one remote, e.g. the 'origin' remote, consider setting\n"
-				 "checkout.defaultRemote=origin in your config."),
-			       argv[0],
-			       dwim_remotes_matched);
-		return ret;
-	} else {
+	if (opts->patch_mode || opts->pathspec.nr)
+		return checkout_paths(opts, new_branch_info.name);
+	else
 		return checkout_branch(opts, &new_branch_info);
-	}
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index fa0718c730..accfa9aa4b 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -37,7 +37,9 @@ test_expect_success 'setup' '
 		git checkout -b foo &&
 		test_commit a_foo &&
 		git checkout -b bar &&
-		test_commit a_bar
+		test_commit a_bar &&
+		git checkout -b ambiguous_branch_and_file &&
+		test_commit a_ambiguous_branch_and_file
 	) &&
 	git init repo_b &&
 	(
@@ -46,7 +48,9 @@ test_expect_success 'setup' '
 		git checkout -b foo &&
 		test_commit b_foo &&
 		git checkout -b baz &&
-		test_commit b_baz
+		test_commit b_baz &&
+		git checkout -b ambiguous_branch_and_file &&
+		test_commit b_ambiguous_branch_and_file
 	) &&
 	git remote add repo_a repo_a &&
 	git remote add repo_b repo_b &&
@@ -75,6 +79,26 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_branch master
 '
 
+test_expect_success 'when arg matches multiple remotes, do not fallback to interpreting as pathspec' '
+	# create a file with name matching remote branch name
+	git checkout -b t_ambiguous_branch_and_file &&
+	>ambiguous_branch_and_file &&
+	git add ambiguous_branch_and_file &&
+	git commit -m "ambiguous_branch_and_file" &&
+
+	# modify file to verify that it will not be touched by checkout
+	test_when_finished "git checkout -- ambiguous_branch_and_file" &&
+	echo "file contents" >ambiguous_branch_and_file &&
+	cp ambiguous_branch_and_file expect &&
+
+	test_must_fail git checkout ambiguous_branch_and_file 2>err &&
+
+	test_i18ngrep "matched multiple (2) remote tracking branches" err &&
+
+	# file must not be altered
+	test_cmp expect ambiguous_branch_and_file
+'
+
 test_expect_success 'checkout of branch from multiple remotes fails with advice' '
 	git checkout -B master &&
 	test_might_fail git branch -D foo &&
-- 
gitgitgadget
