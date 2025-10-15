Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B130F539
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567379; cv=none; b=TGV7YPaYA2njmUnOvUFAMDTsC+M1Hju+88oEBqFCSMuwmH7PqEPUXKJysO0/dr5xb934HuTecnCJ3PAz98Vhdb2YFlMHePjmIYB30ZvGtIxDBTHmU9EpL+t4nJ1/JLFTyZh686ONKoBjdCAm/kdn88y5y/8uHlekbbEJWjJbthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567379; c=relaxed/simple;
	bh=FcwK+c7FHk4WNp/QDcnNA5PY01OZFr+z/lWu7nmnWDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyBBuugxuYn53bbp3s8bzGutyBXWA3+I4mnXaXsKu/8YmpVLwodlAJS1QHCdxSrxniqvvnCviKn3zEbV29HGe1wpHudhB71MZv2t1N4I9ej0G57Sl7FAAckNULs7k4N6vTtcowfBamJtbLAIhzEGtOQDHil+gb0xJn4iouxRtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mNL3PUeF; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mNL3PUeF"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7814273415aso865777b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567377; x=1761172177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgFDpKd5q82vAd9GdI49kQ+5ondL8IPrhN/hWYkdBnw=;
        b=mNL3PUeFhLY5fcGY9SQZaMMNjIuGBqPjajmKznYrgbZTi/DVLjVRgRKy07aWx1EtZ5
         6w2qDXQ+a7yYcwC8gFZtIVQmK6gRdG7Gj0hZSWs8DiWDuKPyHkMFG0UZGBmUMpuYrJSS
         uuaAKcKWAIL1VIHXz7/I+95iYvZJVzjhA+0G0KNOv6TW0QsI0m6lV8TqGf4LcxXyifVf
         jEBE5eYATnQqvEqK71pqoVPqkv9pY3J7CGF0fKBhC5o1XOtKijK3Z17QTbR6uynbIL8s
         HpTqnRF3ZMDbdrO0mJK/iUAADPRV5ggXxKo2q3VTnUfPkNo6wr5lCHlRdZwyElcVR5hF
         +bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567377; x=1761172177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgFDpKd5q82vAd9GdI49kQ+5ondL8IPrhN/hWYkdBnw=;
        b=twGGUcJUJgFH4kqWgPzrXxrYIhQPPcKS2WWjhaqaES3deZE0yGZgOtG3nkzIK2DV8n
         k4X8ZZsdu3COegtcMYsXuySNfRd0fiYY7hiUw+/D6ch4Xne8F/P77W1tkHYUk5jlInde
         Wgfk9rklFFELcxTZIPowEp67h893STz1KEA2tZ55yn32Zh6dq+pTYG1kM4tGTjfH9kuN
         M3F+WjBi7O2KbP/7m3rCr+HgMX3gefXYiUYF/P7sIbYLMG5lyQnhsaEPnPw4dhEWRzI1
         lnxx8XgvCL6/JrbTItyx36nZxv5LuGiGi/OqaztVZGg+96W3jFNGV9jh43Hh3PC84rqE
         Ctng==
X-Gm-Message-State: AOJu0Yx9JU4W+99w8JUqjVlgpaextrSCTMgQge8BFZ+kJbh3p75+a8ia
	j5JTYSj7RhxIJEqOll2Nxhvkm5WcRJk0xiw1ZEOFMfKOvFkY2YyOYfbkQ7HhkVg6xYW/K1Yw2j1
	LSp1fKogAQgmQ
X-Gm-Gg: ASbGnctfiRbyetwoBThnKt5Ccylp8HRoKC9wnh6hRLAJMB1SnpI7amk5kdSARgfMIA2
	9whDAmKjO9Fwbal+hIFQIsWm9TZWNFitfl0Qi5WpQmBE8LpgmaLNF+9CPj3KrCGWCnrMIoeDlmg
	B5eMfJDEgDKZZY79OX/BEOiU0LFeJxwTg2mXfAdnGju7PueSLn/5Y8lGXvDZBlOw163AoBHVsQS
	qFic0Wu/580KHuGlga7XNEOgz0yTlcwrmdVGL1BcqqUVQ2XnVvQpxxoMRkb1xINTMpEY07lgmVk
	GsPOUjyLpu2sbqEY4uAAfcEgLf6PISEMID1PppKnriC5OcBJkiFXiefKn8S2mTSDOJMPBhtI94G
	MMWRD9Z7b6A3l6Dba6n4V9QH8bWBCuw8aaVkCswpYj63Q2eRr8u4WoIsqM0uuKiPDv/y5/QCRAo
	RhLW3QFfRj3ZKsuosPhxWHUmZXqB4tKBsuTZu8Z/88kP07HQwr/6m6DwLZxUAvthKYd9vU/9bIG
	1N/CcEoKBWsmCk//A==
X-Google-Smtp-Source: AGHT+IHz/P9eTii3FLWzGyIdxXbpKfcImqY4jtVUO9OPfB7B3asuxopstKWP8IZsZ2KTuYYUFYIx1A==
X-Received: by 2002:a05:690c:93:b0:781:5fb1:2619 with SMTP id 00721157ae682-7815fb13736mr40741587b3.69.1760567376991;
        Wed, 15 Oct 2025 15:29:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78290c61527sm2656367b3.7.2025.10.15.15.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:36 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 47/49] repack: move `write_filtered_pack()` out of the
 builtin
Message-ID: <75233450562c585634bafb5a979337ebf5c2010d.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

In a similar fashion as in previous commits, move the function
`write_filtered_pack()` out of the builtin and into its own compilation
unit.

This function is now part of the repack.h API, but implemented in its
own "repack-filtered.c" unit as it is a separate component from other
kinds of repacking operations.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile          |  1 +
 builtin/repack.c  | 46 ------------------------------------------
 meson.build       |  1 +
 repack-filtered.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 repack.h          |  4 ++++
 5 files changed, 57 insertions(+), 46 deletions(-)
 create mode 100644 repack-filtered.c

diff --git a/Makefile b/Makefile
index 4b0a122428..42461ea91f 100644
--- a/Makefile
+++ b/Makefile
@@ -1250,6 +1250,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-filtered.o
 LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-midx.o
 LIB_OBJS += repack-promisor.o
diff --git a/builtin/repack.c b/builtin/repack.c
index 3c6d7e91fd..f65880d8f6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -106,52 +106,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-static int write_filtered_pack(const struct write_pack_opts *opts,
-			       struct existing_packs *existing,
-			       struct string_list *names)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct string_list_item *item;
-	FILE *in;
-	int ret;
-	const char *caret;
-	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
-
-	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
-
-	strvec_push(&cmd.args, "--stdin-packs");
-
-	for_each_string_list_item(item, &existing->kept_packs)
-		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
-
-	cmd.in = -1;
-
-	ret = start_command(&cmd);
-	if (ret)
-		return ret;
-
-	/*
-	 * Here 'names' contains only the pack(s) that were just
-	 * written, which is exactly the packs we want to keep. Also
-	 * 'existing_kept_packs' already contains the packs in
-	 * 'keep_pack_list'.
-	 */
-	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, names)
-		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
-	for_each_string_list_item(item, &existing->non_kept_packs)
-		fprintf(in, "%s.pack\n", item->string);
-	for_each_string_list_item(item, &existing->cruft_packs)
-		fprintf(in, "%s.pack\n", item->string);
-	caret = opts->po_args->pack_kept_objects ? "" : "^";
-	for_each_string_list_item(item, &existing->kept_packs)
-		fprintf(in, "%s%s.pack\n", caret, item->string);
-	fclose(in);
-
-	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
-				       names);
-}
-
 static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 				      struct existing_packs *existing)
 {
diff --git a/meson.build b/meson.build
index 0373d5c454..f5325b5941 100644
--- a/meson.build
+++ b/meson.build
@@ -463,6 +463,7 @@ libgit_sources = [
   'reftable/writer.c',
   'remote.c',
   'repack.c',
+  'repack-filtered.c',
   'repack-geometry.c',
   'repack-midx.c',
   'repack-promisor.c',
diff --git a/repack-filtered.c b/repack-filtered.c
new file mode 100644
index 0000000000..edcf7667c5
--- /dev/null
+++ b/repack-filtered.c
@@ -0,0 +1,51 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "repository.h"
+#include "run-command.h"
+#include "string-list.h"
+
+int write_filtered_pack(const struct write_pack_opts *opts,
+			struct existing_packs *existing,
+			struct string_list *names)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+	const char *caret;
+	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
+
+	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
+
+	strvec_push(&cmd.args, "--stdin-packs");
+
+	for_each_string_list_item(item, &existing->kept_packs)
+		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
+
+	cmd.in = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * Here 'names' contains only the pack(s) that were just
+	 * written, which is exactly the packs we want to keep. Also
+	 * 'existing_kept_packs' already contains the packs in
+	 * 'keep_pack_list'.
+	 */
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, names)
+		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
+	for_each_string_list_item(item, &existing->non_kept_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	for_each_string_list_item(item, &existing->cruft_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	caret = opts->po_args->pack_kept_objects ? "" : "^";
+	for_each_string_list_item(item, &existing->kept_packs)
+		fprintf(in, "%s%s.pack\n", caret, item->string);
+	fclose(in);
+
+	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
+				       names);
+}
diff --git a/repack.h b/repack.h
index 0432379815..c790c90ef8 100644
--- a/repack.h
+++ b/repack.h
@@ -133,4 +133,8 @@ struct repack_write_midx_opts {
 void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
 int write_midx_included_packs(struct repack_write_midx_opts *opts);
 
+int write_filtered_pack(const struct write_pack_opts *opts,
+			struct existing_packs *existing,
+			struct string_list *names);
+
 #endif /* REPACK_H */
-- 
2.51.0.540.ga7423965ad8

