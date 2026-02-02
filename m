Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6575809
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998463; cv=none; b=kAmgymUs8DoKbkpyxJyQcxC3Rkzc5uvh+8A7oNMCjG7VNlzWMCHdiBfVcz1Mvwkni66OQqX2rtN+VkfcKdF1BrkPQg7das/V6xTfhKIMoeeYmKMo1bJFn4q2vaNP3QODBCuYCTshbUkmN8d2AIjKf0bwDl/sYARHiq6QUSMG5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998463; c=relaxed/simple;
	bh=vnqO9PUBI0oH77LOWdcveKkVtYSH1cAWZquL3PLXE4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhkEIUz101XGpROs46pjhi1wwXyF2vXuwBKiKMMK1kGG4xp8a9ghLqvevc++fnWTzJ845fMsl8uFoLNwwhuz1fGUkmmnjcQ9cA6ZlF/hPIAZ/qvE+WEedOWWe6a67jJgYqConZy19VVUWwA9quVYLS0QhSUDRSjHlE2wJd7+PcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LOFjCpeK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LOFjCpeK"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794d4f11a20so3961717b3.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2026 18:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769998461; x=1770603261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnqO9PUBI0oH77LOWdcveKkVtYSH1cAWZquL3PLXE4c=;
        b=LOFjCpeKgN15sBMeehatO6GKDgwwYU5GospkRyeBoOS+Eplo62rExLNUc6Jg0C2/r5
         wsnrQ2DbcVcCWzpzsyOAs/RIOelS1dahdxTAbZh1C1fA6KwqL3Y5AwrDwzCPugKMnBMX
         ovUAx6FKVZtw/FvSbBrwxsUX4kpgDiznP6jxwcL0cCDliS465gy44y+N9Iad/7HwBt5P
         As+mHYHThtH+cc8juRmkvZsqXAhDzJ/ORTwidyIwoWg8DL71fU+eXIXdlQkBmX1yT87c
         Jx1Y4rOhIFJFQUTeXG0W5WQztfnJKj84XHaMdINEOL9WXeegv59KGPNqXeuJLnSgzHbe
         8jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769998461; x=1770603261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnqO9PUBI0oH77LOWdcveKkVtYSH1cAWZquL3PLXE4c=;
        b=hnqh9VQmRHYfAoWlljulfWiW7zwZXgtUWb/sCv3JA0ofeej1afGxLgz/+a3BlCqTAL
         1hDoEDHhRxl/xA84277O+HLeYLHmJsHtfEF+AhGqQewkbK/DcATnUo1p5ELjkHUv5fhx
         VvDYnbWJgra6oEtgdD5dvhzuczL3K2BbBrZJXhrmX1WKg8foIq2ldBOoqMpUbOjmQfMd
         2Ic6DBgTqFSayjVsNIU0NU4/fx66w1GI3IR2ZJejrt30QRYKvGeVJO7KuEWAo8VcERle
         YgzN7qy5nyLA9fiM5VvlElMR4NRw8Ff4mt5WMQQFM29S3Qjz1uf21a1adxhYQE/GYsC2
         YXuw==
X-Forwarded-Encrypted: i=1; AJvYcCU6nH4y/0ds1beW1V06JeG4A6rYIgVSRKPEAalalQolRYGYUFWA8yGeZnm/syV7AgJBSnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUrFPOqvUYfxrMEZjKSlHT+qV/wLtspaudmPJxCurigjw0Cwh
	h0szyprsyWBeIzsHula5W7YXUGw9dxcOkoE/+JbcUd11uM1ygEl/OTN6iahkH2XxLgc=
X-Gm-Gg: AZuq6aKG3IMNMHrIlmHf4nvJ62Biql21ux5tSsRDgOb5rYpS0PAHIls9sKfn9n+X15R
	n1pxi2SYJimETVAs8L4vzP9P+z/LIKWricrkwOQ7NEOPPfDrW7TJOPvZ2bXR9kWdBKFMUVMR6vG
	nrbzq87dx4c49p8cErVoUoWVJesp2oD5a+Ya2pxMGb6suOh4XHFMFL8byeaBBXWDqFqZQtMuYFb
	3HYShnHpYcBRgY3WL7JksC8u83r0gmOgt3MU3a7iJ6CIkb9tCJModDBNd/042zyMkz3QY+021UQ
	3KC3N1klH/dfSRFX+wzJ33pCmqFrc3KlTQujyF5nNvf0yOC7x/iJ+TVh5N6PP2avMRFk8lXHUuu
	spMdg/jHFNGb0BFsWdgW54MSn6fUfr/zeWSrQkJQxpVmJwGoA/n44JzCcVp94T5cmYt35m/ZVet
	p9kRcTsCxDlENPItjgn5kkM9TWPlHnldIXuFR3liGzN69AvS1C+OkJ8aGvRoWU3nCs4yo4oFhr6
	plogHAjj3oDlzdBxQ==
X-Received: by 2002:a05:690c:498f:b0:794:cf56:5bc1 with SMTP id 00721157ae682-794cf56769bmr18105987b3.33.1769998461355;
        Sun, 01 Feb 2026 18:14:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794df377204sm2710087b3.5.2026.02.01.18.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 18:14:21 -0800 (PST)
Date: Sun, 1 Feb 2026 21:14:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bisect: simplify string_list memory handling
Message-ID: <aYAIfKW8Vd0iBun9@nand.local>
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
 <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-4-0449b198a681@pks.im>
 <xmqqqzr76nuj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzr76nuj.fsf@gitster.g>

On Fri, Jan 30, 2026 at 08:56:36AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > It was written this way originally because one of the callsites
> > generated the item using xstrfmt(). But that spot switched to a plain
> > xstrdup() in the preceding commit. That means we can now just let the
> > string_list code handle allocation itself.
>
> Thanks for an extra attention to the detail of the way to refer the
> previous change ;-).
>
> I think [2/4] is a good direction myself, but I'd prefer to hear
> Taylor's opinion as well.

After thinking it over and re-reading the second round, I am still not
quite convinced that this is the right approach. I left some more
thoughts on possible alternatives in my response to [2/4].

Thanks,
Taylor
