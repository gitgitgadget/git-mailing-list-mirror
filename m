Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29393603DF
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165576; cv=none; b=Z8maiHyVFPBsje/z52PoRdPt9P9qCtIA9tR1cFY0RtwDBtyZ7mtCFthsaksamOv39BBowA/OKgbtluuKv1YdDDUTBj4clHxYSq9J0FjQu1xnAg9NMaifj3yFV9TS10xFMKBl3CabFmyuOlt7MttEyDpuIz6jL5k62irxEdSP/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165576; c=relaxed/simple;
	bh=3LDpBNlx012PhTSTw7BiGxnwV1Svnnp9mrWyP7T0/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtsWYdWNz4Lza4Bb1n+1Yr9DhxA6eHYeapdPda2eqQv4vmXoV3rAubVrOJEVYay1vDTs/F8TWFzv/NkkJ7Gmqtw4cbH8r2S1PYnMJGIpL/ampzGhBuERnUoGpsZS96AIAD/b/DWhWXYComiAr76FSrwEiJYv1EMgHZDPGCMrVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZtPinBy; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZtPinBy"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40946982a78so505544fac.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165572; x=1775770372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0yknlD4+yHtCRATnMRf34QbBHGcBLbEWn5tQoWzLpw=;
        b=aZtPinBytIAmukybNPn7a7wSXEd/XjsSH669dmHSaT+CtxCmTy7qXl+1Po4F0TMuE4
         WvUCvXA11xWaKmp942rnqULjZUrw/BuXBcr4KSwkusPMT2XETtUR71iuSbE7EVzIXsbj
         Hs0GHrwW8NBpP2zkyGldYKEaxcmi4l/jUl9QkgFhDMUn7Md1KR1snlkhCiFsl+jRyae2
         mCtbj6BfQaAXJOgp7MWRVVvZ5vNu/CduYRkyob9dZDYYK17saFovqiEkSHFC7i+umQQy
         lGOtIAbps2xRRhVEYy5QDWmgfQmzRcVJd+Qh1+RTWTnGjXfHbFzEH6C6LyzeWiY9mfpJ
         5oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165572; x=1775770372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z0yknlD4+yHtCRATnMRf34QbBHGcBLbEWn5tQoWzLpw=;
        b=CNkJY5yomyBXE4QZG0QdZ8Czm3T7XnvwPjhpCC2W608h5xcV/cW31zQelXfvaUswrI
         SkrsrcOCtWTBsLi0sJv3mn1KVGN7iYOSFCmmdCjIsbYUzJ5UjiGkLoixiwjErdaNvleC
         hF5TnxZnJJvm7tO7nu9xKkLYQ01neuD4/Hx+MYdVH3ICj8znwM7SITYTMEGP+tQ0yzE+
         qlHhcNR78/uERoPEtYr6y0ai8fVJiM10W2aNpYtJe4h6j9KRs4MYNZ1tpelNSAHU9MVi
         jgwb2BnuGYknnCZe66XHA0C+Thq29+0nVXyaVXk6e21LtqrwivvVQ3n2c5Z2sBmCZQQI
         VwbA==
X-Gm-Message-State: AOJu0YyBlth1y0mQyohUS+eivjGR7q3IaPnfveH00lkPn0EiRdUvWA6P
	tCB13i/Rh205Y/DNqPxGDQJl+FpD6mrC3OJTokMRp6JL9YfhxoAYy9JU/V4vbg==
X-Gm-Gg: ATEYQzyS9psIewWKT7piZRv0TdHnckUujEtjsycAQ8dupVtcnW4g0MO2mk7O1h2hV6a
	mV4lovBawR8k+lGZMhedggA/CABoQn28SJIvXv+d9jqWUbBmz4jt9G+L5HLj2x7sQJ3tiz5pdfq
	/u4GV8yw1itP63qWeMVkkYDWhH9tOlQ+t/rH+NHMV5WKRYXXC4PDz/e118E7aHNeuxmr+3xdFYR
	03BmXWokrrpiXuvgbzNJ9WQ30iN+7Oo7NactBEobggVPYakXEUSlGInVZIVACdofShrCdsvUIaa
	Gb5lKr6usdaCceG5oMt9U/bF9Bg/+9NFyGVnuu85l3ZBOJf6G3UveEWSDbiEnLq+XRj4HXSJ7PS
	+LCJ0WgmFV0mvysVWW8FgHomIGfzUC6YJFXlJCyx5CglSIkINrKnJmX8rNvkHWHRYqvaQ1jraPB
	O2BAd9yJIOtD9DoyrLK9o1L5+5UaXXbFc=
X-Received: by 2002:a05:6871:8010:b0:404:15b0:4602 with SMTP id 586e51a60fabf-4230fca76ffmr345307fac.7.1775165572079;
        Thu, 02 Apr 2026 14:32:52 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3325030fac.6.2026.04.02.14.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:32:51 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/7] odb: update `struct odb_write_stream` read() callback
Date: Thu,  2 Apr 2026 16:32:16 -0500
Message-ID: <20260402213220.2651523-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260402213220.2651523-1-jltobler@gmail.com>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `read()` callback used by `struct odb_write_stream` currently
returns a pointer to an internal buffer along with the number of bytes
read. This makes buffer ownership unclear and provides no way to report
errors.

Update the interface to instead require the caller to provide a buffer,
and have the callback return the number of bytes written to it or a
negative value on error. While at it, also move the `struct
odb_write_stream` definition to "odb/streaming.h". Call sites are
updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/unpack-objects.c | 20 ++++++++------------
 object-file.c            | 14 +++++++++++---
 odb.h                    |  6 +-----
 odb/streaming.c          |  5 +++++
 odb/streaming.h          | 18 ++++++++++++++++++
 5 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index bc9b1e047e..64e58e79fd 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "odb/transaction.h"
 #include "object.h"
 #include "delta.h"
@@ -360,24 +361,21 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 
 struct input_zstream_data {
 	git_zstream *zstream;
-	unsigned char buf[8192];
 	int status;
 };
 
-static const void *feed_input_zstream(struct odb_write_stream *in_stream,
-				      unsigned long *readlen)
+static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
+				  unsigned char *buf, size_t buf_len)
 {
 	struct input_zstream_data *data = in_stream->data;
 	git_zstream *zstream = data->zstream;
 	void *in = fill(1);
 
-	if (in_stream->is_finished) {
-		*readlen = 0;
-		return NULL;
-	}
+	if (in_stream->is_finished)
+		return 0;
 
-	zstream->next_out = data->buf;
-	zstream->avail_out = sizeof(data->buf);
+	zstream->next_out = buf;
+	zstream->avail_out = buf_len;
 	zstream->next_in = in;
 	zstream->avail_in = len;
 
@@ -385,9 +383,7 @@ static const void *feed_input_zstream(struct odb_write_stream *in_stream,
 
 	in_stream->is_finished = data->status != Z_OK;
 	use(len - zstream->avail_in);
-	*readlen = sizeof(data->buf) - zstream->avail_out;
-
-	return data->buf;
+	return buf_len - zstream->avail_out;
 }
 
 static void stream_blob(unsigned long size, unsigned nr)
diff --git a/object-file.c b/object-file.c
index bfbb632cf8..0ae36314aa 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1066,6 +1066,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	struct git_hash_ctx c, compat_c;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct strbuf filename = STRBUF_INIT;
+	unsigned char buf[8192];
 	int dirlen;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
@@ -1098,9 +1099,16 @@ int odb_source_loose_write_stream(struct odb_source *source,
 		unsigned char *in0 = stream.next_in;
 
 		if (!stream.avail_in && !in_stream->is_finished) {
-			const void *in = in_stream->read(in_stream, &stream.avail_in);
-			stream.next_in = (void *)in;
-			in0 = (unsigned char *)in;
+			ssize_t read_len = odb_write_stream_read(in_stream, buf,
+								 sizeof(buf));
+			if (read_len < 0) {
+				err = -1;
+				goto cleanup;
+			}
+
+			stream.avail_in = read_len;
+			stream.next_in = buf;
+			in0 = buf;
 			/* All data has been read. */
 			if (in_stream->is_finished)
 				flush = 1;
diff --git a/odb.h b/odb.h
index ec5367b13e..6faeaa0589 100644
--- a/odb.h
+++ b/odb.h
@@ -529,11 +529,7 @@ static inline int odb_write_object(struct object_database *odb,
 	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
 }
 
-struct odb_write_stream {
-	const void *(*read)(struct odb_write_stream *, unsigned long *len);
-	void *data;
-	int is_finished;
-};
+struct odb_write_stream;
 
 int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
diff --git a/odb/streaming.c b/odb/streaming.c
index 5927a12954..a68dd2cbe3 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -232,6 +232,11 @@ struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
 	return st;
 }
 
+ssize_t odb_write_stream_read(struct odb_write_stream *st, void *buf, size_t sz)
+{
+	return st->read(st, buf, sz);
+}
+
 int odb_stream_blob_to_fd(struct object_database *odb,
 			  int fd,
 			  const struct object_id *oid,
diff --git a/odb/streaming.h b/odb/streaming.h
index c7861f7e13..65ced911fe 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -47,6 +47,24 @@ int odb_read_stream_close(struct odb_read_stream *stream);
  */
 ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t len);
 
+/*
+ * A stream that provides an object to be written to the object database without
+ * loading all of it into memory.
+ */
+struct odb_write_stream {
+	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
+	void *data;
+	int is_finished;
+};
+
+/*
+ * Read data from the stream into the buffer. Returns 0 when finished and the
+ * number of bytes read on success. Returns a negative error code in case
+ * reading from the stream fails.
+ */
+ssize_t odb_write_stream_read(struct odb_write_stream *stream, void *buf,
+			      size_t len);
+
 /*
  * Look up the object by its ID and write the full contents to the file
  * descriptor. The object must be a blob, or the function will fail. When
-- 
2.53.0.381.g628a66ccf6

