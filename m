Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1413DFC87
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648269; cv=none; b=GuKrhXDKhKOYl5M5b9gtadZcRS22T0J5PDX4E4qvB045HN8lF9hRmKQLuobWCjj1stoe0zTNbcmZvNsB7dAZB70+Jahr9rZnzMVHU1DGrbIoIZtl9th1caMoLw92RIfsMQaQgMYtwjawF5PVLTutncVa9y1/kWSlgQbrpY18gg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648269; c=relaxed/simple;
	bh=cfa+E8OKwjuFZXVqoD7p35tchZ/nJhKC8OIFeH5UepY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEqb1NiRW0BwYlod41AJaf4kJb/ejONBqWelM2BvzLvfHw+ifx2oWI/qbgoBjI+OZoSEGrKsqxg+iV73QeuIBAWlX5Hwv3IvwiTVspjt2bEJOlFurxFJkbi1SBoiz1F1xMo1QaGh6Qfb3mF4EeHGs1IhfT9oNkUM23Dx6OiJC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0/jow4W; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0/jow4W"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598e60a735so1658235a91.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648267; x=1773253067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfa+E8OKwjuFZXVqoD7p35tchZ/nJhKC8OIFeH5UepY=;
        b=Z0/jow4WUBuXj9oId+nfRTVb3wUoBuvAowswXAZhewlVoLMIW+fQej4xmpcPJ1rU3i
         zPpmZBFCNnRGxC5qa8wYS47UlA3Whiab91I8H7hazFLHiXRZupjyYiufUJGlAIBbXkKa
         rv8d2U/s22Sj+992B2KR6M/+KMeKdymAHNlCmfkGy0n7xUfn0sS6R8yPm6PQ2AIjzkKa
         J4n9Gzg+ZnEhuORebsX9NO/S6uSaTtq1pS2YdYgYZAeNIr2FvFX4rjn+/VM/OIMVWbEs
         ZL+DFc4NfEyde7ZNYCdd1XQadGs9modWS1g/3JlG/YLF18u5mR3xP+p88EugkD2XLWc8
         1woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648267; x=1773253067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfa+E8OKwjuFZXVqoD7p35tchZ/nJhKC8OIFeH5UepY=;
        b=MaRSQVHoU9CpZPRTt4Akw6H394dKRW+eef3kXrD8qsC9GgJxxNg69YXG01MYs1/tgz
         KlL8EkuiXmqHOpWVv9x9Eifj5DBi9q+apDnmMxlPArJIJeZry+JEVkbzvhJ/T78EI4w8
         5XIZrVa14XDKdRVw+EZ2JCoszpN7ZWglY24xrz78YtY48YATYPTqDFYZiYAzR/rNQeNp
         87pH/izgT/9q6+jJx3ubZV6QdJ0zAZXz3xBWuaYWV9A/XfEKjf2do2O9hxnCs/9VdbIZ
         T04zZf9bKXndhPdQiKoesaZKfJvky1wtcKkuhJoTzmtG1nTLe9xsQDsBC1m4AjlRwsv/
         uCPg==
X-Gm-Message-State: AOJu0Yya+bEeoXRMsjL4p18JnilFkFQSLO9s63TgqV//D2T8w7NLxYyY
	CAQLtpj8J9l0JVKDaA1dYd1O9PtCA8GasvP6iMInDaniDtdOA4ex4xHNXVOQ+w==
X-Gm-Gg: ATEYQzzQ96fcWAy2USP3iSRL5oZG/I8lHVXTISqx/owB7o2h3ZrkHqAR1w9QQjkMTSb
	PcY0+EKD7ntrvWXKKsctkUmZoWKXBARyM4iOofO55S6WvWgwCAIhYdkwqjyxpeGP9iI78A+yu5Q
	RzoxrpZfSCNm1mLObq58RM7Qy+HL00dLgyZUVbL51yWAmRbdFCNFWKEFlNV9A5u4Pf4miOkrA/r
	k72GFTWZUMrO1ACxO8moEY6GMT0EZS6bKONoxjS5qftMtocH5sr4J4FN4R1DahwB+EomlT1t38f
	yzeyknleRjzbYpEm/efPlHoEJgphFtVqXyFi4ZEj4AD2EGtg4JKFsulUta4nQpCCxxO5bhKM/wm
	hn7znp+55KKnEGtUv7TbWivfa28C2KXvvv+Hzq2W9EgVLLpIETOW8scGCpuEGXVdT82b1mb8tBm
	bzsf6S3MbGaCXEXugQadhVLl8n6a4jRi6zgckIg7RcDW8kVW0BU8FEGdgg+m4JwEVWlJdSE439l
	mnSNDmX4g==
X-Received: by 2002:a17:90b:1643:b0:359:8632:5e3a with SMTP id 98e67ed59e1d1-359a6a4a5c1mr2524701a91.18.1772648267298;
        Wed, 04 Mar 2026 10:17:47 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm7397362a91.16.2026.03.04.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:46 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 04/10] fsmonitor: use pthread_cond_timedwait for cookie wait
Date: Wed,  4 Mar 2026 11:17:45 -0700
Message-ID: <20260304181745.25673-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafifU-befdZW4O0@pks.im>
References: <aafifU-befdZW4O0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> One thing that I'd be happy to learn about is why specifically you have
> chosen one second as a timeout value. Are we sure this is always enough
> on a loaded system?

The cookie round-trip (create temp file, get inotify event) is normally
a few milliseconds on a local filesystem, so 1 second gives plenty of
headroom. If it does fire on a heavily loaded box, the fallback is a
trivial (full-scan) response, same as any other error path, so the
user still gets correct results, just with a bit more work on their end.

Going much longer means the client just sits there waiting when
something is actually broken (like overlayfs not delivering events),
which is worse. Open to bumping it if you think 1s is too aggressive
though.
