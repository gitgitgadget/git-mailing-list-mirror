Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CA32023D
	for <e@80x24.org>; Thu,  3 May 2018 11:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeECLFK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 07:05:10 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36414 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeECLFD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 07:05:03 -0400
Received: by mail-qt0-f195.google.com with SMTP id q6-v6so22260726qtn.3
        for <git@vger.kernel.org>; Thu, 03 May 2018 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztaXQqRx1a6POp4n9bBpJa3BCi7cVS/9C/PiABQso+c=;
        b=QeYcWLWSUx3VCD3wrd3J0lWIg4OiFI+QUvWbO0HCo/IfkJahe0I7wjvcLdsxwdTOYB
         WRkJDdpyBia7zrYP0twFFfFmePa++6US/ItkNZshpEL8ZEgjxM7XHSLJQYBdtDmCl/Py
         0vmxaLFnQbn13FVTlDWiKrgE1uTEztOfPhHm9memJX9bMYWzT3VP/a9xD4WBGabMKyIv
         E5lHplxAUMpYWkfmEinGljQfcFkqWr7Yb7Ehd8dYmQS110RdU/PWNC2DhQ4b/Wq1lIkO
         bUdWI4N1VQpI9yUpkU67e5f6IWE+eY0hz9Qhuc+J3IEhrBXyLi5sxsciJC4p+3RoK5O0
         Dozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztaXQqRx1a6POp4n9bBpJa3BCi7cVS/9C/PiABQso+c=;
        b=cAh3vXBHmhU8CqoA5wL1QIacwpEoRryl3jCSjHvieoZdLx9klSsVloqX0YhsOAqxAT
         Y0iIoHFpJj8Z7+dAUUbC5UhPU5FPGMNKVfPcOlNjxdZQuajsw7fJferivfWs6qttsf7a
         uJsFW8CC9YLIt1Dqn2BiGkpIEjXW2s8/pTa5F5G7lTEds0NSNP9hNX5BoDDeetFurYUi
         TaA803zS1u4VuII7nZ2N/jUW2MtR8zzDFstjqm6ZiQ6DOkYFVYXBtTymSKww5Aj7HYmg
         JU4aAGMs2WQC03UgQrRA4eNWec9TxGZ1toidnb3AFKsY8OokihYvcbN4bQ2X3XbRD0yp
         G0Rw==
X-Gm-Message-State: ALQs6tDSZI8E81G1QXfc9PVk5DJFb8cf4JEAe/2dwZyy4hjWNxAVjPcz
        VcImkF/Hh7X8A0QHobaOZM+TaBnK
X-Google-Smtp-Source: AB8JxZpJ6mK3jc6JWbmQQ8X5UZeulauQPr6ciuf+fvKvRPeaQ7/1A8krzlRYUZ12Ehmt6HJtL091nQ==
X-Received: by 2002:a0c:91c2:: with SMTP id r2-v6mr19119042qvr.43.1525345502437;
        Thu, 03 May 2018 04:05:02 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id o14-v6sm12840833qta.23.2018.05.03.04.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 04:05:01 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com,
        gitster@pobox.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH v4 3/3] submodule: add --dissociate option to add/update commands
Date:   Thu,  3 May 2018 06:53:46 -0400
Message-Id: <20180503105346.1758-4-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180503105346.1758-1-kcghost@gmail.com>
References: <20180503105346.1758-1-kcghost@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add --dissociate option to add and update commands, both clone helper commands
that already have the --reference option --dissociate pairs with.

Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
---
 Documentation/git-submodule.txt | 10 +++++++++-
 builtin/submodule--helper.c     | 16 +++++++++++++---
 git-submodule.sh                | 10 +++++++++-
 t/t7408-submodule-reference.sh  | 17 +++++++++++++++++
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index d1ebe32e8..a75b95043 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -369,7 +369,15 @@ the submodule itself.
 	this option will be passed to the linkgit:git-clone[1] command.
 +
 *NOTE*: Do *not* use this option unless you have read the note
-for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
+for linkgit:git-clone[1]'s `--reference`, `--shared`, and `--dissociate`
+options carefully.
+
+--dissociate::
+	This option is only valid for add and update commands.  These
+	commands sometimes need to clone a remote repository. In this case,
+	this option will be passed to the linkgit:git-clone[1] command.
++
+*NOTE*: see the NOTE for the `--reference` option.
 
 --recursive::
 	This option is only valid for foreach, update, status and sync commands.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6ba8587b6..a85b30419 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1056,7 +1056,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 }
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
-			   const char *depth, struct string_list *reference,
+			   const char *depth, struct string_list *reference, int dissociate,
 			   int quiet, int progress)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1075,6 +1075,8 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 			argv_array_pushl(&cp.args, "--reference",
 					 item->string, NULL);
 	}
+	if (dissociate)
+		argv_array_push(&cp.args, "--dissociate");
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
 
@@ -1190,6 +1192,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	char *p, *path = NULL, *sm_gitdir;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	int dissociate = 0;
 	char *sm_alternate = NULL, *error_strategy = NULL;
 
 	struct option module_clone_options[] = {
@@ -1208,6 +1211,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &dissociate,
+			   N_("use --reference only while cloning")),
 		OPT_STRING(0, "depth", &depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
@@ -1247,7 +1252,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 		prepare_possible_alternates(name, &reference);
 
-		if (clone_submodule(path, sm_gitdir, url, depth, &reference,
+		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
 				    quiet, progress))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
@@ -1300,6 +1305,7 @@ struct submodule_update_clone {
 	int quiet;
 	int recommend_shallow;
 	struct string_list references;
+	int dissociate;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
@@ -1315,7 +1321,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
@@ -1442,6 +1448,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		for_each_string_list_item(item, &suc->references)
 			argv_array_pushl(&child->args, "--reference", item->string, NULL);
 	}
+	if (suc->dissociate)
+		argv_array_push(&child->args, "--dissociate");
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
 
@@ -1575,6 +1583,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &suc.dissociate,
+			   N_("use --reference only while cloning")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
diff --git a/git-submodule.sh b/git-submodule.sh
index 39c241a1d..1fddc098f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -42,6 +42,7 @@ prefix=
 custom_name=
 depth=
 progress=
+dissociate=
 
 die_if_unmatched ()
 {
@@ -128,6 +129,9 @@ cmd_add()
 		--reference=*)
 			reference_path="${1#--reference=}"
 			;;
+		--dissociate)
+			dissociate=1
+			;;
 		--name)
 			case "$2" in '') usage ;; esac
 			custom_name=$2
@@ -258,7 +262,7 @@ or you are unsure what this means choose another name with the '--name' option."
 				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
 		(
 			sanitize_submodule_env
 			cd "$sm_path" &&
@@ -493,6 +497,9 @@ cmd_update()
 		--reference=*)
 			reference="$1"
 			;;
+		--dissociate)
+			dissociate=1
+			;;
 		-m|--merge)
 			update="merge"
 			;;
@@ -550,6 +557,7 @@ cmd_update()
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
+		${dissociate:+"--dissociate"} \
 		${depth:+--depth "$depth"} \
 		$recommend_shallow \
 		$jobs \
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index e159fc503..82656747f 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -59,6 +59,16 @@ test_expect_success 'submodule add --reference uses alternates' '
 	test_alternate_is_used super/.git/modules/sub/objects/info/alternates super/sub
 '
 
+test_expect_success 'submodule add --reference with --dissociate doesnt use alternates' '
+	(
+		cd super &&
+		git submodule add --reference ../B --dissociate "file://$base_dir/A" sub-dissociate &&
+		git commit -m B-super-added &&
+		git repack -ad
+	) &&
+	test_path_is_missing super/.git/modules/sub-dissociate/objects/info/alternates
+'
+
 test_expect_success 'that reference gets used with add' '
 	(
 		cd super/sub &&
@@ -82,6 +92,13 @@ test_expect_success 'updating superproject keeps alternates' '
 	test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
+test_expect_success 'updating superproject with --dissociate doesnt keep alternates' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super-clone &&
+	git -C super-clone submodule update --init --reference ../B --dissociate &&
+	test_path_is_missing super-clone/.git/modules/sub/objects/info/alternates
+'
+
 test_expect_success 'submodules use alternates when cloning a superproject' '
 	test_when_finished "rm -rf super-clone" &&
 	git clone --reference super --recursive super super-clone &&
-- 
2.17.0.1.ge0414f29c.dirty

