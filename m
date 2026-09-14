Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705046EC72
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392279; cv=none; b=EH/cLnFLKL7tamPwTXL2mK2WMIETHXbgOQ0pn3fhoKhyZJr6GcXjwn2/uUoyOz9WHRSeLdQDEDKvgpTu7n4K0/RjFLCawBLHHSUpt+2+MXxm8GP5OQCU0KRQy93wdEvbWvkulyRr/qzcq7NS1ttjBFQe+9uVnpaXWwJgsxpohSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392279; c=relaxed/simple;
	bh=pSnEd+J6o4JLea1vqmOvmjUJmqvHJ1T7s2byFk2yldA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa5c3nubns8evWYOgkPbpiLQHRUi8y/A6Dast1ZUVAoMAdalrRmh58d2YQ8IhIGNQ6zWG5YlhxEPQHtlkfalv+DuII7iUocmAltQjY5Z5pNsKvy0CCWad5+iCqq9n2Ek15gJB+0oCHbmXKi7ANekI+hWuCqJ2Lf/BYLszk3qIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Irvx7Tib; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Irvx7Tib"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-486fa798933so1368171f8f.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789392275; x=1789997075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YtgJFgsc257bvPs04aCfioJOpmTG2dTfRcb3d8NHuoA=;
        b=Irvx7TibzX3ii7ChlcCXnSiGibgH7AmpmogLpV07mAEzwyA585Kn6+Qs90+w3s7EVd
         P+4MypTeu3+bLt+8Te4G7DYCWk9x4kmfNRoI47Jvm2bDWcwQN4cJP9Fnk9jRKFvbuRZk
         S+2Yvd/mGqvvYr0NvG0S8zS92draWbXyB4QCgBDqvP/kAhECBYCTdDCBoR1F/ijIp5g0
         E/w41CeOpnHMaWI1/x7fA03kN65AxtXBDXGBmJB5rKQyJmRgPowMLnFD1sH6BVSHOXjb
         GePnG+y+LDYQodm1K1JRd0pP0YE9R27GHP9WG/gWlVAApRF8bfMyg1htmIgZ8M/RqEao
         cXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392275; x=1789997075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtgJFgsc257bvPs04aCfioJOpmTG2dTfRcb3d8NHuoA=;
        b=JtExAXdmpJnwN3HuI4hM6j6axmdnCjCGOegDUeNfa/4XjNrPIu/ft/hp+5FPtGBJMo
         UYyCEfrXo+U89K4WLfVPBZcqY8q2BReqJH+tMuuzXBfevLTUTZSLgKIiwVjFzrBIoWFQ
         QwF/MHxSQ4qshzCc+VVqs8pm7d8WMApBFW/ayRxAWR2NCicEtnFj4apbFUXSRWCbCw/e
         4CEh3pX7iWe+zsxMw7mVUoTyWOOSk4PYYV2eTw9C8m5YI7PnOlRi1lrkfS0W2vRyEBpI
         An54zVB76isXtZAUP1AvMltIBayBfpe8S7/6rQ2dq6LZiIRjdijR1YpzzLL3mWBPyZsK
         be9g==
X-Forwarded-Encrypted: i=1; AKwUvBx8+ZP6nwLTP5eG2nMOsIDhSk6G42uzXB7Gt4qOyqOtOJrxBRKd4VgKTMIZ1J9d7DF3vuo=@vger.kernel.org
X-Gm-Message-State: AFuF++my5XbjPnx5UKr9vJob8swNgiu/dUQGWOTzIr4Wi1+CbMjmc46D
	CRcmAA/OuRoqRsXKcNsBzN4KRLT0JfaN0JzI27Boq8b5PCAGHg7xILg/LNBOxSA60eI=
X-Gm-Gg: AYBFou0UL43/9spZHaUjfwsFcNjqmXSt5jnNKJLjZPFqzmSCG6F0fGt2VzsOMuabGx5
	utfg6jT6vncl5gyHJIZgEWmraqKKH3jtwYN9L0vGe/qG/0epENaqLWrhXvLFPt531ro4Ln2DD0P
	XAN0byIwhC6c2WRk5NMR7+O/imWNIzmCGlSVjrDxbHQapKGh+1lpH8Xm7RUQG3tWhSkaDwYQBzj
	8kt6RgZPPwe9DAkn/HX9fz+q+2PTHqkM+IAKhxtOGLH9k1hhcUkgzWVVHzTgDvxd2QZn+fbIV6y
	nASXywU7inuHG47eERhOzVfXpt2tkipPR4tGTuHGiK1uzvKnMsUKFakLd2OoH2tJvnwF8LMPkMy
	/Sd384foKHlWwCBXgulzOGWaIreuTuYu4Hlu3ZHstotLceqi7xH7Bizi9ztlPKiGRjcDW4EKVXI
	fvW5kY9tPiupI/FAqFHwBPOAGZq5TQtGBWO2ZL0gvhZGt9Pa5+wDaIgtn8vlh0pqyG4NK202RVO
	4eJgiU0nlbo
X-Received: by 2002:a5d:5d86:0:b0:485:8c16:5ef2 with SMTP id ffacd0b85a97d-48702b19e76mr2809853f8f.44.1789392275500;
        Mon, 14 Sep 2026 06:24:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea60sm26790430f8f.17.2026.09.14.06.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:24:35 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:24:33 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.de>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/3] merge-ll: use tempfile API for external driver
 files
Message-ID: <aqf1Xzug5jbNDWlV@localhost.localdomain>
References: <20260911171044.GA1609692@coredump.intra.peff.net>
 <20260911171339.GC1610200@coredump.intra.peff.net>
 <CABPp-BFyKaByMYZ212O3cB2GD9OjNJNZEO+krf2GGs9vxFYPhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hteark7bbi2pjlwv"
Content-Disposition: inline
In-Reply-To: <CABPp-BFyKaByMYZ212O3cB2GD9OjNJNZEO+krf2GGs9vxFYPhw@mail.gmail.com>


--hteark7bbi2pjlwv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 3/3] merge-ll: use tempfile API for external driver
 files
MIME-Version: 1.0

On Fri, Sep 11, 2026 at 11:10:03AM -0700, Elijah Newren <newren@gmail.com> wrote:
> But maybe Commit-message-mostly-stolen-from?  Much of your commit
> message is understandably about tempfile specifics, which the original
> didn't have.

It's also OK, if you just add me to the Reported-by: chain ;-)

Michal

--hteark7bbi2pjlwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaqf1jBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Aik5QD+PTmooehEHwYdtM5k4+Bj
Ebl1BihpDJsU0jog0DSwKWIBAK3NVnHb77Z9bCpTW8lGI+fqjnAjQxhEed5Xl/IE
wY0D
=L7Ro
-----END PGP SIGNATURE-----

--hteark7bbi2pjlwv--
