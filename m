Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE6D1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeGQA5D (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:57:03 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:40339 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGQA5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:57:03 -0400
Received: by mail-yb0-f201.google.com with SMTP id k10-v6so3200135ybp.7
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Z9gqXcA6ceWy2JriL36VwJfhrs3OPkCs1PyxGD3Fg80=;
        b=DKXDc8Fy49J7vOr3RqAyJHZGPk1ixmujSAwdZj241FqWM23yMoxUqvZoJjy9SgraCg
         KgrBiucq6waWGaygJeNUqIOdsGdaQhuw8kCsEdx8T8YRMLwNpLLJYh5I2Uk5/kU02yGE
         28iRSacCBV7v6d8g/ENsIKhda8N6YCIJ0FxmvcCAgH+6edYvo8mLGyN4C17y18SDl/K4
         jDFla+eUbMRbUA6Qs1sLTF9BwxEmi/6iLwoQhQ+RGkZlC/shP6Mw17vBhqbWr0xiuXm2
         DCmHIff5zUoLyNG3fKzzev+STJcbA1nWcwd84pWbD6WhWjdUAX1S6lEOWPhXYKQ6IBtP
         3EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Z9gqXcA6ceWy2JriL36VwJfhrs3OPkCs1PyxGD3Fg80=;
        b=JpLrHIUMr6xk4K0LIGPPR8tksz61J5MCNiybWWTeh+R3xjqnDxL96JDewjKGoFmkLF
         8ckhFFrc5tcM77/d+KYQiTOdi1tUdHHyS/ryAZ/1Ae4sZVS/pV6sDozpmu/z2Gx+yG4M
         h4RZxMrbKS715aLbqHN28in7z7qGN4AzLI3mfrnoMfqmgGa5p9wmiKo5QMitYRXlqNb6
         Of5vFm9XJ0xyc5RH0xyX1eAdI/mfNj/9MXB62yHe8+wE12jNe6lGsL0e25wzTxyG3ErQ
         g0Lop4gMnyjDMEgaPoFg1YBWIUCdyl7iG8BmhdOdYzNelnCvVbTltGPWWUcMuOt2tOAO
         IwYw==
X-Gm-Message-State: AOUpUlHYtCHzIHIgthXXjaiY+tHvDrR2nWRXocH1EnEwyqQXGegYTtqr
        IaWt//W02+ONr/E5ukZzwFV6NlSuwR/P6VJfwMGrevEifsh3lSRdB8yUOEROW9My7ru9Lw09lhV
        rF1ovCwEUfsR4/uRyhjvHQ1olvi1DN4r5+n+vWOGn5THNyXEi975Jd9WUczV2
X-Google-Smtp-Source: AAOMgpfmNHUqoYOP00Mtzn7eetkkcsF0C/ieJVuSPqyVLtGIpl1Qqx1igLOuG6wSXUZKzg2EBSJfIYDXoIHx
MIME-Version: 1.0
X-Received: by 2002:a81:6341:: with SMTP id x62-v6mr4315079ywb.138.1531787232804;
 Mon, 16 Jul 2018 17:27:12 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:26:54 -0700
In-Reply-To: <20180717002654.120375-1-sbeller@google.com>
Message-Id: <20180717002654.120375-7-sbeller@google.com>
References: <20180717002654.120375-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 6/6] submodule--helper: introduce new update-module-mode helper
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
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
index 034ba1bb2e0..d4cb7c72e33 100644
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
+	fprintf(stdout, submodule_strategy_to_string(&update_strategy));
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
2.18.0.203.gfac676dfb9-goog

