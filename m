Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3B286890
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368656; cv=none; b=GcWte18p3zuSR4rmfHqdxwB4R85ZMOgcGAmt3b0vtoKgmnn5VuGJrZNIGrJHfOCC/BKGn8uBU5U2LaqDVo1NPZXcFwdDEXKGmeJbSSoW5Z4VJe+xFAr3kj7wY0/s4u8vqQzm4R6gBhOLFHvD+ASOWCLiBI80Uj1GvVjA6sUapRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368656; c=relaxed/simple;
	bh=4GNaoCEC6r93RQGEIEMo3eLZDUUthP4LZwZoeZYoWKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSrjqeigdHTfCSWUb67Hrrgo/Y6SB1tzvifmLwsMEk0VX4dDpPeH5VpLe68l2hzi6IkK3TeE8s6llVJQljee9OCyLmGGTR7JLcwpoo9mtM4DPsRwHu+f3Xvw1wvGpRGQo75+v8dlfZheAX7mPjdNLKAaUQJCK8IiVSLLEk5AX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dgqH8TB0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MIn3YBij; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dgqH8TB0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIn3YBij"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C6E82EC0067;
	Mon, 13 Oct 2025 11:17:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 13 Oct 2025 11:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760368652; x=1760455052; bh=nfCNZZk3H+
	93mRFqItBBdOS/phx4F8yylmn+ccMzrx0=; b=dgqH8TB0fpQU59PKpdp6+uQWKg
	cTHnwG93MOHi6eRC6uBo9HTzy0OYUkiONJdGSWwETWxq6tcMUonhb+u37LeEJXRs
	nDTkYG1s5M7uOv6ZPCZlc7RZKbELKRfGps9Xkw77aK+LTGDmM8rGC2id4ceXzPYv
	hm1xNWa+i3LPwbTIZqkswQhCDz8E8G++Ti9FN/2OdzTEzUv6e09jyfoxp+wk817x
	D9FUlEPMf5s/9mDdtbrrsDMtKBD1qBtKRg0bPnt0B5rLMIpDp/njdz+wHC2nbklu
	cKrHIxh4AtMqh4AoknLoVscydBfBEBXRx4Lte4XE2rwioCZkOSmmydXdnQag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760368652; x=1760455052; bh=nfCNZZk3H+93mRFqItBBdOS/phx4F8yylmn
	+ccMzrx0=; b=MIn3YBijIdSJRN0RFLhrzb0a14Za6k6XJ/TSLS2nWsIOPXYbYu2
	J5sIlnSWQWlOo+9qJvV2ZdgrDRC0u20W78zMJ2997wNXrwJmlP96fQDODRy5o/6E
	TtLFJI5/CnEGDzfH71f/iDaTL5lsF5W66qio3Kz7oQYs4hSIKDL96NNuXhlEzzWG
	RPsH8o31b47rNJTJOKmZ4+0XNB/nlX+2GwcqWPD0ehylGgVp62/RDS5KSp0BbdPd
	8VCQG/hwHl2QUCX7VtEgA5ZzEqJ2Z8kCemIodn8OgDHMzA7Plmp4Pr9SqI/66uSU
	27jhVHvi5yiTejGyDnBLIfK8s/QiPcV3kHQ==
X-ME-Sender: <xms:DBjtaMFic7hk3mes6b_Q3lO9ksM2FlErKYn7rVuhK0PLD2__bwn4rg>
    <xme:DBjtaMNY87bLAy8pr-1_cq2ntTT7LOiom4u5xjJvsZ34tvbQ1BW0sfzdmK27M1MCb
    83ix2tMqOUXPHpWZ4scOXIC3IjfokATR6BiYhQXSUZxwHhLlUg0ias>
X-ME-Received: <xmr:DBjtaOePMhjG0sMteaxQ5D5XkSXl6eo62xs50QIRW5NwogtBDgn1dqSZdiKa7MRb49fz0ulLLeUd_31JkeektXKWKmaDl3MUR0ad>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DBjtaJv5ZTv2KjD8r0Dc_RV3hn8oYkaIlk9INbVoWf6bYmC7Tn7h2A>
    <xmx:DBjtaPlFpqJUSJHyRnoJYHo6deWdRLexFR9GXQmo28vDr9KWoL0LbA>
    <xmx:DBjtaLzaMRdSbS4Fm1GDZB9tpAAKe6qyTmDVaE60yp_4ouZX-1udnQ>
    <xmx:DBjtaBNSSK7XtwdGwwezmJ-ZbMTPjIBVG4Fwbsx2_u9Pl0TgKn3z-w>
    <xmx:DBjtaH1LXlBLV5RTgn-0xCxI9pN2UHz80sYXl_bJDEkMuca1UXGKuvm5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:17:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: change the markup of paragraphs following a
 nested list item
In-Reply-To: <20251010222304.GA2007405@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 Oct 2025 18:23:04 -0400")
References: <xmqq5xd5aqa5.fsf@gitster.g>
	<20251003031113.GA6381@coredump.intra.peff.net>
	<20251003034134.GA625140@coredump.intra.peff.net>
	<2239952.irdbgypaU6@cayenne> <xmqqo6qeag9n.fsf@gitster.g>
	<20251010222304.GA2007405@coredump.intra.peff.net>
Date: Mon, 13 Oct 2025 08:17:30 -0700
Message-ID: <xmqq4is24yr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think we already did, in:
>
>   https://lore.kernel.org/git/20251007082223.GA3336685@coredump.intra.peff.net/
>
> and you queued that on the topic (and merged it to next already).

Thanks, indeed we have 84a6bf79 (doc: fix indentation of refStorage
item in git-config(1), 2025-10-07) already on the topic.


