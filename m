Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB55C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiF3VUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiF3VTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3E45784
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r20so411300wra.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rMOar5gUpSfWxVPjUBSxJ53KbguCezU3u+8n/3UUIWM=;
        b=d2FKLrYk726htGHiGAHnhX+qhAw8iW8nB49dqLDHZG21O07nzdKVCjrnY6y8ynz5YZ
         l/OcU6EgLXcKeESTUvfryxAOI6D0RvHfaA1VTMIDQyWqHLOsogSjss3HqrcnLkUk31N6
         ejTX+XZN7woxqFSdTNhNyhhCeJ7eXbnmuO0tvU6kpDj7yc9W9MvEzVgVVcsJ2qOqzf7w
         +s31Qw6GyE9Z34tsT8OI+Q6MyL77B8jSomDS5lQhzbn/bPaRaVbMNPIl910FgemJ1JJr
         eseoFL5e0xyIg+gFPmonvfs2bdpCXS/CEu+0o3XNLEuVoJzU83p9O/zJKGfIKw97Wq1j
         UDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rMOar5gUpSfWxVPjUBSxJ53KbguCezU3u+8n/3UUIWM=;
        b=pvVQGy/HMR/niX3sT3ZTHjGWYdugfxzGHw2f2o+GzwATifhjDge9ZlQptxV2o2rjFb
         DhR87ge6sCcHrlFye4nw6PU/VKd/3Eevb52n8gaYDnyoi1qYlg3TtKIvUJLseogjdyGN
         6Oj8/aQQwyCHPqXCPYusqTfvjCGfKfU1acs/HZQbX84+ZfaXpDfr45YYFq4AVbQXGqQh
         yvHYUch2VsGk9LzD3z69KFkWuLNJHGANH1wat9sXVmYUXo2fzNUXSh04YlDr3q8bXTfL
         wKb/VwrOvqDjHaRDc0wFYl1bgHAEWYow3CN1+ZgfP4Id7IEglHOTsM7OjfQz9VSmya/d
         /h/w==
X-Gm-Message-State: AJIora9cUoA85aHocBZXbkzHMysf9NqA3XCmc6EJujo4nWj9INlfkOna
        Zvn0TfewOSf/tUj4igawJSf7Bd9+KTc=
X-Google-Smtp-Source: AGRyM1smKIRMTh12G8BpyaVRu7sKO6zJDF8/sqRrFnENFJ7KuBKTF3P+6lLj3CEE65CsumK5ALwXSg==
X-Received: by 2002:a05:6000:1148:b0:21b:a4b2:ccd3 with SMTP id d8-20020a056000114800b0021ba4b2ccd3mr10459126wrx.193.1656623990418;
        Thu, 30 Jun 2022 14:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b0039c4e2ff7cfsm4268730wmq.43.2022.06.30.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:49 -0700 (PDT)
Message-Id: <8f12108c2951cdfa181d6be66b6def28cd007bdd.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:29 +0000
Subject: [PATCH v2 09/18] submodule--helper: understand --checkout, --merge
 and --rebase synonyms
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Understand --checkout, --merge and --rebase synonyms for
--update={checkout,merge,rebase}, as well as the short options that
'git submodule' itself understands.

This removes a difference between the CLI API of "git submodule" and
"git submodule--helper", making it easier to make the latter an alias
for the former. See 48308681b07 (git submodule update: have a
dedicated helper for cloning, 2016-02-29) for the initial addition of
--update.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 30 ++++++++++++++++++++++++++++++
 git-submodule.sh            | 14 +++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 04d2620fce8..53179472d85 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2404,6 +2404,23 @@ static void ensure_core_worktree(const char *path)
 	}
 }
 
+static const char *submodule_update_type_to_label(enum submodule_update_type type)
+{
+	switch (type) {
+	case SM_UPDATE_CHECKOUT:
+		return "checkout";
+	case SM_UPDATE_MERGE:
+		return "merge";
+	case SM_UPDATE_REBASE:
+		return "rebase";
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_NONE:
+	case SM_UPDATE_COMMAND:
+		break;
+	}
+	BUG("unreachable with type %d", type);
+}
+
 static void update_data_to_args(struct update_data *update_data, struct strvec *args)
 {
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
@@ -2582,6 +2599,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
+	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2603,6 +2621,15 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
+		OPT_SET_INT(0, "checkout", &update_type,
+			N_("use the 'checkout' update strategy (default)"),
+			SM_UPDATE_CHECKOUT),
+		OPT_SET_INT('m', "merge", &update_type,
+			N_("use the 'merge' update strategy"),
+			SM_UPDATE_MERGE),
+		OPT_SET_INT('r', "rebase", &update_type,
+			N_("use the 'rebase' update strategy"),
+			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
@@ -2652,6 +2679,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
+	if (update_type != SM_UPDATE_UNSPECIFIED)
+		opt.update_default = submodule_update_type_to_label(update_type);
+
 	if (opt.update_default)
 		if (parse_submodule_update_strategy(opt.update_default,
 						    &opt.update_strategy) < 0)
diff --git a/git-submodule.sh b/git-submodule.sh
index 1c1dc320922..7fc7119fb21 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -40,7 +40,9 @@ require_init=
 files=
 remote=
 nofetch=
-update=
+rebase=
+merge=
+checkout=
 custom_name=
 depth=
 progress=
@@ -260,7 +262,7 @@ cmd_update()
 			force=$1
 			;;
 		-r|--rebase)
-			update="rebase"
+			rebase=1
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -274,13 +276,13 @@ cmd_update()
 			dissociate=1
 			;;
 		-m|--merge)
-			update="merge"
+			merge=1
 			;;
 		--recursive)
 			recursive=1
 			;;
 		--checkout)
-			update="checkout"
+			checkout=1
 			;;
 		--recommend-shallow)
 			recommend_shallow="--recommend-shallow"
@@ -341,7 +343,9 @@ cmd_update()
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${update:+--update "$update"} \
+		${rebase:+--rebase} \
+		${merge:+--merge} \
+		${checkout:+--checkout} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
 		${depth:+"$depth"} \
-- 
gitgitgadget

