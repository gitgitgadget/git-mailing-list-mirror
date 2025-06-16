Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156802E11CB
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750034414; cv=none; b=ZI79M7rBu3djnEY9A6pCq0PANYsK+ZTg6CFTiAVwtfK2+/yWXTb1sO5Oqaao4cjbpqXFvpBdCi4rSF/g0O3//Rivll+Al+oK9ZyBObnKrQC/kWMH2pJEmN80y8yIY7NAezsXacy4+g85kE+8OW8AWMwAJnf7kUy0GPIj1Du2+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750034414; c=relaxed/simple;
	bh=2E5WI3+ueSVXYKriHE15v8Hg4QIs6l0RmA7JI7W/eEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aL8xzCSsa6dBlPxaJyrhuW4N2kSvy6utcpXfZf5v93ho7ozP2+8QaBrgNc3GCnSNbRIlP5lUTZWaz2LfIvYLC27uNjBE3mVbStKidFLVAez+RqK0L/E8nieobYtUtjDnsF+RJEOm1qNBS1aXrtDGa1WgYjycwIdzrHRen2xz7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IOnFEzj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmmIc4BY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IOnFEzj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmmIc4BY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F362B114025F;
	Sun, 15 Jun 2025 20:40:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 15 Jun 2025 20:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750034410;
	 x=1750120810; bh=MyFeL0v994z+HYe7O3YNPIYzDquTdxSaGgpUtKLicyg=; b=
	IOnFEzj8x6vXqLCWXzRSKHYd6M8xjWdzbL9DlOf+OFIPL5BHmI+toPpcXrv9jwDz
	uqmV5Ds6WdF/kCV/Zo0cjWtLKK6/gEqbMCtVXi+YKtggMgF7A96CFdbHQgbR7ZDp
	VCTPxGFL9+g0f5AX8hbR6e5AxFIB4ApC5kSeeqqCComodyP6C3aPy5jrf2p1wKFg
	1lJftTYHSI8gt+9kG1xCIfwgtRTc3Dltw+SiTK+GbSMk/Zvpr1NpAcQEa/0myNZ0
	FA6ilRF/MjxaW42PepUW3+4bFQlP09tgwugt1FVU4kO2o+fW8WMAl1WdZYPjyOml
	p3pmbdkxPEyEquz+iMajcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750034410; x=
	1750120810; bh=MyFeL0v994z+HYe7O3YNPIYzDquTdxSaGgpUtKLicyg=; b=T
	mmIc4BYdicClVxZ+FxoECeSzHcjiIpjmzN1/gmeDg3EMGq68LDScTBF3lJpFYrUz
	hGIZYbNkPcQ0v9rjg0a93f4idR12yGRMSDCIqOSEvztZ8mFd8oFFGNvvPuJZrs/m
	lrtjNWqx+UNmy98Rs9a8GkpxuxyQdwuJI5yMiJtt/SfENOB9a9Sf3/61E1TDspeL
	ed35ElQO2bknBvHfZq8VPCBcVZ9wmhAhOO0pY+OALMWSqnW6Yzl/75f9bf4v6gdZ
	z1Oz/BcJXiaMS3aV9m+x7bIrftmfuAml2Q761F9W580FBg9GGfMfDGo5KjNJWivR
	7OS875ED8GvHnsTUouTSg==
X-ME-Sender: <xms:6mdPaLgSURqITluas4DHcPkTQg1sgwOea42A_S2x7tuhUQMsJ5Yt4w>
    <xme:6mdPaIBk7CRs2sm32R9-OTzvXGkAAhoMSJnk4sEhx8GWKaZaWYiAlxbut5tBGdDl1
    EB_hsWGYSqhIliHIw>
X-ME-Received: <xmr:6mdPaLEiUrj4kvNUh_a4I8vmDIHpIJu_zbLD4mBQOYoWNQJveDO4Ea0NH53UI_m2q3M7cm6YSi_PrKogamBCGqDpCsKmuKbtRJx3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6mdPaIQ3MwSMZOfBrR0jcSXzM1hzMsaVNl8__An2LwInOI6TJN28TQ>
    <xmx:6mdPaIz_oq8rKpff1yyzITru610Oc9Y7ehZXE4108MuXZlOsD8-L0A>
    <xmx:6mdPaO4y9be2EO6iZi0Vp9n6OMlOvuZc6bGdqAEX454BNtu--t3lqg>
    <xmx:6mdPaNwULmnCYEnyBWc4WeV8FNuLe3MvH53KwjxlqJQRjwigcRUOXQ>
    <xmx:6mdPaDtw8it5k3aP6sClMQEuI92WKeuJl9unv3_Raqcdswr9Q3xawI-9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 20:40:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Question: regarding understanding code base
In-Reply-To: <CA+rGoLcsuhhSOVJoK2vEV3m7PgH+8hpfpdih2furnyim=0gP+A@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Sun, 15 Jun 2025 06:18:53 +0530")
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
	<xmqq8qlu72hz.fsf@gitster.g>
	<CA+rGoLehMUWPMBrZ1hOk-GBQBCvSY0_ivFCn1w1C-V_bGTDgZg@mail.gmail.com>
	<xmqqldpt6dht.fsf@gitster.g>
	<CA+rGoLcsuhhSOVJoK2vEV3m7PgH+8hpfpdih2furnyim=0gP+A@mail.gmail.com>
Date: Sun, 15 Jun 2025 17:40:08 -0700
Message-ID: <xmqqy0ts4izb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> On Sun, Jun 15, 2025 at 6:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>>
>> > What I meant was:
>> > You previously suggested that one good way to understand Git is to
>> > start from the initial commit of the Git repo and move forward
>> > chronologically through the commits.
>>
>> Not at all.  I only suggested to study the initial one.  It is more
>> like biology students learning the common principles that apply to
>> all kinds of life by studying a lot simpler organism as a model,
>> instead of studying a lot higher order ones like mammals.
>>
>> Moving forward is all your invention or hallucination ;-)
>>
> Fair enough I have read your biology metaphor
> into a full evolutionary theory.

I should probably have said "before" instead of "instead of" in the
above.  You were looking for a way to see what higher order
organisms there are to study, after learning from the simplest
organism.

"git log --reverse -p" is a simpler replacement for your shell
script loop to do so.

If I were doing this, after studying the initial one, I would
probably see how much of what I learned from the initial version
remains in 1.0.0, 1.3.0, 1.5.3, and 1.6.0.

1.5.3 was probably the last version one can read cover to cover in
one sitting.  Anything after that version are just too big, I think,
but there probably are those with more patience than I have ;-).
