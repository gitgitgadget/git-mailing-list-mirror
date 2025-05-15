Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167C29A322
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313149; cv=none; b=OxLz6GM0HcNrjkbl+zEooZvkK1QDGSTryKUFNG4bXwnoAyMDozgWwxZnGMsHT9pwyBUedfJ2LcdncErpvVvDhJ2B963YfmhmSYbXqBK+XKB4VJHUwZXMNF+dd+0D+K9v/xJvcncdQljQSKT2P8C3/VeHm+gbgtsbNae61ALQU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313149; c=relaxed/simple;
	bh=zyVcZbZM4l+wZ8v1/Lnb4dadGm4azN/rVgFs5qnxsuA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ha9bHQt3w9GWlu8i132rzfbruGAWV4pqBLi5/83AZwEj1tPrT6JnoTNG6YYC9eRFYikJCR1MpPU8mZEzFmhhFJ28aXh8gfojbV9r5QAvablnYm5bcvL299NVVf3A/MwDwwSHVMmqsS8Si9tYPUEp4U+uXr81jfDBKGoDDpUSUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S55sXO2a; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S55sXO2a"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b933f214so562318f8f.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313145; x=1747917945; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTqXNgD3/aoE8eUBF2d2FJ26+qiB5kfzQ7IvMQIHWWg=;
        b=S55sXO2axW+I+FfpTCt2984TwEtktTHIjV6c1T0ikj6BO0khQtorNQ9kaXyss8lhuY
         Qv4p/veAOi9dqseclm+vdGHYby0IRiloNwiJGNDIuwzlMS0JuS+hGPf0X0kXign5LqAH
         F8bGFXegXjm4GFwKtP42i3vx7ULF2UwBu4Y5EsrIGC3aDgzbvw5XCD0C3GLLRq3Ph1hP
         mFvqL3tTe1NtBAOCzlc/FWhZucDCSTRbFxRTLtMyiOjNWIm9NkzF1fux06gtPx6TXEF5
         gs9l3Uhua48vlGXJ6chXs5vsjHB7yk7Bt3MA+kZWGLH3XhL3ACANN/szciapoe2bcnP9
         Y2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313145; x=1747917945;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTqXNgD3/aoE8eUBF2d2FJ26+qiB5kfzQ7IvMQIHWWg=;
        b=iu1ersiXxsGUjeovjM3YH7t7zBu1ptlClaMVSIQU6p/5z5RaJeikF2ye4CIjAdijU6
         zAt3Qibg8SB6KsYi9UVj7Ds117OWp7VhFjWSV4dqLUPHXY2h3RBbJuXqrKb5fS5DjwPv
         nPCZV4shD4B/Ivu1oIOjXcAQaTbquh/NHWb30rv21xqJFC//SUBm8sxdnhJ2qhqGhnHv
         GD6LWdXKgb+dT9HsmfU5VNSSgX1ajgC3idy22OK44eXdyulesnYEI+OSWjH/k2AUKO1k
         cqZcXJWAGMNOfv3nNzovnZV3q9jV5Pmd7GB+/YoAxTVsCwJzJbAp/riHGm2RvZZgMJdD
         JkGw==
X-Gm-Message-State: AOJu0Yw1ZlxiR0pYvIlDaV3wTdOJXOiErRAuIAXvlUi4CGohNX3CBl2C
	NHUoqRw1Oo20IEedfvtwjpY5sxRWsmj6ge9hE0KJ7ABsXrZ7avvtMIVMMA==
X-Gm-Gg: ASbGncu+87RfBcU3D8E/fRaMWLqKgeGAEHGNJ+/oY6Ozr8tQgWVkL24fIYHN/McqPBy
	vW/u+5SrOhRCpARNR1kgx7c9oRxAuHhU2vZWgjTvq8EIfMu/Wa7sAx2Zvk0IcmC/jfM7eUVLxmr
	NupqPK5UjMYvaBTaTtPesrIiuhdt52yVDMwztG6PSrjsLpJ2ZIYGX/QgcSpJeSe0j1rEY9QDjAk
	DVhWsWAiPGiobsOYD2HAt0O2pkJC+aTG8Ty9x6wlsdkEcHPQqIO1ggQaYQB7SGBFMZ/NmJdIN2f
	kp5r9IwRRRABHTup5U1TgCOX7Gb5Z2xy8pDxmE/M8fIbVWZ+ToxlDa8UtbhRexg=
X-Google-Smtp-Source: AGHT+IFZPvZG/kpeWA1LdW2AVOGzeet51tdNlfaMGx6cimKtAnUEzoPz8ddRPcaXGkZFZuW2vbYb3A==
X-Received: by 2002:a05:6000:40e0:b0:3a0:b635:ea40 with SMTP id ffacd0b85a97d-3a349951128mr5426570f8f.55.1747313145228;
        Thu, 15 May 2025 05:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a355e03404sm1417955f8f.40.2025.05.15.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:44 -0700 (PDT)
Message-Id: <dcc04afb6cb0f0383c95d7fc35d492f0e1d256a9.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:29 +0000
Subject: [PATCH 04/14] unparse_commit(): defensive programming
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

CodeQL points out that `lookup_commit()` can return NULL values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 6efdb03997d9..1cbc798e32ba 100644
--- a/commit.c
+++ b/commit.c
@@ -187,7 +187,7 @@ void unparse_commit(struct repository *r, const struct object_id *oid)
 {
 	struct commit *c = lookup_commit(r, oid);
 
-	if (!c->object.parsed)
+	if (!c || !c->object.parsed)
 		return;
 	free_commit_list(c->parents);
 	c->parents = NULL;
-- 
gitgitgadget

