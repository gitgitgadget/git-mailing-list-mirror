Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6EA39659A
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791266014; cv=none; b=Q5Vpyzbp97n1iZDqYHTgQgVIaKnttkILwnuX+pj5VEFFonoxvciUxjxYP93S+fXzdhCuq8uWBPWKkPxc0/bWlkw91ONXIeVuVJTW+zh4wM05vE3jmD5fKuiXv9Jm28Zvf8+ZV4zknQJawOlCyhwOr1ovcGI48D6J9FLOp+P8wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791266014; c=relaxed/simple;
	bh=DQNTLVc9KhRvF2yW67zVRkRL7I98cORdBMzvZisDHgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEUy2ewabn1zvu/a2jWSq6oOJPb6Ad58feDKPBA6E/+vQUbShYw+QVVYw60hSQoqeErEgmQt1F/oiJHVQlDG9NZEH2iy+mBXm40SwHf3ZaGP82i+UHLbMkw1aIIpssHvVXZfdsxVIJU2PFTAEa3uE8P/AAuhggJR/LqI4rfWbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZRO7iDPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fojpGeZ3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZRO7iDPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fojpGeZ3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E39C4EC0B9E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 01:53:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 01:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791266011; x=1791352411; bh=AFLVwMzfi7
	FPAMBlg+FlB2Do2J8ctM8KqjsU3pDwa5A=; b=ZRO7iDPiBirfG81CNassEqrHmr
	yjJyTEnT5mdXm6yEaS/uZyAT1mPB5iy7JjBJXAHBwr+AF2wF+OOX37MQqfKG2Yqj
	+wmJkgM+DIzXi6uIUlgs2E5UWOpk/TL1LhK6lZJ7QFlnj2zht3H/tle/01dDupse
	Xx26oeG0jq/2/iUBnRckZ1P9OggkwvQwO5t1JtNFDCTaKuwz/y9NA2HAZObsb50w
	qMc63gidVRIbkGsqjj2WAsNCjtNVGQ87oCsFQGS5O8wyT2Zzg3kiNevaiDw7ENbP
	kAhmxYt22qfCa7kN2hAQ1B84bn0Ju75b2KDLtnrkivwWsI1RGpwUG4rQF5Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791266011; x=1791352411; bh=AFLVwMzfi7FPAMBlg+FlB2Do2J8ctM8Kqjs
	U3pDwa5A=; b=fojpGeZ3U+w9qbD6/bucf8XA8cE2QvsvFo9F0q7X8AYmeWXnCwT
	0D2oTDwBKK/Fuxe72IhlMc5k6GA2U0r3byoSNTV/0YeWtDxJcYrxFTyedX/8OlIb
	F6vFkIUvAbQ56SYUrnyBHKB+h5/LWjNmxf7dsV/VXHpf+luOSgifa3dVrV/GgePm
	oFMPeJFWbMhDSgqmF8tVFaetC4RdCeWaaMUUZeWbMg7nEjlj39aEcLJb/QG35Vr5
	7Z+MfQuTb9/GdX569YQQ2/Q/Brm6mOkIhe+5/tKRFAjJtHp3yQF8g9p/qBzPB/gT
	jFs8ETSd1NdNsW0GMlOZgyrbD7U2kwh5xcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791266011; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vaP1DcJb5rHm1hfWuR9qx3+9BEF71J7huQ6NL+ZqEfjFNtk
	fYOLvxE7w8RKscxtrroUhUg3EUlRcJjwZ49xT307TOhKlilLW52os3UWRlO8qMrs
	GYasEtswl3lysU2E6bTEt452HP9sA7TZX0JtwK4Y5+U0bEayWENd2ASW+TVMqvTJ
	QD9l8nlSburce/BFicsZZtgVL0J5aOIDIMeqQvYQC0g6l/9Qg4+VyKcNmDTbMVdP
	LwQd3169HxT5VXZv8My/AzvdYOreTgl4zAsVdaMoUoI6L6d+pdOggpXqvoVigr30
	YXyZGDIwwvm4anMncQrm249F5WDrAqU/bFBXGkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VNHzQWy8c7x6zwpDkboREBinRGOaAA8Sz5fzb0AY0fI=:DQNTLVc9KhRvF2yW67zVRkRL7I98cORdBMzvZisDHgQ=;
X-ME-Sender: <xms:24zEapLd5onj_lp1gIPqKLmgh8YXxXf381HqUp4ZCdfjJCJ3jkpg6w>
    <xme:24zEarIiidniM6rl78OYwXN3vM1Odje8rV-5v7kZGY1F9YHcKOM_bKwvefx9u0geL
    OHe3k4Z-T07yXORkeHceHL1vP7Pn1aMRVI2gJhFWABbPf7tfRCFug>
X-ME-Received: <xmr:24zEavWn8GCt4_Jd8wE5V_pfl7F8ep8JSHIxayKDZxRnpfWWdZ9uzNIEY7eUTTceGzhZog>
X-ME-Proxy-Cause: dmFkZTGH03yASWLhQfsQ600cZuy3wlmD7pLdi8MoKmaWkml0SbTsW9UYwr1nx0+t1OqW+5
    8VoRtjJU31Okfc3s/+bwkNurCNk8SydQrhwLRNZnbkCkuCTSqZl+a8N39XkZ69ZX1wPY64
    J0TRP6i2V6VXDhsog3KMHTagDgrmk7kSogm3+nt4i4lrnOEOYMuFJcOQG1QJ1sGxI6cGx2
    tjcqHoiV0oX5+IswqiL4LDiYlHzOEFuA/s1kr8hDv0+8rSJViCkLtTynnN/D1pSvvEtwy2
    F52Ei/vNozllXaZmBg2i+xBbnTdXy3JD2gK0XsZxviSAlIeYaKbytaT10BAX6nli3FucNP
    /vXxs8nlR9PL/ORHVrPHLE5AFb/W26P/6v1jcNPBRh3qiLX0wdtbCO4nEYepJYxfJ8wrEP
    qP4h2vlWe60ULe4W16IJM8PGX/iAWoCjJZz8A/XG3L+lXGvfJcWTejR3yzTDRSAcyNFWnZ
    11yUl4nW/7OLa5ulukNA6DfheswnFSLyDvgN6uZQHBPvD6AZgwuT2fdkO02YItVIQ6Pgg1
    IPeGumspwU1bHzoGjhIHtlXIe73I+FGatyEvipjsQ7VZYcrH909fpQpwEs+uilqF9R0Qup
    ZVMNWCh1Q9896/MhFq+8Noe6VwzRjAfcaqpOgBq1Q1up1xi1AkhNTbKp3a3g
X-ME-Proxy: <xmx:24zEaljqE_El0G2OEhfTcxwC2jJrF6bFaVIqV4Q8CkRsfgvmQXE_CQ>
    <xmx:24zEai9V7Myh5G8HhaYwiDOyEpCtK_Tnni0qXxbz_vQ7J4d_ULv_7w>
    <xmx:24zEanBqFHxjvs_JRu8P2vfQ_efgG-DNDodE8WYs4A_k2dOBSmK8tw>
    <xmx:24zEanKkJkdkZCoLVhKY9Yz3Me4-v3Som2uanfkuP7ZG1egoCIROvQ>
    <xmx:24zEaq7hJcUhQ83cubWqXLW34IqKaMaivVd6Fd1-g1UJjB1cOAYSahPs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 01:53:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64e13146 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 05:53:30 +0000 (UTC)
Date: Tue, 6 Oct 2026 07:53:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/repo: rename "references.format" to
 "references.storageFormat"
Message-ID: <asSM12B35oka08Nu@pks.im>
References: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>
 <CAOLa=ZTNNY_XuixqZ96TK0zFfDpWvxSupxVGOnH1VGXK4KF_0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTNNY_XuixqZ96TK0zFfDpWvxSupxVGOnH1VGXK4KF_0w@mail.gmail.com>

On Mon, Oct 05, 2026 at 03:11:19PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > As part of 2f28db44d5 (Merge branch 'ps/ref-storage-format', 2026-10-01)
> > we have adapt all sites that used to say "reference format" to instead
> > say "reference storage format".
> >
> > One missed spot though was in git-repo(1), where we still print the
> > "references.format" key. Fix that oversight by renaming the key to
> > "references.storageFormat".
> 
> The patch looks good, but this does break backward compatibility. But
> since the command it marked as experimental, this should be okay.

Right, I should've probably mentioned this as part of the commit
message. We could for a while carry both keys of course. But given that
it's marked as experimental I think it's okay to break the format and
drop the old key.

Thanks!

Patrick
