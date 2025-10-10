Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838D2798EA
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137096; cv=none; b=dgWu63WMwMz3WBvN04nr5rNamE/7CNPId0yvoDnlF2149sDo3o1xPWtuafGqpkUDkD9jA5/lxePb7sorJy9AvlDtFQynOpaQSQoHkRkQv27L4b26nOXGrJxrJEJi3coaCB6CLINN3rlnlw72af7iytH9b9ehf3Wd9GirpPfPfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137096; c=relaxed/simple;
	bh=iNGbjJvcXvKmEEOuHUJp30tuB0UXB2Am6T3Sema5114=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHUTNgQYRCJU9shTRvfJVAb1Jm/cB+i5hr/c3a76iHhYNwRgiGLDvtJ4N2ELAUOTrEiiSbeN4Wpld2EiKW8cALX0g5ONfXIIAyWve4JNKY8+Uqsxg8zGz4OFijfPqsbm28tRPVCmkpv+vG1lsS/vceudwznHp5OfzpvXZE+mLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bAfjD+0C; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bAfjD+0C"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-72ce9790ab3so26020947b3.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760137093; x=1760741893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DG+CpT7sk9hQ3SPeqvNU2a/QKUHPdCjjhhtbWNpmlnI=;
        b=bAfjD+0CiYcfjYTnL8jTsUNWhaN+/baihSMOcQLf6oqeyL5oUCN77XCwtm3rYUtMFH
         SGv1KO1vOMo51H9BFA2Tstc0Qa7HjwsApu5SssBQ9MfNsy8o1wmDi3l7roamZoPyCdZ8
         s4/QIAppRKlgT1M66iFE8S6dyQM4aUVSmzi3WReTA5IS7zj5WNTxbLRTS0VFc0T99gDW
         XHpLfKgZ2378UKeneorRJnGwzGxPCsdFiLxH0SJFtEOpu7imH1cbuELBTnQBa6NR5m3D
         xvyOUFo817kIEnpAKMeUWKSzMvKSCE8SyC9xEIIEXGDZBgRoXT0HatJU+lqllTEoj2xq
         4IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760137093; x=1760741893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG+CpT7sk9hQ3SPeqvNU2a/QKUHPdCjjhhtbWNpmlnI=;
        b=S15A4/eDDMyFMogz965eB5RlVHUb3VZrjw98TA9fWVgwgpnkau8mJTou+aSMYkTRyY
         DHgFlreUrusmKmuXrUMi+PvKh7VMvaiRLb1ackrcjpDjc96dRWWwXZrjM7FRVCz4PzJs
         IZR8nWkLtUJf3CH+XhCLsyH6AJKh21aAAReQ6NKF4MX77gMFF10C7ItJN7Dei4PaFwxf
         wDG4Jdt3/zvJJ0iugfxSmvwGwlkocbbQf71B1D0jZ/HycpdMYj5HBU1PlKgPpCGCLcIt
         46wccH4RORVF/gZipBx6EHYjxi/5k9WUSoX11Cf8NN9AlFKgpdZKdFIa+4pqsM2yJ5Si
         08sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn3tNvIaKw3CYDyUQ81D1r0mdlxX9MUBD5NDnlO9I2Tr/SpjSWE1mnM/5RMbvGHnbcKCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4F/ZhXfNeOFoPjAwu11XVZKlDgptVCq9WC7R3mF5Cq4wbCC+v
	m6BwKzFnvvzzY4cl5GoSNy/fPrXv7rSAf8oVIHqdqV7xA+0sSwJdUsIkeHKW5CSzB+4=
X-Gm-Gg: ASbGncvc8PMPftGsAkq2AfpmgT3MpErTH0gQBo51Bcx5MeudrFyhO9DGM2pKsL2hzLB
	5uSo2/pMYmwP1KEVXRDWgtP5+XG2rTbeTudBGeYKQdflFrBb7hSrRV0dnlrxPAxDRmsrkmw4af4
	+w7oov7zw1/leOdNf1ZeWzz3gW+LBc8I3Sc7UQb0pSPPSMN2ak8p7yb5p9t/WVIKoWszTL7eVwv
	7jYVA/9m94MsKrpw7bhhDYLUzasS6mvyemqrctBjQlp+dhwPGUlKYoTybeXCpl+6DWHANpAVfNt
	wTPFYek8gxH3xgtrmCCKJkJ/r48y894WMzK8+Oztxrje6ZDfkgDHp4Dq643EBYnxzhalX7aWBcm
	XWnS/K39OEBgAOzRRX9gMRWfyISHXzcGLBoQQ3Audkz5K3XlMy1U3mmcr/22J/UM4d5NMVAwE7F
	5gH0wDP6pOqsDouv/Kg45xWypk19KOJC/XGnTGkxd4CGrA+8njMnGreJTQy4Oc9+AkEg==
X-Google-Smtp-Source: AGHT+IF0kMm2rKtUawpAC0UFJpwktcFEN/6Q22y90yckZW2TfzMlQv5ZtEceqcVYP2Dw2sHTD15SFw==
X-Received: by 2002:a05:690e:154d:10b0:63c:e0bb:2e8c with SMTP id 956f58d0204a3-63ce0bb3a7cmr6290808d50.5.1760137093260;
        Fri, 10 Oct 2025 15:58:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cf0ee8ccasm564827d50.13.2025.10.10.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:58:12 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:58:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 21/49] builtin/repack.c: factor our
 "generated_pack_install"
Message-ID: <aOmPg7Pb9RqOEuZ5@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <96d27261e75fd2ae46d9633b3d4eff243dbcc187.1759097191.git.me@ttaylorr.com>
 <aNsUiho56-S4MQZg@pks.im>
 <aOV3cuZhab7xOdez@nand.local>
 <20251010061449.GH1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010061449.GH1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 02:14:49AM -0400, Jeff King wrote:
> On Tue, Oct 07, 2025 at 04:26:26PM -0400, Taylor Blau wrote:
>
> > > > +	for_each_string_list_item(item, &names)
> > > > +		generated_pack_install((struct generated_pack *)item->util,
> > >
> > > This cast should be unnecessary, right? `item->util` is a void pointer,
> > > so C should do the cast implicitly.
> >
> > It's unnecessary, but I dislike implicit casts from 'void*' to any other
> > type. This makes it clearer how we're supposed to interpret the value in
> > item->util, but I'm happy to change it to use the implicit cast if you
> > feel strongly about it.
>
> I tend to avoid casts when possible, because they can mask unexpected
> conversions. E.g., if item->util's type changed, your cast means we
> would never notice it.
>
> But that cuts both ways. If the prototype for generated_pack_install()
> changes, it is only your cast that would tell the compiler that this
> caller needs to be updated. Ultimately it is the spot that _sets_
> item->util that needs to change, but hopefully flagging this spot would
> point us in the right direction.
>
> And that does seem more likely than item->util changing away from void.
> (To be clear, I don't think either is that likely, I'm just musing on
> whether casts like this are helpful in general).

OK, that's a very compelling argument. I'll drop the cast on my local
version.

(As a side note, it doesn't look like we mention this convention in our
CodingGuidelines, and we probably should, including the rationale that
you gave above here. That seems like another good candidate for
#leftoverbits.)

Thanks,
Taylor
