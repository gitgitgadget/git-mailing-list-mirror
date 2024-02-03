Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA371643A
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706962077; cv=none; b=VVYebJC+6i4rsRzfZ8s+XxWnGKwgsvV5xPm6BlJWND7x+sfJvIx0ENkBF07zZjHDilL8a5Kz6gRbnOakLTAiKlSm5t1AnhHSYydCs5Ob+JST7L/yV5wiV20oKgtKyaW0ANaUAbojB5UoaofUcqJ75uGIVkfLPR2y6XgGbJ62gus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706962077; c=relaxed/simple;
	bh=dG3kw5caW1eFHT0jhWYPe/006o27ie9ejTV1gTNZWm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9MoIwth6uRhhtbjd05+OP4nF8HmrCgWYMkLSU/m7xNuMWsudkW3DTZ5Bdw3q8ETeoKQMkoWLsN8uqMa7aq+rt0u+Z4frWPTn1Vnbiw03f/S4RqAuxnvqmInQXOHUityo1ZcSy3jYJo03aEXU/g2Rwu9ZsxewHhrjR9+RvcIRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRFWCO+e; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRFWCO+e"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290ec261a61so1840278a91.0
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706962075; x=1707566875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyyIyrbVnl8vUIalWx02QZ4P+XXi9LZv+BMA70tlB28=;
        b=MRFWCO+eTHBWjgORty99wxGK0CWCrKX5tVu27bOzhXmWU6tb24q+4ExqFmVEdysCmA
         n4ypiFKlDmascnls8m4E7IU2zb4XO1r2OMJX2C1E/AeALpw1xnUX/8JQ0ucuJ/RWJy/F
         w5oEuzYq+7E0d0YUHpTWK4pTEANei/gY0u/wb/+S0sG256OvivWFxSX4iSEefVsA8cgO
         +s0LVWcDDgF+Q7bNlqO3G25khm8vI/4ge8ryexm90rqu/6Bto9WFhiap4p59VOCnzTto
         TJvtbbm6BAVDt7fAbmu+HXSDs8zM6liQKhmrOrbuFrE4BtAH51LSgLjZeNqh6+3dVZ2t
         2U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706962075; x=1707566875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyyIyrbVnl8vUIalWx02QZ4P+XXi9LZv+BMA70tlB28=;
        b=hKP4LhDxDIKgRR4/mOuwZ0qXX1Rnh/+o3V5RMqGTGRshnfiRhNOF0LEUz1QbVnJaoJ
         a8f+8PcN/qjErDPGWe6gm5/Akl/2HIFRD0vF1lVAl/X2yTl2yS7lZGHm/iv3UHadm7s6
         YZOcc27Yyv3Qj/p6XaFYQLNIV+7y1E0Y+OA3C9C98PbEXLVUmaR83DKa4lL6fvPXKr6i
         wBFk8dqb7am2wD1An6ohf0yl9WtS2Lp7QbdjzI7qymM4MrFub/ooy8DV37lyJn1vfKAh
         H6u2pjt8qBn3ksX1YQX3WVId/Pz6uNkUeA2kzUuTSWHoSBduwBNQ5+CnvCX4DtYfJV3N
         8zPw==
X-Gm-Message-State: AOJu0YwWStOJXDER2hVhhcPJBavOfhNBL812lKnBQ9U+RzCEVjFbAMxv
	IoTk8eUsQgutZI7dY7xs/R3t/ccdk5QYRtrXjarnZic9qZSvv0kQsB/LHcpa
X-Google-Smtp-Source: AGHT+IEws2kLIA0HIXa17zRwIVrOrz/GKxerHF+TxQHgt8ilWvHVwQaaA9tY853CazvvbnV/RXLLVg==
X-Received: by 2002:a17:90b:354d:b0:296:4a5e:193d with SMTP id lt13-20020a17090b354d00b002964a5e193dmr3585779pjb.34.1706962074767;
        Sat, 03 Feb 2024 04:07:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJ1wCWU1m+iWOJMdvZuWOvV1Odi3gGpfmPUQi+F+5MPRenxUzBDWkatK6F/9Dva2mIgLqfh45TxqHtfLYlzd3YO/w8gp/+LvnRuE2IR054m5ezekY=
Received: from localhost.localdomain ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id x63-20020a17090a6c4500b00295fb7e7b87sm1876065pjj.27.2024.02.03.04.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 04:07:54 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 1/2] add-patch: remove unnecessary NEEDSWORK comment
Date: Sat,  3 Feb 2024 16:55:48 +0530
Message-ID: <20240203112619.979239-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202150434.11256-1-shyamthakkar001@gmail.com>
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment suggested to compare commit objects instead of string
comparison to 'HEAD' for supporting more ways of saying 'HEAD' (e.g.
'@'). However, this approach would also count a non-checked out branch
pointing to same commit as HEAD, as HEAD. This would cause confusion to
the user.

Junio described it best as[1]:

"Users may consider 'HEAD' and '@' the same and may want them to behave
the same way, but the user, when explicitly naming '$branch', means they
want to "check contents out of that OTHER thing named '$branch', not the
current branch"; it may or may not happen to be pointing at the same
commit as HEAD, but if the user meant to say "check contents out of the
current commit, (partially) reverting the local changes I have", the user
would have said HEAD.  After all, the user may not even be immediately
aware that '$branch' happens to point at the same commit as HEAD."

[1]: https://lore.kernel.org/git/xmqqmssohu69.fsf@gitster.g/

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..68f525b35c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1729,14 +1729,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
-		/*
-		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
-		 * compare the commit objects instead so that other ways of
-		 * saying the same thing (such as "@") are also handled
-		 * appropriately.
-		 *
-		 * This applies to the cases below too.
-		 */
 		if (!revision || !strcmp(revision, "HEAD"))
 			s.mode = &patch_mode_reset_head;
 		else
-- 
2.43.0

