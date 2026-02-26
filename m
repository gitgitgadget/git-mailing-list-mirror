Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E16355F28
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127559; cv=none; b=B23I7lm0dCoflXG062J18bh+G9NHvU+73IP3UArDRIFpxUeOQKUD4XZRM5HCJSbWRQLsj/WTxqz1/4ChsgxUuWwgFGTGlnbXCizj62JZtuMbDwCmW3O/g79BHoyhtbaKaGstCfmsquM3Y7uLLWAqEIGfEyTj1WRnDgB2jzKaZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127559; c=relaxed/simple;
	bh=KvFlc1144eu94GEVw6BdG6jUDnNbi0ng+2Sy5sWJabE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUY332Q04YQA1UGcp1OGGuOv3nHGtIGWVnSPdKvhr8M3yTr4CA6YOUFyFvPQsWtEQBK4VAeD/BIj+TwyNkOqDSqqJfqHrkUA9wfML5BTXDsKVbr8eh8Fd2bN4JfFsPLggiQCDCNKFRcrV3acZAjZxoWrgEWCW6bMNLf0jJCQrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m3s+OxrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pmd5jvMf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m3s+OxrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pmd5jvMf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C762EC09EA;
	Thu, 26 Feb 2026 12:39:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Feb 2026 12:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772127557; x=1772213957; bh=eTIW/U4pPJ
	343xbrs2sBtIOzswgRBSYdp/wHQDfy87s=; b=m3s+OxrTvx2Pfe3QhMyEqBxaqw
	UluYYbfIFhvzI3tiPm6f6AVYtYpjgMDCHgdxcoQTd+znC9lVvG8JLh3HZoUi3I6j
	Ln28Mkw8y1lZaxKcDVoi6+RsTeWBm48XBWUbYoWEEMIm2pZJ5DMqC6I8HVI5tJio
	G9tdUDqN8GLK4QCN3GFGuowOGxnCenlDJBC5rMaj/DCv84ta4dp4/CnpaOaG0gus
	HqMOV7LTzzwNhn7lGiHDuYFhH3yvlea8eG9TBMbPgP3jniWkwkUYnLBDmvThasOG
	Y5XQHjHMfjobUPYHvvUvSH33m5E3E8vGq8hHiF4ALrkG+0gdP2mNxRDGadow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772127557; x=1772213957; bh=eTIW/U4pPJ343xbrs2sBtIOzswgRBSYdp/w
	HQDfy87s=; b=Pmd5jvMf+gaPjz4MY4lfM47/51zq9pYMnr1Wbh9ROXTiGI2bTKj
	jPZiGsIpWuJaZz7tVf4NPvpsI0jV2fj1tDnX43seGhh1DDchPcWaXM/1s/ioITMQ
	+XRoKqvpulIfv41WppNBv3/76vkiZhnhxjMNfkYM9YPINfSoAPHuxL2n/TU3XDrQ
	fkJdpkpVLonjBV8Eu79N8rAufdjsJU/LcbMY8OLmv0sycM5BUWI7st0PIK9pGHRb
	dPAfH7mH5Z/kSkLbIDta1ktcNAq1/LzL89H7MLB7G5/UuULG21F9WkFv5/S2yQTq
	Xdra8ye2iJkoDj0i1xdFm6T5HOxhgAgGShg==
X-ME-Sender: <xms:RYWgacfGU2G75uGSfcmMQL3SMBIXDfubTkL5tOANIuzPAD4NypFiDg>
    <xme:RYWgaVFT46Ggp29rwwJAsgCKa8P7_ME7Ek0OGwzMjYQpICuXSHVl1zK3UFi1XXTmh
    akfRozVkQaJY6kVlcuAHSM5EzvdLzQNi0YQikQXjg7hwirUW43wzn8>
X-ME-Received: <xmr:RYWgaV3SY9pkLU08-dtMskGwF154yziB0_KBx-4g6sihx1rTFmmW6Kh45sXju-0XnPx4utt-bR0pJuJzBOl4fSKZv3NsjO2ewA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RYWgadlJ3cQvws--m0bmQDKO6-mxUyNucpk5vmnHZTvcBLcNvrKlKQ>
    <xmx:RYWgaV8ksxkezf_pTwEyYPu2bKYdMlEoSCJyooaDJ3v-SrQnRzlhMQ>
    <xmx:RYWgaSowhNGEZQCYUu3ed954oAxC3ugM1ujpLIbDHPbkp9VjyUcyGA>
    <xmx:RYWgaemFfyHlAPx_Zu3KgYED8d4M4CTjMzag59rlw5ZNtIsk9TV25Q>
    <xmx:RYWgaU0VULoGgKmN1vgWF0RxnqTUfP3iSYPbeKskm61oXC_bhszgcRxd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 12:39:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v4 0/4] Fix misuse of `refs_for_each_ref_in()`
In-Reply-To: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Feb 2026 08:57:48 +0100")
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
	<20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
Date: Thu, 26 Feb 2026 09:39:15 -0800
Message-ID: <xmqqwlzz2ym4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v4:
>   - Fix a typo in the documentation.
>   - Link to v3: https://lore.kernel.org/r/20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im
>
> Changes in v3:
>   - Switch the approach to perform ref hierarchy matches instead, which
>     is in line with the changes in 10e8a9352b (refs.c: stop matching
>     non-directory prefixes in exclude patterns, 2025-03-06).
>   - Link to v2: https://lore.kernel.org/r/20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im

This round saws no activities, but I just re-read all and found them
quite nice.  Let's mark it for 'next'.

Thanks.

