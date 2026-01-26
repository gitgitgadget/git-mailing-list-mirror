Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6D34D910
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451236; cv=none; b=YEDSHRC0JlTWIB2CdyUldB2VzRH7ZmLQmIz4BEVJk/M7to1mv+cmyu+bnMYods4oVsZr73kHvwTiNSf0n9rQc/zeAWED2cElSgkrASd82N2bBwo1qQlDhN8YRoCw7Wtf/nyBVCMU5zxs23lSJuzaI1rLyOXpOuHpf+CRi8WIM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451236; c=relaxed/simple;
	bh=0/0GUV2R42aZIF9mF6sQiEa66VmHsbDuAmNLJApr1JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W0hT+dKQBK/vgBsYjoK46PBkU3S/8/uhUiMB+dmj7v3lbSEdwgN44+J9qn2kkCRZk7RyvJ6A6LZ+Ybf7npUluSwWTzF8VoKdDocAx3LUj3ImzL+AO3hbqUsEc6xGRTEMk39af8OEgZa/HjWQ3KDDlT+p5IcA2tuulR/3bacDA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FVnSL6cy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3wgYk4V; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FVnSL6cy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3wgYk4V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD2B07A0141;
	Mon, 26 Jan 2026 13:13:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 26 Jan 2026 13:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769451233;
	 x=1769537633; bh=gTHSFqu4g7/rs4+7ob9SMO09baH2I6Anbu6zEt/itKY=; b=
	FVnSL6cygClWVZwN7VjrZ5rO7dh5HoyQLT1o60WS3EiIJCctj+YtxGs6A5lNrYoJ
	XWFGvyowosa3VPFAbGs0LLamNCUfiCNIsKRnfqsnzybrOEcDpqSCOE67WB80TKoH
	5P9+JNtKO4/VjFpvC7PN+31IfxMV3rK835TEImhrYZC35gkHSLg8u1m8xsNZkxTL
	wPSWYmXOd0bA03r3DrFFQwqV9/0y2gH1pju+SLgq8lP6vu1ZGGMUk/D1iiiBajmc
	h63NFbSopex1zS6VfG8xSfdm40Ts2pCpAcX/EPovrVc0CuTmmHjpfeWklyojUdss
	L037Da+uKhWOAyyzrgR3BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769451233; x=
	1769537633; bh=gTHSFqu4g7/rs4+7ob9SMO09baH2I6Anbu6zEt/itKY=; b=j
	3wgYk4V+ciKv/VJKREE/fXWAjv8wTMBzItGDZndwDx9GLVHB85gIUcOpbsFy3Gyh
	+g7bzRnyW601UZAaO1BbvLqYcoX0xtDj298y7f2Y12E/00qX/rF4uuelNzjEG3m1
	BKsxQ1odDW/CitKa2nzBqwmQnNy4fE0Z6+C/MEDw40YxSs/+iJb3h3WzKXqx2Qbo
	RrRkmaXAq8eDxWavOFmECNAKA8aNoF1zJaBFS2pbP76jNfNp97CR8RgA79DUWiCO
	eR6H3/kV6ds4JkR0YQJCnuZ2cJWGfIHbLU5KnyfCMUgYfEgxGERGaCXxa6qSRWFf
	gyCBBrN7Kz7sl0420trwQ==
X-ME-Sender: <xms:4a53aUqOHYWNC6Q0XkWxVnTjDURnrtdhWmTHxKQnxxQH6UHKPoW24g>
    <xme:4a53aRrS0vbVr_3qRWFtdEm45x5YEEntsyT2MZmkFIYocUMEepG00peES_O72qc9U
    f3XWS7dtCNQdWd-rZYIK3EZ-dzmpi7CzYxsSZBo5-sP0SocTiUjMw>
X-ME-Received: <xmr:4a53aePeaCocwH87IKW5CBtueLfDUGHwW8T1ru6AdZHjGPFhzMRiXRIy7MRjuAx-Sugn0FswJ1H5z5QDRLUb7B7noRofqKDBIMn6Ijs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvleeiteehkefhgeekueduffefkeeiteevjeeggeevhfduudelvefggfdv
    vedtjeenucffohhmrghinhepshhtrggtkhhovhgvrhhflhhofidrtghomhdpghhouggsoh
    hlthdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4a53aazmSnO1pq7BxxXLXe7cIKNA5J51sPLoJFp408B6MdBhovBK8Q>
    <xmx:4a53afv0892yDunEQNqrPTolrCltM9-mp2zjzXIrelND0-9o_RfsVA>
    <xmx:4a53ab4e8340rCoLNkqRejC0Yff5xfTBmhv4T8oBE9zpJKradahINQ>
    <xmx:4a53aWTeNR6e0ruIzHFrsu9RDXdT38nAgW7BkRg5AYxeg0uuClIuGg>
    <xmx:4a53aQBAG9BOHY7p9wv5Ws3d8G0EvgsxcP5E9nujHFCUd3BjW_Eecw_4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 13:13:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 3/3] odb: drop gaps in object info flag values
In-Reply-To: <add7c86f-9d5e-4136-8c3d-a04df523487b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 26 Jan 2026 19:02:15 +0100")
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
	<20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
	<xmqqa4y0jop7.fsf@gitster.g>
	<add7c86f-9d5e-4136-8c3d-a04df523487b@web.de>
Date: Mon, 26 Jan 2026 10:13:51 -0800
Message-ID: <xmqqpl6wi6n4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>> I wonder if this series can be restructured a bit to demonstrate the
>> benefit of moving to enum a bit more prominently.  For example, even
>> at the end of the three patches, odb_read_object_info_extended()
>> still takes an "unsigned flags" parameter, but it is meant to take
>> this new enum, isn't it?  If we do the "#define to enum" conversion
>> (without renumbering) first, then "unsigned to enum", would it, with
>> appropriate compiler warning flags, already reveal the existing bugs
>> that happened to be working OK as potential problems?  And with that,
>> fixes in 1/3 and 2/3 would demonstrate why #define to enum" is worth
>> doing very well.  And after all that, we can renumber the enums in a
>> separate and final step.
> With -Wenum-conversion you can get GCC to report implicit conversions
> between different enum types (like in the backfill case), but I don't
> see a way to warn about conversions from int (the fsck case).

Yes, that is why I suggested "unsigned to enum" change after doing
"#define to enum" conversion.  If a caller passes an enum with
HAS_OBJECT_* to odb_read_object_info_extended() that expects
"unsigned flags", it would not be warned, but if the callee expects
"enum object_info_flags", passing HAS_OBJECT_* enum to it would be
flagged, right?  We may need to give the currently-unnamed enum with
HAS_OBJECT_* a name first.

> https://stackoverflow.com/questions/4669454/how-to-make-gcc-warn-about-passing-wrong-enum-to-a-function
> suggests using -Wenum-compare and macros to sneak in a comparison, but
> that doesn't seem to catch more than -Wenum-conversion, which doesn't
> need any macros.
>
> https://godbolt.org/z/Whvc7Mf1n
>
> Perhaps sparse can do that?
>
> René
