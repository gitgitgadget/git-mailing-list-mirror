Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECD41F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeGRU2k (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:40 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:52599 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeGRU2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:40 -0400
Received: by mail-qk0-f202.google.com with SMTP id b185-v6so4586205qkg.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UyEPxHOs7uJG8c5Vefw2XS+nCQHPmR0coxnhZzrQeRc=;
        b=OCIq5TYkOYEPROw41b8DHx6RPwQaCasD6/OBuRAxLIyh+XJrzmyyN574EvaBcoIDdB
         S6yrXcCr5q2TfQvXwEbFBqHLSUuLgIAzEGf9MVtr91cg+G3n2emRWaQxCw2lbuAMWKDs
         fe7P5u/kuNLbJKG/fcqP6npBZJ2Tp62OLfmLKxyJyabdZtUnrAFuBNZPObNtn7+uYqG/
         Y3A8Mz3LnWmaJTXXlUMhtEFtRG7eIgrlzLkehhXbyMqU5v74MKwx/Amvx9+3aJgp1QcU
         wBXw8UitKH9wNsD8FGfh1UPNdyq1sxcovuMA0HOmTQ7pttcon4nwAdsljGKNsB4jhUDQ
         ww4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UyEPxHOs7uJG8c5Vefw2XS+nCQHPmR0coxnhZzrQeRc=;
        b=tNKj8C+RzyQF5DpPkfbh1i98JtosS+pXByBdsH5d3tocb05ZMdlA/AF3td42txpRlX
         B30ng/umKxX1d5A2tpePp2L19ATxbiUjAHEnJ0jY/Vkhfoqc6Bc2Ef67pztmPSMsBf8t
         tNOVIol5Tiz2KM/Uex8+bttB3Y67mH16MZ57Um/13AIdn1EpHSaOS4/na3GUgqW/AIfM
         mkVRDnit1BSSmThkHIQrGKp6WPP8A/Ji2QpqHdBpipFYtIoAwfibleAmxs89fsEdD4V5
         RfiBq56C+wyWMVWuYRjGgdnYw/zRfpuMZ3dUrPKHdyArxc8fiiBsnY8M4whNX2OZs9+Q
         qZ4g==
X-Gm-Message-State: AOUpUlHNPgczzZGqML7GD8JSGHDTqPTbwOjXsjREymV9eOrOR+ev4Wnl
        qGlYOxM67ouhLbx15BWOAKhga2voZ2tQxKbEam5x/wPaeR3pH+Utglnv3pmejMc70acsQCGh92p
        I0cxvkaoUzTWdhuTs16wDKecBJymSfRXacwP/R1NaoJLuc82w9VkFJ2Zk3YHv
X-Google-Smtp-Source: AAOMgpe4qg78t4NMIkoucGHRNBQqECT5F3JzCO+DPz/siybI5O8RQB4+DMPTWf0+ECOLOIGlSe3s6prbdIg2
MIME-Version: 1.0
X-Received: by 2002:a0c:e801:: with SMTP id y1-v6mr3894905qvn.55.1531943355577;
 Wed, 18 Jul 2018 12:49:15 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:48:53 -0700
In-Reply-To: <20180718194853.57994-1-sbeller@google.com>
Message-Id: <20180718194853.57994-7-sbeller@google.com>
References: <20180718194853.57994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 6/6] submodule--helper: introduce new update-module-mode helper
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com, stolee@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This chews off a bit of the shell part of the update command in
git-submodule.sh. When writing the C code, keep in mind that the
submodule--helper part will go away eventually and we want to have
a C function that is able to determine the submodule update strategy,
it as a nicety, make determine_submodule_update_strategy accessible
for arbitrary repositories.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 61 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 +---------
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 034ba1bb2e0..c7de5d1e0a0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1444,6 +1444,66 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void determine_submodule_update_strategy(struct repository *r,
+						int just_cloned,
+						const char *path,
+						const char *update,
+						struct submodule_update_strategy *out)
+{
+	const struct submodule *sub = submodule_from_path(r, &null_oid, path);
+	char *key;
+	const char *val;
+
+	key = xstrfmt("submodule.%s.update", sub->name);
+
+	if (update) {
+		trace_printf("parsing update");
+		if (parse_submodule_update_strategy(update, out) < 0)
+			die(_("Invalid update mode '%s' for submodule path '%s'"),
+				update, path);
+	} else if (!repo_config_get_string_const(r, key, &val)) {
+		if (parse_submodule_update_strategy(val, out) < 0)
+			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
+				val, path);
+	} else if (sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
+		trace_printf("loaded thing");
+		out->type = sub->update_strategy.type;
+		out->command = sub->update_strategy.command;
+	} else
+		out->type = SM_UPDATE_CHECKOUT;
+
+	if (just_cloned &&
+	    (out->type == SM_UPDATE_MERGE ||
+	     out->type == SM_UPDATE_REBASE ||
+	     out->type == SM_UPDATE_NONE))
+		out->type = SM_UPDATE_CHECKOUT;
+
+	free(key);
+}
+
+static int module_update_module_mode(int argc, const char **argv, const char *prefix)
+{
+	const char *path, *update = NULL;
+	int just_cloned;
+	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
+
+	if (argc < 3 || argc > 4)
+		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
+
+	just_cloned = git_config_int("just_cloned", argv[1]);
+	path = argv[2];
+
+	if (argc == 4)
+		update = argv[3];
+
+	determine_submodule_update_strategy(the_repository,
+					    just_cloned, path, update,
+					    &update_strategy);
+	fputs(submodule_strategy_to_string(&update_strategy), stdout);
+
+	return 0;
+}
+
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -2039,6 +2099,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
+	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 56588aa304d..215760898ce 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -535,27 +535,13 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		name=$(git submodule--helper name "$sm_path") || exit
-		if ! test -z "$update"
-		then
-			update_module=$update
-		else
-			update_module=$(git config submodule."$name".update)
-			if test -z "$update_module"
-			then
-				update_module="checkout"
-			fi
-		fi
+		update_module=$(git submodule--helper update-module-mode $just_cloned "$sm_path" $update)
 
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 1
 		then
 			subsha1=
-			case "$update_module" in
-			merge | rebase | none)
-				update_module=checkout ;;
-			esac
 		else
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-- 
2.18.0.233.g985f88cf7e-goog

