Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4417A58F
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111418; cv=none; b=IuwjX6jnhJHYviuF05fBDCFjSbFL2U9xnMlrJCbQJB6jI+t+NDoN6kuvxhrysSXE5CddQwoBn6ctL37G55O0iObugplLz5NZ+cvYCmhNttDSnrMWxNbW7wvNSvcll/59Wg9UXWv2aJ2Vsk9e4D6SK3detv2vNp3emKbxN17s184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111418; c=relaxed/simple;
	bh=r63bU/EGTWMxr5sjtzqi45brYaeSCi46Y/zNr/e6x9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fB94oZcAKT71NUDbGKr/ZKlwK3yM57cVal8HpJc1RJcBq0aVXJx2f35Ty/q/nv2KMkTdY5kdfVN98i3DOeJHQxymvMZL0c1RscyL0v6WH5HH/9KZw2ciGtD8ixFyzMtScHElyvRa20/obL5viPBGzOzzCKbOrBF498FnyF3f6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=gqmAIXRl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="gqmAIXRl"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a1e429b89so36389166b.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1730111414; x=1730716214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/hLSiNlck2YisxESATdpKNltrYdzPR8kByxkSV8TCk=;
        b=gqmAIXRlLmq8eYvYK4qBgADF03cA4KSZiotONVSbTddJoKa/LqijeJswcDLAFoRz8r
         F6LUaJ6cLQ3SW+h+RqeRooHV92V9MjQPaqBoc9CmzeatxwIrWaP+nGnCsXngOPYl5N71
         jl90ve2w2vGdZ8Qzr6O8WmEd/F64/8u6V3YSKnxgsDZZJ7LiRygpxOKM+gHERJ07UM+C
         ReFHc63szHNKAMAcnHTpZQSmXf4O7Rm1s3l5KPzRA8izzmbw5iUnU1sgS2dAwdMqSyej
         I/hkD+KPs1gwi3xSuSUCqE99X3aqWIg/ZdcKR/aROwPGMXBte7M4rB4Jm2XBArHCh4rs
         3e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111414; x=1730716214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/hLSiNlck2YisxESATdpKNltrYdzPR8kByxkSV8TCk=;
        b=Px7bMPMklPdBwUi2adr40miqDqJy47IN1YFh2355kvxZwF+9VI8342X8a33b6qOLiX
         O1i6Y7rJgXQqr1DhDskbyHAAHXnF5wkWMS3MVogAYXaf78/2/JBnjd/5hW3sndnQNRts
         08DddXPaMYUnS0SthxdTQ8n0LdbW3MJbaxtktrgYfQ5yBiru361ZFKr5FFt/ltPBl5Ar
         /YanBG7PrgJNiuqF2yfPoKnn8xBzuxLBQCvlih2jNcNaNbWBCJPhDt85hBqN4ISp3mQA
         HTFlsww8FungkYaNnx75M8qxkb4muaMjRwFrE0nidvfHgw0s59UEXKg1Lg7jTDzSO1Ei
         jtjQ==
X-Gm-Message-State: AOJu0YxUdnMzQnsRXoxYl6VDKM3q8TeGr5vioQzAPsgjyY1Hze9Ggsp5
	AeT2ckYVczd0K6PP2v9vWMWdq5wFYYcCEGD3j/U+50K/StVlyJAbw/IirUptJjFdv8E5+Ce1Cbu
	OIhRn3oHIViy3wvZGbbd/ys/afi9jEtC7vnnllvgIvi/2XEqFsav6
X-Google-Smtp-Source: AGHT+IGFdxek96HF77++HndMPqIJsSSwbUfLHAwQzOK8laPRmy9pHDV2/jvEIm40fCbL0d6SXetXibQcvHZx1oBO9a8=
X-Received: by 2002:a17:907:7ba7:b0:a9a:7f84:93e8 with SMTP id
 a640c23a62f3a-a9de5ccb5f4mr311803566b.2.1730111414098; Mon, 28 Oct 2024
 03:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Manoraj K <mkenchugonde@atlassian.com>
Date: Mon, 28 Oct 2024 16:00:03 +0530
Message-ID: <CACfndskJZyOf2k2JHVo=8C6+RE3nUdMF5my3t_qcL1+3dW26og@mail.gmail.com>
Subject: [QUESTION] Performance comparison: full clone + sparse-checkout vs
 partial clone + sparse-checkout
To: git@vger.kernel.org
Cc: stolee@gmail.com, Shubham Kanodia <skanodia@atlassian.com>, 
	Ajith Kuttickattu Sakharia <asakharia@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We've conducted benchmarks comparing Git operations between a fully
cloned and partially cloned repository (both using sparse-checkout).
We'd like to understand the technical reasons behind the consistent
performance gains we're seeing in the partial clone setup.

Benchmark Results:

Full Clone + Sparse-checkout:
- .git size: 8.5G
- Git index size: 20MB
- Pack objects: 18,761,646
- Operations (mean =C2=B1 std dev):
  * git status: 0.634s =C2=B1 0.004s
  * git commit: 2.677s =C2=B1 0.019s
  * git checkout branch: 0.615s =C2=B1 0.005s
  * git pull (no changes): 5.983s =C2=B1 0.391s

Partial Clone + Sparse-checkout:
- .git size: 2.0G
- Git index size: 20MB
- Pack objects: 13,560,436
- Operations (mean =C2=B1 std dev):
  * git status: 0.575s =C2=B1 0.012s (9.3% faster)
  * git commit: 2.164s =C2=B1 0.032s (19.2% faster)
  * git checkout branch: 0.724s =C2=B1 0.154s
  * git pull (no changes): 1.866s =C2=B1 0.018s (68.8% faster)

Key Questions:
1. What are the technical factors causing these performance
improvements in the partial clone setup?
2. To be able to get these benefits, is there a way to convert our
existing fully cloned repository to behave like a partial clone
without re-cloning from scratch?

Appreciate any insights here.

Best regards,
Manoraj K
