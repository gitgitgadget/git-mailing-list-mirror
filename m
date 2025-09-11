Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B10635
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757549609; cv=none; b=FnFP7KVn6suElnoielaqBSY06G1BEKxtzLArNVWwFbHeexIRsPlrHxMWbIc1G9t46PgDZd8l+/bAairuhJkvo8dzC1JH5nlM65IGS0G/ZGM8f9zf+Hm6sugmXkVJgtrwyVjlvM9iNBKNjD51yFmzA+viCDT9PFTJfbLn8Eb71kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757549609; c=relaxed/simple;
	bh=oPh0918j4cUQVL9CO2thFyRs+NpK7tQmrfNBngXHGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HthVFmjZU/yUsis6HtI37RFIgUjAixCiIeLeuyPSa1TBqcotMz+D9e7IFgks6K0+URQ1X2McXRuDup4nE/uEDH/AhwQ6UsRl1iYSG/M0sgMcoz4jkNUQMMr2CPGCdYBTsiZjmw57bLZz1FqRAa82x1EjP/JsyHD+DzRNbJe7B3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVJnT81b; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVJnT81b"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso163766a12.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 17:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757549608; x=1758154408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPh0918j4cUQVL9CO2thFyRs+NpK7tQmrfNBngXHGo4=;
        b=lVJnT81bmbAwWCeNBrPtrgZtzIMjYke+ymLXd/5GwBPsJtWLxTjgUnZDruQGs9S4sN
         8z5t1Na6nDC8Jusrjtx8clnRpVScKcp2mYb9ljqjYsECFfBltTxjxFunlB2YV9NKwyGm
         wGn+G+90BdLXuypmgWWhRmYv26wEumN4M8c6Mxcfvvaf+47j1nShin92CDR6CatnNSKg
         0nEyWiJRA68ptn0s1biD6iGgMvnp1oc3E7goZ1UwaaGVRF+dyaOMBLEbu0RbMJezlt9j
         L17uiEhM7XKhVbwEn05YVgmSAk3F4eAVYAXy1GT3o+8eEWfSl+2esxsnqcE2Pm0UbpOC
         Y+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757549608; x=1758154408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPh0918j4cUQVL9CO2thFyRs+NpK7tQmrfNBngXHGo4=;
        b=Q+hU/S51YmnuRhtsGBJv3z6qrRMzGAsbvJUQ+T+T/1mmErloU/Rb8Svd7EWKr0YOlZ
         oMXDe95wSsdB5xABg0i0YmbOc/+i7H/1bWfLrnFbBJOyKFgaXxxoduktkjRWH0buAQ7+
         UTcp0Z7UETwFLhL6T6mADm5VBgenU1Ci+LE8HUlFR3MUYDZOE806sIDGu7X8px8v01lC
         jvPTcMGkN6rgdsjIsQiRV7PycFEG5h+zlalfnpyrr0UMbLr0ULaYo7UADX827l+V62cK
         gOxJAaOSZeZ+BkpL6Kccn+hrodt5u6qkJ+pEsZtTVicGs1LNuTVd5HiXjW/uu8u0f4Sz
         Bm9Q==
X-Gm-Message-State: AOJu0YwiiHGlWFQk0ZIKvdnHiM+Y+jJfX/B1rYiVxOMCIGbzjp6q+WCK
	JjHZR6hnmoBVMuq5rzsMg1AUnOS/zpOCfa6ymctfN8qZHmstHh29gS1phkMq+EIC
X-Gm-Gg: ASbGncsaRhz74P7CJ2bxjoKlaTRbbmKBqtZTxEdB7Hv+1gwAXJPp+Mt3oYQbnnSwuVk
	VwPCmV0vFkzXxzxE8+eTVMDeJeg665qFpCEErql1qMBufTU/684RvPygpAK2fD5y/HMfHwVQVrQ
	sNljfwnWJS+fmYEsYPwk8H7oafBih59K41y0LZ51Q6TNyoPBhUBeJSmVe3/muXpFUbuJV1PF4mt
	Gj5loxOjUF+fgQvwZlDlUVlcR789nuvNiCv74egStSRlBD5miuKViL17aUXp0Dk9COzSg1BSqtw
	DD191FeJKCJnLTbjjnTUyNsf1H1JXlQaJFVV15uUOW+DUnYjmVtYMpGghIf+jMBtryAdffACCdL
	gxnfiMBVZwqCxgKwlXVJB2eaASjLrcwXmdvNL6AsXyjvn6w==
X-Google-Smtp-Source: AGHT+IEYBUbU3KTPzghEcU1a0w/Am+0TRY1S0TUoAPBC9FSbF0n+auQs9iggB4vQEVNEBMPkCRtHbQ==
X-Received: by 2002:a17:903:1ca:b0:25b:a5fc:8664 with SMTP id d9443c01a7336-25ba5fc8892mr12968575ad.51.1757549607594;
        Wed, 10 Sep 2025 17:13:27 -0700 (PDT)
Received: from localhost ([2804:248:fd27:1700:8b73:76e0:2c46:43ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2afe7026sm39684125ad.140.2025.09.10.17.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 17:13:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 21:13:24 -0300
From: Henrique Soares <henriquegogo@gmail.com>
To: ynckz <yanckezcs@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git private branch Feature Suggestion
Message-ID: <aMIUJJTUegO3Nzcm@localhost>
References: <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>

On Thu, Sep 11, 2025 at 02:28:54AM +0300, ynckz wrote:
> I have a request for you. Could you please add private branches? This
> is a really useful thing.

Any branch created locally is private by default.
Just don't push it to the remote origin and nobody will have access to it.

> Imagine that you want to publish your project as open source, but you
> need to hide the .env file in a separate repository. It's easier to do
> everything in one repository, but in a different branch. Maybe there
> is another way, and I'm just dumb as fuck, but here's another example:

If you need to share the .env file to few people, but not to everyone,
then use a submodule.

-- Henrique
