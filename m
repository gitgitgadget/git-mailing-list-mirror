Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76270C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJTUVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJTUUx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:20:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973F1F0418
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bv10so1176069wrb.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qzbLJuQnEYqXpEYDjBQWuosE+DZ0ly05x2Pb3GFYM0=;
        b=OqsV+54yS0emx2scw4Su+gYKXziOlVR4BNdu/fNXA3jARu39kmAcgr4WcFouCIZ3Se
         h2lOR/kJu38wldia5AhBta7G+iGmZE3Sq6s1lufPmU0ybekZN/U4+SA/qhNnWb3Yj1ES
         UpqWQXuQYAwSQ2Cv1ACRN44O9CkpCO5nC0vuLkfBein5i0C4/S+SpGTzLXdtCf+e3Lv6
         dEIDTtAmXYWoGlxjp3IrM07Pwye9dLBhp2lnIbk6Bswu68SkXIYwKBd3ur+5XczAl0AF
         f/OuHx+b8JqMzoX6Ou72iqMR4MuPeWLBhfjWRmYvFguBMqEYGSxIAeH32L2OKH+PBniE
         6xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qzbLJuQnEYqXpEYDjBQWuosE+DZ0ly05x2Pb3GFYM0=;
        b=kdUb0yds+H1IBTfGb39rIxtDD9O8l6H1bEXvcnMKM5mFOdonJuCoqf5jnKvbgimIow
         FpstCxXphnmNfPJqEJlEyyVvcmKTjai4LvB2TaIuXxKySiI2ckW6L5L+sk69gSJEquF7
         gCOXbzPpw/TY3fUPRWZSSnd/nm6w+JujcKe8IAefqh2Tv4E5CI1CxUT7VjO+R5ikFPBe
         M04OCzPpSYDGnp/6S9oXrmTS5Y4ZKnATiS7LNeCNOuyrQXM4MwSDPWbNA2E1ReqqSJO4
         pwqEb9j0pTHr4KYVFxwqy8YCT7H9dr3Vl5xnF/Ra/OkZRwpCCOmAdKCYTdI85UGFmSVy
         n7oA==
X-Gm-Message-State: ACrzQf2eMgMGJw5q2hmF9LWnkZXQKJy1gaTrIRmGwgUHh7eCYBzAAkd2
        OIILEGshwXBHWOGngAiw3wKsVcHoa04=
X-Google-Smtp-Source: AMsMyM7Ieej1S0y08/HGS/vyx1cQPbSl/gfAaNJnpc2xV+sS8ZOYG17Xkd5l/XkL+hoDII150L+tTA==
X-Received: by 2002:a5d:59a4:0:b0:230:eaa4:88d7 with SMTP id p4-20020a5d59a4000000b00230eaa488d7mr10200914wrr.35.1666297248420;
        Thu, 20 Oct 2022 13:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d44c9000000b0022917d58603sm17419259wrr.32.2022.10.20.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:20:47 -0700 (PDT)
Message-Id: <abdfa888ff5a8275dcd0884cea1df0aa5af108f7.1666297239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 20:20:37 +0000
Subject: [PATCH v2 6/7] submodule update: refactor update targets
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
longer refer to oids directly. This shrinks the next commit's diff,
where this code will need to handle branches.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 138b133790f..990adeb2e19 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2253,7 +2253,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	char *oid = oid_to_hex(&ud->oid);
+	const char *update_target = oid_to_hex(&ud->oid);;
 	int ret;
 
 	switch (ud->update_strategy.type) {
@@ -2283,7 +2283,7 @@ static int run_update_command(const struct update_data *ud, int subforce)
 		BUG("unexpected update strategy type: %d",
 		    ud->update_strategy.type);
 	}
-	strvec_push(&cp.args, oid);
+	strvec_push(&cp.args, update_target);
 
 	cp.dir = ud->sm_path;
 	prepare_submodule_repo_env(&cp.env);
@@ -2291,20 +2291,20 @@ static int run_update_command(const struct update_data *ud, int subforce)
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
@@ -2320,19 +2320,19 @@ static int run_update_command(const struct update_data *ud, int subforce)
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
@@ -2519,6 +2519,7 @@ static void update_data_to_args(const struct update_data *update_data,
 
 static int update_submodule(struct update_data *update_data)
 {
+	int submodule_up_to_date;
 	int ret;
 
 	ret = determine_submodule_update_strategy(the_repository,
@@ -2567,7 +2568,8 @@ static int update_submodule(struct update_data *update_data)
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

