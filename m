Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73441331ED0
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829382; cv=none; b=gCZ8QmteC0Qh3TtJEFM67t0cDigWwTZDfcz6Kf0JE0tWtFpuUXXCo8Svpy4QoKEqgmTdxpnh2FmEc4VtTxv6drcHc63v4IjNVoJzeLuNbyfpSlVX7eSkTBn6ci5KpllGYpYzNByYe68p1sXxlZsWtPaYsA8qjQ8UncgbQGkGhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829382; c=relaxed/simple;
	bh=PXLRl3q1G+8+7lsjyqBrlJAq7iidbgolKg0dZWgSBig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLhU28amIxupbgC1XAEumPfsvMenvFeik30EGniP1lztkLmYlnoxqVJFrsE02oZS3C/gMfF8NZlTvXWW4uYjB8I9wqaNta8wc43af2/XImVVAg4sgFUxf+KR/pLnbMXILKRk6a4IlKi0JKe3DTi3mhLyBBiy0akTm2iI5araWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CG5nKmWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZSa+NI1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CG5nKmWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZSa+NI1"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CFC27A0126;
	Thu, 18 Jun 2026 20:36:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 18 Jun 2026 20:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781829380; x=1781915780; bh=f9yJsmkh+6
	IT07pwdpGfUQw1K7C5gz0/D9DSVHLd2hA=; b=CG5nKmWyY98fxR0JSIbyrNcwbZ
	2rcEDwlDUVZ6FG9Pp//4bH+36xtdjZwJ7aY5SIsYbrRMx/uk4BeHtSwIDjbNHIOA
	tAuCkLuKp4kJRbuaG3lVZ8bunG2zfTCRlD8Ad6PXHNQc01ufSePubTCUmMgDypur
	qBS/X9B2lyI3/2zk/XY4qVnZnj/jKOXoZY3wWGRjQ8NyGC84ymReySR7xiPDFqjO
	4ONBjKl2reB2rPPOZfjsnnwbnvtNXo8dQ2wGxIwNg6vtfquxAyqmGOOjCYGvELiX
	KTy5bzkqwHi9Y0+LKsHgRDhZCNyWqrGub6pyfqDDq0ZPNyMUUoJLJJxjLeZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781829380; x=1781915780; bh=f9yJsmkh+6IT07pwdpGfUQw1K7C5gz0/D9D
	SVHLd2hA=; b=CZSa+NI1Dlb0SO4PQWvBQPUTk4UGbXIGQUZJg8XMmCs4+y1wY0w
	VshSmkp+TFfqkW1P9mEKP5KBF/fm5OWshukGNhfXklNXo0YV18iE8Ry5+Y6Du5ZS
	nCCjwl2Woj/M2mGxJfDZBsazOcrB/InnIGACDvPuymavSw372N96UIIYC3vS6vrp
	kTTukX5wbP2mv0xtU81zmbbbcGrATcfW7P1dORDNRkkqi50HW5yAf9x4YlDkF3kh
	Dzdwa1yHKdwF3bh1NYTHPvvnwcXkO/iPwIKdtAltcmiDpeJz/5XK5+/Ap3OAKDyi
	OEgJ0vmR1Fm3WK4C4ezk19nRHAhg7UsxvRQ==
X-ME-Sender: <xms:BI80aojcESY6VH6m5fgorg86oy71NRY1ZmNIEMsnOdYgkNsmOXhkHw>
    <xme:BI80aktXjnYfzZEmMBHT0sqBQIbzZ00utroRveyaPGtxdRCxwB5YRNVoA50s6ZQaN
    9iKbdLRmxy7dfBMtdo_g_N9tCEPG-hIuu6TMNssRt9Gb1pfN2ke3A>
X-ME-Received: <xmr:BI80ap7n7yibySviduShUrJRCrhp4Yv_zI70lrJbKAlCYK9yRG2IhKuHfipMFNfc9ulpzbCCRE_dso3s9VufC0Ln76T0Cfp8yi-q>
X-ME-Proxy-Cause: dmFkZTEKwz7qMWxGjoF9H2IMGPzgGzvmpVJKYtgiRD30ISXyV0ib5gXuvl6/DSzNoO7Alf
    uowF4t7MEI8pYMsNRooJ+FzCiXNuzRxuXKbtMYCl7kGBvkS57hHQizbBwcMTH6SZ8jMIBQ
    2SVoV0U4A4TU5Vf00BmgE8drfTBR5mCV0acU9O6VZLlaHx3TEBte2isI7cOgGhzc/lgzz0
    7Ooz78CMBHFLEvW2jtKk0irqWuIUraPHbsQOiO99n5RkJzasAFV96UgC6JwNbjYlm21LU1
    VHRe4rLXmZtPWKZiz7otxnHArn57nFdP+Yv/jfr1Wuu7ygVV85ulNyPWlD9012/9WtZBVk
    oeXLZpS+wlwtSk3k3TQFAKzcZWnIGbsJsCeFhSJaDnjEWgS1b/CoAevZXhS+LbEWAEzO24
    fU7nKed+9yQIDMj4kMivuRAQkK3w878OYSHwltfaHm+aesu67obEOzkeBo1AxmefwZeHTQ
    +f3Se02+BumHeOM4Fs15dTeaOgg+U0O5x7WOtq4tF1gNPmOfcd0lvjvpbTdGZown00MJEu
    P0FavyTkIwQ6xYVkIDfrDRBnt+zhyo4alEua6Ej+DNmX4tvJ4p16WJWLj8CqeSIyXosk+l
    wd9DLBjxFQuNuw1mwV8mw2YtGu3km3YUWJQfc2rV6SBCQ59mWCGjQQ+ZlGKQ
X-ME-Proxy: <xmx:BI80agMC02XiMEkjRwNxpKmlsZL3Lbkop3jffyv9nRJIbyCr-bSyBw>
    <xmx:BI80antc4MlVIGte0y3rKaQFblEEwe_BWPI97UfBaROGMQZn50YmJw>
    <xmx:BI80ajYBMgKlBifaoK3F7nJ1OnHWcJPi1STMhaw_aIaP88ir-QP2og>
    <xmx:BI80apx-MdwsY7CAWoK8G4mYqe3SDtzzzQ02zvP13dUD-bX7fPu_ig>
    <xmx:BI80amFIsThAiYtxvqc86XJM-QmNmLLDcNKije6HLelgTIVJmCIcJ1CY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 20:36:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Todd Zullinger <tmz@pobox.com>,
  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: git-2.55.0-rc1 t4216 broken TAP failures on non-x86 arch
In-Reply-To: <20260618233536.GA1431359@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 18 Jun 2026 19:35:36 -0400")
References: <20260617220330.n6byiFQr@teonanacatl.net>
	<ajOP1IOjA3EYvRfm@pks.im> <xmqq4iizpkig.fsf@gitster.g>
	<20260618233536.GA1431359@coredump.intra.peff.net>
Date: Thu, 18 Jun 2026 17:36:18 -0700
Message-ID: <xmqqeci3nz7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... But since 389c83025d (t:
> let prove fail when parsing invalid TAP output, 2026-06-04) it will
> cause a test failure.

Thanks.  That was the piece I was missing.
