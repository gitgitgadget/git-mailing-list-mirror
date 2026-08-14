Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583A332601
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715290; cv=none; b=M1CGgB/ygPnq0+RSkH5cklgmzVgCCp3+duK423rpujFbQO0sm6srZmHzMy1ms5/5OfmNqqRgkxYzXdoH6oKktTHHIBME1uiuh1o9cD1ZgWNohJ/z50iXioSBYfMNmfzlQcait/RMqpv0avdCvtZxnJi3E7iiFX3LKzv/7ZB7XJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715290; c=relaxed/simple;
	bh=bw0AQ7pdwYq+ATMSdfsuy/64e4xMYweIDApBJapwcKA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E6GfX+BHip64ztW/XUpFLhe9Gy7Ak0wAdjc4LGHNQ+j0hoHPr/ijo/N0O8JmjVl9BKNp7DSUPqfpTmXzK/U73u84QIkZnGqARwlLqQryJfSAr/rkzIBop7ztPCyvRKgNdVUOBYxg8qbF4TlXLM4g3SxHf3Jv7vsRRXyEMGFIGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev; spf=pass smtp.mailfrom=chainguard.dev; dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b=Ca1EVMwi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b="Ca1EVMwi"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe89fb333so607276f8f.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chainguard.dev; s=google; t=1786715285; x=1787320085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zdvHNyYGUGV4uJtgBzoV4nzRCHfDWn44/Zd6sls/m+k=;
        b=Ca1EVMwikWx7SlrT9MkckqLQ8p/0ScgzfM6/b//COBCroHZrCi67C164MHYTlSi+Ht
         XGSiAOyhLpr1Qx88+u8bfnIT9q0Aui6mWhEryXZGp8R7dzyuuUpqsb/yenh3pmk4qz0P
         PUAtGSHGhf2KvQebyFLX0a188b4t0SZt4v9PARTSzwmtvcXtiduqsLkj1QsnoAZ6Io5l
         eRE4He1ccotLgMspWtpKrju6Jhu/KBi4Ze+kMI0tcxotaRp/waFFGn3NRpRpNPp/k/5E
         6rlE46a5sy2k3LLfCgTmedkHe5lw7rrd34XxUAkK6biEdZN7NABYw4WgxAZh9q4+xs+A
         YhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786715285; x=1787320085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zdvHNyYGUGV4uJtgBzoV4nzRCHfDWn44/Zd6sls/m+k=;
        b=eiO65dqk2l1AWx6mHkh2BaSJbwX+SpPCkbFCR1EKVw4Zncd3PMLOl7zvf6FCMS+oKS
         GdiAYMIjWV80MFopt/bBDVWJCBrXypl7Lu100mJDrupXACjd46fD4kr3HQ/vROu2bMa1
         WVnC7MWTnAgOY+O7D7knFLN2jdB09lR8pCDD4HTg0rdcnhxV5oGqEhcJzRCucBoqs6Xf
         hjFBJAN4U2S2hP84A7xKNRkpQNAjJ/7kpNxo4gp1H+DMQxGBTZY0niui4k8c27ur10sa
         ds4obEfFSF832DfnK2phEH2Owtj+QqdK9tjy8t6UEWzhuVI6Z6XyPncAmWdXQfxq9fA9
         5VrA==
X-Gm-Message-State: AOJu0YxnAYmD/ZUt+hP/dum6hD7tNs/IRQICyBx1kiwzbsGmkP71W3q4
	2qY5o5eTWMPgZJz/GshPW1oIUNTmYAh1JQG5Hc7SwkwRabATK5gUdCzgclCNJYAA+F8NwZ3jYCP
	yKueMPLI=
X-Gm-Gg: AR+sD10q0bJRSWyhYMpyRYaYtVI4zG2Ysfi1NDf5FOfhEzQqkGGh32P42VV1YMUp+az
	d19o0JYacOCuUiW6DwALAIAlcif0EMN4VVAyMSY3L1/1kcLGwl3lSIyUhV8BbKwYgk7CsDMpIvV
	whIdKs9TEMCUrusztLuf8OOpJQYmwvDcVcHZPqtcxFNWjbOeQRv01/HZFyQD1W9MbNGijCztylQ
	wEjIJdTRYiGF5rWWJ9oJSnCLV7kOZQYAQ8LVp/PW0QJ3lnIoAt8GOSSV+64tdnc5SdVhvBkp4O4
	z4391f1rOhtt9mBw5DX2XPTvGMnakOIQquIygaTr70uxwJZmASxv16OjGY7FFE3gg0Zd0pEUJc5
	vvADm9cR2Lg3ErOHxSl0OwHvDCYXEt2NEgIzm1ZoVkSic3frQSur2JcSGMzMgGllGpNg8jLvEmw
	fhXyoMebSk0E3DQXBnqrXZ/yH/rQgnfmjyJRDw/NXV3FAz36gG+0ZS1OF+G3viL9S42A0XF3iBL
	vg=
X-Received: by 2002:a05:6000:2086:b0:47f:e797:41c8 with SMTP id ffacd0b85a97d-481607301c9mr9036425f8f.4.1786715285209;
        Fri, 14 Aug 2026 06:48:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:b911:bf00:6218:95ff:fe01:453b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f21a24esm9883563f8f.11.2026.08.14.06.48.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:48:04 -0700 (PDT)
From: Dimitri John Ledkov <dimitri.ledkov@chainguard.dev>
To: git@vger.kernel.org
Subject: [PATCH] rev-parse: compute object names in another hash algorithm
Date: Fri, 14 Aug 2026 13:48:04 +0000
Message-ID: <20260814134804.680154-1-dimitri.ledkov@chainguard.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git rev-parse --output-object-format=sha256 HEAD^{tree}" could not
answer in a SHA-1 repository.  And vice-versa.  Without
extensions.compatObjectFormat the option was rejected outright, and with
it the answer was wrong: the extension records a mapping only for objects
written while it is enabled, so for the objects a repository already
contained the lookup missed, repo_oid_to_algop() left the object ID
untouched, and rev-parse printed the SHA-1 name with a zero exit code.

The machinery to convert object contents between algorithms is already
here.  convert_tree_object() and friends rewrite the object IDs a tree,
commit or tag refers to, calling repo_oid_to_algop() for each one, so the
recursion is written; what is missing is a base case.  Give
repo_oid_to_algop() one: on a lookup miss, read the object, convert its
contents, and hash the result.  A blob needs no conversion at all, as its
contents are the same either way, only a rehash.

Names computed this way are remembered during the process execution,
so that a tree that reaches the same subtree by several paths pays for
it once.  These are not stored permamently.  In the future a side-car
cache could be added for these results, or eventual dual-format v3
could be used to lazy compute/convert and store these.

Commits are refused rather than computed.  A commit names its parents, so
converting one converts the entire history behind it; that is a repository
conversion, not an answer about a single object, and recursing over it
here would be bounded only by the length of the history.  A tree holding a
submodule is refused for the same reason, and now says which entry is at
fault instead of reporting an unreadable object.

Since names can now be computed, accept any algorithm git knows rather
than only the configured compatibility one, and check what
repo_oid_to_algop() returns so that a name we cannot produce is an error
instead of the storage name.

On git.git's tree at 9936c1b52a (3089 files, 26MB) this names the tree
in 0.26s, against 0.25s for reading and hashing that content by hand,
so close to the floor for the work involved. On linux.git tree of
1.6GiB it takes 8s to compute.

Initially, I have implemented contrib git-sha256-tree.sh script using
a temporary git repo and perform fast-export/fast-import of a single
commit and its tree.  It is a lot slower due to needless work of
fast-import that is discarded.  However, a contrib script carries less
maintainance and is more portable to existing installations.  If there
is interest, I can publish that implementation as well.  The goal is
to help with interop, and have the ability to record tree names in
either format today; to check again later if and when a given project
switches to sha256 format.

Assisted-by: Claude Opus 5 xHigh
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@chainguard.dev>
---
 Documentation/git-rev-parse.adoc |  13 +++
 builtin/rev-parse.c              |  23 ++++-
 object-file-convert.c            | 145 +++++++++++++++++++++++++++++--
 object-file-convert.h            |   6 ++
 repository.c                     |   3 +
 repository.h                     |   8 ++
 t/meson.build                    |   1 +
 t/t1018-output-object-format.sh  | 118 +++++++++++++++++++++++++
 8 files changed, 308 insertions(+), 9 deletions(-)
 create mode 100755 t/t1018-output-object-format.sh

diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5398691f3f..c18ae9ca81 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -181,6 +181,19 @@ Specifying "sha256" translates if necessary and returns a sha256 oid.
 +
 Specifying "storage" translates if necessary and returns an oid in
 encoded in the storage hash algorithm.
++
+A translation that `extensions.compatObjectFormat` did not record, which is
+every object a repository already contained when that extension was turned
+on, is computed on demand.  Since an object's name in another algorithm is
+defined over the names of the objects it refers to, this reads everything
+reachable from the object, and so costs time proportional to the total size
+of that content.
++
+Commits cannot be named this way.  A commit refers to its parents, so naming
+one would mean converting the whole history behind it, which is a repository
+conversion rather than a question about a single object.  For the same
+reason a tree containing a submodule cannot be named, as its gitlink refers
+to a commit in another repository.
 
 Options for Objects
 ~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..7dd06f324e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -876,8 +876,21 @@ int cmd_rev_parse(int argc,
 					flags |= GET_OID_HASH_ANY;
 					output_algo = compat;
 					continue;
+				} else {
+					/*
+					 * Names in another algorithm can be
+					 * computed on demand, so accept any
+					 * algorithm we know rather than only
+					 * the configured compatibility one.
+					 */
+					uint32_t algo = hash_algo_by_name(arg);
+
+					if (algo == GIT_HASH_UNKNOWN)
+						die(_("unsupported object format: %s"), arg);
+					flags |= GET_OID_HASH_ANY;
+					output_algo = &hash_algos[algo];
+					continue;
 				}
-				else die(_("unsupported object format: %s"), arg);
 			}
 			if (opt_with_value(arg, "--short", &arg)) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
@@ -1162,9 +1175,11 @@ int cmd_rev_parse(int argc,
 		}
 		if (!repo_get_oid_with_flags(the_repository, name, &oid,
 					     flags)) {
-			if (output_algo)
-				repo_oid_to_algop(the_repository, &oid,
-						  output_algo, &oid);
+			if (output_algo &&
+			    repo_oid_to_algop(the_repository, &oid,
+					      output_algo, &oid))
+				die(_("cannot express %s as a %s object name"),
+				    name, output_algo->name);
 			if (verify)
 				revs_count++;
 			else
diff --git a/object-file-convert.c b/object-file-convert.c
index 63ee18630b..1f0475b5a0 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -10,7 +10,120 @@
 #include "loose.h"
 #include "commit.h"
 #include "gpg-interface.h"
+#include "object-file.h"
 #include "object-file-convert.h"
+#include "odb.h"
+#include "oidmap.h"
+
+struct compat_oid_cache_entry {
+	struct oidmap_entry entry;
+	struct object_id compat_oid;
+};
+
+void repo_clear_compat_oid_cache(struct repository *repo)
+{
+	if (!repo->compat_oid_cache)
+		return;
+	oidmap_clear(repo->compat_oid_cache, 1);
+	FREE_AND_NULL(repo->compat_oid_cache);
+}
+
+static int lookup_computed_oid(struct repository *repo,
+			       const struct object_id *src,
+			       struct object_id *dest)
+{
+	struct compat_oid_cache_entry *found;
+
+	if (!repo->compat_oid_cache)
+		return -1;
+	found = oidmap_get(repo->compat_oid_cache, src);
+	if (!found)
+		return -1;
+	oidcpy(dest, &found->compat_oid);
+	return 0;
+}
+
+static void remember_computed_oid(struct repository *repo,
+				  const struct object_id *src,
+				  const struct object_id *dest)
+{
+	struct compat_oid_cache_entry *added;
+
+	if (!repo->compat_oid_cache) {
+		CALLOC_ARRAY(repo->compat_oid_cache, 1);
+		oidmap_init(repo->compat_oid_cache, 0);
+	}
+	CALLOC_ARRAY(added, 1);
+	oidcpy(&added->entry.oid, src);
+	oidcpy(&added->compat_oid, dest);
+	oidmap_put(repo->compat_oid_cache, added);
+}
+
+/*
+ * Compute the name an object has under another hash algorithm, by converting
+ * its contents and hashing the result.  Objects the contents refer to are
+ * resolved by recursing through repo_oid_to_algop(), so a tree costs a walk
+ * of everything reachable from it.
+ *
+ * Commits are deliberately not handled.  A commit names its parents, so
+ * converting one converts the whole history behind it; that is a repository
+ * conversion rather than something a caller asking for a single object name
+ * should trigger, and recursing over it here would also be unbounded.
+ */
+static int compute_oid_to_algop(struct repository *repo,
+				const struct object_id *src,
+				const struct git_hash_algo *from,
+				const struct git_hash_algo *to,
+				struct object_id *dest)
+{
+	struct strbuf converted = STRBUF_INIT;
+	enum object_type type;
+	size_t size;
+	void *buf;
+	int ret = -1;
+
+	/* We can only read objects that are stored the way the repo stores them. */
+	if (from != repo->hash_algo)
+		return -1;
+
+	buf = odb_read_object(repo->objects, src, &type, &size);
+	if (!buf)
+		return error(_("unable to read %s"), oid_to_hex(src));
+
+	switch (type) {
+	case OBJ_BLOB:
+		/*
+		 * A blob's contents are the same under either algorithm, so
+		 * there is nothing to convert, only to rehash.
+		 */
+		hash_object_file(to, buf, size, OBJ_BLOB, dest);
+		ret = 0;
+		break;
+	case OBJ_TREE:
+	case OBJ_TAG:
+		if (!convert_object_file(repo, &converted, from, to, buf, size,
+					 type, 1)) {
+			hash_object_file(to, converted.buf, converted.len, type,
+					 dest);
+			ret = 0;
+		}
+		break;
+	case OBJ_COMMIT:
+		error(_("cannot compute the %s name of commit %s"),
+		      to->name, oid_to_hex(src));
+		break;
+	default:
+		error(_("unknown type for object %s"), oid_to_hex(src));
+		break;
+	}
+
+	free(buf);
+	strbuf_release(&converted);
+
+	if (!ret)
+		remember_computed_oid(repo, src, dest);
+	return ret;
+}
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 		      const struct git_hash_algo *to, struct object_id *dest)
@@ -43,14 +156,25 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 		 * let's reload the map to see if the object has appeared.
 		 */
 		repo_read_loose_object_map(repo);
-		if (repo_loose_object_map_oid(repo, src, to, dest))
-			return -1;
+		if (repo_loose_object_map_oid(repo, src, to, dest)) {
+			/*
+			 * The map only covers objects written while
+			 * extensions.compatObjectFormat was in effect, so it
+			 * cannot answer for objects a repository already had.
+			 * Compute the name instead, remembering it so that
+			 * trees sharing a subtree only pay for it once.
+			 */
+			if (!lookup_computed_oid(repo, src, dest))
+				return 0;
+			return compute_oid_to_algop(repo, src, from, to, dest);
+		}
 	}
 	return 0;
 }
 
 static int decode_tree_entry_raw(struct object_id *oid, const char **path,
-				 size_t *len, const struct git_hash_algo *algo,
+				 size_t *len, uint16_t *modep,
+				 const struct git_hash_algo *algo,
 				 const char *buf, unsigned long size)
 {
 	uint16_t mode;
@@ -64,6 +188,7 @@ static int decode_tree_entry_raw(struct object_id *oid, const char **path,
 	if (!*path || !**path)
 		return -1;
 	*len = strlen(*path) + 1;
+	*modep = mode;
 
 	oidread(oid, (const unsigned char *)*path + *len, algo);
 	return 0;
@@ -81,10 +206,20 @@ static int convert_tree_object(struct repository *repo,
 		struct object_id entry_oid, mapped_oid;
 		const char *path = NULL;
 		size_t pathlen;
+		uint16_t mode;
 
-		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, from, p,
-					  end - p))
+		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, &mode,
+					  from, p, end - p))
 			return error(_("failed to decode tree entry"));
+		/*
+		 * A gitlink names a commit in the submodule's repository,
+		 * which we cannot read, so say so rather than complaining
+		 * about a missing object.
+		 */
+		if (S_ISGITLINK(mode))
+			return error(_("cannot map submodule entry '%s'; convert "
+				       "commit %s in the submodule repository first"),
+				     path, oid_to_hex(&entry_oid));
 		if (repo_oid_to_algop(repo, &entry_oid, to, &mapped_oid))
 			return error(_("failed to map tree entry for %s"), oid_to_hex(&entry_oid));
 		strbuf_add(out, p, path - p);
diff --git a/object-file-convert.h b/object-file-convert.h
index 9b3cc5e533..af384c362b 100644
--- a/object-file-convert.h
+++ b/object-file-convert.h
@@ -10,6 +10,12 @@ struct strbuf;
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 		      const struct git_hash_algo *to, struct object_id *dest);
 
+/*
+ * Release the object names repo_oid_to_algop() computed on demand.  Called
+ * from repo_clear().
+ */
+void repo_clear_compat_oid_cache(struct repository *repo);
+
 /*
  * Convert an object file from one hash algorithm to another algorithm.
  * Return -1 on failure, 0 on success.
diff --git a/repository.c b/repository.c
index 651b0f6933..16201ec5ea 100644
--- a/repository.c
+++ b/repository.c
@@ -7,6 +7,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "object.h"
+#include "object-file-convert.h"
 #include "lockfile.h"
 #include "path.h"
 #include "read-cache-ll.h"
@@ -386,6 +387,8 @@ void repo_clear(struct repository *repo)
 	odb_free(repo->objects);
 	repo->objects = NULL;
 
+	repo_clear_compat_oid_cache(repo);
+
 	parsed_object_pool_clear(repo->parsed_objects);
 	FREE_AND_NULL(repo->parsed_objects);
 
diff --git a/repository.h b/repository.h
index 3b467a2513..1a89559cd5 100644
--- a/repository.h
+++ b/repository.h
@@ -12,6 +12,7 @@ struct index_state;
 struct lock_file;
 struct pathspec;
 struct object_database;
+struct oidmap;
 struct submodule_cache;
 struct promisor_remote_config;
 struct remote_state;
@@ -167,6 +168,13 @@ struct repository {
 	/* Repository's compatibility hash algorithm. */
 	const struct git_hash_algo *compat_hash_algo;
 
+	/*
+	 * Object names computed in another hash algorithm on demand, keyed by
+	 * the name the object has in this repository.  Owned and populated by
+	 * repo_oid_to_algop().
+	 */
+	struct oidmap *compat_oid_cache;
+
 	/* Repository-specific configuration values. */
 	struct repo_config_values config_values_private_;
 
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..bc3e644709 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -172,6 +172,7 @@ integration_tests = [
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
   't1017-cat-file-remote-object-info.sh',
+  't1018-output-object-format.sh',
   't1020-subdirectory.sh',
   't1022-read-tree-partial-clone.sh',
   't1050-large.sh',
diff --git a/t/t1018-output-object-format.sh b/t/t1018-output-object-format.sh
new file mode 100755
index 0000000000..45ddc510dd
--- /dev/null
+++ b/t/t1018-output-object-format.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+
+test_description='rev-parse --output-object-format names objects in another algorithm
+
+The repositories here do not set extensions.compatObjectFormat, so nothing
+is recorded in the loose object map and every name has to be computed.
+'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# The object formats are pinned rather than left to the default so that
+# these tests behave the same under GIT_TEST_DEFAULT_HASH=sha256.
+test_expect_success 'setup' '
+	for fmt in sha1 sha256
+	do
+		git init --object-format=$fmt ${fmt}repo &&
+		mkdir -p ${fmt}repo/sub &&
+		test_write_lines hello >${fmt}repo/a.txt &&
+		test_write_lines world >${fmt}repo/sub/b.txt &&
+		test_write_lines exec >${fmt}repo/sub/run.sh &&
+		chmod +x ${fmt}repo/sub/run.sh &&
+		test_write_lines dup >${fmt}repo/sub/dup1 &&
+		test_write_lines dup >${fmt}repo/dup2 &&
+		git -C ${fmt}repo add -A &&
+		git -C ${fmt}repo commit -m initial || return 1
+	done
+'
+
+test_expect_success 'name a tree in the other algorithm' '
+	git -C sha256repo rev-parse HEAD^{tree} >expect &&
+	git -C sha1repo rev-parse --output-object-format=sha256 HEAD^{tree} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'name a subtree given as <rev>:<path>' '
+	git -C sha256repo rev-parse HEAD:sub >expect &&
+	git -C sha1repo rev-parse --output-object-format=sha256 HEAD:sub >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'name a blob in the other algorithm' '
+	git -C sha256repo rev-parse HEAD:a.txt >expect &&
+	git -C sha1repo rev-parse --output-object-format=sha256 HEAD:a.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'name the empty tree' '
+	empty1=$(git -C sha1repo hash-object -t tree /dev/null) &&
+	git -C sha256repo hash-object -t tree /dev/null >expect &&
+	git -C sha1repo rev-parse --output-object-format=sha256 "$empty1" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'the conversion runs in both directions' '
+	git -C sha1repo rev-parse HEAD^{tree} >expect &&
+	git -C sha256repo rev-parse --output-object-format=sha1 HEAD^{tree} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'asking for the storage algorithm is a no-op' '
+	git -C sha1repo rev-parse HEAD^{tree} >expect &&
+	git -C sha1repo rev-parse --output-object-format=storage HEAD^{tree} >actual &&
+	test_cmp expect actual &&
+	git -C sha1repo rev-parse --output-object-format=sha1 HEAD^{tree} >actual &&
+	test_cmp expect actual
+'
+
+# Before the names could be computed, a lookup miss left the object ID
+# untouched and rev-parse printed the storage name with a zero exit code.
+test_expect_success 'a name that cannot be computed is an error, not a wrong answer' '
+	test_must_fail git -C sha1repo rev-parse --output-object-format=sha256 \
+		HEAD >actual 2>err &&
+	test_grep "cannot compute the sha256 name of commit" err &&
+	test_grep "cannot express HEAD as a sha256 object name" err &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'a tree containing a submodule reports the submodule' '
+	git init --object-format=sha1 withsub &&
+	gitlink=$(git -C sha1repo rev-parse HEAD) &&
+	(
+		cd withsub &&
+		test_write_lines x >f &&
+		git add f &&
+		git update-index --add --cacheinfo 160000,$gitlink,modpath &&
+		git commit -m withsub
+	) &&
+	test_must_fail git -C withsub rev-parse --output-object-format=sha256 \
+		HEAD^{tree} 2>err &&
+	test_grep "cannot map submodule entry .modpath." err
+'
+
+test_expect_success 'an unknown algorithm is rejected' '
+	test_must_fail git -C sha1repo rev-parse --output-object-format=md5 \
+		HEAD^{tree} 2>err &&
+	test_grep "unsupported object format: md5" err
+'
+
+test_expect_success 'a missing algorithm is rejected' '
+	test_must_fail git -C sha1repo rev-parse --output-object-format \
+		HEAD^{tree} 2>err &&
+	test_grep "no object format specified" err &&
+	test_must_fail git -C sha1repo rev-parse --output-object-format= \
+		HEAD^{tree} 2>err &&
+	test_grep "unsupported object format:" err
+'
+
+test_expect_success 'names computed here match a real conversion' '
+	git -C sha1repo fast-export --full-tree HEAD >stream &&
+	git init --bare --object-format=sha256 converted.git &&
+	git -C converted.git fast-import --quiet <stream &&
+	git -C converted.git rev-parse HEAD^{tree} >expect &&
+	git -C sha1repo rev-parse --output-object-format=sha256 HEAD^{tree} >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.53.0

