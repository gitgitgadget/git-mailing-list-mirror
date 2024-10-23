Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F14A3E
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709159; cv=none; b=QyyvrZURqdIG+loqN+LqbenCYiEr4uuq0ojeQb/ONDD6zw7is9Pp56j82bAbtkQZHbEaiMnr91M1aszIbFqllewXVGJf8SZgeebrf7OZ784ET+vEG/1GyBZqcGouROUmdSFiyR4glIndikQFEbwbCFQllIKWheAjvz+gCFI4mKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709159; c=relaxed/simple;
	bh=ULyfvdh8Zg/Rh/QH2ZifjQqFZxvP+flJs71IcOYGq/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om+C1aD90Znv7Q7GBpPzK3R72y1lTj0veM90LYlP+Z1tuZs+cTEs2dkn9/oj1XqIl2+pishww9aBDprCDKETLpWwtjgw6G8JjSkZFKfrHwsAXFQU6edVh18W/t8vWFBsPVL77+ayPxWGZjIusfqY3RWJGiO01OqDkbRPb1JPUJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yYC1/agI; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yYC1/agI"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2e32bc454fso125048276.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729709156; x=1730313956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULyfvdh8Zg/Rh/QH2ZifjQqFZxvP+flJs71IcOYGq/Q=;
        b=yYC1/agItCYH2GKlT0PK6WeD9ObdlshFVz14y9wT/WFPal+oFXQBHTH5yvQtsd59Ay
         kgsGFes4c3AIBSP0BHEk9c0aO7CC+EtFB2JHsxSMx6uPWKt6NhbrqQIbPZKYrlpNaWSo
         ieyW7VlyISRSwjYQ0LRnAWk1uxmxbtCkaEiufFTY7eCKUV07Tt3CcOmqbQWxc8QA/CL6
         d4JhI76eldGyUd2j8KIZ5zEdY1lyocZ3TVelvA5M45NXVqqw8T+WgGbWLndhNB9EthAW
         eCR1hypzr6nOH7lDj4K1Q/JXw3g31d0E+OwDhNReEXk+9CHl6oLAYUuGml7W/s6B9/1j
         wMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709156; x=1730313956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULyfvdh8Zg/Rh/QH2ZifjQqFZxvP+flJs71IcOYGq/Q=;
        b=VMkoyjwxojsHOkrDI/mK5JeHa99J5fZy9Ma7ZLYb/g5zV8NRsM3bdueNgrgRn3qNZG
         f7M/arjKttETJHDU7pTrjdYe1WxNHBog2xlt4RVEQfZYuot7yM2q1ApvWuCn4zSTxPrr
         WsV6VMhl7FLENxOZAwdnmLmnDFZDd0hSZ57Xv+hZGrymYVB8yKDonZh6Xh2lGu16AQJi
         9T/3d/mVa6kU/fkDB466CVrvg/SuflR3/xyTWYbYnBYH31VjmQtvHbI8mizk+uKJvjxm
         I5vl9gjFjwxx1ChLmlYzowUnijJVsVMoVb8pTPpNaJS/FJx7nEQSw5QLwNVIIgfFbT1r
         0fAg==
X-Forwarded-Encrypted: i=1; AJvYcCWyt5hsMHDiU2ImInVOG0UihW+lYN2jnVduGCl3gX/ibCQKIn9dR/6I0ir4XNzm00M9gbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4Yl6n6bxjogaYp0k4ZCKIBcaYpKzWYmzAYoFYPc8zDXR+bJb
	oial1jvj8bp6VLpu/TCVJkYhmcd7P8nzuYYPZpQBETKCy2SLRd2ud13wsPUexVmsBjSBnFMabEK
	biP4=
X-Google-Smtp-Source: AGHT+IHDJzoeOyAxbkhjQHWGlf2XDLC/Sw/OVsbS6pGqMRr8Z4aUwtIqwNResQy0YQNbW3I62Oqf2A==
X-Received: by 2002:a25:accd:0:b0:e2e:3210:da34 with SMTP id 3f1490d57ef6-e2e3a632fd6mr3024762276.20.1729709156481;
        Wed, 23 Oct 2024 11:45:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcb049ebsm1642754276.65.2024.10.23.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:45:55 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:45:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 1/8] t/t5505-remote: set default branch to main
Message-ID: <ZxlEYm3zb5K+gksy@nand.local>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241022194710.3743691-2-bence@ferdinandy.com>
 <79c9cd6d-7bcc-4014-91c0-149505f70136@app.fastmail.com>
 <D52LZ1W0FH29.1GVLRMGN80HPB@ferdinandy.com>
 <ZxkRq3GNbrO1cqw3@nand.local>
 <D53ANCP0WMJF.2PG371ZJS1F95@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D53ANCP0WMJF.2PG371ZJS1F95@ferdinandy.com>

On Wed, Oct 23, 2024 at 05:34:23PM +0200, Bence Ferdinandy wrote:
> > Alternatively, you could set it in your copy of git.git's own
> > configuration in $GIT_DIR/config, so that it doesn't apply to work you
> > do outside of that repository.
> >
> > Either way, I'm going to avoid queueing this round since it is missing
> > the required Signed-off-by line.
>
> In that case I'll send a v12 with the S-o-b so the series can get back into
> circulation.

Thanks, will queue.

Thanks,
Taylor
