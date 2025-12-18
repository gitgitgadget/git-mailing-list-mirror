Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4753BB44
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766025662; cv=none; b=ruW+LOV+z9OrVJv6s8rtJmwKL1hn4oMN0jcbdHwcupopCnDRd4dFqG6C1+9zW3Tn0usM8olBE4nPX98hUo6F1DBv4KBXCWeCZ2TWH54gVs84OSHzJt7tM5/s4R+jPGW9xs8vA2jb9pTfW29RyjhLilgGQzj7rLS4gddS58DgM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766025662; c=relaxed/simple;
	bh=a1ExUuh6gNMMeQVsfAQ3E9J/wILMVn23LHPmBZFAdAg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=P5irNpMCVBtvS5kcTX4g8UXp/EpjetLF/zC9OMWc3NGOnPq16YvIa5GarG0CueX3HWSe9niGp+Y7d+0RguQwRSTJZpFXfAnK8oqk7L4b7kgITvHabCq3mrGft0rvxKyHDX3h16tMObqZhvMl4o6ecgfms1hKCqbyb5lOFbs0EGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETvPCnWM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETvPCnWM"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c1cf2f0523eso110942a12.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 18:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766025660; x=1766630460; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a8AzCVCl9P/xOtThbMxXBfuCsNvFYI7nEm7ADWTOVjk=;
        b=ETvPCnWMyNNpz9n1WtulCQ1mir1nT5xOSRl29PGTOeeuBuHsQZaIpOW/Y1hJ+ExlvF
         uveG+hOaCrnrLcgYZc/BhlFq0JIhD7yxoSQG+DcUKgxKhZGcgR4bukigTTwvdE03MzKa
         OtbiRxZNDyXyf4Og44vHvesxEpFGfKfxt8QWKs/i1+ygT5nr3lc6mrPFaimZ1nDvOzbT
         AgC8A2pQDtWf88Nx5BMWQ4PNs3Kka9YG8FVOwJAH0NxG8+SNqBgqXfESd3mhXvUdhvOM
         Qz+pUiZ5vFg3HjOEObjwQ8mGQF80l5GH1pg+yPyAEXXcLPn/qdBWPQMPX3WCbH4IJJ64
         MwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766025660; x=1766630460;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8AzCVCl9P/xOtThbMxXBfuCsNvFYI7nEm7ADWTOVjk=;
        b=hK03rR9PhgFLghVwmm1PaEdynjAx/WTyOLYLAhd/UmzTJJyKscpznkVW/g/JJRDsWa
         H4SJv3FgfzrtELvSjy6fPppinFQERcDHOqqsU9kha2jRvJ6jB2zsCu/kopy44HrP05GO
         kSINe+zPJnRZVdK1DfCuAYaDeJHqs/7fsEwKdKM6OF5iAXbZyYNp17oXD4dvqt+BjPjM
         bUQqf+igflQrzrW4KvM6nmObg1koELGyUVfgPdtSVh+P14sPobrYI3u7W+in9EWbJwcE
         ta54lZ7UwPW7JkJxFN1bB6S104SRLi9Ey+2nlubiB6OSodQIr+G5T2t1pU8ZkJcEWtgh
         jWXw==
X-Gm-Message-State: AOJu0Yz9CckS6yGGgYGKpV0NFCmD/BrNyDt9V4E1ctHFa599xfec3lMz
	LLtnJwusutPkyjYZAa10oOpIPtqcie57RZFGI+Jjt1dki/cl2urPgyTJLsi6v0v5
X-Gm-Gg: AY/fxX4Yw2jqrmSSWtWYWXn4+2LNeBSCAsKpgKqQaQFUSvOOdNjkqq1ywhwcn8H/Gmw
	hB/WzpyQo2PlzDk23oEjWI+9l6DYcYR9jJbCPxm+s7+rMFqbIMnmInOVW6SCo9QI2ww1deSiKPq
	BAHHRuZDxqbAXILdYkmBkdMrsp6Om5dXJeoNwLSZKjf+ifBCvoTWscfr/6sZtBxPTLVCqji0gr0
	KcT8oI5oSE7By4MRabgQDBaPqthPhMoozdO5A1WVqDYBBPtfe6n9rsrlRFh2vRv38dBMH5ST77Z
	uIklxfMDkEa4t/MwgE9mycnBMlFNxChPXC8NUhP05L0vuKgt/Knr0NNOhaDs908+iUUVepFTYGJ
	kM3yTONNFxNlIfbMNiZVVihECtGTsmdIfZFwcQrR+e00gwTMroXHZZZX3s9ykJ+LtBuo7f6FjcQ
	1umO2kQWOEUfFs
X-Google-Smtp-Source: AGHT+IHO27g99PyjUZOpHYcxWieVa0kI3clC+C4wiwT0aDjRsSNpMFOdXIONgxE53FWJu7haBMiVSw==
X-Received: by 2002:a05:7301:122:b0:2a4:3592:c612 with SMTP id 5a478bee46e88-2ac303ca513mr11242175eec.35.1766025659739;
        Wed, 17 Dec 2025 18:40:59 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b04e58d061sm1193357eec.4.2025.12.17.18.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:40:59 -0800 (PST)
Message-Id: <pull.2129.git.git.1766025658413.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 02:40:58 +0000
Subject: [PATCH] fsm-listen-darwin: free corefoundation paths
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
Cc: AZero13 <gfunni234@gmail.com>,
    AZero13 <gfunni234@gmail.com>

From: AZero13 <gfunni234@gmail.com>

They are not freed even though they should be.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    fsm-listen-darwin: free corefoundation paths
    
    They are not freed even though they should be.
    
    Signed-off-by: Greg Funni gfunni234@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2129%2FAZero13%2Ffixs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2129/AZero13/fixs-v1
Pull-Request: https://github.com/git/git/pull/2129

 compat/fsmonitor/fsm-darwin-gcc.h    |  2 ++
 compat/fsmonitor/fsm-listen-darwin.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
index 3496e29b3a..8b4bc3a5bc 100644
--- a/compat/fsmonitor/fsm-darwin-gcc.h
+++ b/compat/fsmonitor/fsm-darwin-gcc.h
@@ -40,6 +40,7 @@ typedef const FSEventStreamRef ConstFSEventStreamRef;
 typedef unsigned int CFStringEncoding;
 #define kCFStringEncodingUTF8 0x08000100
 
+typedef const void *CFTypeRef;
 typedef const struct __CFString *CFStringRef;
 typedef const struct __CFArray *CFArrayRef;
 typedef const struct __CFRunLoop *CFRunLoopRef;
@@ -76,6 +77,7 @@ CFStringRef CFStringCreateWithCString(void *allocator, const char *string,
 				      CFStringEncoding encoding);
 CFArrayRef CFArrayCreate(void *allocator, const void **items, long long count,
 			 void *callbacks);
+void CFRelease(CFTypeRef cf);
 void CFRunLoopRun(void);
 void CFRunLoopStop(CFRunLoopRef run_loop);
 CFRunLoopRef CFRunLoopGetCurrent(void);
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 43c3a915a0..149c310433 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -455,6 +455,13 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 failed:
 	error(_("Unable to create FSEventStream."));
 
+	if (data->cfar_paths_to_watch)
+		CFRelease(data->cfar_paths_to_watch);
+	if (data->cfsr_gitdir_path)
+		CFRelease(data->cfsr_gitdir_path);
+	if (data->cfsr_worktree_path)
+		CFRelease(data->cfsr_worktree_path);
+
 	FREE_AND_NULL(state->listen_data);
 	return -1;
 }
@@ -476,6 +483,13 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 		FSEventStreamRelease(data->stream);
 	}
 
+	if (data->cfar_paths_to_watch)
+		CFRelease(data->cfar_paths_to_watch);
+	if (data->cfsr_gitdir_path)
+		CFRelease(data->cfsr_gitdir_path);
+	if (data->cfsr_worktree_path)
+		CFRelease(data->cfsr_worktree_path);
+
 	if (data->dq)
 		dispatch_release(data->dq);
 	pthread_cond_destroy(&data->dq_finished);

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
