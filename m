Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F24756A3
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195907; cv=none; b=Njm6Ng/pqPtxG7jv+ENKWe72clYjVbmm7hqLVx4TQKk/hCKg+6Hl6F/6lfl4j5N1Ef0TNFkO1HwOyGzLFGmcgy2eB0druhmiPIFI+uurgbR+fNJG4ldnU64nheBpWq47e4WDxCJVYGUptzQO1Dr2viwYbez4eboHegWG+Ad8VEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195907; c=relaxed/simple;
	bh=N6Y58Ry8wHZhusZCzzTDlOggQ540n3dW4Ihqt33kwqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAgaIgHLvMSOjsG4twr+XTT4iCjbvYFoDk11YT41FscUGQ8lLDvLPmShhTiRHBC8S2/Rxvu55DXaVSFxEaUtCWa8TBEwVxs1rIEsVlb/JJe0tAYTkDNHEYo7XAzdq2+8V976Jufs3Tm+zHwWRb/0MUu5h+DNeVwpKScZOswN6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jy09i6e5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mG9A2nw4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jy09i6e5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mG9A2nw4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E3CEEC062D
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:25:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 05 Oct 2026 06:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791195904; x=1791282304; bh=pcC8hosm6/
	2qTeeCoMmxgsDdEF5qauS0+AqqI6Y7u44=; b=Jy09i6e50LZ21WAGb1COrs7AJH
	3m2GTtbVumNaX1a7iFQXdv7CiHx/KAncraPniaZt/Kyn9nOshpq7d5EtykMAEME6
	y4UKQviTIr04ROHmJQTYuqmb0huB2Lr2lEvAJ0XPUNTqsC9VytU+DyR1ohwp5ZuU
	TtggF8AwgIH49SbLM9AtnIJLgXt6V7wl87s8HDx/gGjy4pcqd6ciW2I+f0rgmViG
	5pvlc9xS7i+QMjqn8M+fLRuJI02rEqSLfVzJ6uyyvxSSrU/OITuVg0/AqgklG+pp
	JhYJN8e+/8o/FGf0tj9lszzjLEflUsY/OKtNwyuVTXwCjeoHnf/H0yHHEbQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791195904; x=1791282304; bh=pcC8hosm6/2qTeeCoMmxgsDdEF5qauS0+Aq
	qI6Y7u44=; b=mG9A2nw430kAXRGE/r9KPjGFAAnENINsvYdY5kSxUoBpqeQkF0Z
	8L/1tsI2944flVYJCKBIw5UEtlE+z/tEraHZ0ZO2fsco7FU4Bd8LDRAD2RSAmeL2
	zu3WRIDTSxG4OpdCMHRrDdz+CkvWrlgoz/Mj+AXfUbMksQFYNDUBtfmWe3gypQ2j
	HhFwKc6q8WTe5dlNeLbvF8JOO30lpYGjZ/TSXJ1D856gUQ3gYFt4GMhcWpBq+lIr
	wM+BaJgBD5T3RcO/lV8nP3VAdY9F+5lw6X9UwPETn4GLjBfveo52wgM0jeqrUSyJ
	kZ/AXPfAle3vNzcIjZrroi8hHcebIo1Glgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791195904; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:q4/WCCvSHMFQwjLwRqLG3zdImPeuj+qrjjm2RaVMno3Sn6p
	e9yCXRAnIB17ZIXzkWH8rfZ1HXiQmgjl12SRJvXL5RFXO7rN8wMsFcKAtOcJGMCV
	ZnuiMOkWEnPXFYG+WJmmgFL1Jz0/hRutWkxf5sVqVBiViK0spITQgzvH7JTeBCS4
	9Ah/T0MBKz3uOzXh0sNuslzQUmTKvuOZXIKA15RSdZpHdUne2w1VgFm1bp6xcPEI
	UAKR4toZ2RtXWdNNq3gCck606MqUHDyxfcoAmhl1eZOBfsqDE0DtX/Pyo5XVYrQe
	48dLpr/4fqJDNySSOug9rGFFfiOhwB1JChFlXGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ggIr6jbkdE3CXh0jugLKn6WZo85qPQTadBiXwa2Rm8o=:N6Y58Ry8wHZhusZCzzTDlOggQ540n3dW4Ihqt33kwqY=;
X-ME-Sender: <xms:AHvDah12IuCtwH_5_HSY-6gqT5Byn2qpw44b0oggSotyH3HDCOPCqw>
    <xme:AHvDavhPWB8prvp2QknApklGv1P1S-WFuxm6SGt8FRMRjT_8TUMS6cXSB7Qv-PjQw
    pQw86weqI6H-Qp28ETjaYnvXTCqHbn6qxIt4V9C0-7sXl9pJWqrBw>
X-ME-Received: <xmr:AHvDavTkkK2xE6Vc1YNpYWLMNIcDvVYrEPbfr7yi9rW9uaMklirSVoQUq-Yf75z_3dGBMa4>
X-ME-Proxy-Cause: dmFkZTGXBrRAyzl2T+rLLZkNV80AVWVI7fN7GRE0mZ9c3THXrIs34NJMNkcUaJVjfkPrNZ
    RrHEMlH7W+BVoWwcAV7pwY2GfJBElffaSvM8M8JeWgB3fWuRtGczqOJ8iFWxejt8F03mUS
    Oh8rhKYrtZMhz0KmrGUItbhvZwMCcEADUxh9m09d8NBxfUwKUT+7z1/whrh039edjOvg3I
    nJKRWYAoK44xqz6nSQYBLF9FqeoSREDmaTnO4l0tITnV15ux7hByhH4i7Y0Y57Mv7I+FPR
    AW8fjh4CO459ZmjhwSLXs40DNE/gmNtQA1M1xdHN/yFN1xJ+i+5RHW1KGj4xy4zGx299Ox
    qfFgmThfUk4eo8Uv404Mtx8SCD2b6ULAyEq4maxWuPPDTh6dEds7HRVlk3mHBWCL3FhVfv
    jycfs94HIY5YxN7x7Q9UfG/t2eSZY4DYt/J+ElMoi5mOex1P4u4fsqeoDxf0SKpmbbC7MQ
    RsEYAhFsETInq0I4Y0ZdVWiPIKRiY09Zy6TugYaYcgfjxs1eV1B8x3DW5YTax2mG1ezMlO
    KU/GXE8OBWw2mY84SeJIn08fkFMIEqDuQl5NIysLQNqfQrz0wAr7FvLhYm8nUG1bfuzqMK
    hBzdRwlPdpahIK/KvpdRSZLgzc1RRKXvEuCW0MCutF94abqQiW982kygP8LA
X-ME-Proxy: <xmx:AHvDaog3H6bqZnjOuLJNbP9FwKqTv2YIVEUI1ZcitznWKQu3aDhvTA>
    <xmx:AHvDan5Q8FLsHUKEkJgZjnP0XATGlzWA1Yh6Jw-PWaQ-0t7YOnJitw>
    <xmx:AHvDatD6XLvhXPsdKvY64XcPwkji3ifjohlgBDLzEm1UEyupINz9Vw>
    <xmx:AHvDama0gFXVt9QSscVWHLmkHPOHaTgnAbHeAOrjIsUPNyQyYjmFIw>
    <xmx:AHvDapAZI7oY59OpQ48odGIMbLYANvq_zmZwS8Dr_4Ft3tg-V21S-1NP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 06:25:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a2e74be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 10:25:01 +0000 (UTC)
Date: Mon, 5 Oct 2026 12:24:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/7] meson: use precompiled headers for unit tests
Message-ID: <asN6-vOYWYtbiBFr@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
 <20260924-pks-meson-improvements-v1-4-90b7f79f1c4e@pks.im>
 <eb0432fa-a595-4690-bf13-baffb306cc3a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0432fa-a595-4690-bf13-baffb306cc3a@gmail.com>

On Mon, Oct 05, 2026 at 03:04:16PM +0530, Kaartic Sivaraam wrote:
> On 9/24/26 19:39, Patrick Steinhardt wrote:
> > 
> > diff --git a/t/meson.build b/t/meson.build
> > index 3ca7b27104..9f1ee9ad59 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -66,6 +65,13 @@ clar_unit_tests = executable('unit-tests',
> >     c_args: [
> >       '-DGIT_CLAR_DECLS_H="' + clar_decls_h.full_path() + '"',
> >     ],
> > +  c_pch: '../tools/precompiled.h',
> > +  link_with: static_library('clar',
> > +    sources: [
> > +      'unit-tests/clar/clar.c',
> > +      clar_suite_h,
> > +    ],
> > +  ),
> 
> Compiling this separately as a static library is cool but now clar.c does
> not get the libgit_c_args it was getting through the dependencies of  the
> unit-tests executable. Is this something that we need to correct?

That's true. But I wonder whether that is maybe even an improvement.
After all, the libgit_c_args contain stuff that is relevant to Git,
only. And given that "clar.c" is a vendored dependency, it does not
really make sense to expose e.g. "-DWITH_BREAKING_CHANGES".

Now there are a small handful of arguments that _might_ be relevant, but
these are only -W-style warning flags. I don't think we really care
about those either, as again, this is a vendored dependency.

So overall I think that this is fine, but I should've maybe called this
out in the commit mesage.

Patrick
