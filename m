Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8D30F553
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567382; cv=none; b=VtyUi/VVDExUFrbMs/OjskeaLnuJTJWwf2OXroVQmU96xYoma1L9icdBbAUmdFbsyCvyzdnsNjAgna9x18f8H67DeKhcLGBmK5smqWQoo6hqtKBlpnuOwjOiep5uFwiSKyTyQ4++wbZk/SlP0t2PIRVish8CXF/KQyzwpUmClXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567382; c=relaxed/simple;
	bh=+FkBG0IgEtPM16mf//D5JM+dMZjMsEDofL8asWJMiL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG13ovfwCcj81khqKXbVaepmRz6b4xnD0WhyxgMLDhfnMt0aSL7KcSKV9zX5+4Op1oUlFLlhvBPXMRFgQdZmnVu1P/uX2cME9YaWls0Iw1cLsylmA+qXkaIH2rP3tB80HoG7C0lLCgvrVPwDR4UgdpRaBGB5PSOMbPpNGPpNDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hcnCUv1v; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hcnCUv1v"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-72e565bf2f0so800407b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567380; x=1761172180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+54FRgV9Qn9mmmN26TqmVV/IOkedHxczIL4n9lL2JfQ=;
        b=hcnCUv1vneRsVMdF6ek585HzcLvZAscSqDl2kO60osTZ2VcdYijgNi2wuKJvKvcUXV
         LsUPBsxl11YqBiqaeEROP0RTn4dM++ABL/7DHPrXqDrD3UBjuLdqJOJIOYof6EsMUFcJ
         FybtytZAGzYqZ7Ld12SeKvWIYhFd8Vr130VmVCiPTNkma9BETn6R9Xau82J+7a0byf3e
         sssrwnkilzW+csIo+AJfh8mWFqQG9sTFbkeYTKn2tKI0GMCbgtW5w6RTI1SGPPA1ekMH
         OG7JD8tRqKNVPeBQj7+GlSNV+ao3lCw/DC0AbUCWaKyPU0jtmDJwqyvXMNcpR6jOnQhw
         tkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567380; x=1761172180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+54FRgV9Qn9mmmN26TqmVV/IOkedHxczIL4n9lL2JfQ=;
        b=Z5k81KDrHX/n04p5MxaJPmsOqKZhTm3GS7LZ9Ctfxvd0WrQuEJzbhsqvMCSt9SOlhs
         kqGAXS9lHutb65Ai8QsU2Y/LN/93aoS82MUZGZvEX6BfvWoKNBRda9SarPpKKnjgTk7l
         tvetemeotIrOTjmOg6msnTe52//bLZ/Jmu0/eni4botfgxojF+j6TiEvui+xgeddF9g2
         uTN3+eFiZPKU+pjmWe4ilQq5lmjOYhJgYUNiVg0ATKFbP5i6OTTUDUE1+xqy/CSTVKIz
         jGBpaHfJApK2JU8AqPvDjSCbc79xzau0DKr2VL7t5YoUq3vbmbykybYeZ+b/Y961GF66
         9iJg==
X-Gm-Message-State: AOJu0YyxCwYf14XXtwGhpxCJEO9nVB1uf+LoeeFc/z4L9b7FtKMuOjlK
	X9FNrXy6qdxVz58y1x/JOeKarV6PoCDh+f5FZgwThMH/6i20M2v5KAovu9f/U0RSkHvTlGoX+jv
	Wjn7hyEH58iMr
X-Gm-Gg: ASbGncvednv0RPyxCkt2yQEzbSDn9+8PPFAn5HQ0CF0jqk0TGEMq+9d6jdDlqz8dbxR
	OuE4YveJEOVhQzfqKYm6CpTrkJJ39wjqBGPnGljHR9fijrRQqd7jw9ncAeE9ujoHcHsG9tWOSU4
	6p+3DKTlcV9ujOp8+3P1a0MD8Yt6OsWtrqViUC0OJj7/uSHZd/Hv6AQd5QEe2MPn/enkblZx/wU
	UNW3qza7UShWpu8cBKhYEXKXiuvEzAzrwfDr+AjfMJujvcLdp/TldbtQHXjzr3TO6KVOyXV6C4M
	B5u+HQ5Ym4U/AnbfiCLtMWnlmz6L4M50pK28qi4JBS76LPHaH59f60mLCq9EWKiwGUk8goXSbSx
	CjYUnq56CpmYR0f7wIH6r9QZi5dX996pboNU43ioOwCg0vyp+/BXI4ie+usQmXj/fAQnw3jEAJN
	AqDjGhWZSjsletEsTS/UBpaoM5FnhyszIbwH9Qxsi31oQ/gnmdf7gIyJYUjC3QuWVKjVSnXE4K6
	kGmSGIB5OgKWOGG+g==
X-Google-Smtp-Source: AGHT+IFwI9FcSjEKtjKz6E5shkUVM8+gosLs6o4XuliLRvtO0xZeQwSuTvZxHQJyF8UN9oY2Im3XGA==
X-Received: by 2002:a05:690c:498b:b0:76b:f6a9:5be5 with SMTP id 00721157ae682-780e150fe61mr344985057b3.32.1760567379820;
        Wed, 15 Oct 2025 15:29:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cf52f27b9sm4261889d50.0.2025.10.15.15.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 48/49] repack: move `write_cruft_pack()` out of the builtin
Message-ID: <567ccd3d3e4e197a0fbf78780470ec4e5773970a.1760567210.git.me@ttaylorr.com>
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

In an identical fashion as the previous commit, move the function
`write_cruft_pack()` into its own compilation unit, and make the
function visible through the repack.h API.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile         |  1 +
 builtin/repack.c | 94 ---------------------------------------------
 meson.build      |  1 +
 repack-cruft.c   | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  6 +++
 5 files changed, 107 insertions(+), 94 deletions(-)
 create mode 100644 repack-cruft.c

diff --git a/Makefile b/Makefile
index 42461ea91f..fb965e6acb 100644
--- a/Makefile
+++ b/Makefile
@@ -1250,6 +1250,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-cruft.o
 LIB_OBJS += repack-filtered.o
 LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-midx.o
diff --git a/builtin/repack.c b/builtin/repack.c
index f65880d8f6..a68c22f605 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -106,100 +106,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
-				      struct existing_packs *existing)
-{
-	struct packfile_store *packs = existing->repo->objects->packfiles;
-	struct packed_git *p;
-	struct strbuf buf = STRBUF_INIT;
-	size_t i;
-
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
-		if (!(p->is_cruft && p->pack_local))
-			continue;
-
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, pack_basename(p));
-		strbuf_strip_suffix(&buf, ".pack");
-
-		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
-			continue;
-
-		if (p->pack_size < combine_cruft_below_size) {
-			fprintf(in, "-%s\n", pack_basename(p));
-		} else {
-			existing_packs_retain_cruft(existing, p);
-			fprintf(in, "%s\n", pack_basename(p));
-		}
-	}
-
-	for (i = 0; i < existing->non_kept_packs.nr; i++)
-		fprintf(in, "-%s.pack\n",
-			existing->non_kept_packs.items[i].string);
-
-	strbuf_release(&buf);
-}
-
-static int write_cruft_pack(const struct write_pack_opts *opts,
-			    const char *cruft_expiration,
-			    unsigned long combine_cruft_below_size,
-			    struct string_list *names,
-			    struct existing_packs *existing)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct string_list_item *item;
-	FILE *in;
-	int ret;
-	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
-
-	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
-
-	strvec_push(&cmd.args, "--cruft");
-	if (cruft_expiration)
-		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
-			     cruft_expiration);
-
-	strvec_push(&cmd.args, "--non-empty");
-
-	cmd.in = -1;
-
-	ret = start_command(&cmd);
-	if (ret)
-		return ret;
-
-	/*
-	 * names has a confusing double use: it both provides the list
-	 * of just-written new packs, and accepts the name of the cruft
-	 * pack we are writing.
-	 *
-	 * By the time it is read here, it contains only the pack(s)
-	 * that were just written, which is exactly the set of packs we
-	 * want to consider kept.
-	 *
-	 * If `--expire-to` is given, the double-use served by `names`
-	 * ensures that the pack written to `--expire-to` excludes any
-	 * objects contained in the cruft pack.
-	 */
-	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, names)
-		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
-	if (combine_cruft_below_size && !cruft_expiration) {
-		combine_small_cruft_packs(in, combine_cruft_below_size,
-					  existing);
-	} else {
-		for_each_string_list_item(item, &existing->non_kept_packs)
-			fprintf(in, "-%s.pack\n", item->string);
-		for_each_string_list_item(item, &existing->cruft_packs)
-			fprintf(in, "-%s.pack\n", item->string);
-	}
-	for_each_string_list_item(item, &existing->kept_packs)
-		fprintf(in, "%s.pack\n", item->string);
-	fclose(in);
-
-	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
-				       names);
-}
-
 int cmd_repack(int argc,
 	       const char **argv,
 	       const char *prefix,
diff --git a/meson.build b/meson.build
index f5325b5941..81a3d5b96a 100644
--- a/meson.build
+++ b/meson.build
@@ -463,6 +463,7 @@ libgit_sources = [
   'reftable/writer.c',
   'remote.c',
   'repack.c',
+  'repack-cruft.c',
   'repack-filtered.c',
   'repack-geometry.c',
   'repack-midx.c',
diff --git a/repack-cruft.c b/repack-cruft.c
new file mode 100644
index 0000000000..c51df36722
--- /dev/null
+++ b/repack-cruft.c
@@ -0,0 +1,99 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "packfile.h"
+#include "repository.h"
+#include "run-command.h"
+
+static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
+				      struct existing_packs *existing)
+{
+	struct packfile_store *packs = existing->repo->objects->packfiles;
+	struct packed_git *p;
+	struct strbuf buf = STRBUF_INIT;
+	size_t i;
+
+	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		if (!(p->is_cruft && p->pack_local))
+			continue;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
+			continue;
+
+		if (p->pack_size < combine_cruft_below_size) {
+			fprintf(in, "-%s\n", pack_basename(p));
+		} else {
+			existing_packs_retain_cruft(existing, p);
+			fprintf(in, "%s\n", pack_basename(p));
+		}
+	}
+
+	for (i = 0; i < existing->non_kept_packs.nr; i++)
+		fprintf(in, "-%s.pack\n",
+			existing->non_kept_packs.items[i].string);
+
+	strbuf_release(&buf);
+}
+
+int write_cruft_pack(const struct write_pack_opts *opts,
+		     const char *cruft_expiration,
+		     unsigned long combine_cruft_below_size,
+		     struct string_list *names,
+		     struct existing_packs *existing)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
+
+	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
+
+	strvec_push(&cmd.args, "--cruft");
+	if (cruft_expiration)
+		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
+			     cruft_expiration);
+
+	strvec_push(&cmd.args, "--non-empty");
+
+	cmd.in = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * names has a confusing double use: it both provides the list
+	 * of just-written new packs, and accepts the name of the cruft
+	 * pack we are writing.
+	 *
+	 * By the time it is read here, it contains only the pack(s)
+	 * that were just written, which is exactly the set of packs we
+	 * want to consider kept.
+	 *
+	 * If `--expire-to` is given, the double-use served by `names`
+	 * ensures that the pack written to `--expire-to` excludes any
+	 * objects contained in the cruft pack.
+	 */
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, names)
+		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
+	if (combine_cruft_below_size && !cruft_expiration) {
+		combine_small_cruft_packs(in, combine_cruft_below_size,
+					  existing);
+	} else {
+		for_each_string_list_item(item, &existing->non_kept_packs)
+			fprintf(in, "-%s.pack\n", item->string);
+		for_each_string_list_item(item, &existing->cruft_packs)
+			fprintf(in, "-%s.pack\n", item->string);
+	}
+	for_each_string_list_item(item, &existing->kept_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	fclose(in);
+
+	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
+				       names);
+}
diff --git a/repack.h b/repack.h
index c790c90ef8..3a688a12ee 100644
--- a/repack.h
+++ b/repack.h
@@ -137,4 +137,10 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
 			struct string_list *names);
 
+int write_cruft_pack(const struct write_pack_opts *opts,
+		     const char *cruft_expiration,
+		     unsigned long combine_cruft_below_size,
+		     struct string_list *names,
+		     struct existing_packs *existing);
+
 #endif /* REPACK_H */
-- 
2.51.0.540.ga7423965ad8

