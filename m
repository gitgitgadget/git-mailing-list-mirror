Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC7276D15
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699158; cv=none; b=EvwGd0lgwGgkn2t3mxkdH7f2+vYM+JN79snigL2FdUUvO3/Gmod5WBMzLBAXp+GDPWhsukSn1LJYVAp9CdQUiY7KiGwoMYL2pCQDj4nB1VWi2aVtXeIl0x4qLtoYSf2plK3EF06eryj+e9il8wvQsXTRh74YrwgNsmCPpZPZyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699158; c=relaxed/simple;
	bh=jvIK9MFuNEZH12Ngs+VlBd68vFgOFojHSgggC2WUkRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G1cgC63+QklsOazn54ZEniNf0O0V6fy/MGgZQV1cs/+0SRfJT1eSPcgXClyiK8UXf9z1HeYwyTIkFiwVwllzIzqoBZQmLR0OWwebButDLPbr0MsDvF1fePsK4trSY/1exsLEpXzWO2FC3K3wNIinw0omrNR7OoSDx7KTcRNz5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KjRDCry1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqbMk6Kc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KjRDCry1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqbMk6Kc"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B0F12540131;
	Thu, 27 Feb 2025 18:32:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 18:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740699154; x=1740785554; bh=dkL7nraFCo
	WJCFpagIrfEXNoGK+MKtxKgfxR2Gs/RkQ=; b=KjRDCry1P5yRv3cDRPqBw3/Xqx
	jUn4CIdE6HDkC3PyGFlhZMcQ+oZX4DPMrT3vzO5y6iETm74xyy3EODB+PH+xkD/3
	GQSO4MlyThOwgMem/1+2YttOVKloz2Q0PwufzHT8JdlI2ocADYmrmY8Mi0puRRUs
	n7oUmaBQaSEwY9DcmJo4fkBIyV/AMWV+I62/494+jPB4h0RP3hw3I+RL3q7FSc6S
	M7AcKDcMOkQq6iIRrFoHzo4tGtcXuC0qF8x/MEZSliZFzaUl3w6jeGxu7yMIyxHH
	yggTo+VNi8jZxERMVrqJJLtSdidg85gW/u6o02vaXti5jCwxlOSxrCS0BJ5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740699154; x=1740785554; bh=dkL7nraFCoWJCFpagIrfEXNoGK+MKtxKgfx
	R2Gs/RkQ=; b=dqbMk6Kcsu69qzuHJa7FzECVBquM/hOaX7uRAvGNsyzcqIMBrS8
	yk+sOPftzdDZkSZctdUPNEFPdhSFWwTxlQUEBwdujZQigyzh+1LMkixaEMT+LJVg
	ynmto65qVhE814bWi682+0L0AnkAKKoCSN0W3UYdL/EyWR/i0ZvWqjtflnXACjO5
	S1NidsvJ6QWWcQp8gTqNzyTNbRg+WSsHU75IgO3neQG1aJtAqUYs/ANi+NOMfs10
	VQcdzeViY1aPV57ka8wm7BXd008ScrTm9H4AzzTibxWpwe1pbYehqdqEvt+qB90x
	b+I/jJzZVTjOjKmWzFd/WJFRe4IitvbRZ9g==
X-ME-Sender: <xms:EvbAZ_Y8SqsJ_yZOOyXigszi_yDtposBIQlUDpn4q6GRbk0ACLv2JA>
    <xme:EvbAZ-YUH3CGRs-FrOS6EC7Zl47EmdRsUtG-ktasA5T8rBWB_VSR8XTDU_uH6RX_b
    uGHbvHKx7bb0q1J9A>
X-ME-Received: <xmr:EvbAZx_ialkZaYl-SHFCRFpjJVuTV7xrLdUmiLe6mMYBfIayR-MEt-UwcS_hGHiyaOIH_870Ftwskr-NGlaryUSOhcFvKVFQMEDu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:EvbAZ1qNIbUZ1bmWtOoF-4XFHhpZHZ7PJhKBk84vMVt6puMJhMEuuw>
    <xmx:EvbAZ6rPg9uSAEYe6eHV2-YOHkHU0QEu3-d350vO1skdmo9o1haltA>
    <xmx:EvbAZ7TDUEEoVEXPcBp1qQ30sJczjgHdeSjQux0rSHufz6lRArHxuA>
    <xmx:EvbAZyqdxFMyoGHFIRo3YCZKroxfX26hAMhYinCji5eugX621dug0w>
    <xmx:EvbAZznn-Av6v8GRzV-8YKe9kZfsiIyaB0Yfo2QNEYVa-3ODYXVADNcS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 18:32:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
In-Reply-To: <Z8Dz6EkIpr/g3vuY@nand.local> (Taylor Blau's message of "Thu, 27
	Feb 2025 18:23:20 -0500")
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
	<20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
	<xmqqseo35ic8.fsf@gitster.g> <Z8Dz6EkIpr/g3vuY@nand.local>
Date: Thu, 27 Feb 2025 15:32:32 -0800
Message-ID: <xmqqo6yn55gv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> It looks like the aim here is to introduce a function which executes a
> callback for each object of some type in a bitmap. That's a thin wrapper
> over the ewah_iterator, but it's not clear why we need a wrapper around
> that function since it is internal to pack-bitmap.c. Likewise, this is a
> performance critical area, so I am not sure I'm in favor of adding a
> function pointer to a hot path which executes once per object for some
> object type.

It internally introduced ewah_for_type(), giving the "struct
bitmap_index" object an abstraction that callers can ask for the
bitmap for any type the caller wants.  Before the <type>_all bitmaps
were introduced, there were one ewah-bitmap per type, so it made
sense for a caller to ask "Now, for this bitmap_index, give me the
ewah-bitmap for commits", but with "commits_all" added to the
bitmap_index object, it is no longer clear to me what the answer to
that question should be.

