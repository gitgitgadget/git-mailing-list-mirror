Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA138239F
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615497; cv=none; b=bHxqtlDcVKoOLXea/MoeJ0PQot++7cVYp+FnXfmSS7osQD/U6GySekdC4EaXan08ct9z6FWTOVJM9nehPmBLtofgpC36bD23QYEMbc5y4mLrtzFfDCf3/YzvO/fk6FuqKA/kgvj5md1w/ZtlVfjMoR5N2IBd3MLe9dbspj8NXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615497; c=relaxed/simple;
	bh=k3tVxbwQnFfenJo3eLcqnyoLKZSuSQVzz754p3TPafE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs2p3gHkRJgyBIp8Ng8U/22HvWB3b7A6fCLtSWj6pw4G/HPB4LnZy2nGSVvASReK55y73ExXTIaXv1IhItO3bMbWvcaRHZ1/7TU9M2Q1gCkADva+J9EWq8L4FrDJ2GC6cHCDK71zadc6Pyg4MlFg85lmsVsONpP+OKKJz3qpY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E8PQGQgt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WT2haZxQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E8PQGQgt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WT2haZxQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0115E1D000CB;
	Thu, 13 Aug 2026 06:04:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Aug 2026 06:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786615494;
	 x=1786701894; bh=b1B/A2aFEgMVbIP1FRQkpFc/UTrnDJMzxhDMUDRQLcA=; b=
	E8PQGQgtk7D1Ui0cJm2yg9RKZw1PRhKIVOxrNgenvgy1694TucklFym7tGq84FPg
	gEWP3EDLB2DJmCCyagHORtyaIiOOrLfD4PMFzaQav6zPd0icaxh50NgLuZkQ0sLq
	qt73lc/Zy/OC7p5483UIUbKmeFI4unCZnBDDAPikPILrxJopXlu2nkkEWpYOjLOr
	B2gJftzNv19EoaEH7akk7i5dI9yOqPuWdAu2/BxtltfiEs+EEHs45ZIxdUay64gw
	Gi9/XYTX3HIrHTrBpwgaLN04vrKenIBfJH41hWsXOqaAFkeXJBFI1j+zMDiANoFJ
	1x4ixORiuESSdyejNRwYpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786615494; x=
	1786701894; bh=b1B/A2aFEgMVbIP1FRQkpFc/UTrnDJMzxhDMUDRQLcA=; b=W
	T2haZxQmGqk/9NILTklnR9xYyOltjQdAdlw9QEZ5YvAW3ohdB45o3Rk+fQfr5asf
	Cf5WhICvoVTZBQbfhchHjVhnkaP7G6kTW0WHDx8mnOUJ/+h09bUHUdTtL6Gl0WPV
	dcajdHTw/51G4UVXMhs2xkrypXRsJWryn1I6twKGBuzSIpHwz9zQBx0MRioStVCY
	HiMrK4fi84EjKk8Rgxwk70VThCWDEyrQgVukYY1mf1DoSk0CpQmJgNW6Rj3fT82T
	ReeXE0DgsjxtGypT/sjPYYm4hQL0qKpJ5o6/qbOJBB+OO9Fo7wt62A+u5BO+IYqo
	aLZCkQcylkr+LIBtxcstA==
X-ME-Sender: <xms:xpZ9atYXswB8nmL4XMa0baIAd4OrBQ2la7mSeTJujxLBo0tMZp7y3w>
    <xme:xpZ9arYqIiRB_GuoMP0UMt24N1L_s5XjbQ0TLlWgXV1cG8n0pBmQeORgzTWwRkaeG
    zuJME16q_qaJboCm59B6pd4flaXYYS3yLmLhpKo-Jd5G2p4MnoE8ls>
X-ME-Received: <xmr:xpZ9ak_BnbbyiiknWPiNP3_sibYkOUZUgqxObWYFZgUOh6lX9YEe0CsVj8EE9swnwgQTQi4QfR3ZWBHqS_8REo-4oaec7-RwyFlVh6w9F7Kf>
X-ME-Proxy-Cause: dmFkZTFeO5BSzqrlgK9DlansWF8rBDH1e2mpuzTjgQpIcv/7FLrAWQQDAkyt2q0htzHrnC
    WQqKT3IYQAzoBMypjgo+gxydKLaR7Ao8vLVD2Y0EpSnYQ/dvNRU0g6Qrg4zwndW+TDWTgs
    tMxS5VwzydAOxxiSaEzdoEkOBsppK1eZl5pLN77Q5DBjcGQYsvxMKw9D6W0kw4/lBYmxCe
    +1ZgiSddeT1mPpGXrfv82WVJ3Q34DMT37/DK03KqOSJv6I9pPBozUxUTfHg/ZqPMStlGph
    gbOPkMXi2ndZ++eN0lOp91JMz08KvGK5hgi9MccbM3qmonizcOM+SyBnN1BsubHmB4Moby
    uLwjvz2hlON0NAkhDoMkVuuYWNalDFlz/3cwIbvyd2YnCGSkKJKl83pjT8tuJY3ZxW/VeY
    lmZJ7VP+i4hdNE39UAEKoRg2YJStDKbvciXBmXGtUT2Lr58DJIYIeDQmoNXMJY5va7RWIx
    gDvC5m3RhQdH4UhRrgUcqqdwGAQw/yBWJXQJHZ3y76GVRX+OLwvaAqr+P/i5IshEBv69Am
    FH69nPAdmVJoDjKJq3hfVmcmB97LBDKJL7bcsRfaJm7wB9+BWtX3vt15N+OLSgVZBXk4qb
    SncvaCfARZR4B5syxSCjaWGVlBn3Bn0iRsIpDRyUdodNfjGnH00wcuibfKKg
X-ME-Proxy: <xmx:xpZ9aqhWzAyWiPNAiMfpWmtsrneG5iTUS3PD6Fd2Ic-vzmgUShwD0Q>
    <xmx:xpZ9akcL_UijQJKWBNRz-t4sPxhPjQxBfD9q1NyPpHctW1K9vnTNHQ>
    <xmx:xpZ9ahrl6bGhO_qAyKfJh7Cne49W3lVM1vMuzRE2KIU8BsXpQxsoiA>
    <xmx:xpZ9apD7Tiy7z9CTmJe_PxzncpQOWlFXpXijtYcqGrvCb9G4DuJOCg>
    <xmx:xpZ9au7Vc1KTW5PE_sipb8j5jSAo61QH_awedX6v_GI3RfFkh9A3XILE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 06:04:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9720ae5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 10:04:52 +0000 (UTC)
Date: Thu, 13 Aug 2026 12:04:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 2/2] doc: format-rev: use [synopsis] on code block
Message-ID: <an2Wwe4ytilGoyHz@pks.im>
References: <synopsis_block.af9@msgid.xyz>
 <V2_CV_synopsis_block.b4a@msgid.xyz>
 <V2_synopsis_block.b4c@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <V2_synopsis_block.b4c@msgid.xyz>

On Thu, Aug 13, 2026 at 11:57:36AM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This code block uses the placeholder `<subject>`. Let’s highlight this
> placeholder properly by using the `synopsis` block definition which was
> introduced in a34d1d53 (doc: convert git-show to synopsis style,
> 2026-02-06).
> 
> Yes, note that code blocks since commit a34d1d53 can, on synopsis-style
> docs like this one, be immediately preceded by `[synopsis]`, just like
> the command synopsis is:
> 
>     [synopsis]
>     (EXPERIMENTAL!) git format-rev - [...]
> 
> Cf. verse-style:
> 
>     [verse]
>     'git name-rev' [...]

Thanks for the additional reference to the above commit. That helps, and
you can see that as part of the commit we have similar changes to our
docs like you do them in your patch.

So I'm happy with this version, thanks!

Patrick
