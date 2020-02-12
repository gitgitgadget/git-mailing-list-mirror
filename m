Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A3CC3B187
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133772082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLQPyPb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgBLTTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:19:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34735 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLTTR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 14:19:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so1832224wrm.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cFXoXbSaXwaW0KrHK7ZmljCX3KtFHJMNZypnZtF8yEA=;
        b=uLQPyPb2txBqHEYHJlemEKN/2rV/nzTJUdu9xM6y0T/25EFamhL50B2ZoCl+wFSSXW
         3WMoD0Rbs6+ZI/avy22t8NibuszyQcN7zVwF5aq9ZuZM37W8Qky1jKPt4W56jKjIecn0
         H+vRSsyZVMBXS/5LMWcjYmymPlP4jBI+U5FqQpOIl7U4f0Sowphpb/sCdseB2J2qSv/u
         PvFcVs/trQvpZddWPnnCkSMt3yU2E3D1f51xs14z8Dlb8sUxLLAyOTIQzveg06o+EsBs
         BFk6Ec+3djebl4Q8h2hCTGV0dq1hBCE+COMaoO/E8h1o5FLCmG2A+H/r48Foo10hv/1+
         KJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cFXoXbSaXwaW0KrHK7ZmljCX3KtFHJMNZypnZtF8yEA=;
        b=b/KQvPaxUIg761ZHXhgwNsTFFqf3VGDUT+Noobsh9+nc+nWSCU7oJv8sYZ33QHj9iA
         riNKtEqX1k8t1Sh7r6LOjjrdEDUs7S6SPCw6ODhPHDZVCtWkMxY84M8muMQdLRR2K/9j
         CoEg6ZF4fo2TLZXY4anAutS9WeAiNht4hsIqpoBpaLHOL39sEdXBzZWbkt5EZcLas88e
         nd43wvFikJf+4WL/NfOyKrxPj3on8ijJRxG61YApLsc13hs7GSbdFWB21ho4FJZZy+qy
         GRxOwTVlNC6K23iNA9dO78nf5aWCKW7bnfIKNAgMfrvjjrZHT3EkDeDg6KPtyKynKjq3
         k1dw==
X-Gm-Message-State: APjAAAX0iYgCbw7viK8BCDqTBdDXovDPP9Ccd/H4VuFNgE24SvIEPrwR
        1dCO39x58YgiErSzBQYsXsGRt2Oh
X-Google-Smtp-Source: APXvYqyXVBvVfSbwlnKrnK4fMhpoXqVcSxDAXCWADWXOgxggGRmidVbRBQGdmjz6llpLjwqUUDH4hQ==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr16930234wro.421.1581535153008;
        Wed, 12 Feb 2020 11:19:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm1717156wmi.44.2020.02.12.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:19:12 -0800 (PST)
Message-Id: <d98b7caff56cc839f251ac43c36826ecf800cf2f.1581535151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.545.git.1581535151.gitgitgadget@gmail.com>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
From:   "Parth Gala via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 19:19:07 +0000
Subject: [PATCH 1/5] object.c: get_max_object_index and get_indexed_object
 accept 'r' parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Parth Gala <parthpgala@gmail.com>,
        Parth Gala <parthpgala@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Parth Gala <parthpgala@gmail.com>

Currently the two functions use global variable 'the_repository' to access
the values stored in it. This makes 'the_repository' to be existent even
when not required.

This commit replaces it with 'r' which is passed as a parameter to those
functions.

Signed-off-by: Parth Gala <parthpgala@gmail.com>
---
 builtin/fsck.c       |  5 +++--
 builtin/index-pack.c |  5 +++--
 builtin/name-rev.c   |  5 +++--
 object.c             |  8 ++++----
 object.h             |  4 ++--
 shallow.c            | 10 ++++++----
 upload-pack.c        | 10 ++++++----
 7 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8d13794b14..d2b4336f7e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -375,6 +375,7 @@ static void check_object(struct object *obj)
 static void check_connectivity(void)
 {
 	int i, max;
+	struct repository *r = the_repository;
 
 	/* Traverse the pending reachable objects */
 	traverse_reachable();
@@ -400,12 +401,12 @@ static void check_connectivity(void)
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
-	max = get_max_object_index();
+	max = get_max_object_index(r);
 	if (verbose)
 		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
 
 	for (i = 0; i < max; i++) {
-		struct object *obj = get_indexed_object(i);
+		struct object *obj = get_indexed_object(r, i);
 
 		if (obj)
 			check_object(obj);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 60a5591039..d2115535bc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -218,14 +218,15 @@ static unsigned check_object(struct object *obj)
 static unsigned check_objects(void)
 {
 	unsigned i, max, foreign_nr = 0;
+	struct repository *r = the_repository;
 
-	max = get_max_object_index();
+	max = get_max_object_index(r);
 
 	if (verbose)
 		progress = start_delayed_progress(_("Checking objects"), max);
 
 	for (i = 0; i < max; i++) {
-		foreign_nr += check_object(get_indexed_object(i));
+		foreign_nr += check_object(get_indexed_object(r, i));
 		display_progress(progress, i + 1);
 	}
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6b9e8c850b..afe9f6df01 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -456,6 +456,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
+	struct repository *r = the_repository;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
@@ -553,9 +554,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	} else if (all) {
 		int i, max;
 
-		max = get_max_object_index();
+		max = get_max_object_index(r);
 		for (i = 0; i < max; i++) {
-			struct object *obj = get_indexed_object(i);
+			struct object *obj = get_indexed_object(r, i);
 			if (!obj || obj->type != OBJ_COMMIT)
 				continue;
 			show_name(obj, NULL,
diff --git a/object.c b/object.c
index 142ef69399..549fbe69ca 100644
--- a/object.c
+++ b/object.c
@@ -10,14 +10,14 @@
 #include "packfile.h"
 #include "commit-graph.h"
 
-unsigned int get_max_object_index(void)
+unsigned int get_max_object_index(struct repository *r)
 {
-	return the_repository->parsed_objects->obj_hash_size;
+	return r->parsed_objects->obj_hash_size;
 }
 
-struct object *get_indexed_object(unsigned int idx)
+struct object *get_indexed_object(struct repository *r, unsigned int idx)
 {
-	return the_repository->parsed_objects->obj_hash[idx];
+	return r->parsed_objects->obj_hash[idx];
 }
 
 static const char *object_type_strings[] = {
diff --git a/object.h b/object.h
index 25f5ab3d54..5a8ae274ee 100644
--- a/object.h
+++ b/object.h
@@ -98,12 +98,12 @@ int type_from_string_gently(const char *str, ssize_t, int gentle);
 /*
  * Return the current number of buckets in the object hashmap.
  */
-unsigned int get_max_object_index(void);
+unsigned int get_max_object_index(struct repository *);
 
 /*
  * Return the object from the specified bucket in the object hashmap.
  */
-struct object *get_indexed_object(unsigned int);
+struct object *get_indexed_object(struct repository *, unsigned int);
 
 /*
  * This can be used to see if we have heard of the object before, but
diff --git a/shallow.c b/shallow.c
index 7fd04afed1..4537d98482 100644
--- a/shallow.c
+++ b/shallow.c
@@ -510,6 +510,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 		       unsigned int id)
 {
 	unsigned int i, nr;
+	struct repository *r = the_repository;
 	struct commit_list *head = NULL;
 	int bitmap_nr = DIV_ROUND_UP(info->nr_bits, 32);
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
@@ -563,9 +564,9 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 		}
 	}
 
-	nr = get_max_object_index();
+	nr = get_max_object_index(r);
 	for (i = 0; i < nr; i++) {
-		struct object *o = get_indexed_object(i);
+		struct object *o = get_indexed_object(r, i);
 		if (o && o->type == OBJ_COMMIT)
 			o->flags &= ~SEEN;
 	}
@@ -608,6 +609,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	struct object_id *oid = info->shallow->oid;
 	struct oid_array *ref = info->ref;
 	unsigned int i, nr;
+	struct repository *r = the_repository;
 	int *shallow, nr_shallow = 0;
 	struct paint_info pi;
 
@@ -622,9 +624,9 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * Prepare the commit graph to track what refs can reach what
 	 * (new) shallow commits.
 	 */
-	nr = get_max_object_index();
+	nr = get_max_object_index(r);
 	for (i = 0; i < nr; i++) {
-		struct object *o = get_indexed_object(i);
+		struct object *o = get_indexed_object(r, i);
 		if (!o || o->type != OBJ_COMMIT)
 			continue;
 
diff --git a/upload-pack.c b/upload-pack.c
index a00d7ece6b..cb7312268f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -450,6 +450,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 		"rev-list", "--stdin", NULL,
 	};
 	struct object *o;
+	struct repository *r = the_repository;
 	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	int i;
 	const unsigned hexsz = the_hash_algo->hexsz;
@@ -472,8 +473,8 @@ static int do_reachable_revlist(struct child_process *cmd,
 
 	namebuf[0] = '^';
 	namebuf[hexsz + 1] = '\n';
-	for (i = get_max_object_index(); 0 < i; ) {
-		o = get_indexed_object(--i);
+	for (i = get_max_object_index(r); 0 < i; ) {
+		o = get_indexed_object(r, --i);
 		if (!o)
 			continue;
 		if (reachable && o->type == OBJ_COMMIT)
@@ -520,6 +521,7 @@ static int get_reachable_list(struct object_array *src,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int i;
 	struct object *o;
+	struct repository *r = the_repository;
 	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	const unsigned hexsz = the_hash_algo->hexsz;
 
@@ -538,8 +540,8 @@ static int get_reachable_list(struct object_array *src,
 			o->flags &= ~TMP_MARK;
 		}
 	}
-	for (i = get_max_object_index(); 0 < i; i--) {
-		o = get_indexed_object(i - 1);
+	for (i = get_max_object_index(r); 0 < i; i--) {
+		o = get_indexed_object(r, i - 1);
 		if (o && o->type == OBJ_COMMIT &&
 		    (o->flags & TMP_MARK)) {
 			add_object_array(o, NULL, reachable);
-- 
gitgitgadget

