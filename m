Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA2361675
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062796; cv=none; b=qXkccFwjvznx7ZbtPtQ+7J4kx8I+ExXRfA2U0Rd3Ccsk3CgaMd/y4GURqWHvpo5ESNgxmWLX+3S99wJkYgI8kGb4WT8mTnfDIU7tqJ5YGbzpUPMd4PyEREmdPGyP/Z1ClZQ1dK9QSL0FJQ+r0LtePMNgb5HKDpDirUoHKm4xHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062796; c=relaxed/simple;
	bh=/wTy8GCYYtye0d3U6Z4CPnY89yZzPp5tfHZ1+5Wk+S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRWYZzA5zmsxcVSNxdXZ5x8zzdBMCCsQvkyDEbRaSsiGfXTpe/FLYAnVAyO5eCqB/zUDMuRbholMZw0K2G7QN6cylehiOa7WI14nDQZdhn8M/TPK0u3TZfHyPI1/WBbt7MMqG7v6Uk7yLvw7zfdAkj2bfg4LFdHJYkbhlKRAYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ALtY5RSl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJdZT2hT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ALtY5RSl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJdZT2hT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F28A37A00B9
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 18 Aug 2026 10:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787062793;
	 x=1787149193; bh=IsYXK+bj13WYSFty8OCKveZawUHxGQ5MO18Dtz8ykHk=; b=
	ALtY5RSl5jiVt8qdrXub1SEal2y3wiHqJ5p4p1mH0d53kJsfho/Sk89xHqffqF26
	l9SBYjsQmeZMpzN8XB4GJMxoRxjNW9NjvJqOW72bfYFwhjTgQIsTGES0ZYEVsvVP
	vAvwvs2TknO/y/lI627Jo72rfACWVhIrsHpnJx9NBBCPH8IwgWB/tcigfwudqPtV
	BIefk7khByhEVoycfW33WZVPISxhE5Kx3jy2SEjRnA7fn/xOM7kSpwzy3tAkZa6p
	xkj4E+kFneP5AOJzKFcOZX04w7S4rKFRfkDs1eFZnremALCGFxvnh35hfr0YFbiv
	Z0W1ikaMpWcA6q4MvCDaYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787062793; x=
	1787149193; bh=IsYXK+bj13WYSFty8OCKveZawUHxGQ5MO18Dtz8ykHk=; b=P
	JdZT2hTPZyZiiE2h0CSl1bjSc4ykT2KGufKaGKanlXBjtoaejMBqzwQ57i4Bdigl
	R/Nmx0mpmRWEIc5xMWlUvCY/gnlF1pnXRarvP8Fpwp3npn0BdThFxBx5yi/gqCuh
	W9ip7XJikNzhdxZEXQwwuKIfkFD+EZpo9X2fGj1b2NOwRBJUq5sm9ipap2k7e9O1
	nCgUsOyiyVAEhotbN4EvfrqvUA28yrjbAu9JtsNpmlpTk0H958D+oCF01+OW0Tsk
	mJXJMPHb/F0PI3nBFZ6fQ78GPz9FQhCdj5G5Y7SsmeVxsnJ+NGF+D8Fy9XD0deJj
	l24nR/BIOtWAvA/03OikA==
X-ME-Sender: <xms:CWqEaie7IGAgURXhnpdDsUPQ70LK-uRf1RyVBkcXr-mrhABvhmjiPw>
    <xme:CWqEajLOqFYkul0wC735Hji4-l4v8HcDdIsM_P7ATVtr4fimOsubQZi6xOICZhUo8
    PTtVVYFpxqkYGFkQMp7QAVzKugN--a0u3kmTRNpYa5-SnxXvZgV0w>
X-ME-Received: <xmr:CWqEapIiW32aAcJtDqi8F9h7Zl2NEFqUV0nBR1AhBC-PI4V21uOfq771B6tsJbix-PHKPtq5ppFHL0fGL5lZaDYeslVGRWAg97SoKDBa>
X-ME-Proxy-Cause: dmFkZTGeWRQN3XJ+PCNWaJB6ek4wiuWITJp8nrJrFe5zUiT+9z6FJmBFXt58En+JFG8Ahk
    FjnJhBE4mSzVmmsEUNOGAUwO4n39XmwHetw+P4ubGz9r6fdxcmxV9AxXxnusQdf37/Ioyy
    +vomc7Z1xsgdsGhpzB0rjafSmXfqYlJuhx8Dc4CZDd4D2t/qMQ0uG/XePzmvsV/cy0+mAO
    1OZ96+wlC1PFCPDB5t3rHq/W4hWDU2921Y6Fd2o5BroIviNd7EII2MiFRqIzRPfT3/6Nre
    v95UyaPEJ3G03TtKwBh0h+fah1hzkAlz+PyRBiiYQ0EEy8oYXJ2mbqtI5fId0u8E9+RqUn
    g1R7RccSz2duLahgS2RrXAhpVt5cmq++Z+H70HiBwFsLHyi5QqCft6iB+NUGSwY2fRG1P8
    Q/15KxcQu7cb96dqr2MaBmwmPqjmZAYtCt8CfS8ycJhScuu9iaQ8z/njyKQ6Rb5aS7sW79
    eSJlqJ5N+/gyzA6u5D0ffdCL1VdWIhcwBpolusHs4JDuu8OFV711tkgbrPmxj43q17H+fs
    1Y3Hwg2bQzpLrKXXXLBuUUOmXwFH2DzJFFt3KL/yhs9lKsfFDIVVTRo8WJai0Zy7mnhWQP
    eiku7LcTwG6lUa8g1WhrD62/U88/Nn/nixABRX4cTwe3D5SMwxEoB1kIJC0g
X-ME-Proxy: <xmx:CWqEalFl6iOXtGyFyBSUvqoYkh0LRWzR4XClJ5a4Q-S1YsDvXaVwew>
    <xmx:CWqEaunepCfAzYSmG6QbrPyzscZ8G2sZGeEGRYyXDQwFbZk9dtLPmQ>
    <xmx:CWqEaiIs70-ir1Z-4GNRdGH5-nL2UEqLu1D1SfXxCMJUwrr338Yhvw>
    <xmx:CWqEavZf0ySJt6k0FeOg-OQjcJOiDWKHcTRgscMLJTg68Y62YHEerg>
    <xmx:CWqEagOr9p14wKmHy5ilWpWXxfgTaI4EkI4Gmaw7zciGhhKOncgoHRvj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a29e40a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Aug 2026 16:19:33 +0200
Subject: [PATCH 6/7] odb/source: allow `read_object_info()` to bubble up
 error messages
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-6-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When reading an object fails even though it exists, the sources know
best what exactly went wrong and where the corrupt object is located.
This information is lost though when bubbling up the error to the object
database layer, which forces that layer to reconstruct it after the
fact. This is exactly what `do_oid_object_info_extended()` does via
`has_packed_and_bad()`, but that function only really knows to handle
the "files" backend by reaching into its internals.

Introduce a new `errmsg` parameter for the `read_object_info()` callback
that sources are expected to populate with a human-readable message in
case reading the object has failed. Adapt the packed and loose sources
to populate the buffer with the messages that we ultimately want to
surface to the user.

For now, all callers are adapted to pass a `NULL` pointer. We will add a
user of this new infrastructure in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  6 +++---
 odb.c                         |  7 ++++---
 odb/source-files.c            |  9 ++++++---
 odb/source-inmemory.c         |  3 ++-
 odb/source-loose.c            | 16 +++++++++++-----
 odb/source-packed.c           | 34 ++++++++++++++++++++++++++--------
 odb/source.h                  | 16 +++++++++++++---
 packfile.c                    |  2 +-
 t/unit-tests/u-odb-inmemory.c |  4 ++--
 9 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 10c2471024..399acd0f22 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1759,7 +1759,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct odb_source *source = the_repository->objects->sources->next;
 		for (; source; source = source->next) {
 			struct odb_source_files *files = odb_source_files_downcast(source);
-			if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
+			if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
 				return 0;
 		}
 	}
@@ -4171,7 +4171,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 
 			for (; !found && source; source = source->next) {
 				struct odb_source_files *files = odb_source_files_downcast(source);
-				if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
+				if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
 					found = 1;
 			}
 
@@ -4637,7 +4637,7 @@ static int force_object_loose(struct odb_source *source,
 
 	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
 		struct odb_source_files *files = odb_source_files_downcast(s);
-		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
+		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
 			return 0;
 	}
 
diff --git a/odb.c b/odb.c
index caf1d0f542..6cb0a9534b 100644
--- a/odb.c
+++ b/odb.c
@@ -560,7 +560,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	if (is_null_oid(real))
 		return -1;
 
-	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags))
+	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
 		return 0;
 
 	odb_prepare_alternates(odb);
@@ -569,7 +569,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		struct odb_source *source;
 
 		for (source = odb->sources; source; source = source->next)
-			if (!odb_source_read_object_info(source, real, oi, flags))
+			if (!odb_source_read_object_info(source, real, oi, flags, NULL))
 				return 0;
 
 		/*
@@ -580,7 +580,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		if (!(flags & OBJECT_INFO_QUICK)) {
 			for (source = odb->sources; source; source = source->next)
 				if (!odb_source_read_object_info(source, real, oi,
-								 flags | OBJECT_INFO_SECOND_READ))
+								 flags | OBJECT_INFO_SECOND_READ,
+								 NULL))
 					return 0;
 		}
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 1124a18091..4727670e4d 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -62,16 +62,19 @@ static void odb_source_files_prepare(struct odb_source *source,
 static int odb_source_files_read_object_info(struct odb_source *source,
 					     const struct object_id *oid,
 					     struct object_info *oi,
-					     enum object_info_flags flags)
+					     enum object_info_flags flags,
+					     struct strbuf *errmsg)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	int ret_packed, ret_loose;
 
-	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
+	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi,
+						 flags, errmsg);
 	if (!ret_packed)
 		return 0;
 
-	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
+	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi,
+						 flags, ret_packed < 0 ? NULL : errmsg);
 	if (!ret_loose)
 		return 0;
 
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 57183daf4d..a14d6daeda 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -59,7 +59,8 @@ static void populate_object_info(struct odb_source_inmemory *source,
 static int odb_source_inmemory_read_object_info(struct odb_source *source,
 						const struct object_id *oid,
 						struct object_info *oi,
-						enum object_info_flags flags UNUSED)
+						enum object_info_flags flags UNUSED,
+						struct strbuf *errmsg UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	const struct inmemory_object *object;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index e786560ad1..3cee012a6d 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -67,7 +67,8 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 				      const char *path,
 				      const struct object_id *oid,
 				      struct object_info *oi,
-				      enum object_info_flags flags)
+				      enum object_info_flags flags,
+				      struct strbuf *errmsg)
 {
 	int ret;
 	int fd;
@@ -191,6 +192,10 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	ret = 0;
 
 out:
+	if (ret < 0 && errmsg)
+		strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
+			    oid_to_hex(oid), path);
+
 	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(oid), path);
@@ -216,7 +221,8 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 static int odb_source_loose_read_object_info(struct odb_source *source,
 					     const struct object_id *oid,
 					     struct object_info *oi,
-					     enum object_info_flags flags)
+					     enum object_info_flags flags,
+					     struct strbuf *errmsg)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	static struct strbuf buf = STRBUF_INIT;
@@ -231,7 +237,7 @@ static int odb_source_loose_read_object_info(struct odb_source *source,
 		return 1;
 
 	odb_loose_path(loose, &buf, oid);
-	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
+	return read_object_info_from_path(loose, buf.buf, oid, oi, flags, errmsg);
 }
 
 /*
@@ -428,7 +434,7 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 	if (data->request) {
 		struct object_info oi = *data->request;
 
-		if (read_object_info_from_path(data->loose, path, oid, &oi, 0))
+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0, NULL))
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
@@ -446,7 +452,7 @@ static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
 		struct object_info oi = *data->request;
 
 		if (odb_source_read_object_info(&data->loose->base,
-						oid, &oi, 0))
+						oid, &oi, 0, NULL))
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 50e9be3b4c..bcd040aeb6 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -2,7 +2,9 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "dir.h"
+#include "gettext.h"
 #include "git-zlib.h"
+#include "hex.h"
 #include "list-objects-filter-options.h"
 #include "mergesort.h"
 #include "midx.h"
@@ -10,6 +12,7 @@
 #include "odb/streaming.h"
 #include "packfile.h"
 #include "pack-bitmap.h"
+#include "strbuf.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
@@ -38,7 +41,8 @@ static int find_pack_entry(struct odb_source_packed *store,
 static int odb_source_packed_read_object_info(struct odb_source *source,
 					      const struct object_id *oid,
 					      struct object_info *oi,
-					      enum object_info_flags flags)
+					      enum object_info_flags flags,
+					      struct strbuf *errmsg)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 	struct packed_git *bad_pack = NULL;
@@ -60,25 +64,39 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 		 * corresponding pack entries are skipped. Report the object
 		 * as corrupt instead of as missing in that case.
 		 */
-		if (bad_pack)
-			return -1;
-		return 1;
+		if (bad_pack) {
+			ret = -1;
+			goto out;
+		}
+
+		ret = 1;
+		goto out;
 	}
 
 	/*
 	 * We know that the caller doesn't actually need the
 	 * information below, so return early.
 	 */
-	if (!oi)
-		return 0;
+	if (!oi) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = packed_object_info(packed, e.p, e.offset, oi);
 	if (ret < 0) {
+		bad_pack = e.p;
 		mark_bad_packed_object(e.p, oid);
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	if (bad_pack && errmsg)
+		strbuf_addf(errmsg, _("packed object %s (stored in %s) is corrupt"),
+			    oid_to_hex(oid), bad_pack->pack_name);
+
+	return ret;
 }
 
 static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
diff --git a/odb/source.h b/odb/source.h
index 4ae6cc160e..2b39f06166 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -27,6 +27,7 @@ enum odb_source_type {
 
 struct object_id;
 struct odb_read_stream;
+struct strbuf;
 struct strvec;
 
 /*
@@ -121,11 +122,16 @@ struct odb_source {
 	 *   - A negative value in case the object exists in this source, but
 	 *     reading its object info has failed, for example because its
 	 *     on-disk state is corrupt.
+	 *
+	 * In case reading the object has failed and `errmsg` is non-NULL, the
+	 * callback is expected to populate it with a human-readable message
+	 * that describes the failure.
 	 */
 	int (*read_object_info)(struct odb_source *source,
 				const struct object_id *oid,
 				struct object_info *oi,
-				enum object_info_flags flags);
+				enum object_info_flags flags,
+				struct strbuf *errmsg);
 
 	/*
 	 * This callback is expected to create a new read stream that can be
@@ -352,13 +358,17 @@ static inline void odb_source_prepare(struct odb_source *source,
  * Returns 0 on success, a positive value in case the object is missing in the
  * source and a negative value in case the object exists, but reading it has
  * failed.
+ *
+ * In case reading the object has failed and `errmsg` is non-NULL it will be
+ * populated with a human-readable message that describes the failure.
  */
 static inline int odb_source_read_object_info(struct odb_source *source,
 					      const struct object_id *oid,
 					      struct object_info *oi,
-					      enum object_info_flags flags)
+					      enum object_info_flags flags,
+					      struct strbuf *errmsg)
 {
-	return source->read_object_info(source, oid, oi, flags);
+	return source->read_object_info(source, oid, oi, flags, errmsg);
 }
 
 /*
diff --git a/packfile.c b/packfile.c
index 34e2f9bb8b..3cde39a01c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1945,7 +1945,7 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0))
+		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0, NULL))
 			return 1;
 	}
 
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 93b3f38dab..102fc8db2f 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -29,7 +29,7 @@ static void cl_assert_object_info(struct odb_source_inmemory *source,
 		.contentp = &actual_content,
 	};
 
-	cl_must_pass(odb_source_read_object_info(&source->base, oid, &oi, 0));
+	cl_must_pass(odb_source_read_object_info(&source->base, oid, &oi, 0, NULL));
 	cl_assert_equal_u(actual_size, strlen(expected_content));
 	cl_assert_equal_u(actual_type, expected_type);
 	cl_assert_equal_s((char *) actual_content, expected_content);
@@ -72,7 +72,7 @@ void test_odb_inmemory__read_missing_object(void)
 	const char *end;
 
 	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
-	cl_assert(odb_source_read_object_info(&source->base, &oid, NULL, 0) > 0);
+	cl_assert(odb_source_read_object_info(&source->base, &oid, NULL, 0, NULL) > 0);
 
 	odb_source_free(&source->base);
 }

-- 
2.55.0.822.g20453c30eb.dirty

