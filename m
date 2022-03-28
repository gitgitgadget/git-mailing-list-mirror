Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F4C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 06:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbiC1GxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiC1GxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 02:53:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1056527E7
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 23:51:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso7941200wmz.4
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 23:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RaQp3q9GlHZoemD46wckbQ1BEybgH54kO/rIxCDPSN0=;
        b=KoVzb8+dqPqMB9P1Ak+4jwGQzCSPBRk0xSoqgaXBv3cvHDwCgu2iiEhwOMlByhn3BR
         BGxcU6U918xMPGu2u3tgLncE3vFq6eqwOjaQ8mRymvLH1AVbL35qbPB2QEylra48f3UR
         nuDCPyve8q80wO/bqlmOkRCH1508EeuEksDTdIAYOGrsFWXygoyYjK9XCc8d6GmCDIl2
         4QtDHH8Lt3hGKmuZblSnoyhzES5lxffd2m24hvVwoLSHvOgifwQa84/NOQxnKPYSCMAe
         RWd99jOM3/q6oQwzHHKoNAk9vT4zBhSq59vGgpNS5bEl2ks117WvMtpMU6TNAlxK7Wbf
         gX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RaQp3q9GlHZoemD46wckbQ1BEybgH54kO/rIxCDPSN0=;
        b=gpdhLKsi94XwYEVgjIDnzKaW5fNSRHl+GLVIpVEaCS/CNXZrwBzSEakXzU6Olyz+k9
         xPEBLe28f2HtyUrnn8waTx1XcTULdGacbTKCSmdO7S5YxeXgxlsMUohNYGtKead4auqf
         b0rEAexE6/2HSgoZC5AY77VjyyI1ApXj0X+5vW4SE36XrG6iG2RDZWCKVlx3LrZleNnF
         /FIVUQLCUXifsglRUZBeBtQhs+goh2kv1L2KcLQfBKHjVQhFeSqMPdU1tsOFPdHjHJKq
         C4kOA3nlndGe9+DBy1eIZgVYxkOjlaxkBR/MBIHr67DZRFeGvhTNUWq/Hlr+JoKZj/u2
         Tjcw==
X-Gm-Message-State: AOAM533TZWSpMN830ecXolIRitnILA1gLQMKd5qWe3JAjaxTVsvZui7j
        p3sSWnB07tyYfw/Ymh6cmknPc1xf8SQ=
X-Google-Smtp-Source: ABdhPJwdA6Csz+iE7CeXFc0J3L6d2ZqrjPEJlXHAk8G/UalTwHoh4+DkCbCn+DhHlkNYuQMrQyH2kg==
X-Received: by 2002:a05:600c:2c49:b0:38c:6b2d:39fc with SMTP id r9-20020a05600c2c4900b0038c6b2d39fcmr24702055wmg.33.1648450269532;
        Sun, 27 Mar 2022 23:51:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm11073975wrv.49.2022.03.27.23.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 23:51:09 -0700 (PDT)
Message-Id: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
In-Reply-To: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 06:51:08 +0000
Subject: [PATCH v3] tracking branches: add advice to ambiguous refspec error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%2FTaoK%2Fadvise-ambiguous-tracking-refspec-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/TaoK/advise-ambiguous-tracking-refspec-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1183

Range-diff vs v2:

 1:  6c1cd885dda ! 1:  22ffe81ac26 RFC: tracking branches: add advice to ambiguous refspec error
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    RFC: tracking branches: add advice to ambiguous refspec error
     +    tracking branches: add advice to ambiguous refspec error
      
          The error "not tracking: ambiguous information for ref" is raised
          when we are evaluating what tracking information to set on a branch,
     @@ Commit message
      
       ## Documentation/config/advice.txt ##
      @@ Documentation/config/advice.txt: advice.*::
     - 		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
     - 		is asked to update index entries outside the current sparse
     - 		checkout.
     + 	can tell Git that you do not need help by setting these to 'false':
     + +
     + --
      +	ambiguousFetchRefspec::
      +		Advice shown when branch tracking relationship setup fails due
      +		to multiple remotes' refspecs mapping to the same remote
      +		tracking namespace in the repo.
     - --
     + 	fetchShowForcedUpdates::
     + 		Advice shown when linkgit:git-fetch[1] takes a long time
     + 		to calculate forced updates after ref updates, or to warn
      
       ## advice.c ##
      @@ advice.c: static struct {
     @@ branch.c: static int find_tracked_branch(struct remote *remote, void *priv)
       			free(tracking->spec.src);
       			string_list_clear(tracking->srcs, 0);
       		}
     -+		strbuf_addf(&ftb->remotes_advice, "  %s\n", remote->name);
     ++		/*
     ++		 * TRANSLATORS: This is a line listing a remote with duplicate
     ++		 * refspecs, to be later included in advice message
     ++		 * ambiguousFetchRefspec. For RTL languages you'll probably want
     ++		 * to swap the "%s" and leading "  " space around.
     ++		 */
     ++		strbuf_addf(&ftb->remotes_advice, _("  %s\n"), remote->name);
       		tracking->spec.src = NULL;
       	}
       
     @@ branch.c: static int inherit_tracking(struct tracking *tracking, const char *ori
       	return 0;
       }
       
     -+
     -+static const char ambiguous_refspec_advice_pre[] =
     -+N_("\n"
     -+"There are multiple remotes whose fetch refspecs map to the remote\n"
     -+"tracking ref";)
     -+static const char ambiguous_refspec_advice_post[] =
     -+N_("This is typically a configuration error.\n"
     -+"\n"
     -+"To support setting up tracking branches, ensure that\n"
     -+"different remotes' fetch refspecs map into different\n"
     -+"tracking namespaces.\n");
      +
       /*
     -  * This is called when new_ref is branched off of orig_ref, and tries
     -  * to infer the settings for branch.<new_ref>.{remote,merge} from the
     +  * Used internally to set the branch.<new_ref>.{remote,merge} config
     +  * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
       	struct tracking tracking;
       	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      -		for_each_remote(find_tracked_branch, &tracking);
      +		for_each_remote(find_tracked_branch, &ftb_cb);
       	else if (inherit_tracking(&tracking, orig_ref))
     - 		return;
     + 		goto cleanup;
       
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
     - 			return;
     + 			goto cleanup;
       		}
       
      -	if (tracking.matches > 1)
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      +		int status = die_message(_("not tracking: ambiguous information for ref %s"),
      +					    orig_ref);
      +		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
     -+			advise("%s %s:\n%s\n%s",
     -+			       _(ambiguous_refspec_advice_pre),
     ++			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
     ++				 "tracking ref %s:\n"
     ++				 "%s"
     ++				 "\n"
     ++				 "This is typically a configuration error.\n"
     ++				 "\n"
     ++				 "To support setting up tracking branches, ensure that\n"
     ++				 "different remotes' fetch refspecs map into different\n"
     ++				 "tracking namespaces."),
      +			       orig_ref,
     -+			       ftb_cb.remotes_advice.buf,
     -+			       _(ambiguous_refspec_advice_post)
     ++			       ftb_cb.remotes_advice.buf
      +			       );
      +		exit(status);
      +	}
       
       	if (tracking.srcs->nr < 1)
       		string_list_append(tracking.srcs, orig_ref);
     +@@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
     + 		exit(-1);
     + 
     + cleanup:
     ++	strbuf_release(&ftb_cb.remotes_advice);
     + 	string_list_clear(&tracking_srcs, 0);
     + }
     + 


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
