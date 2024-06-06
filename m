Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9061990D8
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694811; cv=none; b=NYHaAreggPhxkOvYifuXoj8vIpO41/P/4LfrMOkHI3OwzyV8qPjSbpp3cJBlpu2bwp3cdvx3IJxY8Xx8kRc0T+IrRKFTGlJBESXxkLCKfhkl7alwkiXjg0xM1Yy7ym7jP7O94/lCxaXBSlqdyx5xWqSJ1Bn9g1I5yYHnn5lobk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694811; c=relaxed/simple;
	bh=gWICj18GJZHP90oGkAlBGS30WjQG9XO4drdS5SM2T/Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uIoJ7rJVul6dzCR0svqbumK4NFfEtOXvoh0fS6bZnpSJW5RVrZqLOS1piYBUJ3vFeKll+Al8+0Jwvhrq9W9JRQFKyV3LQmmOD5BT07jerIRCUiaUnwwfmZchC8aMlfDNH9vCSxkOEfMa6Ol62C/S1gY4HfDQsFUf9UY/xUuWbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7+L2XlL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7+L2XlL"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35ef1e928c9so1424155f8f.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694806; x=1718299606; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQfu2+R/G8ECR9N1y6tnYv5Q8C+HeK9ufoX1/EDxIXA=;
        b=M7+L2XlLdQTaMnpzda8C+9/K/vsRrI74CbuSAoZrwoX+45J+ra5ykoEPjxMd9HBgw5
         yZkPyFIJ93hwYe8zj+GyeImn76cCSywBbf4LPljSv/yhYl4F1rXT6+QjQDC7L3f14IhB
         w0bel5hnjMg2FlFqjcce4skSg5ix+QE5pT1T3yaOvmnokh8fCGGYJLXnCHOATwPzMenN
         bZDkGnLeLl3GECX5OzzvaIKTB/395WSmnra5v64xhAX638vYWg6arr7k5OMjOLYvgHmY
         s0N05xjF+wXTpugXsWOUwGxCX+b1xDFh67pX/Mwv3Yv8JUaRSIkzAXmmNs1uzD8Td70f
         bmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694806; x=1718299606;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQfu2+R/G8ECR9N1y6tnYv5Q8C+HeK9ufoX1/EDxIXA=;
        b=uOGoTxotdxeAF+YTJQLQw23FGzwnndZBvu5I7IBsFPluc6q0bwyfwGd6lrbn4o03Kb
         2CprxGHsLtKyH1Oj2Tlga+RXMnu5d+pGekm4KxDsKfpY1i6pjKb8uyPMd6ciiuSJr2yq
         Wd3IpAaU3k+rBA7L1xYJHo4oz8gG2p8YoJK/tEeKhI9+ZJ4IP/dWmIm8CEzKJ8cQOIfi
         Lo4oQn7YIl9XIsRuOjNatGl/pUJsiW6tevMK6dN6xCNeesfkoc+7CjCCaYFtUa4pre0P
         S0SwlTbK+JGIYdnLsiogY28bNwKDmKK3UDAGUKrtKQBVQWCrR4Kr2S4j8xGPPet52n7i
         r/pw==
X-Gm-Message-State: AOJu0YwWRN6BZzun4Vh+QOPa/g4xHa/6TgaCZVwIdiHDnYD/TFFkU6oc
	1s5asf2kbwue/qVeEpmUeerLxQkttEP7cAvU1B1kfA8eHqb+0mTDAxgNIA==
X-Google-Smtp-Source: AGHT+IE8jPWBjDoa+Yv42A/PqE5MStESq4muGcbfQ9MJ4zz5lz15D/XFhWVtllgE4BDjZE1A9CRcBQ==
X-Received: by 2002:a5d:4b83:0:b0:354:d098:8d67 with SMTP id ffacd0b85a97d-35efee0ed89mr261210f8f.57.1717694806188;
        Thu, 06 Jun 2024 10:26:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc6c56sm2077907f8f.109.2024.06.06.10.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:26:45 -0700 (PDT)
Message-Id: <33914f84a649fed5bc985d60e1947d1e414e65aa.1717694802.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Jun 2024 17:26:39 +0000
Subject: [PATCH 3/4] refs: add referent to each_ref_fn
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Phillip Wood [ ]" <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    "Jeff King [ ]" <peff@peff.net>,
    "Patrick Steinhardt [ ]" <ps@pks.im>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= Avila [ ]" <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Add a parameter to each_ref_fn so that callers to the ref APIs
that use this function as a callback can have acess to the
unresolved value of a symbolic ref.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 bisect.c                    |  3 ++-
 builtin/bisect.c            |  4 +++-
 builtin/checkout.c          |  2 +-
 builtin/describe.c          |  2 +-
 builtin/fetch.c             |  3 ++-
 builtin/fsck.c              |  4 ++--
 builtin/gc.c                |  1 +
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      |  5 +++--
 builtin/receive-pack.c      |  2 +-
 builtin/remote.c            |  4 +++-
 builtin/repack.c            |  1 +
 builtin/replace.c           |  1 +
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       |  8 ++++----
 builtin/show-ref.c          |  3 ++-
 builtin/submodule--helper.c |  1 +
 builtin/worktree.c          |  1 +
 commit-graph.c              |  1 +
 delta-islands.c             |  2 +-
 fetch-pack.c                |  2 ++
 help.c                      |  2 +-
 http-backend.c              |  4 ++--
 log-tree.c                  |  2 +-
 ls-refs.c                   |  4 ++--
 midx-write.c                |  2 +-
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  2 +-
 object-name.c               |  2 +-
 reachable.c                 |  2 +-
 ref-filter.c                |  4 ++--
 reflog.c                    |  1 +
 refs.c                      | 12 ++++++------
 refs.h                      |  2 +-
 refs/files-backend.c        |  2 +-
 refs/iterator.c             |  2 +-
 remote.c                    |  4 ++--
 replace-object.c            |  1 +
 revision.c                  |  2 +-
 server-info.c               |  2 +-
 shallow.c                   |  2 ++
 submodule.c                 |  2 ++
 t/helper/test-ref-store.c   |  2 +-
 upload-pack.c               |  8 ++++----
 walker.c                    |  1 +
 worktree.c                  |  2 +-
 47 files changed, 76 insertions(+), 53 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4ea703bec11..e22b3acf082 100644
--- a/bisect.c
+++ b/bisect.c
@@ -446,7 +446,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	clear_commit_weight(&commit_weight);
 }
 
-static int register_ref(const char *refname, const struct object_id *oid,
+static int register_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			int flags UNUSED, void *cb_data UNUSED)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
@@ -1168,6 +1168,7 @@ int estimate_bisect_steps(int all)
 }
 
 static int mark_for_removal(const char *refname,
+			    const char *referent UNUSED,
 			    const struct object_id *oid UNUSED,
 			    int flag UNUSED, void *cb_data)
 {
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 76ce5f0e0df..142e56d6020 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -355,6 +355,7 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 }
 
 static int inc_nr(const char *refname UNUSED,
+		  const char *referent UNUSED,
 		  const struct object_id *oid UNUSED,
 		  int flag UNUSED, void *cb_data)
 {
@@ -544,7 +545,7 @@ static int bisect_append_log_quoted(const char **argv)
 	return res;
 }
 
-static int add_bisect_ref(const char *refname, const struct object_id *oid,
+static int add_bisect_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			  int flags UNUSED, void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
@@ -1161,6 +1162,7 @@ static int bisect_visualize(struct bisect_terms *terms, int argc,
 }
 
 static int get_first_good(const char *refname UNUSED,
+			  const char *referent UNUSED,
 			  const struct object_id *oid,
 			  int flag UNUSED, void *cb_data)
 {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f90a4ca4b7a..ccd27c277d9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1045,7 +1045,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		report_tracking(new_branch_info);
 }
 
-static int add_pending_uninteresting_ref(const char *refname,
+static int add_pending_uninteresting_ref(const char *refname, const char *referent UNUSED,
 					 const struct object_id *oid,
 					 int flags UNUSED, void *cb_data)
 {
diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2d..d95a9109eed 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -145,7 +145,7 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const struct object_id *oid,
+static int get_name(const char *path, const char *referent UNUSED, const struct object_id *oid,
 		    int flag UNUSED, void *cb_data UNUSED)
 {
 	int is_tag = 0;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a319954f9fd..b3e275ca5c8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -286,7 +286,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	return ent;
 }
 
-static int add_one_refname(const char *refname,
+static int add_one_refname(const char *refname, const char *referent UNUSED,
 			   const struct object_id *oid,
 			   int flag UNUSED, void *cbdata)
 {
@@ -1459,6 +1459,7 @@ static void set_option(struct transport *transport, const char *name, const char
 
 
 static int add_oid(const char *refname UNUSED,
+		   const char *referent UNUSED,
 		   const struct object_id *oid,
 		   int flags UNUSED, void *cb_data)
 {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2c0ac6653ca..650dd0d839d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -521,7 +521,7 @@ static int fsck_handle_reflog(const char *logname, void *cb_data)
 	return 0;
 }
 
-static int fsck_handle_ref(const char *refname, const struct object_id *oid,
+static int fsck_handle_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			   int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object *obj;
@@ -576,7 +576,7 @@ static void get_default_heads(void)
 		strbuf_worktree_ref(wt, &ref, "HEAD");
 		fsck_head_link(ref.buf, &head_points_at, &head_oid);
 		if (head_points_at && !is_null_oid(&head_oid))
-			fsck_handle_ref(ref.buf, &head_oid, 0, NULL);
+			fsck_handle_ref(ref.buf, NULL, &head_oid, 0, NULL);
 		strbuf_release(&ref);
 
 		if (include_reflogs)
diff --git a/builtin/gc.c b/builtin/gc.c
index 72bac2554fc..65be7c31b33 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -836,6 +836,7 @@ struct cg_auto_data {
 };
 
 static int dfs_on_ref(const char *refname UNUSED,
+		      const char *referent UNUSED,
 		      const struct object_id *oid,
 		      int flags UNUSED,
 		      void *cb_data)
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 70e9ec4e477..52016f1cf7d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -337,7 +337,7 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 	return a->taggerdate != b->taggerdate;
 }
 
-static int name_ref(const char *path, const struct object_id *oid,
+static int name_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 		    int flags UNUSED, void *cb_data)
 {
 	struct object *o = parse_object(the_repository, oid);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 638f5c57f0d..a593fbfb3a3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -771,7 +771,7 @@ static enum write_one_status write_one(struct hashfile *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path UNUSED, const struct object_id *oid,
+static int mark_tagged(const char *path UNUSED, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id peeled;
@@ -3127,7 +3127,7 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *tag UNUSED, const struct object_id *oid,
+static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id peeled;
@@ -4074,6 +4074,7 @@ static void record_recent_commit(struct commit *commit, void *data UNUSED)
 }
 
 static int mark_bitmap_preferred_tip(const char *refname,
+				     const char *referent UNUSED,
 				     const struct object_id *oid,
 				     int flags UNUSED,
 				     void *data UNUSED)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d9e2c4bbe39..d3307730f39 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -300,7 +300,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 	}
 }
 
-static int show_ref_cb(const char *path_full, const struct object_id *oid,
+static int show_ref_cb(const char *path_full, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED, void *data)
 {
 	struct oidset *seen = data;
diff --git a/builtin/remote.c b/builtin/remote.c
index 039d1d6c55a..fdc5954c6e0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -543,6 +543,7 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
+				  const char *referent UNUSED,
 				  const struct object_id *oid UNUSED,
 				  int flags UNUSED, void *cb_data)
 {
@@ -585,7 +586,7 @@ struct rename_info {
 	uint32_t symrefs_nr;
 };
 
-static int read_remote_branches(const char *refname,
+static int read_remote_branches(const char *refname, const char *referent UNUSED,
 				const struct object_id *oid UNUSED,
 				int flags UNUSED, void *cb_data)
 {
@@ -971,6 +972,7 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
+				      const char *referent UNUSED,
 				      const struct object_id *oid UNUSED,
 				      int flags, void *cb_data)
 {
diff --git a/builtin/repack.c b/builtin/repack.c
index 58ad82dd97b..2c1218debcd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -667,6 +667,7 @@ struct midx_snapshot_ref_data {
 };
 
 static int midx_snapshot_ref_one(const char *refname UNUSED,
+				 const char *referent UNUSED,
 				 const struct object_id *oid,
 				 int flag UNUSED, void *_data)
 {
diff --git a/builtin/replace.c b/builtin/replace.c
index ce9f6974d26..ab004979fbb 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -49,6 +49,7 @@ struct show_data {
 };
 
 static int show_reference(const char *refname,
+			  const char *referent UNUSED,
 			  const struct object_id *oid,
 			  int flag UNUSED, void *cb_data)
 {
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 1e2919fd81c..cc1a88cd933 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -211,7 +211,7 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const struct object_id *oid,
+static int show_reference(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED, void *cb_data UNUSED)
 {
 	if (ref_excluded(&ref_excludes, refname))
@@ -220,7 +220,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int anti_reference(const char *refname, const struct object_id *oid,
+static int anti_reference(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED, void *cb_data UNUSED)
 {
 	show_rev(REVERSED, oid, refname);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d72f4cb98de..3427c1572e5 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -410,7 +410,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const struct object_id *oid,
+static int append_head_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			   int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id tmp;
@@ -425,7 +425,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 	return append_ref(refname + ofs, oid, 0);
 }
 
-static int append_remote_ref(const char *refname, const struct object_id *oid,
+static int append_remote_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			     int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id tmp;
@@ -451,7 +451,7 @@ static int append_tag_ref(const char *refname, const struct object_id *oid,
 static const char *match_ref_pattern = NULL;
 static int match_ref_slash = 0;
 
-static int append_matching_ref(const char *refname, const struct object_id *oid,
+static int append_matching_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			       int flag, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
@@ -468,7 +468,7 @@ static int append_matching_ref(const char *refname, const struct object_id *oid,
 	if (wildmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
-		return append_head_ref(refname, oid, flag, cb_data);
+		return append_head_ref(refname, NULL, oid, flag, cb_data);
 	if (starts_with(refname, "refs/tags/"))
 		return append_tag_ref(refname, oid, flag, cb_data);
 	return append_ref(refname, oid, 0);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 3114bdc391a..3b9be14b61c 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -63,7 +63,7 @@ struct show_ref_data {
 	int show_head;
 };
 
-static int show_ref(const char *refname, const struct object_id *oid,
+static int show_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flag UNUSED, void *cbdata)
 {
 	struct show_ref_data *data = cbdata;
@@ -97,6 +97,7 @@ static int show_ref(const char *refname, const struct object_id *oid,
 }
 
 static int add_existing(const char *refname,
+			const char *referent UNUSED,
 			const struct object_id *oid UNUSED,
 			int flag UNUSED, void *cbdata)
 {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e3e1f08a58c..d7c29383ccb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -611,6 +611,7 @@ static void print_status(unsigned int flags, char state, const char *path,
 }
 
 static int handle_submodule_head_ref(const char *refname UNUSED,
+				     const char *referent UNUSED,
 				     const struct object_id *oid,
 				     int flags UNUSED,
 				     void *cb_data)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 893e973871e..14f9a525d6a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -626,6 +626,7 @@ static void print_preparing_worktree_line(int detach,
  * Returns 0 on failure and non-zero on success.
  */
 static int first_valid_ref(const char *refname UNUSED,
+			   const char *referent UNUSED,
 			   const struct object_id *oid UNUSED,
 			   int flags UNUSED,
 			   void *cb_data UNUSED)
diff --git a/commit-graph.c b/commit-graph.c
index e5dd3553dfe..b6906633b1b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1815,6 +1815,7 @@ struct refs_cb_data {
 };
 
 static int add_ref_to_set(const char *refname UNUSED,
+			  const char *referent UNUSED,
 			  const struct object_id *oid,
 			  int flags UNUSED, void *cb_data)
 {
diff --git a/delta-islands.c b/delta-islands.c
index 4ac3c10551a..8bafa4b807c 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -388,7 +388,7 @@ static void add_ref_to_island(kh_str_t *remote_islands, const char *island_name,
 	rl->hash += sha_core;
 }
 
-static int find_island_for_ref(const char *refname, const struct object_id *oid,
+static int find_island_for_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			       int flags UNUSED, void *cb)
 {
 	struct island_load_data *ild = cb;
diff --git a/fetch-pack.c b/fetch-pack.c
index 7d2aef21add..ae9615fad65 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -181,6 +181,7 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 }
 
 static int rev_list_insert_ref_oid(const char *refname UNUSED,
+				   const char *referent UNUSED,
 				   const struct object_id *oid,
 				   int flag UNUSED,
 				   void *cb_data)
@@ -608,6 +609,7 @@ static int mark_complete(const struct object_id *oid)
 }
 
 static int mark_complete_oid(const char *refname UNUSED,
+			     const char *referent UNUSED,
 			     const struct object_id *oid,
 			     int flag UNUSED,
 			     void *cb_data UNUSED)
diff --git a/help.c b/help.c
index 1d057aa6073..385a98f81fa 100644
--- a/help.c
+++ b/help.c
@@ -789,7 +789,7 @@ struct similar_ref_cb {
 	struct string_list *similar_refs;
 };
 
-static int append_similar_ref(const char *refname,
+static int append_similar_ref(const char *refname, const char *referent UNUSED,
 			      const struct object_id *oid UNUSED,
 			      int flags UNUSED, void *cb_data)
 {
diff --git a/http-backend.c b/http-backend.c
index 20c3ff8fa95..d9ed6405ed4 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -510,7 +510,7 @@ static void run_service(const char **argv, int buffer_input)
 		exit(1);
 }
 
-static int show_text_ref(const char *name, const struct object_id *oid,
+static int show_text_ref(const char *name, const char *referent UNUSED, const struct object_id *oid,
 			 int flag UNUSED, void *cb_data)
 {
 	const char *name_nons = strip_namespace(name);
@@ -566,7 +566,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 	strbuf_release(&buf);
 }
 
-static int show_head_ref(const char *refname, const struct object_id *oid,
+static int show_head_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			 int flag, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
diff --git a/log-tree.c b/log-tree.c
index da06c6e982f..06176e34a2c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -143,7 +143,7 @@ static int ref_filter_match(const char *refname,
 	return 1;
 }
 
-static int add_ref_decoration(const char *refname, const struct object_id *oid,
+static int add_ref_decoration(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			      int flags UNUSED,
 			      void *cb_data)
 {
diff --git a/ls-refs.c b/ls-refs.c
index 3d047bbc64f..f0d9f8864d7 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -75,7 +75,7 @@ struct ls_refs_data {
 	unsigned unborn : 1;
 };
 
-static int send_ref(const char *refname, const struct object_id *oid,
+static int send_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flag, void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
@@ -134,7 +134,7 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 	oid_is_null = is_null_oid(&oid);
 	if (!oid_is_null ||
 	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
-		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
+		send_ref(namespaced.buf, NULL, oid_is_null ? NULL : &oid, flag, data);
 	strbuf_release(&namespaced);
 }
 
diff --git a/midx-write.c b/midx-write.c
index 4998707eb8b..bac416d5e87 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -651,7 +651,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	trace2_region_leave("midx", "prepare_midx_packing_data", the_repository);
 }
 
-static int add_ref_to_pending(const char *refname,
+static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
 			      const struct object_id *oid,
 			      int flag, void *cb_data)
 {
diff --git a/negotiator/default.c b/negotiator/default.c
index 518b3c43b28..052c37f4ae2 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -36,7 +36,7 @@ static void rev_list_push(struct negotiation_state *ns,
 	}
 }
 
-static int clear_marks(const char *refname, const struct object_id *oid,
+static int clear_marks(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED,
 		       void *cb_data UNUSED)
 {
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index b7e008c2fda..0ad76b033ab 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -73,7 +73,7 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 	return entry;
 }
 
-static int clear_marks(const char *refname, const struct object_id *oid,
+static int clear_marks(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED,
 		       void *cb_data UNUSED)
 {
diff --git a/notes.c b/notes.c
index 53ca25c8147..77ac78ac08e 100644
--- a/notes.c
+++ b/notes.c
@@ -928,7 +928,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname,
+static int string_list_add_one_ref(const char *refname, const char *referent UNUSED,
 				   const struct object_id *oid UNUSED,
 				   int flag UNUSED, void *cb)
 {
diff --git a/object-name.c b/object-name.c
index 523af6f64f3..68b4105d614 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1363,7 +1363,7 @@ struct handle_one_ref_cb {
 	struct commit_list **list;
 };
 
-static int handle_one_ref(const char *path, const struct object_id *oid,
+static int handle_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED,
 			  void *cb_data)
 {
diff --git a/reachable.c b/reachable.c
index 1224b300086..1f09353bae3 100644
--- a/reachable.c
+++ b/reachable.c
@@ -77,7 +77,7 @@ static void add_rebase_files(struct rev_info *revs)
 	free_worktrees(worktrees);
 }
 
-static int add_one_ref(const char *path, const struct object_id *oid,
+static int add_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info *)cb_data;
diff --git a/ref-filter.c b/ref-filter.c
index f7fb0c7e0ec..0b4b6bb8d71 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2863,7 +2863,7 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int filter_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int filter_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
@@ -2898,7 +2898,7 @@ struct ref_filter_and_format_cbdata {
 	} internal;
 };
 
-static int filter_and_format_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int filter_and_format_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_and_format_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
diff --git a/reflog.c b/reflog.c
index 3c80950186b..744e5f2d982 100644
--- a/reflog.c
+++ b/reflog.c
@@ -298,6 +298,7 @@ int should_expire_reflog_ent_verbose(struct object_id *ooid,
 }
 
 static int push_tip_to_list(const char *refname UNUSED,
+			    const char *referent UNUSED,
 			    const struct object_id *oid,
 			    int flags, void *cb_data)
 {
diff --git a/refs.c b/refs.c
index 2c592a9ae29..f75d6537bc7 100644
--- a/refs.c
+++ b/refs.c
@@ -411,7 +411,7 @@ int refs_ref_exists(struct ref_store *refs, const char *refname)
 					 NULL, NULL);
 }
 
-static int for_each_filter_refs(const char *refname,
+static int for_each_filter_refs(const char *refname, const char *referent,
 				const struct object_id *oid,
 				int flags, void *data)
 {
@@ -421,7 +421,7 @@ static int for_each_filter_refs(const char *refname,
 		return 0;
 	if (filter->prefix)
 		skip_prefix(refname, filter->prefix, &refname);
-	return filter->fn(refname, oid, flags, filter->cb_data);
+	return filter->fn(refname, referent, oid, flags, filter->cb_data);
 }
 
 struct warn_if_dangling_data {
@@ -432,7 +432,7 @@ struct warn_if_dangling_data {
 	const char *msg_fmt;
 };
 
-static int warn_if_dangling_symref(const char *refname,
+static int warn_if_dangling_symref(const char *refname, const char *referent UNUSED,
 				   const struct object_id *oid UNUSED,
 				   int flags, void *cb_data)
 {
@@ -503,7 +503,7 @@ int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void *cb_da
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
 	if (!refs_read_ref_full(refs, buf.buf, RESOLVE_REF_READING, &oid, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
+		ret = fn(buf.buf, NULL, &oid, flag, cb_data);
 	strbuf_release(&buf);
 
 	return ret;
@@ -1524,7 +1524,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 	if (refs_resolve_ref_unsafe(refs, "HEAD", NULL, RESOLVE_REF_READING,
 				    &oid, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
+		return fn("HEAD", NULL, &oid, flag, cb_data);
 
 	return 0;
 }
@@ -2360,7 +2360,7 @@ struct do_for_each_reflog_help {
 	void *cb_data;
 };
 
-static int do_for_each_reflog_helper(const char *refname,
+static int do_for_each_reflog_helper(const char *refname, const char *referent,
 				     const struct object_id *oid UNUSED,
 				     int flags,
 				     void *cb_data)
diff --git a/refs.h b/refs.h
index ea4a3217658..979494ce1f8 100644
--- a/refs.h
+++ b/refs.h
@@ -294,7 +294,7 @@ struct ref_transaction;
  * arguments is only guaranteed to be valid for the duration of a
  * single callback invocation.
  */
-typedef int each_ref_fn(const char *refname,
+typedef int each_ref_fn(const char *refname, const char *referent,
 			const struct object_id *oid, int flags, void *cb_data);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a963d796a29..f4c892422bc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3002,7 +3002,7 @@ static int files_transaction_abort(struct ref_store *ref_store,
 	return 0;
 }
 
-static int ref_present(const char *refname,
+static int ref_present(const char *refname, const char *referent UNUSED,
 		       const struct object_id *oid UNUSED,
 		       int flags UNUSED,
 		       void *cb_data)
diff --git a/refs/iterator.c b/refs/iterator.c
index 26acb6bd640..21beeb91e9e 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -451,7 +451,7 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		retval = fn(iter->refname, iter->oid, iter->flags, cb_data);
+		retval = fn(iter->refname, iter->referent, iter->oid, iter->flags, cb_data);
 		if (retval) {
 			/*
 			 * If ref_iterator_abort() returns ITER_ERROR,
diff --git a/remote.c b/remote.c
index c9718ee0ca1..071c542ab31 100644
--- a/remote.c
+++ b/remote.c
@@ -2342,7 +2342,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	return 1;
 }
 
-static int one_local_ref(const char *refname, const struct object_id *oid,
+static int one_local_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			 int flag UNUSED,
 			 void *cb_data)
 {
@@ -2427,7 +2427,7 @@ struct stale_heads_info {
 	struct refspec *rs;
 };
 
-static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
+static int get_stale_heads_cb(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
diff --git a/replace-object.c b/replace-object.c
index 73f5acbcd9f..8ef561f1455 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -9,6 +9,7 @@
 #include "commit.h"
 
 static int register_replace_ref(const char *refname,
+				const char *referent UNUSED,
 				const struct object_id *oid,
 				int flag UNUSED,
 				void *cb_data)
diff --git a/revision.c b/revision.c
index 6aca4f42303..e37346fb52a 100644
--- a/revision.c
+++ b/revision.c
@@ -1627,7 +1627,7 @@ struct all_refs_cb {
 	struct worktree *wt;
 };
 
-static int handle_one_ref(const char *path, const struct object_id *oid,
+static int handle_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED,
 			  void *cb_data)
 {
diff --git a/server-info.c b/server-info.c
index 6feaa457c5c..3a0d6ad39ab 100644
--- a/server-info.c
+++ b/server-info.c
@@ -151,7 +151,7 @@ static int update_info_file(char *path,
 	return ret;
 }
 
-static int add_info_ref(const char *path, const struct object_id *oid,
+static int add_info_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 			int flag UNUSED,
 			void *cb_data)
 {
diff --git a/shallow.c b/shallow.c
index a0b181ba8a1..a4d2c3e221b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -610,6 +610,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 }
 
 static int mark_uninteresting(const char *refname UNUSED,
+			      const char *referent UNUSED,
 			      const struct object_id *oid,
 			      int flags UNUSED,
 			      void *cb_data UNUSED)
@@ -725,6 +726,7 @@ struct commit_array {
 };
 
 static int add_ref(const char *refname UNUSED,
+		  const char *referent UNUSED,
 		   const struct object_id *oid,
 		   int flags UNUSED,
 		   void *cb_data)
diff --git a/submodule.c b/submodule.c
index 759cf1e1cda..bdba5a1ba11 100644
--- a/submodule.c
+++ b/submodule.c
@@ -951,6 +951,7 @@ static void free_submodules_data(struct string_list *submodules)
 }
 
 static int has_remote(const char *refname UNUSED,
+		      const char *referent UNUSED,
 		      const struct object_id *oid UNUSED,
 		      int flags UNUSED, void *cb_data UNUSED)
 {
@@ -1271,6 +1272,7 @@ int push_unpushed_submodules(struct repository *r,
 }
 
 static int append_oid_to_array(const char *ref UNUSED,
+			       const char *referent UNUSED,
 			       const struct object_id *oid,
 			       int flags UNUSED, void *data)
 {
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index ef1d6acbfae..78cb873e6a0 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -153,7 +153,7 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 	return refs_rename_ref(refs, oldref, newref, logmsg);
 }
 
-static int each_ref(const char *refname, const struct object_id *oid,
+static int each_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flags, void *cb_data UNUSED)
 {
 	printf("%s %s 0x%x\n", oid_to_hex(oid), refname, flags);
diff --git a/upload-pack.c b/upload-pack.c
index 4fddc081237..e79e77570b7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -855,7 +855,7 @@ static void send_unshallow(struct upload_pack_data *data)
 	}
 }
 
-static int check_ref(const char *refname_full, const struct object_id *oid,
+static int check_ref(const char *refname_full, const char *referent UNUSED, const struct object_id *oid,
 		     int flag, void *cb_data);
 static void deepen(struct upload_pack_data *data, int depth)
 {
@@ -1206,7 +1206,7 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 	return 0;
 }
 
-static int check_ref(const char *refname_full, const struct object_id *oid,
+static int check_ref(const char *refname_full, const char *referent UNUSED,const struct object_id *oid,
 		     int flag UNUSED, void *cb_data)
 {
 	const char *refname = strip_namespace(refname_full);
@@ -1274,14 +1274,14 @@ static void write_v0_ref(struct upload_pack_data *data,
 	return;
 }
 
-static int send_ref(const char *refname, const struct object_id *oid,
+static int send_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flag UNUSED, void *cb_data)
 {
 	write_v0_ref(cb_data, refname, strip_namespace(refname), oid);
 	return 0;
 }
 
-static int find_symref(const char *refname,
+static int find_symref(const char *refname, const char *referent UNUSED,
 		       const struct object_id *oid UNUSED,
 		       int flag, void *cb_data)
 {
diff --git a/walker.c b/walker.c
index 946d86b04ee..918693221a9 100644
--- a/walker.c
+++ b/walker.c
@@ -219,6 +219,7 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 }
 
 static int mark_complete(const char *path UNUSED,
+			const char *referent UNUSED,
 			 const struct object_id *oid,
 			 int flag UNUSED,
 			 void *cb_data UNUSED)
diff --git a/worktree.c b/worktree.c
index ed89bab481d..9ab7e305d39 100644
--- a/worktree.c
+++ b/worktree.c
@@ -553,7 +553,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 					    NULL,
 					    RESOLVE_REF_READING,
 					    &oid, &flag))
-			ret = fn(refname.buf, &oid, flag, cb_data);
+			ret = fn(refname.buf, NULL, &oid, flag, cb_data);
 		if (ret)
 			break;
 	}
-- 
gitgitgadget

