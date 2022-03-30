Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DFFC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 07:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbiC3HWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 03:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiC3HV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 03:21:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9F1945D9
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 00:20:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso611829wme.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wXyfsBzq1brSvRlpdof64JnGEQSDwSeamNPXFEMooo0=;
        b=i0vxVf/X+8spSQ364MNFrUwFL8UN+6YwrRYpDUfutn5p6AT/u927A5+OIlYdLvyLI7
         01tq+2vKhfWvJ9hD6ZwsoWL5rOcOzRL+EZKNLwJ5gXr7YIH4rCuRY1WnQNebyAFu2UQn
         RiwixFJhdnkxW5/2FnDoAwpL3DZdnRzsEN3tVAgAAKSSxBXb8nSzjqgeppsO5mSH5zBv
         jJg3nUtmwnLGPvFMWqgrzXvx1qz+Z4yS024i6RiML69GTVYwaEmsAg5nAPrG6LXAFJOK
         QlcjvqAKBfCGvaKYCLXhZpgzx1vQckHrhwk1aFQykztOoZLGA3KA+EzqxbFIQ+sBfK/D
         n2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wXyfsBzq1brSvRlpdof64JnGEQSDwSeamNPXFEMooo0=;
        b=NSCpk0xmCDaTeNN/QTkYEJfkveSDNOFMCF75ps1Hr0/qquJy0lcLOU1B1mbCIL8w8R
         Vnv9rF/2lNIfuVd/sE79qaY8Hi8zsjBBNGrhtY0eYV5jxi/3csos67gYvarwK8proYha
         OiAEyrPvztLsQate/07XOfU8WMTIuc7/Bz8eCMsw4deEFfdyWsHsDF/y/Y3YS0raxq2W
         dg4sJXd8tnnjcmxdFvLmLye3vtIAU3TxV3l3vE5aRoI65bRfwmoq974RjkFFbhYppx3T
         lIScC8SQxeDMLhJlHvzJ+131V45767tF5hcfOMulHX6FTDLlCDHA3AcBqEIyHl70i/cJ
         9pIA==
X-Gm-Message-State: AOAM533uAHYJYt2NRz8/IWluwg6nL0SLgKgvU11vqzmov3f/vWSRqb6t
        PyqhN4nPRq9G4dpcii0R6asrh7B7Y2c=
X-Google-Smtp-Source: ABdhPJzzICJkf3YcUEmb4kmzes4xqUsC8EwOsNxPKngIjh9zkJkcZNgZwcxqgAC+uZAx9SSsG3lVEA==
X-Received: by 2002:a05:600c:5021:b0:38c:70c0:80e9 with SMTP id n33-20020a05600c502100b0038c70c080e9mr3030764wmr.91.1648624812193;
        Wed, 30 Mar 2022 00:20:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b00205c0cb33e0sm7682025wrw.35.2022.03.30.00.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 00:20:11 -0700 (PDT)
Message-Id: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
In-Reply-To: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 07:20:10 +0000
Subject: [PATCH v5] tracking branches: add advice to ambiguous refspec error
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
    
    This fifth version attempts to address Junio's concerns over unnecessary
    extra error-preparation work being done in the very-vastly-more-common
    "normal" case.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%2FTaoK%2Fadvise-ambiguous-tracking-refspec-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/TaoK/advise-ambiguous-tracking-refspec-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1183

Range-diff vs v4:

 1:  ac6c782f566 ! 1:  4478eaed6df tracking branches: add advice to ambiguous refspec error
     @@ Documentation/config/advice.txt: advice.*::
       +
       --
      +	ambiguousFetchRefspec::
     -+		Advice shown when branch tracking relationship setup fails due
     -+		to multiple remotes' refspecs mapping to the same remote
     -+		tracking namespace in the repo.
     ++		Advice shown when fetch refspec for multiple remotes map to
     ++		the same remote-tracking branch namespace and causes branch
     ++		tracking set-up to fail.
       	fetchShowForcedUpdates::
       		Advice shown when linkgit:git-fetch[1] takes a long time
       		to calculate forced updates after ref updates, or to warn
     @@ branch.c: struct tracking {
       
      +struct find_tracked_branch_cb {
      +	struct tracking *tracking;
     -+	struct strbuf remotes_advice;
     ++	struct string_list ambiguous_remotes;
      +};
      +
       static int find_tracked_branch(struct remote *remote, void *priv)
     @@ branch.c: struct tracking {
      +	struct tracking *tracking = ftb->tracking;
       
       	if (!remote_find_tracking(remote, &tracking->spec)) {
     - 		if (++tracking->matches == 1) {
     -@@ branch.c: static int find_tracked_branch(struct remote *remote, void *priv)
     +-		if (++tracking->matches == 1) {
     ++		switch (++tracking->matches) {
     ++		case 1:
     + 			string_list_append(tracking->srcs, tracking->spec.src);
     + 			tracking->remote = remote->name;
     +-		} else {
     ++			break;
     ++		case 2:
     ++			// there are at least two remotes; backfill the first one
     ++			string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
     ++			/* fall through */
     ++		default:
     ++			string_list_append(&ftb->ambiguous_remotes, remote->name);
       			free(tracking->spec.src);
       			string_list_clear(tracking->srcs, 0);
     ++		break;
       		}
     -+		/*
     -+		 * TRANSLATORS: This is a line listing a remote with duplicate
     -+		 * refspecs, to be later included in advice message
     -+		 * ambiguousFetchRefspec. For RTL languages you'll probably want
     -+		 * to swap the "%s" and leading "  " space around.
     -+		 */
     -+		strbuf_addf(&ftb->remotes_advice, _("  %s\n"), remote->name);
       		tracking->spec.src = NULL;
       	}
     - 
      @@ branch.c: static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
       	return 0;
       }
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
       	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
      +	struct find_tracked_branch_cb ftb_cb = {
      +		.tracking = &tracking,
     -+		.remotes_advice = STRBUF_INIT,
     ++		.ambiguous_remotes = STRING_LIST_INIT_DUP,
      +	};
       
       	memset(&tracking, 0, sizeof(tracking));
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      +	if (tracking.matches > 1) {
      +		int status = die_message(_("not tracking: ambiguous information for ref %s"),
      +					    orig_ref);
     -+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
     ++		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
     ++			struct strbuf remotes_advice = STRBUF_INIT;
     ++			struct string_list_item *item;
     ++
     ++			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes) {
     ++				/*
     ++				 * TRANSLATORS: This is a line listing a remote with duplicate
     ++				 * refspecs in the advice message below. For RTL languages you'll
     ++				 * probably want to swap the "%s" and leading "  " space around.
     ++				 */
     ++				strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
     ++			}
     ++
      +			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
      +				 "tracking ref %s:\n"
      +				 "%s"
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      +				 "different remotes' fetch refspecs map into different\n"
      +				 "tracking namespaces."),
      +			       orig_ref,
     -+			       ftb_cb.remotes_advice.buf
     ++			       remotes_advice.buf
      +			       );
     ++			strbuf_release(&remotes_advice);
     ++		}
      +		exit(status);
      +	}
       
       	if (tracking.srcs->nr < 1)
       		string_list_append(tracking.srcs, orig_ref);
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
     - 		exit(-1);
       
       cleanup:
     -+	strbuf_release(&ftb_cb.remotes_advice);
       	string_list_clear(&tracking_srcs, 0);
     ++	string_list_clear(&ftb_cb.ambiguous_remotes, 0);
       }
       
     + int read_branch_desc(struct strbuf *buf, const char *branch_name)


 Documentation/config/advice.txt |  4 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 branch.c                        | 63 +++++++++++++++++++++++++++++----
 4 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c40eb09cb7e..343d271c707 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -4,6 +4,10 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
+	ambiguousFetchRefspec::
+		Advice shown when fetch refspec for multiple remotes map to
+		the same remote-tracking branch namespace and causes branch
+		tracking set-up to fail.
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
index 6b31df539a5..e6ab50fff41 100644
--- a/branch.c
+++ b/branch.c
@@ -18,17 +18,31 @@ struct tracking {
 	int matches;
 };
 
+struct find_tracked_branch_cb {
+	struct tracking *tracking;
+	struct string_list ambiguous_remotes;
+};
+
 static int find_tracked_branch(struct remote *remote, void *priv)
 {
-	struct tracking *tracking = priv;
+	struct find_tracked_branch_cb *ftb = priv;
+	struct tracking *tracking = ftb->tracking;
 
 	if (!remote_find_tracking(remote, &tracking->spec)) {
-		if (++tracking->matches == 1) {
+		switch (++tracking->matches) {
+		case 1:
 			string_list_append(tracking->srcs, tracking->spec.src);
 			tracking->remote = remote->name;
-		} else {
+			break;
+		case 2:
+			// there are at least two remotes; backfill the first one
+			string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
+			/* fall through */
+		default:
+			string_list_append(&ftb->ambiguous_remotes, remote->name);
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
+		break;
 		}
 		tracking->spec.src = NULL;
 	}
@@ -219,6 +233,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	return 0;
 }
 
+
 /*
  * Used internally to set the branch.<new_ref>.{remote,merge} config
  * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
@@ -232,12 +247,16 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	struct tracking tracking;
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	struct find_tracked_branch_cb ftb_cb = {
+		.tracking = &tracking,
+		.ambiguous_remotes = STRING_LIST_INIT_DUP,
+	};
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
 	if (track != BRANCH_TRACK_INHERIT)
-		for_each_remote(find_tracked_branch, &tracking);
+		for_each_remote(find_tracked_branch, &ftb_cb);
 	else if (inherit_tracking(&tracking, orig_ref))
 		goto cleanup;
 
@@ -252,9 +271,38 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			goto cleanup;
 		}
 
-	if (tracking.matches > 1)
-		die(_("not tracking: ambiguous information for ref %s"),
-		    orig_ref);
+	if (tracking.matches > 1) {
+		int status = die_message(_("not tracking: ambiguous information for ref %s"),
+					    orig_ref);
+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
+			struct strbuf remotes_advice = STRBUF_INIT;
+			struct string_list_item *item;
+
+			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes) {
+				/*
+				 * TRANSLATORS: This is a line listing a remote with duplicate
+				 * refspecs in the advice message below. For RTL languages you'll
+				 * probably want to swap the "%s" and leading "  " space around.
+				 */
+				strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
+			}
+
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
+			       remotes_advice.buf
+			       );
+			strbuf_release(&remotes_advice);
+		}
+		exit(status);
+	}
 
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);
@@ -264,6 +312,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 cleanup:
 	string_list_clear(&tracking_srcs, 0);
+	string_list_clear(&ftb_cb.ambiguous_remotes, 0);
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)

base-commit: abf474a5dd901f28013c52155411a48fd4c09922
-- 
gitgitgadget
