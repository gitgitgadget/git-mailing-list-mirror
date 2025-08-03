Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C61A0BFD
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754245192; cv=none; b=D2F7LK/ghZk9xgTSVu8Xar0dDsHAt40pc1C/ntSIfH6IWF0XETt6l23smJsfd7prMPi0lPh6K1c7zmgBWV0zTZHqo/+A3RWKMKv7hMEBeqC7dv98NDy1xiKaEtlMHoofC1y9p3gJ4zrrRdI7zljAE0ijUBTem9fDCOcXbmybTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754245192; c=relaxed/simple;
	bh=WvWstNHKHB3BzPvy962glsEgXfgUYwwWMCXGuDDISXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cphr8BEUYNE7H3N6fuzEpo3j1lIozhUPxOZkQocS9HDAhqSRfYlAzgxfoVUIsdAgtfhKwRE4Eopj6gWcutBH17WpisDG0nlWYfdbvTLm2SuycoEgsWdLUMSp3WTiwWMUnDCGJ/YSU87VKWdgM2cSRubKaEwOwQeKJqB0m8msHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VawBR6WY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VawBR6WY"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae361e8ec32so701289366b.3
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754245189; x=1754849989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCN9OmftzIHi9aS+06C0ijopA6bdbzKMslkZxpKaffk=;
        b=VawBR6WYJ7IeDE6iLvHvZl9YWWQlU0c/LQfZfI+0pBNj6jJDpysKLv0vo2GoZKmUoq
         eem3ezGPwFvn8gqSXwoSeSCt+asKq7OfL1IAHjovJrKYIapjU+gJFi1ieOFdOuUalqzA
         iCXu6Uycc2FEbpRRwfV1Gtg2jw+GXrynwWoMy5IWBf27b2doqFYaoU2s34cnme2Etu5L
         knqahTW3o7C+HsmuxrrMw2lbjnbDnETgU78dsWi0ZQC1gaEqiIQFQsdg5qJb8IEE6UUJ
         1oQHsgY8As/vLwx6GF2rB2WVrq+Qh+Yqvnsm2B0qfWm3QB+AWN67rcB95h1daLAr1/4X
         bzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754245189; x=1754849989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCN9OmftzIHi9aS+06C0ijopA6bdbzKMslkZxpKaffk=;
        b=n373dXQyCVtzchlxN2jvEd9Tr+JxGFlHMV+jJOSnHDZqG3kaFt1WcmKIPBm3veCTmJ
         yWZ//Rw6WLXwaXlEuKjqmMhtIvS9hQUVsR/z5TfbLvk07Fcg+aah/KPJBV95nM3CC6O1
         JJD4/e9IwLxEbEIPvjnamcfL/03rNHb0IwZbU0RfHoQq3Cd97ttpI7FUXuiIJH96pm0y
         F/HXSC/QTOKljo9fGwI1wIgP61CIk0IpkNeIdfiVyo+uazB1uZO62YGiJtmUBVjkOlTh
         b/jT98iigXNmWf4KHwVhe7plT91Oa8EfoZReCKujsTYyThukdCl9LyggHC7w1seDvm0a
         8ZAQ==
X-Gm-Message-State: AOJu0YwJzuoLtLca7Ctn4z6jx6tcEQzX3z26nYvDYCBs0yQKgAzovFja
	hOiGorKedEyQMT7UfTlhqjFqrqETOivuViihcizxloQtSpQMEqGmEc2md+HD8A==
X-Gm-Gg: ASbGncvYVagf0BiIoHe8NiWTmtupWjFA4P56UoSy1/NMJh1biPbBln6sRP2d2Oto5qH
	nlN7/GTKgpGvJVZWyxknFVc5DhMUCSLuEayRfTXQ72+dnPSWmFz/9nFPgKotJBs/SCwDu/vwgxN
	HDMDfVTK+hNMMozAriZ3nKnxcS7EcFeacbpjYYlgSA2b6gfGo7gZB7o0KUXR47JUtZHKa9ECI5C
	OX0D5n9g1QgxRRzYn+6vlwmGDrhRbaMJJTcYj5U2P1LpHc/ygS+SwKq2/F8HO5F6MbYUHSrIMYb
	DL2G/LVPwz+/Jj1w+cu2wVLR/Y8bqxwkQzZXEhSuL5gVEX6Gi2hW5WpqmMXjcigISWI+WOfWah2
	hB3jeZbAzAyZ/RIlGFPB5J4F4MVxWCVbzBDg8RRVtIil56Ui5t6QMJFM=
X-Google-Smtp-Source: AGHT+IHqvADUi9kdsn5sPBcqU4NiigE8XtN6qFIlbdGrEMWjg0MoyL44UvLOxyoK4TZU23ac6trjYA==
X-Received: by 2002:a17:907:86aa:b0:af6:ecd1:4fd4 with SMTP id a640c23a62f3a-af940023743mr617363966b.21.1754245188391;
        Sun, 03 Aug 2025 11:19:48 -0700 (PDT)
Received: from localhost (84-236-109-228.pool.digikabel.hu. [84.236.109.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8359sm610605366b.89.2025.08.03.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 11:19:47 -0700 (PDT)
Date: Sun, 3 Aug 2025 20:19:46 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 08/14] builtin/config: introduce "get" subcommand
Message-ID: <aI+oQvQgnNtC6DVw@szeder.dev>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
 <29676b81e0151e2982326663f8b64e2a70bec0f8.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29676b81e0151e2982326663f8b64e2a70bec0f8.1714982328.git.ps@pks.im>

On Mon, May 06, 2024 at 10:56:29AM +0200, Patrick Steinhardt wrote:
> Introduce a new "get" subcommand to git-config(1). Please refer to
> preceding commits regarding the motivation behind this change.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

> @@ -519,25 +522,19 @@ you have to provide a regex matching the value of exactly one line.
>  To query the value for a given key, do
>  
>  ------------
> -% git config --get core.filemode
> -------------
> -
> -or
> -
> -------------
> -% git config core.filemode
> +% git config get core.filemode
>  ------------
>  
>  or, to query a multivar:
>  
>  ------------
> -% git config --get core.gitproxy "for kernel.org$"
> +% git config get --value="for kernel.org$" core.gitproxy
>  ------------
>  
>  If you want to know all the values for a multivar, do:
>  
>  ------------
> -% git config --get-all core.gitproxy
> +% git config get --all --show-names core.gitproxy
>  ------------
>  
>  If you like to live dangerously, you can replace *all* core.gitproxy by a
> @@ -571,8 +568,8 @@ script:
>  
>  ------------
>  #!/bin/sh
> -WS=$(git config --get-color color.diff.whitespace "blue reverse")
> -RESET=$(git config --get-color "" "reset")
> +WS=$(git config get --type=color --default="blue reverse" color.diff.whitespace)
> +RESET=$(git config get --type=color --default="reset" "")
>  echo "${WS}your whitespace color or blue reverse${RESET}"

In this example the second command in the postimage doesn't work:

  $ RESET=$(git config get --type=color --default="reset" "")
  error: key does not contain a section: 

Consequently, the last command doesn't work as expected anymore,
because the color is not reset at the end of the output.

Luckily, the commands in the preimage still work.

