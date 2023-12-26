Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C81847
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCtmUOLs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5095834aso27088105e9.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2023 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703619564; x=1704224364; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjZsRAjdIuRs8mkAkJSdTz1YkwmZiv9HPbs2gqkPZOc=;
        b=mCtmUOLsLSOkf5XYaFhhjJySoZdNmEy0SY/h2IvJUUbURYvHwRo7ankG/BA2PgrocD
         PBonCHz8FvBkKvRSvEdW5iRHw28wK6xe0HIDFg32l39e2PYk615n73QxU2u7Oae7CM2j
         bBosT/wZMEUX/chncrnzOH80lJawUJN/z9ErpjD1yNtcIHVB7lx0/pP297jj9h7e/fSb
         e3v+SwRcR8QJfQIZwXIhUt30jmBIN3gqX0wB5Z33zPSqwe5e0DJ+WJFyUjesuBeBolpT
         wQdi8UF4ZA7bn+9VOQp5M8LBvE6EIW3GRgTc1hiDeEY/LPYD5Ov2NWyM2IrsFnC40asX
         hCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703619564; x=1704224364;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjZsRAjdIuRs8mkAkJSdTz1YkwmZiv9HPbs2gqkPZOc=;
        b=VKwzP+VWW09XpzgArM+dGEHvKq8b15KbyHjA94z6Uq4HN8JvJ80RFdvv6odegsVA5K
         lEogXETDUnAt+Cger8liIBjmA8Al/uNtdIn9gIU/K6jRiu/UziXa+dGJkDE1QFD0RGFu
         ixNcjYsZfezpeXVhMlKN/WO6xsoYJLWoEE2NJ8vmn8NuyuwZGHj0sZjen1VenJYagB4l
         WT5vU0oszSrcelMta8McPlLNH7PwcAqcz0GSYmhOaYDuz/hTVY9PQ2ve6GoV33GqTRit
         kAkYPNAwvfh3OURvDPYRstEf5BgNzaX5bA/7sRMQ0q4QGmqFto0+u/tJ/nEGVIi/64QH
         CB8Q==
X-Gm-Message-State: AOJu0YwJ/nniqkYcwrilGluKfe/fFr4LJkrgvgaTaqdAxpqN9pZc6n0V
	N9gxXBkHwgMZPvk90WmKI/UfvZ4l4q8=
X-Google-Smtp-Source: AGHT+IHFMu1vRpRgqlXBjp8h3Az2DoVC8rIXxt3OwLPQAZCZONcdHxNTG/IRw3CGk0Ytrs6GJHT10g==
X-Received: by 2002:a05:600c:5487:b0:40b:5f03:b3c3 with SMTP id iv7-20020a05600c548700b0040b5f03b3c3mr2310069wmb.229.1703619563747;
        Tue, 26 Dec 2023 11:39:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020adff184000000b003368129ecc6sm13121763wro.108.2023.12.26.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:39:23 -0800 (PST)
Message-ID: <pull.1625.v2.git.git.1703619562639.gitgitgadget@gmail.com>
In-Reply-To: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com>
References: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Dec 2023 19:39:22 +0000
Subject: [PATCH v2] sparse-checkout: be consistent with end of options markers
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
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>,
    Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

93851746 (parse-options: decouple "--end-of-options" and "--",
2023-12-06) updated the world order to make callers of parse-options
that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
do with "--end-of-options" they may see after parse_options() returns.

This made a previous bug in sparse-checkout more visible; namely,
that

  git sparse-checkout [add|set] --[no-]cone --end-of-options ...

would simply treat "--end-of-options" as one of the paths to include in
the sparse-checkout.  But this was already problematic before; namely,

  git sparse-checkout [add|set| --[no-]cone --sikp-checks ...

would not give an error on the mis-typed "--skip-checks" but instead
simply treat "--sikp-checks" as a path or pattern to include in the
sparse-checkout, which is highly unfriendly.

This behavior began when the command was converted to parse-options in
7bffca95ea (sparse-checkout: add '--stdin' option to set subcommand,
2019-11-21).  Back then it was just called KEEP_UNKNOWN. Later it was
renamed to KEEP_UNKNOWN_OPT in 99d86d60e5 (parse-options:
PARSE_OPT_KEEP_UNKNOWN only applies to --options, 2022-08-19) to clarify
that it was only about dashed options; we always keep non-option
arguments.  Looking at that original patch, both Peff and I think that
the author was simply confused about the mis-named option, and really
just wanted to keep the non-option arguments.  We never should have used
the flag all along (and the other cases were cargo-culted within the
file).

Remove the erroneous PARSE_OPT_KEEP_UNKNOWN_OPT flag now to fix this
bug.  Note that this does mean that anyone who might have been using

  git sparse-checkout [add|set] [--[no-]cone] --foo --bar

to request paths or patterns '--foo' and '--bar' will now have to use

  git sparse-checkout [add|set] [--[no-]cone] -- --foo --bar

That makes sparse-checkout more consistent with other git commands,
provides users much friendlier error messages and behavior, and is
consistent with the all-caps warning in git-sparse-checkout.txt that
this command "is experimental...its behavior...will likely change".  :-)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    [RFC] sparse-checkout: be consistent with end of options markers
    
    Follow-up to thread over at
    https://lore.kernel.org/git/CABPp-BF9XZeESHdxdcZ91Vsn5tKqQ6_3tC11e7t9vTFp=uufbg@mail.gmail.com/,
    making end of options markers in git-sparse-checkout consistent with how
    other git commands behave.
    
    Changes since v1:
    
     * Added some testcases

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1625%2Fgitgitgadget%2Fsparse-checkout-end-of-options-consistency-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1625/gitgitgadget/sparse-checkout-end-of-options-consistency-v2
Pull-Request: https://github.com/git/git/pull/1625

Range-diff vs v1:

 1:  c19156919a6 ! 1:  448146637a9 sparse-checkout: be consistent with end of options markers
     @@ Commit message
          simply treat "--sikp-checks" as a path or pattern to include in the
          sparse-checkout, which is highly unfriendly.
      
     -    This behavior begain when the command was converted to parse-options in
     +    This behavior began when the command was converted to parse-options in
          7bffca95ea (sparse-checkout: add '--stdin' option to set subcommand,
          2019-11-21).  Back then it was just called KEEP_UNKNOWN. Later it was
          renamed to KEEP_UNKNOWN_OPT in 99d86d60e5 (parse-options:
     @@ Commit message
      
          That makes sparse-checkout more consistent with other git commands,
          provides users much friendlier error messages and behavior, and is
     -    consistent with the all-capps warning in git-sparse-checkout.txt that
     +    consistent with the all-caps warning in git-sparse-checkout.txt that
          this command "is experimental...its behavior...will likely change".  :-)
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ builtin/sparse-checkout.c: static int sparse_checkout_check_rules(int argc, cons
       
       	if (check_rules_opts.rules_file && check_rules_opts.cone_mode < 0)
       		check_rules_opts.cone_mode = 1;
     +
     + ## t/t1091-sparse-checkout-builtin.sh ##
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'cone mode: set with nested folders' '
     + 
     + test_expect_success 'cone mode: add independent path' '
     + 	git -C repo sparse-checkout set deep/deeper1 &&
     +-	git -C repo sparse-checkout add folder1 &&
     ++	git -C repo sparse-checkout add --end-of-options folder1 &&
     + 	cat >expect <<-\EOF &&
     + 	/*
     + 	!/*/
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'by default, cone mode will error out when passed files' '
     + 	grep ".gitignore.*is not a directory" error
     + '
     + 
     ++test_expect_success 'error on mistyped command line options' '
     ++	test_must_fail git -C repo sparse-checkout add --sikp-checks .gitignore 2>error &&
     ++
     ++	grep "unknown option.*sikp-checks" error
     ++'
     ++
     + test_expect_success 'by default, non-cone mode will warn on individual files' '
     + 	git -C repo sparse-checkout reapply --no-cone &&
     + 	git -C repo sparse-checkout add .gitignore 2>warning &&


 builtin/sparse-checkout.c          | 9 +++------
 t/t1091-sparse-checkout-builtin.sh | 8 +++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5c8ffb1f759..0e68e9b0b0d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -777,8 +777,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_add_options,
-			     builtin_sparse_checkout_add_usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     builtin_sparse_checkout_add_usage, 0);
 
 	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
 
@@ -824,8 +823,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_set_options,
-			     builtin_sparse_checkout_set_usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     builtin_sparse_checkout_set_usage, 0);
 
 	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
 		return 1;
@@ -996,8 +994,7 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_check_rules_options,
-			     builtin_sparse_checkout_check_rules_usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     builtin_sparse_checkout_check_rules_usage, 0);
 
 	if (check_rules_opts.rules_file && check_rules_opts.cone_mode < 0)
 		check_rules_opts.cone_mode = 1;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index f67611da28e..e49b8024ac5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -334,7 +334,7 @@ test_expect_success 'cone mode: set with nested folders' '
 
 test_expect_success 'cone mode: add independent path' '
 	git -C repo sparse-checkout set deep/deeper1 &&
-	git -C repo sparse-checkout add folder1 &&
+	git -C repo sparse-checkout add --end-of-options folder1 &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -886,6 +886,12 @@ test_expect_success 'by default, cone mode will error out when passed files' '
 	grep ".gitignore.*is not a directory" error
 '
 
+test_expect_success 'error on mistyped command line options' '
+	test_must_fail git -C repo sparse-checkout add --sikp-checks .gitignore 2>error &&
+
+	grep "unknown option.*sikp-checks" error
+'
+
 test_expect_success 'by default, non-cone mode will warn on individual files' '
 	git -C repo sparse-checkout reapply --no-cone &&
 	git -C repo sparse-checkout add .gitignore 2>warning &&

base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
-- 
gitgitgadget
