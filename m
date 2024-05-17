Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080965C
	for <git@vger.kernel.org>; Fri, 17 May 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715977141; cv=none; b=hx/Cqkof0lcMpzFkVYVf+OqXiPPGHaMHszY45B0Hc01qB6p0M50ul3bAwvFszVfqCQuZjrtHMLuTBDy2UJMVzlTVY1UOJ9RzoF+Fae80qkpQz/SoDJYiIhgJbgxVEq1IXdtyqkoCUXk7AJmh8/3SDqXcgH3GYi/n5MhD/sDKP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715977141; c=relaxed/simple;
	bh=sMF6UH5tndChcneJKhGlfU1OrVr4XpWXK+k5JeuMwpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6dVipn8jDWaAaNTMXzFBjCxF4oIT8W/JYEMxrB2dNjMGrrDAl6zhdjOllyVzvm0AfbeGWHAosiN+m90MDcTS+go7EzaoG8jeWbuoNNXWNzHsvg17WblvTZr7HNti7TIWRx2545dMp6gwTz0ok7+cOH8gfDqSIR3Z/akbgmhfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pqg6Img7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pqg6Img7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f05b669b6cso19808105ad.3
        for <git@vger.kernel.org>; Fri, 17 May 2024 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715977139; x=1716581939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVjP39fxCchDIjlJAuFEy/uBhUJ0uqjO+BdtNrHZVIY=;
        b=Pqg6Img7l7+8A5A0e1ukl7sQIYEVI2iPgS69oxfI5T/ZN/RB7lW4IotbLH9k+WrC21
         DntrONVTqCk343yX1hrshfM6WLO097PI9wZRsyRmAhVsRM4eClRedqzFQfzxm/RecfxT
         YfWY9r380G5JgjBQLBBGZxj9z6iPaMNMrG2olAFXYxx4wQanWM9jhKPY2wN6yVJPsb3q
         Zt8DmITPG6IZ44T5/NJn8tMcrZta+nHze7rg/A8ByxPQEfNXE7TvlPI8V1UqeSMCk2G3
         18Ek5YSWm7OFhGTNDTtQfvYyE/XzdR/6WjJp+tbZi6efIeCa5I8+hdQRBb73aiD0bmSj
         bqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715977139; x=1716581939;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVjP39fxCchDIjlJAuFEy/uBhUJ0uqjO+BdtNrHZVIY=;
        b=dYqKOiNzPVTJaEx4m4N9jRqHzHYpJGCUO+n3S9LlMt72+BH46sGv/7iDnFfADUU9J7
         0s2IGkDIRVZUxAHmwkYR9/3gEjfe0hhfzJLpOhEeoRTTS11//YA8YRyK4+QwlugRw2vm
         WBDN/iWJLNJrbLNHOgBgIcL9EXcZxLXU/cSrHFt6CAE8B9Cp3Q5+4GJ8Ts7qTAin+F3g
         t+b3bSKlK/XXKPIl4GgFVLSnuS4f63vde9N4Foj+XpXwsMnhWBdlTs9Hk7d3uSAphEYJ
         qG+PsBR+AAsl7uO+bhj3ac1FrmzD1Dx3cOxv7rD/EE58kO/rc9mgJEPFOWJlCwzply1A
         4sJw==
X-Gm-Message-State: AOJu0YwyVAY/8vYytOFny9cuNeAqnpfsmsxm57kzWv2ed/1LVBG5SsDe
	OxWP3xp59VAurbMUgim3fzvo6rBVC2pzIQVo7MIWN23CeYII6WvcDd3iVIf2KQ==
X-Google-Smtp-Source: AGHT+IE38ofvTHTw7S/T/0h+YbCu5zXCFMrWVtyXi8RBQ3jyeWVOeAVMBhgJgfizRyRKlFG+UPR32A==
X-Received: by 2002:a17:903:184:b0:1e4:24bc:426e with SMTP id d9443c01a7336-1ef43d2eac1mr299082905ad.28.1715977138996;
        Fri, 17 May 2024 13:18:58 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:a727:f495:f5ea:38b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0958d1e3csm49835635ad.191.2024.05.17.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 13:18:58 -0700 (PDT)
Date: Fri, 17 May 2024 13:18:52 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, me@ttaylorr.com, ps@pks.im, 
	emrass@google.com, nasamuffin@google.com
Subject: Re: [PATCH v3] doc: describe the project's decision-making process
Message-ID: <xtndwhhpyizlgnr7aps4t2ly3cr4ivyncvmobf4xtowviq2ft6@l77pen6hlbgr>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, karthik.188@gmail.com, me@ttaylorr.com, 
	ps@pks.im, emrass@google.com, nasamuffin@google.com
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>
 <xmqq4jaxo1qu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4jaxo1qu.fsf@gitster.g>

On 2024.05.16 15:01, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Changes in V3:
> > * Squash in Junio's suggested patch to remove discussion of small-scale
> >   patch series.
> 
> I do not think I deserve Co-authorship for the small changes in the
> remaining document, as my contributions going from v2 to v3 were
> mostly line removal ;-).

All right, switched it to Helped-by :)

> > +Larger Discussions (with patches)
> > +---------------------------------
> 
> Reads well and looks sensible.
> 
> > +Larger Discussions (without patches)
> > +------------------------------------
> > +Occasionally, larger discussions might occur without an associated patch series.
> > +These might be very large-scale technical decisions that are beyond the scope of
> > +...
> 
> I do not know how strongly assertive you wanted to be, but I suspect
> that it will read better with "might" -> "may".

Fixed here and in the next line.

> > ...
> > +For larger discussions without a patch series or other concrete implementation,
> > +it may be hard to judge when consensus has been reached, as there are not any
> > +official guidelines. If discussion stalls at this point, it may be helpful to
> > +restart discussion with an RFC patch series or other specific implementation
> > +that can be more easily debated.
> 
> It is a bit fuzzy what "other specific implementation" wants to
> convey.  A mere "RFC" is often an unfinished work-in-progress, and
> if the "other specific implementation" is different from it, then
> what it would be?  A minimum viable product?  A proof-of-concept?

Ack, will reword this.

> 
> All other parts did read very well.
> 
> Not that the above was unreadable, but just my reading hiccupped at
> around "other specific implementation".
> 
> Thanks.
