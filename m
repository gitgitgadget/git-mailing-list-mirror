Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC03C9ECE
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140432; cv=none; b=EcTsDm1cwimsO04bKBcfw25RkD2MfXOCZXBSKkwt+aRd7E+/D8lUs39maIvJVQg37KvD7gdq1geZPoJv69gp7bOJqiJMqtlFsfzN1VIw4BUuOIPVDLRPoCSTFk1olgs4lTWs1p47pcCcDUmzdoE5qbGo+4otilZsUT8SqcZQrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140432; c=relaxed/simple;
	bh=dtncqUT7zDp/SpAEOWhVR9ivNLDtj9HO9Yn/da0pYmc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=boqGCUu38tTG5gD5zKiPHzEmsrJ49AjFWQiq5moC4vZiErojkbESi9bh6CH1/bQy4ri6Q5ETmwJAdGjPWOcGHUhrYANcHZa2iwBl5D8JSjMC7Ca40cV+9XJQpBQYOcSfG8Fu40rblIWjwoN1Avde9WpJH4cJNKhEiCzJ/1sCnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL3ZFisK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL3ZFisK"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899d6b7b073so12270466d6.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140430; x=1775745230; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB/n1bjwPf5DzQNdvwgWmbQWriYNdfNABq5Yc7hCd4A=;
        b=ZL3ZFisK21YLEobj8CeuL99VAASpMhhOvSYEB/IItetoYFRc37ODAu3KmEAcmkObT2
         I7tibo40MT/a67Hg6b6oSAlT+f8k5AwvHxNAE5o008knB4JLtV32D+JKcBQbqcRikQN8
         KTtIVHQuK2e7R13UcQTcGJfejD79GcYprOP6HVphPsrkbqdNJKfkvKocNsEVfoY0sQ6W
         B0BvmNLHnlDF/ooxjZ+21+GG0IBZraLPYo7HoOYjgvPY7qqwx864Z7hJFg28doQC0HHA
         PycwIIKGsuzO3OH4IG9R7MuHX/9XA7HnJsLwUW4rqCjir4oJvy2BVntjmU6iswZUBEVh
         DvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140430; x=1775745230;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aB/n1bjwPf5DzQNdvwgWmbQWriYNdfNABq5Yc7hCd4A=;
        b=SYMlU+CjbbeOmpQonHcaTtuHDn9CEYCMW0KRZfhQhl/ZSMLw3b6wk1rj3Ag7PKce89
         oZCERJoTb5hb4vV9INiKfRLk0EYfTKk+xlphOOD9oE/ZE8OO0FW8TstGRQxrviy+c2j9
         0FQHRI7nHj7qn1Wf3ZJIyziB30+Rz3srokZb5ZvgvDcFeFym36TxMersqYE5a6+qhxRZ
         qrzKrJtA0CPj+DHByXLmowdd/75zggnMDDXcvNRHHm/scJnCVppUNe+9AsJbqExN6VeD
         499h+1bXlUVXkkcJJmRO+G2Nb1bMqAoeqTWf6qjib3/B7SLqc2GknZ7bs5vPmSbkR22d
         MEeg==
X-Gm-Message-State: AOJu0YwxF8TvfsLVwfhHhnJC8w1uXVIV/E7NUPprha+mio3r18PkhO9G
	p9SGuR59329foa9DDEhQSzZCbCByOOKt0qvoCHtYSgNslDcjGmWux4v5qjYTRQ==
X-Gm-Gg: AeBDiessw+05CavZsG4zsvwKCxsTiRmG1uaRKAm4cvZ5MwvX8RpDWmhs+L93I7rOj+3
	u7ROXbTeMfBH2j2Ug6ijrt/RjdNRm+eg5hzryKb3Ch/6Htp+RwK7pwrAvrk4tn7Bqs8DiS/m2BC
	KGyyckskHPyxR07QnzIY9uSVoiy+oAKAFVhI98KEU276DPVwtNvnZ/9pM+8bApYs+dn2KXSGrVN
	6MayXbs8evcZCBLzYaTaBuPYYRyJnnksE4xJhT/ykrpiT+s8RQeP/huTj82a5tpSW+ULw3nZtt/
	xMIGQ4t2n6pbBDXaczcmq6o6nHQrFtteAXDQZzLPXJgeHnzkUexCiZbCv2qRoonqvMmJ8Uit73I
	FGzLX4jSx350Pp2rDC08YXkGfbxftS12thsfdgyQQEltJuWxbKfRVB/iORRNeqOLlk0zZ+nKyFj
	C1fNWVYvKdb7pGMo2sfBK4wVZvXLY=
X-Received: by 2002:a05:6214:3d08:b0:89a:622e:d32c with SMTP id 6a1803df08f44-8a4391c09a1mr115628006d6.36.1775140429661;
        Thu, 02 Apr 2026 07:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593ded920sm24377486d6.21.2026.04.02.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:49 -0700 (PDT)
Message-Id: <c8e5bef27b4635774eb88f29c98e35e2c613d5a8.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:23 +0000
Subject: [PATCH 17/17] git p4 clone --bare: need to be explicit about the
 gitdir
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `safe.bareRepository` will change to be safe by default, bare
repositories won't be discovered by default anymore. To prepare for
this, `git p4` must be explicit about the gitdir when cloning into a
bare repository, and no longer rely on that implicit discovery.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-p4.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-p4.py b/git-p4.py
index c0ca7becaf..dd38dbca22 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4360,6 +4360,7 @@ class P4Clone(P4Sync):
         init_cmd = ["git", "init"]
         if self.cloneBare:
             init_cmd.append("--bare")
+            os.environ["GIT_DIR"] = os.getcwd()
         retcode = subprocess.call(init_cmd)
         if retcode:
             raise subprocess.CalledProcessError(retcode, init_cmd)
-- 
gitgitgadget
