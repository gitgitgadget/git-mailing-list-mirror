Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27E20318
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738339786; cv=none; b=GTCmohY6LZdOOx7dIrA0+V9TUgNAc1Wn+UKc8QfVrnqLSsPgrzblyUk5lKmKqp5EyUdbXP4w5/0oiRtDu7XA+gIOuuKbcI5ziO6JkB4yqN1gXcNECUsGNMy0Knx6Mb3mwF4XvofOJHDMYfBixlSVcK1lo12kI+r1k8IeIKgYyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738339786; c=relaxed/simple;
	bh=+95AK7SZZqO7N1zNV6imclHvAYppzfaK4JjA6L98XYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cEG3NKHJru4YC/mwem4yjItw5NP6dGiOSUmOqMVzdj+G4LuvP3XqgWusRGdLmcSn5h0k0DjZu3qBl+nhx+85nyNgagbA7oQiy62QYMHYX4qDK3lyQSWMwJbCShuH1Ecdf063To5cp4iAwWjjRcRvJNQbM5DWZq2g91Ol0dvu1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dfVtNN3f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ztpS4H6o; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dfVtNN3f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ztpS4H6o"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 71CDF114011F;
	Fri, 31 Jan 2025 11:09:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 31 Jan 2025 11:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738339783; x=1738426183; bh=U+tXcT0J6M
	A8UwAQ+2uI5rqfkRZbEb6FzcXIPEmlTrg=; b=dfVtNN3fXWW9uamIuzWFiuRiqi
	MVSHEoPqlZbDQXolclV9vh3QGSwE0Dl1R1pxsrwUJraxf+ZlVuy7SSIpNgCbj3n+
	1idEqLSDPNlk4jq13QKqxcI6WOSl+6LdH55GsYHkOaGNzfVOcGmgZiEYneh3PrCl
	2kMCZ0whNc5lDM1x3RRkzoSdq6veHq2xrkbyOz/rEor6OwUwx7NFe33P/G6GyQTb
	FXGMisIJ42rH+J9MihUQ0UOAp1EIcStQFf/f+IY6+M14k1MDhZ8J8sJKnb63ElDe
	Q3PMGpGYimD/WlQkfB/7bPpAkRCRtDPaVMhaXz6tuYHeJaDNflWNVwTGFg3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738339783; x=1738426183; bh=U+tXcT0J6MA8UwAQ+2uI5rqfkRZbEb6FzcX
	IPEmlTrg=; b=ztpS4H6oHYgeWN/b7iP/dF/4M26zzh0YU8RZrluwpGW0Us4PXQU
	Me+SuIcJUOI5qxnbIoK1DPnSNk7bpx98wgzj0yDwSJpm9e6k3MAA/ilh7R+56iD6
	Z0qBHfzADTvkhwKaKcfnFXcISIDgxyNLCKgNvpnJ/XAI/ygIDcQdOzs06hU9Nebx
	Yu7ypzQ0SKjxusRD0aSRK9SCrPAJMEpwtKlBeFQaygWTUtqZEFU2DW+kYpEhr3Ac
	KgErGNikTwVDVVK3yMVn2s9mR+5gDSodwceH5gakkHUdCy6qIlV044D+QK9O0t31
	9XTML1H3VRgaHpkcLqPN0Rehh1TdvE81TVw==
X-ME-Sender: <xms:xvWcZ6WiUUI9vwjLJmGyMyNQoaN-JIoWEy8s9FLmUQ8Nj4jX6f-SaQ>
    <xme:xvWcZ2ma9OI6b9qnTz-QenlE4TSmV__UBN1PYXjrXURya9ydIQ24MVZWbzg5bW9yW
    36hE2Oy13Y1SruxGQ>
X-ME-Received: <xmr:xvWcZ-ZsDMOoD5qyu6qCMLPQZPgD5M9fzSVHP3aJXI-YRQ4M3F5nsgq2ExdPgwY_dc8P8q6UfLna4cxCBgWPQvQt3k06aWoLM2dO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xvWcZxVuDFOfFbCZVpjvzsCLNPZwe7HZqe6vhf-mJbSAXYiDMe8mlw>
    <xmx:xvWcZ0mB0XSAAJLbsy2iaBXHWbHdio_x1dJuTsjf5mO8KVd5yEXx4w>
    <xmx:xvWcZ2c-jvW9h-N6K3ktK97MvR2ohBWO5GqxUtFX4p7xUzPZQ4Jw3A>
    <xmx:xvWcZ2GtMqUeqhGHcWq4Cfirm0GbTJ5-YU6JQ-u1_hdumY62A5Eucw>
    <xmx:x_WcZzuTAaUCQz9W260O0Mz4rw8k7Efi2or92jnDR2BFL6Y51TR1Ekgb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 11:09:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
In-Reply-To: <Z5xW57fsOCNcGViY@pks.im> (Patrick Steinhardt's message of "Fri,
	31 Jan 2025 05:51:51 +0100")
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
	<CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
	<Z44u7od-mDiKcKVZ@pks.im> <xmqqr04vzyz9.fsf@gitster.g>
	<b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
	<Z5srHBSPKQlsuH53@pks.im> <xmqqjzaccdpn.fsf@gitster.g>
	<xmqqr04kaufo.fsf@gitster.g> <Z5xW57fsOCNcGViY@pks.im>
Date: Fri, 31 Jan 2025 08:09:41 -0800
Message-ID: <xmqqtt9f9d8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> How about making the rule a lot simpler?
>> 
>>     The expiration date kicks in _mechanically_, i.e. stale entries
>>     are unconditionally dropped at the date, based solely on the
>>     comparison between the timestamp and the wall clock.
>> 
>> People are free to advocate for its continued existence, and when
>> such an effort achieves a concensus among then-active members of the
>> community by the stated expiration date, a patch to update the
>> entry's expiration date may be accepted, thereby prolonging its
>> shelf life.  Unless such a thing happens before the expiration date
>> comes, we will mechanically drop the entry.
>> 
>> Of course people _can_ resurrect an expired entry later as a new
>> one when it seems appropriate.
>> 
>> That makes the decision to expire things from the list easy to make.
>
> Works for me. Ideally, as any other topic, the retirement should be sent
> to the mailing list as a normal patch series so that people may chime in
> on the retirement and state reasons why they don't think that is a good
> idea.

That is the complete opposite of the ideal from my point of view.
The whole point of making the list items expire by default is that
the onus is on those who want to have them on list to justify why
these items must remain on the list.  A patch to remove an item that
hasn't had anybody advocating for its retention shouldn't have to be
chimed in to be supported.  There shouldn't even have to be a patch;
that is what I mean by "stale entries expire mechanically by default".

Thanks.


