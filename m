Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116351CBEB9
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573170; cv=none; b=A0gJTd72jm3etoQX2VN/fYGl23YWRBJlmrpPWkLovJB6SF4gkISTY4pS60mn1ZDyCL/PP9E0xLi5tU2t4YdypdbzfqV+FZV8OgmVigGdUdBJUYrP8FidUmk/DxnVVrTIMJBUjRG60ipwdowiRr8ctXN8JeNxO81OyxzYrCqqM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573170; c=relaxed/simple;
	bh=OyMpQBdIkpB7cizZaGJX5pyy2k7Pkkvy/AYRCnLyhe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmEDTtGMyLeSzook9UgGEgd65O6LKh2N7VOWgJ4fc9XjHo/uw7llUhq1wFIdGZXCKrkMd03dzsGE6X+0xdLnfGFNrMZzVYcgesabDNdD781jfeGW7Vco3a1gGGRQXlQy7hQg5ofJ5VaGx+uGjeOn1MC2gjVTfXvv7Yt6x8ZsMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht75aNI6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht75aNI6"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2facf48157dso11685191fa.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573167; x=1729177967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFZNtfK1Kxww29o8Mdax/kDYKkmwbBA/izCZ39pMowg=;
        b=Ht75aNI6OCwclIs7/jShYgcWbXXTo3uCFQUq53BE+hV6ZKrnOV0HCAhgXvl5SCAStC
         sNvlQ2jhbH4Zk+wZs/jpSU+ODpAY1ls/gFqMSYmga/wxF0qGHuivA64VX6vZgXsTg8E0
         +Y9VlUcDGFTf3QIVBfchWjx9g4NfJ1RX4pyd+un++983PTQM8I1KYxNmS55aLKfXnIKK
         l1sJGnBSkin3qWZIkgyma22CGhigkTFqRG/Y2dDqCTZCaucjhJS/JZ7zocgzB5sJbBp4
         lh0bmXdUunLiwQc0o34JKYA0itWioQm3lbVrmq35D7eyW7r6hEg68NvExAfe5RfoG5Nr
         75/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573167; x=1729177967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFZNtfK1Kxww29o8Mdax/kDYKkmwbBA/izCZ39pMowg=;
        b=ZT4XEC4HTSgHlWnO4NtCXmvZzTwu5zTEVbws1ysG4KUfAyVekXFhtYuapatp1maLHc
         v/NK+WcRw1AgcUZGTat/dnzTnQPtdmiNLh2YndIrExfFVx99+fcBE5dzL+sGmA8Dz9rm
         FyPUTYa1P5reh/8NJVET8OJN8rJMTCkBuc55LAlLgQKk9WbUWecps2hdzEZ7dOgDBWWK
         67Bh0Sbs661ffnioLFQcR3h1wAJF9KxbUYqgt0YrfqDkCKdGmiuxI6P0Rkr9px9bhPAw
         fsKAvUZZ41P2talpRhsCeJccFJddEPlrsTzcog8MzIfJ7JKTedktHzrwbBL85Kuuvuzg
         SbOw==
X-Gm-Message-State: AOJu0YxbXPb5KXQ7eP22vOs9U3MRkPJ8YD49pV9tIuHMljrPFoOqMdKo
	WfRjD2+8iLVBrDJcQyXM/4QSZryynsY3cfld4Sb1ZPP2LCxv1Hklj2fymQiapn4=
X-Google-Smtp-Source: AGHT+IHmaNfGXM6WEMG8cdu6g95cAnctMaURhTLYwTQ4+37nb9/8ddqponHoHUTEHN9n0WOF5eCsvw==
X-Received: by 2002:a05:6512:3b21:b0:52f:d15f:d46b with SMTP id 2adb3069b0e04-539c48c35fdmr4176622e87.14.1728573166635;
        Thu, 10 Oct 2024 08:12:46 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:45 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 7/7] t/helper: fix a typo
Date: Thu, 10 Oct 2024 18:11:25 +0300
Message-ID: <20241010151223.311719-8-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments: bellow -> below.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/helper/test-rot13-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index 7e1d9e0ee4..ff407b575c 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -9,7 +9,7 @@
  * ("clean", "smudge", etc).
  *
  * When --always-delay is given all pathnames with the "can-delay" flag
- * that don't appear on the list bellow are delayed with a count of 1
+ * that don't appear on the list below are delayed with a count of 1
  * (see more below).
  *
  * This implementation supports special test cases:
-- 
2.43.0

