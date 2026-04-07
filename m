Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5E37C936
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598733; cv=none; b=VjrcEkYneIVhgZ1xb4gOrQRtQHJPdru2d5IomIQ2Xiw49zjpuhVrazE4cUHNeV/J6ei40LBC/zJ0bseNleZ95FSK5UU8+k8kFC2a4AsVZmqozWa3wevENk2NMCiNVtOU5rw+Uxwnsmc6O0u81+1iddUMMKQa6O4/zJ2BYj8Sx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598733; c=relaxed/simple;
	bh=VBUVOcLoHzWh+YIXYupbLVyUvupgmkE5l0vGL2o9qQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkVSjG7An5pR1Ox4yMtj5skzxeRLTGNdN/bx0edSjHHxiIrNLAre0rQ4fgBbD9ucCEBt+Ko2BplZBWd7LOH5W+UQsz1VbPntXVOqmBQ1Hed4LHi0vJaO0VcqWl3L5D7fvIE5A4JXHnTVSCdye+ZfXgD6Yp0tHFtWSAyfvvpy+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tI71PVQ9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI71PVQ9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so26611885e9.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775598730; x=1776203530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdMGB8t47+/+KLbyHlStVUBdo+k4OL68aEG4uOPN1Uk=;
        b=tI71PVQ9K9A2rQGkSItqUGhByzWcqQU2rpeBsmL12u1ckNdfKMYhfY4iAhiVVQuSAv
         WxRcUsEBxyM5BD0YfxayUZvb/LqDuKTDeQ89Bo4vzkY5mrFFPtI4v3y/vgCG4ToayMsy
         kLoN6V9svSk/vJz9S2YyP+oXm1/J4xrKqh7fbzi5cbN7n2ysmHz379uC5eW/DN4Qk8fg
         utJZ10t7qO8WUiRByxZ/v1dlqOMWSNhNdqF8AyvHphu4wGjeJI91lwr5ubW2dN75qIGo
         3bgg+ETNAmWnDYtFtYk4EsBueo6kW/KJsG4plyXLNmGs6yoqnvuKKqQ7IYKIAK6KNn3x
         E5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598730; x=1776203530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdMGB8t47+/+KLbyHlStVUBdo+k4OL68aEG4uOPN1Uk=;
        b=HCHVhJ8VGzrQEtZU4rJ3WlF3rXTDD8L+z+YxwpcZH23+nac+E7pU2kIDqtuX5eXS6P
         MScFjRxWv0Maix2dZP6vno8XqBSFSW5Y9nRAvwX8XzCTNv2gqka2kKQEtKKhCp2WL29n
         u1XvUgPFQRSqkd3bAwcvBoK7JG3CvWWEzmcxuZKypPJRZ48YEEiOJ1P06S2+EwA6OIh6
         COZj58xy3yiD921+VwgoAVheWrd7OPOHviDci70z5QnK7sD0v3GnIPCeeezLuEjlgf5o
         drCzZ4Mn5dOECHq8MNt12e0pRanTAmuApMBB0dAMxihitIwUnhuftjuu+8oYLSlZih58
         zZZA==
X-Forwarded-Encrypted: i=1; AJvYcCVliFz/pkl+UNN9SsD6x4yXk9dP88PrAgjFsd4cuyOrtr98MCmULm+CKcZf5fMsUa+ArKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9APSpNmlUmXOsLa3RedGPQvxH2Kg6XV+SL/UNhdoSU8Rh2K1
	PEclA8KzTEktg9PA8JTemK4yb95eUMmVx6/XSo+Bm785xXGFUe7BnX5p
X-Gm-Gg: AeBDieuSi5qEUbSjPugD8fhrFRl0Tc1FXcdv6WJyBaTACoxRHWYfNuEmiAEIxCZImSA
	XhY+hAqjjRN+BwxF/X/jLDsBZ7PgVwmxhtoJvyCNIKTNZJjV2K5y0xiPkDPPgBVGDBVOnRLP0lY
	Q+JwwI+cuNJJUm1S2PvyVybNlb5A1RaIvfcETtZZtoy5fOS+PtL24bjhsGqBYP2Zb+1RrpITZtU
	IE1Ov1XprBVqIyz1plAZdLLx9qgTeH+H5NkVO+4O3YAxmQm/OQfFxAsl0Ddjnm8es0iKgWD31iJ
	KTc23oubgUll59Ysjat9PovP8y7XZ9HSyTSOR31fpJvfScgE7BNDd09WNvybi6JS1Il0+xcA694
	Pv8Am4zgWD9eWdkf2VFA8lv/FOVzaGtWWQwxw/NzuI/+WaclQFbiBdp6+LQRcaV07j/ecjFSipd
	jh7OUjZUBGqQ/ABAveL8M5AWnAyPWJ/Pp/
X-Received: by 2002:a05:600c:6216:b0:488:b9c6:11ba with SMTP id 5b1f17b1804b1-488b9c6139amr76827505e9.28.1775598730423;
        Tue, 07 Apr 2026 14:52:10 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm52241381f8f.31.2026.04.07.14.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:52:10 -0700 (PDT)
Date: Tue, 7 Apr 2026 23:52:08 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor file
 after repack
Message-ID: <adV8iP668rgxK-9k@lorenzo-VM>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>
 <adP-MYYSmElK9wL3@lorenzo-VM>
 <xmqqy0iz7clt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0iz7clt.fsf@gitster.g>

On Mon, Apr 06, 2026 at 07:01:18PM -0700, Junio C Hamano wrote:
> Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com> writes:
> > On Tue, Apr 07, 2026 at 01:22:16AM +0800, Tian Yuchen wrote:
> >> On 4/6/26 08:24, LorenzoPegorari wrote:
> >> > +
> >> > +			/* If <time> doesn't exist, retrieve it and add it to line */
> >> > +			if (!parts[2]) {
> >> > +				struct tm tm;
> >> > +				localtime_r(&source_stat.st_mtim.tv_sec, &tm),
> >> 
> >> Typo.
> >
> > Ack.
> 
> Not just an unintended use of comma operator, this is not portable
> and breaks OSX build
> 
>   https://github.com/git/git/actions/runs/24058681172/job/70170218891#step:4:213

Yeah, I was shocked that it compiled at all on my system with no issue
whatsoever.

> >> > +				strbuf_addch(&line, ' ');
> >> > +				strbuf_addftime(&line, "%Y/%m/%d-%H:%M:%S", &tm, 0, 0);
> 
> I suspect that storing seconds since epoch as a large integer would
> be simpler and much less error prone than storing localtime in
> textual form without even recording the timezone.

Yeah, maybe for this kinda specific debugging info being less error
prone is more important then "looking good". Will do that.

Thanks,
Lorenzo
