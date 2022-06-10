Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D47C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 23:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbiFJXNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiFJXNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 19:13:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520518344
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 16:12:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n8-20020a170902d2c800b001663868e2c2so237144plc.21
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Buw0Je+6YYylU/iSOIGbYZsnpcuXn+n9CInReW5XTWo=;
        b=KtIE41jYxSQJPxLuvhRXwQFsxnwHvSE/v3TdUXUjpD2aMun/sRxV7/C6eXmE1B8j18
         8ix+zHATkk5Qndb2fSw+9agSKVZaxJWgUNm8dWALbmlZY3VabagZQJBG1evu/zG+Vmbg
         JkpW8Un6Yg3A7qGiwY1IpY97PX4AqgWyTymZ9yS7q9TxlskQV8cbK7s42+0eUC1hsr1Y
         SUKlDzxB0rWAjSRLzxYnp5Uphgmz5UHMRU9JozpnxqaPGh9JAP7Ko2wMWqDGjYCTon6P
         sytdy/o2C9qSL3noglvwSaqwXxvUbSsxKE6RA3XKiLpRKY3omxmrNnKxxMTMzbMZqVxM
         AMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Buw0Je+6YYylU/iSOIGbYZsnpcuXn+n9CInReW5XTWo=;
        b=orUeSrg8UXPTHwqY8LheBpnlHsHnLiHlTiVG8O6T777DqbK08Gav62Pknr9kQOfyRX
         X7qBPTX9d4jFSrjTwv2X5b3MyqUw5qMhhg0dx7Mb+7Xnp0745NbhhW398+41hTtNpAON
         YpSSzUVmPI04yJznuNf7bQAlObSg+D0wbuVYrcEDqsMoOaU0vXvWEecFZ/NQeipCb5h7
         5rjrKL8bhwDTjg5mbRKXQyJUHCH/Rj+86oXquJihEZQ+Gh5Xb1FdfLrjay3RAW/G0wlB
         94oSissXYGnq8CQiWURf1uGXk1uS7Tm6P33phGE1pV4UjZwOHiblPmLSQrIw3q7I/xz6
         3OZg==
X-Gm-Message-State: AOAM5303uiSkSmGM30Nce/Nq4xJ2Pzv7Jz/oNa4Tl2Lw5hBPeQU8VVMg
        Ty5oZNqERTpfkMK757XL8B/tTmrTgVqPq8mSp1N4eqVYayqPr0XGfhpx5h+9Yp+KBD3UCfH/DTj
        /wIkxWTemc9ue8gWz1OvABhBi7QrA7K1O66EXjGftENbSdM7l/wtdu/kVIJuiMAaobQ==
X-Google-Smtp-Source: ABdhPJyzvXnBieR9M4d/SyC9kDRak1W5MDsGJKr5apdqdN8Sc4ltVm3VIQ3Lv1ebalgLm2P4c1fdgA4zbnbGSoo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:d3d2:b0:1dd:30bb:6a45 with SMTP
 id d18-20020a17090ad3d200b001dd30bb6a45mr2124840pjw.206.1654902779184; Fri,
 10 Jun 2022 16:12:59 -0700 (PDT)
Date:   Fri, 10 Jun 2022 23:11:52 +0000
In-Reply-To: <20220606235449.2890858-1-calvinwan@google.com>
Message-Id: <20220610231152.2594428-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220606235449.2890858-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2] submodule merge: update conflict error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     chooglen@google.com, gitster@pobox.com,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to do a non-fast-forward merge in a project with
conflicts in the submodules, the merge fails and git prints the
following error:

Failed to merge submodule <submodules>
CONFLICT (submodule):Merge conflict in <submodule>
Automatic merge failed; fix conflicts and then commit the result.

Git is left in a conflicted state, which requires the user to:
 1. merge submodules
 2. add submodules changes to the superproject
 3. merge superproject
These steps are non-obvious for newer submodule users to figure out
based on the error message and neither `git submodule status` nor `git
status` provide any useful pointers. 

Update error message to the following when attempting to do a
non-fast-forward merge in a project with conflicts in the submodules.
The error message is based off of what would happen when `merge
--recurse-submodules` is eventually supported

Failed to merge submodule <submodule>
CONFLICT (submodule): Merge conflict in <submodule>
Automatic merge failed; recursive merging with submodules is currently
not supported. To manually complete the merge:
 - go to submodule (<submodule>), and merge commit <commit>
 - come back to superproject, and `git add <submodule>` to record the above merge 
 - resolve any other conflicts in the superproject
 - commit the resulting index in the superproject

Changes since v1:
 - Removed advice to abort merge
 - Error message updated to contain more commit/submodule information

Signed-off-by: Calvin Wan <calvinwan@google.com>

---
 builtin/merge.c            | 23 ++++++++++++++++++++++-
 merge-ort.c                |  7 ++++++-
 merge-recursive.c          |  7 ++++++-
 merge-recursive.h          |  4 ++++
 t/t6437-submodule-merge.sh |  5 ++++-
 5 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee..7e2deea7fb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -88,6 +88,8 @@ static const char *sign_commit;
 static int autostash;
 static int no_verify;
 static char *into_name;
+static struct oid_array conflicted_submodule_oids = OID_ARRAY_INIT;
+static struct string_list conflicted_submodule_paths = STRING_LIST_INIT_DUP;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  NO_TRIVIAL },
@@ -734,6 +736,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		}
 
 		init_merge_options(&o, the_repository);
+		o.conflicted_submodule_oids = &conflicted_submodule_oids;
+		o.conflicted_submodule_paths = &conflicted_submodule_paths;
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
@@ -973,8 +977,25 @@ static int suggest_conflicts(void)
 	strbuf_release(&msgbuf);
 	fclose(fp);
 	repo_rerere(the_repository, allow_rerere_auto);
-	printf(_("Automatic merge failed; "
+	if (conflicted_submodule_oids.nr > 0) {
+		int i;
+		printf(_("Automatic merge failed; recursive merging with submodules is currently\n"
+			"not supported. To manually complete the merge:\n"));
+		for (i = 0; i < conflicted_submodule_oids.nr; i++) {
+			printf(_(" - go to submodule (%s), and merge commit %s\n"),
+				conflicted_submodule_paths.items[i].string,
+				oid_to_hex(&conflicted_submodule_oids.oid[i]));
+		}
+		printf(_(" - come back to superproject, and `git add"));
+		for (i = 0; i < conflicted_submodule_paths.nr; i++)
+			printf(_(" %s"), conflicted_submodule_paths.items[i].string);
+		printf(_("` to record the above merge \n"
+		" - resolve any other conflicts in the superproject\n"
+		" - commit the resulting index in the superproject\n"));
+	} else {
+		printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
+	}
 	return 1;
 }
 
diff --git a/merge-ort.c b/merge-ort.c
index 0d3f42592f..c86ee11614 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3866,8 +3866,13 @@ static void process_entry(struct merge_options *opt,
 			const char *reason = _("content");
 			if (ci->filemask == 6)
 				reason = _("add/add");
-			if (S_ISGITLINK(merged_file.mode))
+			if (S_ISGITLINK(merged_file.mode)) {
 				reason = _("submodule");
+				if (opt->conflicted_submodule_oids && opt->conflicted_submodule_paths) {
+					oid_array_append(opt->conflicted_submodule_oids, &merged_file.oid);
+					string_list_append(opt->conflicted_submodule_paths, path);
+				}
+			}
 			path_msg(opt, path, 0,
 				 _("CONFLICT (%s): Merge conflict in %s"),
 				 reason, path);
diff --git a/merge-recursive.c b/merge-recursive.c
index fd1bbde061..ff7cdbefe9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3149,8 +3149,13 @@ static int handle_content_merge(struct merge_file_info *mfi,
 	}
 
 	if (!mfi->clean) {
-		if (S_ISGITLINK(mfi->blob.mode))
+		if (S_ISGITLINK(mfi->blob.mode)) {
 			reason = _("submodule");
+			if (opt->conflicted_submodule_oids && opt->conflicted_submodule_paths) {
+				oid_array_append(opt->conflicted_submodule_oids, &mfi->blob.oid);
+				string_list_append(opt->conflicted_submodule_paths, path);
+			}
+		}
 		output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (ci && !df_conflict_remains)
diff --git a/merge-recursive.h b/merge-recursive.h
index b88000e3c2..5d267e7a43 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -51,6 +51,10 @@ struct merge_options {
 
 	/* internal fields used by the implementation */
 	struct merge_options_internal *priv;
+
+	/* fields that hold submodule conflict information */
+	struct oid_array *conflicted_submodule_oids;
+	struct string_list *conflicted_submodule_paths;
 };
 
 void init_merge_options(struct merge_options *opt, struct repository *repo);
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 178413c22f..5b384dedc1 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -141,6 +141,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
 		test_must_fail git merge c 2> actual
 	  fi &&
 	 grep $(cat expect) actual > /dev/null &&
+	 test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-b)" actual &&
 	 git reset --hard)
 '
 
@@ -167,6 +168,7 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 fi &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
+	test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-b)" actual &&
 	git reset --hard)
 '
 
@@ -205,7 +207,8 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&
 
 	git checkout -b test-backward e &&
-	test_must_fail git merge f)
+	test_must_fail git merge f >actual &&
+	test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-a)" actual)
 '
 
 
-- 
2.36.1.476.g0c4daa206d-goog

