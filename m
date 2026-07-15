Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC8338910
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139790; cv=none; b=Y2GZZgFoI+snzL11uw7OFdKv17DIDqD7hYGA+X1WRMWw1RnvF9IvEOV+2SGEbJvik2gqVkRRglimU8CAwsIjJi+saYPKZbJuFenHxpnMTwBN5tBUstYyviWEUJGLz+CTjt+cH/IojTDZ9LGBkFvyZRwfF/fJMhlz5zQjNzrAbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139790; c=relaxed/simple;
	bh=vnVqhkieDBBAyrHJwZKLOGtgv6Bd1pZyJufzfjgSHIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fo8rQqMsesXaY4I+/Q1k+R8BNppM34WZYOC36TZrnvRQSLM8Cav4KQnmjhCLYtWUv7ye6R9EkCqJH6niQYV1qiyEh2yj2qxbZ71ikXJ86O0C/rU1OuNNZeeFUORKa5wyZn8Bs3HSnKLY2w/q3Mtb81+JfOMaqS7ZVuLfdWAbM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vdD3pNCR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4DuITke; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vdD3pNCR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4DuITke"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E01C7A00E9;
	Wed, 15 Jul 2026 14:23:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 15 Jul 2026 14:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784139784; x=1784226184; bh=3NejAwuuyt
	hRo9pDjRdlLq3dFDwwGR5tky6xx0MNWGM=; b=vdD3pNCRt1vudKm1R3TCGicmie
	vNR+TtdXYuobmkfwS/SHleVr/S00Oc7i/sa2o+DnUgv4fes4JVCp/WZGOcVRJxc2
	LELHEMWYFh3YGQ/0UobZe2E25NhMZY+WptwGdHacSoRC3sgyEiDY4R145cEqDxwT
	FhGvZtAY18MEktgKDTm1Jo3DN40pJzXyNW02H/AgozMGVmUaZz2LO1fI/B66GaSi
	MsIhV96udMvVrPdG88ynqpXECmkNdwUKShdhIgpabHcFU2s+sPUbaSd+oim9zg8U
	maCkecofJ66eQu0Wam349T90dxpfhVvnApaQp8cZeYpc6ntHLW//eyKqA6SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784139784; x=1784226184; bh=3NejAwuuythRo9pDjRdlLq3dFDwwGR5tky6
	xx0MNWGM=; b=R4DuITkeWPC4LQENKzkXAZ/PxetJq2N1N/vMiVO54ePk1HhsXBS
	otYluwhZ7+8OawQNaALN5OfgQiu4PqSVxBFtDoaygxbOo3LWPV3gxZwE4kAuWqtJ
	V2SSrB44ZLTovJCJ4+8JyZlAtsreGSrEi8Exp3ZSAylzt8G13xWjxwOALLFEreyj
	N4Ywts2GIAoR8PoeeC5Bxoi295s/YzASOgWyfQ8mPQCo+f9YD6CAqPrQtQC8Gp3c
	L5+YIeBuy2qZ8lNIpI7XEeS8rQ8X6/k0TRJ+AA6BFFV7Y+q0XUibvvmIcU9aEem6
	NueEjuD6hWBASp2I+3q1NTmxuxAvTqxtGnQ==
X-ME-Sender: <xms:CNBXatAezx9142Ycyc3BwDDo7vagDoRM9hHVyVQP2ZyDkUrjVQ4UYQ>
    <xme:CNBXaqn5B_c7WFgPCr4e7Yk3HPY32UB07UfRIHvrmSnL7dwMIQsWa_ovYk0B0qY-1
    3e_DGVzvgZZUMitPOTimYjilQMeZJkOWh326Kk5hp44SY7LwsD-ra8>
X-ME-Received: <xmr:CNBXauzgC6JcvuUX6Px7i-3MsTQ4VfHxEMDzQA15oc1yAs6BByAZSVfk8G5erLoztxq6j7EoEi1GhHnDSvJNZ2VzceOvFQgdN9yCQUo>
X-ME-Proxy-Cause: dmFkZTFsP61AI9Zqqf7gRrkLcPc6HL9UXnaZtmOF0gd/3Q/9/iNqFdSW71zp+sUEPBYLRl
    VeZG3enPQdpicVpqmUxerr0+ByuDIQSbMP5qDc9RkO8TdkJqb5RVIuR8vk4BPcLLr2oswq
    iXA//+KnZ5ZaQzBbRfaE23ELYA6AX6g9AlLLTiBTF+aLdt7+eiLD0rurvTtPugML0Z278Q
    ughiJroFGA1wZQHts31co3reJ2oRfX1nMJBRYoAyJbeOJ+Oj+2iLWeVBg7mzfPdIrWsopL
    TTDDYlE6RLDQgQYPvjSxq8LdLhBKJs8Hg+2mdCIxki9GGAILcLBUsY1b9u98xNnBJBFvRu
    UbYBvqKITw84lw9E+o9fkWqJ42ECQp7yc4u2lhXfztMvSracOzWrvuk9yOc7KPVi0pywDD
    4Pfk1wulHDQco/2Bw/Ntoog4jCdcvgvj5AWj0CzyRifq5N0CHeq6N/nvxQsOy97UuXRF4u
    pOpmPwukjjV4lVnNXIzvmEJA+4exOwyHYhtROmtQXiY1h/XtzUydNTtOtm36Yf/7oPtFIu
    wdM6DNuy0InLuonhd6+9wHrDnlGlikzaWLBx6JQnFh1CsxwGlFqhAW2+SFbODGRZlHVASG
    hE3tGfy+ubCQOFB1fk8vGJ0emRYRkXbpQs8K/Cww9Mpr2SIcmCeCaFPoEpMg
X-ME-Proxy: <xmx:CNBXakTqmyHnnguc9KfMq7o4lnYCcKyJNGILjDV_xgTsJAb9FYL-gg>
    <xmx:CNBXam9lyno2_F9I6ReR7tHnyphXVjywxC8aYg34AS-YO0k9DFX02w>
    <xmx:CNBXaivoWsS67ePfC-cGG9Rg0zb2VfhAKEshLW122pOEMSy7kGmMaA>
    <xmx:CNBXauPMshtk7lo_RcOG-zFiK1r1bmMdPijh_U-qEhEOEqmYsn4elA>
    <xmx:CNBXaqsbaQhykahffr-fUH3x0HIOWkdb8nYpPOENfdteebvnJz7DehFY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 14:23:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  cirnovskyv@gmail.com,  Christian
 Couder <christian.couder@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v5 4/4] environment: move has_symlinks into
 repo_config_values
In-Reply-To: <20260715035501.48271-5-cat@malon.dev> (Tian Yuchen's message of
	"Wed, 15 Jul 2026 11:55:01 +0800")
References: <20260619162105.648495-1-cat@malon.dev>
	<20260715035501.48271-1-cat@malon.dev>
	<20260715035501.48271-5-cat@malon.dev>
Date: Wed, 15 Jul 2026 11:23:02 -0700
Message-ID: <xmqqwluwm7sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Note:
> To support early platform-specific (MinGW) overrides
> before repository initialization, a global variable
> 'default_has_symlinks' fallback is introduced as a fallback
> in environment.h. The *writer* in compat/mingw.c can only
> access this variable.

This may invite people to abuse the global variable.  I wonder if we
want to do something similar to how we handle is_dir_sep() and
friends instead.

The idea is to have something like this in the generic header:

        #ifndef platform_has_symlinks
        #define platform_has_symlinks() 1
        #endif

And then allow selected platforms override it:

        /* in compat/mingw.h */
        #define platform_has_symlinks() mingw_platform_has_symlinks()
        extern int mingw_platform_has_symlinks(void);

        /* in compat/mingw.c */
        int mingw_platform_has_symlinks(void)
        {
                if (!(tmp = getenv("MSYS")) || !strstr(tmp, "winsymlinks:nativestrict"))
                        return 0;
                else
                        return 1;
        }

This keeps the namespace clean and avoids exposing a mutable state
variable that others might be tempted to meddle with.
