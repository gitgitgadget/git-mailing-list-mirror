Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB153371
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566817; cv=none; b=QDH3aMFlQSPN789is4XNMyMQORTFsE5jWk/0ls0lkKv9MspkuVU83voxI1oP6A1nOy7NJQQZFE7NLNYsjQPJQFssIi5YfkYb1RCIsvZKIn57ncCF3F7l9AxOe/PuUWqFwwFd93ZEyzKcuq+I3qu7o1rLZIVKP+cltLVbTjsBBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566817; c=relaxed/simple;
	bh=lNrxEkFKPGuAxmMK1ggXciDwS5CXYt2lWRAMpk8TSr4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OZlcaNlxE7GRbIV8e0Yg4I60j8FcjfdRaySvUYXxYLe5NtfzPEuWMhkucnQ4d60fXOpw+of1ZF/z4msCBjXSqu3fMCQjn1yVEuC+sc7tOIIvP2XYPAsBNMe0P8XVzQMhBwGo0pTOvpWfIf3zVBbhzcjmPC95882SDaiLioSz+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBRccRrk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBRccRrk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412e88369a0so3824725e9.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566813; x=1710171613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEf419t5X95hibsTlXgcE37OBZrjlXQnHzO/EoEeR+M=;
        b=fBRccRrk2U+aAkCpmjK70hG5CkH5SWAIAmAfAdaMkzppf/dm7AUSv+FKlNDky7/Nxr
         iGUhkc2BoWddl19c2ir/P8kgpDvep9d6po0l47uuKi+uKK6x7ipNLFNNCzP4qw1syk1m
         V2VnGwJ2uPv0AG0P9Ln7M559rWRiolrgCZh+ItxLa1KFfyRila9brGnEOyn29JeXvy93
         IQ2IWMt16awVrgEECh1T0d/HE4ZYEpc0jlLTrJ2NJOEI8cAu0JYD5E0jcwKfbPHRWjRc
         +6cusXpNyhSaRmpfrHFRiKRoOuiza63MnvO3Irf5a/k04ULSpY4l5jSIh4G3fDYsnvsT
         H0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566813; x=1710171613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEf419t5X95hibsTlXgcE37OBZrjlXQnHzO/EoEeR+M=;
        b=lMitXwyXC50d0au1Gql0YWGRSIlAUtLfNCA+vNGDAG6zNKaAIrAYF6bvM21ANhDqgs
         8I+igfizupFr31/+IPQI/CN4laXr4pqcWlecn2LaB555BLXWi1Rf0gEoDHB27aq0b5Ag
         10/ZzuYpBGYycQVlVhKPJYnAflVsja0Fd//rcklPCfD66zzGd5qXzRmX8ytikHbazWZx
         EgSBPx7ESFnjvbrOp3+9v1h4TmsxGLV18QQ8bAbBicQid8Cvsic0Gv9H7Dx2CQZ4PMR/
         c6g4afWdqCL66lnTA6SZ1BC0j/9kQtI/CBRUWmJcDQiUfbVLrk9stgOhY3JB7iEbS/it
         vAsQ==
X-Gm-Message-State: AOJu0YwYXGHsDGjk3L1QJb1ggbF/0xNEShouoSGlu29gdN9ilrNiGNCC
	K9qoyh2QWXiTYAm4iov35+G/1JPpa9qj2l8pPSyyksi8/2OwUGKxb9PfjS6R
X-Google-Smtp-Source: AGHT+IFTti8zKO6Vc5R8mZApAImB0lSodOw9EbXU6V/5TY6xwKhkDa3N4ndRYcGs3cCVtoZCzN7EbA==
X-Received: by 2002:a05:600c:4f4a:b0:412:a8e0:ca38 with SMTP id m10-20020a05600c4f4a00b00412a8e0ca38mr6185443wmq.40.1709566813078;
        Mon, 04 Mar 2024 07:40:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c45d000b00412b67388f0sm17264944wmo.6.2024.03.04.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:40:12 -0800 (PST)
Message-ID: <9507184b4f1147be529898023d8d504819596f71.1709566808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 15:40:07 +0000
Subject: [PATCH 3/4] trace2: emit 'def_param' set with 'cmd_name' event
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Some commands do not cause a set of 'def_param' events to be emitted.
This includes "git-remote-https", "git-http-fetch", and various
"query" commands, like "git --man-path".

Since all of these commands do emit a 'cmd_name' event, add code to
the "trace2_cmd_name()" function to generate the set of 'def_param'
events.

We can later remove explicit calls to "trace2_cmd_list_config()" and
"trace2_cmd_list_env_vars()" in git.c.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t0211-trace2-perf.sh | 6 +++---
 trace2.c               | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

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

