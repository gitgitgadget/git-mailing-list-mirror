Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680EA199237
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772828; cv=none; b=cHalPaA09M/WDK/brMqXdiGGkY1G7jSJQ6uXvHR7lwq92zr8bYATbbGNc9k0Mde64d6319DmFe0guCjx6ETfYvZJ14shf4y8UKBioAiN1HIi1F5TRovKLuEhozqAOxKn5Lgm7/s41yeKQdgUa3gUKaWiKLZYGe52NRM4RFGBn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772828; c=relaxed/simple;
	bh=q59r/CByUpl8+1I7dvIq4X66mODiJKDotmyzZz+YQWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRY/a54BHWU5b67JEgo2UtB/bOCSgjPTcwSVGLlKEb4p9s7LcFVRabV+GJ3KW1ILDETBFUo0jSUbNiInMR81hrqD8G7n/Z2+lvIH9mHVRVuhYaOoGB6k/SPi3tWP6nQgkXqwQjfsCKBnodX9PV+oofu642eXKau/brG1vtS2BQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XF+NkBW+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tj08442F; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XF+NkBW+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tj08442F"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4992A1D00116;
	Mon,  6 Oct 2025 13:47:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 06 Oct 2025 13:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759772824; x=1759859224; bh=zGgHdniVUe
	fYxtTuatvKMxtK30CWMgAUtZlKBZBrqA0=; b=XF+NkBW+OIn6uhkV0Cm3hMCR+0
	6LBjMDMbMbnFZHPaHoYp0ibd4KEYiguSb+GngOX+HLVDpSfBN/6SrPeMmSXq8ksh
	VTtsIWjxvjJ94hJ29NNPKp27wVVVU2vLY029bOtTJVhA2CWrHbrCbNWy6FyhYhhm
	jDw3T6PtD0hDOtIXCEfNmfIhY6pfzlo9cDHbgUl580EOrTNIBlJUFCKfYw5Fs0jg
	jINc6CTz6TxO4zpLqgQKIxsmKlNUi4IpKzClcaitSFVSrdjsJ0cpGrr6ES+97Ic6
	pV1k24CLYs5GBNqlAP12L7zLFWVZSKPd4gwiaS8Y071aB2Bre1y2HAm6KAhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759772824; x=1759859224; bh=zGgHdniVUefYxtTuatvKMxtK30CWMgAUtZl
	KBZBrqA0=; b=Tj08442F1UJD9h98CNR90Yw+zeChqRNSGeJSB3sECcd8o9yhOw2
	iGfPtys5qkVmZGp/ewSg10VNGS3a2aG1SJMpfARuBGoTYibu1RF8bzkwPf3w0vAV
	kZqQp80BA/vwQ/NNfQtMfljOuQBv0s+6aa5IPsQ7/niE3/cVHrBKqTlRIciy3F0U
	SkO7Db/82BJe1KPfoHJVW4EyCwAUSfnID0+0KKPQFvBuyePgxqLf4AkoOg5T1Y+s
	pgRzQLx7GHLmn+Z8WoswvFPc8gCHrkwWCDhMKN7b08ARkyRQJjvaFGhtG8482K22
	ftac4S/S17NA1x9en9JoofknmyZ3dQUHkhA==
X-ME-Sender: <xms:lwDkaCsHByAuiopxUnYhcq6qF8y9g2EGgorAPdpiFO9Png9iJR0Urw>
    <xme:lwDkaDQaRJa2OH0QkKjnm-oH0RbqUPb7a12Y6c1dtyU5x_OA7fW1qlScswft-CwGp
    ydbN7fMw4hEtVLzcVWOUyp4YzLe8eRm7vLfxYgnKX5QIDxDr6QkNA>
X-ME-Received: <xmr:lwDkaJIZyzLcvgpNBOr2kcJAty5G-27Ae21-4bUMW5VOvpzz-PZZbGta5UGvPQKTyzOo_f7nD2hEQJU4Mw-zLwdoeSvuvTzTfl9f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpth
    htohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:lwDkaGtMuXpnODkfxO-GNwh0QyuU_7-ih-lhGi6Adh-4XgzNp2wQ-g>
    <xmx:lwDkaA9CvD488TzUn_tNaQwCqSS5wk0PwufdhxROnAotsOmuF8rJVg>
    <xmx:lwDkaA1sVOynI3P2YJ_E2pPECliHcpk_8RccEonFRUCtdxmgQH5JHw>
    <xmx:lwDkaFi9miRT1Enu4djjwctltqvBMqRZwYhHfImQ65PAOTuTkMA0-g>
    <xmx:mADkaEL_2VgmPjcmEk3UI6X3lytllcxqzLqwidoiLnxUyH5rS5GBynhS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 13:47:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/5] strbuf: bring back is_rfc3986_unreserved
In-Reply-To: <xmqq8qhoq8hg.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 Oct 2025 09:51:23 -0700")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-4-adrian.ratiu@collabora.com>
	<xmqq8qhoq8hg.fsf@gitster.g>
Date: Mon, 06 Oct 2025 10:47:02 -0700
Message-ID: <xmqqcy6zq5wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> is_rfc3986_unreserved() was moved to credential-store.c and was made
>> static by f89854362c (credential-store: move related functions to
>> credential-store file, 2023-06-06) under a correct assumption, at the
>> time, that it was the only place using it.
>>
>> However now we need it to apply URL-encoding to submodule names when
>> constructing gitdir paths, to avoid conflicts, so bring it back.
>
> Why to strbuf, though?
>
> This does not have anything to do with what strbuf does.  I could be
> possible that strbuf.c had some function that encodes/decodes 3986
> in a strbuf and this may have been a useful helper for that feature,
> but it is apparent that this helper function is needed by

"is needed" -> "is not needed", of course.  Sorry for a typo.

> strbuf.[ch] in today's code, so moving it to strbuf.[ch] makes no
> sense to me.
