Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB67EA
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3h5Vmv5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d4e529f24so11955285e9.2
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703379613; x=1703984413; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=25iRw4KtUbrmK0K5gGF8oBvuFDifdsL/Ih4TEYgmfa4=;
        b=Z3h5Vmv52GjYJq+RefHBPIC1B8oxPnIwMrPkQ4NMla3/pkKrwxMuAaQpeBNO2uChUF
         hJXzfbK5GWkp27jbYX81k+kz7JIM6AH6QZ8apONDBq345uODzZmVzm0f6SXfffgecWi/
         bIMqgUniRrSCKCeZnEeBfEF+JovwaMwx7r805+YK6/C6rlwtETN1bHJCc/zdoFeZSEJO
         ATAgOXbHC5xjWVxz9lQ3TDFN2hLtzVjRxto2yejMTkHGoyAakHfvMzhS2A/14UYzbdBD
         opM92RaZSp2Lx/rwZLuSuRHGxr+BkT084KrSxCkTnPe69/E+CqPQGPR4gfK+hdrHzWnw
         YJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703379613; x=1703984413;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25iRw4KtUbrmK0K5gGF8oBvuFDifdsL/Ih4TEYgmfa4=;
        b=EbSVEL/YIXX8BRBFGZZHaz4xL+hVDZHLebWmMUdb8NBTXlW3eZJSm24EtLhMYiflyR
         V1OIKWdR+4jri6n78RUZ+op7bp5YhIFjELuYST/VsKqrsa6x33ipGHdi+lifRdbX5+r3
         nmrgJ2iKoD2b4LeA3oAjirheF4YWJ7YRk0+EqpB+eDoCkAGZpxQn+4io9z3UvhR4jD0R
         3hfStDhFn3DomGgsRhXIz4Xt7zT+uPbpSBhKWn+oIOyQ6ua6KtIkzEgryywhmXhNVAMi
         FOVYhaRviiDaK2EHo7rP14otjKcsx2PQZVpvTD/u+8wgtATndH/hfENPT0QNf3N+IhW+
         1BHA==
X-Gm-Message-State: AOJu0YyIwnVXe/5RlAqvmagMsn82DUjlhnGk++IJzvBwYwVMXUnahhbz
	MFnUbZeuBD3Ouy1+47jpJxW+tWMenA8=
X-Google-Smtp-Source: AGHT+IF20EF/3DmMFHAZCDx7ZmsvXbZIFdHmhiJ+U/PpA8sjp6uIi5Dr6nn1d8TbkPRy9QusmtiUkg==
X-Received: by 2002:a05:600c:4593:b0:40c:2734:13cd with SMTP id r19-20020a05600c459300b0040c273413cdmr1414205wmo.43.1703379612962;
        Sat, 23 Dec 2023 17:00:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d4d47000000b00333404e9935sm7467540wru.54.2023.12.23.17.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 17:00:12 -0800 (PST)
Message-ID: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 Dec 2023 01:00:11 +0000
Subject: [PATCH] sparse-checkout: be consistent with end of options markers
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

This behavior begain when the command was converted to parse-options in
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
consistent with the all-capps warning in git-sparse-checkout.txt that
this command "is experimental...its behavior...will likely change".  :-)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    [RFC] sparse-checkout: be consistent with end of options markers
    
    Follow-up to thread over at
    https://lore.kernel.org/git/CABPp-BF9XZeESHdxdcZ91Vsn5tKqQ6_3tC11e7t9vTFp=uufbg@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1625%2Fgitgitgadget%2Fsparse-checkout-end-of-options-consistency-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1625/gitgitgadget/sparse-checkout-end-of-options-consistency-v1
Pull-Request: https://github.com/git/git/pull/1625

 builtin/sparse-checkout.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

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

base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
-- 
gitgitgadget
