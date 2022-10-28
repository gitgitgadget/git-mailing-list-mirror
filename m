Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021AC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJ1UPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJ1UPH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB5152FF9
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k8so8003225wrh.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU9HVHrNabwm24/YjLnxK0iByLEvRtPIehyF5akJ4gI=;
        b=mL+eVFA/z0IxmEVmODwseOXAKjrLHEU6uUy3muwAlp6FrKbB5l0FZw3tJ40Am06dVA
         585b6g3efIV0Ywm7kN/G0TDetEbxNO3b8PYqtweb0bDdPoYV5gZYVwPIMBl5ARUUUnfV
         2wQoSXw95MKYtXUK3qrbQgGP5hhZGcln9ko++Dy51BglWD+QSD3bSPoTuOih/GNKGuFM
         Fk1m6zYgr0OD2hs1sBxgAS7NQmBl7QbW1ezchzW6kpu0BEZSCmVNUKrh8lSDjQ3hsYks
         xzAqtkleiuaPKs9cgklL8y6D8pk1EdUE22WwuKGDwq0IRQCa5J9XSw8BDSF16bwMaLYS
         NodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU9HVHrNabwm24/YjLnxK0iByLEvRtPIehyF5akJ4gI=;
        b=OHYI2ODlkoR5/xtR46rEAN5nIs52auaVumbQ1biF0FGuTX1CVx8vLDGZ3ZOvolKHZe
         ml+ORhUnn1mFmjyPZVIDrjM8n6LwY5WiFfMRUbMHDJ2gGgQm47VoCFznAlgnd4988t7u
         BGyGwTEZUCDs/QaOJQEeQG2hkkEeqbK0Ls8tRygEarvwGI5eMXk1rKdCl24jLQGcNLKa
         z5puEfe5jNMStPNhTQ+ySq3zaRP3mbkgNWUA971Vp7RMkR54jHlbbYnnwk94LXfzQcvc
         Cbx5rV53mAzzvxuI7esjfO7y20y856hTe5RfrOh6hhqV1sWt/s0YxXA0X3O85Ewf7LhU
         hrjw==
X-Gm-Message-State: ACrzQf2y2fVlCchgSX9u2dgxSKa4F91/uk0KdYuHoRQuRM8UavyzWG2W
        upoTir7+F1TU2J0LWUvtLYrYYKst89w=
X-Google-Smtp-Source: AMsMyM7cyQ2myKmojNrWDo2gMqGzSXWdKffJYh3A/ATux4AQ0zfjpTSNd5xhr6gw2hAl/rnptYhHQw==
X-Received: by 2002:a5d:5847:0:b0:231:21fa:ba96 with SMTP id i7-20020a5d5847000000b0023121faba96mr572688wrf.477.1666988103990;
        Fri, 28 Oct 2022 13:15:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020adff281000000b0022ac672654dsm4362098wro.58.2022.10.28.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:15:03 -0700 (PDT)
Message-Id: <df1f7225f4909547c10c52e818eb5dfd65b3e24c.1666988096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:54 +0000
Subject: [PATCH v3 6/8] submodule update: refactor update targets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Refactor two "git submodule update" code locations so that they no
longer refer to oids directly. This shrinks a subsequent commit's diff,
where this code will need to handle branches.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9ca138374b7..894be133b3f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2255,7 +2255,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	char *oid = oid_to_hex(&ud->oid);
+	const char *update_target = oid_to_hex(&ud->oid);;
 	int ret;
 
 	switch (ud->update_strategy.type) {
@@ -2285,7 +2285,7 @@ static int run_update_command(const struct update_data *ud, int subforce)
 		BUG("unexpected update strategy type: %d",
 		    ud->update_strategy.type);
 	}
-	strvec_push(&cp.args, oid);
+	strvec_push(&cp.args, update_target);
 
 	cp.dir = ud->sm_path;
 	prepare_submodule_repo_env(&cp.env);
@@ -2293,20 +2293,20 @@ static int run_update_command(const struct update_data *ud, int subforce)
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
-				    oid, ud->displaypath);
+				    update_target, ud->displaypath);
 			/* No "ret" assignment, use "git checkout"'s */
 			break;
 		case SM_UPDATE_REBASE:
 			ret = die_message(_("Unable to rebase '%s' in submodule path '%s'"),
-					  oid, ud->displaypath);
+					  update_target, ud->displaypath);
 			break;
 		case SM_UPDATE_MERGE:
 			ret = die_message(_("Unable to merge '%s' in submodule path '%s'"),
-					  oid, ud->displaypath);
+					  update_target, ud->displaypath);
 			break;
 		case SM_UPDATE_COMMAND:
 			ret = die_message(_("Execution of '%s %s' failed in submodule path '%s'"),
-					  ud->update_strategy.command, oid, ud->displaypath);
+					  ud->update_strategy.command, update_target, ud->displaypath);
 			break;
 		default:
 			BUG("unexpected update strategy type: %d",
@@ -2322,19 +2322,19 @@ static int run_update_command(const struct update_data *ud, int subforce)
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		printf(_("Submodule path '%s': checked out '%s'\n"),
-		       ud->displaypath, oid);
+		       ud->displaypath, update_target);
 		break;
 	case SM_UPDATE_REBASE:
 		printf(_("Submodule path '%s': rebased into '%s'\n"),
-		       ud->displaypath, oid);
+		       ud->displaypath, update_target);
 		break;
 	case SM_UPDATE_MERGE:
 		printf(_("Submodule path '%s': merged in '%s'\n"),
-		       ud->displaypath, oid);
+		       ud->displaypath, update_target);
 		break;
 	case SM_UPDATE_COMMAND:
 		printf(_("Submodule path '%s': '%s %s'\n"),
-		       ud->displaypath, ud->update_strategy.command, oid);
+		       ud->displaypath, ud->update_strategy.command, update_target);
 		break;
 	default:
 		BUG("unexpected update strategy type: %d",
@@ -2521,6 +2521,7 @@ static void update_data_to_args(const struct update_data *update_data,
 
 static int update_submodule(struct update_data *update_data)
 {
+	int submodule_up_to_date;
 	int ret;
 
 	ret = determine_submodule_update_strategy(the_repository,
@@ -2569,7 +2570,8 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
+	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
+	if (!submodule_up_to_date || update_data->force) {
 		ret = run_update_procedure(update_data);
 		if (ret)
 			return ret;
-- 
gitgitgadget

