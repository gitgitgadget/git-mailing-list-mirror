Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994CA3EF672
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995076; cv=none; b=szAGbZccwsW0fuJar1G+uYHJ20POJgoQhpZZAt1w5A6toIL6ZFYAywfcJtz4QqraCGje1FXO7B8KgmC3SSfGrawAkbjJJuefTCZoUcruhy/Jel9/n9lS8FsxPfrEsyZ693VIA87IdUAdFnh7fY/7v3k4bP7ys3XELR1HLo25lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995076; c=relaxed/simple;
	bh=kb9DuREsbx6LsxgSVW8taut6hdTJt3aUg8HvFS3dbyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uII/MnuTHnW8wYqvTDc7PpA1JGasI+za8RsnSMwukg+0R4m9uxYNV72yUsrZ4Lh1C+F+XkxG3lbAm/PfA5JI3GOCii9QiJAazFeI6ibkJ5dVNL5qnvUqlwmTFbFEq7ISQbYdZEqm03pTPKuzf5OXKiB41givrh7wTTlehHIIPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bLX/c8RM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HhBFNh3V; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bLX/c8RM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhBFNh3V"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 898C77A01C1;
	Tue,  9 Jun 2026 04:51:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 09 Jun 2026 04:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995073;
	 x=1781081473; bh=ingWsdhP9CiBt4Iim4K2cRU8Vgr+jtqp86AML7i8tc4=; b=
	bLX/c8RMVYOwBk/OS89zN0jMJPiTRmUsbEt4GEYkV3saw3ph4YMH3XQcmkK1kGF/
	foLxXObJLtXn1dyDUQipSNGnM2EU8m9xjEmacYc5s7o/BxGwl2tRI8olFSXL01dK
	sC7KDo4T9c5qS3JavFLhx8p5typscoGcYe4D+bJe+hKYPB+5x9o87BANwsNGm8OL
	VI2zzEimUAqdKLDgmjqqKWm7fzfS5hBk+i6Hn60ybefQR4KxpS0wKgw3y3Yea/Zs
	+nTLmF7bZkosYSSzNp6lQsrqi2J+4fDfclO9XWruNT0KJopbaI95LavqR/CU8SiF
	80mwqXKGNjQCAl9Aw8CWYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995073; x=
	1781081473; bh=ingWsdhP9CiBt4Iim4K2cRU8Vgr+jtqp86AML7i8tc4=; b=H
	hBFNh3VZ3kcJ1w3sVjrwQNpbsHW7lMJJ2s4q7qL5KfQ4WZ+bqhCBb4oN6yUMS2A8
	Lf25UaKytWykPcBvtxjVkLLavk1fMqrO04LhmQB4D1Z76n5KGDyp01D1rj/dVwur
	kFUON7Fi/Lts3/irqXhM9MgQsQ7Jti1UC2zsT9SWZ7ncYqF8VhGkC14TptQ/f88n
	vEiIJVANomKsQaHyqM4rsVkkAoEmj8WWOQqg0N7bZjV1HJHP4AfAl1zNs7lMiKIo
	HYvw08n+ZXUJzfxN/fAPyD/ocSciwN1WgYb+dTo6/fMDl/IVdaBOz9+2go6Oz8Gk
	NsPAAZk6rYznXBaq6Yxhw==
X-ME-Sender: <xms:AdQnai6NvP_joNsGC2m39iP65oFsElVxctsv5cbKqIVpwxmO0VcNJg>
    <xme:AdQnah4QGy2xSo5-VG9bRud3qi7-CkY8PpgS9J7119q7qazJQXyaFfuVOWPoGI4E7
    bMMyWvT-tKcT6yY4PnemOud6so6iA7ilZlD34MqbYnKSzD7Xfn6yw>
X-ME-Received: <xmr:AdQnavHG8ZjSncGz0P04XyYQJDGv3rJyTN2_JmxmZr5XlLDhtJ7MZs9iqib2PMIxvjlJkGwjwatHw0_bcHBQrV4RU5_5G-Ta9I9hamI7-h0>
X-ME-Proxy-Cause: dmFkZTFScmXmBNtXOl4rqVqM8DAc19fyHinqrfJGsNjV/CE2oHckwvnGyvDfLnNUuwKybL
    TXXNE7zDSLzm9sqK7QnFjZefXQ77hB0yUpUORZINqHtbw80x5HeASQHzHrphN1o87wLUDo
    o+b2Dx90Cc3HLmwbZsks1v5Qe3wgVjPUMwX4Epw71mRv/T8ItHrE8RkWZrv81HY9CRlc3Z
    /OiNXFOpQwrN765XqADbyILD80acXbo1GJdpcquKP94bmw57TBOmknCC1tOk25qwSfgaav
    egwmPIOD8ZPaE7+A6cnzDiyYUxaYdFHC73rr/JrclTuz03BNq0lnxnglgQ3GRx5+ugY1HK
    S4xNn2DNYOqE1+OUB4LUsqBteg7xFQX66o0m3T7j57Qhtm6MbSf9nRHt5lXu+OGH8lOKIs
    XHZ7ZnGzF+fcnuJiSd2XBLRUwCa/3bhO6Bi1ZlX6pE7atHiIUenhmLLhqUQAC5x+d/Lg1m
    +zCYWlNKAdn0DLK53w5tLvFPOMbiDfdYpWw2C+zWoI5lPKJF71p3RRohrbVSWTtDV/AdOv
    fJfCgA9x4ItZFNhrURHkOHXBcrow0XBw9NALIHLrdtHGTkBRzmr8tCAQ4doez7RJ02fjKX
    uf10s8SFvCPl0mzU4fXlE20Vd/H9C4uEGihq3j92gbttd/Rk5dWkh9siLgDA
X-ME-Proxy: <xmx:AdQnaqSDtOOiG7PY9_r9IXsgtVsHV7NWbp3fLeQMBMORkbIqbocGZQ>
    <xmx:AdQnaoviF58MOaLmLdPvcgZ9ZUknTPcinnQ0-lHpTBsXIWSRcGW9Xg>
    <xmx:AdQnapxCcDJAw_1cx9Jkpr26kbxwFrRKfibTn5e_xpj7MIqg7au_ew>
    <xmx:AdQnai43CeHZ5Cf4Tn3GF6Ir5-qtjMUhXJlRnjXTAwphFpvHei0teQ>
    <xmx:AdQnagorlFeLWoZhSSNk5FkJ41DSONaPxm1Rvki0lxAJbGaHwNhSIGTC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c767333d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:50:55 +0200
Subject: [PATCH v2 02/17] packfile: split out packfile list logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-2-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In the next commit we're about to introduce the "packed" object database
source. This source will embed a packfile list, and consequently we'll
have to include "packfile.h" to make the struct definition available.
This will unfortunately lead to a cyclic dependency that we cannot
resolve with a forward declaration.

Split out the code that relates to the packfile list into a separate
compilation unit so that both "packfile.h" and "odb/source-packed.h" can
include it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile        |  1 +
 meson.build     |  1 +
 packfile-list.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile-list.h | 28 +++++++++++++++++++
 packfile.c      | 83 -------------------------------------------------------
 packfile.h      | 23 +--------------
 6 files changed, 117 insertions(+), 105 deletions(-)

diff --git a/Makefile b/Makefile
index 0976a69b4c..ed1731548e 100644
--- a/Makefile
+++ b/Makefile
@@ -1233,6 +1233,7 @@ LIB_OBJS += pack-refs.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
+LIB_OBJS += packfile-list.o
 LIB_OBJS += pager.o
 LIB_OBJS += parallel-checkout.o
 LIB_OBJS += parse.o
diff --git a/meson.build b/meson.build
index 3247697f74..12913fc948 100644
--- a/meson.build
+++ b/meson.build
@@ -421,6 +421,7 @@ libgit_sources = [
   'pack-revindex.c',
   'pack-write.c',
   'packfile.c',
+  'packfile-list.c',
   'pager.c',
   'parallel-checkout.c',
   'parse.c',
diff --git a/packfile-list.c b/packfile-list.c
new file mode 100644
index 0000000000..01fb913abf
--- /dev/null
+++ b/packfile-list.c
@@ -0,0 +1,86 @@
+#include "git-compat-util.h"
+#include "packfile.h"
+#include "packfile-list.h"
+
+void packfile_list_clear(struct packfile_list *list)
+{
+	struct packfile_list_entry *e, *next;
+
+	for (e = list->head; e; e = next) {
+		next = e->next;
+		free(e);
+	}
+
+	list->head = list->tail = NULL;
+}
+
+static struct packfile_list_entry *packfile_list_remove_internal(struct packfile_list *list,
+								 struct packed_git *pack)
+{
+	struct packfile_list_entry *e, *prev;
+
+	for (e = list->head, prev = NULL; e; prev = e, e = e->next) {
+		if (e->pack != pack)
+			continue;
+
+		if (prev)
+			prev->next = e->next;
+		if (list->head == e)
+			list->head = e->next;
+		if (list->tail == e)
+			list->tail = prev;
+
+		return e;
+	}
+
+	return NULL;
+}
+
+void packfile_list_remove(struct packfile_list *list, struct packed_git *pack)
+{
+	free(packfile_list_remove_internal(list, pack));
+}
+
+void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack)
+{
+	struct packfile_list_entry *entry;
+
+	entry = packfile_list_remove_internal(list, pack);
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->pack = pack;
+	}
+	entry->next = list->head;
+
+	list->head = entry;
+	if (!list->tail)
+		list->tail = entry;
+}
+
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
+{
+	struct packfile_list_entry *entry;
+
+	entry = packfile_list_remove_internal(list, pack);
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->pack = pack;
+	}
+	entry->next = NULL;
+
+	if (list->tail) {
+		list->tail->next = entry;
+		list->tail = entry;
+	} else {
+		list->head = list->tail = entry;
+	}
+}
+
+struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
+					  const struct object_id *oid)
+{
+	for (; packs; packs = packs->next)
+		if (find_pack_entry_one(oid, packs->pack))
+			return packs->pack;
+	return NULL;
+}
diff --git a/packfile-list.h b/packfile-list.h
new file mode 100644
index 0000000000..1b05e2aa36
--- /dev/null
+++ b/packfile-list.h
@@ -0,0 +1,28 @@
+#ifndef PACKFILE_LIST_H
+#define PACKFILE_LIST_H
+
+struct object_id;
+
+struct packfile_list {
+	struct packfile_list_entry *head, *tail;
+};
+
+struct packfile_list_entry {
+	struct packfile_list_entry *next;
+	struct packed_git *pack;
+};
+
+void packfile_list_clear(struct packfile_list *list);
+void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
+void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
+void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
+
+/*
+ * Find the pack within the "packs" list whose index contains the object
+ * "oid". For general object lookups, you probably don't want this; use
+ * find_pack_entry() instead.
+ */
+struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
+					  const struct object_id *oid);
+
+#endif
diff --git a/packfile.c b/packfile.c
index a2d768d0ae..27ea4a8436 100644
--- a/packfile.c
+++ b/packfile.c
@@ -48,89 +48,6 @@ static size_t pack_mapped;
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-void packfile_list_clear(struct packfile_list *list)
-{
-	struct packfile_list_entry *e, *next;
-
-	for (e = list->head; e; e = next) {
-		next = e->next;
-		free(e);
-	}
-
-	list->head = list->tail = NULL;
-}
-
-static struct packfile_list_entry *packfile_list_remove_internal(struct packfile_list *list,
-								 struct packed_git *pack)
-{
-	struct packfile_list_entry *e, *prev;
-
-	for (e = list->head, prev = NULL; e; prev = e, e = e->next) {
-		if (e->pack != pack)
-			continue;
-
-		if (prev)
-			prev->next = e->next;
-		if (list->head == e)
-			list->head = e->next;
-		if (list->tail == e)
-			list->tail = prev;
-
-		return e;
-	}
-
-	return NULL;
-}
-
-void packfile_list_remove(struct packfile_list *list, struct packed_git *pack)
-{
-	free(packfile_list_remove_internal(list, pack));
-}
-
-void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack)
-{
-	struct packfile_list_entry *entry;
-
-	entry = packfile_list_remove_internal(list, pack);
-	if (!entry) {
-		entry = xmalloc(sizeof(*entry));
-		entry->pack = pack;
-	}
-	entry->next = list->head;
-
-	list->head = entry;
-	if (!list->tail)
-		list->tail = entry;
-}
-
-void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
-{
-	struct packfile_list_entry *entry;
-
-	entry = packfile_list_remove_internal(list, pack);
-	if (!entry) {
-		entry = xmalloc(sizeof(*entry));
-		entry->pack = pack;
-	}
-	entry->next = NULL;
-
-	if (list->tail) {
-		list->tail->next = entry;
-		list->tail = entry;
-	} else {
-		list->head = list->tail = entry;
-	}
-}
-
-struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
-					  const struct object_id *oid)
-{
-	for (; packs; packs = packs->next)
-		if (find_pack_entry_one(oid, packs->pack))
-			return packs->pack;
-	return NULL;
-}
-
 void pack_report(struct repository *repo)
 {
 	fprintf(stderr,
diff --git a/packfile.h b/packfile.h
index 9cec15bc50..4e3d701a3a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -6,6 +6,7 @@
 #include "odb.h"
 #include "odb/source-files.h"
 #include "oidset.h"
+#include "packfile-list.h"
 #include "repository.h"
 #include "strmap.h"
 
@@ -54,28 +55,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-struct packfile_list {
-	struct packfile_list_entry *head, *tail;
-};
-
-struct packfile_list_entry {
-	struct packfile_list_entry *next;
-	struct packed_git *pack;
-};
-
-void packfile_list_clear(struct packfile_list *list);
-void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
-void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
-void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
-
-/*
- * Find the pack within the "packs" list whose index contains the object
- * "oid". For general object lookups, you probably don't want this; use
- * find_pack_entry() instead.
- */
-struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
-					  const struct object_id *oid);
-
 /*
  * A store that manages packfiles for a given object database.
  */

-- 
2.54.0.1136.gdb2ca164c4.dirty

