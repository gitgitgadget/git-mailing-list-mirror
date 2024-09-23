Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3A17BCC
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121686; cv=none; b=X1th4jNBrEwKrC5SCJAI8sePfUsnYU/gj3XJxx18Q6FOxyqHnkN27W95t0FZ3dB2qMKoLUClnEhBkW7xA2QjRZ6k64Nj45Z5eBGVbW1Um7lLZC+rQ6rxm2Z2gOdDwCd0DEc9TpoBPOydCIWrmzK8UNb8xdiL6+yK47CfaeCZl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121686; c=relaxed/simple;
	bh=yTTtFWpj+WNRY9lYgF3cOurrryBOxC0WOaoPNak+UFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+kJAUDWlRgVt6ZeFzLMLxgn/Fe8vB+ovZIA5EFWBokgUfG4MteS7seKILEWO5B2hBfktSc8evmpHARzI4Cj8HCSUgBqxvpdEBvB0O/d9NiZoJ1ldv4trI7EUw5Zy/CvyWnRVaGVyLkt3tt7VE6O3/ZcxexneU7mAOHEDaX4aEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwanJqba; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwanJqba"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso35785785e9.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727121683; x=1727726483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oN6t/KTfBJE31hukd1OuNyIH8tkDGEeMGjevtQ+DmyU=;
        b=BwanJqbam/+9l6Y0UaR6zv5ndKVo+vUbI3VcY7Ia9HFWH++0yAQlA9DSne4i+KuIa0
         /PGZ/paZuIZo+JhOAJ2r5RItkPAZJBf4oCyewJ7R1zSpv8Gj7J8eJL9h8v5aaQ2Vsw/5
         Oof2RQRSWXt/UlZE39otsxsJYORpqY1GQqeOabxt6GZkhrOvrlwerrTTwJ2WeUdIDhsv
         h9AC9TOryVA5J3nG1ovxIUIZiVrwwwLepU1E1XV4hxhZAaa5Xvzit88dc3c6i8oWAS51
         /jpFo6+AQg0fmIL+3Lx4DAuF1STzXd0nhMusdMXmv6enLdVYQQjmB8SHNI6yHQMUQaIA
         U5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727121683; x=1727726483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oN6t/KTfBJE31hukd1OuNyIH8tkDGEeMGjevtQ+DmyU=;
        b=BG757R2WiUotDpISg5YoW9o/fzdBku2vKxiTk4T3U/mBhCE1/KTgmZt+G9fNidFlVC
         oKGeNZQ+eSlmIDxpch8WXzevhureIkwBrRH4N0w5IRYHlRRZc933nCK477C/llW6TAZV
         ajkgt84qjCDECGvWGYdHb9WDHIOllcfUNEQ+d2w1f+G+yx+DNroM3hVj4n7aLEV419HS
         ZQsO30ylpLBRAM2muOZgKM9GiEoQS29ZEYHeAzP5Y94T/EYf9xMZgvRAKJ+1tTMBgcYQ
         kTpyMza6JG103xN+dMRhjM3SaKNCl+F9U8OX9zK9LipidWfgwyV0HF2DC83jSZ93WMAS
         25pQ==
X-Gm-Message-State: AOJu0Yw6vJ4LaGYmuqquDaqXRBjHxqrer0PmogVjnikd9ASIkCp3XfoR
	kVA1E4ymaA5Z2tW4Lu7MY2TzAnhtHT/tStHfCez5IIUrTmr6sAK0M/i4EpjJ
X-Google-Smtp-Source: AGHT+IHyee3S0fXWr+N4uVCGjvNmSabKgbir8ttCFkfOkfQ3olpzoew49XApyQyPxLhi4+GUY8OkJA==
X-Received: by 2002:a5d:5484:0:b0:374:adf1:9232 with SMTP id ffacd0b85a97d-37c7ebb6dc8mr526334f8f.19.1727121682437;
        Mon, 23 Sep 2024 13:01:22 -0700 (PDT)
Received: from void.void ([141.226.162.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805193sm24974900f8f.98.2024.09.23.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 13:01:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 23:01:19 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Documentation/config: fix typos
Message-ID: <ZvHJD73k_SETqAsu@void.void>
References: <20240923110343.12388-1-algonell@gmail.com>
 <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
 <CAPig+cR5BdfVRwdXJ7viJbvgkUW7KStG2Y_=qGNzoXWrOgZcJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR5BdfVRwdXJ7viJbvgkUW7KStG2Y_=qGNzoXWrOgZcJg@mail.gmail.com>

On Mon, Sep 23, 2024 at 01:59:16PM -0400, Eric Sunshine wrote:
> On Mon, Sep 23, 2024 at 1:51 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Thanks. The changes in v2 of this series look fine.
> >
> > In the future, to make life easier for reviewers, when rerolling a
> > patch series, please include a cover letter ("git format-patch
> > --cover-letter") and include the following in the cover letter:
> >
> > * explain in your own words how the new version of the series differs
> > from the previous version
> >
> > * provide a link to the cover-letter of the previous version (i.e.
> > https://lore.kernel.org/git/20240920082815.8192-1-algonell@gmail.com/)
> >
> > * include a range-diff ("git format-patch --range-diff=") which
> > provides a mechanical representation of the differences between the
> > new version of the series and the previous version
> 
> I forgot to mention email threading as a way to further help reviewers
> and readers of the mailing list archive...
> 
> When sending a reroll of a series, use "git send-email --reply-to=" to
> reference the cover letter of the previous version. If your email
> client doesn't provide an easy way to access the ID of the previous
> cover letter, you can grab it from the list archive. For instance,
> consulting the above link:
> 
>     git send-email --reply-to='20240920082815.8192-1-algonell@gmail.com' ...

All noted, thank you!
