Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4442AA9
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767523740; cv=none; b=d4OLbYIjOOmMIEY5kQdPigv7fO7XiJ5gLa9k4Rm+MirTDo91C5Q8kJkQUWTNU47SqMbuZCJt8cQHldymSC2CfKgcR/5XrcTfOq1j4KoftTyECGiIapGBgNm1V02wik7zbFOGi1kpDz2nNDRwQh5pjsufJDI+aGMwNeUvyAUoa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767523740; c=relaxed/simple;
	bh=AHThIyFGOQgb8JpPIbkp+RAEaa3wh8Jnlzi3d2o/m5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rI/yPywGUvWSeZHoSsNiLyc5BCXtL+Iyx8bTuuPamkMcPv/CD8RhR+Z+vCGPbRrw4Y0SQ1xWjpIHT0BUHeeO8gZ9Zb0W1V1HnzQocqlza/Vx87fxQUKEV1ASmJCo2Y/3eBlTuxJ3RXrtuOwlKk3riU6GH2ULwcEeiSfYpD2ztEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNqLJDC7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNqLJDC7"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5945510fd7aso10810637e87.0
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767523737; x=1768128537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxtA2w7EbTWF+dBuZIhyMfDrjnrl5Esq08TNztKmGv0=;
        b=lNqLJDC7GXZHwMlNRdnSGBBtNojFXYM7QkIh7aMh+XUdAndExtgPAvFS7kkpUZXJNg
         G5Q28V7rO9b1jb6OJ/FiAcrrMOMJxRf1ty81ida6mZtHK4SXQK+mQXW5xZpugYSD10UI
         WVLXomxn0qcdRkZtsrAOZNz5X+ZV9+3J6n0k5cbh253DRkGKIZD++/lWh4QlwCR7oiaY
         DTcQt4Lqu651myAVbQmdqaYs/edkIq9SdYa8H0hRtk4wAyzs8CkYsl762tFJWlTGrn4u
         Ph9MO1KtiXmvJFhk5Q2BY46herlekiwiyhbZ2SKXABJkFb6wDi7uYeMHx8/ZB3bxYL9D
         eiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767523737; x=1768128537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yxtA2w7EbTWF+dBuZIhyMfDrjnrl5Esq08TNztKmGv0=;
        b=GBj5yFW4v/mZZSVnE+xKW3ZUXxeyPeUmJ2oW7IkMa61P3nXrzH02p6y6Ei1Ztx4Sun
         26o13pNPDoziiz/rRNnLWvvql8UdDdTWFZu4GbW+U13Kl6sX5uhX93rqa/rJoBZtntWx
         McU0jT1ac1bS0bzS+iyPOwBvYwnzswfRnvPXYoW9IGfxqNBoQqPQ35+sdC00nWV+ytRf
         05diw7GSUqKf+mZsWhfoYW3GzkU8mUU8Wv9Su/eK8SCr+p0GuENaqHQcLPHlLHk4roLV
         f4gH1H3EKZR6g2kJbXFUaveJA4Vs+vu0zVzUR7TrJtFK10NowrjsuY6m1xhIzNqrKprJ
         ZYbQ==
X-Gm-Message-State: AOJu0Yw4trSkYYc3wuH98zdSsgD1TwKwrgtXkHYcg7hAEh5gbsdIdHnX
	rzKlMM40O00FcII1r3liuWLtzoCjxParDO4f82DUW/zWy8ZiBXSlsqZM
X-Gm-Gg: AY/fxX68oi7N7tp2ozbWKauZMscGV8iMO0RFWFCJCHV4yDxHYctn0pVehxzD7pmjIN0
	6Fy2T0KuUdkSRcGZvAULNzelwWotMB442Q2o4raOxyHNqezpedbeJgNbRBDn0gfZrn+VK++3Z5u
	cBB0tpC4a7oW4lmQtaL91tPOmeMOImFc2OZG5muQY312cEbNV9HALBNm/GjhuY6XZx+khtg+ikw
	ahs3K4mJTYhDguo4RMqOkZbuMWdD6ytMI2q6P6ViqmO5R3HSvlElFUZdLPTWssxCffCmcL53jeD
	GVrS9thXLr5CdnZ52D/ls9Nv2vIBuS/+oLnpOJmOQhe8vTIt5FNBdw+bdRPU7vLwJFaVPsIu3Nj
	kkAsOqRtQy2F4LR738103SreAy+r/WBXXedcm/BtBqjoFWJ6NNvuLWmWL/RjLPLHjvI+zURAL+v
	k75ZDfLY4ji/xih4R5+mBL/SJ8Lr0ZnNWZFtrtf3p41y52k6qwViN0kx2j4MrPePgtDaKmI3A=
X-Google-Smtp-Source: AGHT+IH7xvKjFtPQ9OxS5igJOGSp0tVFeR/TeZjHXaoXdITiyUZciv5hniZmgpSlgYC0MWT+HSU40w==
X-Received: by 2002:a05:6512:3f09:b0:595:81c1:c55 with SMTP id 2adb3069b0e04-59a17d74426mr17517658e87.8.1767523736504;
        Sun, 04 Jan 2026 02:48:56 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861ffe7sm13448127e87.87.2026.01.04.02.48.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Jan 2026 02:48:56 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com
Subject: Another look?
Date: Sun,  4 Jan 2026 11:48:55 +0100
Message-Id: <20260104104855.31105-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260104102749.30950-1-haraldnordgren@gmail.com>
References: <20260104102749.30950-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, here's what the code block will look like:

```
	} else if (abf == AHEAD_BEHIND_QUICK) {
		strbuf_addf(sb,
			    _("Your branch and '%s' refer to different commits.\n"),
			    branch_name);
		if (advice_enabled(ADVICE_STATUS_HINTS))
			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
				    "git status --ahead-behind");
	} else if (!theirs && !ours) {
		strbuf_addf(sb,
			_("Your branch is up to date with '%s'.\n"),
			branch_name);
```


Harald
