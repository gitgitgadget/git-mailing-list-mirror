Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47221C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiCaQDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCaQDR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:03:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201045F8E
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:01:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso1976523wma.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EnDUOzBOTT/nkFBDTM+MsdzkU69arEOPGCIMc8vQNFs=;
        b=C/RXkG9Dzd2lyZcnKFsVaHZlUCn8inb03VR5EBFo34HuEvPYFNcXzyhfW4W2UcZlD9
         LiBc1jouejILZaHgkiDTQnwuHjdmxmxf4L9M3DTtHChvtTtxb8/g1Sscc3huzJ2glE07
         AHZoEQUFx14igb2MzaAjwNw+ZrFIAt1okdWI08QKld40i+E5pCjqX/DNv8jwxIlRheBy
         VJvbGQVti4Nwf/2lBGysO5FETli/pYlDJukV7t4jD7XXB0i0B9R/Yes3SeD+Tm0LmZo8
         jP+i63nF04MSlR2D8GlaZTnh3gWoxByXnaQmkQf6+dNxXqQytI23GYMJctQxbCsZJ2Es
         1GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EnDUOzBOTT/nkFBDTM+MsdzkU69arEOPGCIMc8vQNFs=;
        b=hyzDwz+mN9VGXe2vxlDR00Ml2n+2dKawRhVeNquYwa3TY7Y6AvSc+EeA/xwPxTue1w
         CCqaIYzZqXacipzrfRwFwAOIoSne8k5ng61Al5aCYfdBnbAgdKVgOFjaP//mt6s2nb2J
         Hj2Ni1Q3gPC8vcjImcazvr5/DovKQ2HtvgdQL7G0kgHUCo8g1eHe+jZ8WAmn4z1qWew3
         BoyenZzzuooxBfzphYXhsr30GGtbIJ6bepijP58s46Cn7Xy1WX3qD8Kopa3gsuCTQawZ
         E2P9eMvNLs71aVzXEUnqRBl2EdABfb+55EUur5qT3HLcxqVHe0MDAKNL0C6pOp/GoaLC
         dhxw==
X-Gm-Message-State: AOAM531/1V8kvIz0DAQ8L4sd/YrR+JkthIMIdF7BlDHY340c122SfBMz
        buvCgoUCdhSjFTFFeT/uRGwWj7aVuWo=
X-Google-Smtp-Source: ABdhPJzTt7svjEYHT8YRdIP4nfovMzRyLpvev0zn3TPkjRVzIaNRbIM51Gy0qFK+RVDErKak5FNGiw==
X-Received: by 2002:a05:600c:4608:b0:38c:6ba3:1c9f with SMTP id m8-20020a05600c460800b0038c6ba31c9fmr5348291wmo.39.1648742487186;
        Thu, 31 Mar 2022 09:01:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d4051000000b00205a8bb9c18sm15986849wrp.67.2022.03.31.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:01:26 -0700 (PDT)
Message-Id: <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com>
In-Reply-To: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
References: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 16:01:25 +0000
Subject: [PATCH v6] tracking branches: add advice to ambiguous refspec error
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
    
    v6 addresses some formatting and commenting issues Ævar noticed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%2FTaoK%2Fadvise-ambiguous-tracking-refspec-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/TaoK/advise-ambiguous-tracking-refspec-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1183

Range-diff vs v5:

 1:  4478eaed6df ! 1:  2408ab0ccb3 tracking branches: add advice to ambiguous refspec error
     @@ branch.c: struct tracking {
      -		} else {
      +			break;
      +		case 2:
     -+			// there are at least two remotes; backfill the first one
     ++			/* there are at least two remotes; backfill the first one */
      +			string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
      +			/* fall through */
      +		default:
     @@ branch.c: struct tracking {
       		}
       		tracking->spec.src = NULL;
       	}
     -@@ branch.c: static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
     - 	return 0;
     - }
     - 
     -+
     - /*
     -  * Used internally to set the branch.<new_ref>.{remote,merge} config
     -  * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
       	struct tracking tracking;
       	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      -		die(_("not tracking: ambiguous information for ref %s"),
      -		    orig_ref);
      +	if (tracking.matches > 1) {
     -+		int status = die_message(_("not tracking: ambiguous information for ref %s"),
     ++		int status = die_message(_("not tracking: ambiguous information for ref '%s'"),
      +					    orig_ref);
      +		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
      +			struct strbuf remotes_advice = STRBUF_INIT;
      +			struct string_list_item *item;
      +
     -+			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes) {
     ++			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes)
      +				/*
      +				 * TRANSLATORS: This is a line listing a remote with duplicate
      +				 * refspecs in the advice message below. For RTL languages you'll
      +				 * probably want to swap the "%s" and leading "  " space around.
      +				 */
      +				strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
     -+			}
      +
     ++			/*
     ++			 * TRANSLATORS: The second argument is a \n-delimited list of
     ++			 * duplicate refspecs, composed above.
     ++			 */
      +			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
     -+				 "tracking ref %s:\n"
     ++				 "tracking ref '%s':\n"
      +				 "%s"
      +				 "\n"
      +				 "This is typically a configuration error.\n"
      +				 "\n"
      +				 "To support setting up tracking branches, ensure that\n"
      +				 "different remotes' fetch refspecs map into different\n"
     -+				 "tracking namespaces."),
     -+			       orig_ref,
     -+			       remotes_advice.buf
     -+			       );
     ++				 "tracking namespaces."), orig_ref,
     ++			       remotes_advice.buf);
      +			strbuf_release(&remotes_advice);
      +		}
      +		exit(status);


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
index 6b31df539a5..812ceae2d0f 100644
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
+			/* there are at least two remotes; backfill the first one */
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
@@ -232,12 +246,16 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
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
 
@@ -252,9 +270,39 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			goto cleanup;
 		}
 
-	if (tracking.matches > 1)
-		die(_("not tracking: ambiguous information for ref %s"),
-		    orig_ref);
+	if (tracking.matches > 1) {
+		int status = die_message(_("not tracking: ambiguous information for ref '%s'"),
+					    orig_ref);
+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
+			struct strbuf remotes_advice = STRBUF_INIT;
+			struct string_list_item *item;
+
+			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes)
+				/*
+				 * TRANSLATORS: This is a line listing a remote with duplicate
+				 * refspecs in the advice message below. For RTL languages you'll
+				 * probably want to swap the "%s" and leading "  " space around.
+				 */
+				strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
+
+			/*
+			 * TRANSLATORS: The second argument is a \n-delimited list of
+			 * duplicate refspecs, composed above.
+			 */
+			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
+				 "tracking ref '%s':\n"
+				 "%s"
+				 "\n"
+				 "This is typically a configuration error.\n"
+				 "\n"
+				 "To support setting up tracking branches, ensure that\n"
+				 "different remotes' fetch refspecs map into different\n"
+				 "tracking namespaces."), orig_ref,
+			       remotes_advice.buf);
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
