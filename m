Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A026ADC
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408832; cv=none; b=pUkEJ0pZWxtgiz5Kby6q/w+h30i4aSPpWk0Qwkh9WNmNxRQDAq3SJY3OTOIxMtZ2eYCmWLX6I0ODhzMvzNRIzPJB83a3ZXkU2NO010FXQodpPYZVc92BSxO0nxMDCGnONjpfs+uWRAjXMKTgBAu75AXYJB4hpwdkbdVf5c1odjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408832; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stqAV7teYp+yRD9r7fL4ChSmctbVJlK+/6ui/HLegGfhOCG4C4fhahLFO0f67XKonS0GaSHtx6iXVG6+cCAj+RxIgZ3UC8lWpbabeFgomp2bysJvv05+J5plKdfs2HqVBAprK9toIeC4pxV3RMzHgrczldM3FEX1RDxd+OHBMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl9kmqYh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl9kmqYh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a288a2c00so255453a91.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773408830; x=1774013630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=Bl9kmqYhVwYuWg9H2MBw8vae2z/J+1OitRzJvb4AysLx6EN758cYMUcOnFlO6W+9yP
         4NsZiakatcLoOZfY08/qQKLLM0se3nAIpXpr3dUcJkIJHQoG7Pd1qqFnx7rLIddkzGGT
         cHjCZPyMytOBRG/SmzrWYUeQhsbNjV3W27NJf/bOfEYnU+99jjkMp9QqjnqprWLY+vP9
         LTulWQr1zSrwkDXKcsQmE7pmprW+b+CXEVK8VA6/eB8csJ4XlBwWLHyi66CHN4I0jW3Q
         livuPqc2O1+ePb3ZyJtVqqPQNM0Jd6x6QQAetuYZMX/H7Vx90Vq1RCdZFwVtEMZBiq2e
         +vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408830; x=1774013630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=O7PxZYQoODKcyxKzQy6vj0e91rDbHobM/W88K7EBYWUc61tTZ8GL4YO98Q4EIC25Xl
         4c4D6yZY+79RhLOQjS2GDB28O3Cn0eYJABZai6z5C5P1I3WbqsTdKcsuxsi8XkvWhaFu
         0lBVb4JE0D3dH2p6gPfWQTppXA3Gca1egPeKCo1c4U3X9cjAkWwr3B+FNX3dG7VCAbvO
         K82AvMxeFBQzfzPIOOvXaPKDfM5L52P7Geza/cg/OSqA8zZukaLngeBkEEUl7VsUeSxY
         eiN3PjYlhzhT10iH1fRsOfTU/FfsJ9Z0l/0Qgf5ZTlHSSNV7XSG/Ac/Md0EKzJPbOcyc
         7/fw==
X-Gm-Message-State: AOJu0YwgBmNGexKw9H32gP5ZbtO1GGRwho4WHajW2zqhK2uVTWtSoVTs
	tDZPBSQJGeNMhVNOGLIPhpO9Hipxmx/BxwU6fFDewc+TZ/5EzEh2j0JPbFiUl2nk
X-Gm-Gg: ATEYQzz5y2pFAeORLjoqTlv2WiVpPKu4V7B4o4aQQNUQEGkogb5aqVi4AfCMNzQOyKE
	n/i85gQkqwRmhvYiPichClfZbbKwhodAZxRXNN830lIX+RcnkEnPT3qtcDk0B0ppGjnRcKgTDmk
	hzXV0rJaBc6QmSmEI67iJ0X8DQSPqtSS+Dg3XVEZzVBFEZV8VQ103SiUfl495APpNw2+nZImFQ8
	GKWuF+ptmuPruxn/fQl8p6iRJYGVP7obu04z8Le2E4v4ZHTN5w8yUBymP7w0ag827blA2qCzUQv
	f1YnbiuJsWC/VF12Swxjz80JbMGfxoNe6z/oh9KTJAWS3A5HxWzyNP9DFWJpFtsrhqUnOzDf2KX
	ULxVp6chxBsRadWeHXl6Y3aWdYeDosHQ+HOEUiz+s42Cu11LYEyLl2WD2xGxoIQrfuLH2X41o63
	k9ghRcPyU3AUsm/3vyP/BDwOQrHONFFIksWipmV6T0
X-Received: by 2002:a17:90b:3c11:b0:359:9082:1d0c with SMTP id 98e67ed59e1d1-35a22098a46mr2877512a91.30.1773408830212;
        Fri, 13 Mar 2026 06:33:50 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb975f1sm2085998a12.32.2026.03.13.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:33:49 -0700 (PDT)
From: aum2357 <aditya2357patel@gmail.com>
X-Google-Original-From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 19:04:12 +0530
Message-ID: <20260313133413.562343-1-ahambrahmasmi2357@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff: use conventional comparison order

Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
to follow the common coding style where variables appear on the
left side of comparisons.
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0ee21692c2..ad0d6047af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -432,7 +432,7 @@ int cmd_add(int argc,
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if ( addremove_explicit >= 0 )
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.53.0

