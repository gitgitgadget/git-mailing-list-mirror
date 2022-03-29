Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8363C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 11:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiC2L2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiC2L2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 07:28:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15BB1DFDD3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:26:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a1so24308962wrh.10
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G+ho04CruDVQgyRJUESCNl+VzOy8VDtSGmt6XTKe2X4=;
        b=AikhxoofdhRZsv8bqQk5IIzc2eQ+8quxTlAUDNzIfbeL+Why/lH8TDCUJ198Y+ktWm
         7W5Q+a+k3Q9wyFA/AwUqPpjq+pj1mMe7q6ITfJe6YRJXFsq43XUMtWfPe9OxUPLCMENq
         a9siyNR3bNIFtuYNfaCMWzhTZ//lrO7hS9GkyR2GzxsQn29d2E2iqK3CsAk5IsJ1gXQR
         BBxG2GS9l52cnzOy7CmwXsRrYwftGiUpA1czEvFwr+eOZZemxMJJyahO8i2bQkcdvXcf
         vfIAXNFnsS6MS97VyQgYzIk3IGPoodQN3mtCiINyDfMZrWIAATFVryFsU5e7RDrlidhu
         nXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G+ho04CruDVQgyRJUESCNl+VzOy8VDtSGmt6XTKe2X4=;
        b=zX42x9dXS6K4RQVOGrvVZ4x8oPLST3oz4h5DsMUSpzgXMSf7+tmWeXD6jY24XqiLuW
         2F//OmxNgrqMu8b67mDznyrJ5h+7GbXoO1CxktToa5VF5RrUbE9p8Vez/uzDizQ2ffA2
         2CckBnRgoOSFtvikLgemIcBtn3kL84QuvLdw+39yy0Ma2EN5uIKROXtAkkZNt8ZF+Y0Z
         Dm+axR/DO5dFZpgbbeck5mGhXbmnvSNaFNC+twDNUVl2ouMUb6+Zy0Z5THKT/sZ3Gas1
         IzLBx4mxtlylWgQ1FwEYS6Db4aECMptQ7SrBiQQzAZFGiu+O+jib+95XW5QeaHA81yUQ
         9qeA==
X-Gm-Message-State: AOAM532p46X+fqSl4fGM05s0fY97jrHlL7Gk0Kyzas71I0bBc+G51q+x
        n2WMCtd0XlgRTzNhInWT7diiPyGCp00=
X-Google-Smtp-Source: ABdhPJw/hG0kcYHMn2Id1ws1Tc/KsCUQ8JbmcdniSxX7aQdPAKdLBV0eam44PmQQ9S3p5QK5i+qq1A==
X-Received: by 2002:adf:fd44:0:b0:203:f45f:ce92 with SMTP id h4-20020adffd44000000b00203f45fce92mr30872028wrs.45.1648553210030;
        Tue, 29 Mar 2022 04:26:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b0038ca4fdf7a5sm3050759wms.9.2022.03.29.04.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:26:49 -0700 (PDT)
Message-Id: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
In-Reply-To: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
References: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 11:26:48 +0000
Subject: [PATCH v4] tracking branches: add advice to ambiguous refspec error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>,
        Glen Choo <chooglen@google.com>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The error "not tracking: ambiguous information for ref" is raised
when we are evaluating what tracking information to set on a branch,
and find that the ref to be added as tracking branch is mapped
under multiple remotes' fetch refspecs.

This can easily happen when a user copy-pastes a remote definition
in their git config, and forgets to change the tracking path.

Add advice in this situation, explicitly highlighting which remotes
are involved and suggesting how to correct the situation.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    tracking branches: add advice to ambiguous refspec error
    
    I believe this third version incorporates all Ævar's suggestions, and
    might be usable. Removed "RFC" prefix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%2FTaoK%2Fadvise-ambiguous-tracking-refspec-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/TaoK/advise-ambiguous-tracking-refspec-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1183

Range-diff vs v3:

 1:  22ffe81ac26 = 1:  ac6c782f566 tracking branches: add advice to ambiguous refspec error


 Documentation/config/advice.txt |  4 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 branch.c                        | 44 +++++++++++++++++++++++++++++----
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c40eb09cb7e..90f7dbd03aa 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -4,6 +4,10 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
+	ambiguousFetchRefspec::
+		Advice shown when branch tracking relationship setup fails due
+		to multiple remotes' refspecs mapping to the same remote
+		tracking namespace in the repo.
 	fetchShowForcedUpdates::
 		Advice shown when linkgit:git-fetch[1] takes a long time
 		to calculate forced updates after ref updates, or to warn
diff --git a/advice.c b/advice.c
index 2e1fd483040..18ac8739519 100644
--- a/advice.c
+++ b/advice.c
@@ -39,6 +39,7 @@ static struct {
 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
+	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
diff --git a/advice.h b/advice.h
index a3957123a16..2d4c94f38eb 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ struct string_list;
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AM_WORK_DIR,
+	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
diff --git a/branch.c b/branch.c
index 6b31df539a5..5c28d432103 100644
--- a/branch.c
+++ b/branch.c
@@ -18,9 +18,15 @@ struct tracking {
 	int matches;
 };
 
+struct find_tracked_branch_cb {
+	struct tracking *tracking;
+	struct strbuf remotes_advice;
+};
+
 static int find_tracked_branch(struct remote *remote, void *priv)
 {
-	struct tracking *tracking = priv;
+	struct find_tracked_branch_cb *ftb = priv;
+	struct tracking *tracking = ftb->tracking;
 
 	if (!remote_find_tracking(remote, &tracking->spec)) {
 		if (++tracking->matches == 1) {
@@ -30,6 +36,13 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
 		}
+		/*
+		 * TRANSLATORS: This is a line listing a remote with duplicate
+		 * refspecs, to be later included in advice message
+		 * ambiguousFetchRefspec. For RTL languages you'll probably want
+		 * to swap the "%s" and leading "  " space around.
+		 */
+		strbuf_addf(&ftb->remotes_advice, _("  %s\n"), remote->name);
 		tracking->spec.src = NULL;
 	}
 
@@ -219,6 +232,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	return 0;
 }
 
+
 /*
  * Used internally to set the branch.<new_ref>.{remote,merge} config
  * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
@@ -232,12 +246,16 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	struct tracking tracking;
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	struct find_tracked_branch_cb ftb_cb = {
+		.tracking = &tracking,
+		.remotes_advice = STRBUF_INIT,
+	};
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
 	if (track != BRANCH_TRACK_INHERIT)
-		for_each_remote(find_tracked_branch, &tracking);
+		for_each_remote(find_tracked_branch, &ftb_cb);
 	else if (inherit_tracking(&tracking, orig_ref))
 		goto cleanup;
 
@@ -252,9 +270,24 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			goto cleanup;
 		}
 
-	if (tracking.matches > 1)
-		die(_("not tracking: ambiguous information for ref %s"),
-		    orig_ref);
+	if (tracking.matches > 1) {
+		int status = die_message(_("not tracking: ambiguous information for ref %s"),
+					    orig_ref);
+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
+			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
+				 "tracking ref %s:\n"
+				 "%s"
+				 "\n"
+				 "This is typically a configuration error.\n"
+				 "\n"
+				 "To support setting up tracking branches, ensure that\n"
+				 "different remotes' fetch refspecs map into different\n"
+				 "tracking namespaces."),
+			       orig_ref,
+			       ftb_cb.remotes_advice.buf
+			       );
+		exit(status);
+	}
 
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);
@@ -263,6 +296,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		exit(-1);
 
 cleanup:
+	strbuf_release(&ftb_cb.remotes_advice);
 	string_list_clear(&tracking_srcs, 0);
 }
 

base-commit: abf474a5dd901f28013c52155411a48fd4c09922
-- 
gitgitgadget
