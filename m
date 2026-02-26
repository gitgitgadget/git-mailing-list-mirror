Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851436C0A3
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113813; cv=none; b=hleUjs2+c2fvEy2APmfGEH/OKEWCYLGd5LDRW4prloOa76pAa5UAxGFMia1k4t1wHn8aTUsi3EZ54ciZnLT6rl8r1CKl0ZZOSD6ly3fjnXWYhocGnZ2d33+h2OStNItj0QiiFpeK3APWhTftMptavm3DH7O2zCn9WqKNpIzNF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113813; c=relaxed/simple;
	bh=hBl88OBfCFQbyoxL556/06XQGGT5kE8PtH1feS5Tuc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsoqN1AOLj/NbiAjxAL59sq6stSNsg/B0K4hoC0n+lXeyazPhM56VsDxZsFI3ZYMj/9IqJItaXZ0xLU0GZzNvY9wLZOJdGmY+rqcbuINGtInwfEJHfGuH/k/zQ4INf6fKJWSeBVJvKlev08s+qpwW9WrOgcf8YoWwJkEPBUIWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHoh68/Z; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHoh68/Z"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a10a1617d0so807014e87.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772113810; x=1772718610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Win3ZmVTx722ZEQDAbvdp8P1UGaNImr8tobbq7vYVww=;
        b=bHoh68/ZCeWygEXzayNVUqdVI7bZeH336N8cKWPi36TZdlVIDLO+shR+N4hbhU/Zn0
         XkUK6Nzr7VhfH3WEpE5pRLAAKWwq3ALvbjTHUlMts6D4RPgSfTK84iCbFR2ihkqpiSBs
         kbVwMIXU1W0lXVKmI4OVhVMwbf2g2pMpZjBKhPCJOc+FFpoKCCnJfmGYz0hxj8py4zJH
         b/C+D+GnDkMaI9gIzurGAE7YyE7gC2ch6LWTU8X5PbkQ2DKydLOHw/8Nw7YOE/2GkpsQ
         h/VPyxsFTAEFGcHo/Ec09yJsaF7nVWkb0fXAiDH0lYjcfLV4IR932P1hl9a01PAkoECB
         nDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113810; x=1772718610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Win3ZmVTx722ZEQDAbvdp8P1UGaNImr8tobbq7vYVww=;
        b=bZZxJLxw6ZjLLtaRwl6DD7kk/WcDyWOiPxqYzS+HoRsLVqRkfqMqtjSWuvm3gK9TxN
         ycfixZU9bBNfAMWJib470Xa+X5nIrGeDh4LDyteR+gljHH/IPnMOlcc5Luwx7xqgH99v
         P3UZI2qNUmhaclPf6r6j0/nQJ6Z/aTRoRsRWFBiqWsJ74jZ7DenNev8WitVAx6pkd+8L
         NMJvjmldPdUQmMdImiDX1Ut1234SviwZRs6QXLvV9byYgcw18buFiX+tFbwoGgMcRt6r
         pS/jEbaFiXvOdmQ2pguD0f16aQC3w8SFc2BDZi78tgmuGk1N2pmV386+SFjWTCNDTB8A
         1Yrw==
X-Gm-Message-State: AOJu0YxwePv5rxjJNVYO+9anb+SbNq83GLvNwWqnWqSw+WG1xclptKhs
	PMJBdOXxQfMFEztv50JQP1uMcDTTJMuZavu8Gt3gwBQNuwbulJ59qeL0
X-Gm-Gg: ATEYQzz5sNgWOFqsTsNj4L6vfO1fk9T46i+pbInqq9SbRICrpQ2pOPti6CEgsimNH5t
	LvAwoJNcvrsanSVjgqqtfs51jrtIjFpg89XuXn0pM/E5SDcU2iWRWXtFR9WxALUQnFuSqoXa6s7
	XAnaV9N1JOf6FzgdaR6H4KmANUzntzc+hKNf6W+7VqCucO0+00CWl7Y8gelMka0bRInPl5HRVJb
	VKf1eADy3U9JEAZTnMMAzhIAP55ej2u3okSVrId4VsVqgsb+vD3kpx/+yFgJFy4/V+9PVZUVT45
	4lbd6Ru+jxeV4oxmgZmILGVbnUNazcx96wZy6ITqLyJ/exqML0v65HgDZmoUUTLQc38wlpP9Dym
	Ftn1O7f/g4T8gxxkS+mQgjHsu4vNepeMseu1u4DVy4kPAd79+5WXH2Gx45bYAHhsMCm8ZJF65Yg
	6OvjTOH3L9cpEppOqklktqYHdLiJDfPSQgquCd+M9Pm1PCJW21uHceGbzT26VSBzrPI9s2salSm
	Y+bcCCMS/ryTiL17x4Ytw==
X-Received: by 2002:a05:6512:3d8b:b0:59e:5c8f:75ff with SMTP id 2adb3069b0e04-5a105eacea6mr1565262e87.35.1772113809629;
        Thu, 26 Feb 2026 05:50:09 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a10a319f05sm838993e87.50.2026.02.26.05.50.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 05:50:08 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Thu, 26 Feb 2026 14:50:08 +0100
Message-ID: <20260226135008.6863-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225160842.GA2160019@coredump.intra.peff.net>
References: <20260225160842.GA2160019@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I think what would have moved things forward more than just a ping,
> though, is generating a plan for moving forward in the face of confusing
> review.

Very fair point!

> That can be quite hard for first-time contributors, though.

I'm not actually a first time contributor 🤗 I worked on this feature
between around 2016-18. So I know it can take a while:

https://git.kernel.org/pub/scm/git/git.git/commit/?h=seen&id=1fb20dfd8ed70b4459312918a71444bc79ea6f0b 



Harald
