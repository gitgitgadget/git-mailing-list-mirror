Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EB342539
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206687; cv=none; b=K3ycmsintSulzp1Gs9oXFWJc1ScAE11akr2DfZ46qRUKK2gnnJER4EL6ctFAbYcIbe904o9S1A2R8x+zLkxH3ln6SLclzc7uXFm1B6WOrUpW9rzhbNJ9rmbyIqFNRhzfydoqAJRtW/TYrZ3Ukqn/fANIGXNohA17yAiwjAO/Tgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206687; c=relaxed/simple;
	bh=Upf0FybEXEj1jbbA7wR3dldBKmJHp8DGlZ+8XdgEoC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEPB8BQ52jdx36SAe+48d/dteeSUlRKqGSvZZhnv4a4IlnSHnZvUqAnrHXTO4NEzgPGp5FbK1ktaqfJfuLiO6ZvP68DRTDh0Oq1UVuEU8DLYRL4HPaYdXp/km4eL+JzYrPd0R1AqSbB+2GsoFV5z8/6p/0Sx/RK4NhuVud7Nl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxXG+nmr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxXG+nmr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so722330a12.2
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786206684; x=1786811484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/S4ZfMkZNM8X4M2kCeMXOTPfDUbLKrBPzPbwT+05XYE=;
        b=QxXG+nmruv+QsB/vaVA0x8uFPFcvYEzbiqGPDqcniFWVP8/leIvBgTTMpZCu3cGrc5
         fbVQzeplCV74/kTlgFHuuxLxIJoD9E438HLJCRiWcGU2NcUfBdKgjrt2/BltU9LgxLgk
         2v8ZgBLBqIV2H6/IVWdZMiX+DcmMBeRfc3OVeT9odLtI4NvsHP/Dv7khP2TBpHi1JRsw
         wW6eyQDatR5dqNorzCO+inSYl5g7veArrV7WuQ6ZtaZ9WsWVrp1D4HQjh8sQ0HE8kWx7
         bnmOBgQtSING80eJOisc4Nsht4Lv3OHZO1//sO7lerKulOsWXW+9ZAsGwKQYi3cND/bR
         V75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786206684; x=1786811484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/S4ZfMkZNM8X4M2kCeMXOTPfDUbLKrBPzPbwT+05XYE=;
        b=QlNhW+INKQWgi7mx7JyBf9MPIqeCVkw5uBQly7M1t3/VccLWCyFyQOP1ch+6XqgzoP
         bdd2jM1ABqhN9ZeKaS+lvMAPiZZ3qzD1xENFTEN5IC4SAIEmtRVO+5Onz3ewQE+b45JV
         zzuOForPVYXkEEJqP0HDk+BTqCFLXFTwWs8LjavynFXET6iDQJWTD8D/Fw+Zx77CIjTw
         Tcws71k2D66ErZoQmksaaUD9yKmZXK+eJu5z0EN7hsqoM/45eCpTWCd44HgebGvAFTSR
         OKL60q64Y52XniRnCexVXPE/FvFjjmbW/p5WrpuaK0tUe1Xx+f+Tm7/TvrDsXLa9xxD/
         dTQg==
X-Forwarded-Encrypted: i=1; AHgh+RoRfi6f+Po2UuXQQTlTzejKR70+pEBInrVmNnHfT9NBw9Xh4qXPO4n8dCXgrV7vNM9UIL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIYq5y2EsexS4EKYorfHC4N74tW0nP56v+TD48BbevYObBUsB
	5+RVy/bid0n1fFIepYVRsZPd/IdAqmL8jOdR53PsGmPE6e/4ovOMJGtm
X-Gm-Gg: AR+sD11N6g1L4Af7VR+DXKPLEoEHDARlC8TVPit1i8tPQAB5+binuX+wUra/95viPkb
	XoQVTGGr3Q3i3mBaF4BbLWK8n9auwxodJ5M3q/piUQe3xvfMFb9wFeXd4lOqicNXboypQuDpXF7
	Cj1jXmah7rRThxNrSa/H2DZsoAzMixeM4IRB3IXzUnazwRMt3FAzR4gYGM0HjqIcClRrJ4SeKr9
	l53Qh0xZ67y5zpoMRCjq7/qPi/dEoP79DlZuVU+IpZ0D4dy77qtKTg3fbFKjasBQP9SLKQTOqsT
	LBtbkCCK2AXk9MmcENz9sfhP4od9z57cWkDqHqbEtLK+lNhC59QYgY8BEnf8AEw8zYIKN6+SXwj
	D7IUW5D+M8y9IFkMWomaWZ2XZVI33XNORyMAC7DE1oaZwMG6HYlLvpYXrokJN93YqTVfe6Esj2A
	pxErv4MhQ6/YkcBJCyhjtMwrnWIgVs0p+ngREKOOhnJcO5cVHLwss3iFrrnDwL90W2f3BiKLeid
	dk2/lNtRZfDL0SXC1nf4DIAXuZZYsU=
X-Received: by 2002:a17:907:608d:b0:c16:1227:e3d8 with SMTP id a640c23a62f3a-c2039b51b3cmr1408367266b.13.1786206684195;
        Sat, 08 Aug 2026 09:31:24 -0700 (PDT)
Received: from localhost (84-236-109-190.pool.digikabel.hu. [84.236.109.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6e72dsm186872966b.15.2026.08.08.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 09:31:23 -0700 (PDT)
Date: Sat, 8 Aug 2026 18:31:21 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Tian Yuchen <cat@malon.dev>, Todd Zullinger <tmz@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <andZ2eIe6RXifor4@szeder.dev>
References: <cover.1786103607.git.ben.knoble@gmail.com>
 <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
 <xmqqv79ld40c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv79ld40c.fsf@gitster.g>

On Fri, Aug 07, 2026 at 02:17:39PM -0700, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> 
> > Racy Git problems persist today, manifesting themselves in the
> > performance of commands like "git diff" in new worktrees [1]. We have
> > long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
> > precision when available, which mitigates most if not all racy issues,
> > but most builds we know about it don't use it. In part, that's because
> > someone distributing Git can't safely enable it at compile-time if they
> > don't know exactly what platforms their distribution will be used on.
> >
> > [1]: https://lore.kernel.org/git/CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com
> >
> > These days, most platforms are likely to be safe for the USE_NSEC code.
> > Regardless, we want to give users the ability to benefit from it. This
> > requires exposing the compile-time gated code as a runtime option.
> >
> > In addition, update the Racy Git documentation and other mentions of
> > USE_NSEC in the code.
> >
> > Best-viewed-with: --ignore-space-change
> 
> Don't do this.  It probably is helpful to have something like that
> below the three-dash lines, though.

Including this hint in the commit message could be useful for anyone
who stumbles upon this commit in a couple of months or years time.
Whether it should be a trailer or not is another question.

