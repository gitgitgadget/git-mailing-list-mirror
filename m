Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722F1468F6
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120575; cv=none; b=tikX3Z2CvZjoXKUuAxrRPkQAzVxAVqPBmkGyvBe2S7bFlXAcQuWr2t+PY/Fw2VobKseJkaaqX0ME3jwM3ReRi+xTEcz7dEPFa9tiFdVfQGTGI5UE4ceWkgMKXuVIOt422O1Kl47/FHNnEadF8Qhmq2e+lWSd21hhAUb3F3J0aEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120575; c=relaxed/simple;
	bh=2b9elxHYcJaN25zlGzqTIeOhWl5mjNrKy3866nm1y6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YJzT4QWDXkemOUB1XQsK5lYx/t/gngruurKn+K9s3z4ce7D4nLbAcucYE/z4C/e7M+ngM6m55dUhQlULo7WZvUZUgn+7Udm3cJsC9nU/K0ULkW/IBmFJiZ07xysfA4ssHSf3/G5uAVvfyJRDT5SGf0TTbd6Or5vAzp0nWTmAF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mOsJmQtr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOsJmQtr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e13dd7e985so1269046b3a.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708120573; x=1708725373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2b9elxHYcJaN25zlGzqTIeOhWl5mjNrKy3866nm1y6Y=;
        b=mOsJmQtrkbKridTrM4KlGm1hEBw+jeKjFC5JII8973YQ6uHWz3jFVLXCB3uzqPvibk
         puYTKM4T0rEgWOVuL564xzm+6RiKpMuPTId9sGNu0ViF+ciceytig+F/gwVBQb5HQikF
         L5IsyKk+TIr4Hf/d4UwcztpOLLM51Ibx1kjOVo6KlzF2XVOGTaLgL204/RMbORCSYDPb
         TtUEfPdj+Sn6fIb/51vwOjqkrxeaalBGZHu0lMgIAFkkRrR4knhCab6FtTY088bxb6Eo
         owpsJwn1/NjvqakfQiqu+KULK3dtY6ljYooXCt5GLgTaVF414gLOUlfbm7tQ9o3VGqxr
         3GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708120573; x=1708725373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2b9elxHYcJaN25zlGzqTIeOhWl5mjNrKy3866nm1y6Y=;
        b=hjs8R0ZA02yeYOeDgr++cxQ6n0Ee07IXMlxQbys9DQiDNo2DfRyJZloRLsdvh+yQPU
         35GhSaw8JddjszJ/xnTRxwZxJweijvqXBOt/Bi9GQ3vrONWc6Ct3Z6sNF27loFRFXIW9
         vN/eXAue2kGVSFQ8sUEtD2JB/LXZ05tx/ovtO4Khesy8ELJ0TAyRhMgirLv7JMQHojnU
         01ey2UvzEcNFb4EiwJrmw+orjsN+bff0Up9+zkosqhPLNa9VmXPvnojfeOUIyuO7I/Rt
         HL1UsZDoUisT2sonjRn2VsFknzztoRmJE9UNr04U3KSeK/Kn4K0OzcIU9jofMUMZ6rz2
         RLtA==
X-Forwarded-Encrypted: i=1; AJvYcCWDIa00n7W2QubupaE2mvLG1K9YT422c5yKBirdjjhwI9Egs9foPOKc/hpu5h3BeRRWPeZ1wb5/CVzU2obKUuYFNfQy
X-Gm-Message-State: AOJu0Yw6uffvuBMHwXVK35OEnmVgln3v5fkVJNroyJImzmnR6+W/0GML
	BB7PKkn+NvBO/lY1DBy/KTeammt4ZFohj48ssntk0BOFKwenB/wqjewdyKEEZozqhaEzq6xu176
	j5w==
X-Google-Smtp-Source: AGHT+IFqCoseCTW10xiGBM6uQGH1lA3qXMVIRWuLP5ZxKugta34KjtmpqB5WiHJB9aiaco+7x46iDJ3SPX0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:1788:b0:6e1:642:3922 with SMTP id
 s8-20020a056a00178800b006e106423922mr406703pfg.6.1708120572995; Fri, 16 Feb
 2024 13:56:12 -0800 (PST)
Date: Fri, 16 Feb 2024 13:56:11 -0800
In-Reply-To: <20240214142513.4002639-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com> <20240214142513.4002639-1-christian.couder@gmail.com>
Message-ID: <owlyjzn4845g.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 0/5] rev-list: allow missing tips with --missing
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This v3 LGTM.

Reviewed-by: Linus Arver <linusa@google.com>

Thanks!
