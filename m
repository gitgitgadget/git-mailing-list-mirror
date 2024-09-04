Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4551E6DC1
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478120; cv=none; b=deuzsPWvoq9zYVGPsFtUezihd5S0fQCI4RQzoehmKFTc4+CqJehiLRoPMZqHKXMNQXm220rYex88G5/CksIwAUNNBpZ8JjK4XFviUPsWFTdxkJZtdOnJnT3n38fbNNu7KMP07bwy61ejBPpwYCxusil39GuKgbkeBcHE3ApcUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478120; c=relaxed/simple;
	bh=Y5PISd3768koAGO2zPiMs1AnAN2lcqxdDLV6w3mEpGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQNLgj5xr+ykFuZizNzPv7txHrD8iyBVcyBi7DM8XXcRyOvQxcEpOVYk9f/2aS9m7v/31BraVsVHqv2vvvbFsBZQk/1fjxClcjmjubcXq+fW46EO3Wd9SPLpMMGZ/4rhG7LQ6vw/m+5tFZg9a3El4BSeWCAzcrybnsy2t/oeqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CCk4w5gO; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CCk4w5gO"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4fcf4ae95dbso5058e0c.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725478117; x=1726082917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5PISd3768koAGO2zPiMs1AnAN2lcqxdDLV6w3mEpGU=;
        b=CCk4w5gOGzuYZQhJukFQVwK5XIEipXvQ32KxLVjicQSpjxK6/x+Ul1P1cb/nY2EKS0
         k6JaWcx7tnVjk7QvHVXbuy4PSla+u4WYFWhpbGN75kSnWbTDCat335MpPRaIxPmWbl/S
         86LDpJ6tjQjcwQls7nJ1YOHJxkZ7urQ609efKhmE+5LZ9AFyJd2MgQBp7Y6lZjpYzbbr
         2TNLiHkgwc8B25qke5YWwgoexvKWHzOleQPehYIeqIqizfZIRLPUC9lryQ88sf0L+6ey
         dloFzchqsRa0tUZl+ncrgRHaxIQ5xfZ5wn5QW0W3QE9MhruHMF1sMAVkUWHJOJzzP/NS
         0Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478117; x=1726082917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5PISd3768koAGO2zPiMs1AnAN2lcqxdDLV6w3mEpGU=;
        b=vkZ05sWZa6y0DuWzspmaH6YmtOcmd7q1hr33G9kCmf+2AwLRbWujnR6SQCK33FyBAE
         0jpnxztEDz0mCQMwEnoo4QC4OvX8vs7eqxhL6nm3GFBoTA8TbgmX5T674CN10JPhnZt/
         g2P0THVCsXr88IKRzi28srANGSk78bdlxOxjbxjyejCbFGx5eioI7lqHSafHdgKmYP3m
         rtw7qc1D8ssxiy/pgCgaaY0JKCEECpgLHmKMh93hhqrI7EVcDenSxNplBEeGnmJ/aF6S
         VQ5vXg56YNDilZxCNYgnOzDMZLVqwza9waTYtZJ7WRECKt8K+opA9HRjuwC79iyoQO5D
         IK7w==
X-Gm-Message-State: AOJu0YwGiOg2oGBU5kynK0qQTzs0tiRhgL1Ky21YqQnlEw0AAhdWkNwE
	hko7aD28vYCJ3wVKMnLZq+61gV4jY2ul2ViyBi6ZcmjPAsml9xliglQZXNUmed08ajvSDX8M+5V
	H8rs=
X-Google-Smtp-Source: AGHT+IGKrr6EzD0rSMAcBNr+X7UkFvo5/7wc+BRCCToksrpqSjM380YBRbQ2GYH+XF4c3RU0dp5okw==
X-Received: by 2002:a05:6122:3187:b0:500:fb0e:afec with SMTP id 71dfb90a1353d-500fb0eb044mr2966852e0c.12.1725478117610;
        Wed, 04 Sep 2024 12:28:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef24f46sm11251885a.10.2024.09.04.12.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:28:37 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:28:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] pack-objects: brown-paper-bag fixes for multi-pack
 reuse
Message-ID: <Zti04yZXGiCGJBKo@nand.local>
References: <cover.1724793201.git.me@ttaylorr.com>
 <xmqqv7zb8cys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7zb8cys.fsf@gitster.g>

On Wed, Sep 04, 2024 at 11:56:27AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This series fixes a couple of issues (some cosmetic, others less so) in
> > multi-pack reuse noticed when rolling this out over a few real-world,
> > internal repositories on GitHub's servers.
>
> I cannot claim I got all the detail that went into steps 2 & 3
> right, but I was irritated enough that the topic was left in the
> "Needs review" state, so I gave a look at the tail end of the
> series, and they were pleasant read.

Thanks. They were anything *but* a pleasant debugging session, but I'm
glad that the end result was palatable ;-).

Thanks,
Taylor
