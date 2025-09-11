Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762D2DC77F
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633647; cv=none; b=cR6OCaqydiO7NlQk4G1W5StuxiugRc/Js5rSYLSnVC6a2wgeUKXwQcJC1UelDsvWNz0QqyANH6AUs3Muh3TOsuFJUQd4N9Rn096v6/3TTReZY9YLgrSAipAnqvVz0XAggeFOif/ORlELRzVw1cpQmyVvpRbGqHS/WMs/r72ejmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633647; c=relaxed/simple;
	bh=SqbE7JmB742aQuHirgFjj15n9/P05b31HOnsQIMQvCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPWRh6P+NdfW22z6f+SovAl6+6K9j9QW/3m3HWWB5xGUt1Ha7viIVHkFCKS4lRhjMR2HIXebvYTIVPIGpeo00xHTVwJ9ObmqB0Mno8RH0WKQ7yCKi2Q/I2GX2Lr9zoB6e43SUwZ0UP60MY36ONEx0O9F8nGUOGuXnSLJ+QpBauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=I+2kspfo; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="I+2kspfo"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6032c696bd6so397381d50.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757633644; x=1758238444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0vNfV+8jNxJ/cp7MXYYeePkSg/CkWIH2vwbKgtNjUQ=;
        b=I+2kspfo7L7lDEHvWTO5k/A01cOSR/DS3ZW9VXrtY4Jwt7fD9h6AJpDXBMPKaBH9ey
         4IEsLy/XoWEhKMKp8fcHA0MT1jddYiAjHw2Ic+Ma7cno5SG6hFUDkqtRjDF5teyOKWas
         /LeOc0rtJ8SYjg3uoxwSWeaI3X3LTzuCbnqYo+CDink30Hbb3ff9MPvyq+/JpomEtBLp
         rAB8abbY+FIe4FrSUiQ+KU6KyF9qpD3YMJ8hAqbMWG5UDvJPfzE1Id/jUykWc18FV486
         uUVPwE+Zi4gcQeY0ZrOOF+6MTLdR/fjlNlvOG4sIUjwNq7bAJ9fQWBtYqhyNIDnr/CqZ
         BEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633644; x=1758238444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0vNfV+8jNxJ/cp7MXYYeePkSg/CkWIH2vwbKgtNjUQ=;
        b=sVH8qf2c2nfARzPJmwSYKj+fADrdODvho15IgtxOa54KHKNFcACZekvEOWVmHI67+o
         sSTkzsREngzu9DP+V2T+14R/QHGfKR2cGLnFiYkGWuQmb//9Pdd9Pegd9vQfMzmROeLX
         26Sg1X9+gBlLNVWBcQ1YeMZf99Nkn+G1s+l7MJLpJS+1rfDcKrAEYhaC4PaAh0wYhVWJ
         cYTiTpPKeDzM7iRnmlAyY554ouWBSZ3D+hB+DiDcTbV84TSr4likNBxQ88MNpLyJJKZI
         9CtGDsaopeqKE8JvmvoPlqLOzPf8Na47crzHzVS8lxGST9FrQMp+6nD/5cIGqgLza4p2
         VwrA==
X-Forwarded-Encrypted: i=1; AJvYcCXbWQzP/J+Kg+7FwRT6G1dgcv71lkJAekUWXQj2118N2x9G6girvDqZxogRIBS1ND7qCGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0zo6VayB3LKYjTqRfnLS3ebg/7KOm0FPQSHminHRZGS1UOdr
	psxARueN0yXnSnD//is7j4hSvqP6/zfGoMXO0+hEeH3fVhk9tf3ocpSnXdAqwrwvV6Z71fIg3e8
	zZGO8
X-Gm-Gg: ASbGncukYopruHJgKWj3J+J3FFHxmgV6+Xn7bGKl8WwFp4dSj4ECtZxFWjFpmByn9Mc
	1Alb1M6IE6D/Rgob+S/AE4sKauq9oN2ZRRzHR92H2owg19Gf2qcnPP4gHnKOhzCWvj4i9RCUJ4O
	sgxAjEzOxUur/fCJhverQ/o/ye+DPzxuAC90eJGA0OSxKO/HnwPTEjKym5mdegB2ZLRWvGi7JOp
	Mu8jA4qdtb/3DdU9+q6+mOaPs4EmG4HKI3t9VlUq8Z8rgSA2wFQR4Fn8pzKqozNuARjmYITfigD
	t8N5jYheBlfjHizr0B3t2H8WgcHEFdXxuURTuL5AETV+BfXE2PJ0TPh74gfjn3ywtwH/QpXCrrM
	+vSk2iMvEO0KNi7kdqnq1pNjYCUaK8pchVf/s0dXqE9oxjoUV+9zbLT1yy3G2JuNZ3+8+rnc9TY
	80zEILKu9KP3rwsNxTQxAP3Ypneg==
X-Google-Smtp-Source: AGHT+IHYp1vjYKAET5f05J0irOZSmItU+f2IbO+aq/DkKGZzzkO8aLzPq95raD1bqsFhqSTWAKJZMg==
X-Received: by 2002:a53:d00b:0:b0:5fa:b7bf:c5ae with SMTP id 956f58d0204a3-6271e19a404mr914352d50.4.1757633644435;
        Thu, 11 Sep 2025 16:34:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-72f76830c64sm7016197b3.19.2025.09.11.16.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:34:03 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:34:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/15] packfile: carve out a new packfile store
Message-ID: <aMNcahyQ7XZ65GvS@nand.local>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
 <xmqq3494lsdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3494lsdz.fsf@gitster.g>

On Tue, Sep 02, 2025 at 09:40:40AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> >   - Rebased on top of master at 6ad8021821 (The fifth batch, 2025-08-29)
> >     with ps/object-store-midx-dedup-info at 13296ac909 (midx: compute
> >     paths via their source, 2025-08-11) merged into it. This fixes
> >     various conflicts with "seen". There's still two conflicts: a
> >     trivial one with jt/de-global-bulk-checkin. And a more complex one
> >     with tb/prepare-midx-pack-cleanup. I don't think it's necessary to
> >     really address the first one, but I'm unsure how to proceed with the
> >     second one given that the patch series still seems to be cooking.
>
> I think the second topic is not really cooking, but is expecting a
> reroll, so I'd say it is perfectly fine to drop it and expect it to
> come back, if it is still relevant, in future, in a shape that is
> friendlier to other topics in 'seen' when it happens.

Agreed.

Thanks,
Taylor
