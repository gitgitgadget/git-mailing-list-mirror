Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6483A05F2
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373246; cv=none; b=rEVjLFEtChT+hJuoMiIce6xuJst5XVADlIUKTLzTnmULvTPmzd+QfQXfk7KsPW2v1KYK5XT/ifkdzY7wKZyEzpvW1JrIEz32bqa9wSgL/8n4i5YkaqKazKvGt7r1Pm0eBCQZrqQ3/rSYECfa8r88DUdhJt61ihoKXXA/E5lPzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373246; c=relaxed/simple;
	bh=XI+d+DAsovev+xtb7illBMFPKhHcEfp1/MAoffAHxQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb+X3BIW9KjcOqpO0QXiY2yWPYDRNzfXDNu6+OI80wxVF9xY8Y0P0hIZA+pvGWI+Di0u4qfc9sfhMJi1ge1tsmx0dtd2dEPn0AG2phD2P+NNPNdUDnI7MDd0r1jOkX0wazJwN/mTBK/k+GNLqvL7g2Lb9FdgIseVsNTja6rg9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRC+LYCA; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRC+LYCA"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a308736a36so2098930eaf.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783373244; x=1783978044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CctuaP4hihXipo/tvULdqch4zddGEY5JNSWEe+N3zXw=;
        b=DRC+LYCAjlzDqP1HXVb+6CQgjUGcYvauZVGV2YRy5QZs8FiVVrlsmSDdlfdmZwPFh9
         FTjCKNF4kt9e9mMZXif5ARG5Q7PK3LOnQdtOEYoCXmb+LksaKatYvsAQtwWILL+Q1nqq
         XoMtVbcMdTI3iE+ZhJkbIrdy73ZW884axdLO/nI3BxisHla6n5ExJEvwPUdJaGB03D+F
         QXcOy1E2Mkmj9Jop3LcwOkC1LF1G4615r4c4hr0/BZsSEHIpfQ2WuUFpuRIbygyW6oZ/
         E0oXLiY5WAfM60Bt+7AMTGB/MMY/pMhH/JahFbA5iz/SswD0PXP6VUBPQVcoruY4wU1l
         Tfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373244; x=1783978044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CctuaP4hihXipo/tvULdqch4zddGEY5JNSWEe+N3zXw=;
        b=Oz4E/h+KGGDu8aB732kioX5h5Oe0wCo44CHdFdBMg7SaArYOLr62l+Kknson2S/f8R
         xP8+SZElVJkzbY3jUL94SgwXvpDr8boHjFY9cjmf7WWEiJe1boFXLJTpNU+2nGl2zAO2
         nHC6k2Rm70MrHlqo2KGPwKUWvevAjuCKS7lmQs/NrhM9rsn/slqfxBiMl/6fktSKXRJI
         gKt5B+yaIhKcyxoKIGD6Guh3f/EjqzVFOg2oIQZVqOS5bPrpGqz64NldPRpaAhfCnURl
         ZNlRjsSHOtcofLVZNeuJVsTuxUboA6fyifJWTthKbrxGgoKCyfJ2nXC8xAv3xV9YsYF1
         +8RQ==
X-Gm-Message-State: AOJu0Yy83rW4FIV/h41uV0uJpNSorP3Nh9YNHvMc4tu2JVCJa+bZYPke
	CHlvcNegR2Kpd9XyYEe6OQCVG4zFNCBmKgDMo7aIJnbGxGmUozQ7X9SOaNjXXA==
X-Gm-Gg: AfdE7cnbtxn95jZBiS9OpEwdF0TCACWL+v5ho0LmBluG5KsmezRYqEKJC7afzoYsUZa
	vzmtJJ4pX8S2dg/lhaHsVJyRwJlgwFrMSdJY/c8w/xZHc8oOR3xA4ekfQX17fHUaVON1Lm2MRJS
	31x/DKBO5YOzJhbAykSfnFSO3NmeVdhwfr0aHKVS/q7dPG4ncJ2TgxL36HY4rBTWp38tHp63SsO
	ZxAET1ybrlAIuTGCQ9nXfeAOV/Sju/Z2GIUqKyb/45Un4Am8hNmPD3OMlfCYP1MZnOlW2yBeu4g
	liQveYVPOG65oNEqKDgKOJw7fCI6FpCNvj27XB8Pw8YRjp24fh30PsexxLvW3FlnRbk/BjPmzou
	82Somx8B6zEWt5PvsWHOoVVTmVDwV+lNnbb//s87kljnKzBmMvxE1ryVnIpBZsO1JQjuyJ4ts5x
	gZUtoJNg==
X-Received: by 2002:a05:6820:134a:b0:6a3:db2:ecb5 with SMTP id 006d021491bc7-6a355313915mr1569390eaf.3.1783373243758;
        Mon, 06 Jul 2026 14:27:23 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-450fd2cfbf5sm2091574fac.0.2026.07.06.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:27:23 -0700 (PDT)
Date: Mon, 6 Jul 2026 16:27:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] setup: rename `check_repository_format_gently()`
Message-ID: <akwdRmmU3y15jUiB@denethor>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-1-13864eb5a032@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-1-13864eb5a032@pks.im>

On 26/06/30 01:47PM, Patrick Steinhardt wrote:
> The function `check_repository_format_gently()` receives a format as
> input. An unknowing reader may thus suspect that this function actually
> checks the passed-in format for consistency. While the function indeed
> checks the repository format, it actually serves two purposes:
> 
>   - It reads the repository's format and populates the passed-in format
>     with that information.
> 
>   - It then indeed checks whether the format is consistent.

Ok

> Rename the function to `read_and_verify_repository_format()` to clarify
> its functionality. While at it, reorder the parameters so that the
> format comes first to better match other functions that pass around the
> format.

I agree that the current name is a bit misleading so this change sounds
reasonable to me. 

The patch itself is just a trivial rename and reorder of parameters.
Looks good.

-Justin
