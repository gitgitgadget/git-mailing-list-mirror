Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810E42048
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970878; cv=none; b=JismXcU2TXLf5S0OJFuTc7iptTkO1JAqiJdEg+gxKhwTjB9QG0lqmYhRd0eKNoa0M47+WvmXDU/dMh6CDehSb7goVhRzX1qhMO7JyirNnobXVfyXNB5lVgj1tzQjBeWrjetW1iXR366TMXopxPMlCs1nd92x8iPBxvpyZmew70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970878; c=relaxed/simple;
	bh=SnU9k8hxpl3+zwljnqJ0kyFavdYbNnfZhlsgvzf6Ods=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VnQBRxSxzNA1e/1L2tHFcUS/1JiLYdyk0Sk9fDBlDXUMjiuaYyALEfp5JHy4DsZCZszZaUvrDsdp34rC7y+6pXNnC7Y+zayV3tWP9boQs4Lzi0GOIM1Bk0Kz4ohbjWWTCiO2tnUu1dRALP6GWizSDTvz+ei7wjjKCA8Txqc+8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L345GfhB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RB923SJH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L345GfhB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RB923SJH"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 527E8EC0136;
	Tue, 31 Mar 2026 11:27:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 31 Mar 2026 11:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774970876; x=1775057276; bh=9ckRCYpI4p
	KFFtES7igK+p6OHBr4PGP3FAQmKEwrWBM=; b=L345GfhBC/JZObQUeKwm+qC7AO
	+ZOjN3xg6+jwqqk+7YsxcT09alRxUou1oTzRGkgQI308p3brMzOZun5dCcosozib
	olJkoG/PjztWKTK0ub41/kCtb1ykglziRKi+rrIrHKM/6y584RPFTdMCQn+sJSAr
	iAtsCLxXMlhKsJb1t3UCx/I4yCwXpTnKU1Q891Hikle3V9BbtQuA8yJKuCL4V4tY
	pDPfLMUgsVDoxLr+4WO6DwTw46rSGxjopl9re/ZrOJqt/oHGl0b0t0tTtKCzD1uA
	iQEIm/M0yjyHT0ixJqHrD0gt/IiGPN4huCY3TxhIrHHLNKtaXS7dXgwEO2cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774970876; x=1775057276; bh=9ckRCYpI4pKFFtES7igK+p6OHBr4PGP3FAQ
	mKEwrWBM=; b=RB923SJHU0C3kWP4aJ6itXvi3bgSnz0V/X6SEwEWDQmsmX543MV
	ry1qfC53IeYO3EYN8DUofyDwF9sbypbFX9/rDWDcn1ZtYl/eT9IcYXFpMdsV27j8
	TID/2pzkjtG06hlp9zHmPTKG6DBLWFMKBIPKWlmnwrE6K4jhedW5sFPDMRQ1YxP7
	IZDMeI6gxpiIQlvAx5GxVE/cjxPFZEIPFdOLz7oLdWhGwoonU+d9pNQzADKHNEjX
	BKltrzNH5zG6j9W26IUxLl8u1Qlq6Ii9VDlnhcfc7s9bGN9WaeQO4dbQXIJbJvq4
	iden8Fnx/p5FVaOkuMpI8H/M6juZ3jAEIZg==
X-ME-Sender: <xms:_OfLacfqq2DcHwXVzNVCl9bttQgAiJbg1hpexJgHA4ZaS_INU9jVOw>
    <xme:_OfLaVq4Z1GMDwCF4-6XYGxxVCIyjOKKjwTMbGyrQpaSU3FND-Vss_cQ5UWOnNzH4
    u1UfvJfgo5-kvXmnyRm9z5rhJ7fjZJEvPHmb2MDjZAFXtxlyLr-Iw>
X-ME-Received: <xmr:_OfLaa5iQAy5RXkrwSAziyZRjX_MKcSUX_lkqtTs7RRzTI54RE5qahwEMAXROCuj5XR_ka8cpOVGlMM02WGpJ-KmBEYjkiSRrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:_OfLabrbRNXkLLJOCXJFtQD_JMAclKCG1fIJDOHW-HpX5CqIN6bzqA>
    <xmx:_OfLacgllPGJUuP3dbIJoyyB8GQthNXFdHZOuPnv8JMAtxzuBwws5w>
    <xmx:_OfLaVJH90QbfLmpPHHLVKrP27GT6zlfvBRqjylTIw-JhSCghXKH-g>
    <xmx:_OfLacATyNCrAeb2l-DoVfZSj-VI1esA_m2k7cvy_uumkHEDJ7a1Bg>
    <xmx:_OfLaVxbOHMljm2stp6SYzC7jJzRb5jF0cYoN9zbZ7blvnVcmDNJtLQ7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 11:27:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #12)
In-Reply-To: <actaFN8ds0cfgWxI@pks.im> (Patrick Steinhardt's message of "Tue,
	31 Mar 2026 07:22:28 +0200")
References: <xmqqcy0k6epp.fsf@gitster.g> <actaFN8ds0cfgWxI@pks.im>
Date: Tue, 31 Mar 2026 08:27:54 -0700
Message-ID: <xmqq341g3tol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Mar 30, 2026 at 05:10:42PM -0700, Junio C Hamano wrote:
>> * ps/commit-graph-overflow-fix (2026-03-23) 1 commit
>>  - commit-graph: fix writing generations with dates exceeding 34 bits
>> 
>>  Fix a regression in writing the commit-graph where commits with dates
>>  exceeding 34 bits (beyond year 2514) could cause an underflow and
>>  crash Git during the generation data overflow chunk writing.
>> 
>>  Waiting for review response.
>>  cf. <xmqq1ph92pzs.fsf@gitster.g>
>>  source: <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
>
> Shall this also be marked as "Will merge to next" based on our last
> discussion at [1]? I mostly want to ensure this is part of rc0 so that
> the regression isn't part of any tagged release, even if it's just a
> release candidate.

Even though I still feel uncomfortable hurrying to merge down an
obviously UB code, instead of an uglier but far safer conditional
compilation, patching it on top is trivial, so let's mark it for
'next'.  Thanks for spotting.
