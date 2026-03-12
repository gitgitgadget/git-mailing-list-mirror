Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312143CCA04
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333736; cv=none; b=EuYzBc4IjsZYPi9/i11vg48jEzFrCtDYsbA+GC+PC92cpIqhWIhAA5KOM/eENYVYpUXRMohZ0UwKFs1W11tFBS1nN8Tm7N4sCoU8vQxXjMMYr1KYm/mq08q7oQqgExCBeheb0vuMYAvociBRfevBmHIRYTe15SQKI3P79y44fhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333736; c=relaxed/simple;
	bh=uYCS6TZK/KeM/i8Prx4SJmNRaY2Kk/gK5Od+Y73UYXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mOv9TW1JrkAj3hVjH38KAm9r6pFztQeBuKIOk23ftmciRC4Xjxxk9RD4VyroT45VDLGDKmrzaJpkL35r/41zeDSdTtInEHhwHN/t1yemb7blU30vQFrvVJKpyHeGDNKWyPB2glKorDYWE6VOhVGWNCGXUSucEuzg7RWkNKBMEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jnM3OsRH; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=UCMyO448; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jnM3OsRH";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="UCMyO448"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jnM3OsRHmeZjfLMnuPlCMDFEJ6jusesCz1MM6fz+IZBvN4ESEXYkROy6bRkuDRvJy+eDAWqlKXFRM4ywt0bXGmMLt5BH3IMIr1WK/pVIYUAXbHEL9Xif80D71pXzejE5GywtHc9e7L9DZy4bCWp3Rdtlg360ep1vVwE30teojsMpBH++0VeX4rZKED3yBYRuxqiLdfDgOw8BUeCQjx+VkPS+R9sRvtdJvkQTnuTTFEh/vIt3FwuZZ8GjidHig3FwqLo9jvvpY8Im7/yV/YqldqsKZh/mSjQarYO8LpNxXn/sp8ZC7D/qYaklq6tSvzX+AU4tQkzcNAs3ZgOcu9m+aA==; s=purelymail2; d=malon.dev; v=1; bh=uYCS6TZK/KeM/i8Prx4SJmNRaY2Kk/gK5Od+Y73UYXw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=UCMyO448F6+nnUuYbXKIoJXPUxK1HWB1W1r3fAbM+UvuXSMGFQ+CPenVNRKTiD18HZvgxqqnO8Nm9YUl/93w2g2tYG2Ts1mqpcAGuk/oRza6wLzDHY9kZ1kdy9oln//CdjNGe7f5uKYWlDERJ6Z9NyYmTSTQ7kMuOZMsuYb58mfv6MyD7vLgw3se6jt53jvnp1D0NIyQXD84cENwYrlWWvC6m5fdXO4Ad9uub/WTy1V54yGPzjVZfkxzc6QxcTys/jUAN7jJSB+0WHOitX/kbfjkmaH8FTGPFx+yIE8ra///u2m0x+DnQxk/XjDIDx/okas3rQh9F8mhOE21xjToDA==; s=purelymail2; d=purelymail.com; v=1; bh=uYCS6TZK/KeM/i8Prx4SJmNRaY2Kk/gK5Od+Y73UYXw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -597434471;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 12 Mar 2026 16:42:13 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	ps@pks.im,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v2] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Date: Fri, 13 Mar 2026 00:42:03 +0800
Message-ID: <20260312164203.964033-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'cmd_mktree()' function already receives a 'struct repository *repo'
pointer, but it was previously marked as UNUSED.

Pass the 'repo' pointer down to 'mktree_line()' and 'write_tree()'.
Consequently, remove the 'USE_THE_REPOSITORY_VARIABLE' macro, replace
usages of 'the_repository', and swap 'parse_oid_hex()' with its context-awa=
re
version 'parse_oid_hex_algop()'.

This refactoring is safe because 'cmd_mktree()' is registered with the
'RUN_SETUP' flag in 'git.c', which guarantees that the command is
executed within a initialized repository, ensuring that the passed 'repo'
pointer is never 'NULL'.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 builtin/mktree.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 12772303f5..4084e32476 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -3,7 +3,6 @@
  *
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
@@ -46,7 +45,7 @@ static int ent_compare(const void *a_, const void *b_)
 =09=09=09=09 b->name, b->len, b->mode);
 }
=20
-static void write_tree(struct object_id *oid)
+static void write_tree(struct repository *repo, struct object_id *oid)
 {
 =09struct strbuf buf;
 =09size_t size;
@@ -60,10 +59,10 @@ static void write_tree(struct object_id *oid)
 =09for (i =3D 0; i < used; i++) {
 =09=09struct treeent *ent =3D entries[i];
 =09=09strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
-=09=09strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
+=09=09strbuf_add(&buf, ent->oid.hash, repo->hash_algo->rawsz);
 =09}
=20
-=09odb_write_object(the_repository->objects, buf.buf, buf.len, OBJ_TREE, o=
id);
+=09odb_write_object(repo->objects, buf.buf, buf.len, OBJ_TREE, oid);
 =09strbuf_release(&buf);
 }
=20
@@ -72,7 +71,7 @@ static const char *const mktree_usage[] =3D {
 =09NULL
 };
=20
-static void mktree_line(char *buf, int nul_term_line, int allow_missing)
+static void mktree_line(struct repository *repo, char *buf, int nul_term_l=
ine, int allow_missing)
 {
 =09char *ptr, *ntr;
 =09const char *p;
@@ -93,7 +92,7 @@ static void mktree_line(char *buf, int nul_term_line, int=
 allow_missing)
 =09=09die("input format error: %s", buf);
 =09ptr =3D ntr + 1; /* type */
 =09ntr =3D strchr(ptr, ' ');
-=09if (!ntr || parse_oid_hex(ntr + 1, &oid, &p) ||
+=09if (!ntr || parse_oid_hex_algop(ntr + 1, &oid, &p, repo->hash_algo) ||
 =09    *p !=3D '\t')
 =09=09die("input format error: %s", buf);
=20
@@ -124,7 +123,7 @@ static void mktree_line(char *buf, int nul_term_line, i=
nt allow_missing)
=20
 =09/* Check the type of object identified by oid without fetching objects =
*/
 =09oi.typep =3D &obj_type;
-=09if (odb_read_object_info_extended(the_repository->objects, &oid, &oi,
+=09if (odb_read_object_info_extended(repo->objects, &oid, &oi,
 =09=09=09=09=09  OBJECT_INFO_LOOKUP_REPLACE |
 =09=09=09=09=09  OBJECT_INFO_QUICK |
 =09=09=09=09=09  OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
@@ -155,7 +154,7 @@ static void mktree_line(char *buf, int nul_term_line, i=
nt allow_missing)
 int cmd_mktree(int ac,
 =09       const char **av,
 =09       const char *prefix,
-=09       struct repository *repo UNUSED)
+=09       struct repository *repo)
 {
 =09struct strbuf sb =3D STRBUF_INIT;
 =09struct object_id oid;
@@ -187,7 +186,7 @@ int cmd_mktree(int ac,
 =09=09=09=09=09break;
 =09=09=09=09die("input format error: (blank line only valid in batch mode)=
");
 =09=09=09}
-=09=09=09mktree_line(sb.buf, nul_term_line, allow_missing);
+=09=09=09mktree_line(repo, sb.buf, nul_term_line, allow_missing);
 =09=09}
 =09=09if (is_batch_mode && got_eof && used < 1) {
 =09=09=09/*
@@ -197,7 +196,7 @@ int cmd_mktree(int ac,
 =09=09=09 */
 =09=09=09; /* skip creating an empty tree */
 =09=09} else {
-=09=09=09write_tree(&oid);
+=09=09=09write_tree(repo, &oid);
 =09=09=09puts(oid_to_hex(&oid));
 =09=09=09fflush(stdout);
 =09=09}
--=20
2.43.0

