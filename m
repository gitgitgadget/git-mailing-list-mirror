Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034D1E32CE
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490191; cv=none; b=engOoYUJ5RUmXmx0rYtmrxNq5d2E2FpPPe0a7H3ciAf6hFNA+TNPK7B6mfR2gMPrfpmFLZS5TCrU6U1fck5PtTfo4WCfCO0f65/su2ULebGrhUQNSux4IV2arcwq/k2bin6nVtEteobPezesKLZyxExb4eAj16DSJmsXHbmYqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490191; c=relaxed/simple;
	bh=2IgUSUC/tDdFola6BH9/4KICl1wzLbLLhNKtwHI1yrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd0S1uNiCH9EpEFHs7ED558OTHQLhFFLCtaoHuHRyBwnK7hagRB1gdvZ07NVKbCqVZOWNYuctnWskr1ZiZtkx43ypS9t2D97xhkT3s0NIpcIc5Kp6ktF+5QMIy8hPZ3ZeSq7fN/2br9kt7lUU9RmUUd+6NYWkv//CDoW+Taf7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R2NSLYOv; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R2NSLYOv"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82cdb749598so296724839f.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728490189; x=1729094989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IgUSUC/tDdFola6BH9/4KICl1wzLbLLhNKtwHI1yrA=;
        b=R2NSLYOvHnJg40bjG426sznQBAQetwcUwGA6i06+s2u0WRSHtf+Um4GZZTRlQNBWFI
         RC82PlseyPWOOn6htX6c56TFb0xwvHdQOt9zvGfW1rnZdBszFdedKN6JXPo7416YyapS
         wRAKQaq1x6YsaXVEG/e8AVWg4iBEGpNzRYi/HzrP4wJWxWLAWXviVbDOB1Kf/Lb6yiYn
         CK3AdokrgUz92jyRdrbMHhgT4jk4dWggYl3vPge9Lj5IDwRvUuys6r9469vSwSjWdKQG
         F5UAh4Hf/clbfbyJ+Iw5j1wS6NYbkdlhTekA/NOhAr/BvWxgIAFiUJNuLkY2hRUI8tfo
         7dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490189; x=1729094989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IgUSUC/tDdFola6BH9/4KICl1wzLbLLhNKtwHI1yrA=;
        b=w6FiWlhcE3qstU97cycfkBx+2VI8NaLsFgW6CBg7ALs58Dpsk86G44B2jLVnrcr0Mt
         F+yz4EC0pkZw1Sw8ztfmAZ5+GQBE7Spef1x5FqShY4iOoyUCBvgE3jEhJEJP9+3TwPty
         HdUWHQB2N+OytARsYecdUg8ookBWJ69Mqu7zUBu2Q2XNVAAzd50nALnz1WaZFx0FjD9B
         R32yZLh79D7JEB9kYv7L0IF5ZKXG8pHLmZqd+KgajnOdLsk4+kQQJW9i34qBN38SIHBK
         EYzOW48UuZZiLhTZpBNeqGt8zKxrsnWpZyzVHZP/P8WmvTFGz3TqPk9xrVzpYrkAutU1
         8Nag==
X-Gm-Message-State: AOJu0YySJLu4iKhw7TQwwfGIWx1FyUujjaOEErIcU+Rff1WMTiYARXqI
	IXnKKJBjaA8dfhbbbePB3panRKYMH7gSgVcyRvPRhOBsoqnGMRJWTP8DZeXbTxs=
X-Google-Smtp-Source: AGHT+IF13NlfgYaLBjZZGd+O8opbz18lHl89zI0jxWun1THGgrA2Mt7hJ19x7s3vNUdHWNklYzOZNQ==
X-Received: by 2002:a05:6602:6199:b0:835:46e0:d141 with SMTP id ca18e2360f4ac-83546e0d443mr113888539f.3.1728490189128;
        Wed, 09 Oct 2024 09:09:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db89c36b20sm1280776173.173.2024.10.09.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:09:48 -0700 (PDT)
Date: Wed, 9 Oct 2024 12:09:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: git-scm.com is now a static website
Message-ID: <Zwaqy3oh83tuM3m6@nand.local>
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
 <ZvM65LqtFW8f9uqC@nand.local>
 <ZvrNmsycmamx2dcR@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvrNmsycmamx2dcR@nand.local>

On Mon, Sep 30, 2024 at 12:11:06PM -0400, Taylor Blau wrote:
> The only thing that is left is to actually delete the account itself,
> which can't be done until our last invoice is cleared, which should
> happen on sometime later today. Our final invoice is $61.86 USD. Once
> that is cleared, I'll delete the account entirely.

This settled yesterday, and I have deleted our Heroku account. The last
traces of the old Rails site are now gone for good!

Thanks,
Taylor
