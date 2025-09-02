Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6803451C9
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834950; cv=none; b=tRmxdIVmtV6SYANQUmE9apUBP+oKaf4WXzmrNUnvFQ1F9rnVYfUs3Qs+3iUl6UFKP1Wr0IWFvJm4ChlBxmBFsFrbj6FSrcxSU9MpcF83xWPdvgynUkHeldVAQ2JXiKetyIM6n+OsxWnEbl5mDGzR3FkQs4IE2o6RFVUmkfj5LFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834950; c=relaxed/simple;
	bh=7NPAVqGwofaOnF59Iqv9xfJrNrT0hpwFHznJIc1S9yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OdPdBHSQUCmqFTRX38i8WaQTQzNVxlC0xEdNBi7/SMnsH9YCLmfE17nSAI+CiBh55D4yirU0Ukk9eyCorUsGkING1zLkB6CH24plcthfNPrSxZfLnf5oUGFU4DZ8HR4y70bs5IDFYs7LRdTjFFipR/Z3GOVCl5r2mMMZPmU2VIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qMl9rIHR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3tEtUxL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qMl9rIHR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3tEtUxL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BFC01EC03BB;
	Tue,  2 Sep 2025 13:42:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 13:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756834947; x=1756921347; bh=jZ0sld7bGZ
	Sx6ZbFvhpo0CkBpuSqp4A0NpmbHHUD9B0=; b=qMl9rIHRRFKSBdMWE04Jl+vmy3
	utwBdlWyfhKeFV3GyaUliWzS59VvFHXUfEq6iPKLDzk9aamlDu/n6th/eXMpcZ1d
	edqPI2RJK0u65wtPXcGQq0+cLPsRrvHKZSEYB5xUAxi/XHOekGvWQYIt0j8KOej/
	3EYrZO3/KKxlYz7keCIl9BG8ytbV0uAwSZXatchp+pSdJgzaDNiEjpEugg5b2/je
	kfjUkjzXTx3MvYJQQS60Q+QJsY+uCf0KwczcydjHny+Ze/dBEr4/QjeF1iBJ5vhZ
	5s8SPncexeCWF/ZvUaDWjEvj9U4GkJaTTzRv4iW4MDUP4hJ4q4/Ul58aWAWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756834947; x=1756921347; bh=jZ0sld7bGZSx6ZbFvhpo0CkBpuSqp4A0Npm
	bHHUD9B0=; b=W3tEtUxLren4TZG99LdtDw3F7QIUBk4tR2/DhGIrQv3W+WDR1o/
	491QCD+FUAfwlFBSblvaw2UlsEV66cJbySLBjMC9s0FhKuHi4AtnhRqFKv8JaSRz
	mALSIY5ilTImHefXpdiIK0WgZjkN2eWb4VROAYVBeetfTW/cjTZH0k4onHU9fGR5
	c4RV+Un/6U9weOC1k1UqwnjP9KU0c5ZESC3oygEJ0CvZaJNYEIBqSeSXSaBvaJR3
	J9iOZr3cwfVgwkm7UUwp6f8E88xvoJQYdhhZ/VLPaD5h/QPOF4qdFEsnNNY9urdJ
	X74Jz8PcYCDJiJi0A9kANY7ijgxjard4aoQ==
X-ME-Sender: <xms:gyy3aMRbdlpf1CzRBvccx_4vgLwtfVknAdCj14pc-Kalc_Z635qmKw>
    <xme:gyy3aCOFSrRgH8jPGXi9CwONkDbLHHfPR1p85i0v-S5F8MQ-dHKFU9429gR5uY62D
    iK9stbuMSQSJJ-8uw>
X-ME-Received: <xmr:gyy3aKSRibF8bH0J4i42yLPH0-0WJ1O_0Gxuhrh451rCZCYYfgQSI4TBwdmu7LvtcTXQIt-KBN0w0_-RK_ukJeBrZl8rIqQY6C8y3v0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:gyy3aAgqEhLAhzPkDE3raeEuW1sGY-DGNN8uc3w7POzVBYi6xduOSQ>
    <xmx:gyy3aD80D0JvI_SX5BEvOHhqsMk4bcdmntWuIlLRe2diSHq2fRgF7w>
    <xmx:gyy3aHFPhqNv7oOAxZ0y6DcWUhRLNkrNMe1pR3x6wrjF6OKjmi9kcA>
    <xmx:gyy3aGldiYQK-oCnGMdX3nXcYiJFeTs9mpMciPdqw8kc4f4AidsgIw>
    <xmx:gyy3aCrMw9sAieFTvdzIliRykJa9UAeHBd2y5wVV4RNEV0-ET9qeOqN3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 13:42:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
In-Reply-To: <aLcngI6vm9DmqUeI@nand.local> (Taylor Blau's message of "Tue, 2
	Sep 2025 13:21:04 -0400")
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
	<20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
	<aKz0/WNu/GRYh3/W@nand.local> <aLav4UAcfQjvNzMF@pks.im>
	<aLcngI6vm9DmqUeI@nand.local>
Date: Tue, 02 Sep 2025 10:42:25 -0700
Message-ID: <xmqq4itkkaym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> So I think in this case, the CodingGuidelines would suggest that we
> write this as:
>
>     for (p = store->packs; p; p = p->next) {
>         if (p->do_not_close)
>             BUG("want to close pack marked 'do-not-close'");
>         else
>             close_pack(p);
>     }
>
> , which from our discussion here seems like something that we both find
> more readable than the original.

Yes.  Technically the "if...else..." is still a single statement, so
a rule like "do not use {} only if you would place a single
statement in it", though.

I would actually write it more like this, though.

     for (p = store->packs; p; p = p->next) {
         if (p->do_not_close)
             BUG("want to close pack marked 'do-not-close'");

         close_pack(p);
     }

The first two lines in that block is a glorified assert(), and
without a programming bug, what the loop wants to do is only to call
close_pack() on eacn and every pack on the list.  Not using "else"
conveys that much clearer.
