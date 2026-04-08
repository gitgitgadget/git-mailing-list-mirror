Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5842153EA
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687142; cv=none; b=YZPKWa+kmL47Qy+heOmOBAtdQtLrpAjZOIvxCK5Alu24I0KfiaWN2U/TJ2pCJ+q2qlra0VvY2vt2zfcDDGcuQEriGj8M+1P7s7rJ9cK+5vukSbrbzGruhWvDlpKmt4KMTl6nUugq1jEI1CjcDkHbLH2Jm3hRACJAfbjtugie2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687142; c=relaxed/simple;
	bh=wsRBO2YVzGHD5lww6FuWlvrOwcvJy3kxGEmeAOt+sgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eBdRUbEBdEaJv/cAuC1MPxqKMQh2aFtjIlVA5y0JSDxD388GjDf9CbMh2I297MLzLt84ScFUcLy48lV0WNXpMvOZbckrWCip45HKEtF6+7fPm7ArNmSpBuPDCPNlPqR7D6pZ5QBUP0r9Fj5y4vTylvyab+0u3BS0/I+efnn+2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4kLAFd/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VuLXRL1l; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4kLAFd/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuLXRL1l"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EB0EFEC0449;
	Wed,  8 Apr 2026 18:24:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 08 Apr 2026 18:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775687065; x=1775773465; bh=8VFnq9vm6I
	HZmXy1HwLGFTmbXdFqH1Epo31d2qXFRvc=; b=X4kLAFd/YPQ8jISjAWpjRyfCha
	iXWUUtDYixkSqRoM4whD0OXbAxgpeyYnWwmRUWO/hj8ajwbPrJFYcbkcTX5gOtZS
	aJZP3Ggcldb2S1AyZ76fwSbgvPekolmQtpJ4d3YK6FY0MkZ1XdtzKVvqG2q31EOR
	RdO/QUCi2q4RH9Gr/mQa/SDk6stlLTEzzYFYUSP8WYwgd1Aza52dHYmPdDCDYCJT
	AnGPbVTXu6dgCAAT7Na+0G6uqbyg5TmB4zf2ScmqJEb2eGCCyT9e6qAFNpmCBAbR
	7kLBmHMIOqa/rEqQ6N0A87grJGNgR0RiIMU5zte29VqlvsS/QKFXZ3l0witA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775687065; x=1775773465; bh=8VFnq9vm6IHZmXy1HwLGFTmbXdFqH1Epo31
	d2qXFRvc=; b=VuLXRL1lpvkoqxUKwGIZdmClWNZgg3NEDtQ6c9IEhGkI7iOaIuZ
	AuAKPLR8sKGz0dgburjuI2EG7vUljuwKp3eAq2RMUSzFZJvGOSuMrZu4Evcl53P8
	021n1eC7lwTWQBddgH/8q+qKe7CWCLdpaMTw0ymgiJxLtw3RuwMeTPEFJICpPGgv
	Wy9chrqsiQS2lRA6uu9a53xK7RFw1BTRkcSWffh7cN8ZwDEmGSTYz6E9Fv+f7Xzc
	saVSax/tQ/1fz1LvCQk5eUfLADDwORxcMtzLYe39QmHXhPMBOVoc75edr9eULHGU
	kaFJ3TgQAHwFzjl25YBEbUSHWGI5w/CFr4A==
X-ME-Sender: <xms:mdXWaVw69AGSTd1OhIvEhL0LfM86xFVUeSCPUUghY4Oy_q1h-AfPVA>
    <xme:mdXWacJnaPE5wieQVRFfFEcanZEsOibqm2LSw6R6om9xYy8sbTzTrA5_Wslj6QYgq
    KPmvOGpR-SK8qt4tjvobo51FuUVrpsuo50V2SZVPFtiYvpuS0cHog>
X-ME-Received: <xmr:mdXWaXoMlxxXfMM_PKS_ueeWOtG7lAFfvfNbhVgPY8S4B75CCZsREyIx81f5SHqC5tCjEjNmSZWFWk_B8Y_7rgwYC1YR20Uu_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mdXWaTIWn7PVb8mSoEEPd0fB3QAXtj5zlYFOnqfDYP5kW1XOeBXgxw>
    <xmx:mdXWaUQc229Wlg1T3zdHL2x_gHmSsYYpJdoYlDkoYZcsJiahreg2mA>
    <xmx:mdXWaat6XIbpnUwxKKWW6wS62gH5Nl9kEhmQQiW7jvQBuZsDFA2NAQ>
    <xmx:mdXWadYkcwEFDLUTC5lzzO8z_5IQh6xMLt-BvFW0ZYfiakGzO3GE0w>
    <xmx:mdXWaU6bOp39S4p6oNh8WHvCY0KHaL0t7B6jaLd4X6LG-uLeE1DIDvkc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 18:24:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "'Jeff King'" <peff@peff.net>,  <git@vger.kernel.org>,
 <rsbecker@nexbridge.com>
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
In-Reply-To: <xmqqcy09xh53.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	08 Apr 2026 14:43:20 -0700")
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
	<20260408041716.GA1324339@coredump.intra.peff.net>
	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
	<20260408173949.GB2850002@coredump.intra.peff.net>
	<xmqq4illz5g9.fsf@gitster.g>
	<014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
	<xmqqqzopxkxa.fsf@gitster.g>
	<016b01dcc79e$87472860$95d57920$@nexbridge.com>
	<xmqqcy09xh53.fsf@gitster.g>
Date: Wed, 08 Apr 2026 15:24:23 -0700
Message-ID: <xmqqzf3dw0o8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> To be quite honest, I am not sure if it is even worth using writev()
> if we need a loop that protects against shrot writes, so unless I am
> grossly mistaken (e.g., perhaps there is some guarantee that there
> won't be any short writes for writev() that sends data smaller than
> 64k that I missed in the docs), the best course of action might be
> to revert the change to use writev() and use the two write(2)s as
> before, *if* we actually observe that the current code is broken by
> short writes.

Ah, sorry, I should have double checked the actual code.  We already
use a looping writev_in_full() that wraps writev(), so there is
nothing extra that we still need to do to prepare for short writes.

Unfortunately, comparing write_in_full() vs writev_in_full(), there
is nothing that corresponds to xwrite() that can be used to hide the
short writes and chomps an originally larger I/O into smaller
pieces.  Unlike write() that we may receive a single linear large
sequence of bytes, which we can choose to chomp into artificially
smaller pieces and write them out (up to 8MB by default), writev()
API lets the caller to prepare chunks of memory and I do not think
there is a good way for the writev_in_full() at the lower layer to
chomp these into smaller pieces, and even if we could, that would
defeat the whole reason why we rewrote the original code that used
write_in_full() into using writev(), i.e., to avoid extra allocation
(and extra system calls---but if your I/O layer is limited to very
small writes, no matter how we chop it, you will have to issue extra
system calls to flush all of the data out).

So, I dunno.


