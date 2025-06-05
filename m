Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F612566
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104851; cv=none; b=mzwr5nYNVKxNUSkSqDYb1S+wiIoLzDFlJq5KkdOEED0S9++Q134WklUGGA0l2Ucm6g0NtcBgKHIbVQagzWn2BbK1T9BPwq/vaNnGQ3VvB6q/qTtWLMEGKHXqGq5b3AzrRGoxaOvMErEqAykz+tqY0lsokbScU5L21qZs/v/m9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104851; c=relaxed/simple;
	bh=CrCqvLyJiu0vRugLGK7JEHIKj0M3WwXCuQdlCV/G69g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IlKDaoflp9L3j7gxytVN3KgVlM/EApKWMY53s5vRwq3w96AC++cS8HYIFI6ywYrX5j9nv4KUC6vbD6X1d+YlAUMHkSjQEfgRdvyHoxB3cAaqsOLFH+KXqLzFYZBl/k4F8HZ8M0Ihe9+1Orx13Lb7N79UndEYIpF3fhLyLg/9Z98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA/TI+fV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA/TI+fV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d54214adso4268455e9.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749104848; x=1749709648; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6hkdkXklH2vda1T+3VuQ1vBo7x5DYEzTQA/dTC4XqM=;
        b=FA/TI+fV+NjE2oAqZU5D7tVo6thw46uIxAC8Xs1p9oWUnVdRQkVAdfq7DyUtfdFuUt
         OxiaGTVhugRaWECDAhshBxp12WGMdy+bOQoRK+IN9zn0E5TxaSzU1Jx+zieZfHj6CbN8
         ymIkRW7MOgIkghqPiClyg28oLXLNsRvX4sYQWQmnLeS+h2wnnBAr1lxV2L5oaRCTDWPA
         9qDk6PuRFoldJSsADOnF2iJPOcq7cg+jLR1hzNayMsIKjso32/kk6a9/OipcRcMQUPtC
         BMxXmC0Pa90Q6qOL+UEM9M+J4liiGpIoFOqFPuV0PSBcjv3TvCm7uP+sLs8nvUoGA+l8
         RQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749104848; x=1749709648;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6hkdkXklH2vda1T+3VuQ1vBo7x5DYEzTQA/dTC4XqM=;
        b=l/RaIUFESbk4zPeQvpG9NjVNAdP3e75CEyE3OMrsNXzKV6DRY9ClWB68zQ6RqvYMa4
         4mu2qGMKWBVumGfoqWabzjcw9fCpi7v/+i1PEvFRO2D1fw7MtDGGoRhaINy+Fki1LarJ
         OxnFVdWGLjPBweQot8bdgMY2yG9PnVG4UafvpFCQNi+2ql5kGafpoTROQ4zDorPdmK75
         9ctact9WFnmxZyi3xUe/fRHGs0UOxIefpoxIhbiKp4VO/oUME7X83As/OyABGpowZFkx
         Am+G+/EapFS1mdjYHaS0IhCQouNfed51C5P2lC15cqiFUEXMU2i/SjoXWuwNvhNK/M9F
         SGqA==
X-Gm-Message-State: AOJu0YzlHPL5/fhHQqoREMdhgPrTUZX7B3P6/tU2DYrucZKzILCj9ByC
	3FI6k9GRFyNsif7XrCI5jncVJ1X98ZxdviI9TMTr97ppPS5YIq9WRWw5DDoxhA==
X-Gm-Gg: ASbGnctsiKR5EPfHDl+5ns723ESX2IQrUQM3J5rodroXIAOTOEFG21okX3QDdIjCG0p
	p+7eWeuFqyy+Mxg1s6KxWvB9omEZBUfmsLoQUoUz+5UFEr6/sVjbqFd8uN9X96NIeoqSeyF3P6a
	+sVEG84d5t5nZ33Z+cmdH3UV2mvW7yoEkmgUFwn8OgFtuDScmM5PfVYSVjbElWotHaizECOsADP
	B++i3ise8n1/oaS+Y99K0QsSL7Dd0WfvK995cmJSJS1OiUmo/hfk+KcpgSOIZRL/5uQ3sPW5lKC
	qhm0R+OOHU3pd95hpWeslbT7dpURyNzo0OduWBouShWdLJcSQ6wG
X-Google-Smtp-Source: AGHT+IG/aoG6KRlZhIygIFfNSODASdXw8NdLi90wvnRI9Kv3fOAD9KCSOOjc7KWrLAj2ffHdzQjY3g==
X-Received: by 2002:a05:600c:3106:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-451f0a76df0mr63785755e9.10.1749104847561;
        Wed, 04 Jun 2025 23:27:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f9662cd1sm13778625e9.0.2025.06.04.23.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 23:27:27 -0700 (PDT)
Message-Id: <pull.1988.v2.git.git.1749104846531.gitgitgadget@gmail.com>
In-Reply-To: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
References: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 06:27:26 +0000
Subject: [PATCH v2] repo_logmsg_reencode: fix memory leak when use
 repo_logmsg_reencode()
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

pretty.c:repo_logmsg_reencode() allocated memory should be freed with
repo_unuse_commit_buffer(). Callers sometimes forgot free it at exit
point. Add `repo_unuse_commit_buffer()` in insert_records_from_trailers
at builtin/shortlog.c and create_commit at builtin/replay.c

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    repo_logmsg_reencode: fix memory leak when use repo_logmsg_reencode()
    
    pretty.c:repo_logmsg_reencode() allocated memory should be freed with
    repo_unuse_commit_buffer(). Callers sometimes forgot free it at exit
    point. Add repo_unuse_commit_buffer() in insert_records_from_trailers at
    builtin/shortlog.c and create_commit at builtin/replay.c.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1988%2Fbrandb97%2Ffix-reencode-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1988/brandb97/fix-reencode-leak-v2
Pull-Request: https://github.com/git/git/pull/1988

Range-diff vs v1:

 1:  a414074f167 ! 1:  f5165d6a102 repo_logmsg_reencode: fix memory leak when use repo_logmsg_reencode()
     @@ builtin/replay.c: static struct commit *create_commit(struct repository *repo,
      
       ## builtin/shortlog.c ##
      @@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *log,
     - 	commit_buffer = repo_logmsg_reencode(the_repository, commit, NULL,
       					     ctx->output_encoding);
       	body = strstr(commit_buffer, "\n\n");
     --	if (!body)
     -+	if (!body) {
     -+		repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
     - 		return;
     -+	}
     + 	if (!body)
     +-		return;
     ++		goto out;
       
       	trailer_iterator_init(&iter, body);
       	while (trailer_iterator_advance(&iter)) {
     +@@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *log,
     + 	}
     + 	trailer_iterator_release(&iter);
     + 
     ++out:
     + 	strbuf_release(&ident);
     + 	repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
     + }


 builtin/replay.c   | 1 +
 builtin/shortlog.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 225cef08807..6172c8aacc9 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -84,6 +84,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
+	repo_unuse_commit_buffer(the_repository, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 30075b67be8..fe15e114973 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -187,7 +187,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 					     ctx->output_encoding);
 	body = strstr(commit_buffer, "\n\n");
 	if (!body)
-		return;
+		goto out;
 
 	trailer_iterator_init(&iter, body);
 	while (trailer_iterator_advance(&iter)) {
@@ -206,6 +206,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 	}
 	trailer_iterator_release(&iter);
 
+out:
 	strbuf_release(&ident);
 	repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
 }

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
