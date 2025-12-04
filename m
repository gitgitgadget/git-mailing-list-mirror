Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57230220F2A
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886092; cv=none; b=k8OpPt/qSu1iMYv/9o8Xah5CFedfMUB6R1GIItMUvFObxWMUSbyB4J7ZQlliFpfpbKzEPjMXKYAiY3Ah26PjZ+zrbEyUu/xXXFOMLmuX23WowQ0dKQIblRfD8xYSmkrQPxXF4HffjHKgVZl/qEzMZEOFgUTIV0vwC6mIDbYhYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886092; c=relaxed/simple;
	bh=vYogc/nhQT3RZ8GGXGAMFh7m0p24S6MxFRm2uBR9Wdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVetV70HbTi7r1cZG/JTJx5j88aW16s3PXliDR5We+mfgWF+otv0FWdWHAbBhWmZFZ+jz5blgA77USvxJ5OyUhDBnZkpSytW+xMwiSmOjidD1zR+4O2OeMVZraqqJOIekeg70GLZhT8dLKc2jizGsVYnyGfwsbNu321Jhe/7IWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qpWRDvTm; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qpWRDvTm"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63f9beb2730so1248083d50.0
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 14:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1764886090; x=1765490890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYogc/nhQT3RZ8GGXGAMFh7m0p24S6MxFRm2uBR9Wdk=;
        b=qpWRDvTmcBNKy55/suqtdX1s9AZLYWjB2sJCmLNc48NbNz+RIPLSWIZ8K3bp1CCFEz
         0qHbLDXEec5/SESpqiMvrGr881ezssO0R5+GiEMLTOWMgDoH+klMHXlmosVw7BDJMIoj
         hX9RMTEuddG8tQyAkAIaMBZz0hLB6SvVtyqSa/OssRbdbpgxfo8zEfWVX1mH9M7gpTbd
         EpvqoDODMZ0MuqzJXleta0S99thfg4MibSe923en/KcgUr02zF0LCItm8WDsblEc+2Ge
         yicGYZVohf+mRrr/N5ZNfT+x3m7UV50FlBwkcYiGSBElzyAvnNUfP4MSH2UXmFoN0TmZ
         dLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764886090; x=1765490890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYogc/nhQT3RZ8GGXGAMFh7m0p24S6MxFRm2uBR9Wdk=;
        b=CCNRwNodqEVlBY6mCYUjqvgB+VIZoKXHiw/1uuxRI1eOySqNfp8cUkMidijXWoFsnP
         fWheXncGgC501541j0Y8qUm7oPD64xFXGcXaQxOVfKnmX1eqeZfTS+Z+pXePB5YYI2rq
         Ap0GtA35uM0s4Nfp0c2oykyKu4htXaQDjNDjtQkqBc+5OXirspr9r5egCKG3GppIbF/+
         cAf/WaGnnXV0Wr8VK34057F6hoXp6VFBBb/ngB87pzH7y+sJ/rdzDnW4cf2N2yExM9TV
         tc7weYQ4Uo0qkZQp+Z/+F3vG0pFxZCHX2SeiEla3n8E/+AqpMq556j8+OdnaVNYdSk73
         RDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZN8qrVOoGLqeA7EaP4O8lz90Y7N/GydlrpVNfwcRvxPsmw5dxQGI85iHWcKOmiUaegj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSB4cbYw3da3OZvPRfC9gaEp7R+7IOdWnZat71pcw1Z/+apST
	c3yLPtRkk0SzBHzkPZ1Iin0emm5POjfBQ1gXyxcRXrtXaTnl5XsIbKtaGMLZEvLt6tg=
X-Gm-Gg: ASbGncsC9VwTqRl9dCgt75C8wfxHaN32v9tPur9R2ax+2Q54Vl1Pj22UJuNlPumCDJt
	e9+lasVV2dbUraXglVrLANIugpIbNRoQNlM+vU1GNrfimPpiustP8I37wqwRy4iVyrI9Cnu6JMr
	e17xv8cGgxRLHKiU7V9PZxYvRxtYd+vKbwgP7WfEa3gLGU3qZi7AlrDdwQwoFLCZtjJ8BmcqVkb
	DpB+1N3ztdDswgCwjDqG22zTY422kS0Abib0hyE6BzkFm7GmsKdSOkPHzoSSfKcECik+becnfNV
	a1lT+Ugcg72OYmAxilSvh4uce3PIcR9sdDZADbAQU+ZrnvTOBk8ZO/ZbaFDwQ8NYAqWfZbTcgxu
	gD65Ryj7hoR1TVCWCWRKcMMFCp6yZL77jHnXRG05gKpVP6ZZP7CKvqiMwIEkBVz1XeW7ZZWCPNu
	uEEltMeZVZhpL+bioptsTJY1+R07nOg24t5sstD2o3HAiJ/OoPePLZ+1kGOiWdU8rXUki6qQj43
	WlqW5sF6CRUKwx1Fw==
X-Google-Smtp-Source: AGHT+IEHbK363fDMo1psONIan9vwcyFI1uPELAGEFFEvyFahRFVQwOqGY2GTTSyuIC5KiBBMoK3BQA==
X-Received: by 2002:a05:690e:d0e:b0:63f:9cef:d5f4 with SMTP id 956f58d0204a3-6443d9366dcmr3350327d50.36.1764886090168;
        Thu, 04 Dec 2025 14:08:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b77941fsm10044087b3.32.2025.12.04.14.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 14:08:09 -0800 (PST)
Date: Thu, 4 Dec 2025 17:08:00 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [GIT PULL] refs/notes/amlog from git/git
Message-ID: <aTIGQB5dfzz6OAqb@nand.local>
References: <16dd8441-b828-4526-8d21-76ee834b398c@app.fastmail.com>
 <3d396982-8da4-4e30-950b-3034dcc987e5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d396982-8da4-4e30-950b-3034dcc987e5@app.fastmail.com>

On Thu, Dec 04, 2025 at 11:07:45AM +0100, Kristoffer Haugsbakk wrote:
> I see now that all of Taylor’s amlog entries are in `refs/notes/amlog`
> for gitster/git (at 6b6c4b3fb846382a93fc1c94747a90cbe1b5e833). So this
> is irrelevant.

I was extremely confused reading this thread before realizing that the
message this one is in reply to is over a year old! ;-)

Besides my momentary confusion, both git/git and gitster/git (on GitHub)
have their refs/notes/amlog at 6b6c4b3fb846382a93fc1c94747a90cbe1b5e833,
and both are up-to-date.

Thanks,
Taylor
