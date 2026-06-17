Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08763542F6
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678407; cv=none; b=AQswlLsZ82vrTPlAuCzG76Ud9FPDWacu2mN0c2qay7Fi1HYhLdkcuQNcynmVbNKw4KC2aVPwU+oY6y2S5j4eEhNM0alSjMcWrdiUARPVGdVdQrHuQg9a3tiAsOc3X3eZgSRl15P5Yiv6tBMc94/9ObFKNvHgrnnTrFYQMjP22po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678407; c=relaxed/simple;
	bh=1wSAhbXj78iQrHPWG9FmvkFFmII6mc9WOpYTP5QhE6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWd8RG991IgmVNpVcQdftY5NsBND6M0VDomZ/CPxHNI9+rdIeW4B877m0GetQiW3vvnpYXhi+uOXhoUQ7kXOj6LMWnkFAApwKWLJAtd//b14vYZeZb4Ic6fTEXKo/sznQkP25AsXa9SJPVWZCAIFuH7iDcpfeuDZbQTA3/1U7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LBJvEgbm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5uOGPTj; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LBJvEgbm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5uOGPTj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4067B7A00D2;
	Wed, 17 Jun 2026 02:40:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 17 Jun 2026 02:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678405;
	 x=1781764805; bh=olTmcCsJnZoNWqyOg1dkCAIr64LTQM9vHYjP2P0dFx0=; b=
	LBJvEgbmPqSLelh04oRDg7J+UXs08nomw4RGhzze0gLvVKe881yP4q+twmrX+ZNH
	lke43bXYFQvHECxvA54JjAf3S2Umw/wP40YvDmsHArexPZk0zrKsUo2Sbphz8raK
	SRaeX+gniqd+5bMLFSG8bGRSGMXM0br/kZsgo/HsppXvRIX2Apwhc4ED9smTrivp
	ZM8LdB/ktx5nXIU9KssrfL6Gj0pnRQl5WSp/EL+djupe74PwP1G/mnuhvsl2FgXa
	2YfdI9l6SaOmKwRyiAMRBb0lwIxbAYbaoWq8OGXIIXlteywnwS13lQn8jJGmoACS
	xMEQ8JXVYufXFnZ5X5vRRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678405; x=
	1781764805; bh=olTmcCsJnZoNWqyOg1dkCAIr64LTQM9vHYjP2P0dFx0=; b=E
	5uOGPTjK9SsXhoUJO/oZhKFRjs9VRh0leYI27IqG86Y/49wAjA425B6BPXVmRX8H
	5O7lSIjPA//fxLiyw5qklyuD8u9MQ7z0lzrsI3UkDbzwv9n74oGHhWCmo7Li8ZP5
	3xenLiEB3UoRSROjrahb2z+EVRj54TlLh8ijPM3di4SfhgnRnvzrSRy7nX0lpvHK
	HPU282uH2LGu3WS3+iTf+HpO+5w9029z4L13dBls9TGnaIQDI3VFT+aas21vtw1l
	mYFFos7yzTN+eaLeoxQZlje2PSanssRmM9ZxTMHpesy5w6QhB6+XEqHk7X8AceUq
	QGEolx2Wwfr731wKFKh4w==
X-ME-Sender: <xms:RUEyaghiHhmCrLqf_3czbx_5ALmU9F4mMl-VdbiNI6s1kyHFqXl7QQ>
    <xme:RUEyagflNP8mSyUhAuY-gYDPHpo8Hgf1Z29LtPNVQ5wNESv7AHjqQzqI7Y5B7mdQq
    xEwXST1HcdnakZSDpHuPPwVz7aQbDzeU3ScLTwhjxySE9kSF3pz>
X-ME-Received: <xmr:RUEyalfWO5i_0hXyRCfj7LCaA7H4An-cVPSs63qfHEOQxmcbVWmNuAV-I4hO_3EGMSSPC5k6HtkdsjkbWan9Hw15n3Oraa_QOzxNag4>
X-ME-Proxy-Cause: dmFkZTFl07ipAIi9xJGEFtFdeXJ32YlTxjlf2nx1N6xtGXKrOC1bLbDlVvbrzzA5+wU1Co
    Syg+K8Q1ZQCASKzRK2+jUlv03fQMlni6m1uSDG9ZfsMez+CExN6BaOaB4dWww+dwFVrBWc
    MDEQgterYVrJX0duTt2YYH5sPQ0va9XcOu2v8cjr9lrtGWO3H/PAeE6gOAmLvw2VMk7fmQ
    bS0Z8M1QPaN6dBkHxm/qp0BwBioAlyPsS5cJKvA0SEp9LqrehZotcHKdpFgJTmQDXUKsqa
    EmWuysjWltbEijcyaQ8KC9W9onfmQCiSXmKIDwQVCz3CkB3vqB4j2FCfjXy4ARgFAuRiPS
    yD6CgoTtH2CavpULFH3CfGPC3swR9xlGbl62+GfO1CTrm9T8cPexokMSVxZFOdwQJw50Ok
    r8oOgVb/65aKWEAHc7hHmfMEhEG2C3Hi86NIH3QPVIP9zWHt3V7mTcYKz02y4iGGICJkSA
    /QdNx1HXRDEQ6+ONcyyFrNb2mxYzEAXZCTFwz/fCI/AAs6UVTS+4f8ubo+/B0d/KrDjQ2M
    e8YAIx4a9swMbiSfZcrKyUWy2hEycX6hE5Rdn2PmzgDRWgNaNOzcdwkEGNHwilre8Shm6h
    HzmjD95x7o2S3Y/rXPo+bi8sxnjzqnFwa0MvodanD5dnmInS2QyHMKN95FRw
X-ME-Proxy: <xmx:RUEyaq_wCodh-8W6le5Y2tYb3ZfcI7ehMrLHCrXOHsVD4oNKeKO4-A>
    <xmx:RUEyahkwm2Fsi6Gcyquu5NmWy-1DvpDgdDClD8N_E4jS-QaH-qY4EA>
    <xmx:RUEyas9x5wsZmzvMuBGnR2MPbQCoif5JKfZ95lf1McNdfXYQgqPFDw>
    <xmx:RUEyavl4ctymPJyEZIW7qKKN_diw61Pn8uVvkgs51bNfDCcPpX3dFg>
    <xmx:RUEyar51BXSCNy36-En_xZQlXfl6-L97Dgmud-cc9s8tb64giRw8QBL7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf114eab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:45 +0200
Subject: [PATCH v3 02/17] packfile: split out packfile list logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-2-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.rc0.786.g65d90a0328.dirty

