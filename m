Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC45215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756390AbeEASPu (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:15:50 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38838 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756380AbeEASPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:15:48 -0400
Received: by mail-qk0-f196.google.com with SMTP id b39so9423453qkb.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SACNQZ6fSeyKysVGkXHwSoEoNXttBU/abg8G1vbPGZU=;
        b=HB9Vw62KaGz/RwX2Q+NzGhWEfUmx3s7k7Z9wRcIfZRYk5WClW1YHMJwLAjh9gfBdvd
         JmiZfP8oeLis1IiC+gs/67MT3y6kOCnFjTMBMolT8h7Mr5wEvp5BcLHnlVM4we5MNp79
         OR0h8wSkHkZZJTMnYmXv4+XkpmDIDMHrUWovrogj4SZ+VUGavfy3x2XXDsYwQoaACpDm
         jMZwuOTIbLo31iMDXjwMjD5EDX0AVJYjgFw7N0GmYXy8tHLXovW/an2ZeywlfasmbcSJ
         utZ23lG3mHITZTVaxBsWqLdIRT2X62LS5t3B8iVMA2wwvVG0Ju3kP5s+Wesi23D3wdmR
         Vfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SACNQZ6fSeyKysVGkXHwSoEoNXttBU/abg8G1vbPGZU=;
        b=sfZSId/QyFC5Q4Ji7OpAzZbxQnlMzPPvUkxkdQTK/mRmySe6AW2t8x4uHi65Y6C0St
         bwPhrx3IjZtRpqUyYPEA2WJPHMJgD7ewxUgWmTTIVX3wXBqd301uvOsqAls31OxGf9iK
         k2HHZcp8hYoqpqq1wQTEcpvSyzweOrRmFW50OEN6R9aHqN9CcxSQInzvTc+FtFlqKS/G
         /1rGaGTI+yw/DydGotByoTGts7Dqn0bcj8shfeeStT28q/PmukTUbYZbQSkXXFI82R/d
         ZFrE4DecMudW1HwjV1LcxWuWaX5KR0x5dufTLCDxwOtaiaTIJnXTCfPRnnOLzFcoFMYt
         +Y7Q==
X-Gm-Message-State: ALQs6tAJ1SD2ma7MtDoSQNSjduRSc/7Gyht8nDk34sCzi2xF4g+imbNI
        jQkeznUiqyvXV7Somv/tLiBKQGEE
X-Google-Smtp-Source: AB8JxZqRn3EgeHJWvNXQdLqJdHsollKq7T5otGpUzQ/CkB4a428pEf7xOY33b7pDGGp4Ppwl4E5peQ==
X-Received: by 10.55.42.1 with SMTP id q1mr12796626qkh.137.1525198547602;
        Tue, 01 May 2018 11:15:47 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id z16-v6sm9271945qta.34.2018.05.01.11.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:15:47 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 2/2] submodule: Add --dissociate option to add/update commands
Date:   Tue,  1 May 2018 14:09:08 -0400
Message-Id: <20180501180908.17443-3-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180501180908.17443-1-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add --dissociate option to add and update commands, both clone helper commands
that already have the --reference option --dissociate pairs with.
Add documentation.
Add tests.

Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
---
 Documentation/git-submodule.txt | 10 +++++++++-
 builtin/submodule--helper.c     | 17 ++++++++++++++---
 git-submodule.sh                | 10 +++++++++-
 t/t7408-submodule-reference.sh  | 17 +++++++++++++++++
 4 files changed, 49 insertions(+), 5 deletions(-)

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
index 6ba8587b6..655f84f3c 100644
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
@@ -1075,6 +1075,9 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 			argv_array_pushl(&cp.args, "--reference",
 					 item->string, NULL);
 	}
+	if (dissociate) {
+		argv_array_push(&cp.args, "--dissociate");
+	}
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
 
@@ -1190,6 +1193,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	char *p, *path = NULL, *sm_gitdir;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
+	int dissociate = 0;
 	char *sm_alternate = NULL, *error_strategy = NULL;
 
 	struct option module_clone_options[] = {
@@ -1208,6 +1212,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &dissociate,
+			   N_("use --reference only while cloning")),
 		OPT_STRING(0, "depth", &depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
@@ -1247,7 +1253,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 		prepare_possible_alternates(name, &reference);
 
-		if (clone_submodule(path, sm_gitdir, url, depth, &reference,
+		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
 				    quiet, progress))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
@@ -1300,6 +1306,7 @@ struct submodule_update_clone {
 	int quiet;
 	int recommend_shallow;
 	struct string_list references;
+	int dissociate;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
@@ -1315,7 +1322,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
@@ -1442,6 +1449,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		for_each_string_list_item(item, &suc->references)
 			argv_array_pushl(&child->args, "--reference", item->string, NULL);
 	}
+	if (suc->dissociate)
+		argv_array_push(&child->args, "--dissociate");
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
 
@@ -1575,6 +1584,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &suc.dissociate,
+			   N_("use --reference only while cloning")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
diff --git a/git-submodule.sh b/git-submodule.sh
index aa1c0bb67..4743b4745 100755
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
+			dissociate="--dissociate"
+			;;
 		--name)
 			case "$2" in '') usage ;; esac
 			custom_name=$2
@@ -258,7 +262,7 @@ or you are unsure what this means choose another name with the '--name' option."
 				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"$progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"$progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"$dissociate"} ${depth:+"$depth"} || exit
 		(
 			sanitize_submodule_env
 			cd "$sm_path" &&
@@ -493,6 +497,9 @@ cmd_update()
 		--reference=*)
 			reference="$1"
 			;;
+		--dissociate)
+			dissociate="--dissociate"
+			;;
 		-m|--merge)
 			update="merge"
 			;;
@@ -550,6 +557,7 @@ cmd_update()
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
+		${dissociate:+"$dissociate"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index e159fc503..ee9772e0a 100755
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
+	test_must_fail test_alternate_is_used super/.git/modules/sub-dissociate/objects/info/alternates super/sub-dissociate
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
+	test_must_fail test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
+'
+
 test_expect_success 'submodules use alternates when cloning a superproject' '
 	test_when_finished "rm -rf super-clone" &&
 	git clone --reference super --recursive super super-clone &&
-- 
2.17.0.1.ge0414f29c.dirty

