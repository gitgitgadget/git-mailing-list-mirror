Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188E2E1F05
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680687; cv=none; b=KYKcnUtL89gaPwzJl5HZS5M+3JKSZb0nFwq+sAMetknQYRJmwGN6MrPO8VZNmmvV4ng0vMnFz7nm+QzJ9h6NNyBgOf5WBwWVMb9MnaDzscWrmqqqx+Tkzu5ct+q2d5oHVe/Lf6teMpkibNI+m8cve8HUu14eblRwgdKziFNa+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680687; c=relaxed/simple;
	bh=49Sys2U4jViphzErNtZcmg3IYGQU+YIOu7Ks1Vgj6VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs2Ul74UX6C0h8E6tPSVwKWP6orsMi1GzGZ+zG0RQkGjOSy9rDWmWQhg4bdoOrW9RwpykAFt96dLy3C25tom2giRhE96La5s9keCCDO2Y+rL/ElpXaBVjumXO7vSK13jIp+3DL5CSZJSipLGPVZKcuNshDtJKGk54I8IDJj/SC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehvycK0l; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehvycK0l"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656b4881f55so630323eaf.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 15:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763680685; x=1764285485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fA9cF4LXvFB0SJqXC01BfZsU+v8EQmA3c57HN2Z+NAU=;
        b=ehvycK0lvavnA5/xigF+5Fm3HPgMXnpJR1BX/+alxA9DB+GvmdZIyFJAz1Rc5luuk1
         doEqcN7egbaDmwjg1d32iaQPHW50GRR/jI1C/dkRYBgCq+kid4XSX9fplKfiEGanuqOH
         v59XklKmHHtWKHWt3O1uioierESJaJmsmhVYfhZo1860r+MrFoLoh+eB3ThWVAe9eb6j
         tfijv5Tpsk+6zVXHCU0rg9My2/u9q4jU7ZdQsANnT0MZlVlyfXWWIHYh/QikM49wM4yU
         a36OcuSZBhoOFYcV+nt1EumMCvxUWLuJCT9cBUELS0GmI3VzfDUMO5Uz9reH4gDRxTKU
         CH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763680685; x=1764285485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fA9cF4LXvFB0SJqXC01BfZsU+v8EQmA3c57HN2Z+NAU=;
        b=KZBcmIdf8OowMAbMK2C9C37v0w6WpFCZK3WAkNWfSGBqk8GBDtig2otYQsQqcK0Hk/
         aS5GS29Fx/E+q73Xn/aIqJ/ysRrFNMzC4FgX2xMMUSUnt+DVBb4+sEM5oRz0KC7vhmVp
         GBIyaZz7F2CKAd9keYdfUf4rWLYKAXCMwbcOwDQL0Sifs9TNp9I9gOS0mco+xbY2ZIVo
         2+011fs8IJkVUmqzR2o4ZNlpPTLuk6pwo6opOkssxbifXzGVrkt62WzsuvbZDm7EbeFN
         x4PJGqR1jSDpFywKN0FwenVnd64WcWmD6zZvRA9DsJcIj+k7cpyoF3rNnJdJC1xaiqwJ
         I6wg==
X-Forwarded-Encrypted: i=1; AJvYcCU+zgA9VMhigAOupimHcSqGxW2gb73yxCr1iUzQfOpSE8qw2i3MikHRu6XQYQ0s8mjdotA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9uCZJipPu5Fsw77IRphss+0F3EmxJfhLuT7QfxHlqXc+RrEQ
	hU41Ym67OUSoNq4crwZZpyIN16UpgYOts9wlWhJyf931BlbupAyzOEqcaXf9Sb6GeDnyu1hjO4c
	QWYFqbEy68OBWwyGDDWJ8w372v0WWsRI=
X-Gm-Gg: ASbGncvFaGJjI1tM8tgGhFfhdj2GN4zoS0nAMC9HiIvS1W6UwhUAY9O/2HTI1BHN5Ex
	v0NJx3Qn1KGOxqP7NhCNiZDG1yFB0aW93uhivXDVbA7UEpnQqF8y2neLpt2nhlZRmEe50UnesiF
	2hpbp1AwSezYxaI/Z0rGQP69wsksgeWa1FmWLO3uzPMKYyOalsWHbxAdlhnfFsFz4P5/SJ7gZc6
	itKTG36HoS9ins3KLL0MXtpY03ikNXOIvCEJEBGptwinzQGb3085yOXz1RQCRqjs6DsFVd8BFU1
	9+3oItH/JQgYol1vceV7wPwCKA==
X-Google-Smtp-Source: AGHT+IGeV1mQwywzkFQRZbiuC/Wj9pPC7yCMCdJM7/U50z49LTVkmfMXurTS+VpEnwYMwHdtg9ZUNtb7oi/FhGeVbO4=
X-Received: by 2002:a05:6820:150a:b0:657:6905:56f5 with SMTP id
 006d021491bc7-6579085ab05mr260101eaf.0.1763680684947; Thu, 20 Nov 2025
 15:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
 <6F4B3935-7F2F-43C9-8E5E-12E2FB3331BD@gmail.com>
In-Reply-To: <6F4B3935-7F2F-43C9-8E5E-12E2FB3331BD@gmail.com>
From: Martin Guy <martinwguy@gmail.com>
Date: Fri, 21 Nov 2025 00:17:51 +0100
X-Gm-Features: AWmQ_bnfOTFwRTZhnwP5565W4JZx2xH5gWVllSrlNjx4y4gijOPQgUdZ4qMi1VU
Message-ID: <CAL4-wQqH2=68MJ7o0aU9hJ2bgYY1G=xWvgEjpVz9QvTPWMgSsw@mail.gmail.com>
Subject: Re: Feature request: git cp
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Many thanks. So it should notice anyway! Wow.

Blessings

   M
