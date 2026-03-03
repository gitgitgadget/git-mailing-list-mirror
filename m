Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A273ED5A3
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559121; cv=none; b=fwYz86sLdiaDnId1PUIhlJem+7Ml0nA30ymgbBKEKJbf37Fa3UynU26Wj/y1PooM3KUp6NOIjs2VGVeA7RBWKxgng/63/N+k6NRvwNtY5w6jOblnHfSrNXXiU4Kz9OnRzE/scvrTNDcDboN+2pa5SdfiVfoJOa2VCnuMr2mIhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559121; c=relaxed/simple;
	bh=Rzg+ZelmgS8pa8oZftXqT3BxmFvQyMr+eMZ2L3WIrMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JTZ4Jv72NFfGWjT+jsGtb91Lhicai5OuZqiUJkafdTIUMOfpTSWvx3+ZCoUdYjrTZKmUCaH4ZyZcP3f28kU1sEKDQ9pGj30U1UdraKUFFbIPtc6fZDkIzun2weMb8T/Gxx+ykeG5qwwUJphXE32mJkiZKypOeGUG0AZWaMsquQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msMnMPCb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msMnMPCb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb4136d865so791090985a.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559119; x=1773163919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCO01AbtfhqpwefCHjzLLuzPCZncjO9L2QDjZ8ZHyC4=;
        b=msMnMPCb6xxpXX/8953ZiIVBhfVf7dxJ2SAd7JUPshjOQInoTCIwE0RG8EeiZg0MMZ
         JsSiZlYtbN1V2rOqt3HcGch9Tzemq6cCzrls3NyP4WCrUw6+ulGjFFckFbIzNxzzqdVH
         nmM6VsJvQqWdqtLQdq/Q45a+I8T8XFicefUZFMjtHnsDRRyyOfQzPblva2f+VlpF3sgQ
         y/WydQNuyog5C0Ot0/MQNjccTBiB0qANGLN868T4zh7QeO3D+I78gvfgO0kf+fuQDv1w
         +RAbOXEtpC16l1fNsv/VB35wn6cf/AMPugFnNDBkuqkhU06d3AoysAywXRMz/qGkc5yn
         3/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559119; x=1773163919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bCO01AbtfhqpwefCHjzLLuzPCZncjO9L2QDjZ8ZHyC4=;
        b=t7/xRy5y1V16u1QB963jCjyAleOP8xbWsm56O9UbOw59Ms5DLeT3Ad0ZZWDkLJIWpQ
         IfqrY2XP0LPh8ehYy1gkP9Y77ecAQ92NZv71wEEK4KWISPikztkFoEQwzJj6nP15cD5Z
         b/5+yyAFhXVfzsoMYepWxsxgb6CEYTISyJmMD3bW2iPIvwN/igUmXWRO52VGPM/nHIAP
         Wg+yTf8+yQhgahM7wzQUcAdt6OTgJBZu/vDRRZ00d6s6N9SrVFUHPGL+G5/rs4D9SLbx
         7vyJAdNV1lL13NPNAQesoh4y3/4tFsnbmJ4niZ3/tamELB0015MomQLXhMSLh6BiLS9q
         6ixA==
X-Gm-Message-State: AOJu0Yw7JJBXBwP4l7Infw8YYtPuzd3dL6K6jzK/jJhDfMj6GfrsMG+C
	N2fiMiMSZxg1nofQPNNJCgisXAGm5TpHG9mAGWvKRoeWQjIOde7ckFlUFERlIw==
X-Gm-Gg: ATEYQzxmDzhzDPC7SmPQOHD3+FSPJ1cJnz+7oqO98gT7Hcy4zXr8PASrFDRu24hP6jx
	jqlvuNehkOap7v04LonzKeUUfNgcmqyZ6HQI5nlZfL5VKifQmMt1HBuNiD8opaBH3C+n8LIewBz
	3E9hLHoonz7f1S+NDTBIXUenUe+Pfhq1AFhSjLhLje0Ub5NyN2zFsmqvxPfZn2TAY1KW9whGHoT
	Yrr+oUr2O5A/jTmqwoTj/QJ2aOzjFtDQDDStszE/JqYBgBTmZnEJ7Gyo+BoIjtiopZ1apczl6hi
	IX0uFXzT6DY1aW0jqdFDVUugiej9I/72YEJcfO07oqJ/WV5P/PaZ2fkWW0kvNQVKazETj1TzIjT
	sK+raXbVFSiWTDFHtEzZq3zyb6sFEsYRg6FuI+UuYvxTZhq9Ikfs2CpgLrF5SyZqXAMCMibdsie
	1YCbVtE3Kq+Sz0fCeWoCqohCYA
X-Received: by 2002:a05:620a:288c:b0:8ca:3c67:891c with SMTP id af79cd13be357-8cbc8e817ecmr2182101385a.71.1772559119010;
        Tue, 03 Mar 2026 09:31:59 -0800 (PST)
Received: from [127.0.0.1] ([20.161.28.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf716207sm1672604085a.34.2026.03.03.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:31:58 -0800 (PST)
Message-Id: <24398664c2009cc1fe94f8cebec145d062d96abd.1772559114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
	<pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 17:31:52 +0000
Subject: [PATCH v4 2/4] run-command: extract sanitize_repo_env helper
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
Cc: gitster@pobox.com,
    fastcat@gmail.com,
    Eric Sunshine <sunshine@sunshineco.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The current prepare_other_repo_env() does two distinct things:

 1. Strip certain known environment variables that should be set by a
    child process based on a different repository.

 2. Set the GIT_DIR variable to avoid repository discovery.

The second item is valuable for child processes that operate on
submodules, where the repo discovery could be mistaken for the parent
repository.

In the next change, we will see an important case where only the first
item is required as the GIT_DIR discovery should happen naturally from
the '-C' parameter in the child process.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 run-command.c |  7 ++++++-
 run-command.h | 15 ++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..89dbe62ab8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1847,7 +1847,7 @@ int run_auto_maintenance(int quiet)
 	return run_command(&maint);
 }
 
-void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
+void sanitize_repo_env(struct strvec *env)
 {
 	const char * const *var;
 
@@ -1856,6 +1856,11 @@ void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
 		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
 			strvec_push(env, *var);
 	}
+}
+
+void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
+{
+	sanitize_repo_env(env);
 	strvec_pushf(env, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
 }
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..7e5a263ee6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -509,13 +509,18 @@ struct run_process_parallel_opts
  */
 void run_processes_parallel(const struct run_process_parallel_opts *opts);
 
+/**
+ * Unset all local-repo GIT_* variables in env; see local_repo_env in
+ * environment.h. GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT are preserved
+ * to pass -c and --config-env options from the parent process.
+ */
+void sanitize_repo_env(struct strvec *env);
+
 /**
  * Convenience function which prepares env for a command to be run in a
- * new repo. This adds all GIT_* environment variables to env with the
- * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
- * corresponding environment variables to be unset in the subprocess) and adds
- * an environment variable pointing to new_git_dir. See local_repo_env in
- * environment.h for more information.
+ * new repo. This removes variables pointing to the local repository (using
+ * sanitize_repo_env() above), and adds an environment variable pointing to
+ * new_git_dir.
  */
 void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);
 
-- 
gitgitgadget

