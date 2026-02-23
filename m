Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306B3033F7
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863538; cv=none; b=RvzU+e8whQJ+7SgXyxuEUT7SAFAwGpxs+mFAhm1l80d2Vs7R1PfTpZubV0AnldCJTUozC2uQd0pxqMmA72yIZJEilR1ZbaaSN0VWkDQH9YJtPZFBJSA9mKQLrt2EVOKL6v74rVKAq94dcoOLHlXH8gg9CxV+RNbj0PL5uPSWOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863538; c=relaxed/simple;
	bh=yB4ZaXNcDKHxRfcmHcNtjkXq/3Ash0XrCMvSfJaMOLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LX0fB4vrV7atlY5Uwzk7QyxSOV6HiJoOWFgrq89CSTqIe/m0Brf0GFTYIF2rcRShjJurvyCPyAyXNXvWlV+hqAV1QZXhPyJyJX7c/3tnQ/V7lgENly6gcb2RerviXArSBuokvU+UibqKDIIhDTUe35hJP60eWfyve5Ta+l/rW28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxcJgQDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkaJMV9k; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxcJgQDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkaJMV9k"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 604A114001BB
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 23 Feb 2026 11:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863530;
	 x=1771949930; bh=jIqykRtTZbc4CrjaL0ZH3LjC8woI8/5genn4AxsZVGo=; b=
	GxcJgQDwHQKj9vGuB42HqgiNEv+Pv+wCq5fsko/fKnQrFlKJJ4TkCByh+E5A3Rzd
	wKCZW0EKpAyRaua87tmZV3j+fimxkubvLWnlq2Q0J7+nsgKgzdknYyb/5PKQZ/Qf
	Rhr7Y9LJa0L373SPWSeaDMUW40Qnier+rGg9QCRN5zJ0l1ULDokV6c5HGatK7CvW
	t+XZuO1VPXObYkn8gFldGVwJXvJd53ikwOHQ6iwT8e64AeIh7rVkRK09s9W2mcaV
	A0aT8YxLto9eFVSNi95xb3BuoLmDQrfRwzvbGE5Wqp/b9/hT6g+n5eatNF8dgdxm
	7MsGTYzrTb4JXqOT4mB63g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863530; x=
	1771949930; bh=jIqykRtTZbc4CrjaL0ZH3LjC8woI8/5genn4AxsZVGo=; b=O
	kaJMV9kpdOCiOjNtFBAumuJC0JZ9iP3UIxeBr+up04b7TBAJQZtIV+wAAYkpnCHU
	2Dp0PQq1dGz593MPOsU9x2OsrQ5AxIY0OQhnNOQxhwO4tkTty5WBk9FQWqMhEwNp
	tPRo4KZ2bBMQuhZWaqTAuLIr21ymTRTtb8A3lM7A6RA+Ye7N7i0zuNaNIwDazP9t
	fSavUWkUZe5Ql1xSkMP1H1xlkkmwtArtx0g3atRPTYT7D3ELEd2vQAnei9hAFHJE
	XFafYtz8C59jiXN7G8I5SWwdV1CqHcaN/v2H8RK2BudVZVasU/wFtd1CxaP6rqWA
	ueS7aaDNiAEq9z3Mj5TAA==
X-ME-Sender: <xms:6n2cabTVRXUTbMZyCyN0av_z4yv7sxeNhPf5XljsaY9cCvOpGvGffg>
    <xme:6n2caTvKS23wbq-LQjKDNVgDF8hI7tEi_cYI2YU_NgcKtoneW9i0cZE8dMZUzZHxT
    8kaepDwSoFFppOiBkjkSshS8wfHJhEZg_4xP72wuOyPXnxSBtT8>
X-ME-Received: <xmr:6n2caWeIfLVhuPzPPGz0u25G3Im6JA02xq8VaobGn290FZdtWRk49dT9RJP5mk6Unl_VUslZDlldVYTDvdAh0UiK5-1366J_TY9UyCD2nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:6n2caQIf_KH50Ew0LnChGAbFqar6Y4Ult7Qc-cMlNfzp5MI82htqLA>
    <xmx:6n2caUb1MW89pX6FXc_ISzurew6OaFrlHua1SFQvpYVHSmrybE0gJQ>
    <xmx:6n2cabs_1cxdBzoklAa_z58LvHDE3mX5jINJpAVfdJoRHxhmig2T9w>
    <xmx:6n2caRsuccfzuVwRIhYwwAtbRbYFqrvLJhUW0vCgJyj3PCBU6WE5yQ>
    <xmx:6n2cafQyHkgwaDhkEpFIkLCKmGYpvVTO8WQ4M6hpFT6ux6224OF7JVft>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdfc6d49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:06 +0100
Subject: [PATCH 15/17] odb/source: make `read_alternates()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-15-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 26 ++++----------------------
 odb.h              |  5 +++++
 odb/source-files.c | 22 ++++++++++++++++++++++
 odb/source.h       | 29 +++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/odb.c b/odb.c
index f439de9db2..d9424cdfd0 100644
--- a/odb.c
+++ b/odb.c
@@ -131,10 +131,10 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
 	return usable;
 }
 
-static void parse_alternates(const char *string,
-			     int sep,
-			     const char *relative_base,
-			     struct strvec *out)
+void parse_alternates(const char *string,
+		      int sep,
+		      const char *relative_base,
+		      struct strvec *out)
 {
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
@@ -198,24 +198,6 @@ static void parse_alternates(const char *string,
 	strbuf_release(&buf);
 }
 
-static void odb_source_read_alternates(struct odb_source *source,
-				       struct strvec *out)
-{
-	struct strbuf buf = STRBUF_INIT;
-	char *path;
-
-	path = xstrfmt("%s/info/alternates", source->path);
-	if (strbuf_read_file(&buf, path, 1024) < 0) {
-		warn_on_fopen_errors(path);
-		free(path);
-		return;
-	}
-	parse_alternates(buf.buf, '\n', source->path, out);
-
-	strbuf_release(&buf);
-	free(path);
-}
-
 static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
 							const char *source,
 							int depth)
diff --git a/odb.h b/odb.h
index 692d9029ef..86e0365c24 100644
--- a/odb.h
+++ b/odb.h
@@ -500,4 +500,9 @@ int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
 			    struct object_id *oid);
 
+void parse_alternates(const char *string,
+		      int sep,
+		      const char *relative_base,
+		      struct strvec *out);
+
 #endif /* ODB_H */
diff --git a/odb/source-files.c b/odb/source-files.c
index b8844f11b7..199c55cfa4 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -2,9 +2,11 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "object-file.h"
+#include "odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "packfile.h"
+#include "strbuf.h"
 
 static void odb_source_files_reparent(const char *name UNUSED,
 				      const char *old_cwd,
@@ -117,6 +119,25 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 	return odb_source_loose_write_stream(source, stream, len, oid);
 }
 
+static int odb_source_files_read_alternates(struct odb_source *source,
+					    struct strvec *out)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
+
+	path = xstrfmt("%s/info/alternates", source->path);
+	if (strbuf_read_file(&buf, path, 1024) < 0) {
+		warn_on_fopen_errors(path);
+		free(path);
+		return 0;
+	}
+	parse_alternates(buf.buf, '\n', source->path, out);
+
+	strbuf_release(&buf);
+	free(path);
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -137,6 +158,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.freshen_object = odb_source_files_freshen_object;
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
+	files->base.read_alternates = odb_source_files_read_alternates;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index ddce43eb20..14f5d56f68 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -55,6 +55,7 @@ struct object_id;
 struct object_info;
 struct odb_read_stream;
 struct odb_write_stream;
+struct strvec;
 
 /*
  * A callback function that can be used to iterate through objects. If given,
@@ -229,6 +230,20 @@ struct odb_source {
 	int (*write_object_stream)(struct odb_source *source,
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
+
+	/*
+	 * This callback is expected to read the list of alternate object
+	 * database sources connected to it and write them into the `strvec`.
+	 *
+	 * The format is expected to follow the "objectStorage" extension
+	 * format with `(backend://)?payload` syntax. If the payload contains
+	 * paths, these paths must be resolved to absolute paths.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 */
+	int (*read_alternates)(struct odb_source *source,
+			       struct strvec *out);
 };
 
 /*
@@ -379,4 +394,18 @@ static inline int odb_source_write_object_stream(struct odb_source *source,
 	return source->write_object_stream(source, stream, len, oid);
 }
 
+/*
+ * Read the list of alternative object database sources from the given backend
+ * and populate the `strvec` with them. The listing is not recursive -- that
+ * is, if any of the yielded alternate sources has alternates itself, those
+ * will not be yielded as part of this function call.
+ *
+ * Return 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_read_alternates(struct odb_source *source,
+					     struct strvec *out)
+{
+	return source->read_alternates(source, out);
+}
+
 #endif

-- 
2.53.0.536.g309c995771.dirty

