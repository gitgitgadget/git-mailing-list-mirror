Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D080521D3F6
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952458; cv=none; b=LUeo1MI9T0MLdT/URKzIgjfxq8jW34pe2TyyOVtdfxsGmt70ylgsWRpT2PFiios+VeS8CYEP1v7FbOFvLSGClULyqwn5NdGd6Hmk8NHD+dPD0J01GMJvUMvMTRLOiFvViCeT4izXBt+pXdLzu8p51SqgH9nJsc0Jnis0pkMNLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952458; c=relaxed/simple;
	bh=Tf7+S+bmoYSVVIHjnXmveYJ4MFlphU0xev8jNXzbQLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLiJ/oI3llbwHdwiZDtFzqEWwxuAS6i/0zLt2FBYbHX+b9W/Q0gfypLiB/Wpm6SIl6N+awtzAq5VpuMc4arxZ8upWOS+W+02oHLYsDEZAlWTMxos9n6Oy95TZZsZ0/UiGzfeMBn18OvYDu6CJ3Pp2TaqSi2w9ONPBq5fG95Xz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6sgC1hI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6sgC1hI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c44e014so667762b3a.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753952456; x=1754557256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP6ei0tTbOVzjeOAixSF+QwCfYp5da4nEjsbCLTTkJM=;
        b=O6sgC1hIQI0H4rZgCxD9sB0Z3BCm/mPIlbdeoZtxeROaPUH6ZMAioEIYAhUiM7AGaW
         3PGzmmII0Yj8V60i05zMnz/Kq/rMoBlOl63UwxA5TgVEDgFS9WZkJe1yd8YiX+2FGtoy
         1+YlPAFmHNTJcYHiFDV1c5jh4Zq8bWeTtWZ/z2yS7o46qmExuZ+1/MIFQCEDdYus/6zW
         xJy3S3MnUXo08FvpY3+Fyd4ZcjL/deerQ04luG4Y8s+i5PWwvU8y+UPvkC8lZ8HqjIYh
         s3wfOX5ipuYc88+yEamZpQJ35imbRYL6xV/eR0xVzSQHnMJQzhgnb8lNf0LU+LMDw+ky
         URoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952456; x=1754557256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP6ei0tTbOVzjeOAixSF+QwCfYp5da4nEjsbCLTTkJM=;
        b=es44gqNQqkCtMp324e8vr2wYrmVFrUPfq2mtaMvkiKe9UKk0/6EBJJsZ7zdRKewN9l
         DrSes+BMISX+hEU+krKz5nX8QwC6/GPmzF0MpMDi9AroWMFxWToxb+iN9zHxFYk5gaVm
         l+KNep3/RzbS/ZZUS3fwoXredifwEptHtf9VBwyg8H8dyNj9cw6H+pboGqtXtd890Xdj
         FZFzdgPOypRTgafTQGLfghzDVuJe/32hPVaB2f6hNeX/alVZ93VTSCylpfKoBjkkr976
         toTSOkU9BCChMxSEu3FNwcqLiD8PvumCd3QS6YTdFgU2VRD/oEayMksdYFiegyjx0Oe+
         Qq1Q==
X-Gm-Message-State: AOJu0YzRmp0jjsnwFC7izdzSPJvStFkSpTSP+a7WENcGWQZPJPqcMPbI
	m1ynubG9oGyWsThGUQ7NjIMt4zqbeOB9uLticN747oUz1+GWVXZyUL/tW4qnuA==
X-Gm-Gg: ASbGncs62h53HrE/9PLuh3oo7EZb+qBO2ocJFUrAD0wLOscVbuufL4QbRueN+TgCs8m
	lZsjgukF3avi6jvoi24NxqSd8TIbi7GjlBgdGdyXXdyd9XafutFz2awtHV6+5W8jQ/j02JxIKDD
	1l+4Lc0KNThLO+G+VJ5neZGAKRApWg8qL8xKP+ae33SG7veT4CExbvEtBds5YiHQOuNLQhk7Aii
	JTqWax3ryyEQv5p2Me5exqz+nmaFNntaX4NPzi14bN5bQqw3PJXNckiHKy1h5XDbo7D0eTI71id
	ISGKi9mW9SN63CxdbkKF9M1BUpxZpxwHO7BilIqLzvadDbHDoh2cKxEDVKuPTj5WhCxgy4jN+/c
	DAykDPvQNctAvz7LSblw=
X-Google-Smtp-Source: AGHT+IEzXYcNELJm3+BKhjbmJymzA4ulih7qU8FQA+7qfmZMjlldzhIPPqtiIksYd2st198HKK+G2Q==
X-Received: by 2002:a05:6a00:ae08:b0:737:9b:582a with SMTP id d2e1a72fcca58-76ab306de1emr9342936b3a.24.1753952455716;
        Thu, 31 Jul 2025 02:00:55 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm1057745b3a.65.2025.07.31.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:00:55 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	Meet Soni <meetsoni3017@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Victoria Dye <vdye@github.com>
Subject: [GSoC][RFC PATCH v4 2/5] builtin/for-each-ref: factor out core logic into a helper
Date: Thu, 31 Jul 2025 14:30:37 +0530
Message-Id: <20250731090040.1625303-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731090040.1625303-1-meetsoni3017@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of `git for-each-ref` is monolithic within
`cmd_for_each_ref()`, making it impossible to share its logic with other
commands. To enable code reuse for the upcoming `git refs list`
subcommand, refactor the core logic into a shared helper function.

Introduce a new `for-each-ref.h` header to define the public interface
for this shared logic. It contains the declaration for a new helper
function, `for_each_ref_core()`, and a macro for the common usage
options.

Move the option parsing, filtering, and formatting logic from
`cmd_for_each_ref()` into a new helper function named
`for_each_ref_core()`. This helper is made generic by accepting the
command's usage string as a parameter.

The original `cmd_for_each_ref()` is simplified to a thin wrapper that
is only responsible for defining its specific usage array and calling
the shared helper.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/for-each-ref.c       | 35 +++++++++++++++++++----------------
 for-each-ref.h               | 24 ++++++++++++++++++++++++
 t/t0450/adoc-help-mismatches |  1 -
 3 files changed, 43 insertions(+), 17 deletions(-)
 create mode 100644 for-each-ref.h

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d2207ec77..bbc0e5ad1c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -7,19 +7,9 @@
 #include "ref-filter.h"
 #include "strbuf.h"
 #include "strvec.h"
+#include "for-each-ref.h"
 
-static char const * const for_each_ref_usage[] = {
-	N_("git for-each-ref [<options>] [<pattern>]"),
-	N_("git for-each-ref [--points-at <object>]"),
-	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
-	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
-	NULL
-};
-
-int cmd_for_each_ref(int argc,
-		     const char **argv,
-		     const char *prefix,
-		     struct repository *repo)
+int for_each_ref_core(int argc, const char **argv, const char *prefix, struct repository *repo, const char *const *usage)
 {
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
@@ -67,17 +57,17 @@ int cmd_for_each_ref(int argc,
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
 
-	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
+	parse_options(argc, argv, prefix, opts, usage, 0);
 	if (format.array_opts.max_count < 0) {
 		error("invalid --count argument: `%d'", format.array_opts.max_count);
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(usage, opts);
 	}
 	if (HAS_MULTI_BITS(format.quote_style)) {
 		error("more than one quoting style?");
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(usage, opts);
 	}
 	if (verify_ref_format(&format))
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(usage, opts);
 
 	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
@@ -111,3 +101,16 @@ int cmd_for_each_ref(int argc,
 	strvec_clear(&vec);
 	return 0;
 }
+
+int cmd_for_each_ref(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo)
+{
+	static char const * const for_each_ref_usage[] = {
+		N_("git for-each-ref " COMMON_USAGE_FOR_EACH_REF),
+		NULL
+	};
+
+	return for_each_ref_core(argc, argv, prefix, repo, for_each_ref_usage);
+}
diff --git a/for-each-ref.h b/for-each-ref.h
new file mode 100644
index 0000000000..06d5b123b3
--- /dev/null
+++ b/for-each-ref.h
@@ -0,0 +1,24 @@
+#ifndef FOR_EACH_REF_H
+#define FOR_EACH_REF_H
+
+/*
+ * Shared usage string for options common to git-for-each-ref(1)
+ * and git-refs-list(1). The command-specific part (e.g., "git refs list ")
+ * must be prepended by the caller.
+ */
+#define COMMON_USAGE_FOR_EACH_REF \
+	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
+	"                         [(--sort=<key>)...] [--format=<format>]\n" \
+	"                         [--include-root-refs] [ --stdin | <pattern>... ]\n" \
+	"                         [--points-at=<object>]\n" \
+	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
+	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
+	"                         [--exclude=<pattern> ...]"
+
+/*
+ * The core logic for for-each-ref and its clones.
+ */
+int for_each_ref_core(int argc, const char **argv, const char *prefix,
+		      struct repository *repo, const char *const *usage);
+
+#endif /* FOR_EACH_REF_H */
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index 06b469bdee..2c6ecd5fc8 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -17,7 +17,6 @@ fast-export
 fast-import
 fetch-pack
 fmt-merge-msg
-for-each-ref
 format-patch
 fsck-objects
 fsmonitor--daemon
-- 
2.34.1

