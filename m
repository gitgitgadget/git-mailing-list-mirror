Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAD3C4149
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220968; cv=none; b=tQTly3D/B1AAs7ASzEwTPM1krVgQtHqsTy3hhZCi/kASJqYA190csAPzy4cVECDPoYw35lS4MFkMk7cZzJ6T2VmrrLq0GypQxfQw+9kSuysHsx1Sa4jd4c9h4lHQrk9wxDIKIMRnw9vJjvcDg9dAnwvKo4Qu3N+u1yQEJd9bMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220968; c=relaxed/simple;
	bh=g2jdo2OgEDYqOGQeTzTHyvsXDFfFtc0yULBiZJlc0GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSeUh9VYhWREVywVf2ttTEVhhp6nrs/y1HO9i3ql8Kh9RmpUh+dxpw5txfwJz59V1yI6WKQxzWyDZ1KcZx+IHSVdGnpij0lvtcgZeKXJrXD2ZaxCz1EMirQSoCK3ifTF1ZXdszTV2LbDb1oTOreoaibauPjoLZUGNzwEkl3TO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA7Ndh8+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA7Ndh8+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so3354866a12.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220957; x=1784825757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mTnDm/t63wo9huNWoeXk63Bca4k+47Tr3DIzvejbsxA=;
        b=RA7Ndh8+MDSWqh4SXH2p3z3cJZf6bvYx+XIOvdl9ru8XybNQqagnDNefDeHi/k0Mj4
         +CuqzdtRqJnCTxxzvN/K/ei77sW4bo8KgLaUK1U+Tl96J4Sigf70xlqdGNsYdT673bxr
         zjxUaoNU8TQ8xNrO7HP8E+aVNYUbWTGn1+R67JJhAI/yLb3TIuETyetuP6w0Rpx3xms+
         qphFYddfaByeEUuNrZv1z5XxxI7fYnOZkl+pyqDHQHR4fRulCpEUlnnGkYAN8Bvs69Zk
         b3VSOSAY++YIFL+QfooU15SUXPykYq0PV3JVL/eVApSVE5jV7s1rfIVk1uazxdbqYD/2
         /OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220957; x=1784825757;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mTnDm/t63wo9huNWoeXk63Bca4k+47Tr3DIzvejbsxA=;
        b=kvm/PMOJuc/NGBIJCpVYKN2THq5ubszUnBCxTnACFIwZ9dWovbjk5QkBRL6eKEYSiw
         iUrmw5hyTMZmfM4ve4cusEqoLX2bvSTmClmNpm1DIOa3CGPWU19aHlW2XZS/8L5VPtqm
         1c2gO53uuJkxb5+mc4t7b7XUor/3oFQNrEyjkyHDeK2nE98SPosUDtqlyVyQ8Byta7jO
         yI39E2GcyNcXU6/Co6cyYXWWK9vNMmNUzR05JwTKsUJpYfpXViOI79PYAL+KyGN3VdMo
         ur7glpWRPxk7zXWwy6HRFzk/QN1UYm5YlX+DCmqRNyj927hiudD8NhuJ/VbgY3X3pVmk
         kOyQ==
X-Gm-Message-State: AOJu0Yzz+YHIdb2BFl7fLXYtgBSYGx0WGNDh9ool/8zBUnV2HXfiSiv1
	jmloUnCbv857n5jh2EUZfaoP8uNCPbzuGgia3ctMDRL5Pmti3z0fy58Jcujh6e7u7q0=
X-Gm-Gg: AfdE7clRkBsYdxSWO+TFybAx7x6X3vurAONZJwX8FQctSL4jvea4zcXSX0CFsy+EOMn
	LiArrsNgYsShzmRyRlzP6rOQlY/rWUZx1dmcO/YqG2XJMzcnZ0XAcuHyLbEGJh40VLgHxyHs9b5
	kn6p+Ty7tOt+EBRVUkXou7F7gvt6TXCcQOzxTorjQzhoIdhsIzqsdzxoIhpUGZ9WLscIhWQg6o8
	ePbpv8nMvy2Ime9PNPUcE6AES31G29PzegiOpf9/p/Xz/0o55LX1O2L1LPl/4k6ZUZeeHNtWFwv
	jMQHT+gwt4yOAnRMb8GsIqkwLQj87Gy5agAuGQE7YN0hGoKuiRLGKdz3sN0DbnLtpMSwA01rTM1
	HD9U1Lxq4Odlrs/vo/rzAv+DXqhslDEt4FTCBUOkNuIMj5l5R6fIjZNhxdixXEaqrClnz9tBkX8
	vUZcMFnA0cGHpINJ9TM55+N9D3m5K0kGH4yZVh4h0CEU9z9OIAAK1hno1DtRQePZUCMPF4jFKQZ
	SeJcEoItu5nyQwUQA==
X-Received: by 2002:a05:6402:43cf:b0:698:aa8c:c162 with SMTP id 4fb4d7f45d1cf-69e19ee8323mr4263175a12.23.1784220957101;
        Thu, 16 Jul 2026 09:55:57 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:56 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/7] fast-import: use struct option for usage string
Date: Thu, 16 Jul 2026 18:55:17 +0200
Message-ID: <20260716165517.433849-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.185.g9120d2b5c0
In-Reply-To: <20260716165517.433849-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently `git fast-import -h` shows the following on a single line:

  usage : git fast-import [--date-format=<f>] [--max-pack-size=<n>] \
                          [--big-file-threshold=<n>] [--depth=<n>] \
                          [--active-branches=<n>] \
                          [--export-marks=<marks.file>]

This output has a number of issues like:

  - It's missing a lot of options.
  - It's not consistent with the SYNOPSIS section of the doc.
  - With `--help-all` instead of `-h` additional hidden options should
    be shown, but that's not the case.
  - It's not standard style anymore.
  - Most other Git commands show additional lines for most of the
    options they support.

Also while most commands use the parse-options API to handle their
options, "builtin/fast-import.c" still doesn't use it.

Let's improve on that by using the parse-options API to display the
options when `-h` and `--help-all` are used.

While at it, let's make the SYNOPSIS section of
"Documentation/git-fast-import.adoc" consistent with the new usage
string.

This deliberately leaves it to future work to also use the
parse-options API to actually parse the options.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc |  2 +-
 builtin/fast-import.c              | 86 +++++++++++++++++++++++++++---
 t/t0450/adoc-help-mismatches       |  1 -
 3 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index d68bc52b7e..7c5900e048 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -9,7 +9,7 @@ git-fast-import - Backend for fast Git data importers
 SYNOPSIS
 --------
 [verse]
-frontend | 'git fast-import' [<options>]
+'git fast-import' [<options>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 53f5d39173..a2952b273f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -30,6 +30,7 @@
 #include "khash.h"
 #include "date.h"
 #include "gpg-interface.h"
+#include "parse-options.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -277,16 +278,18 @@ struct fast_import_state {
 	const char *prefix;
 	int seen_data_command;
 	int allow_unsafe_features;
+	struct option *option;
 };
 
 static void fast_import_state_init(struct fast_import_state *state,
 				   int argc, const char **argv,
-				   const char *prefix)
+				   const char *prefix, struct option *option)
 {
 	memset(state, 0, sizeof(*state));
 	state->argc = argc;
 	state->argv = argv;
 	state->prefix = prefix;
+	state->option = option;
 }
 
 static void parse_argv(struct fast_import_state *state);
@@ -3907,8 +3910,10 @@ static void git_pack_config(void)
 	repo_config(the_repository, git_default_config, NULL);
 }
 
-static const char fast_import_usage[] =
-"git fast-import [--date-format=<f>] [--max-pack-size=<n>] [--big-file-threshold=<n>] [--depth=<n>] [--active-branches=<n>] [--export-marks=<marks.file>]";
+static const char *const fast_import_usage[] = {
+	N_("git fast-import [<options>]"),
+	NULL
+};
 
 static void parse_argv(struct fast_import_state *state)
 {
@@ -3937,7 +3942,7 @@ static void parse_argv(struct fast_import_state *state)
 		die(_("unknown option --%s"), a);
 	}
 	if (i != state->argc)
-		usage(fast_import_usage);
+		usage_with_options(fast_import_usage, state->option);
 
 	state->seen_data_command = 1;
 	if (import_marks_file)
@@ -3952,9 +3957,78 @@ int cmd_fast_import(int argc,
 {
 	struct fast_import_state state;
 
-	show_usage_if_asked(argc, argv, fast_import_usage);
+	unsigned long pack_size_limit, big_file_threshold, depth, active_branches;
+	char *edges, *signed_commits, *signed_tags, *date_format, *import_marks;
+	char *import_marks_if_exists, *export_marks, *submodules_from, *submodules_to;
+	int opt_quiet, opt_show_stats, opt_relative_marks, opt_force, opt_done;
+	int opt_allow_unsafe;
+	int cat_blob;
 
-	fast_import_state_init(&state, argc, argv, prefix);
+	/*
+	 * NEEDSWORK: For now this is used only to render
+	 * `-h`/`--help-all` usage messages. The actual parsing is
+	 * done by parse_one_option()/parse_one_feature().
+	 */
+	struct option fast_import_options[] = {
+		OPT_GROUP(N_("Common")),
+		OPT_STRING_F(0, "date-format", &date_format, N_("fmt"),
+			   N_("format of the commit/tag dates"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "stats", &opt_show_stats,
+			   N_("display some basic statistics (objects, packfiles and memory)"),
+			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "quiet", &opt_quiet,
+			   N_("disable the output shown by --stats"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "force", &opt_force,
+			   N_("force updating modified existing branches"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "done", &opt_done,
+			   N_("require a terminating 'done' command"), PARSE_OPT_NONEG),
+		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
+			     N_("maximum size of each output pack file")),
+		OPT_UNSIGNED(0, "big-file-threshold", &big_file_threshold,
+			     N_("maximum size of a blob that will be deltified")),
+		OPT_UNSIGNED(0, "depth", &depth,
+			     N_("maximum delta depth")),
+		OPT_UNSIGNED(0, "active-branches", &active_branches,
+			     N_("maximum number of branches to maintain active")),
+		OPT_GROUP(N_("Marks")),
+		OPT_STRING_F(0, "import-marks", &import_marks, N_("file"),
+			     N_("import marks from <file>"), PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "import-marks-if-exists", &import_marks_if_exists, N_("file"),
+			     N_("import marks from <file> if it exists"), PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "export-marks", &export_marks, N_("file"),
+			     N_("dump marks to <file>"), PARSE_OPT_NONEG),
+		OPT_BOOL(0, "relative-marks", &opt_relative_marks,
+			 N_("are --(import|export)-marks= paths relative to '.git/info/fast-import'?")),
+		OPT_GROUP(N_("Submodule rewrite")),
+		OPT_STRING_F(0, "rewrite-submodules-from", &submodules_from, N_("name:filename"),
+			     N_("rewrite object IDs for submodule <name> from <filename>"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "rewrite-submodules-to", &submodules_to, N_("name:filename"),
+			     N_("rewrite object IDs for submodule <name> to <filename>"),
+			     PARSE_OPT_NONEG),
+		OPT_GROUP(N_("Signing")),
+		OPT_STRING_F(0, "signed-commits", &signed_commits, N_("mode"),
+			     N_("how to handle signed commits"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "signed-tags", &signed_tags, N_("mode"),
+			     N_("how to handle signed tags"),
+			     PARSE_OPT_NONEG),
+		OPT_HIDDEN_GROUP(N_("Advanced")),
+		OPT_BOOL_F(0, "allow-unsafe-features", &opt_allow_unsafe,
+			   N_("allow unsafe mark commands from the stream"),
+			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "export-pack-edges", &edges, N_("file"),
+			     N_("dump edge commits to <file>"),
+			     PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "cat-blob-fd", &cat_blob,
+			    N_("write some responses to <fd> instead of stdout"),
+			      PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_END()
+	};
+
+	show_usage_with_options_if_asked(argc, argv, fast_import_usage, fast_import_options);
+
+	fast_import_state_init(&state, argc, argv, prefix, fast_import_options);
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index e8d6c13ccd..85b039a4be 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -13,7 +13,6 @@ credential
 credential-cache
 credential-store
 fast-export
-fast-import
 fetch-pack
 fmt-merge-msg
 format-patch
-- 
2.55.0.185.g9120d2b5c0

