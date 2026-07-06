Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE141D4E4
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363142; cv=none; b=bBLXGPh3MeQhXgLhQkHrTCH/UaU3lyE/P+B8tAeSzP471WTvuFLnIszPL+TYGS97tfJM6JYNwYRVgjdwN2gJo1qqp+xMtbyo+sfTQtyPfs4TLTSUU5zvJYtCV3kQNYQooMwYH9I+6BJhUH6Vf3J3tRwH2PqVCDgSHQxYUnhQZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363142; c=relaxed/simple;
	bh=wR+fK1N/k/ZXSbF444SZE8MPZ702ruPcVYUYNO6leCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCM9qwJ+ycmIzIYw7PIk7B1CX79jMIELUq4N1gEUUAtmg0zCKwtITv1v7PKtSmZwdKnePPAKvPKsY5gSjWszGdG+taNPMnzwPcqbQrplUxD4QgWCL3ggL+QWJ1OacZ9U01tcve4aKPR3b/ttaaacS7OqbVcTpNHfmkQaB+vXLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s85HXg8/; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s85HXg8/"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2cad9d80dc0so3910395ad.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783363139; x=1783967939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZrMBiROORBO1pM0U521gelvOjDDVPfUHK/xmQHzNTgE=;
        b=s85HXg8/Hqt9tbuC9AQrB3zSAZgDq2vhWc0ezM9Fd5vH6NfdF+CMCVuigp5Xh3V0DA
         Z4dWyFT5ZwlOD9FMAWWbBbfkhvxpFdgeAHiQus2tCTlQ95ad/zmXjn4dtIvEA0aQNASU
         jaLRZesBEYrECQFUw/H2f0nISThWEgoE4v9prOfbQmh8EYXBOa6Dy5RhJxljUqj6D55X
         fIRBtzb+Y9qbAU291/WCYR2+1z5HZKVMqMgBj7Hdc1WII62anBn2uKL4Va+VWMrt+5zM
         ZuhQ9wVeYNhOdU4T5s9V8QgYAiqkTJCv/Kv2YeWMFDi1uheRq9QUEObUi8Uzdr5jQ156
         sxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783363139; x=1783967939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrMBiROORBO1pM0U521gelvOjDDVPfUHK/xmQHzNTgE=;
        b=A8BvB3fmAPb+ck2nVdnL7Q9oh6UgQZmcvW+zLN6XfpKk0ZjJMq87bC5tBFXQBKwTrw
         b1NZ+xvLHBAxksMFb0vNEFxtVVK6yZ8LH1s+SwEsuG454/t2Sje+y9dk/g6vH699+ppz
         /9BuiOjtlqmpGimKSjOvmTiKFDMBRYj2TtAMgOoMlLztryedntiw2VnkMGuKXKWX7IQu
         xBDsUjh/DsVInBRr6J+LPN7vUdGl7TjHDund8a2BRUUa3UCrmAUtO3o9fOlnd6iTP+4E
         VOO3aoamfOhjpoIVwd1lMdQ2wgJRLJJWcNMLgejW3gysZAhcQtJ/r7jHIa/3Gm5ddMkn
         JT4Q==
X-Gm-Message-State: AOJu0YyTCWWrN4BHVzEB7+Ub6wCwIqRj5idbVFpEt4Jtc3l2EQ4jfkMy
	SuOM4E32+ghR1hl2FQhoJ0xmdu2OhHiGtNYtl54vq2B30rlqNPsbKFykZGRSQUlsrfA=
X-Gm-Gg: AfdE7cmcfXI4XlEYujwLigNJNq57Cm6Ca/+oCHqm4Y81hIn6Za2AreVqsKJMzkYNVBj
	RXYpxDvFx8DA0E3zbUklKO/m/wD9uqX0gQgj/GCu0rcE/ttpzLOWKinpkVdTzkmoKNT/koHW04U
	tr5aE+3K/nrvoXN1ykbLZW9gCkN/RXsLZjB8hlz9F0ZcMCNDLT0U1EZYbUIA7tLW1mMeeaLohDz
	VEgpWee9sDFsPLV6Zu7DpsRuKNeRxJ3uteDGh+iSb3ltu68dw18hjy3ylgJRDrlkC1lDaaz2pbR
	v0lxSESG2v9T/AFiK6bQPY9ZI6PflrP0/dB5se3BpPayPGCcYkidHGFmP7UnwigjcGdZFPBVJ1m
	BWkG+sb4doCc7mDbY+EmOzkunZketzhHM/+Rc+V1WqnLgtiVKJrtuHqeRRCKAVl/l43RNgEkgQU
	P4/kaTrDRkiTE6G2BpjoFvmWidUhBvcw6gnoCHMFpH1eMNhp7yMrsxdMbscA==
X-Received: by 2002:a05:6a20:c799:b0:3bf:aa1f:4881 with SMTP id adf61e73a8af0-3c08ef34b2dmr2047430637.56.1783363139425;
        Mon, 06 Jul 2026 11:38:59 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm73455218c88.12.2026.07.06.11.38.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 11:38:58 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH] setup.c: use die_errno() when chdir() system call fails
Date: Tue,  7 Jul 2026 00:08:51 +0530
Message-ID: <20260706183851.90517-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..e2e98d1126 100644
--- a/setup.c
+++ b/setup.c
@@ -1954,13 +1954,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
-			die(_("cannot change to '%s'"), dir.buf);
+			die_errno(_("cannot change to '%s'"), dir.buf);
 		prefix = setup_discovered_git_dir(repo, gitdir.buf, &cwd, dir.len,
 						  &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
-			die(_("cannot change to '%s'"), dir.buf);
+			die_errno(_("cannot change to '%s'"), dir.buf);
 		prefix = setup_bare_git_dir(repo, &cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
-- 
2.54.0

