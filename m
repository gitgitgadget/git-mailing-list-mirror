Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6D31A56C
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228699; cv=none; b=bDqHaPqSr13JDFzxQpN4uFnOiJBGEam9tgtcCeQeY6NwVAl2Q/l5wiCRgAAjF/5X7H0Et8Iei3LWfnVoDuQwuOlJHQwQ2SgoUDkVOSlbf0loWAIPyx2N71quppsIjzMYo+47aWxYubTv/FWaSzGNBh9Mkb2IP8JGUSTopxUEkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228699; c=relaxed/simple;
	bh=sVhUAcJ9iZuuDdIiSJqWijSh0J+n+KrkB8LNM1dF0sc=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=IxxqxWdiybAv+AMA9nwLSFs6BNcAVyrFimDBb4OwR3zOMGPRUqoP6lgfNfhQMPNPCLuga2HK0JMzhJIgqZGPYe1OYV0jCOEyKKtfmO2V8RqtX344DDE9lyqrCmz46y/Dt7BO7s4gGbwOhVnjWbwcafCkZm5VEH6oMM/TgfcsP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXUx4QXK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXUx4QXK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4a25ccceso35173225e9.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756228695; x=1756833495; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cy4XTI84Aw2l6T209wm2/WTT78vjZV66JTP1pMM8x/A=;
        b=hXUx4QXK2pyMX5r/xHSwEVoTIv1QJqozSKKPVrElogBqtE9+l1lXdmuzR3tMxej3Fg
         Zg6rROUmuzViZ9GJrJlLW4Wc+atUYw2TRTDZCH0eR34VdlpBX8gxkwJsTo+Ww+OzsaHp
         P+1gTfFHusTkW8SA/vbhtyA2P88/fDWPtoKoxeDW3csE1QjjcOef2kGV58R7BUrQP9CJ
         vuyaeatOKWDZdiLzSPeDWR1zh9Pl+4CNM4ppUL/xgeOKfGR5ikZj7Kk50vxmCcHEy77C
         DbGEce5OJAPXapvTYfg/TtM4KfJU9tW15pV5qkbVuj8fKhFwN7HMzfb/T6LEY7NmL6b9
         XF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756228695; x=1756833495;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cy4XTI84Aw2l6T209wm2/WTT78vjZV66JTP1pMM8x/A=;
        b=MgTda3ogK1UXjtjkW57R0i2PtqvXhmtvqka/5n9UNvs66IG5PZr9/MgQX7c4bREXpe
         QPzg4uId/iJ20DoxDo1kEmvIsapBwOArf2XichUL+hTPFH7EFjnbJ1MExioCVXChXzul
         HnUOqAS0WLTmdK9FlNDPGOtHyCQ0S0QIUagEMZMgDDOWCZyGpbAyYohQwIVpoBNGGBJ6
         bP+cf1NiA/Ic+NYP9j0GAIQFMHj90vkQJkgqUiCPDl6yXYw97uJldk0M9zuGWTYv7/8r
         QEBangeuemSe5oO/ImXjEbpNALK5iQG/Ni8ToIF2MLA2zvL5qLoqOWFjrzn3myhS9OkA
         DmuA==
X-Gm-Message-State: AOJu0YyhM2bLgZyEKvrJjaRzPfIPFlRX5fS91qpD6xWBK6EOM9Ro6ALo
	M7J8jPicggQg0uOiW1H5Ln6IbhQIiDmNik+3RnN69wPRvBG6i0/YKOtQ4yDAQg==
X-Gm-Gg: ASbGncuCRaxwqQGsI3b8sDf0Z128atwM+OTc4FAZxRafH0dq5dQSvWgt7boSfxDX/AJ
	e/LN2KoEIXiWq0Ki8m5FOq9YaIsq+uKa+m+AyqS6VewBCwpjunPihg3HnabLexJRKdNfWBfgy5f
	OT/69evZOmvN4aBPVK2YqpzgaZVTTn6HPFS/sOooujkR0nr9B/9w2zWvHE0SlZWLrFxD59XpLEr
	h6vSeCWrsvd8FgBRR2AUbJAQIzvGFbopAjhAS0z+deRD345VwNpdTKoKdHhAJ0cUqkg4vINcyNr
	/dS1+0Bk0JXJ1FB/7Hp/r3HZU3wHs4A4yN3I8ULPdqm6L2xnrCPpZS+R9Bks7UBwqspRERjQblD
	XzAKHk1AcfEJz3C+OVElvosaa4F3bY0CKEYkWbQ==
X-Google-Smtp-Source: AGHT+IEZh9ZAkxKxMRobM3Kp1s4IvDjWsXEV/GsRHihXJAO88P22tkfr8D5VQS7UZ0qe39M04Zn1gA==
X-Received: by 2002:a05:600c:630c:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45b517cfe7dmr129163535e9.20.1756228694657;
        Tue, 26 Aug 2025 10:18:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6c5cef78sm703195e9.13.2025.08.26.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:18:14 -0700 (PDT)
Message-Id: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
From: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 17:18:13 +0000
Subject: [PATCH] range-diff: add configurable memory limit for cost matrix
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

Acked-by: Johannes Schindelin johannes.schindelin@gmx.de
Signed-off-by: pcasaretto <paulo.casaretto@shopify.com>
---
    range-diff: add configurable memory limit for cost matrix
    
    
    Problem Description
    ===================
    
    When git range-diff is given extremely large ranges, it can result in
    either:
    
     1. Segmentation fault due to integer overflow in array index
        calculations
     2. Excessive memory consumption leading to system hangs or OOM kills
     3. Poor user experience with the command appearing to hang for minutes
    
    
    Reproduction Case
    =================
    
    In a Shopify's large monorepo a range-diff command like this crashes
    after several minutes with a SIGBUS error
    
    $ git range-diff 4430f36511..316c1276c6 cb5240b6a8..2bbd292091
    
    
    Range statistics:
    
     * First range: 256,783 commits
     * Second range: 1 commit
     * Total: 256,784 commits
     * Memory required for cost matrix: n² × 4 bytes = ~260GB
    
    
    Stack Trace (Segmentation Fault)
    ================================
    
    (lldb) bt
    * thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=2, address=0x6e000ae3b8)
      * frame #0: 0x000000010029a284 git`get_correspondences(a=0x000000016fde6188, b=0x000000016fde6160, creation_factor=60) at range-diff.c:356:20
        frame #1: 0x0000000100299310 git`show_range_diff(range1="4430f36511cbacf5c517c6851e2b8508a72dfd30..316c1276c63f55ad9413fa18bf3b6483564a9cf4", range2="cb5240b6a8ba59b4a1f282559ee0742721b0cafc..2bbd292091e376d177ce62e264dae8872ca6be5a", range_diff_opts=0x000000016fde6308) at range-diff.c:593:3
        frame #2: 0x00000001000c719c git`cmd_range_diff(argc=2, argv=0x0000600000bcd8c0, prefix="areas/core/shopify/", repo=0x0000000100468b20) at range-diff.c:167:8
        frame #3: 0x000000010000277c git`run_builtin(p=0x00000001004408d8, argc=3, argv=0x0000600000bcd8c0, repo=0x0000000100468b20) at git.c:480:11
        frame #4: 0x0000000100001020 git`handle_builtin(args=0x000000016fde6c70) at git.c:746:9
        frame #5: 0x0000000100002074 git`run_argv(args=0x000000016fde6c70) at git.c:813:4
        frame #6: 0x0000000100000d3c git`cmd_main(argc=3, argv=0x000000016fde7350) at git.c:953:19
        frame #7: 0x000000010012750c git`main(argc=4, argv=0x000000016fde7348) at common-main.c:9:11
        frame #8: 0x000000018573ab98 dyld`start + 6076
    
    
    
    Root Cause Analysis
    ===================
    
    The crash occurs in get_correspondences() at line 356:
    
    static void get_correspondences(struct string_list *a, struct string_list *b, ...)
    {
        int n = a->nr + b->nr;  // Integer overflow: 256,784 fits in int
        ...
        ALLOC_ARRAY(cost, st_mult(n, n));  // Would allocate ~260GB
        ...
        cost[i + n * j] = c;  // Line 356: Invalid memory access
    }
    
    
    Problems:
    
     1. Integer overflow: While n=256,784 fits in an int, n*n overflows
     2. Memory allocation: Even with proper types, allocating 260GB is
        impractical
    
    
    Solution
    ========
    
    Add a memory limit check in get_correspondences() before allocating the
    cost matrix. This check uses the total size in bytes (n² × sizeof(int))
    and compares it against a configurable maximum, preventing both
    excessive memory usage and integer overflow issues.
    
    The limit is configurable via a new --max-memory option that accepts
    human-readable sizes (e.g., "1G", "500M"). The default is 4GB for 64 bit
    systems and 2GB for 32 bit systems. This allows comparing ranges of
    approximately 32,000 (16,000) commits - generous for real-world use
    cases while preventing impractical operations.
    
    When the limit is exceeded, range-diff now displays a clear error
    message showing both the requested memory size and the maximum allowed,
    formatted in human-readable units for better user experience.
    
    Example usage: git range-diff --max-memory=1G branch1...branch2 git
    range-diff --max-memory=500M base..topic1 base..topic2
    
    This approach was chosen over alternatives:
    
     * Pre-counting commits: Would require spawning additional git processes
       and reading all commits twice
     * Limiting by commit count: Less precise than actual memory usage
     * Streaming approach: Would require significant refactoring of the
       current algorithm
    
    This issue was previously discussed in:
    https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com/
    
    Acked-by: Johannes Schindelin johannes.schindelin@gmx.de
    [https://github.com/gitgitgadget/git/pull/1958#issuecomment-3224133138]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1958%2Fpcasaretto%2Frange-diff-size-limit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1958/pcasaretto/range-diff-size-limit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1958

 builtin/log.c        |  1 +
 builtin/range-diff.c | 30 ++++++++++++++++++++++++++----
 log-tree.c           |  1 +
 range-diff.c         | 35 +++++++++++++++++++++++++----------
 range-diff.h         |  5 +++++
 5 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c2f8bbf8630..5f552d14c0f 100644
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
index a563abff5fe..10fa82fd285 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
+#include "parse.h"
 
 
 static const char * const builtin_range_diff_usage[] = {
@@ -15,6 +16,22 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
+static int parse_max_memory(const struct option *opt, const char *arg, int unset)
+{
+	size_t *max_memory = opt->value;
+	uintmax_t val;
+
+	if (unset) {
+		return 0;
+	}
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
@@ -25,6 +42,7 @@ int cmd_range_diff(int argc,
 	struct strvec diff_merges_arg = STRVEC_INIT;
 	struct range_diff_options range_diff_opts = {
 		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
+		.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 		.diffopt = &diffopt,
 		.other_arg = &other_arg
 	};
@@ -33,17 +51,21 @@ int cmd_range_diff(int argc,
 		OPT_INTEGER(0, "creation-factor",
 			    &range_diff_opts.creation_factor,
 			    N_("percentage by which creation is weighted")),
+		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
+				  N_("style"), N_("passed to 'git log'"), 0),
+		OPT_BOOL(0, "left-only", &left_only,
+			 N_("only emit output related to the first range")),
+		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
+			     N_("size"),
+			     N_("maximum memory for cost matrix (default 4G)"),
+			     parse_max_memory),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
 		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
-		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
-				  N_("style"), N_("passed to 'git log'"), 0),
 		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
 				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
-		OPT_BOOL(0, "left-only", &left_only,
-			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "right-only", &right_only,
 			 N_("only emit output related to the second range")),
 		OPT_END()
diff --git a/log-tree.c b/log-tree.c
index 233bf9f227c..73d21f71764 100644
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
index 8a2dcbee322..6e9b6b115e5 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -21,6 +21,7 @@
 #include "apply.h"
 #include "revision.h"
 
+
 struct patch_util {
 	/* For the search for an exact match */
 	struct hashmap_entry e;
@@ -287,8 +288,8 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 }
 
 static int diffsize_consume(void *data,
-			     char *line UNUSED,
-			     unsigned long len UNUSED)
+			    char *line UNUSED,
+			    unsigned long len UNUSED)
 {
 	(*(int *)data)++;
 	return 0;
@@ -325,13 +326,24 @@ static int diffsize(const char *a, const char *b)
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
 
@@ -351,7 +363,8 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 		}
 
 		c = a_util->matching < 0 ?
-			a_util->diffsize * creation_factor / 100 : COST_MAX;
+			    a_util->diffsize * creation_factor / 100 :
+			    COST_MAX;
 		for (j = b->nr; j < n; j++)
 			cost[i + n * j] = c;
 	}
@@ -360,7 +373,8 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 		struct patch_util *util = b->items[j].util;
 
 		c = util->matching < 0 ?
-			util->diffsize * creation_factor / 100 : COST_MAX;
+			    util->diffsize * creation_factor / 100 :
+			    COST_MAX;
 		for (i = a->nr; i < n; i++)
 			cost[i + n * j] = c;
 	}
@@ -539,7 +553,7 @@ static void output(struct string_list *a, struct string_list *b,
 		if (i < a->nr && a_util->matching < 0) {
 			if (!range_diff_opts->right_only)
 				output_pair_header(&opts, patch_no_width,
-					   &buf, &dashes, a_util, NULL);
+						   &buf, &dashes, a_util, NULL);
 			i++;
 			continue;
 		}
@@ -548,7 +562,7 @@ static void output(struct string_list *a, struct string_list *b,
 		while (j < b->nr && b_util->matching < 0) {
 			if (!range_diff_opts->left_only)
 				output_pair_header(&opts, patch_no_width,
-					   &buf, &dashes, NULL, b_util);
+						   &buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
@@ -591,7 +605,8 @@ int show_range_diff(const char *range1, const char *range2,
 	if (!res) {
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2,
-				    range_diff_opts->creation_factor);
+				    range_diff_opts->creation_factor,
+				    range_diff_opts->max_memory);
 		output(&branch1, &branch2, range_diff_opts);
 	}
 
diff --git a/range-diff.h b/range-diff.h
index cd85000b5a0..9d39818e349 100644
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

base-commit: 954d33a9757fcfab723a824116902f1eb16e05f7
-- 
gitgitgadget
