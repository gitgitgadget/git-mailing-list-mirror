Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A033F36B
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775684936; cv=none; b=A3ATPJVqL8ZspOs5NQ1HPLtGw7ygVHMl5wZcnDhkWzPH7oZvk2GFKe/GE4qdFMVK8Gv63k98dytIiPijTGU2Nj6wL/B8l2fttY0QZqOReP6UEupkssm7K/FXmBGMKPuXf2k6Rkt9wknjbZIm1OVtwPuTj11iI+2FYZylQmOmmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775684936; c=relaxed/simple;
	bh=HxB5k9zcnOOPv3Ozes5Ub16JFSfz7HUfID4MNavGHxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TF6rcXwKqKrzePWPGxW2B5hswu72OSU95xCx6amnzcLtHA4GCbPD6/gpUeUrSZ9DMpyC8je84CWd3jwcORs49AEhbiv1z51P9kwtPRCBgJ4t+FIm8u+6Ss4twwwXNUWScrKgyg1FrgacBl4t0YwWZW+je6/In24giz4mNZh6cv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e0DkInA1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QR4K6RIn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e0DkInA1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QR4K6RIn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 35D12EC0412;
	Wed,  8 Apr 2026 17:48:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 17:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775684934; x=1775771334; bh=7u1JieHZZG
	/fjL/qjSmmx46YPNOyUWZbFhlHGOTG2FU=; b=e0DkInA1FRlouhFmPJis5ax+aP
	9ovNOgj1IebkFJCDDyWYKJyq/TR6BPOG/2RSnE73XhMVBEn/SB3dPAcOGTXofEnA
	hGKyZXNCPqOqNqVcRhHNyyBayEE92OM3ndz1M1dVC/38+Ysj2sw88SGcKnE4jzgc
	+Vyb5cqBjYq3R6qFS0/gV9OYVJESGBAjEnZFDQiImjCfZppUc+wXXLUPW1a8zaXW
	o8VNFSC47PxKU5ahyKNr7A4vZSLFYbtbiyIvLMdZh+hjgWX4qw5T2TSWxCzdEUZm
	vWt4f8RmSM7XlDoBnxPt0MsghMV/CdpHgKDwfQklMikS1xwVqHI4gje5ZMEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775684934; x=1775771334; bh=7u1JieHZZG/fjL/qjSmmx46YPNOyUWZbFhl
	HGOTG2FU=; b=QR4K6RInCKOXPqJwQeHA+wTQLIDRxiPz1PWnsvBoLWoGI7U5Qzt
	gd0w2wRCm8DgMJXv3+LH+vZI6J3A4+pxYdmRa3S2lo+1/e5KlrXZ7MQJ41wYpdHQ
	Lj7FOxwnb0PTq4fzP5Xl7jaMzPCkKWoyP8BQvHry0Ga6Gc4UN5rxUrdcFTElLrm9
	5fhgm4wirsWSzD+1cGhrW7kwa7bEmLZlKmBPP3iSRgQv2YMFHgQoWUz7T9K6mUVG
	H7V+fHxteXss4M3a2Ys9BDpZFrO+0G7/KpKRQCrDIsJ0UovXgIJsUevEJr+Rj3cH
	HFFOfzmn/QZcgxcLkRy9bT8MAxnuKwRBopg==
X-ME-Sender: <xms:Rs3WafcYsJocNlLcnCk9GkSERfDCwdLoiDF460rc4CSfaXSlgpQNQA>
    <xme:Rs3WacqC7vrLfB55YKODN8q7bKqhk-Wlsz0mkqEzIpuuKJcJJ1e5UY0_8mg0ctWQQ
    hvsT6nIECx-BNGrSWx_pUKLI56bOX5pTaK64WZiLuAP9wdhvpqbUgo>
X-ME-Received: <xmr:Rs3WaV40xRMCrx3g3YAc3qFdUYhJyFQGzJJAmOftTQ-95xxa-f0LSMjQ6FbsyFsWU0XcE7eYUvanIwEnLLihosc7s8fHiTvFtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:Rs3WaapDdksL10z7h-zbQsvSW9PeeECJZGikZPmDOLubbOAqJHaxmQ>
    <xmx:Rs3WafgGP5m1m2zRuRQNSUMqqQhOAYBoN5Px2Y2E2UpnY6Hdd9CVYQ>
    <xmx:Rs3WacJISmcWSUfrgQVAJ7Q993CQzLD0Peu6JS5APme_78sR4wxTug>
    <xmx:Rs3WaXBQqnTJFvesWznj2rRfALqh2XnxYqIG8FmPGOhkuVOt5Y_F8g>
    <xmx:Rs3WacwdpTFz9Wksj2EOtiEtsnImNz0VnhNbdVgtRCRyjYecsmWu8XY8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 17:48:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] odb: introduce "inmemory" source
In-Reply-To: <adYQPmnajLmVr-vh@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Apr 2026 10:22:22 +0200")
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
	<xmqqa4vknjab.fsf@gitster.g> <adYQPmnajLmVr-vh@pks.im>
Date: Wed, 08 Apr 2026 14:48:52 -0700
Message-ID: <xmqq5x61xgvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 03, 2026 at 08:41:16AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > this patch series introduces the second object database source type,
>> > which is the "inmemory" source.
>> 
>> I cannot read the word without a hyphen, i.e.e.g., "in-memory".
>
> Fair. I think I'll keep it as `odb_source_inmemory` in the sources,
> which I find easier ot parse than `odb_source_in_memory`, but will adapt
> to "in-memory" in prose. I already did this for most of the part, but
> not in the cover letter indeed.

Fair.

FWIW, we do the same for "in core" or "in-core" in prose, and
"incore" in identifier names, so the above is understandable
position to take.

But stepping back a bit, does this new "in memory" refer to a
concept that is different from what the rest of the system uses "in
core" to represent?
