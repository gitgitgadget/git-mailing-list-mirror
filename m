Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594DF12F37C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824957; cv=none; b=EWAhm0p+uG9ht2LYa29oOk2CILM663VRBeppHXNKTDoD1UcZzcg5/Kwal1UrIqF6pqfSf68qbXfH6xbIajkCJbZH1FrdxMXpBn30Gh3tGc+QKMsCF+BC/WRqw6EG4OqRipWlLLfgkyrALvIgRvLwXtBu0bHol+T/7iSiAP98JL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824957; c=relaxed/simple;
	bh=o/eFoZ6g/Xy1LO8y86rCr6PDddqxvZ0+sLCXDazcvTk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CYwFq5xmhB75yVAr1+NvWVFSea5ZzE1XujjbuIq1y0RBoYhphyppD6ggg0yO0b2EC5iRYNmNXbdBnt2/KUhqwVaOeDzxx/sCk1Srk+59bHejH1ugLin1sNYIX1JExr3pf5VGXXCMxjUi0NiNTAerSdwJRfACh1N0vmC6rnNUKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlXpDw1W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlXpDw1W"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412f67bc6d0so8572445e9.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709824953; x=1710429753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCKPBPxTkJuC8pllkhdDxRMpPlF1FoB0VaaWbadmq2k=;
        b=WlXpDw1W9WQhIj4LCSDdpq0RKJf6IohtVey2zZ3xeYKqzhX8geEgjnFgEiuudFGV9O
         9YHp6ep1pZ9C5+laXSRmMGi6+idnfK/xkbpT9FPlBjd+YmMB3EmWTTLog8PPSVD4loZN
         ouKu8qI0qq4FO3dYIc9rrbdy/yhE6hqBgV80upm8SvFXv4a6OOiVxxFUN+h5vG/cobOz
         RDrvmP0FU7+2f9uay/afyJ2JcDeNwCE7J7JC/+gPJV5P2Nl6d6smldPeQlInNG9yM9za
         5IKO6JBy+ZiiidrCo5eswirClyAbjZBYlLQ+74Ez6o4czcXZ1dGpdZ1gJlSbR1Jev/nA
         gx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824953; x=1710429753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCKPBPxTkJuC8pllkhdDxRMpPlF1FoB0VaaWbadmq2k=;
        b=JcVQESS6/cOpS5Xb9PewTfxN1Aq78V1V+wBO9tSBsDFF7RzUsT/hYAg+3zF9e9BWuH
         /wJwsxUtP5d/ob5gWQ571lUJq6btmShApcdkO4LEE+7xvU2rByYUEuIoyxuA2is1IgqC
         F+n1mVDXOQ7z7i/tslc+j24KFDVKeMycJxPOPjmj0cKV7+7aVtZFgyXODAhgAefmlwmS
         e6MNmQQpxK6p74YoIxwHWzf+2uwGISE1Czhhn2RjL9ZrLcXeUDw4AIhPnnFI4K+rzYIf
         6AiDiSyfr4tpzk/mIUB83EJ1iKngd6EcHoBqxO+g4mFfD8oOfg++r0dVg5ts/Dytz6ri
         RN+g==
X-Gm-Message-State: AOJu0Yw/OCdarz7s+FZWIoQmsgN6JEEwRy3Gp/vtCMQ6lB/3rDnYIA9I
	f1iOGO8gzc32ohVBhFdh7gc8AmnUp0uVsvSl1sCyuLdAT/KSY0EjVKptEv1N
X-Google-Smtp-Source: AGHT+IGrqYYwW2HL8cy9w4gwhgY2NH2RwLt2UUHkSFuARd5ITDKNN5u+ZESeIbAHcr8jcdrFApp4Lg==
X-Received: by 2002:a05:600c:3544:b0:412:9eec:92c9 with SMTP id i4-20020a05600c354400b004129eec92c9mr14707683wmq.18.1709824952913;
        Thu, 07 Mar 2024 07:22:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b004130db58a97sm2959787wmq.39.2024.03.07.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:22:32 -0800 (PST)
Message-ID: <178721cd4f044af44b9d7e625cabf63c5e19c75d.1709824949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
	<pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 Mar 2024 15:22:29 +0000
Subject: [PATCH v2 3/3] trace2: emit 'def_param' set with 'cmd_name' event
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
Cc: Josh Steadmon <steadmon@google.com>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Some commands do not cause a set of 'def_param' events to be emitted.
This includes "git-remote-https", "git-http-fetch", and various
"query" commands, like "git --man-path".

Since all of these commands do emit a 'cmd_name' event, add code to
the "trace2_cmd_name()" function to generate the set of 'def_param'
events.

Remove explicit calls to "trace2_cmd_list_config()" and
"trace2_cmd_list_env_vars()" in git.c since they are no longer needed.

Reviewed-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 git.c                  | 6 ------
 t/t0211-trace2-perf.sh | 6 +++---
 trace2.c               | 3 +++
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/git.c b/git.c
index 7068a184b0a..a769d72ab8f 100644
--- a/git.c
+++ b/git.c
@@ -373,8 +373,6 @@ static int handle_alias(int *argcp, const char ***argv)
 			strvec_pushv(&child.args, (*argv) + 1);
 
 			trace2_cmd_alias(alias_command, child.args.v);
-			trace2_cmd_list_config();
-			trace2_cmd_list_env_vars();
 			trace2_cmd_name("_run_shell_alias_");
 
 			ret = run_command(&child);
@@ -411,8 +409,6 @@ static int handle_alias(int *argcp, const char ***argv)
 		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
 
 		trace2_cmd_alias(alias_command, new_argv);
-		trace2_cmd_list_config();
-		trace2_cmd_list_env_vars();
 
 		*argv = new_argv;
 		*argcp += count - 1;
@@ -462,8 +458,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	trace_argv_printf(argv, "trace: built-in: git");
 	trace2_cmd_name(p->cmd);
-	trace2_cmd_list_config();
-	trace2_cmd_list_env_vars();
 
 	validate_cache_entries(the_repository->index);
 	status = p->fn(argc, argv, prefix);
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 7b353195396..13ef69b92f8 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -320,7 +320,7 @@ test_expect_success 'expect def_params for normal builtin command' '
 # Representative query command dispatched in handle_options()
 # in git.c
 #
-test_expect_failure 'expect def_params for query command' '
+test_expect_success 'expect def_params for query command' '
 	try_simple "git --man-path" "_query_"
 '
 
@@ -337,7 +337,7 @@ test_expect_failure 'expect def_params for query command' '
 # remote-curl.c rather than git.c.  Confirm that we get def_param
 # events from both layers.
 #
-test_expect_failure 'expect def_params for remote-curl and _run_dashed_' '
+test_expect_success 'expect def_params for remote-curl and _run_dashed_' '
 	test_when_finished "rm prop.perf actual" &&
 
 	test_config_global "trace2.configParams" "cfg.prop.*" &&
@@ -366,7 +366,7 @@ test_expect_failure 'expect def_params for remote-curl and _run_dashed_' '
 # an executable built from http-fetch.c.  Confirm that we get
 # def_param events from both layers.
 #
-test_expect_failure 'expect def_params for http-fetch and _run_dashed_' '
+test_expect_success 'expect def_params for http-fetch and _run_dashed_' '
 	test_when_finished "rm prop.perf actual" &&
 
 	test_config_global "trace2.configParams" "cfg.prop.*" &&
diff --git a/trace2.c b/trace2.c
index facce641ef3..f894532d053 100644
--- a/trace2.c
+++ b/trace2.c
@@ -433,6 +433,9 @@ void trace2_cmd_name_fl(const char *file, int line, const char *name)
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_command_name_fl)
 			tgt_j->pfn_command_name_fl(file, line, name, hierarchy);
+
+	trace2_cmd_list_config();
+	trace2_cmd_list_env_vars();
 }
 
 void trace2_cmd_mode_fl(const char *file, int line, const char *mode)
-- 
gitgitgadget
