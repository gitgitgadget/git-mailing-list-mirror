Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55667262FC5
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677364; cv=none; b=Czu7Hz9/CrfCg3l+aZoIDzrf0rknsVXJlNGcrW49GQ5h+PaunNi/W/TNJVEIOdI/Z8tHH9d0SVOq5FkMBuod3bXQXTM8J8uhMVLsSjE5RwLgVl+6ZUEv+FmUQur3rEyNHj7iuUQYun5U/iyYls0WAO+mIEsEFr9n7OP1zmEfadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677364; c=relaxed/simple;
	bh=+NaRR2ybb4PddecU6IvMLoUAjGrHsVLk1g0zcuWaE9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oT2SiQWQukFla7MD8YooUmZVvWeCDLkxYLfLEkKXVz3tY9yFmlR2h6neihK1ge0Ys/4xYD/+rICg+6bocNz/s5cL6ON4VdAG4UXcsW3i54ZDJ02mIdRQ7gGgFl4vSXj/DdPxoOjJth8Xqv/ud26Fm72iUX5dOKUlgLl3VZupAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pNfOzRkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlsVhCYI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pNfOzRkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlsVhCYI"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 51FC11D000D0;
	Wed, 16 Jul 2025 10:49:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 10:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752677361;
	 x=1752763761; bh=xL/xbAkADqZ3SiFb01zQNQMrFkbzW0edgaaS/p6h/f8=; b=
	pNfOzRkT/Ug1KlBcBRnfk6lGIujb8/xQk0JWi8nroOBYNO2NmFf/NsaVey0+KF8N
	TGN2JBBj/b7NGCm4wiptcHb6JsGSgQmY5Y4WTA0RqgmGzDxCZCJgutX/6elQWYlq
	hTOZG1g8ECtpDV3P9V+uFNpZSnVzke+/TQ+B/MirJg+nMecjj0aSVYgW2loBSpPn
	OUQtwnntENSGE/TUc9v4UmNhIgXlB9g8bAVZ4azpx8oQ3HjVvjWFXcuuz7smns4C
	Hc00u34dxoWFCis3RXK7k1os3RzzvonWyGoxM5mAoDpJ9iEX2u3t4yO3sgD3BoEt
	Hz1bLeb6ybPgauUIzdlshw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752677361; x=
	1752763761; bh=xL/xbAkADqZ3SiFb01zQNQMrFkbzW0edgaaS/p6h/f8=; b=V
	lsVhCYIiGKzAtJB2J9+u3+4f4uQhxm1K8AdODDsOUKMiUZqMkNY7iwCE6OIWg7D2
	VJ6GuUso6eehtGGcCagdwaYu+rerq+rV3vjHiWamcuccOLWn3ic7Fi8VXw9B2g2M
	kORlaHZ+gBqFktZ9a1r51x9nD6J1+I9XwY7YpiiPByxUmZpeWK3WxE4Qzv1fY0ZA
	PqlZM6L0qUbjiGYa0AD6IUfejV5Xs/i17MLg5LU6uEc5HVZE22gBwDVeNuzNA7d5
	1ycxZWEgxMBBEHiAf5kYC8JfXrPK4u8yP7JWY70lK/MF8FWAn6D7egQ2PLONp6ub
	zQsBLm7iUFFpWHicR9O8Q==
X-ME-Sender: <xms:8Lt3aAcM6-hygAdepqvg1fdEbDZFo5hgPKd9fxOuvd9VLMu-92I4wQ>
    <xme:8Lt3aMx2QO81EegGUKeu4UvVF_-qQecVIMWLAVW4DEIG8oI2noYZwW9YO6lHQ84sD
    HRkbb3th0i6KA4rbg>
X-ME-Received: <xmr:8Lt3aOHqXQ7F5Olv89SYqN0ORtTOVKO8DH21BL7IWuPcwI-5w9dX4W2MYvYXJFOKDwc6hZWyEPMXHZfBGbjW_I1GYfMINzn3jAKZa2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeellecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:8bt3aIxdsNEzOKfZ4V54S1YG3bvMEmvpmlNwHhUXPoW2LxMMCUCELw>
    <xmx:8bt3aHvqya9vLNFkw7SVHlR1KyZtqySKew_GGIfZ8tAAS4xILMwP3A>
    <xmx:8bt3aN1r8pzgovjiKTx7MCoMZ203TePpD7DOGFwSyMkUdfTuJOdDCA>
    <xmx:8bt3aK9hCdEnUbikWf_8R7GQmwZ_BFcxmbTHlHbqIh6ofQAXjHKO-w>
    <xmx:8bt3aPsE8oIWOsy_xkvtfu476MQPVzfYSM2tZqeXc2x800kuSnZXOOx1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:49:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] commit: convert pop_most_recent_commit() to prio_queue
In-Reply-To: <20250716051533.GD1396022@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 16 Jul 2025 01:15:33 -0400")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
	<xmqqv7ntdmlx.fsf@gitster.g>
	<20250716051533.GD1396022@coredump.intra.peff.net>
Date: Wed, 16 Jul 2025 07:49:19 -0700
Message-ID: <xmqqldoodwcw.fsf@gitster.g>
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

> On Tue, Jul 15, 2025 at 05:07:38PM -0700, Junio C Hamano wrote:
>
>> René Scharfe <l.s.r@web.de> writes:
>> 
>> > Use prio_queue to improve worst-case performance at the cost of slightly
>> > worse best-case performance.  Then add and use prio_queue_replace() to
>> > recover that loss.
>> 
>> Would change in the tiebreaking behaviour (aka sort stability) also
>> a cost of this change, as this swaps use of sorted linearly linked
>> list with priority queue?
>
> The prio_queue uses insertion order as a tie-breaker for stability (with
> earlier entries coming first). For building the initial queue from the
> list, I think that is obviously fine (we feed them in sorted order,
> which the prio queue will retain).

OK, then everything looks great.  Thanks.
