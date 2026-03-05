Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68683A0B34
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715282; cv=none; b=Jjd5c8ielaVsPd2tJz3fNdtGYaDLvcokLEg2PK8zKkd9nCl1u4LR3ljjcN8w214NI3YXCBj494hqcfTeNG08w6eygU4kPAaY+8lI7jL9W5Zf7qPu/PAswg9C2QGTTgYZYTTIEHiZk8MHtccVeiJgVy64tdscE0cqIFB3XGkJbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715282; c=relaxed/simple;
	bh=7zbLgTANy+79X0kW047Gal8gSMAcu6o+zZKNOTts0RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C783MvMIA9urD6m8LIlQBAL5dya5HQGr9S1PAoUvrYi+tkm28tzIN5WV1JAlfuuBdWx8QcVPPd3NqQPZ2giAMci6K1mtzstnARqqCehNkiHAsn6QEN2OHYkm2QkE7ZTOb7ZgR7M7KdStKIzzreYZLO1r+H2gKZGPLcYrgf4zHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD0ooEnw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD0ooEnw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8297310ce0aso1125808b3a.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715281; x=1773320081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBEp70jCT53PxwJBSxH0Jh4XGBrt9i519bBlbX8ofm8=;
        b=fD0ooEnwF0QSEKo7pcF4azRR8FJjCJxnir9PeSfur48Py5vHG6HoHy6qnBf5FrWRQU
         GOCPt/WLac0qHfjrGA8AnULv/aIm+7zJFHkvqDLxz5AycHWCaOMIMq4u7WsC61dC5Yqw
         4ZmVPVageHVOCEu7hKqVL5g38dfrElg9HvInVTqyuzWVqhN2fTpIpzDHYQEMhSqnW7+T
         pmj9KH3oNBRsriLnsHQ2CcPWmL55y+PG8QikMt/i2NY8cC3lqz+EoSYkFU8C11vg6QRR
         mQyrGJnqBpQaWOUQAV8HqGXjT/ma2On6ewcMTObnR7lXpuTrARp9VwaExm9KssQ65G1j
         BQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715281; x=1773320081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBEp70jCT53PxwJBSxH0Jh4XGBrt9i519bBlbX8ofm8=;
        b=MyDFjSArijbHJzXzT64MBSUul6FHqvqaQ/le6RUsrcxMepMWNlkpsTov4IsxlQz/VX
         OgkyskFZE0npQtwfPIjqD0Pj/266KKYUPReqbDMae2JkyJ6sO5PwdssF9KynjjWuxx+O
         hqDnzLT6Gt8PUgcrBdlC6OgIOGZSL/rLDhC+A1L01ZMViuIQusEY5aIRlbn9YsI9Xn8K
         0D21PM2oKeQB4i0NCij5xBMqaPKvm0aGKQZyVZePOdDgpUQ0JkwaJyb3sF4ggSUOd2rH
         rgFhMR7z43vNhF7uA9CzxcI9h8lSYf3+OZNlAOCB0w0PTq7RNeXblNdZ1VspzM/KFk1Z
         ebDg==
X-Gm-Message-State: AOJu0YzZRW0mySnL1Subhf5JU6FZnWe//X2lR53KBjAqCUDGKp3ixuHe
	KRLp/2Z5bKGDMA139c7ZOmwKX+bFhZ+VBal8HQZurOv8LIixQJBHqRDL
X-Gm-Gg: ATEYQzySWqmNQNuVhuRh29vwAK9VGdzS3kn1ujvs+rbm6M74RK9B81VQQFvHxMbvvTT
	BKPjnRzNtqRJcheYEBiu6GSzOYLBM/3YF/16e6rdA/0UYo5pFb/M7J0VwuZB+Q2PUziSWjM1B8n
	fpS8ZSbzkzOJeUmN9o5dQ07FU//DnMpwQO0E8buL7mqsAIvYWhrAjRF1C6nt66bxCTLLlFirp6W
	o6M45OlOSr3PkYtCHAS/9Jvg0hBEoD7KmDuBK+vNWGHDGp1ebmd4TOpuXeZF0pAw2E3G7I6m+2D
	WbhGKLq0EBXxkhy0zJGVMjqWA1cV9m2jsUmQlq3NEgWOk78KZJwnzyV2jQcp28OWn2szGSaWe14
	5kj421F+6a2L9f0YQnU6chJE/R56f73W+T2CtWPbhHatgLe3Li0Ar8++xPoozUDFxPh8VecFR8t
	ooEj4QOPXdHoEHp6/dTNER6VGZftGEGR9M1GRGOgn49csG+myo88xr/MYY+jCd2vTl/TTHNPOkA
	lu7H16O6kaKehCSN3/UDSCNqkhizyyC
X-Received: by 2002:a05:6a20:a103:b0:334:a681:389c with SMTP id adf61e73a8af0-3982ddb93f7mr5874164637.15.1772715281007;
        Thu, 05 Mar 2026 04:54:41 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738b823b76sm2578190a12.9.2026.03.05.04.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:54:40 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v3 3/3] path: remove redundant function calls
Date: Thu,  5 Mar 2026 18:23:32 +0530
Message-ID: <20260305125332.27600-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
 <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

repo_settings_get_shared_repository() is invoked multiple times in
calc_shared_perm(). While the function internally caches the value,
repeated calls still add unnecessary noise.

Store the result in a local variable and reuse it instead. This makes
it explicit that the value is expected to remain constant and avoids
repeated calls in the same scope.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index 56be5e1726..5cd38b2a16 100644
--- a/path.c
+++ b/path.c
@@ -741,18 +741,18 @@ int calc_shared_perm(struct repository *repo,
 		     int mode)
 {
 	int tweak;
-
-	if (repo_settings_get_shared_repository(repo) < 0)
-		tweak = -repo_settings_get_shared_repository(repo);
+	int shared_repo = repo_settings_get_shared_repository(repo);
+	if (shared_repo < 0)
+		tweak = -shared_repo;
 	else
-		tweak = repo_settings_get_shared_repository(repo);
+		tweak = shared_repo;
 
 	if (!(mode & S_IWUSR))
 		tweak &= ~0222;
 	if (mode & S_IXUSR)
 		/* Copy read bits to execute bits */
 		tweak |= (tweak & 0444) >> 2;
-	if (repo_settings_get_shared_repository(repo) < 0)
+	if (shared_repo < 0)
 		mode = (mode & ~0777) | tweak;
 	else
 		mode |= tweak;
-- 
2.53.0

