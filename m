Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B4BA42
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006613; cv=none; b=ggC8w8SNvKpaTdktTmUFu+6yKT/ZWkeRlbb3Eo4jMLgEETntBW1G2vunqt2+2FWUmPhA1B5al1wlQGuemuBZnI6LVueEr0oTQcM4t+8Z7+8Qr0u/Vn2iVafAZkrrw5wct7/3rtUFydupKHLqdpG1+DSnPBdl++9hkaQm3CVv/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006613; c=relaxed/simple;
	bh=FYDGF4rJgORWWeF+nGCFme965D/IppZJst8p+JaxN6k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mJYdSAgMqUvwqbep3zqOq7wza4VJHzSp0WDbDzJ4l/g1aKTRaXXJj374bgaiCOZPIutKbls8IH0Q2cWs6/jgVO6nLlrRLEng5wx3sh/YNfRFTAJIxDxLdA83lBfwo06buF0E/eLcgoxzRECUJ0Htumm+aPacozlQFfeRWeM2FAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvF6y6DK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvF6y6DK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450dd065828so32598405e9.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749006609; x=1749611409; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dB+Jx+ocKI/Ce/7upOy8ub6qTvE+oY41On1eqIDJkL8=;
        b=YvF6y6DKCipcG8PdSiuYqh7K6/FrKxk279OvfeX0sL3xGbxzf+uCC4nD1hsJzEpd+M
         /FamzyC4hAbhcEzwEj7k+C44oJcEk3cG5cbQQrup3ChUUE3o/Iy88mvvU/G2dcHq57+J
         RpNR7A5wVXkPhHZSr9TPa9qrUXbYe4zYRl2lC64vOS5Ut9nlqfNAazDAL/LCCW/p3W2c
         BUBognGv0E4UvSPIlkJvLM0p82gddxzIUGJ2PTa+srN7BntmkCYXeZvRPDokdbQd4IUy
         JdkLFbHJRuQgJHGtzd7dy8vBQrwylJlyaEk08rQ/gow3lJ+lAFhzoEIKyZU9uVP7OCfQ
         jwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749006609; x=1749611409;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB+Jx+ocKI/Ce/7upOy8ub6qTvE+oY41On1eqIDJkL8=;
        b=TfgHglC7bSm/WsVfNC0SAK+69/gbVZDiV8FvSMBMBDrfqHrXOwy6KOenZP0XIxp6qf
         UOcRzRTWn7+6+gK6krV7qlQDWSb31DJ3IH1yXZJnJMUKrZ+RhHyKSBl1eEYc6WJEZKS1
         IvTWam2CmNHNcYJteU6J6cRI/RT5Qq8W410+iP9XBWI2PIhezynactXqrPoQTIk6AACa
         mVo7UULSoVxDCect0ieofwPdmIv7yRjzsU72bCdw/T0wT9rP+pea0gVBCxNqY1t/1gLe
         bk6vbvOVXlspQsqKs90wQGAbVUsD2QmCwfy8fA8+QS8WMtRdMi9mFf4TThI+WpQCwm8m
         X8MQ==
X-Gm-Message-State: AOJu0YwfbdoLgEnWcVjqAHQic+wNUBCP6MiEQFOt7+jmMOax1pfnGSKj
	i/7VpYH9kTRrgrUeEmxS5ajY+EVZeaGy7MRnYBceznvmr2EhUpwx8uB1B67oYA==
X-Gm-Gg: ASbGncvji78DRl8yYCxKRl89BbgPIysq7GTbraIvquuKrf/pqSJnMdZfA1ItMS/Up9m
	jgpW0r5UWXYRRSOA8EGKxxUIgSrlJ3E5aFvHN9UqDe9hBJLBLOHIyrmFmzaPCgV2PnXhKzloPoW
	p9fMoKCzZcUW8nBAWcdF1K8o2daEaEIiMhGgHdeh+7vdHiQJHnjUdImhWQldqN7HE5rurAkSS8J
	dtYhv4GKZfbWsKxIQUMEDK5s4kCOEiiu4DuU98FrVnD4GyssUYDEJaDkddktCV0QxtEou8uEU9o
	fGbFOnD9gaJegY0u/cUdrzSu/duyorFszexaSum7oqtPuVY4f3GZ
X-Google-Smtp-Source: AGHT+IF74m7oPBeOZugX87tHkNrEThE8+xoU8xyPhoclkr5zxeilL1xbHe7PLpSzeCQmD6CbhgCDrg==
X-Received: by 2002:a05:600c:8b25:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-451f0a77574mr8100295e9.14.1749006608763;
        Tue, 03 Jun 2025 20:10:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c43asm19830087f8f.21.2025.06.03.20.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 20:10:08 -0700 (PDT)
Message-Id: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 03:10:07 +0000
Subject: [PATCH] repo_logmsg_reencode: fix memory leak when use
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1988%2Fbrandb97%2Ffix-reencode-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1988/brandb97/fix-reencode-leak-v1
Pull-Request: https://github.com/git/git/pull/1988

 builtin/replay.c   | 1 +
 builtin/shortlog.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index 30075b67be8..dfc7e85ae96 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -186,8 +186,10 @@ static void insert_records_from_trailers(struct shortlog *log,
 	commit_buffer = repo_logmsg_reencode(the_repository, commit, NULL,
 					     ctx->output_encoding);
 	body = strstr(commit_buffer, "\n\n");
-	if (!body)
+	if (!body) {
+		repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
 		return;
+	}
 
 	trailer_iterator_init(&iter, body);
 	while (trailer_iterator_advance(&iter)) {

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
