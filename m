Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DED375F67
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775769629; cv=none; b=loLEx2vGxnLZ1m3ESymvrlYkoamxbiFXcplq6fcomZpktsWcMjqzUQeDe7WZPgVu++3UWTfQxsQNKnGa9p9aKVN0aw9ZDKW0YHZHPBjAX/jbdwrLv5EpnwK5bF4gLCZiMjYxaFs6Ywk6rnNJiwZhYhqv3pHPwrXvWq0lzbphFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775769629; c=relaxed/simple;
	bh=Jk6Lhn4IThNmvWiFr1IWWhbbpxkBy58IQwInUDK2t+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX3355EoB9Lp2GjMZ5c+LnjyNgexm4p3x+Yuo+DL60dvvGN5Pex5yxtb93qB1y/llaT/f55MebQ4WVdp43XVJ4toKZftBiUXXssPPqq90xzYrk3EialWsbfzMJ2A42n/0Q94eAVqL5yeYgFA+HCeTR373L+//vfz/syeCyEXlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdmBaGCO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdmBaGCO"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a10d130b37so1074500e87.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775769626; x=1776374426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzC2dRlKbusSbHF67T8hDl5cIKpSVfru0i3GvraU4xc=;
        b=XdmBaGCO3RHav8HmH9flw630K1+WcpOfGuxtnmOjB64yETNNf93XiDkDrTkb5BX7Jo
         Y4MoecWhTPA4D+YEviwjTv0V4/YDNsRbk/KuUQ7fi47s3H/GFf3X6h6Y5hE52sU43TO+
         Wr1Ecb2e0zTjkleHBQNg/AZA9vskc021N70DVDLrMdEUo6rA9WZR2Tr8N33989P0urup
         WVeTBo7GtKzGUxc9RJhZII9pN3Vx5v2pIrosj3/S891lqX1Hq/tTTOMufnwAKUC95gAy
         Qq84ZpyMsZTay7Wa3XnL/hjc/GbkykSJkaWNpoVfNY0j3OglrjV83/p0gR0JjohxFXQQ
         6fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775769626; x=1776374426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzC2dRlKbusSbHF67T8hDl5cIKpSVfru0i3GvraU4xc=;
        b=Jlf8tNGZOx230nmnkzWj4QufyLCN1V5dEq0DT9Fv3lxAEEVDK4p8HBehwLORKyKQ2b
         VCV1JMVPg1suTJSGI2amavi8Na0DwU5ibx5PNkYoLdc+PDPnb9sbW5AKJ/9amympg0BC
         W4sCpB6TFFxhtmojlx8UUXVibNaG5ZVicdldtGmtaqDIHV5LV0aQonChUw7dDHE+H7kS
         WXjQVu+I6AZ6HcQGLoftYWijTIE6nreNFrvjBZjV5hos2VdjYV+ct+aZTyq0y2VxiD88
         L2QK8PcXwLUOfTEY9RhgJSvD+Rg3iDekpwrMFsQnltGsvelPa3056V6JgG3Y2nbORd30
         Y92g==
X-Gm-Message-State: AOJu0Ywn7WbQQWZlDli79rACL1Hf4MaZMMz/+MQT2gbc0XpV7uraHX/j
	0nIFYa8RTld6WNoXQmRYJakCIp4ZL9tr5RguMCB1olCWtDR2SQPX1Wi6
X-Gm-Gg: AeBDiesbVxCnwAW9lcyod6K4UPXi7A26QDqqGqY1m3NbbLCb4pf/FoDAqhwp9mQAxa9
	0LUKvFN5jwbfGklIQk9C2OMHZDX4auoDikTxPpdeeKgC/HhcaTO0W2KiwfQ84LgP7uskRuANJdY
	13qG3JuuokqHVzGUdwf9z9e436BK18qbSMJWBGmG+5EW8MZRkQv/GIr/w3w2vzqhTAGA312Zp4y
	vuLxH6qXTR2YkaPFWB9i4bb8+4TQNVOUftcovPrLPUPQka+71u+SnZWM1D4cmYX+efx8I7wO1Ha
	6LhQSavqqvfuLlHwALSKpzgqZwltiiEw2wLw4n0p+85BHkakh+jdGkl6xZyl9pnzUxxSDHhFOFJ
	t0KaPDw/v+cNsdGWam+du7Min60X/O9281ATGaV9Obny9c6CPWMWFMgj5wOtnHoZhXiy90/wg81
	+NBYJUlBboHHh6wBk4+6R/KYgHNc7vh8eP1jeo7Gz2yd7sA8WahywvLNcsIH2/CB9ah3Tx1lT6V
	E0/55YVuZ6B4j4T
X-Received: by 2002:a05:6512:23a1:b0:5a1:3308:2a16 with SMTP id 2adb3069b0e04-5a3e7c9c6cdmr1555587e87.1.1775769626003;
        Thu, 09 Apr 2026 14:20:26 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee8d02dsm174597e87.24.2026.04.09.14.20.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 14:20:25 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 23:20:24 +0200
Message-ID: <20260409212024.19750-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq1pgoujiz.fsf@gitster.g>
References: <xmqq1pgoujiz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It is just a naming thing, but the contrast between label[12] vs
> label_ancestor feel a bit uneven.  Wouldn't it make it easier to
> grok a hunk like this, if you stick to ours/theirs/base terminlogy?

Fixed!


Harald
