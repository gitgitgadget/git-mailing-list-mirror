Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B7296BD7
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351654; cv=none; b=aftJCZs+6sXu0k1FKqE4zjKqgwkKdoelxz8BNYjAsCKhqQjwRKkX8vaG1JRKFzyMDuthaxnAWBKcN4fYJTryIEjikzb7RaeivjUXCQGTQfL1OF8k1tAyx4dOCuSMoHyHWNAWFgSnRVCCSM4hinvh0HuMRN2qzyVtbrkqIObwFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351654; c=relaxed/simple;
	bh=qZXsNJqE0s3zx6eU0x+fDwZJbaQYS53diFdOclGPM+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DKYii4lojob0C5Dq/U7VqcCV8QEjY69izEFCBfbpX8FmTBR70HNnFwrJrW9gopJvSaCVhtMSoGpanPuLh/gA76DvF02cZZEJpsU6QImSZ9sleWv308S41j8u39eoMOT9t+zcUC2I7yJuffCe0fKEybuA6fHVY52Y6LWQySEYI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KMuIGqqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LLfysUCT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KMuIGqqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLfysUCT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C284A1D00157;
	Tue, 17 Feb 2026 13:07:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 13:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771351651; x=1771438051; bh=XpS4ICVFH/
	2+Y0L6bJwxkSVWe1izeZaGeqWCB1KLpk4=; b=KMuIGqqTtg1Ym8HblukznAVKY1
	ZwS8MzBljhzwu107dzfkdqsux46UHSLF0fRK1kGWxpJccyWDW3mkuFIVG5P1Ficr
	Z3dHI0OM2HDYwP1q15jwmpLLYh8vZuYicC2YK2WW5S8h9JFzl7bXYSgjDUSlg2md
	jmP/LdOA3W2lQTFd+oHW9GiAjCdwMZ1/YzI6XKYrm+9/S8SzBOAD15CXRxgWkTVz
	1JpM6CA1vPuFLpPJMbkGLMB8qIqjbop8WROeFnK1yx5IQSi3q+92ZnInKFgLTMqO
	S4qDKywmB3A0IsuxtDv7PpxodzFf1ml4KjuqW/T97sf6l0lgmuuHWq3Md3DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771351651; x=1771438051; bh=XpS4ICVFH/2+Y0L6bJwxkSVWe1izeZaGeqW
	CB1KLpk4=; b=LLfysUCTXaXnG4LcODV0g8L1+69gjWKFYg58puqf4KhQvlxY3Oq
	Gu5yiZn3uIqrVN+2Ctlqkm0Q71B6Go+NFYjwrLwLeZci5IgSoQYbbPbUuKH3vupW
	feZP8G099sbySLBJdDyD3hWclRMz1C7lhc0gRmPjsHX7yeaMYMixrO5tVlwyb/bd
	+HBjSxHOJ+fUcCcGg2vbN1Hyx+D21wTTj0Cfb7yUDDJZSBTqwXmmi8tQuTwnwJBO
	z2iNfedTIZ+jr6ZH30qhs4FRKFmqwpSdQDLa+I8n62RqlN0ef5BdrwVilOOFiNwb
	V0FJ/4OKYCzkani9nzc+ajh3+qdzYcLBc9Q==
X-ME-Sender: <xms:Y66UafeB8GOJ9ARgq_NHhS0_Dcz9kMLfZX0Bh-tCyQtMckTeW7hi_w>
    <xme:Y66UacMADgfse8RwjfaNe7RwhJvdSfL1rm_MX98yKwVJe4s3aelvXv7-VOS9Y-jBe
    dpVDgSoaLaF9yxDDAg-wucXyz3giVRLhFSWBrtOhX31nWL5maMHsw>
X-ME-Received: <xmr:Y66UadiSU9GtM5Ma9ixSpr5MG9-fvfIt3NaxXY4zmtxFD6eFPPRMq9HfJ-240vrC7mThoE5OTlg-LKgQz6ShBg07JLLd2Lx5Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Y66Uaf2jw75_jbQNW7unOitnEPfCY1dQZKlmNe0n7Vw12asXr1Tpkw>
    <xmx:Y66UaXhWHz9ZGvb8xGbHokvA8zS6Au1SimrQoMsckCVF9FOVlHlYJQ>
    <xmx:Y66UaffuPR3an9NCWgvtmED-8xzgV6H9P4O0hIWmHHXJmnOkh2Cvmg>
    <xmx:Y66Uaam8rx0uz9pDi4GP2WoeaqHmK70lpbE3Fi5h0g2y3zOiwyDX1Q>
    <xmx:Y66UaRf72ZpSy0M3Id6Fo3EuOdyI-q92BIOvJ4YZzSktz95VW3dN7_3q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 13:07:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Collin Funk <collin.funk1@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] ref-filter: factor out refname component counting
In-Reply-To: <20260215090052.GA695631@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 15 Feb 2026 04:00:52 -0500")
References: <20260215085755.GA86262@coredump.intra.peff.net>
	<20260215090052.GA695631@coredump.intra.peff.net>
Date: Tue, 17 Feb 2026 10:07:29 -0800
Message-ID: <xmqqqzqjckgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> +	if (len < 0) {
> +		int i;
> +		const char *p = refname;
> +
> +		/* Find total no of '/' separated path-components */
> +		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
> +			;

Sorry, but I have no idea what this loop (copied verbatim from the
original) is trying to do.

We start at the beginning of the refname string, and while we are in
the leading run of '/' we increment i to find the end of that
run. E.g., we start with refname="///foo", p points at the leftmost
'/', i runs from 0 to 3 at which point p[i] points at the first
non-'/' character, at which point we do *p++, to make p point at the
second slash?  Is the dereferencing of the pointer in *p++ a no-op
that is there only to confuse readers?

And then p moves to the right until p[i] points at the end of the
string.  It does count the number of slashes in 'i', but there is no
satisfying simple answer to this question: "what does p mean while
this loop runs?".

Anyway, the conversion looks very faithful to the original.
