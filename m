Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9047C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CFB2151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOOD4vRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgIMOzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgIMOyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8528C06178B
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w7so10442275pfi.4
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBgatEu4PbcfLkhZema0WcpwWzOIo/lwCYN5CuDldHk=;
        b=FOOD4vRPCbhP+LIgKwhag9L8OVUq5ix7hpkydJQWi8CXOP/IMWxI4DPPL+CRp/mvmN
         ABi240s2VTBpLbUkIEGB2FZPqXXiitXDbXRmhN75NyNE1+v+o9YQRr0N+iE5xbnWltU3
         +rBnHmPxtekUEVQPlZT6tooD9DHz7cAkOTvyC6ieQepABwEO6dYKXM1XU6Iz8gjDfWGm
         NfFF5EmPcE5uGTz+cQ4C3hMdgmxU3QX5Jhp58AyDn6tvqhWO2ztRIEt9tgNmVMYfv4/9
         pRHJbcdkH61MidwmXIRaMyyemGyfVcLS7RA7rKonyBv8GGYk8awnof3eajvYesONM8ky
         LWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBgatEu4PbcfLkhZema0WcpwWzOIo/lwCYN5CuDldHk=;
        b=rN5dG/eZAJQ/fmPEpssuuQP7Gpe5cg1JBM6oRgeaY7V40hUEEwtXjrDOV2sE512S/f
         VqN6MWXzcXhJjY+EiXlmy19xe/fcTUObbfrYOKwDJLBwqTwnGYR7VOxUrXXzExV6ZGz+
         bfYnHgSHSbNBogSTT6BfqfUlDzg0tcHGBDLFSANi4D7LYnS4U3/Xrc9mcc00fHlK/xRV
         vM7/416z6GWkam2jIcjZCbWveJNKC2PnrX1klKuJs0a1ABRP2N3OcUFDW+c1lzvYasYt
         Y5NrdWstfUbjWQyVU4J3UsUHteP9sHAlfoAizIZpS7EKmlkQfIClIJBDI3ABNxxmY7W8
         oJEQ==
X-Gm-Message-State: AOAM532Be7DoIsq7D2+jNNW4Ow3Zj0Put9r2VVIk9p8t6u5SLF5G2nHv
        f3vUyQtpJgKJEJx+FvCNyCOdjxMCdkEZP6GjWDg=
X-Google-Smtp-Source: ABdhPJy7iTQDj0j9K++VmcMAsBPEd+U7xtnfdjIKOwAa/kVrwUEqZfv9aeJ1TBfhRMYsCvvR0zb6Xw==
X-Received: by 2002:a62:e501:0:b029:13c:1611:6527 with SMTP id n1-20020a62e5010000b029013c16116527mr9877057pff.7.1600008879905;
        Sun, 13 Sep 2020 07:54:39 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:39 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 5/7] builtin/push: add option "--[no-]force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:11 +0530
Message-Id: <20200913145413.18351-6-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the option parser to set the flag for "force-if-includes";
add an (optional) advice message to print when the push fails and
the reject reason is "REJECT_REF_NEEDS_UPDATE".

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 advice.c       |  3 +++
 advice.h       |  2 ++
 builtin/push.c | 20 ++++++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index f0a3d32d20..164742305f 100644
--- a/advice.c
+++ b/advice.c
@@ -11,6 +11,7 @@ int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
 int advice_push_needs_force = 1;
 int advice_push_unqualified_ref_name = 1;
+int advice_push_ref_needs_update = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_status_ahead_behind_warning = 1;
@@ -72,6 +73,7 @@ static struct {
 	{ "pushFetchFirst", &advice_push_fetch_first },
 	{ "pushNeedsForce", &advice_push_needs_force },
 	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
+	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
@@ -116,6 +118,7 @@ static struct {
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
 	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
 	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
+	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
 
 	/* make this an alias for backward compatibility */
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 },
diff --git a/advice.h b/advice.h
index 16f2c11642..bc2432980a 100644
--- a/advice.h
+++ b/advice.h
@@ -11,6 +11,7 @@ extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
 extern int advice_push_needs_force;
 extern int advice_push_unqualified_ref_name;
+extern int advice_push_ref_needs_update;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_status_ahead_behind_warning;
@@ -60,6 +61,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
 	ADVICE_PUSH_UPDATE_REJECTED,
+	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_RESET_QUIET_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
diff --git a/builtin/push.c b/builtin/push.c
index bc94078e72..d23b4678b4 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -300,6 +300,12 @@ static const char message_advice_ref_needs_force[] =
 	   "or update a remote ref to make it point at a non-commit object,\n"
 	   "without using the '--force' option.\n");
 
+static const char message_advice_ref_needs_update[] =
+	N_("Updates were rejected because the tip of the remote-tracking\n"
+	   "branch has been updated since the last checkout. You may want\n"
+	   "to integrate those changes locally (e.g., 'git rebase ...')\n"
+	   "before forcing an update.\n");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_update_rejected)
@@ -335,6 +341,13 @@ static void advise_ref_needs_force(void)
 	advise(_(message_advice_ref_needs_force));
 }
 
+static void advise_ref_needs_update(void)
+{
+	if (!advice_push_ref_needs_update || !advice_push_update_rejected)
+		return;
+	advise(_(message_advice_ref_needs_update));
+}
+
 static int push_with_options(struct transport *transport, struct refspec *rs,
 			     int flags)
 {
@@ -384,8 +397,9 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 		advise_ref_fetch_first();
 	} else if (reject_reasons & REJECT_NEEDS_FORCE) {
 		advise_ref_needs_force();
+	} else if (reject_reasons & REJECT_REF_NEEDS_UPDATE) {
+		advise_ref_needs_update();
 	}
-
 	return 1;
 }
 
@@ -521,7 +535,6 @@ static int git_push_config(const char *k, const char *v, void *cb)
 			return config_error_nonbool(k);
 		return color_parse(v, push_colors[slot]);
 	}
-
 	return git_default_config(k, v, NULL);
 }
 
@@ -551,6 +564,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 			       N_("require old value of ref to be at this value"),
 			       PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option),
+		OPT_BIT(0, "force-if-includes", &flags,
+			N_("require remote updates to be integrated locally"),
+			TRANSPORT_PUSH_FORCE_IF_INCLUDES),
 		OPT_CALLBACK(0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
 			     N_("control recursive pushing of submodules"), option_parse_recurse_submodules),
 		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
-- 
2.28.0

