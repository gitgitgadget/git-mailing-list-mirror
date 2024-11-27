Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62478193432
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750554; cv=none; b=lRlxQmHM7kFWS8vq7tx92g8vL+z9YBbiiSeb7D+cIbt2Kl51F4v3h6140gDp4BNfh38bzrubV7DKKmCZgl4Ogpl3NC5J5AK5jNCrih+RjwLlGCNRGMJvwK+DXCrR3hPfbBmid3bnKP7i3QRocJdoUXp7HY8+26tR0l5lEhM5+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750554; c=relaxed/simple;
	bh=wtw4IqE1Bvc2CzKKYsqjndJA50WqpmlP+DG+nS8iZ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=US7EJwk3kPGjgtVI/wPtNYLoXQbeweXvMxiYhFymypcnZ4IYQvg4reiDmzQM4EfaPkAoHQXUkDR4o0BTNjxCiMQ2BfXT8yawTNL7WQNKALMwF+rAHGPhkyVC65s0ccptQ8TQ6bWl2TjzmYcdpPQ3RwYxHcKDS+o2yD53WSo9syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+KG+yyZ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+KG+yyZ"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f1f5075cf2so155054eaf.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 15:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732750551; x=1733355351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhauHutODHFANCW4hs0xz+fYr1BuPMFJVuyibdfT4/A=;
        b=D+KG+yyZhBDSYRyuxHFfqVeD/FdYPTi1XaaYoW4D8xS40lzvrNGPw+qzqzfgGxo2cG
         yJdJdpMCcgqFG7x7fGpcXWlC3NmIXVdPEaihScnGngJ5cUpkHlB3gzwrdlhw1nLzj7Bz
         9aI8l+39fK39AAd31wxYtfcobCRHMfMEtj7AkgO1zd/JgwoRnH9rLKga4cg7nRIxBf1w
         8LUsBClLkrbzIWmXKTbtkJ0UypP6MQpvwpGA4dNnsk6dG4NsZrY304WErD/gyWIFgBeP
         ePGhQS6+yEgU8Ek1uBs6/LeL+/w0TzTv9mLwcl5EvFm7T7wVr6+RQDeHXBJqK/fhgBy3
         Wu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732750551; x=1733355351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhauHutODHFANCW4hs0xz+fYr1BuPMFJVuyibdfT4/A=;
        b=Ux2Oux82s1AWlVi9rc0X5kLAaOvzedwA19rL2k42JopS+fTV1yQJ6FeWeKzXYmNJbz
         73GF7KSeT/ILi5x1Xm33mdG5Nk2C7SWLlVFnqaGIDwrXpXm500CoPenPe81EEE4n38so
         Jz5U2OWQWw1fkT8quW9DCeRd1dYpIWCszVzSByKUlz5kjjm+c+lIqeqkS9godDjFkufr
         uEl46LLmiElakf+exUgBDmgEMA8DVP73YcuyyWAp2+KfXiVlqgaeDw/0qzcoWV7LipWN
         Z3eRISEoKpH3A8qoKVrpbRmwHG4NdW8GGnA+8s9xmpPK5+8tUIlgJTSAAWbzdr77M3vc
         0VEw==
X-Gm-Message-State: AOJu0Yzm7IIwSPrvr6D/OyORXBnELte8Xs688QPxMDBJh2MB3g6bfXn9
	1+FnOPXlSuKFDNIX2syVj+65vS9+zrTaFNs6yM0Y+F/rVKnefbm3SrNQEQ==
X-Gm-Gg: ASbGncsreaa/EntGrodA9DP+bf/c5PPKVgHR+5WGYIUlNCpqWYNtxle0Hnpt1lNdGoR
	Ksz8sgGX4+oFyVxJCBQrXxboVCPoXr8dmu3WQrPzioaLZLCFmsA2S9q2cb+UQSLlahmmVJESTS8
	yIZAhRV2JDyKh84KO6fDXyunSZzzvLIRTvDTW6SNjY0hIarTqld3Yv21iuj32QZxPYbSOln/JDE
	/z2Dw8x/mPcQmoWgKT9IXLF9WQIGAb1gGxqTNCgVwYj2YnYSKv/h6CWVw==
X-Google-Smtp-Source: AGHT+IEx72VZbH0Qiucj5oYTgMcTwYCcA5zSwPN/VUK3R88Sg10FpOJG12hcTWxM/t6rCY68L5HYpg==
X-Received: by 2002:a05:6830:4114:b0:71d:5f65:ce2f with SMTP id 46e09a7af769-71d65cfa6a7mr4109560a34.22.1732750551207;
        Wed, 27 Nov 2024 15:35:51 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de8f31cefsm109260fac.2.2024.11.27.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:35:50 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/4] bundle: add bundle verification options type
Date: Wed, 27 Nov 2024 17:33:09 -0600
Message-ID: <20241127233312.27710-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127233312.27710-1-jltobler@gmail.com>
References: <20241127005707.319881-1-jltobler@gmail.com>
 <20241127233312.27710-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `unbundle()` is invoked, fsck verification may be configured by
passing the `VERIFY_BUNDLE_FSCK` flag. This mechanism allows fsck checks
on the bundle to be enabled or disabled entirely. To facilitate more
fine-grained fsck configuration, additional context must be provided to
`unbundle()`.

Introduce the `unbundle_opts` type, which wraps the existing
`verify_bundle_flags`, to facilitate future extension of `unbundle()`
configuration. Also update `unbundle()` and its call sites to accept
this new options type instead of the flags directly. The end behavior is
functionally the same, but allows for the set of configurable options to
be extended. This is leveraged in a subsequent commit to enable fsck
message severity configuration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/bundle.c |  2 +-
 bundle-uri.c     |  7 +++++--
 bundle.c         |  6 +++++-
 bundle.h         | 10 +++++++---
 transport.c      |  6 ++++--
 5 files changed, 22 insertions(+), 9 deletions(-)

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
index 0df66e2872..cdf9e4f9e1 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -367,6 +367,10 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	struct string_list_item *refname;
 	struct strbuf bundle_ref = STRBUF_INIT;
 	size_t bundle_prefix_len;
+	struct unbundle_opts opts = {
+		.flags = VERIFY_BUNDLE_QUIET |
+			 (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0),
+	};
 
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
index 4773b51eb1..485033ea3f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -628,9 +628,13 @@ int create_bundle(struct repository *r, const char *path,
 
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags)
+	     struct unbundle_opts *opts)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+	enum verify_bundle_flags flags = 0;
+
+	if (opts)
+		flags = opts->flags;
 
 	if (verify_bundle(r, header, flags))
 		return -1;
diff --git a/bundle.h b/bundle.h
index 5ccc9a061a..6a09cc7bfb 100644
--- a/bundle.h
+++ b/bundle.h
@@ -39,6 +39,10 @@ enum verify_bundle_flags {
 int verify_bundle(struct repository *r, struct bundle_header *header,
 		  enum verify_bundle_flags flags);
 
+struct unbundle_opts {
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
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags);
+	     struct unbundle_opts *opts);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 47fda6a773..8536b14181 100644
--- a/transport.c
+++ b/transport.c
@@ -176,6 +176,9 @@ static int fetch_refs_from_bundle(struct transport *transport,
 				  int nr_heads UNUSED,
 				  struct ref **to_fetch UNUSED)
 {
+	struct unbundle_opts opts = {
+		.flags = fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0,
+	};
 	struct bundle_transport_data *data = transport->data;
 	struct strvec extra_index_pack_args = STRVEC_INIT;
 	int ret;
@@ -186,8 +189,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args,
-		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
+		       &extra_index_pack_args, &opts);
 	transport->hash_algo = data->header.hash_algo;
 
 	strvec_clear(&extra_index_pack_args);
-- 
2.47.0

