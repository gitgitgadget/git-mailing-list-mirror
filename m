Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2DF27E1C3
	for <git@vger.kernel.org>; Wed, 28 May 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426331; cv=none; b=YWSF9KFdA25OVoOp1yxfRSf27snCx08AlOiyNvpNf3bWcvnCZ3TdtEx+PhM9e9LIdhBqE8csIo/BUL9Nzr5d3xYEiNV5Rle0yOj5HxBLPVAoIc5716/+p80GyLTKJsK4UZoTWA4/Vws5H5L65xu/9jjr4+SS3xWNzDnU0Lcf9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426331; c=relaxed/simple;
	bh=hC3mOYPPXUYm15dHe0vv8C+xQhvnY/0JomI5p3gPKLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oe9N3KbqkD8IfS0lgKRC26c9LyH+6G8whNw6s9VlhhsKh13RgZFD6VNDacLQgoChzmPpjRvj7DW4GnYI0hdSMXeUn8ME1RtGzjdC5An51gAFMkZshv31PKixXS3pE6vQ7eox9895HimZQ9Oiflrh3JFqWQZPEpasJn/+pK+hj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RDfkhn0s; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RDfkhn0s"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26f01c638fso3482942a12.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748426328; x=1749031128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyTEbW04vbZsrBVK+M4l6YqF70BAO9Y/k30Ev/zEPB4=;
        b=RDfkhn0sODV77YIMUtJCUCZTFIhmui/wRN3p/VRyuKlb/8462tcBoim3WWhlz9gkuQ
         ql4wsEgvXxq5mVlbPfAKW1vMKPzAPGoPdWui2IuWNfpuA+bJv8nXi9pT0+sLibrGmFmt
         qyGsZc7A8SxdZf9NXQj/8vjFxGSCBbIoeMn4vjbLEwfivkZ7c9CSD4zBu0ybE7B7DNIN
         IjG6lBj+MPCgHO2AUfLWgr1LnKoa4+eL8fUB4eJ4dxE6ymF3HFm9BM78RQK0aSPG0gmw
         n+r2haOQmNOAHzK2Y0boLwCfbEtn+dWVpwQudYjC7bkHAfPVJdywxYW1kWHZZ3+YSAAH
         HE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748426328; x=1749031128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyTEbW04vbZsrBVK+M4l6YqF70BAO9Y/k30Ev/zEPB4=;
        b=HfS+ZP0c+hE4WTx9MApAZ634l7UTMC1ZQvW/bFUq9z9mWfPRnRlIUqEfRR6bQGSj4y
         yl8xi21UYNSQ4hyUdnKzWjG4w0Hxy7fJY86ypbJKQoiiEmLJ+VaUcUqgEut6uKUQ8WVq
         AZE9eRk1MslTfNWGokufZ+C7Sd7jo+vb6/X1kSk1oT3UhWyyjZ6or5A+z0Z7jcQons5K
         oVZsPx7yQUhLP9NKlBcUmD1aesk6URuIQb+j16AVWMd4Z1QqNaZzJshX6V0Ry64eQ4x9
         Q7yyZ2MaBhPCRvNscKoNt7vdYP2U51MEDLxuT4blWITh3cKdJMz2l7DPgSKQPaGxl+W7
         Targ==
X-Gm-Message-State: AOJu0YxpKjxs90Ru9PvXdNm+kTAGjO8T8zW7BvoMHNpXcaUf1Oala8zL
	fmASLW/Si5GWd2BIraqDMllaW9NHSq2xyhYleLRfl0s9g/mFsoE6wltABYwjT0eu8FyC1BjOxNL
	U7Ox1cJY=
X-Gm-Gg: ASbGncu/pLKfBlO6K6ZlPaDIzoAZ7S0s0VkviK7zfhTSIzk+wPSLjJtfmiVgAaYU1W+
	2ko+URKLSWPCaCeRoSyZYaoiei67ItMyLNLwOMgbVBKEG3ixrQFASnRSeF6uhK9HXwKW2uK+yDB
	7oRCLKYmDKx795NTQZUeDoqft1kCz4VeavDlsSCbIFhTalkbWbd8zDKBMKNLLi2P7IQaAkepNoS
	A8TjPhP7+7AsaQL9lt3RyoFgjIvCwMbX9uISp3EsEqdzBYKRQkSAo4iVZSri0qi1fa7bkFXXnG4
	KvVmitFWGdKUuTFREHRuwmBA4EXM6hX2PVnlgUxGNB4a7BaXjnmGofZAYxwVoXERILh/jg/yeBn
	aY2J/qVNw
X-Google-Smtp-Source: AGHT+IGe69fkWqD31tRN7NuJ8LTp0nh8Y65rxmTVhVFIKRNMyNjnmEIHyYWbVuOknufCidOaq0XLtQ==
X-Received: by 2002:a17:903:4b04:b0:234:d431:ec77 with SMTP id d9443c01a7336-234d431f1a7mr20428235ad.6.1748426328514;
        Wed, 28 May 2025 02:58:48 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35920dcsm8277275ad.127.2025.05.28.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:58:47 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	jonathantanmy@google.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] promisor-remote: remove the promisor object check for failed fetch
Date: Wed, 28 May 2025 17:58:30 +0800
Message-ID: <20250528095830.30306-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the promisor objects fail to fetch, we check the remaining objects
to see if they are indeed promisor objects. Then, we die on the first
remaining promisor object. However, this promisor object check is 
unnecessary because callers of promisor_remote_get_direct already filter
out local objects. All objects passed to promisor_remote_get_direct are
promisor objects.

The is_promisor_object check essentially iterates through every object
in the local packfiles and adds them to an oid set. This process is
agonizingly slow for large repositories.
Remove the check so that we fail immediately.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 promisor-remote.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 9d058586df..f42ea4ce78 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -275,7 +275,6 @@ void promisor_remote_get_direct(struct repository *repo,
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
-	int i;
 
 	if (oid_nr == 0)
 		return;
@@ -296,10 +295,9 @@ void promisor_remote_get_direct(struct repository *repo,
 		goto all_fetched;
 	}
 
-	for (i = 0; i < remaining_nr; i++) {
-		if (is_promisor_object(repo, &remaining_oids[i]))
-			die(_("could not fetch %s from promisor remote"),
-			    oid_to_hex(&remaining_oids[i]));
+	if (remaining_nr) {
+		die(_("could not fetch %s from promisor remote"),
+			oid_to_hex(&remaining_oids[0]));
 	}
 
 all_fetched:
-- 
2.48.1

