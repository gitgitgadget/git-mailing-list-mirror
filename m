Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458382D781B
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156026; cv=none; b=Soa22ObRUm24FEeBaGn2icBDd9QlNx/Vrbr5dpXTovB/5nUzAWoguLB5k/5hlcJQ1734oIcyNJgMzvEOJulzVI16nRdlZEHC8uGkQLkUdgP/eVt+iLtN8mZc9RXNEdCT5mVy7z0EK/gdG+QkHQHpvQqarox+ZQLyTpNwIReIbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156026; c=relaxed/simple;
	bh=jGiCqDj4kErwjtIEy+HqUJztA67H8eOBVo/PG8CYUgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onukzQi/Qinm9di5JN46OVHnb6pzb28oxPjmPaRUUdQDJx1Ybk6YFBfsXoXKcTb9oDKG1cIHO7AUqRfpSaSTVHB/dztAaSleULBhBOl/EPMKw+09Bpc948F032wPmP7YAr7/yu5D/wQBFa0PQg2x9HhdxbpC4uYyymZUkVx2jxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UkSiHpgk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGlf5qfH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UkSiHpgk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGlf5qfH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 18B0D1D0010A;
	Mon, 31 Aug 2026 02:00:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 02:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788156023; x=1788242423; bh=BmKJjzwqyT
	Vcl6pLjyiqmLhZtp+fxwdRxlZNDUxsEBY=; b=UkSiHpgkqpmIAd3e2qQ3rK//l9
	Rio7zvpeYp9DamOZGjfaRxe0/G5cUZzEYcLZ2Iq9fYXXKOSh5u6kIIhbp187pP87
	FCiksqBsuIzYSWRQD1AnorcBGmDzPAFiwdX0MfOKEsTeCyfsFO0SHzC5bYtsyCIz
	OFxTOjCGy6KGWCKGJOwtn6AegF/ddUv2kSGJG1AE+uSurgzgvVA42v5wZlCvwHfB
	ZTDj49GPOFkoAsP4zDU+EesV98oIbhibADsxnIyFN+N50YKUCSSF8CNZZP09LEXm
	gdy5UWlVjxM8c44stsq2AesjZjwSo5q2UN54C8K8EP0JJzWSHXK/zDh5EjGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788156023; x=1788242423; bh=BmKJjzwqyTVcl6pLjyiqmLhZtp+fxwdRxlZ
	NDUxsEBY=; b=XGlf5qfHtq3thxW1gKCFg131RUUiwm0OdZlYMoq7jqkR4gTpQ/J
	JbLDnnq0GOJLXRJhz7Wyh6+pK6ePV11X74VGfMBTia1sTN5lwX4xr9NS+el85uXE
	7b1IV/7cwf59cOVmrT6S0elY2/ncxYG0H8mBlEfvxU35o/abcbjb4c/W1i9NxyeX
	dS9wzdDcitRQFHwtX48cA5WR+V3KWTxKp/fsGWx1Fms3GRgQ+GfkmgmwmlBeSZm+
	XLumQ+4nALGX7vmwb3vxFhOS2V7U5gmo0nGMFZo/2ySz8LzLapVFv50PnuyGeAWq
	alYgOwWYMICV8bo1pO1/kbSe81+AZ30iYZw==
X-ME-Sender: <xms:dxiVakR0o34JeeiHoX8RxhJ7ofMEVXtfFF9fbDeXf5r_ETYqiNStVA>
    <xme:dxiVanw4UcUaANBTsGAKhMvZpWSt_8t8XarvZHDl43c4doFqPe_O2pX2iw-54yuvP
    HepxPtLwtfbUKIS0qUjndi8rYA4sGUCe-JFlueroEajy6n0ttwi>
X-ME-Received: <xmr:dxiVavdq7cofw39cA6ZYr1JGDNYJt98rI__ruOiJ_LsLik8X-rKXx3CL6qt5DrbDldSRwQ>
X-ME-Proxy-Cause: dmFkZTGRrc/w/LyLEw89uV9Ke3SE18xmG6iVlp9uMrMUKG9EAZ2dTprR/goEVcwWww0Ik3
    gfm9nhxM2s62kdcZ/4RQhfzNhH1xrd/zBzH+bYztHVou4a3z3q1JICSnoRb5BdpqB5Noyx
    W7zstf8dqNUYLSWljObupyy4bOUyBD2oScZowgwrYUAHqRfANmvUwfUzpA4QeH/opuZ9iF
    ir1JEUPapFQ9Fy9AltuUsrnGDwl9rBaHV59h5+OuMyfix7/wHYc6fOB/z30cECA6x89KCm
    ANULxC+IaSbngYJUCAh7uyNy0RJL/OFaWO8XOnlY4bo2beuiclvyW8B6NqXbnw0XVwFhrX
    ZZCg5AbP6RcHw9oiz4kSoKcXTjgB9oMpD4n/qYpYz4i+mAjTZFVdFyCP8KYVg8fQpMEmKP
    I0xy3KZhpGQEc5C9rfomqfcXZBzmwZkdmtJQXLn7XEHGhE1rsDuRGf7bb3OL15rFADMka7
    rFTu6QINefhhnu5udAP1hSLc4Xv1f6GS9AV7sye2k0kNRb4HJCccciYsl+Hkou1sVC2MbA
    y31TO5dceE71BOUyk/PJpqcVfoQQDmAiPfLGRX6qsJ62vsj3uhmkHezMOgE6OXKkeaBCdM
    06MyJiZq2rSz+pUEPYeMAtK2Mltizko9gyQyXu9jo3i6m2fpJ89AHGn7QmLg
X-ME-Proxy: <xmx:dxiVajK-vqoXZhLw-gxA4__CIJk-_O9dN1TTZ0Pe14bXtBzER5cCxg>
    <xmx:dxiVagFl9q2AU4ywoM1sXDkSL3TuYxSID1v94B_npoK6GQsVppNdAw>
    <xmx:dxiVatrSKwmGVoo9vBx0qafiOWt-ztfDKhMCfIpIbQFHbqFMCnCOHw>
    <xmx:dxiVapRVpY-I0n-NGQHh14oCczlhNZ3egdHDdWijVxFE1btSY0AycQ>
    <xmx:dxiVaoATCWjX93FOHb6Asmjh7cdnYpgT-huRdM_04X94izTv2aOoFs1e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:00:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aea6772a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:00:27 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:00:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/10] builtin/fsck: merge `fsck_obj_buffer()` and
 `fsck_obj()`
Message-ID: <apUYbzzzBULal_op@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
 <20260825-pks-odb-source-fsck-v1-2-b756de0bf24f@pks.im>
 <CAOLa=ZSmjfCD-5fPgJm4cbaKZOQa0S62wAf+vSxWFWLrrgczBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSmjfCD-5fPgJm4cbaKZOQa0S62wAf+vSxWFWLrrgczBA@mail.gmail.com>

On Thu, Aug 27, 2026 at 06:03:08AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The interfaces of the functions `fsck_obj()` and `fsck_obj_buffer()` are
> > somewhat similar to one another. The only difference between those two
> > is that `fsck_obj()` takes an already-parsed object as input, whereas
> > `fsck_obj_buffer()` parses the buffer and then calls `fsck_obj()`.
> >
> > Furthermore, `fsck_obj()` has no callers other than `fsck_obj_buffer()`.
> >
> > Refactor the code by merging those two functions. This makes it obvious
> > which function does what, and it allows us to get rid of the early in
> 
> s/early/early return/ ?

Indeed. Will fix.

Patrick
