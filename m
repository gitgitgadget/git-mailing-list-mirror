Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CE2D0C66
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767098580; cv=none; b=udgqYKBfkck+950n4G8tNbxPQoQ9UGcXsX9IwEUIGk5tH21US+J2L42duYArwStc026FX9xZKOg8wATQI77YC4S9F4QDO0NoaSl0f5N7fqYxlu5j5WL3tShcDMfnKpEb+P5x8SI1uCQ0N+LqIx/hqz1h9x7uKVpSccIfBTp1NOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767098580; c=relaxed/simple;
	bh=OM14hdhWBANhvOqjlxXyMHLk/zhUQCTYScNR4I7NrHE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=b7n21eTjx9wlP60Vv8JzVMB42W+Vs/ZO3gD0MWL74dX5z7Q2TDHcK68pEZ0HuL5h5qberXi3EmWJqpVxSnLOUe+XbzDge4SdZWjwR/9kVdHIq8CzdDiCaaElhm6ke90qFYDVyd/dFP8OKswk+DcVWXrmM/t7cj4A6HqBdiK0GFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRyiZE1j; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRyiZE1j"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1022dda33so81497675ad.2
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 04:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767098578; x=1767703378; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk5At5KdBvsbkOfONxJDfe90DHbc+cPjFNmNShit/VY=;
        b=PRyiZE1jEFtnAyi7I6D3SAz39xQclxggF4tK33ACI6TwB7MbyPq3zMD5Io3lnkUW4l
         fSOq+E42PfVfBHmdmqZ7Qf73dYWOWvSQKUqEHWXEOjvUx7SmHAJYVleTOR0qAsz8fxR4
         q2+N1mBObc+CX/EBuikUlAUZBZllD9jkFGFQqFZavmnIHtbOfhSVZ/BG7is4Kt6efZh1
         SJArBR9XzfBXYk5vWdEAKaT93QQO1hpxZDHOiU1wZjewdxl/y5MZTLOMXJ/8+R/wci5l
         jluS+vRhx6Kvua+w6h3IINPb06e6AX3AlUxWCJyyHCiB+E1+bDoiqd414TgZsqUHP7xS
         bCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767098578; x=1767703378;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk5At5KdBvsbkOfONxJDfe90DHbc+cPjFNmNShit/VY=;
        b=cpUpPNQp6jeHyVvByAZcOButt8WPn5kTtRY9buZw1Xjy/pDdySS1Uty+vgAPkfesTW
         iPvZCXeFDX9nfL2rZvK75dkTV4KbI/K9FewQ9lV9fU4gvcIhgSVYzLe7IzPCwboVdVtr
         JMxWyalogKiw3SIiG+mcLfTTRO1TcKH62spx3SgNqbtgEiJJ0nWjPp7O19mKw2unsIlw
         3PTy4tV9Mk16zczMiTAGuvsn0WbYxkdY2Dwtsc3EML4nNLlRtHwYzhm/dUCODl/BkAPL
         hs62De5+cJpC2zbhqQTR6T3eHpR9GTaamz4ekyJzMTMBWhctJP1McA4HpBKn/SegfaPE
         y9Qg==
X-Gm-Message-State: AOJu0YyPvHlkcmpAwi3tHoB/F72jYXqOJCvTQoiGh/MS/VnRVsM2vFPT
	ee2kx7ktBBGJRCVU+JRIHr0zOHTBxm/l4rZHuj+CI/3St4soxu8EvJFfk2z16A==
X-Gm-Gg: AY/fxX7MLPiX9AnuKIKWNZLCz+ldyvqRx2/cCyndjw1rqioU61brsmihJnEBV1BZNgg
	h6qFdTTlAxzCLOX+HWd9jKfD0sHiNuruB8Sf3VrSu4q3+fZmzrV/OgbCIZrXPNQ+bytBJ5foomh
	WP96GqXarQb3RY60LbkdsFbPGp539Ixuz1jyVmZveiRNHTDbwq0Ic8qKOeQXxAJC2hXpdGEbQpu
	wLMZHSAD++ncIl9xoldj4HaosQ8w56uIOm8mnsPmvHnX+2NgViDiZUjh+pI+EXYPytBP3GLfrEG
	JuyOgw29Pn+Sw3ZOJDa6aT/Mw9ZAEFJNfb4zWkuuehcWlIHvEcwAMAVnUDDXI+8FK6tACWxxZgj
	3lRXH8oojsasi1HTSTINTf3OLLnCp81SoY9adWhAC6pJY5ZMRL2aOS0HRQB4Xzz9tbuMkUPSS1L
	RAWssLk8h1MVo=
X-Google-Smtp-Source: AGHT+IFfnClHH/QD3R1Wr7XrFHJSyOwqFduMMuGQchzZ9+jTXPii7iHxCU5hNRMNM4je/cB6GkFf1Q==
X-Received: by 2002:a05:7022:f68e:b0:11b:95fe:bedf with SMTP id a92af1059eb24-121722ebb0fmr23962732c88.27.1767098577812;
        Tue, 30 Dec 2025 04:42:57 -0800 (PST)
Received: from [127.0.0.1] ([40.65.56.234])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm124377194c88.15.2025.12.30.04.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 04:42:57 -0800 (PST)
Message-Id: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 12:42:56 +0000
Subject: [PATCH] fsmonitor: fix khash memory leak in do_handle_client
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
Cc: Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The do_handle_client() function allocates a khash table to de-duplicate
pathnames when responding to client requests. Two issues existed:

1. kh_release_str() was used instead of kh_destroy_str(). The release
   function only frees internal arrays (flags, keys, vals) but not the
   struct itself (allocated by kh_init_str via xcalloc). This caused a
   40-byte leak per request.

2. The khash was freed mid-function rather than in the cleanup section,
   so if the worker thread was interrupted before reaching that point
   during daemon shutdown, the memory would leak.

Fix both issues by:
- Initializing shown = NULL at declaration
- Using kh_destroy_str() which handles NULL and frees both internal
  arrays and the struct itself
- Moving the cleanup to the cleanup section so it runs on all exit paths

Signed-off-by: Claude <claude@anthropic.com>
---
    fsmonitor: fix khash memory leak in do_handle_client
    
    The do_handle_client() function allocates a khash table to de-duplicate
    pathnames when responding to client requests. Two issues existed:
    
     1. kh_release_str() was used instead of kh_destroy_str(). The release
        function only frees internal arrays (flags, keys, vals) but not the
        struct itself (allocated by kh_init_str via xcalloc). This caused a
        40-byte leak per request.
    
     2. The khash was freed mid-function rather than in the cleanup section,
        so if the worker thread was interrupted before reaching that point
        during daemon shutdown, the memory would leak.
    
    Fix both issues by:
    
     * Initializing shown = NULL at declaration
     * Using kh_destroy_str() which handles NULL and frees both internal
       arrays and the struct itself
     * Moving the cleanup to the cleanup section so it runs on all exit
       paths

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2148%2Fptarjan%2Fclaude%2Ffix-fsmonitor-hashmap-leak-gfDCU-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2148/ptarjan/claude/fix-fsmonitor-hashmap-leak-gfDCU-v1
Pull-Request: https://github.com/git/git/pull/2148

 builtin/fsmonitor--daemon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 242c594646..bc4571938c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown;
+	kh_str_t *shown = NULL;
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
@@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		total_response_len += payload.len;
 	}
 
-	kh_release_str(shown);
-
 	pthread_mutex_lock(&state->main_lock);
 
 	if (token_data->client_ref_count > 0)
@@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
+	kh_destroy_str(shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);

base-commit: 7c7698a654a7a0031f65b0ab0c1c4e438e95df60
-- 
gitgitgadget
