Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB718A6DB
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770558469; cv=none; b=aHJtkh1y1rUrpPqppWwjXMrcCyVoSOsPk5lTpxDZbFAZxRhlORJ0n7dMPvULOcoGvvIdeVc7nqppajbX1JlKWIFTV8rJFXqTF6/WoaWVruyYgsjrLpuP/dLgWkAVjfuhMt2iJCnRQSs8hjov5jnuVl0lZ/bxKdv8Y04q3QLJVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770558469; c=relaxed/simple;
	bh=1Z0YoIB6C4oZE7n9rUG95FR0QymxE6qHqvEAqdri/rY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dBR8/lQc0NHAuwe889TzSGLQOXbXRaEbWlwTWqfWwy/CffNLzyGjts2xs7uTkRHSko4mpisHzjAcwlW5QuDdwYGW4c6qqO3t6/2KjHegFc9aitBSO6w0CeoXSFdl9Ax6u8YenASyFrYIeyI+KsIvv7sWl1/MgQHuw1olOyWfcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=T692w1Lq; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="T692w1Lq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770558460; x=1771163260; i=l.s.r@web.de;
	bh=uNDZu8lqPtoZS7RbDtomKQEOfmxqStvhcK3+17VnHfo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T692w1Lq0X4gEOxZmA2skIlOqyArEJBDqJqAZA2l3LdPhQtsSpGjx0SV9T8mAfzU
	 HyxbRjE2682BIJTWkqMQYMbJy2f0fMhW47PMljmneC11lGVWCqAN0EtIacxk9sJrM
	 14cj/vkiZlaMV1FPG8+blwKNvhTX5J+Z+pM4ypzZDiN/zomnH90QrxQejeY0kf2sx
	 zB2hnm90LMK5cCuFFN+GAdQiPeVY80HBBtoGV2Tg3FZ0lb825RpRPKXFSa51/Izye
	 O7Sy9c63kU9IvCyNyYv3Qr40rlr6LpO8DLFgBSHZSK1cIi97KUFrPdNLEq7831G8u
	 Bk4pZZ7NpMcNj4IHog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1vVUof2Wkr-00sQTW for
 <git@vger.kernel.org>; Sun, 08 Feb 2026 14:47:40 +0100
Message-ID: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
Date: Sun, 8 Feb 2026 14:47:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] xdiff-interface: stop using the_repository
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRtfzCe+iTWE5uFAKejB/XD6ZWlzWN0VdH/5pkty3DtCqNxHr0R
 ee6IVMH/YVecUjgF9U+4tQbXvYuBIFd/Hfaxcq0wAEpLIchbIL6RofLI/o0TuQhQjQuR4QX
 oEjnqJ2dnpTH/PcMa/dxHrbBGIybcUJn7dt/Zk/Y4VmD9fXMaJQiojpN6+7XuuNZLUeUTRR
 3Pdebmbi/a4gOrU/6KPEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IM+CYqkHWz8=;alCe9aY4FhymY03OjUs89qOwqxK
 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
 A/4eEEnL37QLLCr7w=

Use the algorithm-agnostic is_null_oid() and push the dependency of
read_mmblob() on the_repository->objects to its callers.  This allows it
to be used with arbitrary object databases.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 apply.c              | 6 +++---
 builtin/checkout.c   | 6 +++---
 builtin/merge-file.c | 2 +-
 merge-ort.c          | 6 +++---
 notes-merge.c        | 6 +++---
 xdiff-interface.c    | 9 +++++----
 xdiff-interface.h    | 5 ++++-
 7 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/apply.c b/apply.c
index 3de4aa4d2e..ea90ed16be 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -3568,9 +3568,9 @@ static int three_way_merge(struct apply_state *state=
,
 	else if (oideq(base, theirs) || oideq(ours, theirs))
 		return resolve_to(image, ours);
=20
-	read_mmblob(&base_file, base);
-	read_mmblob(&our_file, ours);
-	read_mmblob(&their_file, theirs);
+	read_mmblob(&base_file, the_repository->objects, base);
+	read_mmblob(&our_file, the_repository->objects, ours);
+	read_mmblob(&their_file, the_repository->objects, theirs);
 	merge_opts.variant =3D state->merge_variant;
 	status =3D ll_merge(&result, path,
 			  &base_file, "base",
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0ba4f03f2e..f7b313816e 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -294,9 +294,9 @@ static int checkout_merged(int pos, const struct check=
out *state,
 	if (is_null_oid(&threeway[1]) || is_null_oid(&threeway[2]))
 		return error(_("path '%s' does not have necessary versions"), path);
=20
-	read_mmblob(&ancestor, &threeway[0]);
-	read_mmblob(&ours, &threeway[1]);
-	read_mmblob(&theirs, &threeway[2]);
+	read_mmblob(&ancestor, the_repository->objects, &threeway[0]);
+	read_mmblob(&ours, the_repository->objects, &threeway[1]);
+	read_mmblob(&theirs, the_repository->objects, &threeway[2]);
=20
 	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
 	ll_opts.renormalize =3D renormalize;
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 46775d0c79..c5dbd028fd 100644
=2D-- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -128,7 +128,7 @@ int cmd_merge_file(int argc,
 				ret =3D error(_("object '%s' does not exist"),
 					      argv[i]);
 			else if (!oideq(&oid, the_hash_algo->empty_blob))
-				read_mmblob(mmf, &oid);
+				read_mmblob(mmf, the_repository->objects, &oid);
 			else
 				read_mmfile(mmf, "/dev/null");
 		} else if (read_mmfile(mmf, fname)) {
diff --git a/merge-ort.c b/merge-ort.c
index e80e4f735a..a4103d56ed 100644
=2D-- a/merge-ort.c
+++ b/merge-ort.c
@@ -2136,9 +2136,9 @@ static int merge_3way(struct merge_options *opt,
 		name2 =3D mkpathdup("%s:%s", opt->branch2,  pathnames[2]);
 	}
=20
-	read_mmblob(&orig, o);
-	read_mmblob(&src1, a);
-	read_mmblob(&src2, b);
+	read_mmblob(&orig, the_repository->objects, o);
+	read_mmblob(&src1, the_repository->objects, a);
+	read_mmblob(&src2, the_repository->objects, b);
=20
 	merge_status =3D ll_merge(result_buf, path, &orig, base,
 				&src1, name1, &src2, name2,
diff --git a/notes-merge.c b/notes-merge.c
index 586939939f..47e9d7580a 100644
=2D-- a/notes-merge.c
+++ b/notes-merge.c
@@ -359,9 +359,9 @@ static int ll_merge_in_worktree(struct notes_merge_opt=
ions *o,
 	mmfile_t base, local, remote;
 	enum ll_merge_result status;
=20
-	read_mmblob(&base, &p->base);
-	read_mmblob(&local, &p->local);
-	read_mmblob(&remote, &p->remote);
+	read_mmblob(&base, the_repository->objects, &p->base);
+	read_mmblob(&local, the_repository->objects, &p->local);
+	read_mmblob(&remote, the_repository->objects, &p->remote);
=20
 	status =3D ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
 			  &local, o->local_ref, &remote, o->remote_ref,
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 1a35556380..cd7493730b 100644
=2D-- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
=20
 #include "git-compat-util.h"
@@ -7,6 +6,7 @@
 #include "config.h"
 #include "hex.h"
 #include "odb.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
@@ -177,18 +177,19 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	return 0;
 }
=20
-void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
+void read_mmblob(mmfile_t *ptr, struct object_database *odb,
+		 const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
=20
-	if (oideq(oid, null_oid(the_hash_algo))) {
+	if (is_null_oid(oid)) {
 		ptr->ptr =3D xstrdup("");
 		ptr->size =3D 0;
 		return;
 	}
=20
-	ptr->ptr =3D odb_read_object(the_repository->objects, oid, &type, &size)=
;
+	ptr->ptr =3D odb_read_object(odb, oid, &type, &size);
 	if (!ptr->ptr || type !=3D OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 	ptr->size =3D size;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index dfc55daddf..fbc4ceec40 100644
=2D-- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -4,6 +4,8 @@
 #include "hash.h"
 #include "xdiff/xdiff.h"
=20
+struct object_database;
+
 /*
  * xdiff isn't equipped to handle content over a gigabyte;
  * we make the cutoff 1GB - 1MB to give some breathing
@@ -45,7 +47,8 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
 int read_mmfile(mmfile_t *ptr, const char *filename);
-void read_mmblob(mmfile_t *ptr, const struct object_id *oid);
+void read_mmblob(mmfile_t *ptr, struct object_database *odb,
+		 const struct object_id *oid);
 int buffer_is_binary(const char *ptr, unsigned long size);
=20
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflag=
s);
=2D-=20
2.52.0
