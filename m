Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD038AC79
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901336; cv=none; b=Yihf4zRcaibQ6YJG6V0hv11j/J8yNXhvaraDa25xVSpitkc6PkZAQEJY1anuy9jhyG6Od8yIm/aBZLdSCcH2AxMy+GIxk6Srh2vy5B+Nly8tfGWZyln/Y+vRphagHzvkgPG9Wbq4bnv3vKWS6rkV8V6lHIR6E57Kdzu2PvNCwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901336; c=relaxed/simple;
	bh=434hTrrLS/OCN4S2UPzC/MXp8Jk20512QfBaBqGeh3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHrYfPIRxQ6Tepvhhcah+qCNh+nJ2HZSGjnP9tOyCZHfgz+YY/3R4jZoEVpxlqjKrZ+4YH11CPVW8CiWpMQdqvSBVVuDtNkxl0c+zwvMBIWzn9DDRTgNXIry1WSSM8nSI4d2f9ey62TlCP4mvkIjbYMyCKrfTueUsUFV+r+OsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PZjXYVLE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xz/2uOcd; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PZjXYVLE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xz/2uOcd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6BE9E7A00B7;
	Mon,  8 Jun 2026 02:48:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 02:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780901333; x=1780987733; bh=4NcODGkCxK
	aA5eDQXhStrIvuNhzWpYJyUwUxfouMyUY=; b=PZjXYVLE4FOOz1nphQfqRdO9Ok
	rzXGzVzrjl4zVvrpDTWS7Z2avHa/wKIEpPIYD9uSO4l7NcBgFqTe5MEsF9+FpQ50
	a/ZiH5g0cPUTe4lonZZ7CF4EAYWcOEjpWoNiSbGZkNYBjyuinlliOPE6S1Q2DBYn
	ytIrhGdsYwVBqU48nSAyxWQMRH1CSq5Q9MTjq2SUegBQ015trMwRgslZ+u1rbIlI
	xxCGR6bV3+CCqEelKJUpx1hq7mkp1R1RiEz50nrTLRdPPQTPB95wBo0NBLApvCzh
	vG5Yr15WVnRqzRmfAEawka/BEKk5WFJiJs4Hp3g0c0W1+4JyuULwNi+HC8LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780901333; x=1780987733; bh=4NcODGkCxKaA5eDQXhStrIvuNhzWpYJyUwU
	xfouMyUY=; b=Xz/2uOcdNGce5SkVgLpFlkQvu/HCLsvK0sOaYVSz250sYWMGmuJ
	tODD+y6X2RwgP6PvCP6qE9ye0qoyuSCHU4Nx3ftGJle3NXujVHrxA+AGuky1Nsqb
	4t/EF21gCjuCry+ugL7VIwhAjx310pNJv+UQGAz9r3qZnAqfTee4Lkdub72/8yEG
	z40ibAUFid1skP3WRwY26D5wO7sFrw7X+Rj+GuzP/7+k7Ru/zIOsorEb9VOMapIH
	ePJGYIP9K6Uz6FbO980ToKHfYss11JNRRlucNavJHvCgkc53kIMGFBlwqpee8dmH
	+BZBtrjO2xWBiwmOh9iqq+8fCzuyoJ7pIww==
X-ME-Sender: <xms:1WUmavOfu2PjZEd3LsMYTmD-lJn1mr8-Zr-Z-1rCV3F3xJp9UZG7sw>
    <xme:1WUmag1TyFE22Fm-qNfD5oaCJGQqmGvxr_tccu86_nrm3X-YZbEm6CVGPhT5SPs9j
    Aj_ASbfv_XZce_tzVGP5ow8VLYLGcmVH9slHp23H0SpmrILuZ7new>
X-ME-Received: <xmr:1WUmammd90Uaon6m_PjoTXtKcZubMeeTVGZ7jYLgyzZvtA4EeQrCN-xJ9EyMaHl5o2_j6k2qPp6ue-CobHAAO847P9dbGoEgLFMHOH2Isw>
X-ME-Proxy-Cause: dmFkZTE1vg+MTl7/Gnw3PMhCO+oRY6BoQf3ByqmTH3+XryLoNm/kFUpZ/ApT3U+SNOX/mg
    g/Kx2n9STsanlaQ+RIv4kFdyeogVYkLYp7mJP9OVLR8afAmk0nu26F6euzyAIYxhR85yTF
    Zh2JDUnin0IZ/jqrha7+YczrjuoUfbwi4blW6/iTAZtcSj58PPqOoJyzkkrL0lG+I9tyby
    RMEGipgt6esA+vpHICYWgO/G8eiSSFmoKZoGMXjgGTVbxNiMFPxdte2Dc3ogEUnVrN7e/a
    STyaYo82AAMG7+Gu/CSu65/NL593T/2E43Ac5DLRPcJouFE5fXX67iwySIYCGBKxbos2ly
    m0+xB9zOs4qxE6Q7DJwUpGaXa/muiNlY1jAlI9zTYk9myTZPwEcU1xpVvLTY9wEYE8H6w9
    9pWw+tJX1n8iNrWRnbgQSG7USCzVtCCexIxR9QE37M2oqiHuOkCr7rxDqdtrkvtB7KdHFn
    vv5KKG2TaUrGEOK7+tZ5CCOfu/abQ2gPFuy7D1fkjbWKCbabFdP5lg6OqUc2VuAC8ptfVj
    tD1YlaC7p+ukMam4jCP1vAitEiBuFn2FY8P33Xf6AJ8IYvtUmAhQtaoMn6D+mqShOAiNdV
    LCQb5IwevXKIbSCwShS0xHJ++cvpPoJYUcsNcBLQ0kUG7DnbJe0hJL1I3AAA
X-ME-Proxy: <xmx:1WUmavWFR_KGYoAOezK-FMoo251IYDGczPfwlNzqwDY5zOPBlbRe-A>
    <xmx:1WUmakvkv5MCCpY59pvVvm6HNPNrK0EytW4VcAkVy5XCwQiutTOBaA>
    <xmx:1WUmaqbv79KVfnG0krICN3ymAE6xTPyGWCPYf631S5DjzcjkggMJRw>
    <xmx:1WUmarV1uZj75lLLL3Dv7QviXa28BZUz9gsHBg1IJiinsHVy2X6CQQ>
    <xmx:1WUmarP5wdBbKqZVr810tqu3BPM_a2_iGe4cdleYUEllk1se_XalFbK9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:48:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba877b9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:48:51 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:48:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Weijie Yuan <wy@wyuan.org>, Tuomas Ahola <taahol@utu.fi>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <aiZl0ce7lnRrL4bv@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
 <ah-Nhr2PboWUq6eU@wyuan.org>
 <ah_PyDwO1Sffr5yq@pks.im>
 <aiAK9eLvew+mgWt+@szeder.dev>
 <xmqqmrxbp0s6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrxbp0s6.fsf@gitster.g>

On Thu, Jun 04, 2026 at 10:11:37AM +0900, Junio C Hamano wrote:
> Having said that, I've seen a cover letter of iteration N (for any
> value of N > 1) that respondes to the cover letter of the initial
> iteration.  While it seems not to break "br" and the lore archive
> does not seem unhappy about it, I am not sure if tooling used by
> other people are also happy with it.

Yeah, I always use that style myself. I mostly prefer it because the
nesting for long-running patch series with many versions is eventually
getting out of hand and hard to navigate, and I haven't seen any tooling
breaking as a result of that style.

If I'm the only one who thinks that style to be preferable I am happy to
adapt. I'm not really sure yet what the consensus is -- I'll send one
more version that includes the changes, but if we continue to be split
or in favor of the current status quo I'll drop those in the next
version.

Thanks!

Patrick
