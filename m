Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636423AE62
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065652; cv=none; b=czmg1cURiCZzPSdHuEOoS+j1WGBh3/BG5gh673WErdXWUAYXoLKZ/vY8LMnWZu/RsAkCr/ahRfrnHX1Ng0qzh0kD8EkA2oS1truht3R3JkEo+Z5a8AxGj3qCMzNqC5LnNatIGI0cRC5mwPm3uK2cGMA3Ry2PHUQ7NSwo17JyZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065652; c=relaxed/simple;
	bh=JQgRoFMlV8NBf5Vaen1XUMPigYyWdXXVL1E9mgC5uBU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SSyC29foHDO0s3CbhoxnNvV8QKZIpQ9FgyOgjD4hcdtd4zWICOKBkENI1OcbzuYY/OFElCFcK2H7PR8s/q7Zpvwr6fC8+Q1mTpGlZDfKivtaACkGafDGgmeEXFxTCnoHPP2eq4wKUJrbItEglB48ulDkuDgGUeYWOzUASYxeqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEFCoXAv; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEFCoXAv"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1273349c56bso331397c88.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065650; x=1772670450; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS1FLDvdtnW+ZbQt+E0ojudYwLzdg0U+4RO9oATf1+c=;
        b=cEFCoXAvySjiWxYcPOcXSVfBA503EbtBHEYkQYkDwsinoNtX//JAkypO+dTPlCcCRw
         hRTqZdUMpdiWyY7VmFBhQLQYTcFxngzGW3jE0t+yqZcMNLN5s4UoK6JuRnQo9twPm9fu
         mnvVpBCKftL1oVHg9+SDC2WhUJ+iOOE3u7KFViCsJ/e48c4J8/Y/nPuTc+f27fMoPxov
         ney/Vh+7OmKg+GGxGfd7OdyadaGNAVoqMe+zvAMavRDe1u4NgPl1qOUSTsxonHeK8IC/
         /N9vCAYnK/vV+/4768ov4pqqmO5fvfQORVXIklwcBY+WmADeJztoT1gvk3L4PnMo0WCE
         BhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065650; x=1772670450;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mS1FLDvdtnW+ZbQt+E0ojudYwLzdg0U+4RO9oATf1+c=;
        b=LsU50tNrBF+B/D8FJTGApd1GgcBdQb2r1gHK1+aTWYz46LflxHxPiYtWyPg5BEPFWJ
         SmckD6RION1p8CertA5QaS0ikOlbDK0R1fEwXKZ5XH4/69HBRyDMYa6EaY+QuFpavuOI
         PfFVQa4MTgRqBj/IO2sR2aQgb93KY+WO2hEDiHiaRPAzRD3rXidi0lxzOSnkYTC7sf4Q
         mWFr7p95z8HprEtV85l2DOC/Oe1ZoaMwVNx7/i5DLOB/97LnHuZVbt0hVQyaA05fqyMa
         qEm/6ZFgKvxUoc3cQQitCuhBIipJhhOSRQkiCBcb4mpP7QO+ijM9NnAq5F0qherr2au6
         zP0Q==
X-Gm-Message-State: AOJu0YwDCkqz1RZS97DqGHLUkW1/oLEyy8BaVCCi9ArtSQv6pt6Ib8Cp
	3Cuba8egCr2YddnnSJxMk7Cai71OKDSELwhoV4LEija0j9dTfdjO5XG6od2ZCcu+
X-Gm-Gg: ATEYQzwrN2G142pm/3opUKt1oMT5yGSUJh7gEqIkq1cW56FUoXawSgbYhKsF3KD8zwF
	5vterB2yN6igyEUUE80gpGHu+eDlavt+mXbXQQX76WYdgsUmq8/GXZr3Eee3aelfZRoSuN57ns6
	aKO2VC5dIPg/lRNHJEqvPzXkWm3b9/7pZX22R3GwQOSRM3eCaFE0IZwQlIFGw47sFLwdXJFgBOC
	0R+uZvU0uH6tGN/398+Ck08B/LJZdEkU5+btCyGMi6NnOWnIlOYOyc+B5oTqp+Rf46654Te8HYu
	JsqSMbZP25s6x8algH45t3BlLqpIWwmAqTH4/SLXKM0/qXhqMr3oY1eswAH35eJak/ztp5BO1LP
	ajNSZVSwfDbLCCdW0Pk2nMAbokM6Seo4DHbZy02qsEzCs5bD7bIgS7M5sZkTdMIZyWMUtQXoKg5
	qDewcItXNa7z87laICrp0dWeIEDg==
X-Received: by 2002:a05:7022:62a2:b0:119:e569:f615 with SMTP id a92af1059eb24-1278695822amr1197544c88.14.1772065649923;
        Wed, 25 Feb 2026 16:27:29 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f68de3sm476226eec.29.2026.02.25.16.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:29 -0800 (PST)
Message-Id: <d0bd3e32ca32b4150054ea91aa774a5b2db427e5.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:15 +0000
Subject: [PATCH v7 02/10] fsmonitor: fix hashmap memory leak in
 fsmonitor_run_daemon
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `state.cookies` hashmap is initialized during daemon startup but
never freed during cleanup in the `done:` label of
fsmonitor_run_daemon().  Add a hashmap_clear() call to prevent this
memory leak.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index bc4571938c..4d52622e24 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1404,6 +1404,7 @@ static int fsmonitor_run_daemon(void)
 done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
+	hashmap_clear(&state.cookies);
 	fsm_listen__dtor(&state);
 	fsm_health__dtor(&state);
 
-- 
gitgitgadget

