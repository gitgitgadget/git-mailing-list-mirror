Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC753A9D8C
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908724; cv=none; b=ZDxvUPdTzqNoBVImdDnKVxeyJro7FO0cfG7+xQeivSShwfk4axdwwZ0Ri41Wjfc0FErTOx9d+1837T571PyfuvIn22Fn7yxU6FYELNVYCx70KNa4fnmTdq5ENJigAYvVfL2TABcscQkpKj5NIN+w04eZhqqCeMwyKCYfn46xIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908724; c=relaxed/simple;
	bh=QHvDZSzisMzDm5sk1eXab1csOsX9AUCYa0yZZC8B8TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIybBBZ5TCfWQ+6hWVHD5GDExtVk+zLxboKABBHPMvqYJWmVUHB0yrC1cZAlcnD1HVge+HLHH21+u2dW21Koh/5ungU46XCEm4ge71kWpnhnGy/7qwKiJDilLF2YjEOXpG+E+hrwW3OfWlm1XMv980ePYoABIZAeQug3YOKiyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/V+56Ls; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/V+56Ls"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38a4234f91dso6713791fa.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773908716; x=1774513516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHvDZSzisMzDm5sk1eXab1csOsX9AUCYa0yZZC8B8TU=;
        b=c/V+56Ls2GWmasjP/Erm7+7bTfqggB2NTPkUOeB7EK0YKNV4/oj9bzAG9Yh5QojM6y
         MLperprn+ipz59Vr5LuTVuv4E7bggz1hoHphe4YfbQZT++IkAEWm9vHGnYqOrGklhggI
         /prbLWYaHR9LHD/pmjMyrVY8IhlB4+MuaM52SyUjHQ4EMIO6SbEdR5PCWAYDeGzwQZ9W
         1vBYBj7FPPp1B488h9nhQT2kSRWvfaknGLm9rycjr+wUCs3O8XqFIwW50YLXoVLnB6Hm
         XIWAfwXyYxIqxnBEgse1H3QbdGlKECslmTowsxOzeSWGrX4sj1TdsTw9WGq2Bd7lzBKw
         t2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908716; x=1774513516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHvDZSzisMzDm5sk1eXab1csOsX9AUCYa0yZZC8B8TU=;
        b=Z4TleKE+zIZCNtT8479nTrBC8QU+CmPk1lO4vYjCkF0vLK5a4XuhF4QzBJEqpOh7nq
         4Yzro11iokU2rj7ED1fF0He7AnvVclzmCILFVtvuSXZhBPTHd4u94ozwST+DkR1iP7Ir
         gl3Tfmp2Zz4J0etJt6lMOaWO07E+n6SOeXCNhEXNN9pXxf80r9DfXBU6iScnyaqBZkUO
         X8aoJNk9Lqz9BTC48vPBxus0LOjQYHeUs6Iz47yfFsCrQKI8PnLq4tL3oCfJ6KarpD/q
         weVYzrMOMmYDKLqLFxczmmLLMlzHHy7eQzhs8wWLRbLlaUfeXjFa4RTSBEfdMWAE8BOm
         jLIQ==
X-Gm-Message-State: AOJu0Ywa2Gbz0HqN/FP3mGXDhm76E1EC6K60yqL/4t5BkkHPEO/EdX8Z
	e9rYp9GiqW3E3Un84NoHt7JqtI92Wbp1JUR8mLaJPbvS4ap4rtCrHm+V
X-Gm-Gg: ATEYQzyGAps/VXNxT+cAssjBWBkhKFv3OcArK+SR1qBVPsV+2jqobrjGyTek9lYzxv5
	4WQPZqLUP0Rm82eV3TiB/XNVy8tZCG+TtER7Dc6Rc5q+M10bcSVnSuq+mNu0Q7rWHiz2h53+LW/
	//m+yzQj7xg4UhsBQD+m2qbJpeXXAgMs2acGeStUZb2Ev7inm981IC+LOk+9EnmfwwJiaJRes4Y
	3+hlK8dA1C05BBfH/EQ1u6hlUPiNeuQeASDb5DjW8svg2u+gbF2cTAfVbINoqfsf0CguZ+FnvJS
	GrVc0pWzFUbWzvssxXG2iaYkkTalh2bbRucdHOtDKOFMLNDyPvb6xAbVqoLH4gIXbqGRPlMvD/F
	V6yDQ+vI6qTXBPbKoyzBkl7o7hlx/GPiyLb9Z7125iNTtaopU0NmgZCCfPAPnDwjCeUfAUx9fY3
	RMELhAdT7V2Tzqh32m5Dwz3Pm57KO51xqvEZbOrevNUlY8ziuNLB50PATbFPEwyYmUVwZUroJss
	BnQ5LoUCn8JFh6s1ISuWg==
X-Received: by 2002:a05:6512:64e8:b0:5a1:3b78:17ed with SMTP id 2adb3069b0e04-5a2796d3a29mr1794179e87.40.1773908716224;
        Thu, 19 Mar 2026 01:25:16 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bd5488f79sm12080491fa.19.2026.03.19.01.25.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 01:25:15 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu, 19 Mar 2026 09:25:14 +0100
Message-ID: <20260319082514.49717-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317094716.43654-1-haraldnordgren@gmail.com>
References: <20260317094716.43654-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio and Jeff!

Did you get a chance to look at the latest changes?

The scope of this grew a lot from my original idea of auto-stashing, so I'm
not 100% convinced that changing '-m' is necessary here. My fear is to
break something, especially since 'checkout -m' is a feature I never used
before touching it here, so I don't have a good sense of how it should
work.


Harald
