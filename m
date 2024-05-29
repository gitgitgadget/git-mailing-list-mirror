Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C9169ADC
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022178; cv=none; b=nbkVpdr85whyKSygljV0ej3Du0TVsdimd8T3yAZytfPb3d+HGutV6c4zFlO9ahThKvidgtY3AAvOPcagEjc6z0crNlerwi1x3E7Gj9kOrgAE8XKFU7kPG0I7ahJUCKiyJ+elkS+sbb2LCPBsMYTtaAixNcfxPvHibIpI3c6SINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022178; c=relaxed/simple;
	bh=5OIQ78XnmiV24wcZz0InKQxKUqzNZ8e3hv52CiQGSWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4mKbYCJD0XGj1jEn55UGSRRPBvGLbBedgdusF0Q5GYNm38RnpFbCank/YR9ZiyT+49MYMKB06Ed0wW2TBJ2TyOCGx5M6+hdnHL/1rx3wA9DH0+ioKJ0Ar0Fqqhw119J7ImszSMyeuPeoAvkVVyWm+/mpQqc4alLXFipOWoWcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iQFNfxoy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iQFNfxoy"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-794ac6b5409so21469385a.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717022176; x=1717626976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OIQ78XnmiV24wcZz0InKQxKUqzNZ8e3hv52CiQGSWY=;
        b=iQFNfxoypt8g6EoEydkKPZvZeflinTjeXHFg6FfUZQgYVLQ0wa7N7r3wJVXmVorwmi
         lCePrmxv0t2bQBaSxtJxG8Rnccm98itVhsYrjPAB0YHNy4TdpRf7sM68VRvEqBM4Wo29
         aqE5ZQd7yFGShGuq/mK3GDfXxeV+YdOdVG611FuWQm+fj5SeQx6e8VQq+SiQhO9PJMzQ
         XLCD9tUiLwXdaH4PQZku9AO9LS+DTiOJKGTj0end2l7s0MeUrAdqlDJNKmBDa0evciW0
         s6HaF2Iq6g23fnRzvQmsBkeocAVeg1WV/TvtAAZC9nbuUCSdjNaCkjS26WSqE3EL/8z9
         s9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022176; x=1717626976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OIQ78XnmiV24wcZz0InKQxKUqzNZ8e3hv52CiQGSWY=;
        b=X5XJAOW7kMJ600j5YMGIsw4CVirDM9nM/yJdUBZNWhEeyn6jfjBNBC9Z8yoAcAd42d
         tlTW+QzoLEOv8H2CyOyVPu544fjEgoenaeZ/bD8O+LNaWh4ud//yjUTpdllZjy/ZuLO9
         bYoeM0ViPPm+w/WXIkupghSretzsPjqLnSnhw93RYvM+HVuo68lxit4fVbCD2TvgmM3A
         8SmI9Zl/BFT7pj0g3MvPBwiu+GjAbPs/U+PBRmm0KNp7fkFoxQD4wHz1HyqKBPksd+y9
         KhB3DzcCdqfoKUxk0hrtJPEVV1b6bUTclx2szqBdeLy8jxcyoTzLeRGmU5i5Z8v5QpQz
         Cifg==
X-Gm-Message-State: AOJu0Yz8b0xFXrfRZr7+Y2CTNYsHXoZHcrWvnyY00ZVo7sMKc15lzWmw
	aBydRprbFNGvKTE7wUgPCnkZpwlxiWhcESsaxEaA50qrYO1SEDaPDLYWFHyVR8k=
X-Google-Smtp-Source: AGHT+IHgGJ3VjGeaE1vpQhInN+WmV8D3Ao03PqJ3aZ7nuRwoSl1u6Ips+kpZmgmMu/fb+Zyi4VjgaQ==
X-Received: by 2002:a05:620a:5e0e:b0:792:d1d2:e07c with SMTP id af79cd13be357-794e9e3879dmr53145485a.68.1717022176063;
        Wed, 29 May 2024 15:36:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fc319f88dsm42390271cf.54.2024.05.29.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:36:15 -0700 (PDT)
Date: Wed, 29 May 2024 18:36:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] midx-write.c: pass `start_pack` to
 `get_sorted_entries()`
Message-ID: <Zlet3mhO+tLT4yj8@nand.local>
References: <cover.1716482279.git.me@ttaylorr.com>
 <7acf4557dcb2240cb43eadebfd21b5c37515ba7f.1716482279.git.me@ttaylorr.com>
 <Zlbdsz5VSlX89HfH@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zlbdsz5VSlX89HfH@tanuki>

On Wed, May 29, 2024 at 09:48:03AM +0200, Patrick Steinhardt wrote:
> Will we always want to skip packs from the start of the array? Or may it
> happen that we want to skip packs in the middle of it? It's a bit hard
> to judge because there isn't a ton of context when exactly we'll want to
> skip, and why.

It's always from the start of the array, but I'll add some more context
into the patch message as to why this is.

Thanks,
Taylor
