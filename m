Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EE3C25B08
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiHER7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiHER67 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:58:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D29F75395
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:58:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a11so1736112wmq.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=puiFefnhp9YNXAJZhdLn9aOrVcAqFC0f/T/E+4AEqvs=;
        b=Rcr7tvOBkGB+047svleuS7YpNBjcLnxiJigdb4A4GGrgtviw6XjbYrFRqPahfgyROj
         Y8X/2HwracM98qlXN8ph91VVkgbRmKX9U0ZJoTHwffbj92YO0Wc6EyltW1Mojw5epU+q
         GeDjQ9MLLNVZrviuGSJ8Y18VsLi1twTS3BDYCpF0JgX49HcjJcNDg9mYYju17QNAmmaW
         sLQKhxSRQpIO1kLzdHiA+KnpKT0la4qhK/hK/ca8IPUguuIrHhrpZRFnDqwX+ui4a76I
         2n37CEfcAM7oNsSHEHJtAJlShTKZTQIuqBrHrUa/axU6GvyUdox1f33N6UKPTZtUjkPB
         Lnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=puiFefnhp9YNXAJZhdLn9aOrVcAqFC0f/T/E+4AEqvs=;
        b=WpqZMmmXCpm8sErXVB9nujPu48qzEFoTjY53PavxH0eU/OmNVm/cxCU3J4TKT5LILp
         44lrMQWLbMoaUqRFrYlyTSzlXXWQi8QL1OYOLGP6cigz0m3e7KBrs0oUszoYfMRXJxcc
         ihvwRBGgw09wn9b815j8o6PtYrEmWbWfExpu/1H+mPsz1V2d4YdXSrFZRxDTBOHac0CC
         yAd1UFMeaCArhOTp0sZAdbC4E9Fk+ZAiNVsRkvZ4W7Riyv3oZyZP8XG/Oxv/lTP0KCr2
         4IUavn13peMfv6nomrgX1BMp5V9sfsRxGd3oL6i9h4UqxP3AZtSwGEurEuxqL2GfTj2p
         vNEQ==
X-Gm-Message-State: ACgBeo1N58HbIeyLRr8z2RDUO7nH6TMYOjQDira1P353gQCrpjS8eVsT
        4rk75T7syErG4P8JJF9JzxL8w0NMD2s=
X-Google-Smtp-Source: AA6agR74ZNVs3V2Es1CDLUQ5Su8PeUB5WharnLq2UmckVyndauNdke6vSgRqZ1O4hJpJHl2LN8Hn0g==
X-Received: by 2002:a1c:cc0f:0:b0:3a5:333:310d with SMTP id h15-20020a1ccc0f000000b003a50333310dmr5439177wmb.122.1659722335109;
        Fri, 05 Aug 2022 10:58:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020adfe681000000b002216d3aee78sm2397131wrm.86.2022.08.05.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:54 -0700 (PDT)
Message-Id: <475ebca6310768adb11fc5b64fb5499f20b3cd5f.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:36 +0000
Subject: [PATCH v3 04/11] refs: add array of ref namespaces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Git interprets different meanings to different refs based on their
names. Some meanings are cosmetic, like how refs in  'refs/remotes/*'
are colored differently from refs in 'refs/heads/*'. Others are more
critical, such as how replace refs are interpreted.

Before making behavior changes based on ref namespaces, collect all
known ref namespaces into a array of ref_namespace_info structs. This
array is indexed by the new ref_namespace enum for quick access.

As of this change, this array is purely documentation. Future changes
will add dependencies on this array.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 environment.c |  2 ++
 notes.c       |  1 +
 refs.c        | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h        | 46 ++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/environment.c b/environment.c
index b3296ce7d15..9eb22f975c7 100644
--- a/environment.c
+++ b/environment.c
@@ -185,6 +185,8 @@ void setup_git_env(const char *git_dir)
 	free(git_replace_ref_base);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
+
 	free(git_namespace);
 	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/notes.c b/notes.c
index 7452e71cc8d..7bade6d8f69 100644
--- a/notes.c
+++ b/notes.c
@@ -1005,6 +1005,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 
 	if (!notes_ref)
 		notes_ref = default_notes_ref();
+	update_ref_namespace(NAMESPACE_NOTES, xstrdup(notes_ref));
 
 	if (!combine_notes)
 		combine_notes = combine_notes_concatenate;
diff --git a/refs.c b/refs.c
index 3fdfa86a5b9..65decf25d09 100644
--- a/refs.c
+++ b/refs.c
@@ -20,6 +20,7 @@
 #include "repository.h"
 #include "sigchain.h"
 #include "date.h"
+#include "commit.h"
 
 /*
  * List of all available backends
@@ -56,6 +57,88 @@ static unsigned char refname_disposition[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
 };
 
+struct ref_namespace_info ref_namespace[] = {
+	[NAMESPACE_HEAD] = {
+		.ref = "HEAD",
+		.decoration = DECORATION_REF_HEAD,
+		.exact = 1,
+	},
+	[NAMESPACE_BRANCHES] = {
+		.ref = "refs/heads/",
+		.decoration = DECORATION_REF_LOCAL,
+	},
+	[NAMESPACE_TAGS] = {
+		.ref = "refs/tags/",
+		.decoration = DECORATION_REF_TAG,
+	},
+	[NAMESPACE_REMOTE_REFS] = {
+		/*
+		 * The default refspec for new remotes copies refs from
+		 * refs/heads/ on the remote into refs/remotes/<remote>/.
+		 * As such, "refs/remotes/" has special handling.
+		 */
+		.ref = "refs/remotes/",
+		.decoration = DECORATION_REF_REMOTE,
+	},
+	[NAMESPACE_STASH] = {
+		/*
+		 * The single ref "refs/stash" stores the latest stash.
+		 * Older stashes can be found in the reflog.
+		 */
+		.ref = "refs/stash",
+		.exact = 1,
+		.decoration = DECORATION_REF_STASH,
+	},
+	[NAMESPACE_REPLACE] = {
+		/*
+		 * This namespace allows Git to act as if one object ID
+		 * points to the content of another. Unlike the other
+		 * ref namespaces, this one can be changed by the
+		 * GIT_REPLACE_REF_BASE environment variable. This
+		 * .namespace value will be overwritten in setup_git_env().
+		 */
+		.ref = "refs/replace/",
+		.decoration = DECORATION_GRAFTED,
+	},
+	[NAMESPACE_NOTES] = {
+		/*
+		 * The refs/notes/commit ref points to the tip of a
+		 * parallel commit history that adds metadata to commits
+		 * in the normal history. This ref can be overwritten
+		 * by the core.notesRef config variable or the
+		 * GIT_NOTES_REFS environment variable.
+		 */
+		.ref = "refs/notes/commit",
+		.exact = 1,
+	},
+	[NAMESPACE_PREFETCH] = {
+		/*
+		 * Prefetch refs are written by the background 'fetch'
+		 * maintenance task. It allows faster foreground fetches
+		 * by advertising these previously-downloaded tips without
+		 * updating refs/remotes/ without user intervention.
+		 */
+		.ref = "refs/prefetch/",
+	},
+	[NAMESPACE_REWRITTEN] = {
+		/*
+		 * Rewritten refs are used by the 'label' command in the
+		 * sequencer. These are particularly useful during an
+		 * interactive rebase that uses the 'merge' command.
+		 */
+		.ref = "refs/rewritten/",
+	},
+};
+
+void update_ref_namespace(enum ref_namespace namespace, char *ref)
+{
+	struct ref_namespace_info *info = &ref_namespace[namespace];
+	if (info->ref_updated)
+		free(info->ref);
+	info->ref = ref;
+	info->ref_updated = 1;
+}
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
diff --git a/refs.h b/refs.h
index 47cb9edbaa8..d6575b8c2bd 100644
--- a/refs.h
+++ b/refs.h
@@ -2,6 +2,7 @@
 #define REFS_H
 
 #include "cache.h"
+#include "commit.h"
 
 struct object_id;
 struct ref_store;
@@ -930,4 +931,49 @@ struct ref_store *get_main_ref_store(struct repository *r);
 struct ref_store *get_submodule_ref_store(const char *submodule);
 struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
+/*
+ * Some of the names specified by refs have special meaning to Git.
+ * Organize these namespaces in a comon 'ref_namespace' array for
+ * reference from multiple places in the codebase.
+ */
+
+struct ref_namespace_info {
+	char *ref;
+	enum decoration_type decoration;
+
+	/*
+	 * If 'exact' is true, then we must match the 'ref' exactly.
+	 * Otherwise, use a prefix match.
+	 *
+	 * 'ref_updated' is for internal use. It represents whether the
+	 * 'ref' value was replaced from its original literal version.
+	 */
+	unsigned exact:1,
+		 ref_updated:1;
+};
+
+enum ref_namespace {
+	NAMESPACE_HEAD,
+	NAMESPACE_BRANCHES,
+	NAMESPACE_TAGS,
+	NAMESPACE_REMOTE_REFS,
+	NAMESPACE_STASH,
+	NAMESPACE_REPLACE,
+	NAMESPACE_NOTES,
+	NAMESPACE_PREFETCH,
+	NAMESPACE_REWRITTEN,
+
+	/* Must be last */
+	NAMESPACE__COUNT
+};
+
+/* See refs.c for the contents of this array. */
+extern struct ref_namespace_info ref_namespace[NAMESPACE__COUNT];
+
+/*
+ * Some ref namespaces can be modified by config values or environment
+ * variables. Modify a namespace as specified by its ref_namespace key.
+ */
+void update_ref_namespace(enum ref_namespace namespace, char *ref);
+
 #endif /* REFS_H */
-- 
gitgitgadget

