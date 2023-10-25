Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1D2773D
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUl1DuO8"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DAF13D
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 05:14:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507ac66a969so7466357e87.3
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698236059; x=1698840859; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PSsxv2cn5y0AcxXpDd1/4hocSUW2Ag1qM3UwlbCIs+c=;
        b=lUl1DuO8wOVo8tCafrueDqzmBq9f5K+1aWyU0IAJz/rTSb1gwHc+56cWjfXPbOpb/G
         TJqRvFzWsK8IdYRzks3GGNXxr7+JVK+uKD1/LxCI93vS50jXg/+kZtOzYhiDm9liyF2L
         p5QmIrHDlBUYOZnajfuBqHXKaEI28mbqrZS6hyLk2AUgD6hwqYIDffP3Ojxk0wX6iTmj
         XdDFwZEIB8lYf73XJzEviJgEvKKo4wcDbwvEh8PLG450sRrNyr56SjvvpaR4e7lNkCsg
         Veds3aoKKqquZyKQ4QymM5Ft4nVR+4lRbox/9+nCDPLGM5MbWxhAlV7Z7xUNRfisM6r/
         QQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236059; x=1698840859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSsxv2cn5y0AcxXpDd1/4hocSUW2Ag1qM3UwlbCIs+c=;
        b=hXuqn8Ilnp53c9h2YrC88ddQJcGBLqEI9+Bo9Dcp2afzFgFEDkPEoX1kEKloj8lX2Y
         lXeooRe8zVmfGSHAoGsB+UNmCv+cGN2gBTdYTXFf/ZzCJD4ix6yLRfXDoTj+fxKQpHlw
         Xy3CKomR4p98PxKtCrLwt53i7qdz4iJKJVbLxJ+cIetmllxGP5mcLnJzRYJ5vJr+oS4i
         VVI4PrUeloFVZqlPHlsAdsr9T9Fa6/sGXTG1EMIhcfpuPCWrEzlpoPGQmtkbz7YtIaB0
         3FyWguNzerVsP1ThvQbXT/IpiPX1u9Vq+eG4zImYvbSrSqN07NGvAOnETkG4yAZ0VKZi
         8mdw==
X-Gm-Message-State: AOJu0YxTRqvnNn8SImAGU/L03BV1gpmi/lou9O8+FhEmS6Wro1Jdc4XS
	R8xXI7OviKhwEuPKVmYFRJOgU5rULck=
X-Google-Smtp-Source: AGHT+IHc1uIukmUH8PzU16WFcwwoxAg6dfk4RNr1HzvK4oRgGNujS1xIGPdyPXPnjBQ5O2MhTA7HvQ==
X-Received: by 2002:ac2:5192:0:b0:507:cfbc:bf8d with SMTP id u18-20020ac25192000000b00507cfbcbf8dmr9370609lfi.16.1698236058335;
        Wed, 25 Oct 2023 05:14:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003fefb94ccc9sm14635263wms.11.2023.10.25.05.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:14:17 -0700 (PDT)
Message-ID: <pull.1600.git.git.1698236057229.gitgitgadget@gmail.com>
From: "Stefan Muenzel via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Oct 2023 12:14:16 +0000
Subject: [PATCH] merge: ignore whitespace changes when detecting renames
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Stefan Muenzel <source@s.muenzel.net>,
    Stefan Muenzel <source@s.muenzel.net>

From: Stefan Muenzel <source@s.muenzel.net>

The options ignore-space-changes and ignore-all-space for
merge strategies based on "ort" are now propagated
to the computation of file renames, by normalizing spacing
changes when computing file hashes.

Signed-off-by: Stefan Muenzel <source@s.muenzel.net>
---
    merge: ignore whitespace changes when detecting renames

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1600%2Fsmuenzel%2Frenames-ignore-whitespace-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1600/smuenzel/renames-ignore-whitespace-v1
Pull-Request: https://github.com/git/git/pull/1600

 diff.c            |  4 ++++
 diffcore-delta.c  | 14 ++++++++++++++
 diffcore-rename.c |  9 +++++++++
 diffcore.h        |  2 ++
 merge-recursive.c |  1 +
 5 files changed, 30 insertions(+)

diff --git a/diff.c b/diff.c
index 2c602df10a3..916cc38f57c 100644
--- a/diff.c
+++ b/diff.c
@@ -4081,6 +4081,7 @@ int diff_populate_filespec(struct repository *r,
 {
 	int size_only = options ? options->check_size_only : 0;
 	int check_binary = options ? options->check_binary : 0;
+	int ignore_whitespace = options ? options->ignore_whitespace : 0;
 	int err = 0;
 	int conv_flags = global_conv_flags_eol;
 	/*
@@ -4090,6 +4091,9 @@ int diff_populate_filespec(struct repository *r,
 	if (conv_flags & CONV_EOL_RNDTRP_DIE)
 		conv_flags = CONV_EOL_RNDTRP_WARN;
 
+	if (ignore_whitespace)
+		s->ignore_whitespace = 1;
+
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
 	if (S_ISDIR(s->mode))
diff --git a/diffcore-delta.c b/diffcore-delta.c
index c30b56e983b..e2bb5f9133a 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -130,6 +130,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
 	unsigned char *buf = one->data;
 	unsigned int sz = one->size;
 	int is_text = !diff_filespec_is_binary(r, one);
+	int ignore_whitespace = one->ignore_whitespace;
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(st_add(sizeof(*hash),
@@ -149,6 +150,19 @@ static struct spanhash_top *hash_chars(struct repository *r,
 		if (is_text && c == '\r' && sz && *buf == '\n')
 			continue;
 
+		if (is_text && ignore_whitespace && isspace(c)) {
+			if (sz) {
+				char next = *buf;
+				if ( c == '\n' && next == '\n')
+					continue;
+				else if ( c != '\n' && isspace(next))
+					continue;
+			}
+			if ( c != '\n')
+				/* Normalize whitespace to space*/
+				c = ' ';
+		}
+
 		accum1 = (accum1 << 7) ^ (accum2 >> 25);
 		accum2 = (accum2 << 7) ^ (old_1 >> 25);
 		accum1 += c;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5a6e2bcac71..ee68442afc3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "strmap.h"
 #include "trace2.h"
+#include "xdiff-interface.h"
 
 /* Table of rename/copy destinations */
 
@@ -950,6 +951,10 @@ static int find_basename_matches(struct diff_options *options,
 		.info = info
 	};
 
+	dpf_options.ignore_whitespace =
+		DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE)
+		|| DIFF_XDL_TST(options, IGNORE_WHITESPACE);
+
 	/*
 	 * Create maps of basename -> fullname(s) for remaining sources and
 	 * dests.
@@ -1402,6 +1407,10 @@ void diffcore_rename_extended(struct diff_options *options,
 		.repo = options->repo
 	};
 
+	dpf_options.ignore_whitespace =
+		DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE)
+		|| DIFF_XDL_TST(options, IGNORE_WHITESPACE);
+
 	trace2_region_enter("diff", "setup", options->repo);
 	info.setup = 0;
 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
diff --git a/diffcore.h b/diffcore.h
index 5ffe4ec788f..d6bee67e646 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -61,6 +61,7 @@ struct diff_filespec {
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	signed int is_binary : 2;
+	unsigned ignore_whitespace : 1;
 	struct userdiff_driver *driver;
 };
 
@@ -78,6 +79,7 @@ void diff_queued_diff_prefetch(void *repository);
 struct diff_populate_filespec_options {
 	unsigned check_size_only : 1;
 	unsigned check_binary : 1;
+	unsigned ignore_whitespace : 1;
 
 	/*
 	 * If an object is missing, diff_populate_filespec() will invoke this
diff --git a/merge-recursive.c b/merge-recursive.c
index e3beb0801b1..0e52c45158a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1894,6 +1894,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	repo_diff_setup(opt->repo, &opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
+	opts.xdl_opts = opt->xdl_opts;
 	opts.detect_rename = merge_detect_rename(opt);
 	/*
 	 * We do not have logic to handle the detection of copies.  In

base-commit: 2e8e77cbac8ac17f94eee2087187fa1718e38b14
-- 
gitgitgadget
