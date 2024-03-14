Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA23D75
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710401793; cv=none; b=UNrL8LJqzVAiJlJ3RDNNreWlhG1FY6rzpCWhFd2whSHRz434AcvilaDeEucCf8b01gM3iKW1g5dRp3Mi/roHFs7TVTYvHu0tXogMVNgTYHB/IjNqnFWTDPAhmMoQ/403NXV8IpKuuvB66gpQC4jFAjQl8z07vbbr8inuNNyfr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710401793; c=relaxed/simple;
	bh=ckluomC40xcKdtyRzmDleuadVkQGnNNuWF/X1AcOwAU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=iuFaQ2xQtJZqTIfL8xfTfegae0y2Hb/XJ+ok2W2imfRQ/etW2w0blRUvwOm8M6RQbZyjpoymPAot3Ruzqr9hbcSOee14k+jeg9y9TuRGXDJJMEKyjr/iw+mHdMfrqGy1SOnjfWIl/B1ObEGLcUfP8ET7OEq8DMvhKJZpu2ww92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njN1ANhr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njN1ANhr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4132600824bso3541425e9.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710401790; x=1711006590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l12rscBhYIYXJ5PbO0o9p/4CyV+fxv13mm4xlKQ1VTk=;
        b=njN1ANhrdcnavFbwNUplZquklIyUMrmlmBb4Vglb98jAr3AF8UMIv9TGPfarQzkjGn
         f/SNGXgjLIy1Xjnn418W+I351MhGt0+MuLN3QXoF+ZTxjN4sY8cjZuY8yqlIQ2ZkaTPW
         99jKk76+kNUnrgG1uzsSyL7SYFyUUProcv8MfqKb70eAe4SFaHw08m/vaS4qiGggpLuQ
         xZ9+Z1Na1JT1SW216+hFyG625PZPoHg2UzrOozCn+n0Q3n+nbuxHSUyRxg1/8vh10t+v
         j/rr5zzY5f4PUzjyvitjgQ6Xkl+ZNqqkGJIST2dXYb6Buv+bHQKpJUOxRlimzNDPnE5n
         E0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710401790; x=1711006590;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l12rscBhYIYXJ5PbO0o9p/4CyV+fxv13mm4xlKQ1VTk=;
        b=jt9OvA15XeWUJ51N6RoPwvU9a/nwfKxTi36Auo8okEz4A/jKidJwGVWC0+MAwAsqr8
         2IV/iE0UKP7nGHICi6pEoYXIoEv/WqH9vIQM94sRvl4I0NcEeLsgiOMay1bXBUQc9B6Q
         NHGuup4m1318iNG7Ja0R+P+DIWv4j5nvYAyCZoisv0GCsEtX48WgYguQHOShR+z1ZveD
         JeeCgFZkV75CHDEXS42vaFhNngyzXnOCrOqiFT8Rhr/v+CCxJccxoJHetXC96lvrXTZp
         Siu+rNCx2Ov7xaiHaHwN3cFbVPRvRc73TVfCRIrwXpFbk3PEcPrA0B9JPVSBfxZslfcv
         xr6g==
X-Gm-Message-State: AOJu0Yy6qDWSGrWrpffVhubMIfTxq7XSllJaBucj4RxPCVTqDheLDIek
	WS47FtgiWdATZKn2GXA6xqdaPZ01pnXTDKSOB1SEJ4kd3sg1qnGt75DtFWJG
X-Google-Smtp-Source: AGHT+IFDgV+z2zZIMdfFzQVrWERy7igckVNH/g0VT8hCTlnFxbWkW063Xg9puWxkNQJOqHZ+g9Omdg==
X-Received: by 2002:a05:600c:3488:b0:413:f58f:2f47 with SMTP id a8-20020a05600c348800b00413f58f2f47mr220334wmq.27.1710401789761;
        Thu, 14 Mar 2024 00:36:29 -0700 (PDT)
Received: from gmail.com (221.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.221])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b00413ee7921b4sm2467097wmb.15.2024.03.14.00.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:36:29 -0700 (PDT)
Message-ID: <8faa0cd5-25e8-4a8f-ad8b-5fc1b6e5138b@gmail.com>
Date: Thu, 14 Mar 2024 08:36:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] checkout: plug some leaks in git-restore
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
References: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
In-Reply-To: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In git-restore we need to free the pathspec and pathspec_from_file
values from the struct checkout_opts.

A simple fix could be to free them in cmd_restore, after the call to
checkout_main returns, like we are doing [1][2] in the sibling function
cmd_checkout.

However, we can do better.

We have git-switch and git-restore, both of them spin-offs[3][4] of
git-checkout.  All three are implemented as thin wrappers around
checkout_main.  Considering this, it makes a lot of sense to do the
cleanup closer to checkout_main.

Factor out the call to checkout_main in a function that does both the
work and the cleanup, and use it in the three wrappers.

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
1:  d54a2c4dcc ! 1:  78ad33fa02 checkout: plug some leaks in git-restore
    @@ Commit message
          [4] 46e91b663b (checkout: split part of it to new command 'restore',
              2019-04-25)
     
    +    Signed-off-by: Rubén Justo <rjusto@gmail.com>
    +
      ## builtin/checkout.c ##
     @@ builtin/checkout.c: static struct option *add_checkout_path_options(struct checkout_opts *opts,
      /* create-branch option (either b or c) */

Thanks Eric.

 builtin/checkout.c               | 51 +++++++++++++++-----------------
 t/t2070-restore.sh               |  1 +
 t/t2071-restore-patch.sh         |  1 +
 t/t2072-restore-pathspec-file.sh |  1 +
 t/t6418-merge-text-auto.sh       |  1 +
 5 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4fe049cf37..2ff4cf88a6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1702,10 +1702,10 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 /* create-branch option (either b or c) */
 static char cb_option = 'b';
 
-static int checkout_main(int argc, const char **argv, const char *prefix,
-			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[],
-			 struct branch_info *new_branch_info)
+static int checkout_main_1(int argc, const char **argv, const char *prefix,
+			   struct checkout_opts *opts, struct option *options,
+			   const char * const usagestr[],
+			   struct branch_info *new_branch_info)
 {
 	int parseopt_flags = 0;
 
@@ -1907,6 +1907,20 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		return checkout_branch(opts, new_branch_info);
 }
 
+static int checkout_main(int argc, const char **argv, const char *prefix,
+			      struct checkout_opts *opts, struct option *options,
+			      const char * const usagestr[])
+{
+	struct branch_info new_branch_info = { 0 };
+	int ret = checkout_main_1(argc, argv, prefix, opts, options,
+				  checkout_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
+	clear_pathspec(&opts->pathspec);
+	free(opts->pathspec_from_file);
+	free(options);
+	return ret;
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -1922,8 +1936,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1953,13 +1965,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
@@ -1977,8 +1984,6 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			 N_("throw away local modifications")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1997,11 +2002,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
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
@@ -2020,8 +2022,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
-	int ret;
-	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
@@ -2036,9 +2036,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
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
2.43.0
