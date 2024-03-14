Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775E74C18
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439744; cv=none; b=F2ai/5PwWxKOB/VljLkmhmBwplkKQWB3fMdKWrH/glwZG41NRSKNjUqEqEjcDXfbpIJpnQNWmq5a+12j6eDuugiDhEkCfCHn/lMoe5GbHiypZutdAWCI0SojIFh0Bh8e12rITWMfZRldbpDbsFFe32AYAlS1MY3QFW9Y/paYGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439744; c=relaxed/simple;
	bh=PJw0/2BC2+/V4HJ/TJrnqZTv5YofBgSxbnJEtu4z094=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=nPWiRmrlzGn7IHtKgQ+nfD2VSnMQxjjsde5buWkrUWHTuieW96ixspF9q0KDUFWmD5JPuNGbPktNmipO80+vkTesOI+MxY8Dr27ULqhX8uV5tIt/OoOvPLTA4M4F1yOam1XU+lzwORUeRetSckWavaAAvZ34+nXIZtJVe/sJUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/RySHTC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/RySHTC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413e93b0f54so8732435e9.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710439740; x=1711044540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2K0GcZQ4ivwDOloa4+f6Nt7uXpcIWH2fsRk40WgJDE=;
        b=V/RySHTCPUOKH0pRXtXYJv30D/TYFRvqVbP7U+vPAGm8cimPISt3MqUc5xQbYRc0mJ
         wW1dxFiBUF2cnkkazB37VpFUsQJThfMwd8GL80QA/Kh6yJ0AIYp4cjhebygCJY8/GBBS
         u3UXBRAOhfy+uK0y0L8NbxvTmMds7SzjWAyXtX6Zlax+IHVZcYh7TsKqs1qZcHslrkK7
         vqDw9O4+gTxDnelGpq26XoPDnqddDZ9QTFgTqH/eG87vJqn/Ubepj5oL3gc/hpbrdTJ1
         V6Cg3Sn4SZm1B2NVMLv/fTRY3dXfQzynhkQmK2s6rAo+Vt7Jhrde4otkEN8vB10KuPan
         u8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710439740; x=1711044540;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2K0GcZQ4ivwDOloa4+f6Nt7uXpcIWH2fsRk40WgJDE=;
        b=dq5eB46aNqu61/NteQV8VDp+tVHtnI3vor6Efxm0VmOKyGSKRhJUg+xEfDjg0vrg1E
         RmxJAEE2hX21MMBaiBk9u242hipHvGR+R+2+lJHRI+6cTE2+GdDPn+w5yprFUpT10FwY
         mAKOsTU5+TVvtvwnX7Pa9m+JdpgLNFRurqEJenc4IhJYbj6fzCkjPTPL3K7gH9fOY5MO
         Uc6zX8SGDmPkjO/L45mN3Erv3EhwKTN1J8nvB/BZyBRBL2UinWrRnGjf4GPhnXsR7UEu
         RB17gtLwwQcdJ/WWy+aWvkZYcYazzLsx/B87i7riEgqjPKAvb8RRMm72YGsaaxVbRamr
         E2nw==
X-Gm-Message-State: AOJu0Ywnfg07xRz+MruhsrbvObvUR8OZde2zCdMck3WIt7rN36IMoAdH
	yj/jEo0iAv7JibgSnUVW5uquh9Cp/sONiHkhSG55Sh6gpjcDciYDqUvd80fg
X-Google-Smtp-Source: AGHT+IFkpsGhg5OkAk8fRCdWVgP33SiFHnJbZk/mxv+MYBJY4qHy9UQKarmfDeDYWcKM2FO6wUbJRQ==
X-Received: by 2002:a5d:694b:0:b0:33e:b719:8bec with SMTP id r11-20020a5d694b000000b0033eb7198becmr1787038wrw.24.1710439739998;
        Thu, 14 Mar 2024 11:08:59 -0700 (PDT)
Received: from gmail.com (70.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.70])
        by smtp.gmail.com with ESMTPSA id f5-20020adffcc5000000b0033e7b05edf3sm1259072wrs.44.2024.03.14.11.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 11:08:59 -0700 (PDT)
Message-ID: <64c1c3cc-51d7-4168-9731-4389889e1449@gmail.com>
Date: Thu, 14 Mar 2024 19:08:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] checkout: plug some leaks in git-restore
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>
References: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
 <8faa0cd5-25e8-4a8f-ad8b-5fc1b6e5138b@gmail.com>
Content-Language: en-US
In-Reply-To: <8faa0cd5-25e8-4a8f-ad8b-5fc1b6e5138b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In git-restore we need to free the pathspec and pathspec_from_file
values from the struct checkout_opts.

A simple fix could be to free them in cmd_restore, after the call to
checkout_main returns, like we are doing [1][2] in the sibling function
cmd_checkout.

However, we can do even better.

We have git-switch and git-restore, both of them spin-offs[3][4] of
git-checkout.  All three are implemented as thin wrappers around
checkout_main.  Considering this, it makes a lot of sense to do the
cleanup closer to checkout_main.

Move the cleanups, including the new_branch_info variable, to
checkout_main.

As a consequence, mark: t2070, t2071, t2072 and t6418 as leak-free.

 [1] 9081a421a6 (checkout: fix "branch info" memory leaks, 2021-11-16)

 [2] 7ce4088ab7 (parse-options: consistently allocate memory in
     fix_filename(), 2023-03-04)

 [3] d787d311db (checkout: split part of it to new command 'switch',
     2019-03-29)

 [4] 46e91b663b (checkout: split part of it to new command 'restore',
     2019-04-25)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
Range-diff:
1:  93f900a81c ! 1:  2bfcb55424 checkout: plug some leaks in git-restore
    @@ Commit message
         checkout_main returns, like we are doing [1][2] in the sibling function
         cmd_checkout.
     
    -    However, we can do better.
    +    However, we can do even better.
     
         We have git-switch and git-restore, both of them spin-offs[3][4] of
         git-checkout.  All three are implemented as thin wrappers around
         checkout_main.  Considering this, it makes a lot of sense to do the
         cleanup closer to checkout_main.
     
    -    Factor out the call to checkout_main in a function that does both the
    -    work and the cleanup, and use it in the three wrappers.
    +    Move the cleanups, including the new_branch_info variable, to
    +    checkout_main.
     
         As a consequence, mark: t2070, t2071, t2072 and t6418 as leak-free.
     
    @@ Commit message
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## builtin/checkout.c ##
    -@@ builtin/checkout.c: static struct option *add_checkout_path_options(struct checkout_opts *opts,
    - /* create-branch option (either b or c) */
    - static char cb_option = 'b';
    +@@ builtin/checkout.c: static char cb_option = 'b';
      
    --static int checkout_main(int argc, const char **argv, const char *prefix,
    --			 struct checkout_opts *opts, struct option *options,
    + static int checkout_main(int argc, const char **argv, const char *prefix,
    + 			 struct checkout_opts *opts, struct option *options,
     -			 const char * const usagestr[],
     -			 struct branch_info *new_branch_info)
    -+static int checkout_main_1(int argc, const char **argv, const char *prefix,
    -+			   struct checkout_opts *opts, struct option *options,
    -+			   const char * const usagestr[],
    -+			   struct branch_info *new_branch_info)
    ++			 const char * const usagestr[])
      {
      	int parseopt_flags = 0;
    ++	struct branch_info new_branch_info = { 0 };
    ++	int ret;
      
    + 	opts->overwrite_ignore = 1;
    + 	opts->prefix = prefix;
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
    - 		return checkout_branch(opts, new_branch_info);
    - }
    + 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
    + 			!opts->new_branch;
    + 		int n = parse_branchname_arg(argc, argv, dwim_ok,
    +-					     new_branch_info, opts, &rev);
    ++					     &new_branch_info, opts, &rev);
    + 		argv += n;
    + 		argc -= n;
    + 	} else if (!opts->accept_ref && opts->from_treeish) {
    +@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
    + 		if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
    + 			die(_("could not resolve %s"), opts->from_treeish);
      
    -+static int checkout_main(int argc, const char **argv, const char *prefix,
    -+			      struct checkout_opts *opts, struct option *options,
    -+			      const char * const usagestr[])
    -+{
    -+	struct branch_info new_branch_info = { 0 };
    -+	int ret = checkout_main_1(argc, argv, prefix, opts, options,
    -+				  checkout_usage, &new_branch_info);
    +-		setup_new_branch_info_and_source_tree(new_branch_info,
    ++		setup_new_branch_info_and_source_tree(&new_branch_info,
    + 						      opts, &rev,
    + 						      opts->from_treeish);
    + 
    +@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
    + 		 * Try to give more helpful suggestion.
    + 		 * new_branch && argc > 1 will be caught later.
    + 		 */
    +-		if (opts->new_branch && argc == 1 && !new_branch_info->commit)
    ++		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
    + 			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
    + 				argv[0], opts->new_branch);
    + 
    +@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
    + 	}
    + 
    + 	if (opts->patch_mode || opts->pathspec.nr)
    +-		return checkout_paths(opts, new_branch_info);
    ++		ret = checkout_paths(opts, &new_branch_info);
    + 	else
    +-		return checkout_branch(opts, new_branch_info);
    ++		ret = checkout_branch(opts, &new_branch_info);
    ++
     +	branch_info_release(&new_branch_info);
     +	clear_pathspec(&opts->pathspec);
     +	free(opts->pathspec_from_file);
     +	free(options);
    -+	return ret;
    -+}
     +
    ++	return ret;
    + }
    + 
      int cmd_checkout(int argc, const char **argv, const char *prefix)
    - {
    - 	struct checkout_opts opts;
     @@ builtin/checkout.c: int cmd_checkout(int argc, const char **argv, const char *prefix)
      		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
      		OPT_END()

 builtin/checkout.c               | 51 +++++++++++++-------------------
 t/t2070-restore.sh               |  1 +
 t/t2071-restore-patch.sh         |  1 +
 t/t2072-restore-pathspec-file.sh |  1 +
 t/t6418-merge-text-auto.sh       |  1 +
 5 files changed, 25 insertions(+), 30 deletions(-)

25 < 30, :-) thanks Junio.

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4fe049cf37..2e8b0d18f4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1704,10 +1704,11 @@ static char cb_option = 'b';
 
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[],
-			 struct branch_info *new_branch_info)
+			 const char * const usagestr[])
 {
 	int parseopt_flags = 0;
+	struct branch_info new_branch_info = { 0 };
+	int ret;
 
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
@@ -1823,7 +1824,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     new_branch_info, opts, &rev);
+					     &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1832,7 +1833,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
 			die(_("could not resolve %s"), opts->from_treeish);
 
-		setup_new_branch_info_and_source_tree(new_branch_info,
+		setup_new_branch_info_and_source_tree(&new_branch_info,
 						      opts, &rev,
 						      opts->from_treeish);
 
@@ -1852,7 +1853,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts->new_branch && argc == 1 && !new_branch_info->commit)
+		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
 				argv[0], opts->new_branch);
 
@@ -1902,9 +1903,16 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, new_branch_info);
+		ret = checkout_paths(opts, &new_branch_info);
 	else
-		return checkout_branch(opts, new_branch_info);
+		ret = checkout_branch(opts, &new_branch_info);
+
+	branch_info_release(&new_branch_info);
+	clear_pathspec(&opts->pathspec);
+	free(opts->pathspec_from_file);
+	free(options);
+
+	return ret;
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
@@ -1922,8 +1930,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1953,13 +1959,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	options = add_common_switch_branch_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, checkout_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	clear_pathspec(&opts.pathspec);
-	free(opts.pathspec_from_file);
-	FREE_AND_NULL(options);
-	return ret;
+	return checkout_main(argc, argv, prefix, &opts, options,
+			     checkout_usage);
 }
 
 int cmd_switch(int argc, const char **argv, const char *prefix)
@@ -1977,8 +1978,6 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			 N_("throw away local modifications")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1997,11 +1996,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	cb_option = 'c';
 
-	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, switch_branch_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	FREE_AND_NULL(options);
-	return ret;
+	return checkout_main(argc, argv, prefix, &opts, options,
+			     switch_branch_usage);
 }
 
 int cmd_restore(int argc, const char **argv, const char *prefix)
@@ -2020,8 +2016,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
@@ -2036,9 +2030,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, restore_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	FREE_AND_NULL(options);
-	return ret;
+	return checkout_main(argc, argv, prefix, &opts, options,
+			     restore_usage);
 }
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 16d6348b69..ac404945d4 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -5,6 +5,7 @@ test_description='restore basic functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 27e85be40a..42d5522119 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -2,6 +2,7 @@
 
 test_description='git restore --patch'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index 8198a1e578..86c9c88788 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='restore --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 41288a60ce..48a62cb855 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -15,6 +15,7 @@ test_description='CRLF merge conflict across text=auto change
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
-- 
2.44.0.341.g2bfcb55424
