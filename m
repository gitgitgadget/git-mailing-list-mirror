Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F952D1901
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171965; cv=none; b=M1lUpbSwmxYpdMDNUmKs5eHLnJPE6+0Rhjaq6adnLmqLNmm7zAS6kKIGdrjQwdHXRvUKpQNKzjPEn536mHxxziQycj1inwJwwGsOzcWydTOVk4jgOsHiSPJyuT7e4Fc5jDK2BFqqRjy69xBpcMn9d5W9W+iitw6yh3cwIiwiLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171965; c=relaxed/simple;
	bh=ZkG1GeGebvxK1Nlj4Bm+8tiOPzWVWBq96m7RRmAnPaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIsUqh584hGpmZ2nE5o9W12hk2BJyScXGCJbk0ywqDoAOgn5UlL2EdXnbSczHWbnBF1mTl/p0UXIxapKPuwFRzY6CK6+XefKWQ01l7dTGve6GM3NB4g64jQNqxOuFYyZihP5JO0gauduV9t77Z2S21MN4oA6geMSGYRzaTRZeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2Zxbre4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2Zxbre4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2352400344aso47251835ad.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171963; x=1753776763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5GhttFXQyNWMkH4PFO/MJh2fhRMjpxrlt5sBExZFCk=;
        b=S2Zxbre4B0duPFD+HJcoIJ2Xz8Gv98ToZybQ9axFeGY8+mCUmr1zSeWKnR+SjTLBaX
         5T2WJERbfBnyRcCPUwoLXXhSuQKRuYcYqA3M7fbf1VdBgNMazabX2YSMN9cuMjG0NC6b
         IBGJHe8Naron3gXb+ojoaW4EC9d/lTOK30X3aGuRUWeMJlEDLKcG2ty7v5Y4FpBxjKyy
         +JtbK/Q8MDT6NrJX+7oK0VHJRiI81mGTc0C4VIsCb5xP1NZLcVs8Qp161vGSz9T0nEUF
         OeAHPmz6MMUm2Tu4na4vBJTyzCCIXolQC00ZMy+bILB234vUTq1iJ4ZT6p94S57/2Z1C
         PZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171963; x=1753776763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5GhttFXQyNWMkH4PFO/MJh2fhRMjpxrlt5sBExZFCk=;
        b=ajjHgVDqsj25JUcGGZ5JEMhWwiYaY7UqFF1JVAZrddbp97SAOBgLrtYq67+8XF8qcW
         DeHx5rVle04q0KHCwEHTv4fnvZbNwMNEeE9fEKYSic8T6SmSS5uS0/UJ+TDTCKqhHfSp
         lVaRtEwSHdfiUtzy11dIyjar4xFLXjwPO8IOGGNoLEfVRuD7oilXZ1RHNgSNQmV6k6Ll
         2BXRTMJEZXjrupgJ5OIlWnXcQfUIstBLeEkt+JrIZV86ztItP/IHhdNPG1YcfYCjDBcv
         b/eBoqyEcUg9hWzUvN2V/5mETu7TIVe0ZGlCgh7VG62bFlrf4odsn9gm7WTWClYO0RyI
         zX5A==
X-Gm-Message-State: AOJu0Ywu2QDKtBQCMAzr5IDZi2UfNxzzqF4xzby4ml6sHBdGcR2J9yNp
	HnlM0lnwif4dbAKo3STCKCu6Cyz/2TQDk4x4AEk/uYd8JFEGLBuImWvxKQ0bh0rH
X-Gm-Gg: ASbGncvcB0R91eeMDUKjLvpzCGWDX+BQDVA7Rk0GpQFQsj7wehIAUchL7Kz7UvyPv5z
	FY0kbywnneNILqa5Ur0B8P8HCSEhWIukSnsGQuxt0zWFUnxAiW+Kgs8WISAx1QnwVnRlWEqy/UN
	im6gmIi6gVoFEAGaTEERltTXKbUMkUqrK67zqiTciO3sp2VCPJ9wajr2Z6hBjSCci15ajcqo6O8
	M4ZWh2MJF1EuE7FKEBPRsnUMt/4QtiImSNfXaiUC0u+3+RQiMN+rZrGJskyS/Nm3v0WOzX5EOTX
	BYEi+RPnCkE9jkecd6NLJxSnCEFV3q/uAvLYeiOVw1FLNuoCdJEy2F2Y6sXamssIWbg5KKeOOUm
	5+EiDs6oREYf04WdqoKavlacPyYUnwz9S/c09eGpmXQuX
X-Google-Smtp-Source: AGHT+IEULh3GrbrT6v+uHhpj6WjCwdJnmC3ENfA1wT/AW8V6NweYROGqd5dMNTzk4bofyfZ6atfojw==
X-Received: by 2002:a17:902:c405:b0:236:7333:f183 with SMTP id d9443c01a7336-23e24f4a679mr335269865ad.19.1753171963180;
        Tue, 22 Jul 2025 01:12:43 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1b8f89sm11584538a91.9.2025.07.22.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:12:42 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v2 3/4] t/helper/test-delta: close fd if fstat() fails after open()
Date: Tue, 22 Jul 2025 08:12:18 +0000
Message-Id: <20250722081219.1086866-4-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722081219.1086866-1-lhywkd22@gmail.com>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If open() succeeds but fstat() fails, the file descriptor is not
closed, causing a resource leak. This patch adds a close(fd) call
in the failure path after fstat() to ensure proper resource cleanup.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..103bf7f3e9 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -31,6 +31,7 @@ int cmd__delta(int argc, const char **argv)
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[2]);
+		close(fd);
 		return 1;
 	}
 	from_size = st.st_size;
-- 
2.34.1

