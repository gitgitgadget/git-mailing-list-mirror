Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63516139
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366727; cv=none; b=vELJXlIlAFUeW72j/DMbWroXNKog/txX+NlMBjbqapiPkNO+8DthUDOBNGbYF96DejDJ1dce1BeL3CtzoN8aqSt8+FcCT9YCKDaOCjwVgss70eMSBCLg2n+jv9cP/LSQb87YNevf6bVytxwTCBTqcy8jCWokdYTtOBGVDbPn8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366727; c=relaxed/simple;
	bh=sJaWMjlWAOdID6YH/DUIZjCs+IufPJRRfBYdNkmNIwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7ebwGA6/DoERW7g/7vfTcrVQFT0xz7+mHe+lxrGdQV1Tw9NJLxpI5cWLIESOyGFAlsLXN8Eo2jbjxOu3rYcqy5YeXnWo+3jm80TGdy4xDuwT7uwpTgdRdfA+I1ZaP4Pgr4W3gQalGCAVKRYVsePUZNw19LeGo1orFapchI/pRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENXJkXEE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENXJkXEE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso1229212b3a.0
        for <git@vger.kernel.org>; Wed, 22 May 2024 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366725; x=1716971525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ87p04VE7vHx26+4Ba6VxLnS4lsE/Hdc2zfripxr3E=;
        b=ENXJkXEEfFf4TWBpBjhy1IJ/o41IDFfa0x995ACxuWgtMqlPYdvAxQE3C0+RHgY1dY
         0bQ1N5wDlDRiQYA8nxSrz6oxiVd1UpJ2zAtIkLJVbyZcnxma2+Jho8FCuZV/Kt4KP4ci
         dcKZcdHZSw46LOVMG2vwruVFOm2HipE5Wrubm9FdaZLHA2K+u0bu+XAcHxdMSdQmTJdI
         7l/kJkVauJYgSE6UzS+J25c9mYd5z8k+0ABQ1BiUBbLVbkU5EuUnHTSfWUbw/Bh10ieQ
         +0juGSMVf500Rxun5YfDu1SgvIbY3E9yi3thqiUUKZY/6KUtSl1SGPrPH+NPay6/qG05
         Ih0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366725; x=1716971525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ87p04VE7vHx26+4Ba6VxLnS4lsE/Hdc2zfripxr3E=;
        b=PGp09/iB+SvxzK6W8WPXpWK29NbnrWS5z/7W3lFEyEDXdo+Ee6XX35DOgfga4w2K5W
         +JA18GkDR441EKx01VGqegTevtWvcntlrMId3zeX29TK4abR3zgya9+gOpzKFf6YoGhO
         spLf5PXP9l6jqcP62BP+LtCjhfB9jSk7yjv6xf2NQRWa9UoPWX2198UmtY7l7Io/imeF
         SsY4os1tJ04b+Z75rU9YIQJDRoUj7ywthhzxW0rQGBsU112uYbc1nLrV97yrW+KELGZ/
         UoRCohm5Rn/lcfCBAAt9uCDUsTZ0qnO+DwpjX/KzQhjT5WCdxgrPvVLU5htofVK0vL0p
         rHMQ==
X-Gm-Message-State: AOJu0YzJNnrWP0WS+MAaQo1VAiQi4hEz+c//nkVptF8jIfNSdJtfdMhB
	9M/ICZnQTLC2/Enysym0XxR5lXtYRjPX57tJ3w6EXEbv23z+t094NTsehQ==
X-Google-Smtp-Source: AGHT+IHUMx4rO0XaCnf1hzGkSdoK2zKM88NTqyZDeA5IprmBxHN9pwxSmCUCnCF35ncpPjiJFg7bhg==
X-Received: by 2002:a05:6a20:a110:b0:1af:d19b:a7f with SMTP id adf61e73a8af0-1b1f873a915mr1640720637.9.1716366724709;
        Wed, 22 May 2024 01:32:04 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:b807:e802:c2a7:5720])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-65bdb181aefsm9747316a12.43.2024.05.22.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:32:04 -0700 (PDT)
Date: Wed, 22 May 2024 01:32:02 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
Message-ID: <m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net>
 <20240520190131.94904-3-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520190131.94904-3-ericsunshine@charter.net>

On Mon, May 20, 2024 at 03:01:30PM UTC, Eric Sunshine wrote:
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> On SPARC systems running Linux, individual processors are denoted with
> "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:".

not sure if worth a reroll, but the "usual" syntax is "processor  : NN"
the regexp used checks for numbers before the colon to account for the
syntax used on s390x which is the only one with numbers before the colon.

Carlo
