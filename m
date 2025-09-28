Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD72BDC0C
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097435; cv=none; b=A8Ly5MSqVhMh73FZRCCxCihGmzpSiGJxhjvHn2XYzZYdE4nQPbSFvT36OoWGOIHHdxy/AlxBS3hp0bQz5E+s00nWaWvJt4RIg+AmtSaMOkoTiw3wLyrhI4ZS8f6s6Khh4Rb6oQHkS0+P12IS6r75+lUklaKObj7AFY6A4uAtr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097435; c=relaxed/simple;
	bh=GMVBNanAv9nuTLqas9x9I+9Muhk8YVhT0c1yAMuTdtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2LHCstiaBk0PbYbvVxmQizJLBct7a3EkwKT+86n5AmKLCbKUGuQsFyUDUTkVahFFmRRykvt9vL/H1VE67EPCFO/A9wPkWSNWIk0tkzcaWlhwSGfANEpyowLbXYrFwdA0vvRti1gU/3BaNO5gJEQikbsq6Dr8wKHyn12kiR2O+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=A+1AruCz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="A+1AruCz"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d71bcab69so36554727b3.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097432; x=1759702232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8mhQzCwsUUwWDq6FHEumcNZhMtJjq4x5jibl2M6BSg=;
        b=A+1AruCz3gxCoy5ghGr4/Pr4usYXjT2QrdMMXHJylvTfOy9nf4/eykj06BDMBojt06
         WuPiiB2yVvBNSmzJZuQrnlWw9dvMtn1Sfs7AbqTW/wvsKSYRxw/do7AjCm2bSCe2Mdtk
         EE5USHxVPSLYdsMg1Pw/Nmvr0NxX2JeTfPr64CFgiI9cf29NR9Yv6EBvUkf0g4eFUydj
         rKv47n3xGHzJg0XnHSOUwyaLw9lEtNfIiZ4JFW0K1dYS5/TpXm08h2Qep6jcQQT6BpR8
         CLAoV1ByQzEyR/UbeRcgDS58RTgFlwiXBdfQ5E8Rw0UfRs2udPB3IK6HXnttqdJRQzai
         D4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097432; x=1759702232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8mhQzCwsUUwWDq6FHEumcNZhMtJjq4x5jibl2M6BSg=;
        b=QjRTSmTAh9poIo9xH/NEZFWje+8BS9yvI0r9L3ecaBGXN6vaVkt6TOSiaTQXZZIDYW
         QaPYSzd0zG0rND8RWUGpFEeFgAocudLHJPtE9FvqfIkbWuGK3hdXR4VxdSvQQyVlt5iC
         se2c4TUeoLQ8LVKBP2NPun/v+Xja6FagfYFD9I4B4GkP6gXOYgkXfPhjVgnhjjX5+pO6
         exylv+KKx3KbN6pPVQlpxIWJi3nKenIOUdPjg5+UAM4nwW1mvLGHbEVLIRFQxM+o1/sC
         2EjhN7ggnXo8KgbIfhbJrmKEHmLORmC/t4HMlKa9zHungh/IvEiT6kCfsCkvQLoooum4
         InhQ==
X-Gm-Message-State: AOJu0YySmh1TKRTaIUX7OYToIJ+031RG0VAJURMW0hNeVVmvat+USpwz
	xXOccJG+el6GNeEL4mQNDuMQaCDhK9+QhwBKNrfkxWjpbcPTZJtq/MbiSMAmQZftXKoAHrLzrHd
	kUaSwRyY=
X-Gm-Gg: ASbGncu8bmNeiuHCyH+cugGaEH9hAwy1+J4Kb98egYsKsWxFNq6j5SJpDR+BklTrTqq
	HSNH7yO0Q8TX7d9FNh4ftEnYisxsx9FgMF+qNjANiTTJvGPLogo/67ibMk0mqWxpxSZmxcoD8WM
	osEvW9dliuPYmbFiDLXUERAFTR/7gYyw8yWpJ3Oh4c+IGp2jQVaEbT3u4PssXT9mei05bN+2eqL
	pchFHMFcV8mw4bjE7q+SIJDqCaWrr5F/JJP2AnRV89O5xZWwev/q65na49SN6f9foUE7xBoPpiP
	nuaih92gwS5bt6auqhPB2EsPKbmq8Fqh68KxHPQEnpavDBZG6KN5JSRcvA1zt7Qacxl9+brVG6I
	zhdzqK3rTFMGNvIEpmnMY+n/w3TZbbyYlQTKgSR2VoshiYpjtdUpCW2XPjIXz857H2IoVh+az+M
	NCHyEpWoi6ljVH5Jan3Xn+NYKXbnTwS4xEFzCIA8kw8iqju68=
X-Google-Smtp-Source: AGHT+IGwZuoauo3ihgvQifvWgLkKQ8UWF6EBrDJtfi+6DAU1UjgYuWzO4WZrRbxXSG19wiVkMq2New==
X-Received: by 2002:a05:690c:45c9:b0:74e:d990:5550 with SMTP id 00721157ae682-76403423548mr185290887b3.39.1759097432264;
        Sun, 28 Sep 2025 15:10:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d8bbsm1932995d50.20.2025.09.28.15.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:32 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 47/49] repack: move `write_filtered_pack()` out of the builtin
Message-ID: <d0df1397176501fa6bf13a4a846d21e2b1ee3865.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

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
index 3360743afb..1e2c09da07 100644
--- a/Makefile
+++ b/Makefile
@@ -1137,6 +1137,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-filtered.o
 LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-midx.o
 LIB_OBJS += repack-promisor.o
diff --git a/builtin/repack.c b/builtin/repack.c
index 9d89217b77..a9fc09a24d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -106,52 +106,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-static int write_filtered_pack(struct write_pack_opts *opts,
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
index 42171d1851..4c60e016c3 100644
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
index 0000000000..96c7b02bb6
--- /dev/null
+++ b/repack-filtered.c
@@ -0,0 +1,51 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "repository.h"
+#include "run-command.h"
+#include "string-list.h"
+
+int write_filtered_pack(struct write_pack_opts *opts,
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
index 4a1c4eb606..a7ddbe784b 100644
--- a/repack.h
+++ b/repack.h
@@ -133,4 +133,8 @@ struct repack_write_midx_opts {
 void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
 int write_midx_included_packs(struct repack_write_midx_opts *opts);
 
+int write_filtered_pack(struct write_pack_opts *opts,
+			struct existing_packs *existing,
+			struct string_list *names);
+
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

