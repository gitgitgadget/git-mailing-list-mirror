Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51E1448DC
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162425; cv=none; b=r2bsbZwtvFPAQmVGHQZlUDKfrdvy8DrY5oblZA60w2D1oZXiqiJQpMATdXIzdCsqB20ZWYtK/q43ZeuJ/4LFHXs1Q0C+kXTrGL1W95RX6KushVf7sk0rWpQHpetL1up6rlwdQhBBmofVB7d8VDFbzg5+dFmDrPWwQIwLqV1VVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162425; c=relaxed/simple;
	bh=slr4AQdtktY7oFuQ+kAIoDtjMORxKejzpJ/uCyg8zR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6hC6Clw5GdMOFlwwbOQ76js0gUzn8YgHpIXCQpjig1gMTkn8h2AT/pQCcfjYSw48cauAT9AZtvr/PT7zSdL4s9wAvbgh5GSfjyDp6BEduhc6/kNt/xsXVrmBW2IomUs+O8mPZn67a8k3MzttA3aX2sDNyIsMNR7424E3BVx7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OoPZ4BdP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjt0cvwd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OoPZ4BdP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjt0cvwd"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54545114034F;
	Tue, 24 Sep 2024 03:20:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Sep 2024 03:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727162423; x=1727248823; bh=/W0WIhcEBw
	9wFlLVr6cKb7T6xBkOTmi1XtHU/Lyn23Y=; b=OoPZ4BdPA2xNxyvPwl+o9WlROj
	3T+IitZDds8b2u0NVPYl02COB2EfjZrExQ1ybGiPirEuOCwiX4g8CVzxqKkQxvq1
	QZkqrzZUeW8qpEH7C7qLi58QWBRmnFn0QswAVW5m2QaA5Cr5/o7XFotJ/woCCUqy
	YlWPCg8f824+FoihRJcQ5R3nBlICBF19n7uz6eQeD6N1gWhGCfG4j5cau/HcZEyM
	iRmvAQs9C2fTVjtLu3wBSs8zGtPFXPfkMzKZMtiZeSYSQXJvfGQ1ZLaBLcxJTlxn
	znBNVxD3a+LJWOnXxh6qi/eeaJJ7kmLo9TsyujrHrlhjC3DG9UZOo8i40m4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727162423; x=1727248823; bh=/W0WIhcEBw9wFlLVr6cKb7T6xBkO
	Tmi1XtHU/Lyn23Y=; b=mjt0cvwdWd+XpllXomRuOooBKzBvOg//bhx4ZXQI/3gO
	BSvImJ6xDjBG6NXX9dT3mX3eNtyVjFOwe7QU+hBRRhtAmwa/qNHEpOSfDrRHzokT
	Lz80IKL3j4+Ib1sH/wtEgL5TcTSuen9LnkZ1eBTlMKbW1edo97AYPV4T2eYc+lPJ
	dyV0UTryzwsGe06KLpKCcNvpR36iKOgbER1Jm2qP1AuPX9EVJBMfJwT5RyRIkFxQ
	1hiikSvUVzFXnEaV/YwJKOjGT25p4epCksIk3Cfd0TNI+kUNm6qs1kVgLq6gpnW5
	h5Xd4AAZ7YgL0fMWxvlWlDVuL5unzeW0p9N+ttgksw==
X-ME-Sender: <xms:N2jyZt57JH3Wh37xe4YgWhuIXBWdcBn3ers65daW3Ugkp3GmzRDEVw>
    <xme:N2jyZq5NcAzT0gpXHj9-vDC2xw0XlApEhiX-BEnLNXjxuu7Szr63ObjSO4ih_O8hc
    CjBH-Zk2VEGyhl7sg>
X-ME-Received: <xmr:N2jyZke_Y6mthcPmKT1tsyZsq7u_k4Rny9aNg43bSsJf1Vmp7AKhfdRWphzc7mmO7Kbvg3UMSX3hDo-a0N-AWK4-N750xe8-qEuyCAP8KSbvew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:N2jyZmKnqen5v3X48pscxd2q0ROqAq3xCjoCS3k6RNNAvg3ofwZ4kQ>
    <xmx:N2jyZhIVOnBLsQj-4rULQhJz0JgVSLVuUal8HYyfOTKACMzDoNtyLQ>
    <xmx:N2jyZvzAJ4F3cv--KHsg68XFJHMgZ6DQOqR9CLJ5n5cgXUs54cqQ2w>
    <xmx:N2jyZtIkPZj6mrBAGswQDjlcmSQqCrjvdqGHxAZ2_zuZaFda2FjoUg>
    <xmx:N2jyZoXy94CzWrwKUKL9ZMK3Cc-N9qwM8FwZ7g8IrQ6DM8ObWhH7bWwo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 03:20:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 695a96c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 07:19:49 +0000 (UTC)
Date: Tue, 24 Sep 2024 09:20:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/23] builtin/pull: fix leaking "ff" option
Message-ID: <ZvJoM_JbJKPrgHnC@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <747c9a76a288d6fbfad85203e0bccaaf4b6db282.1726484308.git.ps@pks.im>
 <xmqq4j6a45wr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j6a45wr.fsf@gitster.g>

On Fri, Sep 20, 2024 at 10:00:04AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `opt_ff` field gets populated either via `OPT_PASSTHRU` via
> > `config_get_ff()` or when `--rebase` is passed. So we sometimes end up
> > overriding the value in `opt_ff` with another value, but we do not free
> > the old value, causing a memory leak.
> 
> Good eyes.
> 
> I have to wonder if it will come back and bite us again that
> OPT_PASSTHRU does not pass through but creates a new copy, while
> OPT_STRING borrows from the argv[].  I guess that we could check in
> parse_options_check() if the address of the same variable is passed
> to both OPT_PASSTHRU (giving it a piece of memory we are responsible
> for freeing) and OPT_STRING (giving it a piece of memory borrowed
> from argv[], and would trigger a failure if given to free()).
> 
> In an extremely longer run, I wonder if it becomes necessary for us
> to also make OPT_STRING to make a copy (which means strings that
> come from the configuration and from parsing the command line
> arguments are all allocated ones that we are responsible to free).

For now it seems like we are fine with `OPT_STRING` not copying the
value, and I haven't yet found a situation where we cannot work around
the alloc/don't alloc split. But it certainly does lead to an awkward
calling convention in many places that makes the resulting code way
harder to read than necessary if it did allocate.

I also doubt that avoiding an allocation for these gives us a noticeable
speedup. After all we're bounded by the number of arguments passed by
the user, so it's not like we would end up dupliciating thousands of
strings in the general case.

So yes, I think that it would simplify things quite a bit when all three
of them (OPT_PASSTHRU, OPT_STRING, config parsing) were duplicating the
values.

Patrick
