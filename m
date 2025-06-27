Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4B17D346
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751066068; cv=none; b=OOuYNHkJsX56APOK7UeohrOywrDbQhsMilqu38KV5WREtpapIoQtimIgjv9vKhtFNjmR6anWnHx5GV0c0pl8skGboe00NKo2xg1uPfVcCIJYsTXJh8P9s8ZmAv3x3HVBMd8ZmQEmAgAn1FumhWfA52HVJOpl5GJ3ZzsD6XVFllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751066068; c=relaxed/simple;
	bh=N/D/A8YgMkmy6qAcyL/SXivRXLqFCuiJFpKIAWoLIIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mu9Csl86jjd/h9o+jyEg0Nmt5Fzo1IzbAPUKvNmytF/vWg99iVGmJxZnsNQfRbnNaPsOpGrQVJ5xtVqrz05wP38za3ShSATw+3VZmhnAsKqXGElXMaKT3U44hvEL2TsOIBRuW9r821ZBvIElADDN7xLw7RY8efOirfrLQ5esC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm0cLeoL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm0cLeoL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so23460905ad.2
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751066066; x=1751670866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5e0ZAjUsqxklMx7r7gRyjA2jpY+rrORETlsW3MSaRc=;
        b=Rm0cLeoL8LIJObe8qjl7bZkvDyj23OK9msKB9ndBlWTxJOaILSR0NOQ+GWSjXcbGDN
         uX4in7MCCsaAMNCE6d981Ijiim9mkAvF79CKYk8hhEwvVFdpUq/6QZDHof14Y4FRzu7D
         76MdPmUwJODWtNSwyqzzTRHwXl9Z5irIl2psczz8SKWu4RgEUvhoKgVNEAXBHZGBDRi/
         6r4XgvSzkF/xK0COmOodfwiPfja2j5M2uc1WM9tOg/myqfJbdBnUpcFqJQnmQ1Xiii7v
         JDMGniSziFEyqns1yIzF2j+pI2wh//88fn1EqwFFr31gXdccbwMkkPHnnZPjMB0oCsy6
         QZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751066066; x=1751670866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5e0ZAjUsqxklMx7r7gRyjA2jpY+rrORETlsW3MSaRc=;
        b=KFDDuKVOcHxdNAbnmxLE+Smknsl3ZfyI4/om7/pJtx7uLSmjnIR0eXk/5cw44S5OgM
         dalcTQ86s82XX6RLMHqTpTj5IN4f91STeT5SvR8G0Vp/366y+K+VcfEOQceOP7IWxBhr
         +EW27IYYZnSSWz4uZwrmanbDYzNc5Lx/uICgLESKXwpKsSeFat+PrBNmgzofBJ0iZw6i
         r/qRkgX1i1+N1SnKpMWdPARcgW1iCfgBm2FehfPJRbKv1OzIZF0559A4LrS2y2gF7p+J
         gwbuGkCc+OI7QDIS2c2bUQQEr8ZaxvVjt69sKMLaT8B9El6EapTj2RoYBdQMFpjquWAY
         JPBg==
X-Gm-Message-State: AOJu0Yyza3dZacxUXHk6xFRrcAP8n/MhLlymzzx0nWpMKuGs7Jg4Rvyl
	npMoCXcNkPeD9fcVUqpPoj+b1T9DaoOesaTr4SGInM9b7Gn/FlNudXxjICzpYQ==
X-Gm-Gg: ASbGncuFVBagYBbe2YNXMnv7quq94wB+kz0m2K/g9Hu0AJtvrH/jXrB4aNEAZ0EesaL
	n0mRKPfVFAOasx+85btbYN5ep03wRxCD4TcOBsGppTU9Ty4ObEuKh2LZVPNcwa7/1IVj3kBVxnv
	jNeiO+d3KtsoZe1AvYHGGBegJt45udVON8FpJRnuM/0AlLUo5k24+Bov4DmwvVRg9yWM/exLt1T
	7TGRT/WGzQ1b4gH5zyyE/++YShLht/RMLLHopulo97slm1lbolueaWn5v+TzTyPreRUtpYQ3yNq
	LymXWrwbw+lcYzvkinlYcOOcx6V4GSHXtbTmzzDumNMERZHqbwz/n2SH6y8j5p2/FxbtHwEizuE
	LLSXtjnxNmkvyw7AK
X-Google-Smtp-Source: AGHT+IHtHFIdefcpy1zo0E/HNy8WQo3HOnD/mWS/+2DTkkfvmS2xPOt8Z5wNRRrwCAMsrcNYE5ZP0A==
X-Received: by 2002:a17:903:1aed:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-23ac4893e96mr87972915ad.40.1751066066382;
        Fri, 27 Jun 2025 16:14:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:fdae:9b06:496e:5a9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b95csm25662225ad.139.2025.06.27.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:14:25 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v3] daemon: correctly handle soft accept() errors in service_loop
Date: Fri, 27 Jun 2025 16:14:04 -0700
Message-ID: <20250627231404.27100-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.132.g195eec4876.dirty
In-Reply-To: <20250626172159.87204-1-carenas@gmail.com>
References: <20250626172159.87204-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
2005-07-23), the original error checking was included in an inner loop
unchanged, where its effect was different.

Instead of retrying, after a EINTR during accept() in the listening
socket, it will advance to the next one and try with that instead,
leaving the client waiting for another round.

Make sure to retry with the same listener socket that failed originally.

To avoid an unlikely busy loop, fallback to the old behaviour after a
couple of attempts.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd57..9ac9efa17c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1153,11 +1153,19 @@ static int service_loop(struct socketlist *socklist)
 #endif
 				} ss;
 				socklen_t sslen = sizeof(ss);
-				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
+				int incoming;
+				int retry = 3;
+
+			redo:
+				incoming = accept(pfd[i].fd, &ss.sa, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
-					case EAGAIN:
 					case EINTR:
+						if (--retry)
+							goto redo;
+
+						/* fallthrough */
+					case EAGAIN:
 					case ECONNABORTED:
 						continue;
 					default:
-- 
2.50.0.132.g195eec4876.dirty

