Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D236125C807
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386102; cv=none; b=SdiAfANJ7BEFlRPSkFl1sP7iXuLvLjiq7S+FJN7urIOfl6xUaU5/ZpcG88MYiHmti80zaNDe3B1TR5OfKii/xZDrtXSEHvN/CokQbEgG0KmmAt+iTZJLRvdX2skPCDzyDOH+69tdlIMnXHfV9kC6eYfUeoqgbf3Fi40xiczhfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386102; c=relaxed/simple;
	bh=nKv1CwFOPL0KeHUigqwVNFZeqt1X3KPl6/in+0QTmec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJ9cS+NLZ02TVmkpjHKb6czYh+5p34IrhvlRdOVyfW/Ks9Sgyc+UxNOYMOagwv1v8D6fDLmSioVSbHHygwuPYTjhTwOXAtIIv/FCMfKoPRYI6L5x1FiT9bR7LCUD/oXBzgg0VbSIF5RPDmN0USHbOyZSB89ynJxc4TfugLypdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB3ev2ge; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB3ev2ge"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso4409179b3a.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754386099; x=1754990899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWb79U1Ps0rMxYzaWQJ21hUDEldvMpoXanQl/cjBXx0=;
        b=iB3ev2getMcV3NH3XiLZqUW1aKI9SaQ+rFjIzfoYNFAZZ/8+gVhk88Vcs9ToBMj0tB
         KhYBvrpk8PtlUzfjtDdNhcUSF8a1WtEYnRp+UxpG+0lVeaB0Qjgk1bddtteZI3kXTqqb
         9qNtqMj4YjxLmUNe0zTsIqTmhky6IK9FSgI7yAkRBappPDx0Z4pEZPUWvpgraPgHuDAz
         CqVmLBTtou8lBx2yQFwObEY/ZhGe1MZfRE1jMFrElTsrCGRam0SdERhecwC93hxg8Pb5
         XuzqgzWEJIkMUdOulK6XBbj2/q9n5Z10LB7Z40VAXOELEK/3MJMd0eA3Xy/wIC0fuyls
         lNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386099; x=1754990899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWb79U1Ps0rMxYzaWQJ21hUDEldvMpoXanQl/cjBXx0=;
        b=ULxLf0JNM/7GzG/CmQRIsUI9R+zJMew1hkNRvi9I5xTAejzOvkp6o1CHCsZ9x6rYsk
         02ZeoDQAePGdImveKssQ5Nt0jbEYmxLJ3ZglJRxGUO6An1pcAzCYHU63WNIbQO/3Vqww
         sxicoV2+vAegWRI7JIOVcOcDnFR9cwPOOXtX/epmMoZD1suiZV/i7rgeyYVjdlXNmHF8
         6oIHh+MBVMfCSNe5KaVhLPDbwbUrTkVt5VbGB2EO/4NY0UAYxiADKSKcxPX7x73eWvgX
         BO8yavYfcWSzf62saXbUC7Fa0foq+PrksbLK/ueszPHwyTYLcmn+DsofxAAiBDCYfl/M
         NIjw==
X-Gm-Message-State: AOJu0Yw3CIW7VYp6zQE8+3EA05T58PdvHqbl1YAxv6Lwt+T1+/2/NwVh
	I7moxizUQxWEUI97Ra9Co7a1iBGNBbWmKHZdcZKeY6+PiOQjiMgjR8CX3YdG9w==
X-Gm-Gg: ASbGncuVCzaPAwW4WD1KfOjgcMmsYfOCbtVToUOprq3/w/G95h6z4kUV4oyLMitCYH0
	UIRn9y4e6t24It/ufqOhNKGUzJP28YusQl1a3lAljkh5BXqS3cwHCk9Wz22ByjW7mpG+FD8l8mV
	+Ye2XfW6MJ7zhqmAoWdOQ8PBlcmPJ9bgHUrLQl8cnPg+xASl+FisIagNqOA6NXD0jAQVMHaqWzM
	tHPZsNO6rL4wAfl4Jh9VL3sZimWzpRCI1VcSUyDUpNWTpMQYUJ+oNMi2kbPS6lNYEF5m0XTMpap
	9Z0SxbpMnPeBDTEYN5efTrMo0DczjB/KpNqbXq5XqFr/YVH+fb2sX3cMm7koEJiUDm3c5tUEyty
	c+X/DZ1diuViH7ZwmDvU=
X-Google-Smtp-Source: AGHT+IGcya38jWFqnsExyojm3BqsyWv40fC11BMomC5nTHuIM8hfH3fMgcsCTjrQddD3LnsO+UAXJQ==
X-Received: by 2002:a05:6a00:3e25:b0:76b:92ac:27cc with SMTP id d2e1a72fcca58-76bec0dad9fmr15439684b3a.0.1754386098884;
        Tue, 05 Aug 2025 02:28:18 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm12465691b3a.58.2025.08.05.02.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:28:18 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Victoria Dye <vdye@github.com>
Subject: [GSoC][PATCH v6 3/6] builtin/for-each-ref: factor out core logic into a helper
Date: Tue,  5 Aug 2025 14:57:55 +0530
Message-Id: <20250805092758.5321-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805092758.5321-1-meetsoni3017@gmail.com>
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
 <20250805092758.5321-1-meetsoni3017@gmail.com>
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
 builtin/for-each-ref.c | 41 +++++++++++++++++++----------------------
 for-each-ref.h         | 26 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 22 deletions(-)
 create mode 100644 for-each-ref.h

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index fe62f07861..4af33de576 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "config.h"
 #include "environment.h"
+#include "for-each-ref.h"
 #include "gettext.h"
 #include "object.h"
 #include "parse-options.h"
@@ -9,24 +10,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 
-#define COMMON_USAGE_FOR_EACH_REF \
-	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
-	"                         [(--sort=<key>)...] [--format=<format>]\n" \
-	"                         [--include-root-refs] [--points-at=<object>]\n" \
-	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
-	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
-	"                         [(--exclude=<pattern>)...] [--start-after=<marker>]\n" \
-	"                         [ --stdin | <pattern>... ]"
-
-static char const * const for_each_ref_usage[] = {
-	"git for-each-ref " COMMON_USAGE_FOR_EACH_REF,
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
@@ -75,17 +59,17 @@ int cmd_for_each_ref(int argc,
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
 
 	if (filter.start_after && sorting_options.nr > 1)
 		die(_("cannot use --start-after with custom sort options"));
@@ -125,3 +109,16 @@ int cmd_for_each_ref(int argc,
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
index 0000000000..a5e0b6d17a
--- /dev/null
+++ b/for-each-ref.h
@@ -0,0 +1,26 @@
+#ifndef FOR_EACH_REF_H
+#define FOR_EACH_REF_H
+
+struct repository;
+
+/*
+ * Shared usage string for options common to git-for-each-ref(1)
+ * and git-refs-list(1). The command-specific part (e.g., "git refs list ")
+ * must be prepended by the caller.
+ */
+#define COMMON_USAGE_FOR_EACH_REF \
+	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
+	"                         [(--sort=<key>)...] [--format=<format>]\n" \
+	"                         [--include-root-refs] [--points-at=<object>]\n" \
+	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
+	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
+	"                         [(--exclude=<pattern>)...] [--start-after=<marker>]\n" \
+	"                         [ --stdin | <pattern>... ]"
+
+/*
+ * The core logic for for-each-ref and its clones.
+ */
+int for_each_ref_core(int argc, const char **argv, const char *prefix,
+		      struct repository *repo, const char *const *usage);
+
+#endif /* FOR_EACH_REF_H */
-- 
2.34.1

