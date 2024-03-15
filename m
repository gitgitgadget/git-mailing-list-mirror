Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155065A4C2
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542608; cv=none; b=gdrcS8+ON/f+93zIvtxMiH+xV0vGmLn+UGy7xM8qzu8r14+MCgYTXEK7O4T6Hq934SZNKsNTFMs+qAMC2KbZcKJsNKk6sDHqr6rvwcDEP6V9H6BHTqZAFO/SFsLDoMkp/f0KgRu9xOR59WKA8fR7qQetid+n5xQiAUFRdj5EMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542608; c=relaxed/simple;
	bh=D4JmCJnmYyETKhoR4GPX2A8cq3D2Hyp9yFEzj5zwqdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YsgjRUBUzvvmSoH/hiQm0bivFF0wPXI0375RR0SiRstqvtW1zHCZNj/EjEmmdJYiEFoftqEGZMLTkZ7VMoN/ttR3HlOunDS/RlXhVfOp5HMuaYSDQZKSQ3F3yQ67Zu3XS1jDq5nTiUcNWNyt09E8kTUv6/MXYeB7RCYkrLGZj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+Cjwu+q; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+Cjwu+q"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-6e6eb891db9so2132405b3a.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710542604; x=1711147404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4JmCJnmYyETKhoR4GPX2A8cq3D2Hyp9yFEzj5zwqdY=;
        b=m+Cjwu+q8/gL3t2HoyVckj/IfVE7oT2AetKP/bfeABEHFNOSb87WbmHXj/GAzefkcj
         /OBMGvDLqGsaA2ria37tWNBU5m2c+nUsKC/m9xGJsZVLNR5LKLJf0C07pXBMzRGQvIis
         yMwcqyA86TUVzTryAqlAyaiicV6N4pQpJszyjXDGutSiuBRhBT5fvP/nZDSJEdz+kID5
         JWHT7ZdtqDxQIJyGHhN5fsEnM5DlVkFu1umOWrEoUhdfG0HXJlVowXpxjYVRkP3/Uni2
         R355WIlrwQL8sMwSB8DvXbrK0gG0IapwDE2Ln/d2g35wOsiboLUk8XsXd+0r4+2AbK3A
         ly7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710542604; x=1711147404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4JmCJnmYyETKhoR4GPX2A8cq3D2Hyp9yFEzj5zwqdY=;
        b=pgQzZO4YdjwVpBT2GdMPHclsF249zHDIaygXGRnWOXJldrXGgvmIfCuUEB/j6oeY5r
         z2hL3S1vP0fNhEgPA7srjrzfFlhOSPPpf4qd2o8LBXg3HyNoD6T4k2ppnAnb8o/sFBBy
         vw37cXEU2l2PZs/D6S4Dx7BR2d200+eCe3FLiecUCpKOIBu7S2dwLzcEJ2U/vsMJhVQ5
         HyDMBdh+Cp9bln0AL5nBr8mjI9Yr60eEDfRI/XCI/MeswjgKH2jwMpCcXL9XRideRBgJ
         E2TxvQFmjyQLRALck5F1+cHbfCBhSDVW4V9GJoL5s0H1PJabGEL4DitZLlfvKBZt2pt3
         fj+A==
X-Forwarded-Encrypted: i=1; AJvYcCUmnCem7fluUYu9NZgT0s8DcKO9C51m+eNd+9hH4177KfCfdb+FgE4hiQ3kxCLY5Vo89ojwQW3GTEYkyudOc6hdS2cu
X-Gm-Message-State: AOJu0Yx2v81CXxFL64NqC8fUMQVK0ya94+nP1Y1yf/Ix/D0XL9iD1Ami
	alh2xAKtDvbiPObre0za1hlIyEE+SkKniREaLuBpKVsOE0a2Jnqy
X-Google-Smtp-Source: AGHT+IHpWXkBIo9IsxXRXWPcXfdG0LY8dxzI4kGnl16HRrEik7GTPTI9otQAN6pXTs7Fx3Ii39tT9A==
X-Received: by 2002:a05:6a21:1693:b0:19e:9c5e:ad80 with SMTP id np19-20020a056a21169300b0019e9c5ead80mr6411345pzb.62.1710542604197;
        Fri, 15 Mar 2024 15:43:24 -0700 (PDT)
Received: from SUPERFORTRESS.. (p093208.f.east.v6connect.net. [221.113.93.208])
        by smtp.gmail.com with ESMTPSA id f18-20020aa79d92000000b006e6931a50e8sm3888084pfq.79.2024.03.15.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:43:24 -0700 (PDT)
From: Jiamu Sun <baiorettohr@gmail.com>
X-Google-Original-From: Jiamu Sun <barroit@linux.com>
To: gitster@pobox.com
Cc: barroit@linux.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	me@ttaylorr.com,
	nasamuffin@google.com
Subject: Re: [PATCH v3] bugreport.c: fix a crash in git bugreport with --no-suffix option
Date: Sat, 16 Mar 2024 07:42:24 +0900
Message-Id: <20240315224224.27182-1-barroit@linux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xmqq4jd8ydqz.fsf@gitster.g>
References: <xmqq4jd8ydqz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jiamu Sun <barroit@linux.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> I forgot the two I CC'ed the review thread for the previous round to
> ping them, so here it is.
>
> Thanks.

I've updated patch 3; this should hopefully be fine now.

Sorry for the trouble, and thanks for all your help, especially as
it's my first PR.
