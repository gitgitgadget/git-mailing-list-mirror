Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63426E6FA
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629593; cv=none; b=aAVF0U5DGP3q80xHN+Qa0pECzvU6hFrl4y09Rc/B9jCT7zKswVQ/bEr+4uiwU5FUaMZGsWrVJ2fvxaBK7SI2HyenJqhX00/Iuu8UEHq/uqOXOa5V9bOCm95IkMcxHh0btPZZF/iaa0YUYBztOBxZio1dHE5GAAgU14Np4GJs8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629593; c=relaxed/simple;
	bh=7zbLgTANy+79X0kW047Gal8gSMAcu6o+zZKNOTts0RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZuhEGKrzxcmCsb8H78akPxvez63XWVpHhQUH8m7U4lkKrLwURf6lbx1p1dKWx1q065KU9oJd2tPY1jB46VfVVlDIKQ13CE7WBH1+IXspc7ZnF0AyU8GaOFjCDP4OkGyNLQonbo3AdFwAP5JiPX75FgJ+utdJWAmjriqIIwY6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7g2PSZ6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7g2PSZ6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823c56765fdso3512925b3a.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 05:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772629590; x=1773234390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBEp70jCT53PxwJBSxH0Jh4XGBrt9i519bBlbX8ofm8=;
        b=a7g2PSZ66jdYaPiZgFqXvCfZnwqAyYEu0SFA2f6BTGTA4Bftvjp9kUOagLZr42a8YV
         4wUXvDlcQRB1VyQ8p0hNcjUp4E4/kAgziOTyAP8YBc8IqVlPzTMbc9SqCbCUWE5E8Qjb
         qYHDNuc26rWyirwQTAH+tb5IHXTFbTXB59o6CuK0nAtP0kOO65hIeWV81kapyn90bDTM
         sXpi7u6E2Dk7lA3+99Vhh7G83SMLuiEz5IT4dHrv9nRwTNr3H2Xn8qQdqHFHtZM0RJvy
         WQ4PgoOHi0nKw36gF6VMNCnNDR3e55czbDzTY9PdqqTnhTqFGBiq0PoDiGIZcDrBZx9Q
         yZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772629590; x=1773234390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBEp70jCT53PxwJBSxH0Jh4XGBrt9i519bBlbX8ofm8=;
        b=F9dDHEVTIKR6KuJcg6qaw9CfClPHKbCjI31CkI469KeqJmXdQGb7C0pEpbuMpZ8mul
         JpojQ0q58E9znpX1g7ZTshrvt+XwtsyHf8ADJueaOGq/fteBVaWkOSoBkKGT/dhd67bC
         wzTZk2yTn3L1cS98OzsxmVab6LTohofwF4Q6fenfq8Hhg3SIZ4oxQQevhFjKUsijGn3T
         9gm/zpd3QZjgzwnXOGy2J2ntSx5Qp9rTMrMeKoh94dUHEdXFI9DYZ1kodyokuItaEDN2
         0biKnE6rsH9zD9xvVaOiNvJQlUd4THCaxI8etmZCTW/t8nGEFfqDcU0Ba7hPaihpYkvq
         0bPw==
X-Gm-Message-State: AOJu0YxQAZ+c5NrfaCvJwRe2I1SlCS+t7XU0hbaHEou/eC4QmR6Fnnnx
	LLnpyVHIVpv+DTiyZ8UTcpqJg6voIUe7wMlcG6/MPpzvSATWwse5WvggWiIfSnuT
X-Gm-Gg: ATEYQzzptYsNTd8WnwafGPJ8COhlhOueYAoMi1IGuuIxy8eyQpHylmRkreTaXw48z8Q
	BOj2UNn/qqj1mjlLB9HxrDrVxRnp8fIDbHzR6IzH3vWNKWwzDyDSpPnEdgXjjz8I71Sp8DqBMTz
	9TJwKpsl+4Ob+wYSy5dq8CP4GPm/GdGDMKFKMkylLjjVoO1TPFS4uYR2j9TbKK/CYVeOAleCAgO
	PgnJt4cAOO1fr55T1fNJKgS5eC123RacpiW7CqXbwFSKyxTxOrBOZ9GMV4OGi7VffvVUQJkBwJX
	NS4L1aaGpd6lNbW9Hjyu7UqI7lpMHx4kGIWPCX/E/nbO69GQko9HESq8x+47PZnGL8gETXiGVbA
	WPhioIZz7rRdElUTt0DJGGHyAbsHuWgw3BPrMQGNsi91DluQiQb0pC2WAAXsK0iUfHiIvu/kHfi
	6TOzm3E16ghAIgUc/TXTQS+9uDSMw9IP+fInIvyNCNtkMWfB5grSoyW7bYG44Pe4E5XcT3dckJe
	dG6Tt36XhF8WeRmG8lHljCJlBTvHpg2tqPpfiiExrw=
X-Received: by 2002:a05:6300:8948:b0:38d:f745:4d5f with SMTP id adf61e73a8af0-3982df04bcdmr1856067637.24.1772629589617;
        Wed, 04 Mar 2026 05:06:29 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa3756dbsm16473717a12.0.2026.03.04.05.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:06:29 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v2 3/3] path: remove redundant function calls
Date: Wed,  4 Mar 2026 18:35:02 +0530
Message-ID: <20260304130502.8475-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
 <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
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

