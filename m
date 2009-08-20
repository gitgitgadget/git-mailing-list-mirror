From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 14/19] unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
Date: Thu, 20 Aug 2009 20:47:08 +0700
Message-ID: <1250776033-12395-15-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
 <1250776033-12395-11-git-send-email-pclouds@gmail.com>
 <1250776033-12395-12-git-send-email-pclouds@gmail.com>
 <1250776033-12395-13-git-send-email-pclouds@gmail.com>
 <1250776033-12395-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81L-0007ZS-Ow
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbZHTNsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbZHTNsi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:38 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:62823 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbZHTNsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:36 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so3269349pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qtIIHj1tvtokFEdhb41WHrkGxIJWw9ZC+1hOyEQauW4=;
        b=amGomg7GbCyOAWI0m8T/17e2cKs/+TkpZHG6TgHdArcwKtA474Z+nGzmlzLkkHe5Pc
         ZmO7kt6/C2+dCEpdHujGxI7mBKFLnGZtgrBwVnC4IlFjixXWyM/xlYrMOUX/z/v7p29p
         xDe1pLiK8HfVFKZ5Op6Wz3i1JP2ztRZgM8DiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=p8pMd65kfYdlsaTlolBK+AaoUP3BTux8zEma1EIa9sK+sC+UzX7i5hB7LThZbYgqXk
         fKD4qXh2CBGWF4HcOt9c5eNonZ62l12GiuRXucNIbEmIjWeRpuI+tpJN1IB82cULVDvU
         cKu7DFgAsBe578z9d9wqbuoq8abJFd6IcMKJg=
Received: by 10.115.144.9 with SMTP id w9mr9208829wan.66.1250776118348;
        Thu, 20 Aug 2009 06:48:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 22sm186415pzk.6.2009.08.20.06.48.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:32 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-14-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126639>

This patch introduces core.sparseCheckout, which will control whether
sparse checkout support is enabled in unpack_trees()

It also loads sparse-checkout file that will be used in the next patch.
I split it out so the next patch will be shorter, easier to read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt        |    4 ++++
 Documentation/git-read-tree.txt |    4 +++-
 cache.h                         |    1 +
 config.c                        |    5 +++++
 environment.c                   |    1 +
 unpack-trees.c                  |   36 ++++++++++++++++++++++++++++++-=
-----
 unpack-trees.h                  |    4 ++++
 7 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5256c7f..bfaa78d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -439,6 +439,10 @@ On some file system/operating system combinations,=
 this is unreliable.
 Set this config setting to 'rename' there; However, This will remove t=
he
 check that makes sure that existing object files will not get overwrit=
ten.
=20
+core.sparseCheckout::
+	Enable "sparse checkout" feature. See section "Sparse checkout" in
+	linkgit:git-read-tree[1] for more information.
+
 add.ignore-errors::
 	Tells 'git-add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index 8b39716..fc3f08b 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -401,7 +401,9 @@ follows:
 ----------------
=20
 Then you can disable sparse checkout. Sparse checkout support in "git
-read-tree" and similar commands is disabled by default.
+read-tree" and similar commands is disabled by default. You need to
+turn `core.sparseCheckout` on in order to have sparse checkout
+support.
=20
=20
 SEE ALSO
diff --git a/cache.h b/cache.h
index 0e912a9..a401daf 100644
--- a/cache.h
+++ b/cache.h
@@ -528,6 +528,7 @@ extern int auto_crlf;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_apply_sparse_checkout;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index e87edea..abd762e 100644
--- a/config.c
+++ b/config.c
@@ -503,6 +503,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.sparsecheckout")) {
+		core_apply_sparse_checkout =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5de6837..f9ea207 100644
--- a/environment.c
+++ b/environment.c
@@ -50,6 +50,7 @@ enum push_default_type push_default =3D PUSH_DEFAULT_=
MATCHING;
 #endif
 enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MOD=
E;
 int grafts_replace_parents =3D 1;
+int core_apply_sparse_checkout;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/unpack-trees.c b/unpack-trees.c
index 8eb4b70..44f8fdf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -378,6 +378,7 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 {
 	int ret;
 	static struct cache_entry *dfc;
+	struct exclude_list el;
=20
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -387,6 +388,16 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 	state.quiet =3D 1;
 	state.refresh_cache =3D 1;
=20
+	memset(&el, 0, sizeof(el));
+	if (!core_apply_sparse_checkout || !o->update)
+		o->skip_sparse_checkout =3D 1;
+	if (!o->skip_sparse_checkout) {
+		if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"),=
 "", 0, NULL, &el, 0) < 0)
+			o->skip_sparse_checkout =3D 1;
+		else
+			o->el =3D &el;
+	}
+
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized =3D 1;
 	if (o->src_index) {
@@ -407,26 +418,39 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 		info.fn =3D unpack_callback;
 		info.data =3D o;
=20
-		if (traverse_trees(len, t, &info) < 0)
-			return unpack_failed(o, NULL);
+		if (traverse_trees(len, t, &info) < 0) {
+			ret =3D unpack_failed(o, NULL);
+			goto done;
+		}
 	}
=20
 	/* Any left-over entries in the index? */
 	if (o->merge) {
 		while (o->pos < o->src_index->cache_nr) {
 			struct cache_entry *ce =3D o->src_index->cache[o->pos];
-			if (unpack_index_entry(ce, o) < 0)
-				return unpack_failed(o, NULL);
+			if (unpack_index_entry(ce, o) < 0) {
+				ret =3D unpack_failed(o, NULL);
+				goto done;
+			}
 		}
 	}
=20
-	if (o->trivial_merges_only && o->nontrivial_merge)
-		return unpack_failed(o, "Merge requires file-level merging");
+	if (o->trivial_merges_only && o->nontrivial_merge) {
+		ret =3D unpack_failed(o, "Merge requires file-level merging");
+		goto done;
+	}
=20
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
 		*o->dst_index =3D o->result;
+
+done:
+	for (i =3D 0;i < el.nr;i++)
+		free(el.excludes[i]);
+	if (el.excludes)
+		free(el.excludes);
+
 	return ret;
 }
=20
diff --git a/unpack-trees.h b/unpack-trees.h
index d19df44..5c9e98a 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -4,6 +4,7 @@
 #define MAX_UNPACK_TREES 8
=20
 struct unpack_trees_options;
+struct exclude_list;
=20
 typedef int (*merge_fn_t)(struct cache_entry **src,
 		struct unpack_trees_options *options);
@@ -28,6 +29,7 @@ struct unpack_trees_options {
 		     skip_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
+		     skip_sparse_checkout,
 		     gently;
 	const char *prefix;
 	int pos;
@@ -44,6 +46,8 @@ struct unpack_trees_options {
 	struct index_state *dst_index;
 	struct index_state *src_index;
 	struct index_state result;
+
+	struct exclude_list *el; /* for internal use */
 };
=20
 extern int unpack_trees(unsigned n, struct tree_desc *t,
--=20
1.6.3.GIT
