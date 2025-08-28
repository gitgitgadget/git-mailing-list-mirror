Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598A2EA494
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370299; cv=none; b=uBi0U+VGoakT3nhHnhof+jiJSP3NaK1HPED9hKNRaSgxLS2py6gn27lTr4DTHs7l+G4XhdvA7q+ujjH/ucmUgFYnrwmQvvH3j0RJdHZBZfwWNxXfq1b0PJ9PIgZnSCUctm11+saIox6zSITDlmT0cP99SHiLVg34IMMO5mqF/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370299; c=relaxed/simple;
	bh=FUQd1wPfPbsUPtlgxfrEaGzm0AAsbTOKk4JP4SoxSgs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Q9oqysng3seBu60TAyoIzUt9J09PyR+al3+yElFw9VrNKk5BlDjoaJ9EPM1an8fUx6Ntx9prxZp/RL6BRe0Vy7CcuzoiGbpbE7erG1Uv/XnM69gx2l0zjK/aOX8gzaXvhK/HvA2ld9uO+A27RZll+EziwiFNewLtRYcKIc8yV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5y7hHBt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5y7hHBt"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ce772ce0dbso140016f8f.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756370295; x=1756975095; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8jNkT0+DF4yUmtQPRot3G1k2OK4+60xKiP/elIdU4Y=;
        b=D5y7hHBtwx91gsYZY6YzxkQFrl72Oc3sPQFbH6nrnCx0pvfGOxc8YA/Z9Uek92Een8
         M/qtrD7JSfnaEuTCF5fgQwjzNOobyNUsAWBJrfnFjEyA/8RiyFBa3uDWDzwewzK0T0V/
         yaFq611tbtISQ4ZIWaLV/rVUShlaGsJuS0w8b0KyLKPzgVWUA9JpAb6sDJbsIkDletyQ
         nzxn7VsJ6F9VD55TexO4boGOI7stgX8sZN2Sgya3PjFEp+rzXK5q7YYS2h58Sh3td8pK
         t0EQp12jRKWbMTVIVcTwhlPhOfxG/PoBATHPtiP55qx/KtoRAV+Gk+oxaDffBpzNW8RU
         qFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370295; x=1756975095;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8jNkT0+DF4yUmtQPRot3G1k2OK4+60xKiP/elIdU4Y=;
        b=ZMnXuhlXtX8oLgUSV+GRI587sNtGvnyeIsx94SZdwnOdNCqRgI6CkelrYhGvEhnRb+
         ULCzECijMCTLm2nCLfh4iX4HQciZYsKdgnTqlJA7ezLpIGStniNDh/a+Sz65cgLcMRun
         QK6BznXwa2iZxOv9XsP9zRIeojj3FQuYXEbZ36NF52Gtniw4b0ZTHpK9tYDEz1/apBv8
         mjEOPSlUhK6Ww1Bs4g1zVnL9lzaSH1bUOwBUBv/HmFUkubc/mZhdDmf+mHPXMIZqTVYH
         JGerT9CFOoPtVMvfslJzj9wSDY5uDCPxK8KyvU7EfFfbt1f9V5aQG36wu7Zmu9DCMZBF
         brwQ==
X-Gm-Message-State: AOJu0Yz965XH6kfQf10he+fdd9Wvzulaq475cIUOgxI9Qb0dgpVwzGN3
	GfyoaqbAITtsqJfeDkRddTtOQ2XwBpcoK9YEZhO6rZdhKlLFeup+E5wswRcGUQ==
X-Gm-Gg: ASbGncu5JmkpCUnK2QND7XN94Z5kBc7320L4OCb3MNlLuF6VSsRbe0+Tl6rYxxav2iZ
	xd6J4ovcEdlA5S7R+gK6JpEowcX/YN/loRsRWux9deJdEY3jDUx3r2KiC7cDmc17bE0WAuJHJpd
	DS9jwJAad6zDSxB1YxLfaQh7+J+ezvgzbB8YLCPJFLoL6p3zWPnssOrJk0pOiCA8u4vMUOChYl7
	AP/RwJRriswyJ+r+3I2dHprj0ORP8q1VuokZeo/6ROf7iK72MIehthCb+579+BmYfB51djRjJjr
	jXtj2vECeFJPSHLQUkyTx7lNe58oknHE5rJjNPg1LR+MlSzrzORo0h79hoPda0+32oHiV0wfa3s
	xNJPkBUOhkNhvnAy1TTDIQptC6TbLK0NOFY9veQ==
X-Google-Smtp-Source: AGHT+IEPs0/aJtyes6CMTqQXRfjD+asuhF73SA+DH6eErXpJtCKGJWmbd7zON4PSJFs9LMMR909X0g==
X-Received: by 2002:a5d:5886:0:b0:3c0:7e02:67b8 with SMTP id ffacd0b85a97d-3c5dcefe359mr16306864f8f.60.1756370295062;
        Thu, 28 Aug 2025 01:38:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211b19sm24388336f8f.39.2025.08.28.01.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:38:13 -0700 (PDT)
Message-Id: <c81f920fee0ed8672783728fae70b6435e800f82.1756370289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
	<pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
From: "pcasaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:38:08 +0000
Subject: [PATCH v2 2/2] range-diff: add configurable memory limit for cost
 matrix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Paulo Casaretto <pcasaretto@gmail.com>,
    pcasaretto <paulo.casaretto@shopify.com>

From: pcasaretto <paulo.casaretto@shopify.com>

When comparing large commit ranges (e.g., 250,000+ commits), range-diff
attempts to allocate an n×n cost matrix that can exhaust available
memory. For example, with 256,784 commits (n = 513,568), the matrix
would require approximately 256GB of memory (513,568² × 4 bytes),
causing either immediate segmentation faults due to integer overflow or
system hangs.

Add a memory limit check in get_correspondences() before allocating the
cost matrix. This check uses the total size in bytes (n² × sizeof(int))
and compares it against a configurable maximum, preventing both
excessive memory usage and integer overflow issues.

The limit is configurable via a new --max-memory option that accepts
human-readable sizes (e.g., "1G", "500M"). The default is 4GB for 64 bit
systems and 2GB for 32 bit systems. This allows comparing ranges of
approximately 32,000 (16,000) commits - generous for real-world use cases
while preventing impractical operations.

When the limit is exceeded, range-diff now displays a clear error
message showing both the requested memory size and the maximum allowed,
formatted in human-readable units for better user experience.

Example usage:
  git range-diff --max-memory=1G branch1...branch2
  git range-diff --max-memory=500M base..topic1 base..topic2

This approach was chosen over alternatives:
- Pre-counting commits: Would require spawning additional git processes
  and reading all commits twice
- Limiting by commit count: Less precise than actual memory usage
- Streaming approach: Would require significant refactoring of the
  current algorithm

This issue was previously discussed in:
https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com/

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>
---
 builtin/log.c        |  1 +
 builtin/range-diff.c | 21 +++++++++++++++++++++
 log-tree.c           |  1 +
 range-diff.c         | 20 ++++++++++++++++----
 range-diff.h         |  5 +++++
 5 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c2f8bbf86301..5f552d14c0fe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1404,6 +1404,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		struct range_diff_options range_diff_opts = {
 			.creation_factor = rev->creation_factor,
 			.dual_color = 1,
+			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
 			.other_arg = &other_arg
 		};
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 283583a80d0b..79956d83e400 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
+#include "parse.h"
 
 
 static const char * const builtin_range_diff_usage[] = {
@@ -15,6 +16,21 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
+static int parse_max_memory(const struct option *opt, const char *arg, int unset)
+{
+	size_t *max_memory = opt->value;
+	uintmax_t val;
+
+	if (unset)
+		return 0;
+
+	if (!git_parse_unsigned(arg, &val, SIZE_MAX))
+		return error(_("invalid max-memory value: %s"), arg);
+
+	*max_memory = (size_t)val;
+	return 0;
+}
+
 int cmd_range_diff(int argc,
 		   const char **argv,
 		   const char *prefix,
@@ -25,6 +41,7 @@ int cmd_range_diff(int argc,
 	struct strvec diff_merges_arg = STRVEC_INIT;
 	struct range_diff_options range_diff_opts = {
 		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
+		.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 		.diffopt = &diffopt,
 		.other_arg = &other_arg
 	};
@@ -37,6 +54,10 @@ int cmd_range_diff(int argc,
 				  N_("style"), N_("passed to 'git log'"), 0),
 		OPT_BOOL(0, "left-only", &left_only,
 			 N_("only emit output related to the first range")),
+		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
+			     N_("size"),
+			     N_("maximum memory for cost matrix (default 4G)"),
+			     parse_max_memory),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
 		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
diff --git a/log-tree.c b/log-tree.c
index 233bf9f227c6..73d21f71764e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -717,6 +717,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 		struct range_diff_options range_diff_opts = {
 			.creation_factor = opt->creation_factor,
 			.dual_color = 1,
+			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts
 		};
 
diff --git a/range-diff.c b/range-diff.c
index 8a2dcbee322e..e31f71c73d20 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -325,13 +325,24 @@ static int diffsize(const char *a, const char *b)
 }
 
 static void get_correspondences(struct string_list *a, struct string_list *b,
-				int creation_factor)
+				int creation_factor, size_t max_memory)
 {
 	int n = a->nr + b->nr;
 	int *cost, c, *a2b, *b2a;
 	int i, j;
-
-	ALLOC_ARRAY(cost, st_mult(n, n));
+	size_t cost_size = st_mult(n, n);
+	size_t cost_bytes = st_mult(sizeof(int), cost_size);
+	if (cost_bytes >= max_memory) {
+		struct strbuf cost_str = STRBUF_INIT;
+		struct strbuf max_str = STRBUF_INIT;
+		strbuf_humanise_bytes(&cost_str, cost_bytes);
+		strbuf_humanise_bytes(&max_str, max_memory);
+		die(_("range-diff: unable to compute the range-diff, since it "
+		      "exceeds the maximum memory for the cost matrix: %s "
+		      "(%"PRIuMAX" bytes) needed, %s (%"PRIuMAX" bytes) available"),
+		    cost_str.buf, (uintmax_t)cost_bytes, max_str.buf, (uintmax_t)max_memory);
+	}
+	ALLOC_ARRAY(cost, cost_size);
 	ALLOC_ARRAY(a2b, n);
 	ALLOC_ARRAY(b2a, n);
 
@@ -591,7 +602,8 @@ int show_range_diff(const char *range1, const char *range2,
 	if (!res) {
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2,
-				    range_diff_opts->creation_factor);
+				    range_diff_opts->creation_factor,
+				    range_diff_opts->max_memory);
 		output(&branch1, &branch2, range_diff_opts);
 	}
 
diff --git a/range-diff.h b/range-diff.h
index cd85000b5a0d..9d39818e349c 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -5,6 +5,10 @@
 #include "strvec.h"
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
+#define RANGE_DIFF_MAX_MEMORY_DEFAULT \
+	(sizeof(void*) >= 8 ? \
+		((size_t)(1024L * 1024L) * (size_t)(4L * 1024L)) : /* 4GB on 64-bit */ \
+		((size_t)(1024L * 1024L) * (size_t)(2L * 1024L)))   /* 2GB on 32-bit */
 
 /*
  * A much higher value than the default, when we KNOW we are comparing
@@ -17,6 +21,7 @@ struct range_diff_options {
 	unsigned dual_color:1;
 	unsigned left_only:1, right_only:1;
 	unsigned include_merges:1;
+	size_t max_memory;
 	const struct diff_options *diffopt; /* may be NULL */
 	const struct strvec *other_arg; /* may be NULL */
 };
-- 
gitgitgadget
