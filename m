Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9BD305693
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437232; cv=none; b=hRNd5Jf9h1fmc8Sx7HL35wWqKXNyHXtJFrlcXvSeu7N2Kq5joTNow1vZWQpnpbyCIhzsZ1LMTp8qHsA55sfcHL9sHglb9DAgDgHZ2c6Gqyzhk+10lx/fbyrkdNBADlR86uQcwm98XXUNrg3RQed7TSMpx0Yt1THjU4drBzvXP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437232; c=relaxed/simple;
	bh=dfIohZiOIoO1jvCxGTJwMxeuB79yMBp1U6My7uGjr7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDjN3LSNNFXv74JAVW67mffLcAz0EZ1owBUFhVeiq6wkzT8BByRq4y4W2rGJegwka6JsKr1Ha1CoBcnuhsXM3X2Y/8GD+wFEZSSSFhvX4B3XeuOjU3sjdmHUfTjRNsslZaqqeiU5+je+Wd0ZnB6O7ofTNEytjyueyLJvYG5iIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrM1Ymfu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrM1Ymfu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954df200ddso18758395e9.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437229; x=1787042029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c5q/Kx+jJAMpd6iIFV1NaoASq1J8ealxMhqHmPPsJUE=;
        b=lrM1YmfuS5zMaOa0G+bNtnUB/+DEKHPoXS3HukXJPOsbszXco705DgrXND7/LTQs/N
         hWiY3jKoAJQ8Ifg0l3WEmFC4mB1Qf4Z4XTBajzArdlxMH0B/CDD0A5LnlbefW0kDdwsn
         7vqYhZLhrYH/81bKn6iLVUHli9TTqne1FabRx1JXYOb5JWdw9SrB7YsDjBFHe+Y38rOl
         PPrliiXM61hiZShHun+XNu5P8wfFNOAYx4N3ZkK8rJu650irTNW11j6agfDFQdy+rtwj
         pkevceia7rR/Vq4kKnGNqJAdVexHM5FMZ+jRUk/x5gKDXR8shCg0u4uJtLSF/pJggqcy
         /zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437229; x=1787042029;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5q/Kx+jJAMpd6iIFV1NaoASq1J8ealxMhqHmPPsJUE=;
        b=qoYlHxr8mwfs6lJvzMYmZQf+YuwLdxqOlK1pZcmM+Br3nyBOjFhEGCZINuS8/ep6gI
         rstqU1/Li3Q3NfcZ9eZAhKejkBYuMU6Kz2Wf6OSt4eILRSt9k8H8xJ6PJok49HOXrUvI
         OppZceXJn7We53CTZfQOU6FE6mDYZbXdc0ogsu6ULrUMrxwBp8yytz033FaFWa+BBsSB
         wCw9OKX6pi+3YqtPu9BB1RMyRBZ+qQuyRvMpyVi5jeDh+8T7h2Cnp6gJahSNxCemg1BP
         S1kIU6GpxrYgEovce+9Ui3gAHzJptHkLqGN6idzpuAQ6Ujl8pIdM7vnX57Vbyg9f0zQk
         H/og==
X-Gm-Message-State: AOJu0Yw1uPEec90MsS/6kyOUZltXWwf09fFWnPaT342VaY3VA2pZ03uU
	sSGjS3o+mJVLt0K8Su0yMgFry4ss2Efer6V4CkADJ/VUuEC61rrccqcP1vz3bA==
X-Gm-Gg: AR+sD10d/g9WvUL7srn2b2r/TZqGNDXxfFw8WaQsOxn4GvImhQQlzeeqGfK3LDUSalz
	ULacfGloeTdR1z5R55x6UVSyv+tcT1tKsH6qwPdHLpFxnNPsW295Rq88vac999mVZFjwIDUXNbe
	OucDh0nrW8djnhPNs5gKKOuh4SzT2ZjTxi/ozTlNECI8OhIZZUBa/0RqELJ+5ILB2/KTaifbebt
	kO3pZ3RVvsS9v1Rir5DHC4jx4jYc2Bxe4iVOF8CLWrrrANgFO9bH9fFVcZenovYdHmgzaGnibK4
	AIP6Mu7oEppQFQK4Gr1dJ0AbYKvSjMJyuSrzg5gAYwoZBpuKDztf7pd+/YA13HlxbiQFp0hW1GT
	BPT7gVx/3ym0C3F32vQfH97hzU+UGwfG7kuiec38wNZMrAcpnbxE3RdLfyqvQSZjFB8P/sODRDV
	mXtha+RXi7XG0QVBm9DLsX6GbDQival8alULE9Sxu8BQQ9kMSADQfYMgEUa40uQVEvpl2B3LT8u
	kd8mgmP6rqW05duhUjg+np2DQOe/ZyNzwBHohVQxpUVX9T0Z7wSXeyudjSQBqHZRBQDOd1wiWz5
	Z3Y=
X-Received: by 2002:a05:600c:1f83:b0:499:781e:25fc with SMTP id 5b1f17b1804b1-4997842c0e7mr24872355e9.3.1786437228713;
        Tue, 11 Aug 2026 01:33:48 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:47 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 09/12] fast-import: use struct option for usage string
Date: Tue, 11 Aug 2026 10:33:11 +0200
Message-ID: <20260811083314.2023489-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/git-fast-import.adoc |  2 +-
 builtin/fast-import.c              | 83 +++++++++++++++++++++++++++---
 t/t0450/adoc-help-mismatches       |  1 -
 3 files changed, 78 insertions(+), 8 deletions(-)

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
index 52da29c1bd..879c286043 100644
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
@@ -3965,8 +3968,10 @@ static void git_pack_config(void)
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
@@ -3995,7 +4000,7 @@ static void parse_argv(struct fast_import_state *state)
 		die(_("unknown option --%s"), a);
 	}
 	if (i != state->argc)
-		usage(fast_import_usage);
+		usage_with_options(fast_import_usage, state->option);
 
 	state->seen_data_command = 1;
 	if (import_marks_file)
@@ -4010,9 +4015,75 @@ int cmd_fast_import(int argc,
 {
 	struct fast_import_state state;
 
-	show_usage_if_asked(argc, argv, fast_import_usage);
+	unsigned long pack_size_limit, big_file_threshold;
+	char *edges, *signed_commits, *signed_tags, *date_format;
+	char *import_marks_if_exists, *submodules_from, *submodules_to;
 
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
+		OPT_BOOL_F(0, "stats", &show_stats,
+			   N_("display some basic statistics (objects, packfiles and memory)"),
+			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "quiet", &quiet,
+			   N_("disable the output shown by --stats"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "force", &force_update,
+			   N_("force updating modified existing branches"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "done", &require_explicit_termination,
+			   N_("require a terminating 'done' command"), PARSE_OPT_NONEG),
+		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
+			     N_("maximum size of each output pack file")),
+		OPT_UNSIGNED(0, "big-file-threshold", &big_file_threshold,
+			     N_("maximum size of a blob that will be deltified")),
+		OPT_UNSIGNED(0, "depth", &max_depth,
+			     N_("maximum delta depth")),
+		OPT_UNSIGNED(0, "active-branches", &max_active_branches,
+			     N_("maximum number of branches to maintain active")),
+		OPT_GROUP(N_("Marks")),
+		OPT_STRING_F(0, "import-marks", &import_marks_file, N_("file"),
+			     N_("import marks from <file>"), PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "import-marks-if-exists", &import_marks_if_exists, N_("file"),
+			     N_("import marks from <file> if it exists"), PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "export-marks", &export_marks_file, N_("file"),
+			     N_("dump marks to <file>"), PARSE_OPT_NONEG),
+		OPT_BOOL(0, "relative-marks", &relative_marks_paths,
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
+		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
+			   N_("allow unsafe mark commands from the stream"),
+			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "export-pack-edges", &edges, N_("file"),
+			     N_("dump edge commits to <file>"),
+			     PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "cat-blob-fd", &cat_blob_fd,
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
index c4a55ff4e3..baf3b1d809 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -12,7 +12,6 @@ column
 credential
 credential-cache
 credential-store
-fast-import
 fetch-pack
 fmt-merge-msg
 format-patch
-- 
2.55.0.530.gdb3615d990.dirty

