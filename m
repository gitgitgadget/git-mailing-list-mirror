Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE9395AE9
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339229; cv=none; b=knSAWVPDiDvzcviAjGjKHOYZaqDqlPi2dwsahmFU67rEW7qh5VfQBmoJLYbJSEqiX6igD35bmpKhg49ji5xKpQ0dVo4+5v2rdmJDXPpwpofp1vkGiFGY29Z7AiJuqiTAN2sNXnIV0ARPTfHiFgYdVjnmpC4GWdyozabnIEUAiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339229; c=relaxed/simple;
	bh=V4Shp4XhM6tn8cIcPkFZp9Av8z9u9dB/69rhFjRnDJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FegxHOTBrARDiyhRgRq2EykJORBNy64nftG4uuL/6HHE7Hs5E71wHIeWHaXnfXWj2Nr3S0uIVP3Hq62uWGqZIFXj41trAd5EFk7G/R2GtNi/h3NaVjBhw8kp8dcB6h2DHtuYlzyQcBkxhtB5t5NGv3Tol5hn3TUfoqwnNb/3g+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aIXzFLSW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPuJRbjL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aIXzFLSW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPuJRbjL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45521140005F;
	Mon, 10 Aug 2026 01:20:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 10 Aug 2026 01:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786339225; x=1786425625; bh=DCpE2lsbas
	UmqfoTxpT5H7lM+WKH3X6LXt01ACZi3vQ=; b=aIXzFLSW2TakVD73xAYZl+oK6S
	RujYfbnDg7uCYqQggZb9reXAgwmKPvAdPlvP3+rJEENgs27mnm//LB5PoBtttqxi
	Cluu9lahgP/IsuFldxBM88YbOHV/HNRQM4mzKuc7PBtdz8/WKg6reLohze/SghuQ
	x/x8yxt4Mm3Qy+z6t1ZAVCljMSu/iFRfnpa+mlePdyZ1yaMwm7wLrzJlN5wwA0do
	EGt34RBxkBLJdnbXKnD2U4eJEf3NpHkvfAjzYb4kXTR4+YjvhIQTlQw11Itg/qRI
	j0hjqV6q2H1BD/CDeNkjc6wqlw7oSjCJQjvETJ4aIUrQxPNB0yFHi19vbYDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786339225; x=1786425625; bh=DCpE2lsbasUmqfoTxpT5H7lM+WKH3X6LXt0
	1ACZi3vQ=; b=DPuJRbjLGFekvy/Gnacqg6LChYO6wvsk97T2OXebxr1IF7jay4V
	hQT7lYe+I3ttGd3w1JY8G8c0RcjF+Q6XoeaAPUPrHl+4j05oCunJVmuWoNL+vdbt
	iac6vOu1Zh8vMw/BKeYJ8bruMD25EXEGe5tQTVwZuylstfdaKia1ApL/+5+oDmID
	kul+JZ1Zqmqlqh1TsBS266nyzUrfWmPag1Hah6Unx3qRNQDv1u3z7Nowd+554qGZ
	LWY6n5neg0s1oBoAyLG9GPvybzCeTbeTLXyocZrVjl+e0oQmh9QnkLXf3GWrazlI
	yg5yBmMa1m0uxJ//py5X9bDZQHWx3RCVUtw==
X-ME-Sender: <xms:mV95avsi2llGW2Zr13PkJppwZuUkIsVikovwxlz2hUQeOs4Dw9btFw>
    <xme:mV95ancn4Yk9uDIPXtwPxIdBsulYzxsPcPPZbyxf0o0Llwl95tGkzJVKENBpYKJEj
    CUVmG132pkgBiYf1nbGEHCrnf52NVrkbD2OXMEQCTPlpYBtFZ9vhQ>
X-ME-Received: <xmr:mV95anzF8P_G4MEp76d9tn7Os8N4YZBlaPr5UVsC8poufCsm1mm9Gob19r3o-VABIX5YAWSufbCF-y2BjlAiKNblmu_bUY_upIccDOqx9w>
X-ME-Proxy-Cause: dmFkZTEgSXdJlt6DcqgQPjBSGLMqs0+stlfFk+BKHvmQyshJMgbPn5fjiTMQOn10ErISpt
    e8bcutX3YiPsLgaU+GOKRm6vMjfJ8rcdw8I/Wj7aQrqZI3Va/xVMyEpHBVRZab9KE2jS1I
    6RLks9s4Ky1cZMEDAdZKUpOQKlfasmTfgVI93N79Ia5ZlY/d+fXJmFWi/QoYSfHR1BL74H
    Us+GpUjWRZCFDKpvP40RijJ4xdEHK5PeKoeda46WGH7gn9q4XdaSO+svgmctYdWf69MRHu
    2bfZ82GFkkssfojyY9r+dbJX+iHFpXGsWRIqjToIekfumqPFN40441zIQsWZsvdVG7PGRT
    4e9PPk+0ZQeQ+WIyi9UCBgbxK4fEsd15Qc+mSDxXTDhtuJRFBdX2Wlisd2dbEBWzRY5T3d
    V7sZYUD4PAgyZfYYuC1Bkfba6XqmWOfTHmS7sm2gwE2YQeBdGScSx/FNroNLesVl+1UZ0s
    AdfBBbJJ40GgicR2tXy52rTvoaYMx5BP088krDHzaFLRzArE38d+h/HfNV7DGtEtUkgZCa
    OivYJczUvCnYKfkXjOtDGKG+NqL+Qpmim9sil2M5Sho8sSif+OCHqqiTVUPYIuv/TJYS6H
    ZiEtckYAkO/+EelxUkjXx2uhv6l+GL7uKLmNFNCsKtgKWzG60WoSLstjWASQ
X-ME-Proxy: <xmx:mV95atGLYbocVw4-vpO6hsOwgm5ysSWDCrLNX6ZqEn7aWs7m8SLzPw>
    <xmx:mV95aryDE88K7Bj6kTe1YEHGn5nc2xingUXt7smWfjpVBaz8d4ZcEQ>
    <xmx:mV95autMkHtfvHdzoxbwAzBSyHBnnBjwIOff-Ijl-OrGhmMbEWeW1g>
    <xmx:mV95ao31GnyanMQvVxeAB9Qg1ZKHaoBL7dNq96UQiUA-_kYexmLL1A>
    <xmx:mV95ag6FHjDf50QSedzlSWkhxOfQwLwbRmGyMr5HyczpheEFoN72WyUD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 01:20:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1395f36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 05:20:22 +0000 (UTC)
Date: Mon, 10 Aug 2026 07:20:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
Message-ID: <anlfk0P7UillhlUd@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
 <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>

On Mon, Aug 10, 2026 at 06:43:45AM +0200, Stefan Haller wrote:
> On 20.02.26 11:15, Patrick Steinhardt wrote:
> > Introduce a new `GIT_TEST_MAINT_AUTO_DETACH` environment variable that
> > allows us to override the auto-detach behaviour and set that varibale in
> > our tests.
> I have just run into this problem with the lazygit test suite, and I
> worked around it there by turning off auto maintenance altogether. Some
> more details of how this affected us and why can be found in [1].
> 
> I'm fine with that solution, but I do wonder why we think this doesn't
> also affect ordinary usage. Lazygit's integration test suite doesn't do
> anything special, it simply executes git commands like a normal user
> would. Maybe a bit faster than a normal user would type them, but for
> scripts that create a bunch of files, stage them, and commit them, I see
> no reason why they shouldn't run into the same problem. Or am I missing
> something?

It does affect ordinary usage, but the expectation is that a "normal"
user should not care about repository maintenance running in parallel to
us. It should be completely transparent to them in the best case. Git
commands should just work with concurrent maintenance, and if they don't
then it's worth to have a deeper look at why it doesn't.

The reason why it's not fine for the Git test suite is that in lots of
cases we assume a lot about the on-disk state of the repository. We are
often reaching into internals to verify that it looks as expected, and
that is of course racing with concurrent maintenance. And hence we have
to be more careful than users, as they are not supposed to reach into
repository internals without Git or an implementation thereof.

Patrick
