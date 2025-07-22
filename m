Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B7281341
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206081; cv=none; b=ccKoGrGJg9mD97Wug1tMkaALktWOR73McfNpSwL+ISBZE0Xm0GJqM1F2N6S3sUtTVwpRiH+dyYFWbo7921OCI0MV8dngSGxgtRLkdp4PrPS/evPMTw43j5RfxtJzGDK9Iepk6HCRcw0SniJlvys5t4GxFnwy3r5cO+MnXuAWdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206081; c=relaxed/simple;
	bh=sk0U82/3FavnFIrHJyV/o9nX3WL1xxy2dUr+aRpZzag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5ijcId08focvJC1KCHiLLZAbBoxPx3f5UjDZWzmqnoTB2MDOuFRp7RJa1en/gnfYP41vW7sDLplqOh0TDfqgSO6hM4xj+EEuCPeCTvlyVR6JrHeEnO4RpDGtgKFoPGQadSn+bb/QeMTsywyzmpZgK5ooTUz9N2aqqKSc1uQ4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY8DC1FJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY8DC1FJ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso6126202a12.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753206078; x=1753810878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZfdG28L4t2BMprclNeK4kINg4VjJmW7A5DUE2OqEws=;
        b=PY8DC1FJsrxkxZU2nWVrtixqjbJNDe9k11scNIU6QwI7FaDFVY5fr9PX1T2bLZDLN6
         MVaoxJDtA+ss9qs/j9uxhhkX9lh6D9FO66/CCgDCMs5l5hwuWJrcjGTlT4khVf8M9A+a
         ApuGKg6+aYpJrb35sCzhjCI3178Ac07FgirZdpAxxb0zwJW9jNXWA2DzxYkHNy1W0vlI
         B1tAoZpyolBOT3tZcXcZ9YpZkw99zNGbU4GQd5Xq7UT+XxWmsrrekmyc13MQa2q/mxAj
         sK3eyvGz2tH3KLQgCbKOm5cEbYZrRWG5FV4MARgs1PKj6DA7mYOEjh3lazgiDpS6autP
         yg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206078; x=1753810878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZfdG28L4t2BMprclNeK4kINg4VjJmW7A5DUE2OqEws=;
        b=QpGbAZ/bVTP1UgMNQMIcZIMYFN2NsgFzRB03ICVxONd8+PEwdRFLed0/y12vvqa99x
         pG2+zvdgRXqLD4wOahyxG+MUo6QFCxDOvWiEaXcLm/WjEpetYGDAl0g9Px7et+elIRod
         0eR3JwItkPMt+weZ6c8F7fJw1Xc9Q+OgBfz+F7tA+3pGZ8KeTigkNNBk2dyhRelDxGKE
         u86qfgwpNLPeA6zBRZ0hmHbaFrETCx54nREWuIf6DGXBq8h44djvcBBvbXs+nXOSSDAl
         6Y80H1IIe9lvwi4Y2NkGEXxZbd3qh9BHp/kiKcsjqwzZblH67GIyBJ56ifsQCIHqpWTH
         /42A==
X-Gm-Message-State: AOJu0YwOYLvI4cml3hibX8H+Xd+T4QRj6ykm3aoo1eKT8v/A6dKevy13
	ntPNP2bwgudPi6vtMXUrWPEJ0QQQvbLV8RsWtu9qKJ1I6A9jrcdL7s21fCqdiA==
X-Gm-Gg: ASbGncsbPdr+nyg+OK3BvYABJVHy8dtXIZBB0qd6rVrtSaXY7WrjyfxCTdfPHwgCHmh
	3jA2KU02SMkHnGY7/cMEKG4tvPyuJWdtHiu9B+HB5H4QzSAqgZ1sVOOWDTv6IW3KupBXWWjwEEK
	E0naeIFuQSkr9e04+2OOze65zfyz9aLjH2gBanXojLwz7V+K+Z5TB9IWKDEeKuw0+uDGxSWyj7z
	sP4nPrmdMe319VlaY3a84kePPb5BDR9VP1mtp4yECaJ57Xe40U6ZEmGRvrlEFM354weeHMHw7Eh
	Ifr6h5EKzGr91Z8BkQ1vEuHRy6veNjPzzOaI3GwtPCZFQuAbHSMMSCFsr4HaAXK7nHI7a+MbT0y
	JAIAYuZTmozHchCJU8qxVNyXXtLjBZSQMug==
X-Google-Smtp-Source: AGHT+IFX3rPvd+otigDwqJotsCOy/4JHYeSSitEzktYSkMWHFTqEclBqYqbDVX9pOJS8elhI/+Rlxg==
X-Received: by 2002:a17:90b:4c49:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-31e507b3b85mr195462a91.21.1753206077801;
        Tue, 22 Jul 2025 10:41:17 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e40f31bedsm932293a91.2.2025.07.22.10.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:41:17 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v3 1/2] t/helper/test-truncate: close file descriptor after truncation
Date: Tue, 22 Jul 2025 17:41:01 +0000
Message-Id: <20250722174102.1876197-2-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722174102.1876197-1-lhywkd22@gmail.com>
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a resource leak where the file descriptor was not closed after
truncating a file in t/helper/test-truncate.c.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-truncate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/helper/test-truncate.c b/t/helper/test-truncate.c
index 3931deaec7..104bc36cc0 100644
--- a/t/helper/test-truncate.c
+++ b/t/helper/test-truncate.c
@@ -21,5 +21,8 @@ int cmd__truncate(int argc, const char **argv)
 
 	if (ftruncate(fd, (off_t) sz) < 0)
 		die_errno("failed to truncate file");
+	
+	close(fd);
+
 	return 0;
 }
-- 
2.34.1

