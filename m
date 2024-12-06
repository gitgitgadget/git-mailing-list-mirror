Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F0207641
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499899; cv=none; b=sGDIa8iEDYxHo+9MHKGBYM3lT6MxaHAbxaxh2LAFcd+4D8b6PUTW0Lk7iPzNxnx9DIUL2N/Vu+eziLWmsEV0Oyvr3DvtUgIoQdtHz8um02vo8C7V09Sut3TzeKXAoqaHKVe6caSJekYt4NOeHFVTohhb7Lr4rsbQdb3Y2++QAfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499899; c=relaxed/simple;
	bh=wT80jwm/IM2GOSkQAkxqwbgDhk/PNAEw9Kx0qZp3ANE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlZjnq9FWt8VsL+Hqb9tHFGmcyw/9YZj8HaUnk3DF9lc3slP1kLtHHl2UFXjxR36ONLCbYLw73C7i6AJ8jyA3a0ZZ6huwMh4WHtgwMo1xCMHyQ3FcSSpEci+A6wAlvfaYVHKwnWRGnIoSqqO2gI8tzLbANcqZJVHaAeKOCw2PBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SEwhA19/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gj//GdZW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SEwhA19/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gj//GdZW"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 07769114019A;
	Fri,  6 Dec 2024 10:44:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 10:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733499895;
	 x=1733586295; bh=C28L6tUTWtMZsaPDUTZSyjm5pg4U6iKaDQDiWl/ztVU=; b=
	SEwhA19/mNTdK9U0PAp3Avf0EtTdMGe3MlN3oxp0NxfCRS3gEAaFMjKdhS+VfY6C
	C7gsWLtMbNv9QAJ+jho1oPCGJ/WAvWiyGm5b8v7EQ78EGId3CE6Btmvp0HTyip0E
	F0kUgrTlD6JRfYXufsal/wAiRbrQ0QEGcovz63GNGjhnuHsABJ5SXKPB8J1gPety
	1Yi4guS0ug8c1h6aWRi06s1fY8F+bvneH2g3TuyQVyh0HOCCv9tOCXkm3hI8E6kQ
	CF2ThNU835uVdleWJgjAeTMpCOChxouryJZyltiZhn0B9bmU97LeMtwVIO/RYU1d
	8WOfOCQib2B2fIpIEustKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733499895; x=
	1733586295; bh=C28L6tUTWtMZsaPDUTZSyjm5pg4U6iKaDQDiWl/ztVU=; b=g
	j//GdZWEyvlpp9PxrC/6vEkfHk5sm0cZeVb2xy4aCIBTDoLVJdKAlfB+DVB3KcXx
	9Z6tzZ4T+1tEQTY3IVQF9mPO/Y7I/Uc3gompmkqXzIYwC/0nBfyqht5B/eSWp4gw
	pvTfmumK0E0Taat1fpgV2e5/Txng2ZNqBQwr0qrI7ccLdjWaZDDEZ23o8rDNfa9r
	C7lD/8R6eg7KUoirLdjchdq2WVnL2ehzY+8zj95cLtbxU9SP/r/wOwMBV/gRnOOg
	4bcWcPAZ4E4hX1mr9jCzl/FJXKMDH4bR6HVkIP/U9/1Oo8oCqn9JcyM3Sze51i4F
	NsLfugmGGtcbRQ1cERHQw==
X-ME-Sender: <xms:9xtTZ-3yh1Upm-C5JUAEK89b2E5AktfXgMvCU7OqQ8ERAIDa3hra1g>
    <xme:9xtTZxF5lU-hW6rf3QQmJQ1rcX4jnPRceAIH6zTYUfmWCBpdfkykqkklL_mp1hP8F
    gU8NwA39QyyFEWAPg>
X-ME-Received: <xmr:9xtTZ24qdn4Tnse7QZLhjPT-g44LJSCrjlQFf84aXl_RYTNyXxhjnWria2uRetY8KRMh_C4JXs0D20rZIkUdsZ3eyoaDDNy6ZpvwKE5zdwBzWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteehffdvtdeltedtteeuueekudegteetuddtgeeuueek
    teehfeeuvedviedttdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtoheprggrrhhnihesvhgrlhhohhgrihdrtghomh
X-ME-Proxy: <xmx:9xtTZ_1Qusg_are4U6-5sxUfeGyZ-ZLjjOFFwZdZoLOulcG6L3Ri4w>
    <xmx:9xtTZxGOlyfjqQ5VR796S-jHE8ljEzhU8d41JAvgmbDV_BI1I1vTeQ>
    <xmx:9xtTZ49fvTvDBQfnxeMyxEzLmWWYj2CGVswzsCTiKlxy0sb1vlBoQg>
    <xmx:9xtTZ2m77R9KMesjhsEfFqUB_gfjsIIKOT2uOIL7z84jvqPZRBYPig>
    <xmx:9xtTZ6OBZtZu8BCx4AGvFuwwYBUy7Zs58hNFY_bd4yafmw7ajbitq9ua>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 10:44:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 578fcfae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 15:43:28 +0000 (UTC)
Date: Fri, 6 Dec 2024 16:45:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Aarni Koskela <aarni@valohai.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] object-name: fix reversed ordering with ":/<PATTERN>"
 revisions
Message-ID: <Z1McGsD8nG5x43g9@pks.im>
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <20241206-pks-rev-parse-fix-reversed-list-v2-1-190514278ead@pks.im>
 <4fc44fe4-cf34-4b6b-a073-8ad5b02fe663@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fc44fe4-cf34-4b6b-a073-8ad5b02fe663@app.fastmail.com>

On Fri, Dec 06, 2024 at 03:33:52PM +0100, Kristoffer Haugsbakk wrote:
> On Fri, Dec 6, 2024, at 13:28, Patrick Steinhardt wrote:
> > Recently it was reported [1] that "look for the youngest reachable
> > commit with log message that match the given pattern" syntax (e.g.
> > ':/<PATTERN>' or 'HEAD^{/<PATTERN>}') started to return results in
> 
> But the regression is only for `:/`.  Not for `HEAD^{/}`.  I’m sorry
> that I wasn’t clear in my previous message[1] since I didn’t establish
> the context properly:
> 
>     I have indeed noticed that `HEAD^{/}` returns a sensible thing while
>     `:/` does something strange like finding the root commit.
> 
> What I had noticed myself for a little while was that `HEAD^{/}` on
> Git 2.47.0 did something that I wanted (and which is documented) while
> `:/` behaved (behaves) weirdly.  I just shrugged that off since the
> second syntax is more useful anyway (like Junio said).
> 
> 🔗 1: https://lore.kernel.org/git/Z1LtS-8f8WZyobz3@pks.im/T/#m0b68bb083d5ec6fddbc2af2ec5886a7a884d27ad

Fair, I should've double checked. Anyway, verifying the behaviour of
both in the added test is probably still sensible.

Thanks!

Patrick
