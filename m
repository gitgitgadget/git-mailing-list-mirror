Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4E3DCDA4
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524472; cv=none; b=BMMKZYgI/19G/X3q5ma5NBMi2MY/k/E2S5ew4yJgex4bWYWDjrXfSpVX31oUAk1jbAyeLgI66EhK6jiU0z5g8Y7c8we9kge++8oiDOuWWm9KS6gdbbNqq3AmJ7tDkJE6Z+weo/vtsU7KpOvbGLPKY7EdPZdGbLwSH1A1DGGySSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524472; c=relaxed/simple;
	bh=VRCZBBH+EJBPQeC7K8w94a2QBEhhmpIgv7EPLNDSAFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAj05qZrqSxZAZ/jCLmGwzg+h1J4ofXNdVOKOplXt2fyst/V2psatBhLg6sEKywJ8+g0hzWtjOJaTUvjwKEZGhnqdOJR8zjbvu+NDO8H5Q5Ce8/dxkKiViAksAy7bkxzCWmDIgpIXIuyTIlDsO53HvJi90ZZBcULiCLfcmdZl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cwxjx8TT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bE7LqL1C; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cwxjx8TT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bE7LqL1C"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76D3F7A00DD
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 01:41:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 01:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791524469;
	 x=1791610869; bh=VRCZBBH+EJBPQeC7K8w94a2QBEhhmpIgv7EPLNDSAFY=; b=
	Cwxjx8TT1sa52V/teUJf9bo6IZ10QVXqzfawvfUk3tlMaVx8FqH3Tuw5wmNtzFxt
	yN2UNQ5J1GDrDhJmdyw7FZi/Zlndj75Y+YvNUDENoee7m6v/giKxHvZuYh0PzsjT
	ve6jzgVdE6id6uezFXRmCkmjALxEgRTJAdrLaQPGy7gZvsz1G4HU7UqZKa5ZYpdX
	iy3jET2rCAw+ilxDteT6/TiJqtu8cxW+Ne7xm7ksd/NpnFmb5qel96XK0lXKNmI2
	ctrem8rahbZZJ8c0bp/gRRrrrI+0457Y6iUx9x2HdARz6yDF6A9GOu3vFByRxrBk
	b5TfDbowthUS6voDqzBHHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791524469; x=
	1791610869; bh=VRCZBBH+EJBPQeC7K8w94a2QBEhhmpIgv7EPLNDSAFY=; b=b
	E7LqL1Cyw3ybDQMUSfwXLziVndqVTPOC4JJrAKFUzhT5ZNCt8r1MKsZvRDeB8WNz
	eFaBO8vnyOW8LJghfTUS6KsTD3nve3z+WVbe907oJiTbJlb6ra3JWPJ0kOJ6KU62
	vwy+7WOKX6tdDszrrg77hBVRq/kzsYhydATX5vpFzMJW/gSU8q/ygMKIs0/s0Ygp
	q91Cy9EfqKYAtrpqWQFqSYoaSgzS2VHvl794r8se1Gf4CKU4ObsKRuQ7tusoLcX8
	i7Fom/p4VpVrCYFZGNXfi0vEK9/Vj9gUmHymLcCiQcA1pjQmvImQbZck6NH8Lwqb
	XVI/tcz2GSycApKhFt+Ng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791524469; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RhYZgSllZqe9Zwbpb1gMDA5K+aH5GkWEx4aWkvFiQb+pH7F
	Ka4izUYoqG+YLqFgZpHFsgenO6RjkLry98EMvgg9+l8I/RPRwWPLEEHK+fatd8mN
	bRmx7oFp4+/n2Zj4v5qpA1s9gppHa2kWnM3cH6sFCCXvB1mXQC2BCwqQfDhzz+Mi
	BAC8E9uMtFT+hYv+auNb/tgFJ4mKUt83w0GZLhtjF40+uqBSOWzSqRGDHfHoqYdD
	yWFCIvTLoXNOpriKXN5zGUlnO6zR4dzAgCpdxcyit2eVmLrJDnh6ttb14x/Lx5pE
	bYiaU2PqNY6tDf4Vecy/ZUeAV42ewyhWFErEdLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QyEdMC2humtcBQrpM3RUtRpwFXoyC+mYiXnFjUrYOf0=:VRCZBBH+EJBPQeC7K8w94a2QBEhhmpIgv7EPLNDSAFY=;
X-ME-Sender: <xms:dH7IajhTwuEjdCUsO-CvOgo-Aao7Bovf-0eSyeCPmFofEJ83LHg-fA>
    <xme:dH7IanB_UGE9DeMXtm2hFiktSz3iFjn4zm7Tx8Z1-b2q2QLo8xyXBLGIb4Tbwcb-_
    QRDbX7pcJjsaIubXsF_mk0YGLpEAGOJ_xHV9QVpgmZb5vHVGf9HlNs>
X-ME-Received: <xmr:dH7IaoHw7srPQmluEkzWZ-K5cT1h6tNfQDzrM5hiVArSJn1f7SCqYQuRs4PGXUI4yloM7Q>
X-ME-Proxy-Cause: dmFkZTFHwwAXoap3sDXMQ29SfG7FImV+oJ5NSH2+LS2MYfF76xB6Z8fOvdRCz/pZjhFfJ4
    ZLTmqw5g6HOPV79m6njkYxXZ6xRv9q4a9suPYwbPD+G5O+2lm4wtkfXkQPZ7jnPyPHuSAj
    2FRV/sMKSbO9ZFPMFxeWqJb/6oLfvEO/ThpRQDBwQ+3LHJWrQqgmSwyF6+oZyxIlZXhI49
    MPdu4HfY2GvaFijI3p89kqnqmes+J+wdhALKryxRYzA2taO7f9mA3Ez/3Jh7dAh/QGa0Zx
    Eu2zneSJz/ZKH5bplT+lbsGjl5HNIT9tFuuaFjCwZ7JqCTV1v2xK0t5PA+qK6INu5Sk8GM
    vGB+LEzG5hE5GtQq806EtslEkbGawfFl8X0c9E59shM2Ma4YaAYdkvkeItmalNnSA0dXYz
    Cyr6EfMpRFaS2uXqQ12pkeiQ6qOff+PlxuAIpLNjvPxQdZKCZ3vIUkKHoaSWw7GfOWoTun
    fAQxfSFjFpRAb+ymMmPxQjXCZojqI2fyW5C+VxzdYlaE4TQ+XI3wxrI/32C+/XOpWpp87K
    oj7YInYOtzt3Tx3zMiwTLSlkpNW3/pVF2HGfCi1cN7bNpIpktN/nJewRHszktVohp4Fajk
    PAzoDKw+07CMfndnzgiI3AIzAFMtNzEuEsPwunjeXEEi6O0pwA2BCGASqyPQ
X-ME-Proxy: <xmx:dH7IavJa3IEFkWeZpVCY8TWuR-gev1Z5GjSeqZmxWqV_nFeiGVWmuQ>
    <xmx:dH7Iasla4aRvLSbS6364LxaZJ-ne2iBZjrskB1JlnoQPMsFSqfbqIA>
    <xmx:dH7IanSLZvnUfw4ALZsT86nVLyDbK8OPRkUEsBdHolUTU-Qz2ZfEmQ>
    <xmx:dH7IauKrzgAxkFk83LhMeOpXAzdB-2hGBGd90ZKRdDm9W4YrKFpkNQ>
    <xmx:dX7IavlhUujxCHvLGkVrgTPuOSugVo2tkER6NVpT1UcqPD-pJSU3p1P4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 01:41:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b18d93bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 05:41:05 +0000 (UTC)
Date: Fri, 9 Oct 2026 07:41:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
Message-ID: <ash-bs4-WmGuLyCl@pks.im>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
 <asdsIjNEUOpaAnX5@pks.im>
 <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
 <CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com>
 <xmqqqzi02o22.fsf@gitster.g>
 <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>

On Thu, Oct 08, 2026 at 09:06:32PM +0200, Maciej Ciemborowicz wrote:
> On Thu, Oct 8, 2026 at 5:46 PM Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> So realistically, my choice comes down to options 1 and 3. And that's
> my moral dilemma: I don't know whether it's better not to submit a
> patch at all, or to do the best I can with the time I have, using AI.

I think one important factor here is the size and complexity of the
changes that you are proposing. If the change you're about to submit is
smallish and can be reasoned through quite easily then I'd always be in
favor of submitting such a patch. But if it's large and complex I'd
refrain from doing so because chances are high that there are lots of
nuances that the AI will get wrong and that you cannot vet because you
lack the context.

And I think that's something that was true even before AI. People that
want to contributo to Git have a bit of a ramp-up time, and the guidance
has always been to start with microprojects and then work your way up.
And I think that guidance continues to apply even when these newcomers
are equipped with AI.

Patrick
