Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C66BB5B
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369365; cv=none; b=kvxVR5g23Vyqf+t0Zjx7hjRkaXFkEEl7JolGQhQ5PberFOcG54oduY3DkYDB7mamRimh3vqzAUZCsgz7aAAGiq/d9FTqHCyhlzMlZuuxXQ+NwisazCQlDpahk/8Ui0dZMv8oujZIQZAdsEKYW6HTMljjHZQ5IOz0mPkVSiEd6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369365; c=relaxed/simple;
	bh=eV9xkQZ7GlqIBMmMZrCBnKEYRvTt5SO8T7PJsLMmnBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw4MYN1AObAYyeL9AdmTo5Vqf16VYxXpzYyAvvWDHp2zeWGs+dJX7DNsHsQ89/xHHVJ3ijDdm1cwna7s94Ex3/uo3gMU2iGpzYcSbwihCAcnBKbtbEBixf+8UH/O0CBwVTjU0ZqnCotkFYcKAaIXeqAVuSpGneSeYkH/mYpLqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UxzK4bjv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4VI6kX5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UxzK4bjv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4VI6kX5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A46B87A00EF;
	Thu, 25 Jun 2026 02:36:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 02:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782369363; x=1782455763; bh=OlFQ8l6Yju
	SM77A5lgKR9sQj4VqeVyV8EEivmpfKb+U=; b=UxzK4bjvrqphDv3+tpS82FTt1w
	5T9k3by2vK7bskMdIwIOI6CYZ1AEak5n1hm5skIJFYUPs8CBly0pgHVi6npaMY+O
	BAGDw9zQtpP0EJQCjexqZatwYX8diX5RTZsn+7WkvOtNykI580Ud8KZ9r8efvlwa
	xMRe24joTHtVd8Tw4m22OGeA41KQuMNu1HxPCr0IeK0SQ1aierpSQ4zMsdMos1cM
	B27Dd3uGr8a3EbXLL/K14+bJMB0UKOOVD6mbAyC2QA4tEgqZxOsi8uQKykG15jk/
	2Jz7sobOG7EdcksUnzUlty2oOjqemkRBKnUtlCPnP2cjwEnIhPfzmdg6zi8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782369363; x=1782455763; bh=OlFQ8l6YjuSM77A5lgKR9sQj4VqeVyV8EEi
	vmpfKb+U=; b=g4VI6kX57cC/jNtFp55BwEgfXzk8Ux3ng0NSj4FDmf4udct3zBc
	FvjCKIfonjWP1JTrlRgT5tBQ9wtavzNR+5EaAsEblbGGfjPKmL2SLVRT7wrgKdPO
	BlguejzajzjFsoeXuqznEhY0M6RLRJ8mmseUJIpUIFoCABfnGk/2eQ+lf+ZBYhV4
	stDZG3UaKjbBdukbG/kYuMOe1D4PXCClD1vKIwoVLKdm2mCJ4/TxZ3kX/kIaViiM
	u9hiQBjvfpdDRTTo9t6v0AdoNMlAK6DnanDzyCoFzDWLIfe52kX4Fx5N5h7RQFKS
	NGw59o5LDV02yJqqYkfur0NJffkOV3Z2oGg==
X-ME-Sender: <xms:U8w8ag2BeiIlpunfB_aNsf3IPMyBFW69AIlzjY1V9w-6r2QuMSjLfA>
    <xme:U8w8alquAGoY2D47INwaCRhPazL8XBCzMRKHgoVc4PCHMOc57LSsPkyb7zF43IJJB
    qMiCRuODZ500mCmlp6wUogz7HnpuaRDj7Ysr2UlcrQjPJo7AbGaMbM>
X-ME-Received: <xmr:U8w8alcmB18EopmH_p_4r_c3Ciy0L1LXOuS38TRPrAj317dqHjP4s_snRWkrdbAaFwaUu9DLORCex4KIBe9hP7VWcIZc46hgKjssufsKjg>
X-ME-Proxy-Cause: dmFkZTEEFS+bhG+sjDrwmLPwAOCcSG0vk8bzM7BwQP28y0bOnjQc9ZaaN8FLYNWign/bzd
    Oz7K1UBafnoY65LAC1BF2ZZEWLXj6hHEcm/wWKkA4h25LLzv2wfJ11E4LmRQ+pkuVvLAyF
    jBNyPa6bMke4WNnFmA1FROM6FhQtNh6Y2uaffsD/XjmaOLNazE9HXpH+Gnm7Bak7jVYcLx
    Rcc64lsrG3l5vEBrX1nmbojXABpSe80EocRweA9YGuacA6MXYGbVP05cr56VwKtM3mx/SL
    wuUdAg+bp+XQ8h3rduIOJ/3xOMyeliC84LeonqOTKWEnTvkVKCCHAgZMvjblo5B1eNuIaI
    8icbBcY5FhvN5JlDEYwvx04GegH9UXTBknfWNwD8Z2uqRNtmdYba5f1vTi6n37cuyYfzk0
    ve1QC1Dlg6SFskJ8jThifIR1PVAtR1HpdPM3g7y4q5Wsf+jsupfzx1rqH87VghXMTW+4B5
    nVLRzW/kY6XTm7ib6NiXR4KdK96HvEvU3JFQtwtflrpkaXDUBjNLZWQxL2zRq1U74O0AWa
    gugO0XrOHuAK8HZ8GWN7xK4BOBHyMUWZPKHi2SAjVjy3dxpg7vw+hflpzcu/op3ZDOHPWh
    pdxmGlNMABKjvVA3+EHsbDmSOBX8uchvRjWqpRQzXAcKWT/7F/UjmAjRKZCw
X-ME-Proxy: <xmx:U8w8asqy8lm4QQudia-XMXcuoDIYDG5TymXiEFIlvHwOVe8EoGHgPg>
    <xmx:U8w8auHpxaU3agd30Xc0Rcr4-i8pYUCP1_NJ8_J56FMZsli6AjEwDw>
    <xmx:U8w8akvOu6Yzvv8EBcH2p99CnwoCoEOAekPjVEW_nnDlItFAHTGwqQ>
    <xmx:U8w8aoUenwvFp1ckDbumuBJ5nACuLCbYDAEp9xBXQWOZR9X01atFXw>
    <xmx:U8w8aj-I369pICEL9j5QaAYurJqJf0HGoUwaRG_4eTR1Eeh8oTrAGHTr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 02:36:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35a00066 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 06:36:00 +0000 (UTC)
Date: Thu, 25 Jun 2026 08:35:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 09/11] reftable: split up write options
Message-ID: <ajzMTTW_UzTvldN1@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-9-018475013dbc@pks.im>
 <ajxR2fLRsIvNYFtz@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajxR2fLRsIvNYFtz@denethor>

On Wed, Jun 24, 2026 at 05:06:32PM -0500, Justin Tobler wrote:
> On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> > When initializing the reftable stack the caller may optionally pass some
> > write options. These write options mix up two different concerns though:
> > 
> >   - Of course, they allow the caller to configure how new reftables are
> >     being written.
> > 
> >   - But they also allow the caller to configure the stack itself, like
> >     its hash ID and the `on_reload` callback.
> > 
> > This is somewhat awkward, as it doesn't easily give the caller the
> > flexibility to for example write multiple reftables with different
> > options. Furthermore, this requires us to eagerly parse relevant
> > configuration when initializing the reftable backend.
> 
> Naive question: are there any current use cases where callers may want
> to write multiple reftables with a different set of options? Can
> reftables written with different options pose any correctness issues?

There aren't, but in theory it's totally fine to do it. One could for
example imagine that a large reference transaction wants to use a larger
block size with a different restart interval.

The only thing that of course shouldn't happen is that the different
tables use different hashes.

Patrick
