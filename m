Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B04320CC0
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261679; cv=none; b=onXntNiikI4wHC/HrI1uzTwWXiMV5UUHD2s1uRDY6cv2AGFMpGRcEjw5Ga3GDBZqUV9u7TotsDlkupYccyjC0RoF1lAKrlim26tI7fCUA4saG/zH/pMyTHhIvehQyfuA2O0lxjwFuEWzWBXhexyQGNg20l1GXQb2SvA4ibz7XfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261679; c=relaxed/simple;
	bh=wsAkLdnmfLcobX1Br495NbQzoTn1H9k58UIzB2LYVl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdfI2RCRbEnvJdrb9u1bDWSpz7Sc/H2vNfzp9c8aIIwuZV+1T+o8zzGg3P9fyid5Ld6JILtb6V03/dLkKpAnmvQY+haeFtARWXIO95BZQfGHQtPKMfCt05gTkgoL/SejwT4cDO74QXxsoTbBP+vZso3W2EayCa1v98d8WKNp4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PgtBArzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w7tN5kGh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PgtBArzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w7tN5kGh"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7F1314001D0;
	Tue,  9 Dec 2025 01:27:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 09 Dec 2025 01:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765261675; x=1765348075; bh=buFsE16zeU
	Wya7D7hdWBzaSQyHLhc4a1bqil90VS02s=; b=PgtBArzEcXPJDoZdNHUO5QgoGj
	1cuILroQ31nAVLcPrRUSLdtNYg8luA/4OY2P3e7/hi4EqFNSRD7W9H6qKppFANMo
	MmFhxWKl3Jlro4KGIx67LLxTxp5F/HZ3BysRGwtPdhxHuwDUvPjbwsISn34/c5zp
	lbHuNmXj+in0dV6kQi44f9au5zkfLqaDEcZRLotSNXZeE2YEXLGMzTQAvjQFBDYe
	EpEO/+qG2s/sCCiOQhbR+3ibmCqFo++d8O9kQ14PNj2Ee/KxfabmZefmI70k/v/k
	uof2qZXWSKcvQmZlj6sH3C5NDsqHmh+eamrCP28LHK+svsBXrujByH2K0AjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765261675; x=1765348075; bh=buFsE16zeUWya7D7hdWBzaSQyHLhc4a1bqi
	l90VS02s=; b=w7tN5kGhN+U37f9kOhOLQs4/ju9OpbeJ4bsrfINj7WlG8ku1xJJ
	deQtwVZNkl38UAdSpVG7+rurs+Mjz/+XxL8d7CAM6VXw21uh9ti+2qNUFYdgiHU5
	v64D6tz+3sLSdKW6nhvJK8gxsnHbVwF/Yw5hQb5gPvEBlCpjjiVLW3EwL6/vhdvI
	jOAw6RccWF9ipY6ACDPKVSoEVDNk6f9Gi7McQSI4kdXarRAk/KGpgiKMVg/PhrTR
	XPpAgD953G2rOQsZ76PcD+ZaAraxa8ROlDBVWAyhep1aQg1PxQbtaS8ldJB9sYl6
	PjgDWdINV5Qx71OspjXI54tvbodCWl6h11w==
X-ME-Sender: <xms:a8E3aWMrZ_5SKtW9wMU7azJUqy9ditw3TKwnAQAOw1JoxIXUfysKEw>
    <xme:a8E3aQf-Pn-hPiuB5eyGeA4yAuFL7sRFnCXBUIni2EZX57H2lXLVvQNjN0eaVJpqH
    w3yWAxXhuqUDf9Tia5vpFnDJC1rt4JpzYyWpw20pWzB3vZLSinY2g>
X-ME-Received: <xmr:a8E3aTudIYxxbVmxxyHjjgyYomcdALGTBm0fI9TS0TV2GMOO0dIwmm1h77RDWRXleEA_3TZViu4rDLE1KbW7a5vww7hJQIqh_J_RmMVq4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:a8E3aRmxDC_KXun1MmOUSr2m8M_IrH8Nym6okVa1GPJy5rzHoVUDyA>
    <xmx:a8E3aVw3jGRTlki_DfirB5xxs8BxCPiILlGSbeb8vZ_NPtC_RwoOPw>
    <xmx:a8E3aTOCefABTth_yAihyQnuEvNRnVbdsdNFqJcj06hnji7tgaToYg>
    <xmx:a8E3aRqDK8fGY9xbWhkc2rXovH1_p3Jffv2GdkKmCo8RKBnLAxKP0g>
    <xmx:a8E3aUz1BSITUbkldyUTrBKrlxafMtF_nsc66U2Q0CyxihrV31Xz5dgN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 01:27:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 110b7a17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 06:27:52 +0000 (UTC)
Date: Tue, 9 Dec 2025 07:27:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] midx: split `get_midx_checksum()` by adding
 `get_midx_hash()`
Message-ID: <aTfBZVo6Hq8Nf7uW@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d583a169f08eea9d750622c6e3cf79774a2a68e7.1765053054.git.me@ttaylorr.com>
 <aTcYAdJ6lNCST7PT@pks.im>
 <aTd+fxpflcLuJXDn@nand.local>
 <aTeAUKrB89RM9p+i@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTeAUKrB89RM9p+i@nand.local>

On Mon, Dec 08, 2025 at 08:50:08PM -0500, Taylor Blau wrote:
> On Mon, Dec 08, 2025 at 08:42:23PM -0500, Taylor Blau wrote:
> > On Mon, Dec 08, 2025 at 07:25:05PM +0100, Patrick Steinhardt wrote:
> > > If I didn't have the context of this patch series I would be wondering
> > > what the actual difference between `get_midx_checksum()` and
> > > `get_midx_hash()` is. The way the functions are named seems to rather
> > > indicate that we talk about two different kinds of hashes, rather than
> > > two different ways to encode them.
> > >
> > > Would it maybe be preferable to call them `get_midx_checksum()` and
> > > `get_midx_checksum_hex()`? While at it, we could go even further and
> > > rename them to `midx_get_checksum()` and `midx_get_checksum_hex()` to
> > > conform to our modern best practices.
> >
> > Yeah, I think those are both reasonable suggestions; I'll apply those
> > locally, thanks!
> 
> Hmm. Upon further thinking, I wonder which function should be named
> which.
> 
> I think the _checksum() variant suggests that it returns the non-hex
> encoded form, while the _hex() variant suggests the opposite.
> Unfortunately, the latter is both more commonly used and more characters
> to type ;-).
> 
> I wonder if there are shorter names available. Perhaps
> midx_get_checksum() and midx_get_checksum_raw()?

It's only four more characters to type the `_hex()` variant, and it is
in line with the interfaces we've got in "hex.h". So personally I'd
still prefer to go with `_hex()`.

Patrick
