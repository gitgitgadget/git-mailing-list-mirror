Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B6242D95
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410291; cv=none; b=eD2ZwBY4+PG41i1/UcSBHxRkTA9B5C0Ut0QgdvkPjkuTf9iMsCwjsriAvnfovPaW0z3SqglUDnO64/RZNxAybb42YHSH5mazsDGX0o0McPm+IAajJsSvUsRhIhfcwH43U5CCOk2Jk6ZDkLvHAmp2tdSEQ2iZJo5i6EUQgeyWwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410291; c=relaxed/simple;
	bh=PVWk4Xeho6shcXzvMVQgoWtxakEJOV56wn+IIkizCNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6deA+Z+/IKiNoGoRBL34fa15ttDVezRT3Esv5kEmiYzYXcJXoqF1BLM8jgZQ6C0cOdoBySFRU2MhgEK4z8rIAxAWdy3paUkx1gH4AvZ/JRbtEf87PjWXAHwKe0Ebn4tOUtEIf/cTkxMY3/TiA5LU7mCh6/aIDpnjGCzXQF9Cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y313msvR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZLnZqum; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y313msvR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZLnZqum"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1585A7A003B;
	Tue,  5 Aug 2025 12:11:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 05 Aug 2025 12:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754410287;
	 x=1754496687; bh=kbR0XDM5sO4ya6QbKkj/tlNv+XzMsyA8QZK8af38ZDs=; b=
	Y313msvRynwtbDuywprbJ3S+/3f3lxMbRAwIEr5eljq/kpmQ+W7A9kfpQTPVG9D0
	2BMt9YAmEXMkUBYyByI8vhpeaM/2dvWWUr/c+joq/69+pBN6NhBRr08GfVpTQETp
	sVzEaM3RNwgBi6KngT4Zk/6Mvfmy1Nn8uJ2rOY0Z6jhZihCr0Y8VVM16ThIHSNaD
	U2jic8sGJ1FZ9j3bEixBVyIoGrJvX/gU7ir+Hq3FR76JJjgxMr/BPI8Zn6R4eMqU
	QRxSVYfpQ7YcET5930HC6heCUWDm0rymnfV/9FD0AX3eIVUnf5UvzG8BC7XtwlvX
	bY+1LL7LXaPoKpuqBQEhDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754410287; x=
	1754496687; bh=kbR0XDM5sO4ya6QbKkj/tlNv+XzMsyA8QZK8af38ZDs=; b=Y
	ZLnZqumorXwNW5K63BDAh68WSBlxMMRUZdpOPXeQa0asKi6Pus06XlucrcBFz3L0
	oZTw/dEFmvXJvPaUKNU6Yb2eiWZTs84QX7TgvYTbpm3798siO5tMJwnMg0ViWH+M
	FDqW1s4a5cbxuFO1ilQ06oWOx4rt+2ieqHFV2IqKKe6w/Rjl2BHNpQBhznbD78iW
	FEqt7ES9A+SGnxbj8qt28fCFg8ynvCh9rHtjQRMiLmTsgV21Q5sMJEl1+52t0j/3
	O/9IX5t+i8egE0ntViDKqDeYLnTEgiyiu/k8CwEdlZQTCrSAhpGZARQmzEXJGoSL
	ooIUNJ4+6FFf6ZfUjidFw==
X-ME-Sender: <xms:Ly2SaL0NxavFy6tGR5ub7Iji8irmsjENaO8iZNIOux3CgqabWcrzGA>
    <xme:Ly2SaCgCPgZTKv7_8fytS-TVETbtYr3dNDPZ4gtth3bQCwMMcgC5GNwtdrbfIf_Pc
    DEjWCulFE5g1u26PA>
X-ME-Received: <xmr:Ly2SaMVKJO9N0wy-Y87_1BcEh9jlvPAnV0gURmz7royMcUvCAvUaxTwOzqYfdZ6y27vjjfdEbUXcb4stFqMI_9qlKThSdGguTy8MSNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlughh
    ohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehhihesrghrnhgvshdrshhprggtvgdprhgtphht
    thhopehmihgthhgrlhesihhstgdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ly2SaBWjspck1LAqG-AcIXIK66buRWagPa92c7jLqWiW6O3P6w_l9A>
    <xmx:Ly2SaMhsIDJlUBsmvceepLZYG5xKjIgR6VUO1L0NCiZpc7b22LuKiA>
    <xmx:Ly2SaMZ38j8fX5AFx1IbCpGfypYt2kyq7t8QN2XAt8BNv0GZG2V6qA>
    <xmx:Ly2SaJrnLi_wuCFfo0vgSSUMwQ85ky6HFANgN2xkCFBiDVflFdt0kw>
    <xmx:Ly2SaL7uekdtjpLR2brNBDZlHqRcPSIwA-VdE-Hx0CUHmJsItIXlvcnH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 12:11:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@arnes.space,  michal@isc.org,  peff@peff.net
Subject: Re: [PATCH v2] diff: ensure consistent diff behavior with -I<regex>
 across output formats
In-Reply-To: <F21E21EC-4894-4396-A126-8F6638731762@gmail.com> (Lidong Yan's
	message of "Tue, 5 Aug 2025 17:23:38 +0800")
References: <xmqqcy9io73j.fsf@gitster.g>
	<20250803145155.57894-1-yldhome2d2@gmail.com>
	<xmqqfre7ex8x.fsf@gitster.g>
	<B1F1EBB7-1824-4776-B8B0-B557114546DB@gmail.com>
	<xmqqzfcfd7pp.fsf@gitster.g>
	<F21E21EC-4894-4396-A126-8F6638731762@gmail.com>
Date: Tue, 05 Aug 2025 09:11:25 -0700
Message-ID: <xmqq34a53g0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> I’m proposing to add a .diff_optimize field to struct diff_options, which
> would support three modes: DIFF_OPT_NONE, DIFF_OPT_DRY_RUN,
> and DIFF_OPT_BUFFER. The appropriate value would be determined
> before calling diff_flush(), potentially in repo_diff_setup().
> ...
> However, I’m concerned that DIFF_OPT_BUFFER could lead to high memory
> usage in Git, and I’m not entirely sure if this trade-off is justified.

The DRY_RUN mode would make very good sense, and I agree with you
that it is better to leave the BUFFER mode out.  It is hard to do
right (like, keeping up to certain small amount of diff in memory
and then spill it to an external temporary file if we are getting
too much), and the value to have it is questionable, especially in
the initial attempt.

Thanks.
