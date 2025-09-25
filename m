Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3613635E
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827875; cv=none; b=ha0JVbK43A2MJcI97meKM4FZvJnQacsEKYuk3z34IRc7grpbJ6AKd3xhBaZ1rd8ScaQu5I2jmlA89WG9mo+x1ONVI9g8klRvoJMgqKq0wKv5J1mglKRYwoPUCSQ4UOGPuAlsJMOyKUBQGi3CgMI9rI2GTI2m8pKHYM9RpFnIVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827875; c=relaxed/simple;
	bh=sQkMcs2kbryWhMVmUBZeOiZ7kfZ0me1PjlMjL1BvSIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUvSVQ1zCqcsP7gzpvr8hzyBGIJT8RzoD5YpCzlN56qO6cUcqcWHE51Oq4Emo9gZp1eLkCmIRipptA5sTH924/ZkWDN9flpLn2Dk/lE2FlhKrzkfrXDgUDu+khBAeAuVh/CQRsqj3MlC6Qm1jXpcnyQkF2O0e70VAIQ8U9d0Oak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ARx+whhR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U49RFKLT; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ARx+whhR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U49RFKLT"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FC751400053;
	Thu, 25 Sep 2025 15:17:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 25 Sep 2025 15:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758827872; x=1758914272; bh=CRdLTBH4Ci
	EmOP1NfC4kTsrbu+mSx0tYxgqzYsJrRXQ=; b=ARx+whhRt2A5pYzyhWzqhvBMbd
	013BVHp8hTcotcZaDzajEuOcFOJsMaTqpn28QFtLAxizAyxRuj+naDgmLrpgTu1N
	+ccbLxV+szw/CpMGlsyxndIRvhX0DS0+PqhGMcbqFFlRXQ58PuFGP/d83ShlPnnt
	BQY77SBQjVKVTTI7P+nekw7Cbm7hfxTarNzD5e+zDn6/s4C4uSxz/MKPjlVTvNnt
	WlYaOxZTS8Zpkpwio8nFqQcErMZjkYnsFhBIV2sLMUSs8iiFF1mgqpIx/pN/o1xN
	ouUFSI7VaXRNkfFaB9xsnpBEJp+h5hRl4TzpwOtRltTwY2IZBRjDY3N/8M6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758827872; x=1758914272; bh=CRdLTBH4CiEmOP1NfC4kTsrbu+mSx0tYxgq
	zYsJrRXQ=; b=U49RFKLTRHyn+qOrpluZskp5JWfCUUpk3MefW91AjasZ8xRVcNl
	0z9vubUFHZCjSbtrGMtYHaw/iNzN4x8GE6/WVrNaMF0S7fbay6ATnxNQhkctzNq7
	g4cwJ0KWa3/d9pd4JzaqBwG28fn2GW/Lhk8VRjtwLTT3cVuFY7Oy8jvaKoRlR4v4
	HLOUFDVJQGhUtdW9bX+7MpQlNnSrRLhGqDcPHknTPMnP3xLQs04hjB8fj2MAIdfe
	IB51ED9Y0pdRMQ63nG9I6VqtnEHnuXoQvbmu3VuE0a7VRjAnQ2Qrub+BSuOCq+WM
	M24dDH6e7Nx9tY3ZwFBX6CVQxDoR/5hBrAw==
X-ME-Sender: <xms:X5XVaAG2qFVCh7ZRtGG2_RhUM1hMcQu-0X8-0fEBjyx-RJjGf0FGBw>
    <xme:X5XVaANLc86bSSYA48jwGOLIdW8VJiTR40eGAcSDOMHkKpmfkpTGw15trzylueKQq
    e1PT1CN6n-r-EtyN54E6BlR8Q7hqSLnySI2mjhBUWwGlNv5dLQu>
X-ME-Received: <xmr:X5XVaCc1UuCPZczP77Ax4yQYA7GaWHsAzIMlnuf6eO9AOp1a4wUZxfFskPdbRZVAN6Znj8icraJpaKVDhUQSwbxsleGGruW5zktF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YJXVaNvVVrYcC_eKhpDRMUSlg_eNhEWsvTSHCFxLZ1uB1cy8Q2n1MQ>
    <xmx:YJXVaDmNFewSNphrhc4lnY04TieubCWFT17UO0olV3G9vI0ldOs5ZA>
    <xmx:YJXVaPywloQX0U3HUb-pxSbqbCekodjwEGeTFuXKM6uZ3fSLiomEiw>
    <xmx:YJXVaFMLtd317BD8oK3F9F9xVk_cQA7hyxuIgIEAq0uhNofqVepPbQ>
    <xmx:YJXVaEFph5r2l0mE8XMa_O-eGOitmJKUGhCOTsuU_-nMcU7BS_XHJ1Ur>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 15:17:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,
    Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
In-Reply-To: <aMFjGoPhGsRCTihO@pks.im> (Patrick Steinhardt's message of "Wed,
	10 Sep 2025 13:38:02 +0200")
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
	<xmqq5xdx7qx4.fsf@gitster.g>
	<cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
	<aL67U0-tw7O-y6_X@pks.im>
	<4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
	<aMFjGoPhGsRCTihO@pks.im>
Date: Thu, 25 Sep 2025 12:17:50 -0700
Message-ID: <xmqqo6qyfijl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There is no inherent reason why a new backend would not be able to use
> the existing commit-graph infrastructure indeed. But there are reasons
> that specific backends may not want to do so. If objects are already
> stored in a database table, then it may make way more sense to store
> additional metadata that is currently stored in the commit-graph in a
> secondary database table instead of in the commit graph.
> ...
> This is roughly what I have in my head right now. And I realize that
> this information really should be sitting in a design document. I'm
> working on that, but still need to land two more patch series before I
> want to send such a patch series to the list.

So is everybody happy with this line of thought that makes it
mandatory for each backend to decide and implement the commit-graph
support if they want to?

My reading of the later part of Taylor's message[*] tells me that at
least Taylor does not agree with that position, and I am not sure
about this design choice, either.  Surely, each backend can have its
own optimization, but looking at the way data from the commit-graph
and other auxiliary data files are used to optimize real operations
(like populating the essential fields of the commit object first
from the graph, only to read other things lazily from the object
database, or switching to completely different traversal machinery
when reachability bitmap is available), we cannot say that each
backend can store whatever side data they please and leave it at
that.  The code paths that are supposed to be generic need to be
aware of these side data used for optimization to some degree, so
conceptually it is much cleaner (well, at least to my eyes, that is)
to declare that the auxiliary data files like commit-graph and
reachability bitmaps are defined on the objects in the repository,
no matter what backend is used to store them.




[Reference]

 * https://lore.kernel.org/git/aMNWgD4wKa1a5R8g@nand.local/ 
