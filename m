Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51328E3F
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752974576; cv=none; b=b1hG1jli0JS+wSFYHXNf1EuPruMKcFiHHUZfMF7aOg3Xxggvl+Um3w4jeYp/H5FeA3jRceWfDEvOSD7X5tZA35ufk4Qs1drlK8NBIgrRjcjct7aeIi6phZaWXZPttSxVfgeoepqhEXL+vEcHhjWSJcKuoiTZyKxZ+pcBBkyW3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752974576; c=relaxed/simple;
	bh=Y+H7fG8go4VUW2WLQ+NajnoGBt6ihfgrFPkyk2jsS/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mFe6w2JaaPFFXKK646rc5jHMWEP7N83VlXLAkaovXJGeJ/bLMC++cxyrxBvH5rz/HZODwLeqnuP1OaF7hx2fLh79Q/ngJlT9vy3GL6nAKvu3f4Y6o6YXH3NuOiZO/rYGh00Dn7eXyJ2ILbMyjigTFrQKkzE8zDKsMqCX/33jx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fCfZf+l1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCTxMBMR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fCfZf+l1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCTxMBMR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DAF60EC0193;
	Sat, 19 Jul 2025 21:22:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 19 Jul 2025 21:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752974573;
	 x=1753060973; bh=7Mii2c6hTo95V+6jl2lMCi3oOJBszUPHqpOwoM7GXeI=; b=
	fCfZf+l19y85FGf2zGkI1viqX6bbSEmTqB/vQ0V00o19aJ7+vtrmScD6KAfuPH+B
	Y2Xh6WFpV81mjsKUx+UQT3ZvGSaeoOxvH3S+ACw0XRmELBS5Ooiq5DtIb42RjEtT
	lHFpslXNNR/tFUth/BjJcUlvwZi2JLDlyYzk/NbG0UT8D29CZ+wkxr1MB41Eyzal
	4KNQGpIMD2H0LV3Vco0DBEs1HKNYuqQERvD4cdIVD5SVJBcV0hfoMGdibOzouJaX
	mXkJsuVMNsStU/FcVSZcnz/XpVZBZza8w+59ySRsJmXkP8SHFziWv1h3nPKf9hOV
	HXtEiPpKIcPpc+BZOL8gwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752974573; x=
	1753060973; bh=7Mii2c6hTo95V+6jl2lMCi3oOJBszUPHqpOwoM7GXeI=; b=c
	CTxMBMRIm/fJ+XxOESixNPH25fdwTYRPbV47U6gUz7PVeAsVbVyGs6WT6Uet4AaB
	f5k2+yPdP71QKgSppuj4ftEvh2YzSGxPuIsUevALMFepuS00w2zdUcZ02JrWeS6F
	Lpx8EwRYGEmQPSO52Z8z4o4HecQQIINiiC3mO0jG2uA8igGdVuIjK9EtjGzt2IEI
	gsJW+o6/rvh7Zpx/DaZn22icpAhamUVBb3QkqiXX1cy/iv9wEFffSj9V4S+o2azW
	n8esIwzcJWt/K8gBnRYOvIeJjMxC3wJhI68Uvnotuoo8GN+GFptMc/Le7en2T/q+
	MgCfjDb9iCvlhYs3gmmSw==
X-ME-Sender: <xms:7UR8aH-kQiRc3UOf1YW-sWJDRC3-NTM-qvyMwFRh6lFnrRHSKs62zw>
    <xme:7UR8aOQxKIWPHtpRUBSjV944dJHZVvrJyR1kNmRB_i0SXeF1OKDTzkaz8krSk3dcz
    O0cichLKRwBO1MjEw>
X-ME-Received: <xmr:7UR8aBkkQF4PpwdV_oZZ1Io86NqUE8t9SVAdPNhlTNh9Ljy_8nPmXdBFVQpoqixEqyK-q19oGm0qRJU6VuQHNtiFYrtIVKY7M0roE8k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeijeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkefotd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghf
    dtjefhgfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7UR8aGQKC2R-5QZCFYEco1ITEDRxzeuUv8leyDW5kv4WOGpHoR1Ozw>
    <xmx:7UR8aHOSzx6lvDeeHj_-CmpG3M8y-_Kwh0jHjkAalKx6WS_DbjYepg>
    <xmx:7UR8aHXA499Qa9l7zZyCGQkCyBgKiHufhci3aKxBKXI9t8NyBDFIcA>
    <xmx:7UR8aGf26u8j8rirDR0EGRBTNcdcOze_ljGe1Cuyn5ucYQiLLIhxlA>
    <xmx:7UR8aLPzKdGH-j8_iP5f1cj-4mhQN9JhJkBC7rS67rVlkcwFCkNm9QHx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Jul 2025 21:22:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to prio_queue
In-Reply-To: <20250720000359.GA743449@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 19 Jul 2025 20:03:59 -0400")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
	<bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
	<20250716050540.GB1396022@coredump.intra.peff.net>
	<b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
	<20250719065558.GD705356@coredump.intra.peff.net>
	<37f34e15-f44f-4b8a-b684-bda27a977775@web.de>
	<20250720000359.GA743449@coredump.intra.peff.net>
Date: Sat, 19 Jul 2025 18:22:51 -0700
Message-ID: <xmqqseirzmdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> On Sat, Jul 19, 2025 at 01:15:28PM +0200, René Scharfe wrote:
>
>> > Hmm, I would have thought prio_queue had less memory overhead. You're
>> > spending one pointer per entry in a packed array, versus list nodes. But
>> > it's true that it doesn't shrink as items are removed (though that is
>> > something we _could_ implement).
>> 
>> If we just count the net data then a commit_list item has two pointers
>> and a prio_queue_entry has a pointer and an ID for stability.  That's a
>> tie.  ALLOC_GROW overallocates by ca. 50%, so that's 25% more on
>> average for the prio_queue.  No idea what overhead malloc() needs per
>> allocation, but I guess it's enough to tilt the scale back against
>> commit_lists.
>
> Oh right, I totally forgot about the extra counter.

Don't feel bad.  I forgot about it, too, when I gave my "is it
stable?" comment to René's patch.  ;-)
