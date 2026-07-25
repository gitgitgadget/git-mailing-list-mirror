Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4917331EB9
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784978353; cv=none; b=hJKFG5L31364nFfYdwn9cV4urb4AB/uoMXBGmzAENqI+EpMRATZN7Dca/XlMCAXp80vP7/H+9d22jpIA19b3pSXHWhytLfM9Bxax8RC9hjvsKhykxXPSdrzX8mE0GnJ8S7EMsz70zgXbyr0Qu33OGoIuKer9qyLJ/CZY58GlQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784978353; c=relaxed/simple;
	bh=niXFwI4dLw2pRfRqoOyed/v470GNXpDI1Y3weYObnWs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=hZB/hZTkPTRMkaoT7dGPrJOlMEEku36h6OYC7sp3UX2t4kfcDnGHf7EqYn2U8oVL0KYRQpKN2CyilFUwH6oznKJQBO4NDbk//2wWL6uWSqxdl7jSX8KF03kFgZZtfzm4/+DXEr/KgHn+btF15DRRGE2pfxbQH5Q1XpYc4lIlf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvih+jkE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvih+jkE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc61541f8cso25908265ad.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784978351; x=1785583151; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vMNVxedH1Clmq9CMJQwwXpiPg5azqP9Nttp67ldLShw=;
        b=nvih+jkE4cuxaC7WAWKrltJrbntWhDKic7ywsusyXD/w0atPgSDR+hJrmKg3pCTpzG
         zKqZUVLCPBpf8XdxvKW/gjU3QquC/yfBf9KfJnBaRtcvDYI6CAMQbi7dtZlXOi1wMZ0F
         y9qmGEKZFeFue0ZL0/FQlz7URuxQYBUPbnGpRALOw2CgmKvIKBssn2J5bMfPSqUDY6nq
         97uIpp1nwN/PzZvkLYsfhRltNzS9/MyoP8Ua1DQAVpSfsgDcvbyqUCEehOMlTDJYYALz
         DGJQV5Mnis3LEMGMw4Lw8oZa7EqGNgHuW5WuNtn+0GFsqmtVS23NMtGEvcmdiSH1mnbM
         qmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784978351; x=1785583151;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMNVxedH1Clmq9CMJQwwXpiPg5azqP9Nttp67ldLShw=;
        b=XrdkdB2+tQzT0PWFY34M5TKPtDW1BF2KivkyIviaxympLIEr5ZsRG3JnJV8cgNCUSs
         lF3Pb/aY6y2byxNHut+5IjtJn7JkFsz+uaIp7HgzwKDuDTqBwPLIlPoor5UduArpEtDH
         reLtZC0WZfE+KoAPQhME8MyLetXIGYv3rQq6zxVzNJvLc9WhZPjO9UAE7qRhbk0v7te4
         IlMI5u6YAmaJW4pvAdlojCcSBIw44B4sC5Jp+KkkPJ+5jLYiGS6UkrO81lOm0WP2Wsnl
         /1tEFcjBI//OXlx3ajUPsaEfiSvp/HL8A++PUXRTa6SH6/c2Ixj5LTH5pS/3GlxpGAGn
         a3aw==
X-Gm-Message-State: AOJu0YyPMAJ/kM3fSWTuSqC74QR66RaiIbS4Uetly2lSVm9DaAc5I7gt
	hdXk4UJScPvEEh0dkiAX2A2cYvDXlGCC64QkPw5mZtZYL4+EzARC6BcY3gXXuw==
X-Gm-Gg: AR+sD139z+fETAxhF0DvNmb1unSpjhH6nIuFTzSY8bJ+Wp2KvtxaOWkcSE/vCX1opbq
	s7PrYA1ejRzegd6BvfeeXX+qd859DrKL7Sq95eka1+go75jfMR+XUxvY461uHgIxsa49v18EL8l
	tFJ6wQVpZv0p7dj5FJvrvbjc7aF4QAw+HwlmJuocP5gjcJ57RY95cxq9IdYU8njPnhwRXZBwDdz
	0Yey7piS/8skuzpD4GJyTJ0oYUC7xDmLIygxvr1ciY5wlqQuo70kCkmAdVUyrW3eQOt1KUz1Z02
	A5POvBS34cIlwlkCNtGI78GyHF2zi8d+Ya16oi3MmebboTHUTSiHkBW13H2ROfaqZpC5YsXZuin
	ZX/Pytmc9GV5YlHdZnECcps+cIRoB8lVOLuoLV7XNvaczyc1ha99aj7JIzKcg91OIqsZnYvXTwZ
	HjaOwAq6s=
X-Received: by 2002:a17:903:41cf:b0:2cf:461a:3863 with SMTP id d9443c01a7336-2cfd7194df2mr36769115ad.22.1784978351200;
        Sat, 25 Jul 2026 04:19:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc447f6bsm10738832eec.12.2026.07.25.04.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:19:10 -0700 (PDT)
Message-Id: <8bc69c6b80ed42888327331b1567cecf7225ea7e.1784978348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:19:06 +0000
Subject: [PATCH 1/2] worktree: don't read out of bounds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Marc Branchaud <marcnarc@xiplink.com>,
    =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy <pclouds@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

`worktree_basename` tries to read from memory before the passed `path`
string, if `path` is empty (or only consists of directory separators).
That results in unexpected nonsense data being returned to the caller,
which can lead to issues, such as `git worktree add ""` recursively
deleting the current working directory, including `.git`.

Stop reading out of bounds in these cases to avoid that behaviour.

This leads to `git worktree add ""` consistently exiting with the
message `BUG: How come '' becomes empty after sanitization?`, which is
still undesirable, but at least it doesn't result in data loss anymore.

This fixes https://github.com/git-for-windows/git/issues/6346

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 builtin/worktree.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4bc7b4f6e7..d8188035db 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -297,17 +297,21 @@ static void remove_junk_on_signal(int signo)
 static const char *worktree_basename(const char *path, int *olen)
 {
 	const char *name;
-	int len;
+	int len, len2;
 
-	len = strlen(path);
+	len2 = len = strlen(path);
 	while (len && is_dir_sep(path[len - 1]))
 		len--;
 
-	for (name = path + len - 1; name > path; name--)
-		if (is_dir_sep(*name)) {
-			name++;
-			break;
-		}
+	if(len) {
+		for (name = path + len - 1; name > path; name--)
+			if (is_dir_sep(*name)) {
+				name++;
+				break;
+			}
+	}
+	else
+		name = path + len2;
 
 	*olen = len;
 	return name;
-- 
gitgitgadget

