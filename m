Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D8485502
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240625; cv=none; b=cQhzVSG3IemoVLe+Dv0somIu0rnh3nIwhuoOYmznPg/4EZRXL9zXRnCvtd4yW8/Ud8fiNBn/y7uag2N/qi6E/Y5FwsAJ276Ws4/fNPH9ytShTCrJFLVh4LjmZ+Tl3qqns/Mdh0z9p4B/t8Kv+/B/ZIfcmJnIjw5MZzEzB89fYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240625; c=relaxed/simple;
	bh=v1Qw4QNGunDLpA/7ZllgU3gFUVsicBa2Okmy44GNOCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URCwMnWovq3QuceaotiwMtBpeWrdEHbfkk7bL9L4Sb4XzRHq3rL5wB+OZcQT+fFoQXAFtWEdM/OtwajZ9+XNOacvJPkYOziBBbf9n9aJvg2eZeg4v3nihulLwI2CW3N77Ppov8I9qQvhnUEiqwOPwqsytN9PF6OKnncmMUJH1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q9wXP3Is; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByKzwyrm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q9wXP3Is";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByKzwyrm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90D837A00B5;
	Thu, 20 Aug 2026 11:43:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 11:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787240619; x=1787327019; bh=M4Lzp7ZfPv
	eOnsVcrZo2KiEMLSoJ3sfNEOaXwf9i4E8=; b=Q9wXP3IsEzncSWPu5z1E/3BJg+
	vV0vRK3E8akdwezna2tIrYIebng8oySIfNoRgpAN08Sq4pA3CmW8oNrmA2PHDHyE
	OGCAk7EZvavqUoOFpH+eH9rE5eJTuUoJouSZ19S+46twSQ4tCn/FNFgwoezxxn+r
	fDGKbRPdHdzYNRllFbYNu60X52SHoO7n4l0PJBUH/d1znjXifxJnyXfwXLww9SQB
	r3xyhkkWNr48OgCmvAiJXONDHSO0DAFVXMNeVN7Dv7VXTRy8z6vWdqbYiHcluS2Y
	c9gBVPUO5sIS+oEyorpceNj+UZKsmYphnljRf32dNKQ/fGsoFcbhhvbfzCMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787240619; x=1787327019; bh=M4Lzp7ZfPveOnsVcrZo2KiEMLSoJ3sfNEOa
	Xwf9i4E8=; b=ByKzwyrmBc1939cwAahEoGKB8L3CZRCDcDSc+hYdV4y1XgTkOoZ
	zpusUmrNzPGXnN+6ELbfoVVb7lCqwcUKZ04u/Tta/7pMIGIEmU0GhYvaykM0spMT
	ATObaNHk070tvcfiC8APRxnSq7ARmB1hm4OvJ6E+v5ldkP2+XG7qSvZ7AB4u6MhQ
	zPxg4zNQE7kzmOM6elg3eGA0awqDmVRK+/332M7ETHna53/9YwVwUEiwV218p6rB
	w5Eo6crgjnANq+Ws6V4bmeabe16V8/l8s5OX8H0tPQ5OOhRFHSsbtNCse9PraClr
	qgZMaAW3zznUPyIjB0giUZsyKYbS4peqZtg==
X-ME-Sender: <xms:qyCHamwyoznW6tRv9ZROQJH2v1npGUG8gTdSOiemwRsR7aMQUEZQ-w>
    <xme:qyCHapRAiLCcZP7v-dvn8IHp_7TSR-YKsN7j-krkK1suvc5eY5JZrpfTHtnG0BoGO
    ccL6mkeoH7OV181KnQEV5_UOAJzffpkgSvrSD7OPCN_-yiwGUHt0-Y>
X-ME-Received: <xmr:qyCHatWEYuJ8WTXJwPNx21bNFF-f7KVV5d18_RhKnHaP0lYXP25guh_7rjxZfuayzmvFciXcDAq2unGZeAPQkgMWNv2xfa_Mnw>
X-ME-Proxy-Cause: dmFkZTF0QtJSHCyAdzxArq49YHDFcAozWie4f2U2P6Wrv2UUyTu9txsO6+exk+iBSuw5a7
    sr2lCa7wl2p+tA5aA880ODRSg3dgfR02gV7aa0xRgN3Ta0MnBONLVZueTmIXrYjrIiD2KY
    wTj2GEo/ixIdsDjZt2OpbXr9zvoprk+Y4d2gfKsrtboH9ohkJFq+0y4nitJ0LSLvxXIWda
    hKq8OQH7qBKoOhEX42QRfkaks6YhKnnyRZ5V2xz4UmIeXmy6k/qRCDE9mvXk8ycUuNUa7J
    0p3hOF72/vj/74nnUMNICOK8wNnO4fC+UzMZ8Vuky7nV75CFtJIvpeJwuEaSSd+a5nz5Iy
    5hEgwyO7rzKVPK/5avOaqktSjaoQUxVeKlaMFZHu8cO/G/f7ae0yYLT62Dj/rszd7+IYz6
    Osgirc/MMRdy3DVUlF/D+9+NAZdBCC2SLo2KYG1MVq4TWnQIv9D82iUjJPfMcltQrtrgSs
    pxBgI8TnacsIlxu2nTcymRwa2fyPVR+fxQwuSNUmNJwaNPLMJqnbxZgMic7tpF2/pwfT7E
    L4YtjTD8Er0Og87FXY0VJZz9h8n3kYWz1MMVTd4S8njJoI9hwllOWNZ3IqvWdn1K624vAr
    rQ/L8CRS6px7M4l/9i7jsWsSD/4sjY5+wnrT41t49Vb3BU3qC9o3x159tlmA
X-ME-Proxy: <xmx:qyCHarb6xerduLMZekeHHTFn2eMt2YwgZjQh-mvmjSjxuN5j8NIgBw>
    <xmx:qyCHaj15lHbchnstl_IFFTOZ4mvOTBxtnQ39mKXQDMw62--amQdDfw>
    <xmx:qyCHati69try4-aT3YIrmRXpeRmlThyl1vf8xE24XtSegf4Ot1dVrQ>
    <xmx:qyCHanax9v2Oh5umhBid7MFYk9luyGJzD8QJ9-QxHlq-MfLNSMQn9A>
    <xmx:qyCHak0nlwvgZMKBpTeoFE4GRjGIg-nkhTgBC8CSBoRNFsU6htMp77Xa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 11:43:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
In-Reply-To: <29f39d8b-6cf0-4811-afb3-0a1656877f31@gmail.com> (Phillip Wood's
	message of "Thu, 20 Aug 2026 10:50:06 +0100")
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
	<29f39d8b-6cf0-4811-afb3-0a1656877f31@gmail.com>
Date: Thu, 20 Aug 2026 08:43:37 -0700
Message-ID: <xmqqwltksspi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think the question the commit message should be answering is, whether 
> a design like proc-receive that predates config based hooks and only 
> allows a single hook script, makes sense now that we have config based 
> hooks, or, if we were adding that functionality now, would we design it 
> differently?

Yeah, I think it is a reasonable way to frame the problem.

> I think the answer for server side hooks is that a design 
> around a single script is probably reasonable but it would be worth 
> discussing that in the commit message.

Hmph, I am not sure what the hook being on the server side has to
do with the design decision to accept the limitation of allowing
only one hook script.  It is not as if a single entity has tighter
control on the server than on the end-user desktop repository,
making it easier to live with such a limitation on the server side.




