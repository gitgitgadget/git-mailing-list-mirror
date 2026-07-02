Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0795394498
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016349; cv=none; b=bL44PmMHZgnLxvr8igDHlDpbKF4b8YLO0sgbh9tyXZrLPKXhFe8rknTLmZ4rJUK6lGOcb6/X9TUSGHV2X1Kn8T0Eupx9Ao09mB7bFsEu2VbXWl7lAiGekXJ18vthP7YBNXKyFT2woYsmgIptPInF9oEPGjaDbJHk9y4lRwruZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016349; c=relaxed/simple;
	bh=9sJbaJNkeWLsz5J2DClU308yvsOR5IgxkdgSCclL1wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f5Md4TXo+r4U8Zh25V6XtEu/qrrNHoihMRI4vJTM76fCcO9Io+SndD1IR3REz5KsnK2ioNCq3MWoe/jqD0T9FXQeSYVGHBj7wkx4Z1ItR+xzVGRmpVoUNdRg6d7bZwIapI+pTEoEJewNMj2DOjLhveghrv4ygH80ikLJ2qLPNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VyvACmTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K23FavDW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VyvACmTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K23FavDW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1BE357A012C;
	Thu,  2 Jul 2026 14:19:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 14:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783016346; x=1783102746; bh=9sJbaJNkeW
	Lsz5J2DClU308yvsOR5IgxkdgSCclL1wk=; b=VyvACmTOosZ5JCixgjL0QawY1r
	Vh32iSjoyBjO3HDVGH0eJkSWS4SoOV5rhEe/3AJ0b3OxkthT0/BpT44tb5M1jezR
	1jqQOSzlyMJk2dnyNJu69TKP1R80DO1NkGzNoNBrLUtmbgeVo5d7c5ydOFILJ3ql
	i1TocEOZ6jnzJZCVLhq96ux0SLTzRbGN4qTS1hUAG90Uomu5I065PAp8z6aWQQkP
	Rk9xwBp8qkxdNH+JwGcwLCOxQ4MLZfZrmKEwrNOR5/z2of5dqhusY4w5XpSZbAbp
	BsHTVUSl3pnUU2tdVCXluhJDs+QS6+Wvvk8zA/JpVLhQP4CgWyyj37xUMmZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783016346; x=1783102746; bh=9sJbaJNkeWLsz5J2DClU308yvsOR5Igxkdg
	SCclL1wk=; b=K23FavDWruwHg1iyDZtL6Fnzy2mdznScM9SD37/7zXGDW+xmUEs
	1iXEjgrDgiIpbYLd151rmRqstBR+cGYjWCXVxeHON9+ySVHaQg+haKjbmedbLULk
	sHqpE9Slw0fJVxeNKOowYFyC9SrIo150Tzix5cvoHWMVFQoIBTzgLkp8O5TVbMQb
	th0n6KgUSa1fQSwFCXDuVlTUFTX4aTn9exUrzBVACPyH6+rmKN5Mneg7mqDcAESK
	IsBZDBKJ5SmX3y16v6zqnkT/0icruCiqRIPi+IvMTB0IeltXDKye1PGkqeYd0GLP
	PvBmpjNVgMBXHyvsEyZNx2I9QUy/56hZT6A==
X-ME-Sender: <xms:mqtGatbm4V8NXJyq_SD7_VDS5AdCOHDMfVwxlF5TnBMepzkp2y3C6w>
    <xme:mqtGarZNCo2EAHfL71NIHMiMy6bCKwr4ijzkgTA4BkuaMvMgr4nGyz0DhNju4WmTk
    GbnDBRDYAxNkC2kPp03Mjpjmvlfe92SEizPcIvUItUiKHsYAU52Dg>
X-ME-Received: <xmr:mqtGak-o5jShiSzaGt4D1HH5QDqG2BGxK8R5r1MiHGowyg2zMQ2GKtg_bOCITRMWdfc7ZQbl2H1zZC0IuVz1nU-2U-3phm5X_Mq3Z44>
X-ME-Proxy-Cause: dmFkZTG4iySh9XFNqbVm1nGrpgxEOO9FG+NCtD7TCvA3Jt+6s8nHz4sx3hnsWxO+VEIhRz
    sbmWciXt354kzmTYkFfJ7FvPuscP6xaL5o6DGR7Vmxj7L2vLNTCqKEhlor6h8XheMi4LSL
    GVEVFqxLuBktoOzRnfqmy69lZhrh0iq0ZMWNiRQtJaaSvgLCaKA8AkIzgvrPbYSH4LMQ4X
    MY3yGNqol/NSYnh4fag+0IyUqkhoMCHQv/t/pxcf0AQ3LqCHuaEeD9OoER+YlTAl9TQWmh
    Li86A65wa1x0K4GuQ8AV0DyQZGPzXkAbDW32LEZePMgcOqH3DB+bJyEyWuJDAfzLZLEMgB
    kfq+Q89hCmotidc3ewhTNOKFJoWVgaj+0UhPpO1ToBZ1v5NdwoWWl6ljD0UY6ynaIpALCn
    wdSEjtRhhobqtfPktLq0U3dC4FsTkzciW1gGwIDsvHyn2owBf4zfUhWJUUF5Yac5QptQ6B
    7+d4sqhXoIjHNj8zskl5RFC/hIdRrwkfzUTBKYlBfNvO92oMbmVKob4ZzhZjB9c1BBw5IW
    Pw97ibB3OaoKKtrT4JDIgxQ5cGShHzmrZhaxd6Ja/cDe+qyTB79ezFmTUeRz1945FBsBWx
    aMcBSJ+CVyJ+/Ab5dmFb70QoFXHir6trEQ/JfCxTLO9b/yj4E8O0/B7NB9/g
X-ME-Proxy: <xmx:mqtGaqixYEUhExbsqWe30C9YzZfqQZWznGIZ-vYqPfWBbJzvZwDbFw>
    <xmx:mqtGakfK6Y2YdSIMtP_cKZ3Ig4G2lq5frGCx4vuYNZE0GiUshckXhw>
    <xmx:mqtGaho4UdL9HnDgkI8CDtikuvmElZ2WzmQOJkFwzr7udHIznAE4Ew>
    <xmx:mqtGapBS31BcJiEnBzpbph6nfRUajmcps5PHWmL5l6rszYT4afV-sw>
    <xmx:mqtGatF456pKlTp227oTLn2i2vrCHZYW44ytMK4pz20_YcDaaFeyIvBs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 14:19:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/9] csum-file: drop discard_hashfile()
In-Reply-To: <20260702075744.GA2029434@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jul 2026 03:57:44 -0400")
References: <20260702075234.GA1548258@coredump.intra.peff.net>
	<20260702075744.GA2029434@coredump.intra.peff.net>
Date: Thu, 02 Jul 2026 11:19:04 -0700
Message-ID: <xmqqik6xl0fb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So now we have two functions, discard_hashfile() and free_hashfile(),
> and we only need one. Which one do we want to keep?
>
> The only difference between them is that the discard variant also closes
> the descriptors held in the struct. Let's look at the three callers:
> ...
> Note that I said "descriptors" plural above. Those callers all care
> about the "fd" member of the struct. But discard_hashfile() also closes
> check_fd. That is only used if the struct is initialized with
> hashfd_check(), and neither of its two callers call either discard or
> free (they always "finalize" instead). So closing it is irrelevant for
> the current callers.
>
> I think we're better off sticking with the simpler free_hashfile()
> interface, and the handful of callers can decide how to handle the
> descriptors themselves.

Sonds good.

Our resident naming czar (already Cc'ed) may have preference about
the names and word order, though ;-)
