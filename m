Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9D78C93
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041931; cv=none; b=byIcNr6F8THDLAg2jF2YjFCyTND03caXKGTfUdZRL+i/0qGJf62kh+P/9O9yIU8bk73yGaDLaxxudw9lyJDonEf/IXUPRD5WDqPoyvCA3C/ZWqcnESBkCnLdABHA/WGPGVVYcjCJiEbgDXduwnHGt5asmY18u82536AJHauQsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041931; c=relaxed/simple;
	bh=KxnTRyJxzpVymL1mVp4LXqvVcb96tSibzdB/z2n6MoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyomgyW717L/Sq9A9n0v+qixcJuepOLGSdqWvZKdpq+9GKp6uWkqSBM3dv4awV2PilcM4qLlsjEHB+a/1gpTKSAfLdYlfI7KJAfdFnAqmN7h9eFUJ+2rq/3/n4ySLmjEBPZoQ46j1aRa59S4LOBW4s+SxWvoY7llCpSX7ImNtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA7LlXhk; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA7LlXhk"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso195945566b.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723041928; x=1723646728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxnTRyJxzpVymL1mVp4LXqvVcb96tSibzdB/z2n6MoE=;
        b=DA7LlXhkm+46SDrts0P7kS5ifVCdqYWtIQq/S8sU38zXi33S7eGjvshtr6SGT3781H
         TiA/ZVec5gAQWtA2yQXTdHgsJ+U0Yh1JpK//3veDSb9+tWDIohS3vEuoo8im/BqKPb/x
         i3wJG9BGcmra2C3E7KkbN39f6o2ykbLxtZqb45WncpHsqw8Cz2tmlhj2fiZjfVHSWyFI
         vSaY+GOH/aPRCKrMTrLwJNsyDE8HD/VfxmJlOEuL67BECNZrREXBox4QUPoBldB9DrlI
         5EDUQvW6RA7e/v/MlHlASwqtbAY1FWEhbQXZWyATHAM/SZvBNFs8oIPfEkLfkBus5NJc
         KHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041928; x=1723646728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxnTRyJxzpVymL1mVp4LXqvVcb96tSibzdB/z2n6MoE=;
        b=XxTl7Ogn5DMhYk0o0bI2s6T5WC2e2JQ1O3nBK3tZt5aIlbfupDYCvosVaofiEf39AY
         EOcmk0q+w/2MnxxGzlOvWg41huxisM+q3xme9M8OAG/R1YFkmyEltLlNvSVgbD9z4R1W
         D0lGLygMv3NkXX0urZpnm+LzV7NaTW6v33fyqjgrDKu8+sqfp0eG3/fnTSINF2uEtRMR
         Xg4gJd5g82lS8jc2O17nBM/GRxCvQNs8oxuImOab6ADJx3H3R8+6Z7UaHNnpqAG0f9M7
         w+/sNOCI5ezlIVQvozjxNmO9bcIUmviybMp0UhNGsD71aQkAfUHt5RVRombxawle5dd+
         NYHA==
X-Gm-Message-State: AOJu0YzIgQE5PLalxNHXqIFPVHtf50lsyhR67KszgjOam0IqKeoS/+v+
	Zl/FyAUEJcGxMV8hZPE5FCg3+c5SJ7JLN612BdbwmpqwNhA8JxH1c1K5QKSbsD3x2Xddvj/8+cf
	7FH/BdD6EWrb0YbmnLj+nF4CcAnyTzKq3Vow=
X-Google-Smtp-Source: AGHT+IEjg2XKqyCCUzQxIyQRm6mH8EGxhxuEe33mRgfdfRQbxU1btTuFJuYnqu64Wzzzh0V5i4+QdTG7g0qza1BBM3w=
X-Received: by 2002:a17:907:da6:b0:a7a:83f8:cfd5 with SMTP id
 a640c23a62f3a-a7dc4e57b2cmr1268946666b.18.1723041927442; Wed, 07 Aug 2024
 07:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im> <a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
In-Reply-To: <a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
From: =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Date: Wed, 7 Aug 2024 16:45:16 +0200
Message-ID: <CA+osTZWES2eU7xwfd6fSNdprg_iJyaqRaA18ft+vynXgf40FXQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Improvements for ref storage formats with submodules
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

> Just got a shower thought that this isn't quite there yet. Most
> importantly, I think we should default to the ref storage format of the
> parent submodule both when adding submodules and when cloning a
> submodule into a preexisting repository.

Yep, I was going to suggest exactly the same!
Thanks for the quick response.

Regards
-Jeppe
