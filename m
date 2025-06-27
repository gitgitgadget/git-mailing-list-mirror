Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510A2264A3
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010607; cv=none; b=n/2cU738NRVVElnX9N99kTAQl10gUflR+L2wrgjP4ig7OZUtCRIXXQHE02mgH+h4c1+vdI7wxkYMDtTgyYazvNUVrMrZ5EsTIW8dkkl2bfmLzucegfbAYgsEaaYjf/q0VLiYuARdN0qhzLNGX9AlqhRXbLkK1SNn2xZ8LKN1zeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010607; c=relaxed/simple;
	bh=pk5tFhQmTClvPF8qr1W32UcryvS72HWBXoMHVQpxxRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOQsK02/+VQwSFpZR2qE/IA/bmZzuG2VcMrCQvOKaYtxis5aQyvpEv7of/KxO5BxAmKt+NDck9GmkT2c+/iHpfPL2iAWuC+lN5KTb1t/HZVd8dz/jLjMe/AkeVGV3qvUo3uMi2bUFPcUZvK2YTvufkduDtbFI8U+SjAAUBF0jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1iOEMrm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1iOEMrm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-236192f8770so15432435ad.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751010604; x=1751615404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMwsm/qDIWdCDgBgHroQFPbf+PGQ0Ia5txrh1GR/8D8=;
        b=V1iOEMrmsnMP9t+bVItWMTCdIz5QQW0nEqlzYf9kVafOZc1hZ1OwgXQhW4vE48GT3M
         Hga9iCnTpEmwZ0BqQVEHY+sy6cfjwDZlOQDZrhMltzWLmFwMPD0bxy8EWt3hRSeF8POJ
         +RFIKMm+X+K5jvf4HhYpB+5hmgvN3HmgJaYD8IGXRmdllo0UHo+R2Czu+GSAwxtX+r+B
         0IjH+09sX8IxtZlgoKV40lEyrjZEXgyByISqoyKf7xqgcObaNpBUbfwPybgVALC4o0hH
         95+mXqpzxoL6nkYqOjl6bqtlcU/XvUfIhVNdKuAceZ+k/aRdvtB3wv68mVlMgSeYE8cv
         jB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010604; x=1751615404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMwsm/qDIWdCDgBgHroQFPbf+PGQ0Ia5txrh1GR/8D8=;
        b=r5UxuBG37URKOM+kfQyAJRiMvg+ip/mMrYoVg5Ggm7mV8aOaQyrkQzE1nZU60IbZKT
         957VRVK1oiBb1++Cix64O2bL1/fQh//1T65Dx1fEleF5ocTtFL3y62vjV51j8plwdQ0j
         7lvzWaIr1f93EMg6wP6514mTAoSx0xYBIZmddMRIjnfq3PDn7LDFoMJcWx1DdWk3qJsN
         y/Q7fPiIxDni7RPx+xEOvBEZhk25QUjlJ+hL7LKvgZ+bC7TsxXs7k2dftAgi7tHXYdmj
         f4esMKLFqUgD2veJSebQWzFdVK52HpQtT9xDnykhPrJSG7pIpNLnPekC+uC8HMtCv8zZ
         rqHA==
X-Gm-Message-State: AOJu0YxITXUsHqvWB/HnCTYXnWHBBvRsAlsZHWxcHLQRa3bpi+vlVXTm
	mwDpQONuKBl1Y2E85paOiPPC7oWeshHd+/4XsKQQJy2WCp76N2wPY5QsqcnVlmdl
X-Gm-Gg: ASbGncufm5sRljgVVAug8Xwx0N1Ny1KFIXzU6bTIvi6bBli6kXSj+bN5I9Verc0FCF3
	3pMbFG4tdMr+cThmcQ1RG+ba/oZwDQWl1DJ8Oost8Np+u8LGLKJtPj08Z0MpX+r2tH6u15NoYv/
	nUP0lS3s2MvTwfcZb7uN5/f0UKrqUMJJw5jH/NO8+I4Fr9ABOPNgQxxEAr2Ou4YvK4QqyxTgYJs
	5DEVBfqBPwenVBN5+eaZ1gph6TzQJw1UI+ajvsd9MGT/bL78SSna/64dp2hJFQch9cx45++zOuf
	eTlFzYFxE9rKyvTkIsbfhKCItoZLn9lcFB6BXW15d4lJEdbM2/kMgsf2P1uKkOCQ2myJ
X-Google-Smtp-Source: AGHT+IGgsITaBIbBB3awONrAWvECJdbq9PNIkFuD0jfsabAq7aPdYnsRROz5+myxg3gv+QBHAkXeuw==
X-Received: by 2002:a17:903:19cb:b0:231:c89f:4e94 with SMTP id d9443c01a7336-2390a54135bmr92674505ad.21.1751010604456;
        Fri, 27 Jun 2025 00:50:04 -0700 (PDT)
Received: from meet.. ([43.250.165.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e23aesm1673437a91.31.2025.06.27.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:50:03 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>
Subject: [GSoC][RFC PATCH 1/2] builtin/refs: add list subcommand
Date: Fri, 27 Jun 2025 13:19:33 +0530
Message-Id: <20250627074934.1761897-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627074934.1761897-1-meetsoni3017@gmail.com>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's reference management is distributed across multiple commands. As
part of an ongoing effort to consolidate and modernize reference
handling, introduce a `list` subcommand under the `git refs` umbrella as
a replacement for `git for-each-ref`.

For now, cmd_refs_list is effectively a copy of cmd_for_each_ref,
allowing us to reuse the existing filtering and formatting logic while
avoiding any backward compatibility issues. The core implementation
continues to reside in shared modules.

This duplication is temporary and intentional: future enhancements will
be added exclusively to `git refs list`, providing a gradual path
forward without disrupting existing workflows.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc |  95 +++++++++++++++++++++++++++++++
 builtin/refs.c              | 110 ++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 4d6dc994f9..d8f81eaabd 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -11,6 +11,13 @@ SYNOPSIS
 [synopsis]
 git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
+git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
+	      [(--sort=<key>)...] [--format=<format>]
+	      [--include-root-refs] [ --stdin | <pattern>... ]
+	      [--points-at=<object>]
+	      [--merged[=<object>]] [--no-merged[=<object>]]
+	      [--contains[=<object>]] [--no-contains[=<object>]]
+	      [--exclude=<pattern> ...]
 
 DESCRIPTION
 -----------
@@ -26,6 +33,11 @@ migrate::
 verify::
 	Verify reference database consistency.
 
+list::
+	List references in the repository with support for filtering, formatting,
+	and sorting. This subcommand uses the same core logic as
+	linkgit:git-for-each-ref[1] and offers equivalent functionality.
+
 OPTIONS
 -------
 
@@ -57,6 +69,89 @@ The following options are specific to 'git refs verify':
 --verbose::
 	When verifying the reference database consistency, be chatty.
 
+The following options are specific to 'git refs list':
+
+<pattern>...::
+	If one or more patterns are given, only refs are shown that
+	match against at least one pattern, either using fnmatch(3) or
+	literally, in the latter case matching completely or from the
+	beginning up to a slash.
+
+--stdin::
+	If `--stdin` is supplied, then the list of patterns is read from
+	standard input instead of from the argument list.
+
+--count=<count>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
+--sort=<key>::
+	A field name to sort on.  Prefix `-` to sort in
+	descending order of the value.  When unspecified,
+	`refname` is used.  You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key.
+
+--format=<format>::
+	A string that interpolates `%(fieldname)` from a ref being shown and
+	the object it points at. In addition, the string literal `%%`
+	renders as `%` and `%xx` - where `xx` are hex digits - renders as
+	the character with hex code `xx`. For example, `%00` interpolates to
+	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
++
+When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
+TAB %(refname)`.
+
+--color[=<when>]::
+	Respect any colors specified in the `--format` option. The
+	`<when>` field must be one of `always`, `never`, or `auto` (if
+	`<when>` is absent, behave as if `always` was given).
+
+--shell::
+--perl::
+--python::
+--tcl::
+	If given, strings that substitute `%(fieldname)`
+	placeholders are quoted as string literals suitable for
+	the specified host language.  This is meant to produce
+	a scriptlet that can directly be `eval`ed.
+
+--points-at=<object>::
+	Only list refs which points at the given object.
+
+--merged[=<object>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged[=<object>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
+--contains[=<object>]::
+	Only list refs which contain the specified commit (HEAD if not
+	specified).
+
+--no-contains[=<object>]::
+	Only list refs which don't contain the specified commit (HEAD
+	if not specified).
+
+--ignore-case::
+	Sorting and filtering refs are case insensitive.
+
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
+--exclude=<pattern>::
+	If one or more patterns are given, only refs which do not match
+	any excluded pattern(s) are shown. Matching is done using the
+	same rules as `<pattern>` above.
+
+--include-root-refs::
+	List root refs (HEAD and pseudorefs) apart from regular refs.
+
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 998d2a2c1c..70e1757791 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "fsck.h"
 #include "parse-options.h"
+#include "ref-filter.h"
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
@@ -13,6 +14,15 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
+#define REFS_LIST_USAGE \
+	N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
+	   "              [(--sort=<key>)...] [--format=<format>]\n" \
+	   "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
+	   "              [--points-at=<object>]\n" \
+	   "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
+	   "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
+	   "              [--exclude=<pattern> ...]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -101,6 +111,104 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_list(int argc, const char **argv, const char *prefix,
+			 struct repository *repo)
+{
+	struct ref_sorting *sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP;
+	int icase = 0, include_root_refs = 0, from_stdin = 0;
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_format format = REF_FORMAT_INIT;
+	unsigned int flags = FILTER_REFS_REGULAR;
+	struct strvec vec = STRVEC_INIT;
+	const char * const list_usage[] = {
+		REFS_LIST_USAGE,
+		NULL
+	};
+
+	struct option opts[] = {
+		OPT_BIT('s', "shell", &format.quote_style,
+			N_("quote placeholders suitably for shells"), QUOTE_SHELL),
+		OPT_BIT('p', "perl",  &format.quote_style,
+			N_("quote placeholders suitably for perl"), QUOTE_PERL),
+		OPT_BIT(0 , "python", &format.quote_style,
+			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
+		OPT_BIT(0 , "tcl",  &format.quote_style,
+			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
+		OPT_BOOL(0, "omit-empty",  &format.array_opts.omit_empty,
+			N_("do not output a newline after empty formatted refs")),
+
+		OPT_GROUP(""),
+		OPT_INTEGER(0, "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
+		OPT_STRING(0, "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT__COLOR(&format.use_color, N_("respect format colors")),
+		OPT_REF_FILTER_EXCLUDE(&filter),
+		OPT_REF_SORT(&sorting_options),
+		OPT_CALLBACK(0, "points-at", &filter.points_at,
+			     N_("object"), N_("print only refs which points at the given object"),
+			     parse_opt_object_name),
+		OPT_MERGED(&filter, N_("print only refs that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
+		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
+		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
+		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include HEAD ref and pseudorefs")),
+		OPT_END(),
+	};
+
+	format.format = "%(objectname) %(objecttype)\t%(refname)";
+
+	repo_config(repo, git_default_config, NULL);
+
+	/* Default to sorting by refname unless overridden by --sort= */
+	string_list_append(&sorting_options, "refname");
+
+	parse_options(argc, argv, prefix, opts, list_usage, 0);
+	if (format.array_opts.max_count < 0) {
+		error("invalid --count value: `%d'", format.array_opts.max_count);
+		usage_with_options(list_usage, opts);
+	}
+	if (HAS_MULTI_BITS(format.quote_style)) {
+		error("more than one quoting style?");
+		usage_with_options(list_usage, opts);
+	}
+	if (verify_ref_format(&format))
+		usage_with_options(list_usage, opts);
+
+	sorting = ref_sorting_options(&sorting_options);
+	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
+	filter.ignore_case = icase;
+
+	if (from_stdin) {
+		struct strbuf line = STRBUF_INIT;
+
+		if (argv[0])
+			die(_("unknown arguments supplied with --stdin"));
+
+		while (strbuf_getline(&line, stdin) != EOF)
+			strvec_push(&vec, line.buf);
+
+		strbuf_release(&line);
+
+		/* vec.v is NULL-terminated, just like 'argv'. */
+		filter.name_patterns = vec.v;
+	} else {
+		filter.name_patterns = argv;
+	}
+
+	if (include_root_refs)
+		flags |= FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
+
+	filter.match_as_path = 1;
+	filter_and_format_refs(&filter, flags, sorting, &format);
+
+	ref_filter_clear(&filter);
+	ref_sorting_release(sorting);
+	strvec_clear(&vec);
+	return 0;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -109,12 +217,14 @@ int cmd_refs(int argc,
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
+		REFS_LIST_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
+		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_END(),
 	};
 
-- 
2.34.1

