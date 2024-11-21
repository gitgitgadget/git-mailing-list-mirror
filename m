Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7871C9B76
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221844; cv=none; b=Z4GxESGpiAzVeWessMhPVxRdStI+HxPKoeAE/EcgekFXOWdaLUjEOAyl5mrqmazJWVKYeoOms3EVK5oNWPiW/NGAr2uvDi4GehlA0kwcVQAsNyAezm4rKGSVxzW0bmReXv5qjuM13A7808Zd2tbFequ9sp2SYyPXg6QPfSq2tAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221844; c=relaxed/simple;
	bh=IjFVRAOmo87pEEl1ZPDTdOw04ja2XQ8FrHqIhhoD7Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMtsnFHoOvBInZc/u08/lc8yZWAK7gxFHo7V/mcjDuBW/3bAXwwcedgX07ninKo2EDsBKV0RTCidEqQrh6Beuvz/N5kEIk+2fJomLKRN7dLjwr8x6uP/SD66m9+J72D9Q6TVjel6PsPqt8R+0f5JJkKcr4L5+Z+bHwZVpMwuOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxGDKwHA; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxGDKwHA"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2969bf1680cso737819fac.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221841; x=1732826641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmkEFgbT+6pmf1SQ1MtNnGa5PRZNfhwjV+iVOGrGFaE=;
        b=JxGDKwHAzfR2hVCHRNlIMvevOOC2EhlU+vTT/3ioEF/QTCZbq29umzsjXUEY2+epSJ
         hxZsGIhpBqh84BnmjHe65V2S8UVq7S4BljynEwNsHJzeaG5MLvZ564m5jO/Doe1nego+
         L3CvQogFGkKn0kX6QFbnvqcsq8O3j0Vk2t5APReSBFcNVyH78PDnY83m3tKrAxdvsIfP
         J6bsmiWjR3+mqtyJnQO2z8uTBqPw4GyQiBq7PqsmAxl5iWUlBrXhpFIFADvY7McfuHYD
         aO/eBVz3gx9J/JYgZY+/eI4lG0p639EktvsIumbTAdkKu+hMgo5lPGMAZS0BC9rveyYc
         fApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221841; x=1732826641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmkEFgbT+6pmf1SQ1MtNnGa5PRZNfhwjV+iVOGrGFaE=;
        b=wMybjjjViDxXOIPAaUTMLpQLZAOmO/ABqWi0elX11PljnuLLsT1qirHZp5xk5xd6xO
         vGtCDG5Lqn8b1a6FVlMZ7eG30Qa23KfCaQ6f8SJA+ypq6DR7i4Usi1OqfYIvy03OoIIC
         2X93aIsHYwXD7+XPzjETNKkGDNZo04qXvTU6h9NCH2QvCcVszHr55+qGLxKIBEcEIPM7
         epP1eRQ/frkmg3/wUWKNxRUulSu/jNu5np/XVIJ63q9hfUZUAJrZi1hm4uKA3xnhm7R7
         lIu1Lq0H/jaD/Bi6CktXI+IvSrSFHwuEVFDXMydHwBjtEx+VXMsdvFwkE4TjxqF/ddbA
         PAag==
X-Gm-Message-State: AOJu0Yw8Zs6TUNST3aDjQ/I2WP6repjg976scEv4QrZWGzhOXNgvYXYm
	ZEthFuAgtnGuxJ0rSlXnPRG4RwxcS0PfGRM/pdxbp4qER8FLRkqXP91eKQ==
X-Gm-Gg: ASbGnctRWkjhX7QgJFNKzAQMa7UWyEXxQY1zY4uqbYzqLWPwENjfqvfIfi0iE/PGMbN
	q8JdLKsy3L9SK4JxvCkKPmjcJI7GX/J56uhmegMZjI+1mXmhSQ9aDsR4HdJ6MFiZk0T45uTFbq/
	yuxBEUIyx5qOQtXEEDJ4h3aByc83SnNHQlJyL9GCNs1XXFJICsrQZr3/ihZIjRv2b9zEocHdGgs
	EAMzUmd3aV1i5WKOoiJbJfsui+JnH7Bvmf51DGGy7V02TXG3eWei86POA==
X-Google-Smtp-Source: AGHT+IGq6XlCSbz5Hs0bmppyLwCAt3vBdTlT31IbMgdJ/yo6Zzi/xOFhizzTNEKfUzjHUizrW2Xljw==
X-Received: by 2002:a05:6870:1f08:b0:297:5a2:d560 with SMTP id 586e51a60fabf-2971e2b17eemr483422fac.4.1732221840739;
        Thu, 21 Nov 2024 12:44:00 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d669843sm126481fac.28.2024.11.21.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:44:00 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/5] bundle: add bundle verification options type
Date: Thu, 21 Nov 2024 14:41:15 -0600
Message-ID: <20241121204119.1440773-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121204119.1440773-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bundle verification performed as part of `unbundle()` is configurable
via providing `verify_bundle_flags`. This is done by invoking
`verify_bundle()` and propagating the set flags. If the
`VERIFY_BUNDLE_FSCK` flag is provided, the `fsck-objects` flag is
specified when invoking git-index-pack(1) to perform fsck checks on the
objects in the bundle.

Introduce a new type, `verify_bundle_opts`, and update `unbundle()` to
accept this instead of `verify_bundle_flags` to perform the same
verification configuration. In a subsequent commit, `verify_bundle_opts`
will be extended to support configuration of fsck message severity.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/bundle.c |  2 +-
 bundle-uri.c     | 13 ++++++++-----
 bundle.c         | 14 +++++++++-----
 bundle.h         | 14 +++++++++-----
 transport.c      |  6 ++++--
 5 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 127518c2a8..15ac75ab51 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -218,7 +218,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
 	ret = !!unbundle(the_repository, &header, bundle_fd,
-			 &extra_index_pack_args, 0) ||
+			 &extra_index_pack_args, NULL) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 0df66e2872..ed3afcaeb3 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -361,12 +361,16 @@ static int copy_uri_to_file(const char *filename, const char *uri)
 
 static int unbundle_from_file(struct repository *r, const char *file)
 {
-	int result = 0;
-	int bundle_fd;
+	struct verify_bundle_opts opts = {
+		.flags = VERIFY_BUNDLE_QUIET |
+			 (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0)
+	};
 	struct bundle_header header = BUNDLE_HEADER_INIT;
-	struct string_list_item *refname;
 	struct strbuf bundle_ref = STRBUF_INIT;
+	struct string_list_item *refname;
 	size_t bundle_prefix_len;
+	int result = 0;
+	int bundle_fd;
 
 	bundle_fd = read_bundle_header(file, &header);
 	if (bundle_fd < 0) {
@@ -379,8 +383,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * a reachable ref pointing to the new tips, which will reach
 	 * the prerequisite commits.
 	 */
-	result = unbundle(r, &header, bundle_fd, NULL,
-			  VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0));
+	result = unbundle(r, &header, bundle_fd, NULL, &opts);
 	if (result) {
 		result = 1;
 		goto cleanup;
diff --git a/bundle.c b/bundle.c
index 4773b51eb1..db17f50ee0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -626,13 +626,17 @@ int create_bundle(struct repository *r, const char *path,
 	return ret;
 }
 
-int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags)
+int unbundle(struct repository *r, struct bundle_header *header, int bundle_fd,
+	     struct strvec *extra_index_pack_args,
+	     struct verify_bundle_opts *_opts)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+	struct verify_bundle_opts opts = { 0 };
 
-	if (verify_bundle(r, header, flags))
+	if (_opts)
+		opts = *_opts;
+
+	if (verify_bundle(r, header, opts.flags))
 		return -1;
 
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
@@ -641,7 +645,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
-	if (flags & VERIFY_BUNDLE_FSCK)
+	if (opts.flags & VERIFY_BUNDLE_FSCK)
 		strvec_push(&ip.args, "--fsck-objects");
 
 	if (extra_index_pack_args)
diff --git a/bundle.h b/bundle.h
index 5ccc9a061a..bddf44c267 100644
--- a/bundle.h
+++ b/bundle.h
@@ -39,6 +39,10 @@ enum verify_bundle_flags {
 int verify_bundle(struct repository *r, struct bundle_header *header,
 		  enum verify_bundle_flags flags);
 
+struct verify_bundle_opts {
+	enum verify_bundle_flags flags;
+};
+
 /**
  * Unbundle after reading the header with read_bundle_header().
  *
@@ -49,12 +53,12 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
  * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
  * "extra_index_pack_args" (if any) will be strvec_clear()'d for you.
  *
- * Before unbundling, this method will call verify_bundle() with the
- * given 'flags'.
+ * Before unbundling, this method will call verify_bundle() with 'flags'
+ * provided in 'opts'.
  */
-int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags);
+int unbundle(struct repository *r, struct bundle_header *header, int bundle_fd,
+	     struct strvec *extra_index_pack_args,
+	     struct verify_bundle_opts *opts);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 47fda6a773..7e0ec4adc9 100644
--- a/transport.c
+++ b/transport.c
@@ -176,6 +176,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
 				  int nr_heads UNUSED,
 				  struct ref **to_fetch UNUSED)
 {
+	struct verify_bundle_opts opts = { .flags = fetch_pack_fsck_objects() ?
+							    VERIFY_BUNDLE_FSCK : 0 };
 	struct bundle_transport_data *data = transport->data;
 	struct strvec extra_index_pack_args = STRVEC_INIT;
 	int ret;
@@ -185,9 +187,9 @@ static int fetch_refs_from_bundle(struct transport *transport,
 
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
+
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args,
-		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
+		       &extra_index_pack_args, &opts);
 	transport->hash_algo = data->header.hash_algo;
 
 	strvec_clear(&extra_index_pack_args);
-- 
2.47.0

