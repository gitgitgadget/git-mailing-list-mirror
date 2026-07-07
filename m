Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB9346A1D
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463108; cv=none; b=YualNr1z+A1D+6E374E33afrI03x+2NfaT7dVTd9pPSdCTA5sbw+9GIUGlUhL6qlr9Oa1LmUnGEQNuHqOHB5C8cUTyqgb6qaGpO0ydo9w4Hoxq3vjSUi3yuk3N3vwQkgcLl8Pl1wQ8zpAc1VmcUJsJllTajwrp5o9tG/coRo7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463108; c=relaxed/simple;
	bh=EPDlYfJ9DndERduRz734x6bWXeAnRKVNFxEdidVMonY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwrI/GxZruLil2dKiL3wDzgIiBkREGjzKkMNnogW5dOfX94KQ33N0jfZmL4gbObmrUgWxAzfol4fvyh0OIlP1OCvLjApSXbi2IkLAvCDVclJ4S7frwPsGyuvnvo9fOU2eFfdb0CjlET4IWkt0Y2Yo9A8YgqAgyexrAJEBvuEHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fSB6ZREQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYgc56S6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fSB6ZREQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYgc56S6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 244991400127;
	Tue,  7 Jul 2026 18:25:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 18:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783463106; x=1783549506; bh=EPDlYfJ9Dn
	dERduRz734x6bWXeAnRKVNFxEdidVMonY=; b=fSB6ZREQ/sCxQH3jjm9kOTj4mM
	UzN383Qnogto0CDjaT2KWJsRb7R2zQIyIPOmLLuun9GC8EMcn4Kp8m1vP4VnMdpr
	0GoZ1/RWz5LSYVCLZveiyUROFokaxyneoNesI9zusktRAHYmk4xemH3HnZzfjt8u
	cCi74oM3/2YlBmvaO1Ra7CsEHNcsnhvJsS1+ILg4elz1OZiNM/+iIRjYXW8wlgZZ
	nQ2+srHWKZTeSMD4RfnA2oujjzXVzu4GR7qs+kxbMqlUv/Ig/ZNbqkOEg0t6JKMz
	J0yM8sk31Sg7OotZsqWvBTSawCqR4x50kg/MbCm+LAEUH5pP/4YHAXurhcEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783463106; x=1783549506; bh=EPDlYfJ9DndERduRz734x6bWXeAnRKVNFxE
	didVMonY=; b=IYgc56S6u28blz71qmtdjhR4o2ZTSXGL7R76/uVjzZO9CFa8ROE
	ZYoCxSCIrT/BCYuX5dYP2anbyoASfFG1FwOSmdYULL8aXl8ocCfeWGthRhhTj3pO
	Db5a31BoEhnXqZpX0KB+F6bR+5uY67gv9HUwd+3iWX+Hm/WAHb1Xf/VYH0NQquXf
	y+1+SjTAPe97/J6SYli+qoPVdZ+H/903qSvStyEeJGyvrBdBFuaQTa/DLBan88/5
	EFOjx84ZUvreukthNvKzRb+6KVfNc28rGEFGplFuR73nXVQJKG2deYEzdhgbJ90q
	yDZpAOvAssk5ywu4pDPgxkxrmI8V2FtzqvQ==
X-ME-Sender: <xms:wXxNape2hE4JRZZRVNSpL3ezFOW0-CEjZjsNxVzH6w1xHshFWOAGig>
    <xme:wXxNauFO7gr_wj-GMWNNDRz1GNnHXa5hVYrgipOrx4_nfF-58pKz_ZDHC9OvXoxll
    LwZfWnssNAm3h5avekpYAju_aCJJ42w3wic_BWdhWgVYbhBu0i6lMk>
X-ME-Received: <xmr:wXxNaq1O1DraASjIpMcHtJvQ8uYXT0NEtu8RWTDSI06PsH_RkwfT0mgQHGmn4XyiUKmiJe9nHarYSuUycnJPHReGb2CfOxUlLZQXwHs>
X-ME-Proxy-Cause: dmFkZTGi1pI2ty2Aoe2xMbl3ZfooRcpmUjXaMe7NycHDCCuRwHBMAI/DpRUZ9iGowhoU55
    vG4wXWGspG9/GeQHCmkcJ0PaF4E3ciAWcaTlK4B35rXbitUvTN/0JQiMhdMUsKF9h+jQci
    wC031y564T678mAmGsbKKbdDtGvv1e8Oh+tRFWnHTTSCrKYZVo5TjJEfLELEmQI6NcxQ6X
    nx0D0+yy0clM/05L9p9ua0em3yzgn/SnrdeCVU16AYjEGhrnTPyoxdX37fJnOcjqc3WwtL
    eVLYrWyup9rNTeGtLzXwlmGlUf0UIoqFnv4b058vDBx3Op5dll/bxg2SpP/578W2zAmOLg
    ac6ABcSMw/2wpsplftSjH50RAwMHvvXF3AcDQy2KH76JDLDVWLwd3fnmxyweP7RgnqiGaa
    ZdQ7h3nRKWldru43wH7tE2Thd5JCciJ42QtY0m44JH8dc+ialqHKgH1oNsCgovumtxUUpO
    7Ap3azobqqCFoeahq+Jergfn9zvdfEAdoYQzvEgOgMttGy7zT1195qtS2EKIShPrY6UE1S
    n+W+xbQTPIexRECTkMgcrUlkhKjIHgg07xck7VpujmtVzKghfq7D/tWg2Bo6BaRPMevfRy
    nL32HEzT9UHn1VQCurjkqLTTJyH7xIJH/WS1DcIbtvyk11a1l+5E7MG6CQCw
X-ME-Proxy: <xmx:wXxNaukXMt7yORjOo1JTDuSwJAW8dLx3LOMaHMjiJ562msuhH8b_KQ>
    <xmx:wXxNai9Bsepag_nOBZ8XMxSecsLOqJQ_hsZJkFTb2tvVdmF9Oeey7w>
    <xmx:wXxNarpUWQtZ6ZtAzf4CpbltBF-fAW3ufnI3pBMGOSmJH9H27VaJFg>
    <xmx:wXxNajl32dRl8bLg37RCGpwQpa8DP2TwGIMAqpFqjO5EgRlURpPuxQ>
    <xmx:wnxNaq1j_zEsHi_kJIHL-QrkumiUkxxKOrN0Q9AW8r-x7fYTb-WQf4dV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 18:25:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 4/7] hash: make git_hash_discard() idempotent
In-Reply-To: <ak1yazHtP_OazDaO@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 7 Jul 2026 21:41:00 +0000")
References: <20260707045556.GA1288172@coredump.intra.peff.net>
	<20260707050700.GD1288294@coredump.intra.peff.net>
	<xmqqqzle7osz.fsf@gitster.g>
	<20260707201808.GD11780@coredump.intra.peff.net>
	<ak1yazHtP_OazDaO@fruit.crustytoothpaste.net>
Date: Tue, 07 Jul 2026 15:25:00 -0700
Message-ID: <xmqqqzlezbcz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our Rust code makes calling final a second time impossible because
> finalization takes `self`, not `&mut self`, so the object is _moved_
> into the final method and you no longer have access to it after that.

That is a cute trick available to Rust but not many other languages,
I guess ;-).
