Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04079CD
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669220; cv=none; b=VWRA9VyOurSgpwVr/xj3nj6ib7kWfmp3RTYidlqW/VKD+VdBhLvo0nQlN+3t2P0GJWkCqjL9JsrM/Enu2oA8m6ZOsgtI+iCBKdbgIVxe2FSixMdgypFTMG2qtDFHdIcqnB2ZXGPJSiUEiQXvoGtW4cxaAvMvH7+jXBIJLrHQM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669220; c=relaxed/simple;
	bh=wn5xesBB9vVRtiWDpvy9PieewOSytk6BjRTRusSfwLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PkdeurFegyFkQhTIkg3lydL/2Z3Y83brbPTXA1k0bVvvj3OiU80+8bh/o9cgZzHytzER8l8j/CIf1uAd7GNrBS+wnyqQe81Cbi5VU+m+9F5f+szOzB7teLVAEl1rZxqXwsYceMa1jxtsgRqJ4dGhkF6byLQgEe5gLb5lDiVv+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XNILunxL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZFxGR+t; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XNILunxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZFxGR+t"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE5967A00E2;
	Fri,  8 Aug 2025 12:06:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 08 Aug 2025 12:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754669216; x=1754755616; bh=ENpcprDHHf
	zp7ynsm+s9GQNuThxtyOOFNGJ71VOx9KI=; b=XNILunxL774dAbM9UpWw8c1Fhn
	1naNg024ScosYFDT54hPP9LY+V7cF//3nwy52X9v6rHvI5en+/PFF6v4LoL0eEnl
	Ki9QXda8t+u3d8iZkFg64Vz8f0oKpt5on/DiSs3VpytQw5QDYWDJhv1AGzEEuTnk
	vQWoPF6AWPJYwYrYkCnpu41OWRcb7NkV0PKlH9lghIp/YSucco3sMimFn63SuWMl
	6PBS1vr6UJ4sPNAkNFDX8yKLoQC/y0FGW7dc/dMWAxeAXnDp68+Lr7tZ0Yw3ox7J
	sYl2JgTMgTzRLlu4YnXPRV2Iek+0cR0TlqPBAmCbFZlxrAHmaOoGn+McVcRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754669216; x=1754755616; bh=ENpcprDHHfzp7ynsm+s9GQNuThxtyOOFNGJ
	71VOx9KI=; b=iZFxGR+tmXtVnEh+GrFCS5BhPEs3j4yor+tVG7BGaKb3qbyYjGD
	YOUBthbRdSLOTQr26BKk/oaNSpHqFfHFuItr2y8No7I2uvbhbELwrLtyp2tI4JO8
	NtPsjdNTQecHT2A9lx0MuY6+clPsuM2HwjtALJhGLDxQJAq8KjUF09uCLdyfFUT0
	Susw7Fq/r4lZgd/rBGeXxeLnn10XPHsZtAc12JEWE0HzGwBWh8W/u9e9M3j9QzgN
	BuZHPoTw2uq0zhjYXMDaRhrztEDJmwUKOdygg2AKSOfZOERPOxJQDSuyUVxGJDni
	0PPtpTgjlnJrwkqHBJMSji+jSBaou0TGyxQ==
X-ME-Sender: <xms:oCCWaEdeqFw7cuXIuOtL0-jjKDajpMeJdXd3piyPwOOe4Bhfg__LsQ>
    <xme:oCCWaAz8waEEWyr3VlRxSjNm6zWJ6asBNu93XMWL1BoQq8KBiNCItQMFVTCh8CYe-
    td50vfdBLIjK0oUmA>
X-ME-Received: <xmr:oCCWaCEnO8SjQAtn-SVL7V5OlYYJ0LLZGg0DuU4C-U_czd-GOGsxWBnd64umB_UokaE5TmnOwC6aHfSZGQs8070CEOyzZWxYJhx2T8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehlihhurd
    guvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oCCWaMyEBBBrVx8A1AJMNZebTROuf05NA_WzpQmG5eDxADhBScTK5Q>
    <xmx:oCCWaLsg4oOQ_LL2sfJalmCgHwQLSEvN0yO61yx_Stop_EXTbJMeIw>
    <xmx:oCCWaB0F_y5q2zjDZss9DI0g-Z67kyPaH0Di7J1ZtniWtBVYpyzb_Q>
    <xmx:oCCWaO8hFhkfoy-zHuRk3tlwWZxI7Oq2auDeIMWBCWBRI2-P1b6HEA>
    <xmx:oCCWaCsolWPjMmC0H7AvvSwQTYBs6laKSOrrFZVKPCFdvEyT4KMQ7HDc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 12:06:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Denton Liu <liu.denton@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] remote.c: remove erroneous BUG case
In-Reply-To: <aJWnMSmEXNTG1lL1@pks.im> (Patrick Steinhardt's message of "Fri,
	8 Aug 2025 09:28:49 +0200")
References: <cover.1754627874.git.liu.denton@gmail.com>
	<cover.1754637849.git.liu.denton@gmail.com> <aJWnMSmEXNTG1lL1@pks.im>
Date: Fri, 08 Aug 2025 09:06:54 -0700
Message-ID: <xmqqo6spiyqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 08, 2025 at 12:24:39AM -0700, Denton Liu wrote:
>> In the case where one pushes a non-existent oid to an unqualified
>> destination, we encounter the following BUG
>> 
>> 	error: The destination you provided is not a full refname (i.e.,
>> 	starting with "refs/"). We tried to guess what you meant by:
>> 
>> 	- Looking for a ref that matches 'branch' on the remote side.
>> 	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
>> 	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
>> 	  refs/{heads,tags}/ prefix on the remote side.
>> 
>> 	Neither worked, so we gave up. You must fully qualify the ref.
>> 	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
>> 	fatal: the remote end hung up unexpectedly
>> 	Aborted (core dumped)
>> 
>> However, this isn't actually a bug so replace it with an advise()
>> message.
>> 
>> Changes since v4:
>> 
>> * Put the switch statement refactoring patch last so that we don't get
>>   compile errors from a missing variable
>
> Thanks, this version looks good to me.

Yeah, this looks good.  Let's mark it for 'next'.

Thanks, both.
