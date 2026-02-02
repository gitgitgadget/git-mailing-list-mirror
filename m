Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441D27E054
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020937; cv=none; b=OEZzEAMwIA3749MY7xlICYkRyKeAUdSUZpfGZRdPnMxJCEnySNWrmMEFkO1OXpu4VQkuW9ckoVp9u5pYDBfirhGvGcyTTrVJtO8FEJ01O8qLhtJHrJNjLpdhAL+Hqrc8Zdnb6I9kZGewxgDeubm5AWTmBohIT/vycdWmhCjyHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020937; c=relaxed/simple;
	bh=LNSJMBZVhUxYT799rFeUTPzFPP3/Et54nw3qw3qbP/w=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BuKX+gsalIusy+T6ZYHaLgdTNpTFOlnRAQ4NR4x9xB/A+xXYmA140PxvLYGv4g7AwI0GN6sZ5i+Qg1VvF0xJwvFo/BBWxX2eO/l7PWcYELKh9wVI/vSbYXSIH369ak+M8nBflLHx41lQS5B9g4mkhPhQYEBLR5CAvkdgkIl70oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc7fFmGY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc7fFmGY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801bc32725so30485265e9.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 00:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770020934; x=1770625734; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNSJMBZVhUxYT799rFeUTPzFPP3/Et54nw3qw3qbP/w=;
        b=Xc7fFmGYR0aC1SyZw8m1RErrYCuqXL/XzfIyEnx171JF1NreEDs6CpTYHXsQlXvf+p
         MGcrEcs3IKxq/3vtRioja65c64473fiyXwD4kuqTyySayXdbayqerS9hJAX+3KDLBE1d
         JwGOTKUnUhO9UBeYnTnetOBDcHOWj1zkHnqFjGDFxrvmUJEfghapZGjMCaJDgcirCkgM
         wiFDxmew9J8X/7sLd0M/BeAJ0JTSuIjOHoFmYROfrt4O6WD3V/HdrEl1PTLn9oc1+kVp
         96WL4dBoqj6x0B9U0XxsayJB3xF5I5+LK3MAdixpyJhqZFZXFW4HcIuB9qewruaZCOuf
         XZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770020934; x=1770625734;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNSJMBZVhUxYT799rFeUTPzFPP3/Et54nw3qw3qbP/w=;
        b=pgJ/bcu3WhSjD88gmckepG8CDLFI42tp4v8YlSvggnHbtvfTOlhqg+MjXsEvSmzWxT
         26wpEgqg+OQqiKS4dwePZCpLMBxD3IpTB4IiZeVDJ0X85z5+mbGhSM9Bynaw8SqOLLgU
         +gvhGziz83j1fJoyo/Lo/bvUVmWI/Jshpdkt0W5u9EagG0KIJi0olAx/nUcWLwrOy6u5
         IInTl9CHfhMVBwfv+Md3mm4s0oiw5lcgDhiFu2SivTz+MSWBvBSKiAPebUxcJR539zrR
         0p3tO4qI2daH1qNE6VHA+XwmPyH/0H+vy0UQU1BVrC6LkD/T9pb6FNyRKCJd5gk97hNX
         3N6A==
X-Forwarded-Encrypted: i=1; AJvYcCWz7T9cxniIJeXHYw4DJsgrkl1ZFvxrIMzsvs4TOvRQ5Y3a1Y2wqUgyV2N+fYspO6Ie6XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbV11HQxyoSQBq9sL5oDIjd0qcPELTZIUDHcmC42bl+uV1LWXi
	yua2v6+GFif1MVaklsFD5N5l1W9/Py2erodjD+m8PrXf7LUhm9ZEi8ZxmrSakhYp
X-Gm-Gg: AZuq6aKQQlB3VEs7d+uYcjzrMSiaWY9maLIax3I/p4UshBohh88qj5vuDcZdzfWXb0r
	+3NiggpuhqiWYF01FpNe/KshXN2s8vOTSlJWinRIiYZMYPkUYZmFMdTgfFfTkU8KXKavApvxi8+
	WI1+VTfItoP/L15rLNYgpCwVEsnQuGU4zrfgsPUy+VOCDVoANAeQE9F69PlQXgwSOMISWcyf7Ls
	uMLQU0NA4hbpxSLlBZphoZilC/40GAjNLUmCzxDTQAk+3mWwUb0RHEyOo7MvKbIpNWYyiEM2yXt
	0mKxKFDffqOuKaaFlDWdPxyDJc6xR01LiOBnQ92I9wXlYsC0nlGI7k4EiqbS52UmmHn8UVVjy9+
	YL1f2X6nESurCJJTzDSnBYHTjMkrwV1QfPrsen5MCMOonEeAsWqGJ5hLPrp9F/CgYdsdR5Fa6Gi
	8P8f591QZnRsPJKhIwOrcDq85nPdJdonY6qEBUkOLYC3kHq16KwvUv4Q==
X-Received: by 2002:a05:600c:4443:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-482db4a317bmr139507495e9.32.1770020934332;
        Mon, 02 Feb 2026 00:28:54 -0800 (PST)
Received: from localhost ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c40e04sm455080165e9.13.2026.02.02.00.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 00:28:54 -0800 (PST)
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
X-Google-Original-From: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>
Date: Mon, 2 Feb 2026 09:28:59 +0100
To: valusoutrik@gmail.com
Cc: deveshigurgaon@gmail.com, git@vger.kernel.org
Subject: Re: [Newcomer] [GSOC 2026] Introduction
Message-ID: <aYBgS93v-7bCTc4Y@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Thank you greatly for the direction. I did check the microproject
> page, and the first contribution page. I haven't fully gotten all of
> it , but I am making progress.Right now I am trying to understand the
> first git commit's code by following this :
> https://www.freecodecamp.org/news/boost-programming-skills-read-git-code/

Hello Soutrik, welcome to the community.

Try not to top-post as we favour interleaved quoting.
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style.

Also while I think the resource you reference above is good. I think the
My First Contribution page, as suggested by Deveshi Dwivedi is a good
resource to get started, after which you can get a microproject to
work on and push to the mailing list to understand the review process.

Thanks
Abraham.

