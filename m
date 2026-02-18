Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E02D0602
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771398602; cv=none; b=adLqTGtAqyxT0aaxVeRDPKKytNx7bIyXYEiaWyOMnvQhuf47TQewLvrdCHWGWYptVTnluBLgIVLRYhlIP+1fYFkLRRs8mBHes9KXDiRasYq1tLUZFBl9AGiEK5f3PQI2MRCLQQc1ABFytqelJH/+y6AyfkapfQW8EAPPVjAFeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771398602; c=relaxed/simple;
	bh=Fd05Uo5xr/AZykvFrlOEA3nkTFeFYGnn/LNwSafcMpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd2sRYQjNw3ddPzoB9U3s9IX8sa3PlUbAFMZzp26fra61XzJH/gbWF8VsnFrBP7T81eFCU7oZWYFQ8cQpbGaApfFZXUvAcpsKuRSEmjnKKrLPukagxw8BUHeVcWCv9lui/OIxDgQS38a1rPc1y8LAPS9baf94PAALevfUfRnzow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=byiWZDkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qE/nbjy4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="byiWZDkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qE/nbjy4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57BD17A0148;
	Wed, 18 Feb 2026 02:10:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 18 Feb 2026 02:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771398600; x=1771485000; bh=cEyiJGJHXz
	ERBmbTztVKJp/IdyCuH+d0Wz2pbLFa3Jc=; b=byiWZDkTWRyBeP0F5H/eMwX+To
	LaaWVjz9BZPZcSNfjSqgyf82V26xOyn4XCd4RHJ0l9I7IDb97CCme5OINtRsZNDk
	YnNbshXTJfFCQvDG5USA45oBziuTrOQ6VgDhJe1GCDfmxcAhxmifHaxRNs6mxANH
	aQcREU97kcjMVrr6mrDrdtcQRInlHXFOgCkhSjDkzD7x71I1dc+kaOWgGpV7SUQp
	0SSdH5TYAPnJwBsgn893u7sWCe8Q9BwZ0s1awMlRr+Gu6YToh/g7wfunUNvjrlPH
	JfIRqbdYkS4yB3SxfX/V9ZznwekyEoVkqEzxZ1EltjDH86rsMjGX2G+5Jkmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771398600; x=1771485000; bh=cEyiJGJHXzERBmbTztVKJp/IdyCuH+d0Wz2
	pbLFa3Jc=; b=qE/nbjy4xiYFXPtpSlfP7y7wMPHO49kJwvnfCaw+iA++G4779Ru
	bvQLf3SGwKwtTw13RaQZVU/GGp/dEPOXGCGXdOzLxg7xE+5sv0zJDWwwp118EX58
	bWoNpSlkgFboDKLeZw1FjU2qlUYt5CHARbOjEU9mQ/HCvt5euSQSN7SrdXjBuvPi
	7s07hpjZb4ZYlliItoAXZNQ/dPNKMDxZqFOGYhY0C+IQ7HivsVfTjHIMkGZJlolW
	lpzBjcHil6RfPXJa50ZA4c/i1pKAbwwG5lCBbYZeliM1F7n/5tejVclfTzqy6/Eb
	MWMA5bP0D7dGhh5/xgBoVT4iBQu/huJSyFQ==
X-ME-Sender: <xms:yGWVaTECsZRBeyb_XqwWfuOfXJh1E4QcE65hC3qRgMZLPsSRwKdC6A>
    <xme:yGWVaWWUFbP8B1Z3HfYfyxyq7_tvhQQYZWpQ5njmW6ikrEW4zGXUxTNHoGFlOntA3
    leKepjPD6evlYeMAjnCTNsFEBZV9D3mQQIpI2K5fW2cSfAPJWQ8JA>
X-ME-Received: <xmr:yGWVaSzj5zoI0lFj7V8RiDoD972PrFLmOFhoGdLQWulDDddqXoWzKoMtgK906QrXQ30NZu5FsIXRVjeWjrC206yxzysflDE6lVTulbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:yGWVacOKPydhr7yO-BWIi45irh_u9l0JeTRGu_XPcT8jv4pi1MoHgg>
    <xmx:yGWVab7EQ7yQOsG1IGeTcL6VSwcqN3OaOTaoFFnFLEu6LDXXk6h7xA>
    <xmx:yGWVaVNkXcyFyMhMy6sq0F8bWItdnErWn9AJ8YxykacvUULHZsehIg>
    <xmx:yGWVaRn8_j21Z0zMBMdrgxZz-r2DKxPBa-I83iPO3WgMPUsDCPLdew>
    <xmx:yGWVaT34oK39GfD_FphGlnMiCrFSNOFyI8hfT87nhDVQA2OxuajHkvGp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 02:09:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fb6aa99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 07:09:57 +0000 (UTC)
Date: Wed, 18 Feb 2026 08:09:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fix tests with missing iconv(1) executable
Message-ID: <aZVlwleQAhTk1BZf@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
 <20260218064613.172817-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218064613.172817-1-christian.couder@gmail.com>

On Wed, Feb 18, 2026 at 07:46:13AM +0100, Christian Couder wrote:
> (Replying with git send-email as I didn't received your email in my Gmail box.) 
> 
> > In any case, this patch series causes the MSVC jobs to pass again on
> > GitLab CI.
> >
> > Changes in v3:
> >  - Split out the changes for the ICONV prerequisite into a standalone
> >    commit.
> >  - Link to v2: https://lore.kernel.org/r/20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im
> 
> Thanks. I think it's better with the ICONV prerequisite changes in their own commit.
> 
> The series looks ready to me now.

Thanks!

Patrick
