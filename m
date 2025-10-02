Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14034335C7
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373981; cv=none; b=kzSHWPepZ2J1qQTHut98OlCxq7O9xhL6vcdl4mTmdlTuJ6ALpIO6ddjrz4FXyg7zZBvAwF11/ZA9QpdEWlAI6PFgXrn+pIStnKFgZ7/xv8hQPNa9QcI0K3LPIQDO4Dv8EcIlkF7c8lOEftmSRaGAZtFOWexLq3vcRsWb8vLxcg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373981; c=relaxed/simple;
	bh=acdJd8rcNg46uKE3jKPxUMWt5RWl42u4NTABWcedFF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAtFzTRP5l3tYig8wMPO8djl9bHGJ6L3sDjz3RJpeZ4/HSFJ8Jr+dimlAAY8mgOncl0NmbQ8C3GwUqYMWwO7kyep/6fQi6riO510GGci/3IIyTAROcvKIwunIXr/LM30S6mVTdSZtg2o2UKzFPQ5M6gX9fCkSB5x7WqVJMdIHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+JA4ByZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+JA4ByZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so685507a91.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373979; x=1759978779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TAIlQ38Zi/zYlz6G5rTXqjln6CXSTtwe+/iSDMqpYJ8=;
        b=e+JA4ByZTMmoGWnMQyUHnLbv+dVa38AN7MDsHAK2Hq24sn6MO7GiU4NG3Oh/Rma3bV
         8P0lWe2ctEs+AK9n8okuZ2C+Kz0aOtluZFTwId/HU4tRfy+hoi95QBXMkJZU65qvQsAd
         E/tXG1p4a+awmKDEtmtzexAe+tiFhavAq0z8j+KYdpgqbu/G2zH5CGT06eqR55E8wFv+
         97ie367PTm0DL6nYK0lDhXK5yoOM0h8UyYrNaivpjsPDcroTCVlCVKf/wcKgVT6FRHgw
         PANtPu9rPZ91E8GXTPupu0UP9zDYaN3qN0iihfApxrLj+m6GxnUgfP+HOZzWAKbZL85B
         Hsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373979; x=1759978779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAIlQ38Zi/zYlz6G5rTXqjln6CXSTtwe+/iSDMqpYJ8=;
        b=UBwCaVMzBJbwFoPEfwf2oAUj7HYs1JAiXRhLPJaaYykJPPmQFDGMq2fZOEOPpXzR26
         aGE128TTw5M8tizNqmHa9IloQVyNOFKhRovhojFTStgWGTpD51/ue5YKNeDj3xhOFFEW
         FoHDTFspEQo1hZZqZEsbJv6qSCBkbr2eD3NeV8P57najIuczaInvkhydt248zSabAhou
         +N/QHlVMwpCKHqXJozmFyVHElVern4G1wKU+bk2P8pLU229CfLEfMhhTRjbTeJ3tLQHt
         Ar13Wg7aiCAGVu/BMPqavlDrCTuUoKGsI1eMZqNIE4Myj5BjQXLY71OtwpGyu/TOLx7Y
         50hw==
X-Gm-Message-State: AOJu0Yw6VRVGWHdiTJkVtNgQOEuXhnO6XntgWJXE7gtSA6MOyfi7Kmpn
	FOcuIMkEJPO2vdP9MVT2noNHTUpGA+l9qZEcG155jljh4+Oi7g7dkuv5dMSycM9X
X-Gm-Gg: ASbGncuUxA9DIdHPw3MaN1yaNfI9HNQTuJYlWg8QxZ+aadw9XFe4Sj8UogzwX1oS7Y1
	X9ryWi2O/UtMrosOxjJtoBeHWIS+3DSp610ri5otTlJEh+06K0ciMyeS4dCCNwULi3Ux7Z+HRiK
	jMa4Zmija3c5tCj2It1tlS71HUCfJhRYIxVAzWpIf0NN3JqtizwD0zzPQoQFTaN2QJqadg8istl
	qXp01Xokl1DMJbV6hiVJ7YWN/bKJaoKNRjk4K4WrhzHkYgHoAivqu7vX8Bf5nx1rM8KnwWd/OGm
	5PVJC6ynt/sRjOgOCEB1dVKK/e6CzWnS/8aH2cY7/q8zYLA0XJXgzieqcAH3VRuALi593oyxdri
	b/Bz3VDuS006vRa6Sb0piDC3y6xmMfrFcJhSEx6vuy5J4YTXrt5UVjCjy
X-Google-Smtp-Source: AGHT+IE8KodKsWQJwJZJzXaGYUtwZf2fjpNUuJGH4qvWVsSdFyVnTmZ0+VsCzMgLYn3Ehi/lsN3KEg==
X-Received: by 2002:a17:90b:4b8d:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-339a6e9551cmr6259389a91.9.1759373979239;
        Wed, 01 Oct 2025 19:59:39 -0700 (PDT)
Received: from localhost ([2804:248:fd27:1700:3748:9d8c:286:76f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f7ab4fsm860213a12.44.2025.10.01.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:59:38 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:59:35 -0300
From: Henrique Soares <henriquegogo@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: git@vger.kernel.org
Subject: Re: How mantainers check Git diffs and patches?
Message-ID: <aN3ql-r3Hj9Z5oHO@localhost>
References: <aNygY8Cm7LEaBzV6@localhost>
 <20251001-pastoral-frisky-seahorse-cd5bdf@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-pastoral-frisky-seahorse-cd5bdf@lemur>

On Wed, Oct 01, 2025 at 09:37:34AM -0400, Konstantin Ryabitsev wrote:
> This will apply it on top of the current HEAD:
> 
>     b4 shazam https://lore.kernel.org/git/20250919010911.649831-1-sandals@crustytoothpaste.net
> 
> This will fetch it into FETCH_HEAD, making it behave pretty identical to a
> pull request:
> 
>     b4 shazam -H https://lore.kernel.org/git/20250919010911.649831-1-sandals@crustytoothpaste.net

I just didn't know about b4, and this is probably the tool I was looking for.
Basically what I was doing was `git apply` patch-by-patch manually (with
a little scripting), but b4 seems the right tool for the job.

> Hope this helps,

Yes, a lot! Thanks.

-- Henrique
