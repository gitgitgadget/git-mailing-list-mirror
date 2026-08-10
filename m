Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC823D283
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342018; cv=none; b=Tbldo/VtbBnWT9V4M7+x6yoZUXEEx9/fpB05xBN+syV3Rcz10fbf107kOguz6e4U7/amVjj8inNTap4499sSge5HfadhEmPou+n6MMOVPddVw/FfpTp7FLxFKKN1UhsqhIuyzxMRsmnc4E5bscKhHhBk2jG/QaogvQ6msa5cnPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342018; c=relaxed/simple;
	bh=j7BhhX/8aLkRAt1PZiiPDGBqFyA2vXiUVR8zOJGR7ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR+mXQdaXNS6HGSKQFOWCCgTpHJWIYZsN43TOoFtzREAD91atTknvcPoT6KGInHfF2pXn/8VWE+GP0AGzqoCeA+cSOy6AsWX+WWRY5lbIVMovRhJIlEHq5/GFBXKZGG5eoNcCiZolKplh1geXYf/gxblSLDCITv5qyPJGC40C7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A/J+Ezb1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jhoWDHuQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A/J+Ezb1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhoWDHuQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CB2F7A0190;
	Mon, 10 Aug 2026 02:06:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 10 Aug 2026 02:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786342016;
	 x=1786428416; bh=CRgF0htbd6SEwhGPCEWc3EL9xiXuWhKkFMA/RP/dZwk=; b=
	A/J+Ezb1thrXLhdH3oUSDtwMaivcOziAhnqIZMPlX2pnrJYqSYisc/G5vjMU3Rpi
	0CS/2Uk+7oRvAQebgmNVjCapAEwwp8mu+talqhzF8cj3TO4mi3Cq3o9ww0qzVuOc
	CK4GENVHsKIMqWKO+AAYLChWXVnc3vkNCM7BtU8WsFcOy/wpr2iDZ4pEZ1L35itI
	DKj/HNwkY0HwPMTwertp/Wzps5uozdTkDzFloAlw/n6SKXuwbCfohyw1SvV3EWhq
	/dxUW/+vgzDZQgLbPd6niEYGv5h/6fGOZDBt+PPT4tjx9CEuFHKKSCc0D9X3I/gq
	FQM1otQvResKQKODpCOGDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786342016; x=
	1786428416; bh=CRgF0htbd6SEwhGPCEWc3EL9xiXuWhKkFMA/RP/dZwk=; b=j
	hoWDHuQ4jneUf5alMyld9mW+n0S5gcmFmafSdiZK4jKMmgxJlC61w+mOnyP+Ek6+
	ydjnY5EjXHGuygCVXU2uk6zx0SU23o0wzrtzKqlH58lKYbWJBo4JepiRvRn9Vwsu
	mZuy5C0FCe+cIcDm6VJUm9w+KY1gvSFtyDdTLfGOQt/ygzaYEtgFlGjDn6DHKyEo
	IIzGTAUBg/8Ucwa2VmfBNHzFv0jyMXgI2cokhMr493V2wyTsRekQru0aUmzyYIbe
	OntnVOyLYYanyBUzw7y5th5J30DZTuaiokkGJWkmp1WjhC6waR+yGeCsXYGarAaC
	wRRewJlyfErdEYTZDVR+w==
X-ME-Sender: <xms:gGp5aikZVKY0CBa7OPZuluduTHkxT-3Zn352hExXWorwlgJxVv93jA>
    <xme:gGp5ahSEB9JC4rMVm6eDGACM9AcTqEnuZHtpOtYtg4BXtoYXvlRVonzt-y4utPJSe
    ocBNvVITEIgphO4uKW9oGzsoimjdiVCACxvP1o_FaiKF8C-ocp4UA>
X-ME-Received: <xmr:gGp5auA8y3y2LPFQpnoPl8KxsAdnqRj-SwuBuuSNqiTieLV01McdkL2kAQgwoHnK7dvzAXyY5vBK6SwMWVqf0LzB8uFQHDJ13gKVT1e4Yw>
X-ME-Proxy-Cause: dmFkZTGr+7OLeImki5hFuEwZ+2xXj6pdHP5eQRpmBjNLejT3hVvCpx5gCTjbpkV+bJCs/K
    VVCglAnVIIJZIlroS4oSarkMfLYsGVpV0NujMDVeZ2PaZ8JUYoHdTvutf7vNmJ/BC5b/bZ
    Y2KgBWWlRGGD4mAkciOKZ3UPojeRWtzu7C/NF+CMEEr09MfBj+iVYNJHtWuSNaxwjwHttY
    DHBGCC/t5LFg5nLWYAxKRCBAGwGaFdznYRvAWwXELYdqKO8ZbN51Awb7cFYmbKhDxCC9C1
    oAXkqcGjuLSkOre0EvSjM/aXGazORjv9Lg1+kSXNfEquDbn+djKJtEHDCVt7H2SENhYtHC
    DWEsR4ViKeTEGn/CsRtAY6IbVe4U/ClTOtSpA92/u/E3oOuuWTDmTJgKHWE9WXQbkfGhjH
    EN5PM7ECCrsTsH2zG/pcv/DKX9WtXjcOZd6/Wdz6P+DCMjuRCSIniKuEgjz9ybAowLkVvu
    f32b8AQeuHa2z143yKDl27KGJLPAK5beyipiUeUOYQ32nrmodn+M0VSPLj7uRtd0ZjEzbO
    URsanVqGRaoDofi8Mgn06fv/iTQ0smc92Gw581QQl8ZHSFbduQgM6H/KWh9GtZBOJzq18M
    EvN2pISm4DN6rE6NefXHCA39m2ZHqsTZt9CJuezMD/hjZUO0m0TkTsTqkysA
X-ME-Proxy: <xmx:gGp5agSvhAJuxPg-ID-SgIkt8LNP7SyPG5D3WkYA1HyOFbJD1Zki8w>
    <xmx:gGp5akqYzYFUVKnzkVoKKRYh7gJTFv1RZYRdxh1BpRZ0HFUgzFBe-w>
    <xmx:gGp5aqzUJZaS0HaMOfmLsj0AWb3h4wZa-OW0IO3sF6VF7kpQfirw7g>
    <xmx:gGp5ahIfkY_OHWmDCNRibX_8EAxbjlMPWZh43dqvGBrVAfXlt99KLQ>
    <xmx:gGp5apt9lhkaYhq2kfGjlPbIsAxvdht_vCIzZEUhmZvs5vGdcuBaEZOI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 02:06:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1485b686 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 06:06:54 +0000 (UTC)
Date: Mon, 10 Aug 2026 08:06:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t/README: document writing concurrency-safe
 helpers
Message-ID: <anlqeshH0FXaLvF5@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
 <f158e1f92e9c586fca34faecaef23f9581d65478.1783704657.git.gitgitgadget@gmail.com>
 <anGcx4lRyy3jyS1D@pks.im>
 <CAC2Qwm+Jni+xU=gaef1AWCMj9+GUQhMrCWX9DFpS3y757pxv=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2Qwm+Jni+xU=gaef1AWCMj9+GUQhMrCWX9DFpS3y757pxv=Q@mail.gmail.com>

On Fri, Aug 07, 2026 at 09:51:34AM -0700, Michael Montalbo wrote:
> On Tue, Aug 4, 2026 at 1:03 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > >
> > > +Writing concurrency-safe helpers
> > > +--------------------------------
> >
> > Nit: this paragraph is quite specific to lib-httpd, so it would make
> > sense to mention it in the header here. E.g.
> >
> >     Writing concurrency-safe lib-httpd helpers
> >
> 
> Originally, I did just have this as a blurb in t/lib-httpd.sh. I ended up moving
> it here and trying to make the advice apply more generally, though the only
> other existing example I could find in another domain was the
> make_symlink() reference. My intention was to make sure someone working
> on a test helper with concurrency didn't skip over the section just because
> they saw "http" and thought the advice didn't apply to their use case.
> 
> I'm inclined to make the language in the section more http-agnostic rather
> than changing the title to be specific to http, but I do not feel very strongly
> about it. If we were to frame this as http-specific advice maybe it should go
> back to t/lib-httpd.sh instead of t/README?

Dunno. I'm not sure there's much value outside of httpd, so I'm still
inclined to make it httpd-specific. And if so, moving it into "t/" would
make sense.

But I don't feel overly strong about this, either, so I won't complain
if this section stays as-is.

Patrick
