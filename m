Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C54242D9E
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299400; cv=none; b=akm2hwot+Ninyj6EZBvt4lz0bFbC9ZgfI8JCiSFjr2viPd5HsKWs5Njqbs//dUBimseZqqNpWkc4XWka0CTDA21tq3wg1zlI2q32w55khGEMMpOproLxDPiCgHaTrRRBTWH3TWJnoBr/SENmLj+IVBKmW6/IQO8AvegZi57yaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299400; c=relaxed/simple;
	bh=5klwY7y5ffFisuLLfpgtLmXI8oToSSEFKhC4apuER+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pF/OwcO8zGJPshFzHt6pyUdd8PAnwkbbE+Ea1dwwUBUdfBYjnRy8byfXbLfgvr3jSIEIoQfc53gVp5h+GRaoX790O3xfKW6d/DdtKo1Fie2kmAjMi0GqhAh3s98g+1tEZN1HJ306KEmtacLc4qSQneGACBIgW7pREfnsQTTkTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROW3r0OV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROW3r0OV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2401248e4aaso53579385ad.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299397; x=1754904197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84Ij2TtxPhuBBKO6R5fvkl5zfarx/ZqUMtqI5Am1mgE=;
        b=ROW3r0OV4h48AvXsD/E9/JeKfv7Oef3L+g/vXoFE9SIT6YLL3atsZkc6r90GV0BArn
         tx5KlWApsQuSyfJofHJ0FbU7rXsjsCcRejKYNPRsNaIjylApSX95X0Di7jgDkjwWUZ5v
         P22ZSDYDJBZxJ5XQcXXlnvmRzLSW+08qr1zq30qvMjGgKzzjkSUcTGISqgkEVQ03obt+
         fCvsxWRuLHBWrh44Q66QUqLtUTn0ohLIYWBJW4rgdzzlC0pC0uDxhdC7IEioPf8PM6m3
         88sz9SUIs4GRX5isK79p9acTfmknmvDKgq9X99SJSUd0kRkR+prhPsj8WlcrTrtm3PLG
         kRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299397; x=1754904197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84Ij2TtxPhuBBKO6R5fvkl5zfarx/ZqUMtqI5Am1mgE=;
        b=tjW7nFiM1HMnjtJGGa7HFaw/NILjlgIbHbLifCpxdLk0BDCTcOwQBujMdxxSaC7D37
         lrvDoi3RqawAsCAZh/iP2D6ZGcLZmsXGV2UyPETqcnQfNgg7h/Xcn1l8MdJE4Y2qgwfY
         M9wyerBqCPcYIn+IngtIUyW8p86k4mTCgzEq1CZe+M1m3dg1XyiCz/CwmAegp4AcYLeu
         cbgp5O4T0I8nCQccbWWKgbOgxF4WxReQgb5TLIQL1pmnxIOujMbIU64CX78LBtJH4DyZ
         BO4q2nPrMMmbrNYPiW56g95viV9gsnnsoI38/3vp8GHCncyNQ4QwPOl2pj2qUDmswpVE
         8o+A==
X-Gm-Message-State: AOJu0YzUhSYW8zqQPigsbpryeL9FQxj6S0XtWOVXMBh8W0Iux8ER5sH3
	AY8ubsgVAxrWDeJqh9WHyqFGaOy1Otg6ilNqYhAT3AjRqaPyVXEbVpNTb6iYI5gg
X-Gm-Gg: ASbGnctupuSpQpA+Lxv7dMx685oH5F8RZas0okKDC7irZ+STtCBjB0Kr8gjGRbKDBj+
	AD2NCyhV/pObGPFqm/00isyqekrPzIV+2spo0g0eoRkq3OdpvmAFDKIGXOrD/QGPxeB2QvMf5Uj
	NO0ktFfb4hiHxlbNg86eRMIOTXCQYEWeCO20v1XMNFuShj1Tz/zWLO68p/jFXhwsqqA/579epu3
	AyfXK/kqC0t2Ym6ewbCOtUhZj38F7BFPoatTTVV7GldVrmsjCNP3xEHYPC0K/Iiw84BY+trXYnw
	CY8EoCZijLzZf4EkpCvpZQ3OLLwaiPW9XCK1Nw5DW8fvL1pVWMOmgS41U1g55fF04aIfMsUxdT2
	EkzWqgDv8AxR3C6a3fww=
X-Google-Smtp-Source: AGHT+IFZgAnijBUuYkGxiuRxAOGFZH/+Nd1aVALjLV880TbKctnwXqZmJQKzQXPjHE1e7L7bP1u/aQ==
X-Received: by 2002:a17:903:41cc:b0:240:70d4:85c3 with SMTP id d9443c01a7336-24246f3094dmr130008005ad.9.1754299396969;
        Mon, 04 Aug 2025 02:23:16 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm106205565ad.4.2025.08.04.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:23:16 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC][RFC PATCH v5 3/6] builtin/for-each-ref: factor out core logic into a helper
Date: Mon,  4 Aug 2025 14:52:52 +0530
Message-Id: <20250804092255.1092973-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804092255.1092973-1-meetsoni3017@gmail.com>
References: <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250804092255.1092973-1-meetsoni3017@gmail.com>
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
index b2186f9f9a..2d4945379a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
+#include "for-each-ref.h"
 #include "gettext.h"
 #include "object.h"
 #include "parse-options.h"
@@ -8,24 +9,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 
-#define COMMON_USAGE_FOR_EACH_REF \
-	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
-	"                         [(--sort=<key>)...] [--format=<format>]\n" \
-	"                         [--include-root-refs] [ --stdin | <pattern>... ]\n" \
-	"                         [--points-at=<object>]\n" \
-	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
-	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
-	"                         [--exclude=<pattern> ...]"
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
@@ -73,17 +57,17 @@ int cmd_for_each_ref(int argc,
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
@@ -117,3 +101,16 @@ int cmd_for_each_ref(int argc,
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
index 0000000000..1662d25417
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
-- 
2.34.1

