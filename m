Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42D3A169E
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411609; cv=none; b=akX/xz71C42fuFT2h1WAEP8r85Vis1daOAuH2wzoB7SWyKtnAMXCP32fW/lXUuAw+dJZ21GmIjEFnQmoXavDtfQz4iWQw6j3RSeYJTQNRq4bhmQoTI/wSsthpwxsBS6d3Js2iwvAaWJYigXx3uNeategLF/Wp0RphvGNeMnCc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411609; c=relaxed/simple;
	bh=tPZcAzZook5DMO6bjkcjRrtese8hgzEQz2zrNRTWxbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3zyhFm4ba8mXlPybs8iQxhlOr+pOCE/IfrpO08v/TCfD/yIzKOQXO/BPMfaRey7Bm4L1TGJbk0vcDLS6Sb7bL4eJ4YElO0Kqk6mFuQXGJ0q3aE44aIHxrl6ex/YItiEHhSXwqrEI0o8qvxGm+AgGdoz7Q4snZuC2i5riVniTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG6hBl8w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG6hBl8w"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so20983125e9.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411606; x=1774016406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V0CmV5ipmnz13sA0WTFvj+i5qyaFXYRtdz+hp6iy0Q0=;
        b=IG6hBl8wInzTXP5+Tzi38BpU5PQ8Zw/6MxsoiEKzz5x6LVeOwPF2nysHZdYnF07iQW
         FhSoVbNtZavB3nGSHAJhgVcpNMQ4PPf720DtRBLnui1BxWgf+HW8uOVYVV+XYSpKu3Jz
         iHFIPxov8+2MvxNhzpRepQI7IxkkCvqfIf4KVXBanSgSjk/5LF6ri0dhGtd4Ky+xMr8z
         A3X7JInPrbRa3IDdcTTtJy6WMfA7aQpdST1sTCwh8jqCtZ/0q/Z2kXMPFkytzeQczx83
         HxqdZ6a6ThfNAeeVVgOZGbr0f9S/UgeP5+hbe/I5wXsHIHpEGDTOjIndm0ThqMb91r/+
         zbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411606; x=1774016406;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0CmV5ipmnz13sA0WTFvj+i5qyaFXYRtdz+hp6iy0Q0=;
        b=M1I2QNvTp0aBF0nuOtG1X5zVuv1p6I/1U+Iw27nivhsHTX2pvdl0aOfVC7Bap8/00c
         iCmz8Ti6ZQbOtksOC04QGUZQgH80DO8LKA4aj/FZkRxEatTlyJq50uNGBq3o/PvzbxXA
         ljRgvkjeW2EWoOvzp9ZZEq+z5+Tk9E48iccNgqdT07Fa07hwt9Q8C2WdKqRB50HaoTLy
         EL1WfCR3+lPUqw8a8oPQF9dyFy3v14k2jEqJ7L0XkiRI5SR247ykIao3HFwknNIehpSY
         nGa/rbX24Y5266XjAjf2g2w7iZuww8tgNujqzJmQoZP1Ro+IxofkDdrxu2md3khnFE3h
         YZyg==
X-Gm-Message-State: AOJu0YwNyA9JzP+xZhNtb9SOPIHoOHPcydP8+b8+UZnu2sLOlZbKXP76
	uU0V/1eL6EOm2HIzZVJ0L2ha4B+pdPTj3RGrvNBobxNssFMdO1LXBtnnmTEMRg==
X-Gm-Gg: ATEYQzwzgLyreI403kWxEfeYsR8ZFdnAYqf/Sj6iF1xcnWxOkIlzuCvCA29wBrQRSzz
	Hcw1eu/mDZPDbNpC/auMOdNKYXtG6uQ21QAc6cHA3Lg5xwjUuEhblZ2Ea187zutoEd2VeForEHM
	Yg0ckbeD9ju4KzVEdcY2prQKSTtY85TagKPMqQtCawWi/SzLXWmfxUsZI45WnvXS+EzM9X9bTjn
	3jK0uEKYgQZQOm0gMV3hEBCCUU6oyei4IgmB9BjgTrblKe2C3qMXc3Ln+R2WOkQ5g4srMzADTPr
	DjkIigEvYzdbDP9ZRI98FCoD0RhUFkD7noly0gnS9tIZWsAJHunM4/wB8+Ndm7PQUQwfH3ik3al
	PDdgYkNFIg8TQkYoO1MefEXV7CM9t4dT/pjA8gox4tPFgLLMfsHU/qgdGEfgrhfvpScQc+F5pEf
	6GPlFS2nqFi7z7LwWz/ODArZt6AfA=
X-Received: by 2002:a05:600d:6451:10b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48556705319mr41187265e9.25.1773411606128;
        Fri, 13 Mar 2026 07:20:06 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a78cesm17215509f8f.11.2026.03.13.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:20:05 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/3] worktree: reject NULL worktree in get_worktree_git_dir()
Date: Fri, 13 Mar 2026 14:19:50 +0000
Message-ID: <1151b5b302069b4f3414a37e3be4bdbbc7e40686.1773411586.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This removes the final dependence on "the_repository" in
get_worktree_git_dir(). The last commit removed only caller that
passed a NULL worktree.

get_worktree_git_dir() has the following callers:

 - branch.c:prepare_checked_out_branches() which loops over all
   worktrees.

 - builtin/fsck.c:cmd_fsck() which loops over all worktrees.

 - builtin/receive-pack.c:update_worktree() which is called from
   update() only when "worktree" is non-NULL.

 - builtin/worktree.c:validate_no_submodules() which is called from
   check_clean_worktree() and move_worktree(), both of which supply
   a non-NULL worktree.

 - reachable.c:add_rebase_files() which loops over all worktrees.

 - revision.c:add_index_objects_to_pending() which loops over all
   worktrees.

 - worktree.c:is_current_worktree() which expects a non-NULL worktree.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 344ad0c031b..1ed5e8c3cd2 100644
--- a/worktree.c
+++ b/worktree.c
@@ -227,7 +227,7 @@ struct worktree **get_worktrees_without_reading_head(void)
 char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
-		return xstrdup(repo_get_git_dir(the_repository));
+		BUG("%s() called with NULL worktree", __func__);
 	else if (!wt->id)
 		return xstrdup(repo_get_common_dir(wt->repo));
 	else
-- 
2.52.0.362.g884e03848a9

