Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3C324B31
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329294; cv=none; b=SqKjkbijwKDXWWxysuBjQ/7M5LG5jlzqjvBAJ2fxdaS+k8z/RnxpFrGgmvYmQ26VPaZzAtx7t0SkgwYXp3FpQeDlVbB2PRf2CVa+413JDMR1jv6KB6c4FnOlJHXA1H5sXlzYP/5fqi0GqimylW+MAQ9pVkRoHQJtmKetI7Nd6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329294; c=relaxed/simple;
	bh=U7JC2xHoHjhQKtlEpclws6wV0e1DVKr+9f4yD2cRzno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNskUeDZKU3LGhfsC4MVJ5+dOXdZmVpbGfeWzDFDZHHBRusyKrKiB3Yqx9NB+3YvOeI2uM4wyVL71VHN2VZJBC5VxP7V7znhSmQUzaN8CUnxJfFK0/fdx/hTc3KEIGNJ+SU31AcepqSWE6ZE+uuSLYsYmTvVTT5+deC15+YHz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r9bYslmg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHx0ul1T; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r9bYslmg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHx0ul1T"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26BD07A0099;
	Tue, 17 Feb 2026 06:54:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 17 Feb 2026 06:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771329291;
	 x=1771415691; bh=ThPelK4S9RCwFl6LPKLgqzjocNqqQ/HPkWB3zvV83ow=; b=
	r9bYslmg+fpHeBz3LgHNIyGhXVpL4cwf/nlJPkk1bgcWILPm/XlTFAi+lMkaIF44
	aIY8JNiQLORDsgjHlQdW/gGnGvTLJD52/lfMvfU2dBOKNVMqn3Cx/+kCbRthRPx+
	G9KUNBOmMF2PQBuTGvbw8TSAM1NKQ32pK63tW/72Et3g188rvRNgzyc7mueS1bI8
	ctEhNWAygAiTFyioSTNdgHgf/ExgqiAzwi0UnqLBPtV418pFG8vy2xYNNNlM1qS7
	Ht+hKVFKYQs9N89MX6jpV6UDvXvxY648NwAap3pCPe/ctAQVbo2DzXsRn05jR7SR
	YSTaYpTOqlR40yVGZ0dB3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771329291; x=
	1771415691; bh=ThPelK4S9RCwFl6LPKLgqzjocNqqQ/HPkWB3zvV83ow=; b=R
	Hx0ul1TlCOII/xTQQ4oVpgrlcAWAaNsk4HSYhiIG6qAb+acOIJNprpIG/+HPAAT/
	+9f++jQBkPt6P577WBn9yPfOWRd8zE1c/xQU/Bqano+CEKyFeTIpJuAJ89lqFJoa
	eBbsOAzCiSfLHlzTjLvuKvqk051e4Uv9Fu07raideRS7SSrA/0nRAHOEYV3x3sYB
	Fiq2bikUbxiC/h6zkSO7WpjWrRlF86DTPEew3+CIqw9xH2X4/RLLWiPgHRhpZw/h
	Sw0wFAOqAGwC8L50O3JA69j9yn8+ZN/3A/ovltT/0XSWPsSloMVlyaMiPcl3qbOF
	wTcs90z6TS+YlJloWWjkw==
X-ME-Sender: <xms:C1eUaRbrGt02VfAGSyg8ZNCtsGkQLtC-U1LQyKOPDaeWAZFV-QjUzQ>
    <xme:C1eUaf3TxdHWbGm1Ien8UIGc3l8bDQGkz6lWBGs-z6toqg7ZVIAA8Sb5qcBdJXXlz
    fHPxJX91bhj6QksgP5lUTSE15vy1jF-7AbPiCuNxMPLWP5pbVnlYQ>
X-ME-Received: <xmr:C1eUaRWZahXtT9ZVbqBuTSLFjXOfHmJUmg2VqJfy9KuwSVvU_Hp5tarcR4JFD0kP9g7Yb30Ddh9ECQb-_DOqeXeqRTm3ILGDBDGsFooaqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefguedukeekffdtfeelleelffffffevveejieeffffffeejffefgfetueetgfefheen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugi
    hfrghmihhlhidrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:C1eUaZWPEiKSbpPcfgMkkWpsJxr7a9EtblS3CNMAfyYh1kwSWWA8wg>
    <xmx:C1eUaQd8pCyCyBgKa7Zbz88Ro6dbAeHLsbHq5bfSCXJwWpX3UZWAzw>
    <xmx:C1eUaSWafDxkaGmvNK64CzLlewZ0CJgJBQJwwQPIeCRVb-PfyUcyBQ>
    <xmx:C1eUaZfpeVFTvsoi3pRr32QDiO8Oezf0dKyk20nCBnsLmpJikw8wQw>
    <xmx:C1eUaX186DnLXp96Q524VkVW58aGHe-buip6POsHWaffMTj5gxKtvbRE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 06:54:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac12c6d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 11:54:48 +0000 (UTC)
Date: Tue, 17 Feb 2026 12:54:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/4] Fix tests with missing iconv(1) executable
Message-ID: <aZRXBFIMEAUQCJAu@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
 <CAP8UFD0=7sCe6oEG33gb8Gzug_ig4m-breNJeUbBk1AUvuaR4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0=7sCe6oEG33gb8Gzug_ig4m-breNJeUbBk1AUvuaR4w@mail.gmail.com>

On Mon, Feb 16, 2026 at 10:23:16AM +0100, Christian Couder wrote:
> On Mon, Feb 9, 2026 at 1:42 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > I recently noticed that th MSVC-based tests in GitLab CI started to
> 
> s/that th/that the/

Will fix, but given that this is the cover letter anyway I don't think
it matters much.

> > fail. The root cause is that the iconv(1) executable cannot be found on
> > this platform anymore. This isn't entirely surprising: we depend on the
> > Git for Windows environment to provide necessary shell tools, and that
> > environment of course is not a fully fledged MSYS2 installation.
> 
> Maybe this and perhaps some commit messages of the patches in the
> series could also talk about
> https://github.com/git-for-windows/git/issues/6083 a bit now that we
> know it's related.

Yup, makes sense.

Patrick
