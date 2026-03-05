Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623021E091
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720431; cv=none; b=Z762Wn+W+wOw9PX9oaSrIOypPl/+uFj5PHpuY+nRaRYOaoGUTQ06aywHKZvbyxnZEmZcB5Ff1dIU/+aRnps/hDbvaOwJoCIF5s+3c3OKkPkn56pB6odaGP7wdOVljkM9e+nZ2tD8sDwZzT3AU+7kS9sHW+4Rd/4Dr/FNUxkM8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720431; c=relaxed/simple;
	bh=KW2tk+w3dhpG1FRajL7kY1mzi8Q3s51MuXALSqUL73A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3pmJD45FoPhAqrNq/rzsEfuu6BaKQYz8aXpp5RVseMGDmYdzj2yMUK1o3nkmsMJ/kDn8YpOjROrCD08Rc8PIA09h93c6qA1bC0U2CLrTaZCuvN2sZQQJljhkiuRooBxn4f2tC/8NSxUnJ7/q+YEZGpkL67mJwdhhvxGVOOWdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g+RcWqzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZHQoa+y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g+RcWqzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZHQoa+y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF0247A0017;
	Thu,  5 Mar 2026 09:20:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 09:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720429;
	 x=1772806829; bh=8/PkWt8xZbzEjP5jeSHG5SMxB4YIo2zQQcnRA4EKNHE=; b=
	g+RcWqzZaXUliwQLtAxQ33zLcYrDD2sj9e9M1uSl0NZKXOtyP61eeTE1Bhlc/rBf
	DqJV2syfz1e4NlTYZtnnf8hciwxC66v08dacGL4EY+BHsBk+Xv1lMY1CCMwWjW7Z
	zOvAbzy8f++cDEZhjODa5L2jWVKHPtFKiYYPI5fVV76NnvMvfzrbw+jrXyFJk5qv
	8zx2K7zSeDscf3hlSe6TbzjLSsT3XeJKKlH216e3aLQpP/ri4gLG2zvfA94V5XJh
	iz2UExXPLdiLhS3vsKwU2ygYXCWHIYr+chKRQO3s75HZtYUl6gLmVEVs/f8P1Gqh
	bwwzURz/Q+rzp2O/UE6RMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720429; x=
	1772806829; bh=8/PkWt8xZbzEjP5jeSHG5SMxB4YIo2zQQcnRA4EKNHE=; b=j
	ZHQoa+yPWmpxJae7WlH1G2FNIZQr2jJp3LZxJ9jYhjWfLliZSvgmbvieeEau8u/Y
	DCCYt22fAz1GzRP1Mum4lI5g8ZwbXgZiGs2uOz4j6HSDwFSkFoCVNDHcn13ub1LM
	VR0GFarh7tQs0qzGudFAqc5UP1jgacX42Sxgco+C7Hm/aCAgoPngkE2UPUsFnOAP
	/IXlyfBN/0XKjMkAgudjynJBhAtXumsY2EYPwuU0+KbWOjmmTEc3RkUD58Antyz0
	M3qcxDTN6dfUjtL2VsaL9R7MDYVWhtS5eCmFJtQVZItWSRVC90a1J/Hzca561I9Q
	03HaJg7wsSSZhDI6MOiJA==
X-ME-Sender: <xms:LZGpaai7r1zxmSXTwoyBhgN8EArzMnko8WaNEXqGp9fIMz9FK2b4wQ>
    <xme:LZGpaSCXemvYZF3KruC_AF__DCxcx8xVzFHmJAf7i_JbtVs9hxAJlt0-LZ1pgwg7J
    6v4Y4Uwh458YHrOeo0bNPmb_wL3UokQre5sFvlJH0_zWL9kaI8cWw>
X-ME-Received: <xmr:LZGpaXEmY2YDxA7B6XEYha5du2IdK5A20BLPN7DCYkc-FHDEBwOYvXYVIKdAKHUfNiMDnY7YiZYiSMccJU3Mib2BtXbgVnnU_fc2-7Rq3LFD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LZGpaSLyDPTzlsBV7PEbe6a6uADOVOHc34YpfaKZkPZc5TOlYbdbNQ>
    <xmx:LZGpaTnapuv_A3TsbZhAKHyaop68ZoDoTtzYRAgRNUbbI5TEjtKhUA>
    <xmx:LZGpaSRuPCcrxSVNNuj9kLTui1hItiX0THfrfYAhuJBwB7on-99b-A>
    <xmx:LZGpadJQyki-PjhJ4fWjsqfeqiD7JT8GBZ_AB3G-6hZ4mfLUspPOug>
    <xmx:LZGpaelj-_4T4hqugp_zojWMJu-XMXq5XHJjsJ22f54nGGpgqpoGa0wP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f61f2333 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:55 +0100
Subject: [PATCH v2 15/17] odb/source: make `read_alternates()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-15-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 26 ++++----------------------
 odb.h              |  5 +++++
 odb/source-files.c | 22 ++++++++++++++++++++++
 odb/source.h       | 28 ++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 22 deletions(-)

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
index 6c8bec1912..fbdddcb2eb 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -54,6 +54,7 @@ struct object_id;
 struct object_info;
 struct odb_read_stream;
 struct odb_write_stream;
+struct strvec;
 
 /*
  * A callback function that can be used to iterate through objects. If given,
@@ -231,6 +232,19 @@ struct odb_source {
 	int (*write_object_stream)(struct odb_source *source,
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
+
+	/*
+	 * This callback is expected to read the list of alternate object
+	 * database sources connected to it and write them into the `strvec`.
+	 *
+	 * The result is expected to be paths to the alternates. All paths must
+	 * be resolved to absolute paths.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 */
+	int (*read_alternates)(struct odb_source *source,
+			       struct strvec *out);
 };
 
 /*
@@ -384,4 +398,18 @@ static inline int odb_source_write_object_stream(struct odb_source *source,
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
2.53.0.797.g7842e34a66.dirty

