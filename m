Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26735B644
	for <git@vger.kernel.org>; Thu,  7 May 2026 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184777; cv=none; b=pFyQf7Ucjz7Rx1lF08nDMIwSbMpiVcIfX31zgBO7RbKGEHAFAz/GMIaI8bTWAAv+4rWq1bHUIGTWwlo/UkZL1llG9FudW+46BgQ1osIf/Cs6+gPCgyWNtWGuqFQAubLI4i1GVKQG5uNfUdJeFBxZq3MJW6JJbqqMqOB8R9/dtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184777; c=relaxed/simple;
	bh=sA8Yh/crtgDkQ8blPuCm0Cr/MosUsGnBd2pVQvzICQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIxpBeAs/H3tJPk8dNqHszuJSsEHRsS/Y1H2tdkQiKo20SUJ2HCAJYjMndWwjkT91TwKq3uHckBrhIuN2WHymKPrG+zALkKsi85UUuJ7emxdQfdihAjx/24jY/3u9XZwj4Ndr9pQ4KcvYhTV2g3+l53lqMahMNu1Cj85pvISgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLap9Yci; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLap9Yci"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a01c80c34so10707961fa.0
        for <git@vger.kernel.org>; Thu, 07 May 2026 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778184774; x=1778789574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA8Yh/crtgDkQ8blPuCm0Cr/MosUsGnBd2pVQvzICQA=;
        b=jLap9YcinfbwdD/wN0vvPvoH+CCUNVQQDd6On2B8JGJlnRKSklyzzJ1MqLMSq3rl2q
         Mq/9dD9g6bwDRi9qSc+KW38Ja0MFUzfLuUvNtnk33I0/FAFDMqw+tMy7MbUVDBHo2D+T
         /zgFTWS0n+HAj0m102eSOgwFoIrt8o5mMWq1zjGvu9gS+Xr9ccoxiu+OJCgOSMb2sFq1
         T4kMU/WIG3fz8wvkTPPzrkSxQQWzMDKxWNcDtObDDIa0/OIpIWDFmDyMLqk43OUgtmqc
         briuGTGBezu+ziKcSbJ1CTSuapZMTAwwHW/jRGNTmLU0wOFaBCBKePkXgVyOW9vJDTWs
         7ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184774; x=1778789574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sA8Yh/crtgDkQ8blPuCm0Cr/MosUsGnBd2pVQvzICQA=;
        b=OvM6GnW2KqAV+8Ixp0Ko/ajxlAI8PBn43+FZkDNY7e188rKTF2I2scN8BDSUknpzxJ
         +aW4Ra1exdYemzTdELXy87c0N9dVAox3A6KNqG3xL7/CjpOLkwAn2hckLuFgfDzeQv3h
         u7c+d54BYgNq9fP/O4gFki7BURtcWGf2GdwB4ZbnZ2YWBnTdyw7j+LLvU3GzbjpWCf6C
         SW1C/jj4aPHIf1dmu8HeoOUEa7L4+mftXrWGWx/svRcwfHyy2JD8VqrquROf6pNWx7sX
         j4BoH7+ujL20LLXLc+mSDw+Iqg4nK0X4C+VwT+dn/z8+fhhOJnXKt6FWUoZm9LW+vurU
         GxIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MScT9Is9Z0NVZVc5YGNxDqxWN3p0FmN48ZOGTjX5XozZsU/+LKl/7K6qN5eFzIkOzgsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAo+5yF5Y3NC4238vMq4VZzXdszwVjkqksHuzoytw8gMrDnqu7
	FxOzpYqnPfwzjnsNyTNq9eDSycZub5FOZA2c3L6PlWo5OBukrZYyMIN7
X-Gm-Gg: AeBDievZ1n80j2VMZ0qPA5pbpR2UlASJ5AlmgqAOlXbmkD2n/UiVDSzmOZrZqIAfzJI
	++IaVKKSS/yU6xjYhrZSoq7Hm54sO2LoYqCpamveOexRnSU9na5Rn/z7iHhkkKU5uK3HghNtGAU
	ZL72BSfHKxiOUG5uUFEUXEDR4tsjTXScH3vjn5bKGykBfnSMTnuvbl1Te2hb4vkke2lXKqOpNPZ
	vloyUhOkSzpZbnljlncp57DEP8dZUSSvr+lgS0nHUsBITlAx1CGOvj8bQkIAhx+F9D4LiZLZX58
	viPLyYAjRi2sQAgy3iPxCmmewoaCyjJ2fCaeucYMKmXn5L6MCp7hdYu4w36P2MXMKVhWCknf3aU
	LjVBvNCk4f6ws0c8u9R2UtsfqZ3GA6G3u+LLtxfKDxZxk9VRmzBB1YzgMzpnCWSCeOep5JzzE71
	O3FBr2ElSmRn+yAK8sKXXuEUcOyqM4JINxckZy++KfTzTzlyHzabQ8M1aIE1RHty/DFZtctro6f
	mgfGHNDHCqQJLYK
X-Received: by 2002:a05:6512:23a9:b0:5a8:934d:7cb8 with SMTP id 2adb3069b0e04-5a8934d7d7dmr2191891e87.19.1778184774071;
        Thu, 07 May 2026 13:12:54 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a43fb7c2sm189803e87.19.2026.05.07.13.12.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 13:12:53 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	marcnarc@gmail.com,
	ramsay@ramsayjones.plus.com
Subject: [PATCH v6] checkout: extend --track with a "fetch" mode to refresh start-point
Date: Thu,  7 May 2026 22:12:53 +0200
Message-ID: <20260507201253.41428-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.6.g690242d89b
In-Reply-To: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
References: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Is this ready to move to next?


Harald
