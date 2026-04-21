Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7901FB1
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757985; cv=none; b=EBmv0a/lav2xX/IAjN/OpXaq9gmj5fjCe9C2un4Ph7WMHFT0EgPVnkMrxoUvAA0p/pGEDbU9EWcHsljN3U3Yv+KPOiJ9bj6gl/4CC6/kwkBBsPqOjownemReP4IB1jXI+aaxc6CHnn49/DDYgzUY6oLvHnKPlGue+GPbKb9kJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757985; c=relaxed/simple;
	bh=Kmn01ALn0vXm1nSbbBUa82LILFj/Iv6/sZh3xSGXFWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7eTl+c+MLJoQ+8uXiI329NDr7u9gj4Q21sSxuTIcqRtaRaxNF4UUiXS6MmCY/vynqhfFO3d1CBzN8IkXdlWtPvtZqKtFiy4IpvS+LT7iYQDDzslnxtsVL46CvX+xMOJhzisBXiE3LMcYXPkr50GaLDN9pX2SX3R1WKHti5wwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZRTY7zk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZRTY7zk"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a1307438ddso3631534e87.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776757983; x=1777362783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmn01ALn0vXm1nSbbBUa82LILFj/Iv6/sZh3xSGXFWE=;
        b=DZRTY7zkrqMR52O8AdxCcqukNet4bHWL2nX0uJCKLZHKevNgoDUxoD+HAizxCeU14A
         Wyi5zEryFfBUO3tZhTkrmNS6C5V24GXOHQeUANO6IBE6BvoqfP1A7/Cz9ywfdYILwMjD
         WXC76+kKJmeXdIvm13zkm5s+tvvRHZdwROqreiXkAPTLNb5h9415dnpUCQePipRZvl3e
         opjrGn+tnRmnwu77PJkqttgryJzKFau52C3hpQ5y2skaer9jSPpAfwbM19qIPIaUzcur
         SX1OtV++jG8CK0aLkTPCoTEkaxAvoinRpnly1OyMWimE/aCXyI1wKVqsk77oTiRkZ3jO
         KBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776757983; x=1777362783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kmn01ALn0vXm1nSbbBUa82LILFj/Iv6/sZh3xSGXFWE=;
        b=QGLblKVL8zP6XYXjNQ459yJmdn146lKeVndNyz702aK2hQ3/elW9ZmHnNJnSO1Q4iM
         hHeRQ3iRldSnNV59v2iX/fet/7+5DBvg01Q4WoehV3H+p2puLt6SWwCWk1dMKHq8Sbm5
         V0n5Op6DA6GMHoTEdKtP3I0stYO/LB0ZXF6sHujd2f19VTYQVObu9w/Yot/bn24C6fBj
         n6bcs1yahvJ/8fSgp8mI530XJeOhhFfARu7UQunpnVfXIzxyGEXOfkx9cUO8bS5562Qg
         KzjYP2UwKx4hfifYJAMO9zgE0Ca/4m4oO04hwFVGJGbzpylSt6M2Iq58c4qRf1ZFK2XR
         FLkw==
X-Forwarded-Encrypted: i=1; AFNElJ+p+uEE20AO2tu7tq1uWNjZQ8rX+sx/WHen6SKvZtogsXoMp5XL1zH5RAPELSikkmMkmak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU9UaaJ3Y+MK6lPjeR8KaqUl4LkswVmzSYykg71wbqfsihIEtS
	JAA8nZe2VTmeoLn3y+NeYKveowKo4ljAbbSTpuI172YyqKJcbnO0i2+IB5GxF11R
X-Gm-Gg: AeBDiesOm6KD9QyCyKYxUpentp6J16hFc4CHGJfVgvDqJWuktfObkvtPdJeajsxsheL
	ZgKSqOTZp7n0WP5BsLfd6+ShaQN/nLCBm78KyrvFKDL0DgrLascapKPcMw5fTS1HpSoz2DqJ1pu
	UpHHnuwnd9PrNS5DZKRGhBffgNO/rhk0/waOOyHDl3dJ5DjKj+PCWs2CKFFHLGW4mNm2AkJ40vC
	7S51kW7u/v3MszBUSLhpTeCVHskTubA/mvQkQ9wcszo2tt6/ArW6XL9EwokcA4JFh2DAcP7Tr6k
	vrO7/SkGbGOTiLKuNNWlLwaCC1c+a+e9A/TBmz+11rf9MknyTyzWKWGkYzjEnUpws4qXKW2SD05
	kWhuZxodwUg18qFa7XGo5Eqh8xDyzcj/k2m6tMtc8A0dwqPzopqwgphUEXIAc1X/vqaryZvsJny
	lhLy4EajfbDAC8ecSv41MXithQQf/ZNaECrsCv6G/12oHCHUOFKmk4nDvgu8Nn182FT3VoU5Iy5
	lorKMf6AHTPsj6+fbem/vko8zSOlTq6
X-Received: by 2002:a05:6512:108b:b0:5a3:fdf4:4899 with SMTP id 2adb3069b0e04-5a4172ca2afmr5207670e87.16.1776757982578;
        Tue, 21 Apr 2026 00:53:02 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad0fdsm3538164e87.13.2026.04.21.00.53.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Apr 2026 00:53:01 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 21 Apr 2026 09:53:00 +0200
Message-ID: <20260421075300.49672-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip, did you have a chance to look at the latest changes?


Harald
