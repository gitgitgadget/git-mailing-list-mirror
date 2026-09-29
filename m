Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BB339B3D
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665822; cv=none; b=rBo4kCSyHb4Kld6t6t/w8708AQs/LpH199JlQVd1Dp+DkizD6MgPLdFQW83zT7cyPk+Vdc8Uml5QttfksnAUSpQ4Q/zIwlMV980SGIOEWZGieN72pJORt7eaz4/kgImiCO2S2DVtgNxSwVJxeDRfVoO2ORzN9oJTWWkWY93fgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665822; c=relaxed/simple;
	bh=T97xl/uRAWerN58ejNHlh73RBd+CGIDj1okdNwYinMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0dNVDTDf8b05/UOO2O9AAATWzA/uigJ7AU589mEhImqUGLZooNYByTZAUu1+j7RxnzkD2OHTCFg1f6U5Nd7eXLrntVG2m6qkmj09joRzqkW8GfE7g1iVsPwPqVY5anaremHECFRVXsFRInPWrPAwcKOhEk6Rm5ND6dKMKSJpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NfiMRgDW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7XIJJXM; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NfiMRgDW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7XIJJXM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAEA07A009C;
	Tue, 29 Sep 2026 03:10:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 03:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790665819; x=1790752219; bh=T97xl/uRAW
	erN58ejNHlh73RBd+CGIDj1okdNwYinMc=; b=NfiMRgDWnuux6eO47sdxdSRXPH
	HuGeykV6h12EN09K9QmAItT3uAXgM/TCTBqGwGmx8LpaeEI4jX4Q7Fa/yzL6fBXo
	RBxe0PvkhJYGpOrV0n2g5M3l1h+6V8xVuL5d3PIJQ/dvaOhd+DhfbEigzl+fliwF
	KB6hfSTdo3lY2hY2o4FvpriV0NgCDAVP1LhGYaFh+tQkdkX73pVZ6fHBJRKakJGX
	AkI8jCOUGHyuPE9xuiyXCKOA7fywOM9qCFUnjE/mUO1Uesa6Iz4grhguS9ZPvBFW
	iElP/bkVseTqM76gxWSXaUs1XxUdgHvmfho25LldH5esJBZr1JyVhCJgXsNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790665819; x=1790752219; bh=T97xl/uRAWerN58ejNHlh73RBd+CGIDj1ok
	dNwYinMc=; b=k7XIJJXMRAhl05OHx1T+vJEWzUH46a22+kBOesGFvRKO94H4Usy
	ADvEj/Vd7rScCR8Doz1lD+jYgVAbwNj4aHRUIchu1V6Xa+3+t5rqmMRcm9FueaDY
	nzte7m0yJ7JgC2Wqpp55pBSPP1xCK22a5gRy3iWs/i4AjQU8oeXK+m1VOhai74Mk
	n0ZQe7uxOhiu2dpsFni+swy0ecCv0FLuWdW2iG2282UpW9HgmjU1G1dlSO/lR780
	OmA6TqfJsJimwlnBdNteuRpG2Bnw//ZWhngwCcw2KCGzJOHKRrckKDX8IM1tujuE
	5xTYFtf9e8u/6EAlegWGFDxHm96zhPx2V5Q==
X-ME-Sender: <xms:W2S7avAivptkqlPSY_PGP09oxCt2HlTvUEKfyF2LfsE9u81sq4QLvQ>
    <xme:W2S7atQDY2GshtrXPopU3hT5doHgtsWwoWlxEV9sqHJqXqM_G3fFqEwUi4VGytSLI
    TxFq3--r-MNwiEp4slefIKz7G4QroDqEoYBM6gYJP3FMML1KmtnqhQ>
X-ME-Received: <xmr:W2S7atqUajbke1DAe5Kb9FmsstQ5W1u6eHEQfcfALnDojzuvuoFRmA>
X-ME-Proxy-Cause: dmFkZTEscQWFs0xi8++KYKMlszHRH96PEHtqvr01GRmE7NUeloRWT7lTL1MRl9O+Kxw1EA
    m4fCgk9EhUU+vi/pV6e2uyVFGZqgY/lv9mH5bY8ttMN3I7hY9IMiBBZvrHTGonDzSVj2GD
    uA4tS2rqMewDbjw6AO4KWyQEQY2PArWARMUC6heDrCjLFuIlTv7ZrpnD+x2r4mI1fXhu/K
    F68uDBZWtzFYr5lunRTVcD+zJOFmNLcU7IlJN9nB8CvvC1F+Wc8MAmMWeQATLQ/eLFMCt4
    3R22eEvCsB1vuKW03snzEduS3U/0TAI7OHzD9KOr+zgU+7Azwo48J1x+VI3Tuim0SkbQgV
    4zqyOFTvUBdrZt/dLb24FlAMRgqjtPGh1rzjedYvBCnS8tRYcNz7ChgdJsXGfDqg98ftQ7
    gI+6Znn53DRpkW9BP5RKEdjM62VIr2FSzkV8ib8HlFZX8ss+ekkWu6BxM4cjw3DjjGKXM4
    6pkNYmRwT0VreCzTrUYsl2jO7k6BK4tdJzoGn04JDFLm5mxVSmTAvSuWgLrhAlVjwhSMBL
    v1HZVv3OQqhhXRgXBY0/vDSnDuHl59k9BwdlKzqbEwholitYnIDD/zZYryFi3fLdGSllL6
    rMtSgSP6sSWeaJuID6/c/2d+oZi6Bqtv3IWdeLzKzJboFU4LEBep3PFKQgkA
X-ME-Proxy: <xmx:W2S7avy9pjxv00k8_TODi9KzHdgkGboHewGvChe0YyM0QR6Ekwpong>
    <xmx:W2S7aiJW0rvqzWNkv83NlatjK44riUQVxHNowyqBTmmXoxGQHkkb2Q>
    <xmx:W2S7ahL5dzioDWkypd1shpnVltYCoh7z8F7lrPxvUHk94JzjGmeZDw>
    <xmx:W2S7antGXXt_mwlWYP-0272cAVu4wC6cukSlPF6tx7ZmTuNWt7cQeg>
    <xmx:W2S7ah14Vj3yjmlU-ZgJPx9arHfpRmB_mt-Bz2GEpizOfUegBJ0F1QPE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 03:10:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4b83629 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Sep 2026 07:10:16 +0000 (UTC)
Date: Tue, 29 Sep 2026 09:10:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh McKinney <git-bugs@lists.joshka.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Reftable reflog timezone encoding differs from specification
Message-ID: <artkVoGEP0iLOGgr@pks.im>
References: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>
 <arpZ5xCwFXc9ikrj@pks.im>
 <xmqq33utphdy.fsf@gitster.g>
 <2abba760-d331-4cad-bb8b-6e567b517beb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abba760-d331-4cad-bb8b-6e567b517beb@app.fastmail.com>

On Mon, Sep 28, 2026 at 09:02:36AM -0700, Josh McKinney wrote:
> I think my main concern here is mostly around using multiple tools on
> the same repo and how they should interpret on disk formats (my
> clanker picked up the problem when comparing git's output with a
> library it's writing).

Yeah, and sticking to the spec we have is the best way to fix that, I'd
think.

> Anyway, nothing urgent on the problem from me because I noticed it
> purely in a development context. Thanks for filling in the bits about
> the real world impact on this too.

Well, I think fixing it is somewhat urgent -- the longer we have the
inconsistency the more problems it causes. I'll aim for having a fix for
this ready later this week.

Thanks for detecting this!

Patrick
