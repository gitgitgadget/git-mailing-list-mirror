Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF16EAD4
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713694977; cv=none; b=CNJZsYiLofizw4gacLRdYsMlFuaabAyx8C5OiIgKSj9/pxdYCB66PLKtbWsbtyUx1W44fO1ia6OopCk8vcnlv5/3KvaLt2ElcK0HzPfYLt8vo7DnKEyEmjZUQVmZvyvTMo8pHvwXG2fEXYJ05dGNNHRiG+eC7rshYlqi1VUzG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713694977; c=relaxed/simple;
	bh=phHC7pMlVQ6BStHlzs9Wu3e1/tIVz9wZPlo4IR7H3ZU=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=uFS7G6u0TwoCCwOFz1r8F0yx7gt3JLmFs8VMd0QSKs2G3J4jNX6bsee/Oa1eHTYBPZ3HFsGWS3pyTIs30J0ovKaui0khWOvSMRzgMelCgSnxdIS7Kb3t5ZUmQL5Ql9cns/ZWKsP94D416UspMhhWYZMle4rfAgniMhsBzo0eWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps3JYBv0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps3JYBv0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343d1003106so2760814f8f.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713694974; x=1714299774; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz/WUyj2P1K7DMbBE9GKP/iN7GoGJzVcrCR4AHQf+7g=;
        b=Ps3JYBv0r2fbww+7ZANOMSzxTBftcD9oVXRNLCYko3ivGEXPILHUX4m2NNkJUVCgbN
         kd/pVudaUMwuCYdKzcs+gZVLXQFwsYP52+9atLFmQ88Fsl9CcVlgYzjq5QSoQhyQ7TbA
         1LjqePAg9Wio3skBjjmTvOXlFavzKUX3K6dlD47kJ+U5KT0TfH0l7Vp8apQpzsJgElrB
         PU6ww2sAaMgTbbWEAEDr4tmUHtYZl/udDl2Mq8s7QUBjMtTbsUZ2J/MYAFnzhYnz43+v
         etatM4Qx9Aj6nf50NA77dSv+iH/wXaenAYBnlFVSBowlYA7ou5SfX7ySrIDM7hwC1QLa
         D4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713694974; x=1714299774;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yz/WUyj2P1K7DMbBE9GKP/iN7GoGJzVcrCR4AHQf+7g=;
        b=T1BDPeSkPYV5tS5878TYVhVPXQsq8EDRx7q4XkY62P0g2h92ekiOSgjZoImdyb6hdF
         MwMwnZJ1ScP1JT9zH/y8bnJJsOKcqCtfIfK+KfDB+KCYRCxljpTm0uLzJS7U1zn7a4u/
         BEmMjafMTHPaPeE3ntV+0FC600c1RZfIW807KR4FVLjfowN6PS5L9POfwAShZxhw3fss
         RRyNP2Pk3wF3nCo4mLJoBmLDAO4QO04hlPJZPQtLKK6H1BrNnXsYW3bB+s0Yq0Ohzzm8
         5qIOF1IIMrn9N+wn8SZ+ChgX1fbNbEcfeg1bmIB7QcjsDxdFn/4CHUHUc0+lEqrP4nA0
         ooRA==
X-Gm-Message-State: AOJu0YwelJgOJP+IusniHNgKW7M2OZA6ry2DHH0+qGmzed2OfM7zb+8m
	Rj754x1hOk57u6sDAZAv1mqWl2sZrM8AlpP/rLmRI/mbvUiBkHEEIPmjfw==
X-Google-Smtp-Source: AGHT+IE8cp6jmAGXX/KE+CcdrA3H6XxM37TNM2aMQXpw4dIsg0yWicaZqh/4msC6OlHHCOBH8x214w==
X-Received: by 2002:a05:600c:1d86:b0:41a:43ae:acf0 with SMTP id p6-20020a05600c1d8600b0041a43aeacf0mr547058wms.35.1713694974254;
        Sun, 21 Apr 2024 03:22:54 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b0041a49b10a13sm484004wms.11.2024.04.21.03.22.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:22:53 -0700 (PDT)
Message-ID: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Date: Sun, 21 Apr 2024 12:22:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Subject: [PATCH 0/4] mark t3701-add-interactive.sh as leak-free
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rubén Justo (4):
  apply: plug a leak in apply_data
  add-interactive: plug a leak in get_untracked_files
  add-patch: plug a leak handling the '/' command
  add: plug a leak on interactive_add

 add-interactive.c          | 1 +
 add-patch.c                | 1 +
 apply.c                    | 4 +++-
 builtin/add.c              | 9 ++++++---
 t/t2016-checkout-patch.sh  | 1 +
 t/t3701-add-interactive.sh | 1 +
 t/t4103-apply-binary.sh    | 1 +
 t/t4104-apply-boundary.sh  | 1 +
 t/t4113-apply-ending.sh    | 1 +
 t/t4117-apply-reject.sh    | 1 +
 t/t4123-apply-shrink.sh    | 1 +
 t/t4252-am-options.sh      | 2 ++
 t/t4258-am-quoted-cr.sh    | 1 +
 t/t7514-commit-patch.sh    | 2 ++
 14 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.45.0.rc0.4.g08f77eb516
