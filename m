Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9125DB1A
	for <git@vger.kernel.org>; Wed,  7 May 2025 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624301; cv=none; b=DuF+rhnMrMie7/H7tX3WKTAfnvKRDioSoas1W2N8VSLYX6Pny29u3ai8fbke4wovYTxbEdDhsJ/LJw366An7DAOYsrQpc/38H18TLrZIURYHYhE/06Au+/x7o7K8XWxmLZhYGSmEzRtsaZYDKi6m102fpE8JWNVfl2sf8n1JLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624301; c=relaxed/simple;
	bh=ZZoMXXMWSnehDrGw9bInY5hRYLU3Krv/jE/5hoTu3KU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OeV4TrK86C2HfxwKuB7yZ6EHb4AYtri8Oo4zbbabVzvIBqT89u7ilP1NTfjCkzkOMqVazmlI4dcEJB8Gad442bZFUQaDOmakIlMtuDiuiFYR8yvCJShpQZ8jlVVSfAvcHhUIIc6vk0xM1tXVaKeqM3qnEM9dHzj/SnJqksF2BmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZegvp8P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZegvp8P"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so1395245e9.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746624296; x=1747229096; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cauvL0Rr624g0eW9h9xVV7JHL3gs+HPVWJXT+yMQwKU=;
        b=aZegvp8P5JXDCwjTfw6fkfhhZM1XKkLLMvqducw6O6cxXLpEII6mYjeNzfLvnY/s6s
         pTgy/gj9VBlU6nlZ/EWfM7L4NgXWXPUVCyeWsvy8lQx7QC/Fr5YQl5W8L9f0cDJMIyH5
         Gjq0owq/vFYpt1djs6eM/7i3IdRreVBN5hgKHZGxsMK9uMdkzlzwKwgjznFrWWYI4kaS
         2RFvrjgOUpUunpLApqaIVvVBO+XeJ+6zd0a1dVq0pqDOcd18yU+tu/B8yaxnIdw6LCmR
         iQum08fm10TZpkPi+HT45Wev7C8dGI1oggll9uODNbfreyLpPPWbt3zpdxMoVEWpikH+
         K06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624296; x=1747229096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cauvL0Rr624g0eW9h9xVV7JHL3gs+HPVWJXT+yMQwKU=;
        b=aV2ua0m/Zc/S8vq9J+S7saQByACHptiPymaWXwiKjkZWKmFdDfQ8POjVfPaXv43HE/
         4UM0wUYiRCdYdatLNmLvn6GU7t+0cn38Q1sT1ZbGaQQlk9gTHs7QtfuC5VvJet/2b5cf
         TqQrwyPgAlO3LSnV/cMsRo8PTzsAuhqMx0+fzgw2tt9vvfW5L6+PN2/2V3HCdk6UEyDN
         jMfcPr6L2BoDH8tqGntst/is5hJMiq8d9fL1PgdyvVicIIUyKYmsv/I9piZ7qaKN9rjr
         DWrEkr3JoyeoC8vNUP3WjeWmB3eTjK43HWe0bEZXzNTd/kNCUIx1AqkqI0rfxTnxQLLv
         oP8w==
X-Gm-Message-State: AOJu0YxtkylTMAlnicYS7FjpEcCcr0UrVlFt05+EjpJGyGbszNR/HaEe
	+TMnkQHzoTwYe7glh3zaymbyO8BZt2DbyA7LDyBvren/7VCwbbMG2CUkRQ==
X-Gm-Gg: ASbGncsqrETd96TFFWjC0yPqTpG8eyPwONH+cqVs03+pONvcTVmFT7qiUo7QRNsZZJ3
	beaIw0X/D6oubsctoEJ/ANXp6x8cCL6JFSMkFBZD+Z86TuC9Uo2HjDkgKFK9zyx8cdeT/YDbv97
	DSsKshn+F5/+9a6geC826614lMfcIVHZSA7yQ/ceeh0Dp0lyKC1W3Of3OkM2bZyOdZVZ7cEUF7z
	NK4DwMBRtWNX8TGXZLWKhrABGw9zV56sLz4bHVG4w4xXf1Vnfs1tpau99iLufCZWfd7sVbJ9G95
	vj+veGGgyqh0ulI5Su10rPbkjq3TDjTZZeg0HL9qZA==
X-Google-Smtp-Source: AGHT+IF7YIwahgCBd0BLrWSS3m4OTNY5QJqiSgCdeiX7oB6D+WTZj+W2XBl2s908WlQv3Ct1ntCY0A==
X-Received: by 2002:a05:600c:1d08:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-441d44c75b0mr31252025e9.15.1746624295510;
        Wed, 07 May 2025 06:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd350f56sm897625e9.21.2025.05.07.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:24:55 -0700 (PDT)
Message-Id: <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>
In-Reply-To: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 13:24:53 +0000
Subject: [PATCH v2] parse-options: fix xstrdup leak in parse_options_step
 parse-options:984
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

Most Git commands use parse_options to parse options, but parse_options
causes a memory leak when it encounters unknown short options. The leak
occurs at line 984 in parse-options.c, where git allocates some spaces
to store the unknown short options and will never release those spaces.

To address this issue, users can be allowed to provide a custom function
to allocate memory for unknown options. For example, users can use
strvec_push to allocate memory for unknown options and later call
strvec_clear at the end of the Git command to release the memory, thereby
avoiding the memory leak.

This commit allows users to provide a custom allocation function for
unknown options via the strdup_fn field in the last struct option. For
convenience, this commit also introduces a new macro, OPT_UNKNOWN, which
behaves like OPT_END but takes an additional argument for the allocation
function. parse_options could get the custom allocation function in struct
parse_opt_ctx_t by using set_strdup_fn. A simple example to use
OPT_UNKNOWN is put into t/helper/test-free-unknown-options.c

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    fix xstrdup leak in parse_short_opt
    
    Pass a user defined strdup-like function in parse_opt_ctx to avoid
    memory leak.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1954%2Fbrandb97%2Ffix-parse-option-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1954/brandb97/fix-parse-option-leak-v2
Pull-Request: https://github.com/git/git/pull/1954

Range-diff vs v1:

 1:  b34445d166c ! 1:  e7b4465b83e fix xstrdup leak in parse_short_opt
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    fix xstrdup leak in parse_short_opt
     +    parse-options: fix xstrdup leak in parse_options_step parse-options:984
     +
     +    Most Git commands use parse_options to parse options, but parse_options
     +    causes a memory leak when it encounters unknown short options. The leak
     +    occurs at line 984 in parse-options.c, where git allocates some spaces
     +    to store the unknown short options and will never release those spaces.
     +
     +    To address this issue, users can be allowed to provide a custom function
     +    to allocate memory for unknown options. For example, users can use
     +    strvec_push to allocate memory for unknown options and later call
     +    strvec_clear at the end of the Git command to release the memory, thereby
     +    avoiding the memory leak.
     +
     +    This commit allows users to provide a custom allocation function for
     +    unknown options via the strdup_fn field in the last struct option. For
     +    convenience, this commit also introduces a new macro, OPT_UNKNOWN, which
     +    behaves like OPT_END but takes an additional argument for the allocation
     +    function. parse_options could get the custom allocation function in struct
     +    parse_opt_ctx_t by using set_strdup_fn. A simple example to use
     +    OPT_UNKNOWN is put into t/helper/test-free-unknown-options.c
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
     @@ parse-options.c: static int has_subcommands(const struct option *options)
       	return 0;
       }
       
     -+static void set_strdup_fn(struct parse_opt_ctx_t *ctx, const struct option *options) {
     ++static void set_strdup_fn(struct parse_opt_ctx_t *ctx,
     ++			  const struct option *options)
     ++{
      +	for (; options->type != OPTION_END; options++)
      +		;
      +	if (options->value && options->strdup_fn) {
     @@ parse-options.c: enum parse_opt_result parse_options_step(struct parse_opt_ctx_t
       					 */
      -					ctx->argv[0] = xstrdup(ctx->opt - 1);
      +					if (ctx->unknown_opts && ctx->strdup_fn) {
     -+						ctx->argv[0] = ctx->strdup_fn(ctx->unknown_opts, ctx->opt - 1);
     ++						ctx->argv[0] =
     ++							ctx->strdup_fn(ctx->unknown_opts,
     ++								       ctx->opt -
     ++									       1);
      +					} else {
     -+						ctx->argv[0] = xstrdup(ctx->opt - 1);
     ++						ctx->argv[0] =
     ++							xstrdup(ctx->opt - 1);
      +					}
       					*(char *)ctx->argv[0] = '-';
       					goto unknown;
     @@ parse-options.h: static char *parse_options_noop_ignored_value MAYBE_UNUSED;
       }
       #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
       
     -+#define OPT_UNKNOWN(v, fn) { \
     -+	.type = OPTION_END, \
     -+	.value = (v), \
     -+	.strdup_fn = (fn), \
     -+}
     ++#define OPT_UNKNOWN(v, fn)          \
     ++	{                           \
     ++		.type = OPTION_END, \
     ++		.value = (v),       \
     ++		.strdup_fn = (fn),  \
     ++	}
      +
       /*
        * parse_options() will filter out the processed options and leave the
     @@ parse-options.h: struct parse_opt_ctx_t {
       	const char *prefix;
       	const char **alias_groups; /* must be in groups of 3 elements! */
       	struct parse_opt_cmdmode_list *cmdmode_list;
     -+
      +	void *unknown_opts;
      +	parse_opt_strdup_fn *strdup_fn;
       };
     @@ t/helper/test-free-unknown-options.c (new)
      +#include "parse-options.h"
      +#include "setup.h"
      +#include "strvec.h"
     ++#include "test-tool.h"
      +
      +static const char *const free_unknown_options_usage[] = {
     -+    "test-tool free-unknown-options",
     -+    NULL
     ++	"test-tool free-unknown-options", NULL
      +};
      +
     -+int cmd__free_unknown_options(int argc, const char **argv) {
     -+    struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
     -+    strvec_init(unknown_opts);
     -+    const char *prefix = setup_git_directory();
     ++static char *strvec_push_wrapper(void *value, const char *str)
     ++{
     ++	struct strvec *sv = value;
     ++	return (char *)strvec_push(sv, str);
     ++}
      +
     -+    bool a, b;
     ++int cmd__free_unknown_options(int argc, const char **argv)
     ++{
     ++	struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
     ++	const char *prefix = setup_git_directory();
     ++	int a = 0, b = 0;
     ++	size_t i;
      +	struct option options[] = {
      +		OPT_BOOL('a', "test-a", &a, N_("option a, only for test use")),
     -+	OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
     -+	OPT_UNKNOWN(unknown_opts, (parse_opt_strdup_fn *)&strvec_push),
     ++		OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
     ++		OPT_UNKNOWN(unknown_opts, strvec_push_wrapper),
      +	};
      +
     -+    parse_options(argc, argv, prefix, options,
     -+	free_unknown_options_usage, PARSE_OPT_KEEP_UNKNOWN_OPT);
     ++	strvec_init(unknown_opts);
     ++	parse_options(argc, argv, prefix, options, free_unknown_options_usage,
     ++		      PARSE_OPT_KEEP_UNKNOWN_OPT);
      +
     -+    printf("a = %s\n", a? "true": "false");
     -+    printf("b = %s\n", b? "true": "false");
     ++	printf("a = %s\n", a ? "true" : "false");
     ++	printf("b = %s\n", b ? "true" : "false");
      +
     -+    int i;
     -+    for (i = 0; i < unknown_opts->nr; i++) {
     -+	printf("free unknown option: %s\n", unknown_opts->v[i]);
     -+    }
     -+    strvec_clear(unknown_opts);
     -+    free(unknown_opts);
     ++	for (i = 0; i < unknown_opts->nr; i++)
     ++		printf("free unknown option: %s\n", unknown_opts->v[i]);
     ++	strvec_clear(unknown_opts);
     ++	free(unknown_opts);
     ++
     ++	return 0;
      +}
     - \ No newline at end of file
      
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
       	{ "parse-options-flags", cmd__parse_options_flags },
       	{ "parse-pathspec-file", cmd__parse_pathspec_file },
       	{ "parse-subcommand", cmd__parse_subcommand },
     -+	{ "free-unknown-options", cmd__free_unknown_options},
     ++	{ "free-unknown-options", cmd__free_unknown_options },
       	{ "partial-clone", cmd__partial_clone },
       	{ "path-utils", cmd__path_utils },
       	{ "path-walk", cmd__path_walk },
     @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
       	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
       '
       
     -+cat >expect <<\EOF
     -+a = true
     -+b = true
     -+free unknown option: -c
     -+free unknown option: -d
     -+EOF
     -+
      +test_expect_success 'free unknown options' '
      +	test-tool free-unknown-options -ac -bd \
      +	>output 2>output.err &&
     ++	cat >expect <<-\EOF &&
     ++	a = true
     ++	b = true
     ++	free unknown option: -c
     ++	free unknown option: -d
     ++	EOF
      +	test_cmp expect output &&
      +	test_must_be_empty output.err
      +'
 2:  7a5e2f29529 < -:  ----------- fix: replace bug where int was incorrectly used as bool
 3:  a9cbca6bed3 < -:  ----------- fix: use strvec_push_wrapper to prevent ubsan failure


 Makefile                             |  1 +
 parse-options.c                      | 23 ++++++++++++++-
 parse-options.h                      | 12 ++++++++
 t/helper/meson.build                 |  1 +
 t/helper/test-free-unknown-options.c | 42 ++++++++++++++++++++++++++++
 t/helper/test-tool.c                 |  1 +
 t/helper/test-tool.h                 |  1 +
 t/t0040-parse-options.sh             | 13 +++++++++
 8 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-free-unknown-options.c

diff --git a/Makefile b/Makefile
index 8a7f1c76543..af8ea677b82 100644
--- a/Makefile
+++ b/Makefile
@@ -822,6 +822,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
+TEST_BUILTINS_OBJS += test-free-unknown-options.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-path-walk.o
diff --git a/parse-options.c b/parse-options.c
index a9a39ecaef6..12721b83000 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -638,6 +638,18 @@ static int has_subcommands(const struct option *options)
 	return 0;
 }
 
+static void set_strdup_fn(struct parse_opt_ctx_t *ctx,
+			  const struct option *options)
+{
+	for (; options->type != OPTION_END; options++)
+		;
+	if (options->value && options->strdup_fn) {
+		ctx->unknown_opts = options->value;
+		ctx->strdup_fn = options->strdup_fn;
+		return;
+	}
+}
+
 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 				  int argc, const char **argv, const char *prefix,
 				  const struct option *options,
@@ -655,6 +667,7 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
 	ctx->has_subcommands = has_subcommands(options);
+	set_strdup_fn(ctx, options);
 	if (!ctx->has_subcommands && (flags & PARSE_OPT_SUBCOMMAND_OPTIONAL))
 		BUG("Using PARSE_OPT_SUBCOMMAND_OPTIONAL without subcommands");
 	if (ctx->has_subcommands) {
@@ -981,7 +994,15 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 *
 					 * This is leaky, too bad.
 					 */
-					ctx->argv[0] = xstrdup(ctx->opt - 1);
+					if (ctx->unknown_opts && ctx->strdup_fn) {
+						ctx->argv[0] =
+							ctx->strdup_fn(ctx->unknown_opts,
+								       ctx->opt -
+									       1);
+					} else {
+						ctx->argv[0] =
+							xstrdup(ctx->opt - 1);
+					}
 					*(char *)ctx->argv[0] = '-';
 					goto unknown;
 				case PARSE_OPT_NON_OPTION:
diff --git a/parse-options.h b/parse-options.h
index 91c3e3c29b3..57037bd381a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -77,6 +77,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
 typedef int parse_opt_subcommand_fn(int argc, const char **argv,
 				    const char *prefix, struct repository *repo);
 
+typedef char *parse_opt_strdup_fn(void *value, const char *s);
+
 /*
  * `type`::
  *   holds the type of the option, you must have an OPTION_END last in your
@@ -165,6 +167,7 @@ struct option {
 	parse_opt_ll_cb *ll_callback;
 	intptr_t extra;
 	parse_opt_subcommand_fn *subcommand_fn;
+	parse_opt_strdup_fn *strdup_fn;
 };
 
 #define OPT_BIT_F(s, l, v, h, b, f) { \
@@ -388,6 +391,13 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
 }
 #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
 
+#define OPT_UNKNOWN(v, fn)          \
+	{                           \
+		.type = OPTION_END, \
+		.value = (v),       \
+		.strdup_fn = (fn),  \
+	}
+
 /*
  * parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. argv0 is assumed program name and
@@ -496,6 +506,8 @@ struct parse_opt_ctx_t {
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
 	struct parse_opt_cmdmode_list *cmdmode_list;
+	void *unknown_opts;
+	parse_opt_strdup_fn *strdup_fn;
 };
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
diff --git a/t/helper/meson.build b/t/helper/meson.build
index d2cabaa2bcf..476e3278176 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -39,6 +39,7 @@ test_tool_sources = [
   'test-pack-mtimes.c',
   'test-parse-options.c',
   'test-parse-pathspec-file.c',
+  'test-free-unknown-options.c',
   'test-partial-clone.c',
   'test-path-utils.c',
   'test-path-walk.c',
diff --git a/t/helper/test-free-unknown-options.c b/t/helper/test-free-unknown-options.c
new file mode 100644
index 00000000000..7369dfe379d
--- /dev/null
+++ b/t/helper/test-free-unknown-options.c
@@ -0,0 +1,42 @@
+#include "git-compat-util.h"
+#include "parse-options.h"
+#include "setup.h"
+#include "strvec.h"
+#include "test-tool.h"
+
+static const char *const free_unknown_options_usage[] = {
+	"test-tool free-unknown-options", NULL
+};
+
+static char *strvec_push_wrapper(void *value, const char *str)
+{
+	struct strvec *sv = value;
+	return (char *)strvec_push(sv, str);
+}
+
+int cmd__free_unknown_options(int argc, const char **argv)
+{
+	struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
+	const char *prefix = setup_git_directory();
+	int a = 0, b = 0;
+	size_t i;
+	struct option options[] = {
+		OPT_BOOL('a', "test-a", &a, N_("option a, only for test use")),
+		OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
+		OPT_UNKNOWN(unknown_opts, strvec_push_wrapper),
+	};
+
+	strvec_init(unknown_opts);
+	parse_options(argc, argv, prefix, options, free_unknown_options_usage,
+		      PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	printf("a = %s\n", a ? "true" : "false");
+	printf("b = %s\n", b ? "true" : "false");
+
+	for (i = 0; i < unknown_opts->nr; i++)
+		printf("free unknown option: %s\n", unknown_opts->v[i]);
+	strvec_clear(unknown_opts);
+	free(unknown_opts);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 50dc4dac4ed..5af5acae1cb 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -51,6 +51,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options-flags", cmd__parse_options_flags },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "parse-subcommand", cmd__parse_subcommand },
+	{ "free-unknown-options", cmd__free_unknown_options },
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
 	{ "path-walk", cmd__path_walk },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6d62a5b53d9..33fa7828b9f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -44,6 +44,7 @@ int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_options_flags(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__parse_subcommand(int argc, const char **argv);
+int cmd__free_unknown_options(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__path_walk(int argc, const char **argv);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ca55ea8228c..df221be5d18 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -822,4 +822,17 @@ test_expect_success 'u16 limits range' '
 	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
 '
 
+test_expect_success 'free unknown options' '
+	test-tool free-unknown-options -ac -bd \
+	>output 2>output.err &&
+	cat >expect <<-\EOF &&
+	a = true
+	b = true
+	free unknown option: -c
+	free unknown option: -d
+	EOF
+	test_cmp expect output &&
+	test_must_be_empty output.err
+'
+
 test_done

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
