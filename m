Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DE374E5B
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131746; cv=none; b=at61kGrQ6DQod4XYlJ+jjExqO8yR3nrEEu/Ubdm4+ymte6Hl+QC/eLa8ZSDjMgexBNBUWMdHqwGxRyBVRZRWeYRQEeJpLf5sANWjAO02Dq+qjYhTDpZhBSpHHJ8YqVCOL6BP9QRrbWp8tfG895x18OocELMxAEfYV6tvyS6QizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131746; c=relaxed/simple;
	bh=P6G0HoOIe0oEFq4gcUv/A5bxck3rID9HW5/ZpN0jQ7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hMFEUemwsMf3/JRtTUbIqcoh2MbKruIRUdGkFKnCs3qtb5Khg9F5Ge+IdojpIhwWr3lnOMaCjmsGso95PoQuEDbVLv5EhhnOi6yAKE9lKhoQvjfWTR7lUwitB//eXD2x7tudqZj4VHb8cAyFBYpTJ9XsDtw2hcVOsJwfyP7hdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UBMlOtCb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXa7zr+A; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UBMlOtCb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXa7zr+A"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A488B1D0022E;
	Mon, 27 Jul 2026 01:55:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jul 2026 01:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785131743; x=1785218143; bh=gyVU8CDLiZ
	S9DJeB65tf/Vo4snYTCuSJXkE7xYSnCFA=; b=UBMlOtCb2me01jIZxYa9WUhLU1
	KKofYF2Z3llUYnU524tXp30WlFWaAbP0c7fTvnwQvZowWjyBNDS5Ep+NXMCiPTIf
	qgE8LHX49YDpgGgtb3fIxkHfWQbEoWbynHIWkV7Ifrea/Wm7H2iiJ+bhESt6jPXD
	FJadV+jYIlmfK+1ECstpgFo6KRU/gi8b45N/pxdZFEaMdSvEV2qvS1IWhhL7DchG
	ECzp6GZ/Lptr70LBZKQQExjsFeYiEt58yBU3X1q8YpX7WZr5f3gCV5csrCBtnsyn
	nAoFwgeDKbjCwRJ1aY1dpEjJAtUigl7o0fgpR5WvKV8bff6bE7WiBO5pUziQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785131743; x=1785218143; bh=gyVU8CDLiZS9DJeB65tf/Vo4snYTCuSJXkE
	7xYSnCFA=; b=dXa7zr+Aie1igqfqzDPWnbzH9AjPjh4yjm1lKUdOsBZDO2WPq64
	52JOyrIqefoUxs8OuGqjSgiWqIOM2CBUUtdF6VNZy5Ay/5kR58bcr6/MUwZM1ZzK
	w02G9lRIxjLScVkqOAdSCJ7g9vksG1X3J3uq/B5ROr9LgTEQbdo0Nr+HfPrcyuTO
	jHPXpbtMPJPxIVDkr5yAOxj08soSXQgbJ8ENQsWBZusXpf7CRmlEpe31tOgX175A
	F+9evVGA295DSLjnKUrPYpXVaPhP48iv1f5DS3Og53sk7tRW8+ruahUdCuEYQxnD
	oDMCGC2i+aVmd+1xea8GNqylzxhTcWgzIcg==
X-ME-Sender: <xms:3_JmaiZrYlQbQMNgJ9TqN4JZpIGbhNYz0pj_D3BPMuBXfe2r2mddGg>
    <xme:3_JmasSpYDA5XuTb-Php-dgULC1y66-1Z4T9jUFNujHgX1pFnKYOHkQa5M2T1StQl
    NpT9ZlzOZwRC5IMqhocq_MeELS4TGiA7LltXjiKNCeLpFk5esvAWg>
X-ME-Received: <xmr:3_JmalTzcI0AhF8HVGu27FGFtoMWX3u5_x3oGGpil_axb3uSc8fmEjtK0C3cUGSzyRnTgsAWu4Vzpws_JP80OhAzkCfRn-qCjQ>
X-ME-Proxy-Cause: dmFkZTEfbaDZ2DChDE9LGGA0F91vuyoXN+uerjphKGKjQ23rtGG4b0WseR5OYW3MRNS47p
    VzsH8QK/TqTGMmlld7sj9l7b8Dc1XwLd2wQs/okbmWukepNxsL4UgLHpUs5j6whdQSjDeX
    CgSRQCir91zEKnbNR5fyozvD9YGktrGIltPi8yYemikTruFgx283rMcPfgy5A0FzV6wrpx
    r5sIgPodt7Uo4VeW1mTxHr9piQQglPKGHZ82EGbm1JNIw1jff+v2AuS1wx5ZziRIowFYvl
    vwQfYuh+BmFrtZMrzA89IBWB2q9KdH0zG7eykJ/6rIjofeIolShHJXKtqXRUc9Wm5GwQh+
    LVNbjt/w2a4bMczWzz6qGl/+76012IJngHs0/Vy/IAbbJpthM0rcUeKQ7jEElvc+9VMoK7
    Oe9l2pYrootFt8VRMYgzHeyX/BUbVlXm2P2onZv0mJulZSpG9HO3pIfAae8k+B1jMPaIwe
    4lPEDXLO9BizoPdIz+5wXHIJ9AT+4KTCxNBG+n3FLbrz8f5ZP3LavpXMwgdDUz3olhzJZ6
    QPEURMIR7qqX/e9VCnwkFUV7aJnu5e5LDTlkwgrzAD6YLYnuMmsI0YItfJzS/QCtKYyTl8
    PBLEXUJ/PAypoTl8vkjBcRmAk50PrZjoeftO7YPbmgDL9t9+RPArOHMCMjNA
X-ME-Proxy: <xmx:3_JmagQ9xmKDbfjPcsHhLcjFZVFO17OUsOac1sQM2Ns731Q2GCqDjg>
    <xmx:3_Jmaq5P_xX-sIW8HVlv4qNn1fLJ6RoLiQU3p5g5PO20_iA1aFn50g>
    <xmx:3_Jmas2arxucOfvBaPf_bzgEjFLDPTeRpwPMBgIY5vIasQkFvVTlGA>
    <xmx:3_JmalBfDmCIeHNjuczB-IIdZnvsNaszjw8pGlIXwyLclDE8ZOlWVA>
    <xmx:3_JmajiMrRU26AUzWnhVQ7NX-3IHcXPTXlw9zVs8kehSVBtZRM6dCQa->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 01:55:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com
Subject: Re: [GSoC Patch v3 0/7] repo: add more path keys to git repo info
In-Reply-To: <8933F9C6-DF8A-400D-AE1A-CC79CEB26283@gmail.com> (Lucas Seiki
	Oshiro's message of "Sun, 26 Jul 2026 21:57:07 -0300")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqse55vhnz.fsf@gitster.g>
	<8933F9C6-DF8A-400D-AE1A-CC79CEB26283@gmail.com>
Date: Sun, 26 Jul 2026 22:55:41 -0700
Message-ID: <xmqqpl09ou1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> I'd love to hear real reviews from others on these patches, but
>> at least I didn't spot anything glaringly wrong anymore.
>
> It looks good to me :-)

Can you try to make your review sound a bit more credible to
readers?

It is much harder to give positive reviews than to merely point out
a few breakages in a patch, but there are still things reviewers can
do.  Thinking aloud to follow the author's line of thought is a
technique I have found over the years to work well in demonstrating
that your Ack is backed by having actually read and understood the
patch.  There may be other techniques experienced reviewers (by now
you know who they are after reading what they wrote on your patches
and others') use when giving positive reviews.

Thanks.
