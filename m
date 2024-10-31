Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047D1E481
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414033; cv=none; b=VB62NcDY4RQhDHjxN9jetsUPrK3UzsPBfiu3868JnqpVa04A4xq8c71kxv0ouU1Edo8IK9SiywTWsRs1KcTQ/YsSEN1MSrT6NGf7or0yOnB5OB3fV8V4k8V7eMTgYuW4Ki1+XrKRSjyZA6+i24r644TFHo9Tjz3BPWD7ASh/5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414033; c=relaxed/simple;
	bh=1ziJAorBZIi2z0GTz6m5xurqSJjRodcnO5/Nhk5v7XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFSu433Njm96LWy9ny2G06oTyJvDTLw1gHExkAJgf60vy7EYtWvMvdFABxnTJj1vmdt+cTImHxLRvQVqKeUH2/XVJYWp3IjhLi7lQfwrDfWIxGT2S2YQw/39NPivoY27cbfEoiy9zR4ajX1gfB2A0GMTfru9nx27Z6yGDg2YKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqcMCjA2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqcMCjA2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c87b0332cso30255ad.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414027; x=1731018827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+LzBitw+9xCtzFVupjJbNwKH+K9XmVUCmvlKNeF820=;
        b=MqcMCjA2FroJ4slW9oFuUHewynUcpkA4kE8wLOGQXDvyZJXyj0/0ErRle3CV/Frs22
         VJy7zNWPGPzf7MAQ5AsJw41MtOA4lrW85XDy1kfo9qwz3yKCvF/YzrW1PsAqwZbhIjxQ
         f3aQtB5QLpN0Nsj9A5CgucTKgeE//9Tr8wTTWjqS/89q+Wd2FZCm8sfCnVygZykRrYYb
         IOG4sHPUJKz7nvm1vQeQ6qwRTc/G+JDwdggDLJDrWYgariNCxBBQRBUj1IGDNPZj942b
         pGch2jcwDUtcPGnVD39J0LY+JFI2RE52l48DwrRJvD2ZrKv+YsA4OxxNPgBLgNAzJJhd
         /v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414027; x=1731018827;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+LzBitw+9xCtzFVupjJbNwKH+K9XmVUCmvlKNeF820=;
        b=Hc5EF6iU7CzDe5kYqba1TuXUEUxTeOr9FNT+6BTip26EMTVepj6H591qUoak3+PKnq
         Zk0aYd5L2hCy5B7T6/rMjY8DIv4JKGD4BUwa6Y/D1ZmG8RfTLjJPF8uIsiMXzNs/fPN+
         dHqmiyLvbF6C9qgucLrM4GjbP/f8qws4mUkPz9UG8XDq4j8GfBD0epLYywHW+4C5qpC8
         0Zipy7/5J2ZWr42yLptGHVXodly/BA5St8cmsLEaBEzSonYXrXo+rslM+H1gTdTYtkST
         vY8sjhl18HMg7nMOfJEoNr/QPolkP/PoCStGDDIeQI32LwS4WK+lW/JVomH6SK96RFgj
         uClA==
X-Gm-Message-State: AOJu0YygBS4/w6QA6MlOW3yx6yuIC5557nRve/XNhI1VxJIr0bwUrYcv
	3XEdSV8KZ51H/2PrxHULZ6LOK67kyiakQ1YCNYY7AGxWEej10ue0r+0WERc0Rg==
X-Gm-Gg: ASbGncu0eBfBxzsPTnVTGZlhOK1FtJ1hlGR/wtmr9d432lSR2P53jozjVfNwn7BlirN
	zK2HJTEIP46xtKdbyh/d44JPJUSI1fou2U3UQFax4sCvsFFmLSaD5d2O6syOc8nUIBnFBWgxH/j
	R5V4CqY19BsGJiXGnmOnaWPMp7U5vymA8GRA36douH9Yhlg0tVg2+6Cxj+KPMkoWb/AI8OAkcu5
	Y5IGcWbbY/KnEIRyjP6IcGZWsX+wtVBUpLl6J59XDi0zJZW
X-Google-Smtp-Source: AGHT+IHIRYk2vHYVN5GWd0oqSJDSJnTwvCxXmO/j2OZMqewauyDnlAtX1gPG8t6etVxGSxnO6+d7rg==
X-Received: by 2002:a17:903:2348:b0:20b:6c3c:d495 with SMTP id d9443c01a7336-21105636e6bmr3115005ad.25.1730414026569;
        Thu, 31 Oct 2024 15:33:46 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:abe2:ab2a:94be:7b53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1eb1a0sm1618768b3a.67.2024.10.31.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:33:45 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:33:41 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, hanxin.hx@bytedance.com
Subject: Re: [PATCH v2 0/2] When fetching, die if in commit graph but not obj
 db
Message-ID: <sbfnqtf5phdstpfrsahxiz5orzhgblflvghyni462aew4n7pe2@74cnj2vjuby3>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, me@ttaylorr.com, hanxin.hx@bytedance.com
References: <cover.1730235646.git.jonathantanmy@google.com>
 <cover.1730409376.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730409376.git.jonathantanmy@google.com>

On 2024.10.31 14:18, Jonathan Tan wrote:
> Thanks everyone for your review comments. I've updated the patch 1
> commit message as Josh requested. I'll reply individually to comments on
> patch 2.
> 
> Jonathan Tan (2):
>   Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
>   fetch-pack: warn if in commit graph but not obj db
> 
>  fetch-pack.c                               | 42 +++++++++++-----------
>  t/t5330-no-lazy-fetch-with-commit-graph.sh |  2 +-
>  2 files changed, 23 insertions(+), 21 deletions(-)

This version looks good to me, thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>
