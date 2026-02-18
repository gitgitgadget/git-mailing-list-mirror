Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16663328FA
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439552; cv=none; b=Z3lZlGjFTqOjzggi96x9I/NT/ZmF2Ljv7s0v9YdSqp/i0WtaqZgSOiirENliYVFWZAO8qRF52iczaci3k37ivVGEMZwc4/wDhiKnZko2EBu+aN/EouLFkokRHRugAZ64Vo2+iNrI9C7lqxRpmtye5F55TSfeERKu5KP6ku4gkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439552; c=relaxed/simple;
	bh=x+oWjtekAVW+U09Zanwq2tfY7UvG5H5kV9Gif+YcxDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3Nzp2y4WyA3sU1gttLqL/cDNb8AdnzO/8oxXue9QuHCeIOVPZn4IIZ3Iu15Vwc5LnMW31ZeImrL9Ly/UP9VMIFUzK2ZOtNT5UvkSzrPQtM2UWeuBeNPBN3keNtF7odl20PGhVwWTuRa4GH4YHgsAWQa26A3lOx3dJ1VqzIF9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScWM/Xh6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScWM/Xh6"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bde0f62464cso29384a12.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439551; x=1772044351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoS2Jslm5NijRtBA3foWE5s5NG9CajrFHzZsCIQBRzU=;
        b=ScWM/Xh6HagvkrWo8zyu3BoR951yvf1VsFSxr/bvPTs0iWo5y8vU904x4wyEqBHxqj
         LuIrw0dRKUlbBobHBc4T7aTdPWaSezfLJ18vtayLk+IEXu4KjlETwKFjhCcf4ifelyzU
         8Ma3MUxJA7tt7DTiW55z21eEcCLgDP5jGGaybqzcaPEpbAPvjQHh/tvTISIs3PZ0kXgp
         SXxD8z6x7V8DF9g33xGUkxEmhFAIs9jF519wGTJaJY0ST6eMk/yWvdt7HRCC0ObKIQde
         WmWjNB0F7mkJjG1nCP/0+++8tstnczs3W2LkZCRsc7alBfRv6aXH/qnQM6ynW7/fKVKK
         EDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439551; x=1772044351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LoS2Jslm5NijRtBA3foWE5s5NG9CajrFHzZsCIQBRzU=;
        b=EqAsYhsA8wz116ljTag0xSyZUELc48scag3vxAk0IPJ4d5c8T4zQ2L3oRURpuqoouE
         lBZJaHJ0K8q/BGODwWOhrKSV3Hp7dRNR3oJMBHXhEJUK1wll6TqyeQuT0Mvk/TtRGkB/
         0KIr3NZGaStj2LIYhSCiuLPRdzeqCCtlfQiFnKLmg68FeJC3EmZSkAquFyt7xeYgRwlf
         kTEbAHbJA69h/ynGwV8apYCPPv7fAPOfB1CzDRqFCfoCYL/eR62IhkzdcItdPZ3llII2
         gujXCKHdNB8lH+dbGqbmjUrgTXBOGtNHEsFwRPyJbme47GlEPC30oNBh0mO1VsEoluug
         iv8A==
X-Gm-Message-State: AOJu0YweyB71RV4e1hRgOBTA4i5gArFVujauyADnA+mcsgH+eYzovcms
	H6IqVoKFEmiYG06FLkdvh1TT9k6wJDmA1NzfyMMARRsLHt3fFd0Gm5861b1LBQ==
X-Gm-Gg: AZuq6aJwwnWddKL8ZvvGjrVG47JBW+vQigK2eQyYkOKKjrW+yBIU01l64ACJW/SheZc
	HrgFkQt5TRvCopDok3i76CniLDxV/al+daQjhUFySdwG7tWFqOFimJJzSkelF818qHJ3sbnk0AX
	b7H3bUYbObg80WSzYn6sdRexSVx5OclMJd5TJgYFuYADJrl9DjU1fUNubmkmqPBAjDfv/m0pFvZ
	qdU1O06CAj4QFaIiOXsuqcBEvnANt/f/sgL25qEeQ1zG2+fSkd85YLuQCmigXgPLjlywF7y17sH
	mOgmE7gLOvhAfxImhZK2B4Kx+YhyK4syUxdlEsUZt3vkFKb4wU13pfdhaDw8gEa/zeSavQKX/en
	I+/tF1fr/heK+FiU/BGvY+3Imlyh9cE45ulz9SdXr6nKhwjT9guVUTIcbwOXP8k/GtkReHTPUho
	8so7GGc6BdM/sf41BTr3m07WcTuMgKzCFu4WGE4eullCftdAHN16WC9P8aCw==
X-Received: by 2002:a17:902:ebc8:b0:2ab:3ac6:8d01 with SMTP id d9443c01a7336-2ad17515116mr153696535ad.29.1771439550955;
        Wed, 18 Feb 2026 10:32:30 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:181:cb2d:52e8:2ca0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aadbb9bsm131597385ad.62.2026.02.18.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:32:30 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: [PATCH v4 0/3] wt-status: reduce reliance on global state
Date: Thu, 19 Feb 2026 00:01:29 +0530
Message-ID: <20260218183220.69034-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqseay98oj.fsf@gitster.g>
References: <xmqqseay98oj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> * sp/wt-status-wo-the-repository (2026-02-17) 3 commits
>  - wt-status: use hash_algo from local repository instead of global the_hash_algo
>  - wt-status: replace uses of the_repository with local repository instances
>  - wt-status: pass struct repository through function parameters
>
>  Reduce dependence on the global the_hash_algo and the_repository
>  variables of wt-status code path.
>
>  Will merge to 'next'?
>  source: <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>

I have made some changes and sent a new version on this.

Thanks,
Shreyansh
