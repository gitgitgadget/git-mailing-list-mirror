Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119E27A476
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178440; cv=none; b=QUl95Y6KHNbqkCu8LfVtOEQ6cTXlK4cm7EQ+sC3i9sFIUZSqNeWTr2lI1pYBzs5eA0T3iSY68U+zyIKbKIIn1OYD8+PGTFQfDIWkplMRQkewj07aKJ4+qmTx6MHGLX6b2SRBNYZVOA143yLr4jbJ9cuZb+Bv4HBE67jJzq4uAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178440; c=relaxed/simple;
	bh=0+4s8tnnfMSzE4gvyy9DYJh+jTExT+Brc+rxOPkkK7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzKpXxTqHXUH+Z5y/C+BfAMFj0BNSbhblz3w0ky9lVO83BqaoW3Ho6c590IhgJ3sPtVx5gAx7KCoXdZFITsBxhQL+IyPQTWw4HHLGZKScglSR4oXATb90Tnlbjci9+jyc5ge1DNZvRJkFOPYlZS8SodHuAeifxKH2nPGvZMUUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S0BXmcCe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYwNdg9D; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S0BXmcCe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYwNdg9D"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A4B4B1D0018E;
	Thu, 11 Jun 2026 07:47:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 11 Jun 2026 07:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781178437; x=1781264837; bh=FV8QwFDUru
	TOsEbjqBnJ/ZA/387nBgdr18OrQZ4SRck=; b=S0BXmcCeIEpo+KU0ygVkc8CvIo
	n3ZuCRT1l41QKCCv51VOrfsARHwdIn9GUhAt8BFisQxU8USORNN54h+HCV1DLfXb
	JyjdNoIV6Z5rHCvR5oBwVcj0yV9q9rpFhBLOD2r3cM0h2ejEjiwPndp7l3yH3bSF
	Tw5hPF6pZFcJaelZJUqdYGlDVkLI8TJi9CxjuibR9W7cbQDHuRTaCLR4pOWpHco/
	xa3zcTh5Q6eHF/nwtHfDosUu+HXgrGP+AVkwKpkK4fCqVL2xVXl2ycCIkXCdKGEc
	9NIxHq8EqqjtssX8rK8HOMxiYAi3pAoUJ4PaUBKimrwnR+FXFBaHvi3fvZIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781178437; x=1781264837; bh=FV8QwFDUruTOsEbjqBnJ/ZA/387nBgdr18O
	rQZ4SRck=; b=iYwNdg9DYKFvm+br4Rbd0jALFtikoUxfSMBXzJgOElmFCTuwSr2
	taw45XgL0qVGJVPBeD1C10+Iy4YWuR85OcNxQO0q/I7jsaqnOZ9bLDLaDrJ7lBWz
	LESfUnNjcw3Kz5tbU255JiMRpF3GPBEumPseQG7XpNnH+AG3Y7bay6tTiepOAhno
	5RPNfjqLap3e76sr8mR7e2NWGKrQ7cZ5G3Pmj4AZ7VjIPYb29jTYcjHXCROQdccL
	kwKLZrA0oYc/azI56Vxp+50tcAKZ6C6wD65h4I0lI/oVOfKrp8UH+QtY8PzMFIE+
	k9Ly+DOVsc8l/1Fh4x7McCZO4P6orMuydRA==
X-ME-Sender: <xms:RKAqanxLnWYmcq_aGT9x-6-ETs5HH0PnxH3cCgPy_F_uzLnoAkfNGA>
    <xme:RKAqagy2u6YEkAzYu-m8O8k61YlA51p5c0_eLE6wzjrgtmNE_Z2-pj9jx02na7S7L
    66SUfbsbWh1wC4pDteMNIOrmNZpizeSq-AP6urYYuDZa8B1pRVGgNs>
X-ME-Received: <xmr:RKAqahYIoRNshKK-Q7IZFdTFZxofQjsoGzk9eeFnIvHxlYNHycRXoJEUeRYVrnva0Atyekn10_U5ukK2Zye0wMplXssstAuLi63cp2Zy4vCm>
X-ME-Proxy-Cause: dmFkZTELghkDCoKuLIe7LoQmZ1WbxEI8O0wBpAusxnFilWYlejF9cH59cK5VovfIF8mWoP
    dndo4z6bG13HcEVP2XHTOm1k4/2R7avt+vS9VkwnjCYFn8S4No4i980+ehZ3A6l0xpioF2
    /iI3h4t6WNTLj9bLN7hnbYr3kZi9DF9b4lQfcHRfXkMS2KGGEizyxJPb8kK3720ZU2uUC8
    VYhPIxuNmNKxSGOcFhfqlN6JbrYVOO1yd4jEh09QDWionjM8GZ2N+SFhXOnoSWtUB2k8cz
    VDouafeYeydJiBRZhw99JqNowJ4YrwdHJSZBPj+j2EGyp0/fipaX5xhRG2TiRTAxJt8FaP
    h9EiZGZ3Aw04xeXW1B6/hS9SsG3KbCtqvSBQB4mFb96N+PzkHEomI9j7tE29It5qz68iYr
    MV1He1oqtqw4rmlR1W9OvhXnhvnHlrdAasyTzfdEfIS3GwNaW/ni1uNBq7U5Nk/HC53X2e
    yPNgl7xLgRmHDa32bKwLkgtknDROCHFmRoQLmlcyRlmDKAWLZqSIqf37ArlI4FlAEe3TDO
    q1BhnFeVmg70X4eHmkdhj4b3I0nxpGF5zdQNX4dF12jv5UFvLIMv67Dh5gLAavn6K42ZLE
    tprC8yt2tuKp5Mbrx1zsWhKcU1bAIP1ppn6X7hcX76VJuzQwaDkyUVwswUrw
X-ME-Proxy: <xmx:RaAqahWPGJWBD1G6IKw7DaeK1R2si1coyq6A0pFX3Sasulu00OYMLg>
    <xmx:RaAqavgRl_-UdqCKuQE3M6AQ_opAWwjLol73-1iTBRjQsuvOlAnEHA>
    <xmx:RaAqavu3iCUxvtADy9COt-0gvWhcJ1q1acSCeFtX_hJTbpUDHLgRZg>
    <xmx:RaAqao4yqV4I2yFVs5QW71FpZOuH7yEo2emSi676pLr6HrGlLTka0Q>
    <xmx:RaAqaglqsualmaR_EMBRvTawQMi8Apxw2a8vEqzp21eMn9QOMMEorx2l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 07:47:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 076805a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 11:47:14 +0000 (UTC)
Date: Thu, 11 Jun 2026 13:47:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 06/10] reset: introduce ability to skip updating HEAD
Message-ID: <aiqgP7Yust60mCsC@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
 <20260610-b4-pks-history-drop-v4-6-70d5f0ae8c25@pks.im>
 <cfade236-75bc-4679-a74a-6da82e6a5135@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfade236-75bc-4679-a74a-6da82e6a5135@gmail.com>

On Wed, Jun 10, 2026 at 02:11:04PM +0100, Phillip Wood wrote:
> On 10/06/2026 09:52, Patrick Steinhardt wrote:
> > In a subsequent commit we'll introduce a new caller to
> > `reset_working_tree()` that really only wants to update the index and
> > working tree, without updating any references. Introduce a new flag that
> > makes the caller opt in to updating HEAD and adapt all callers to set
> > that flag.
> > 
> > Note that in a previous iteration we instead introduced a flag that made
> > callers opt out of updating any references. This was somewhat awkward
> > though because we already have the `UPDATE_ORIG_HEAD` flag, so the
> > result was somewhat inconsistent.
> 
> Thanks for doing this. I've grepped for all the callers of reset_head() to
> confirm this patch adds RESET_HEAD_UPDATE_HEAD to them all.
> 
> I wonder if we should add a check for passing RESET_HEAD_UPDATE_ORIG_HEAD
> without RESET_HEAD_UPDATE_HEAD that calls BUG() as we don't support that.
> Everything else looks good.

Fair, can do. Thanks!

Patrick
