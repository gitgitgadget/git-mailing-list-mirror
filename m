Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD3199924
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325529; cv=none; b=I9cuR4fut3DirWlIJDkMsZl54FdLskMdd5+7ltdI4JS2hSIzTCsPxsT7C4mULyueXiImlkafhOoQzltNboonoTOYveK/HuVVitHwaGnOcTSJrD2hheJlzifFighBRlvSEbCMEubELtKajiZeKvZYWETg9kYP56tzDJ+QSSolcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325529; c=relaxed/simple;
	bh=tRpcvOAZzzoPnqCnsQLvLvrNI3Up3GfGRVfrA2JPWlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKu6m4+M3+5DhQDllUV/PPwF84iqVtmwM2J9KZ04Bjfs1nRnHJ3vxdp/L9S9i6fVT0r5o+C3CsrsRclsF3ZQ+EjvXiNkfi1ZaaDyGIzk3XTFpOk7IHFULrew8JT7wJ/ZmIIoxTSoqg0v3j8slbcjj2S//zawj1YxtHu++RpRdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N2TCESnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5+Zf4xiW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N2TCESnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5+Zf4xiW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EF9311401BA;
	Tue, 18 Mar 2025 15:18:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 18 Mar 2025 15:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742325524; x=1742411924; bh=9aQcghvL2F
	wuH/b9jX61fFHEERBS5e11D5SMoU1DjPg=; b=N2TCESnfCGHt/FuCALOmZ9R1g3
	iFHbrYvBKabplfZoxcYBkgKykEW/ruRjeWSiWFRB9C4sn0NKaZujGksxeOPL42UM
	lc9gl4uBNjz2dE/vgfCMbwWZvsywlR6ch+sV26IXYqy2BJIjLBADK5AjxrcgwCS/
	PhC6Cbu7OzNUCPljYMFuhQOxMasdk9mc37XIt+Aozo65acHnJjkruSqy3L5S5ibE
	QPpYWTF5WXDBmMuBlJL5jAyzYpgByO4w15anjHgKjdhHUwknM+HeAbEyOPN8G+dV
	CYVBzA0HWRVrABldUfXAN4tTPXTlcbtIJ5jqKdYeliqhvb7hhxr5o61H6Tvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742325524; x=1742411924; bh=9aQcghvL2FwuH/b9jX61fFHEERBS5e11D5S
	MoU1DjPg=; b=5+Zf4xiWgNmcsz/ifqdoKlEOJrz2N1wkX/FaFUEbsxaKaFrQ/D5
	ujyO0YVvHw5pLcTPnPPXOxfMvnd2u+ewx61DTA35VwanQ0afZK1lhrtS3hEEV4T5
	rzlj+vZu/aUKhYIgtKVhkbGDmp9xMXEtELILMe95q2U+vCLJ1guQxOqehU2WlOeW
	2UP/wk9a+WxAB2PAD9wMHUAOwpYjaRLMR7iY4n8Q6dI3tMnElkIpypMKV5bGUOXq
	59PMioddURV1NE7pMrR3mnbOJr04lrSM5Y+XVamwh1Sg3Vs4xlXT8xswPI1x0cPX
	D+4Fj7bnJRUv6hBaZ0Q8aGq+Pzk09yrPtZA==
X-ME-Sender: <xms:E8fZZ6uZSP1-Hw2sV5AQoi49XvABqNR02EtxlIz1Ot894J6UbYZSWw>
    <xme:E8fZZ_crk01Gj3zJjVhShaiA7gqhnISBdwMkPwdhbCUn4Kf3ZUmYoLY254LZZXfbB
    s73dXsBbtkJl7p6yg>
X-ME-Received: <xmr:E8fZZ1z6PfKa8CbFqGyrcJDLMdp2xyP2jVdtbTSrXy175bK3L72svnXywWjLWbYzff5CKre_c1oqR3MGDFKRTrG5UYIPt5Wu9almk1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E8fZZ1OtBa0yrSwlqomyqqpgtODYj7ZVpY_WEA2M6lPHI_Ik-ykQIQ>
    <xmx:E8fZZ68i68OXXGD1XR1DEl76_NdwFfRsXvJVWnQ2ohARnRvnAc9upg>
    <xmx:E8fZZ9WageiTRF96hnY6uJyWzchz1bPGVZZVH-h4eToR6NizNKubgw>
    <xmx:E8fZZzfcQ1W_ARi9j3TzYAkl-uesKNuMsGPbN-MEFIsKNEsyxV4KYQ>
    <xmx:FMfZZ6y_i02QW5Pq3vroDUhDlxG2VKcB3otB8XDnwrA-rUeAVZJTm6uz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 15:18:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 0/2] limiting followRemoteHEAD being used
In-Reply-To: <20250318053905.GA2051217@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 18 Mar 2025 01:39:05 -0400")
References: <20250309030101.GA2334064@coredump.intra.peff.net>
	<20250309032016.GH2334191@coredump.intra.peff.net>
	<xmqq4izxq63y.fsf@gitster.g>
	<20250317180604.GB704553@coredump.intra.peff.net>
	<xmqq1puva3cu.fsf@gitster.g>
	<20250318053905.GA2051217@coredump.intra.peff.net>
Date: Tue, 18 Mar 2025 12:18:41 -0700
Message-ID: <xmqqmsdi2lm6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> There is one interesting case we haven't discussed. What should:
>
>   git fetch origin HEAD
>
> do with respect to refs/remotes/origin/HEAD? Right now it does nothing
> (at least with the v2 protocol). We ask about HEAD, but since we didn't
> fetch the matching ref, set_head() won't accept it. And after my
> patches, we would not even try to call set_head() at all (since we are
> not using the full refspecs).
>
> But it's also something I could see somebody doing to try to update
> refs/remotes/origin/HEAD. I've left it alone for now, since my series
> does not change the behavior either way. But it might be something we
> could do on top (though it gets funny, because with the code as it is
> now, we'd have to ask for all of refs/heads/ to see the pointed-to
> branch advertised).

With v2 protocol, we have direct knowledge of where their HEAD
points at (when we ask for it), so we shouldn't even have to know
about what they have under "refs/heads/".  I do not think it is
within our contract that we'd somehow make sure that HEAD in a
remote-tracking hierarchy is not dangling, or something.

In any case, I agree that it is sensible to leave it out of these
changes for now.

Thanks.
