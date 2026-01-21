Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B59331206
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031119; cv=none; b=c06tOYU9Baf6TE9B58QME6+5mLRZsFqVQxt8tG7rGdv9fSy123lgl0D6BPxDRqh+kh29LuF1SHz6JUFv3iMM/6WcSzBwwnNLzisVJYwCokPFiWUb8RjGeftHgWW9ykqY0MVDHJwPl6AWO7uXsIms8olMddJioxc3tbpoN04lEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031119; c=relaxed/simple;
	bh=Vv3vtEyaXRacSAY5Mj3RKuJTzfeh8BPgOumK6IjsvdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfAz97980xKlagpu4hq5cQ49ClHznwGkgfrcS01B+z3YRWncYxlVlvrVySkSFiifGJwT5HWR/a9Phi0bEbT34X//jiQtN8hWRl1lrEnxGKBj4fBYtgYsuMXBTlYaZRtJJwo904SNWQq67lPzg+nanW9wHqAysm0cWDnWWD5nwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mK5ssvIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVSGyvYC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mK5ssvIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVSGyvYC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D1DADEC0166;
	Wed, 21 Jan 2026 16:31:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 16:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769031116; x=1769117516; bh=gdcIm1qGMk
	jsbOPx+reF13R10FbhD7Wo41S/DHn818w=; b=mK5ssvIo/UhNFFXvQwg3B2b/WU
	95/eBuPCZdImR9QRoXtiwXA2HXar+2k6Gkp+oqsP+ZIiM24kUfXLXthVrkc+hJyN
	GnmwAGe0qApEvZyZbi2rVb4rCVm7PkcXvsM26yXLcpkwvSwdXBtVWFJkgdrPvzHF
	qBz/2JzIHfAh/bjS1TKOqr9yV1Ma3tkhClHkELHq5jLI2Mm24EMcCEHrpbjyXVea
	ioRxdW0FVIQdDTR8pbZx6EnbijAvjuEGqvNisL5KpbuQQJxGWfCgi/ycd8wI3q4u
	Mov4a0SvB7bj2vRgT0VTws3PLd6WdtG4yaiMNvTwzShmeHoaFIGEnW77HndQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769031116; x=1769117516; bh=gdcIm1qGMkjsbOPx+reF13R10FbhD7Wo41S
	/DHn818w=; b=OVSGyvYC7K86/+k552/524yJYoHpmGZTBom5KQQqF/7XTjXhTRn
	QDiDcrXI/FqqHMiXX1GogEU5bHHuEq4hQxDnXxRCZ8yWFBEy8Jcpq/m6GNqjhTeu
	HAdKN2OiqjAh3uPwMEtsyamcRgpus/mwC/boKIdgEBTBANnPMxbNluYdB8RSGzfU
	tC1fiAiWxatsIwvBpI+SUfVbgKtjocp/jNOqKx+qAVcFqWmDzzpW9PpIz98QuFyB
	Y6V/HB9cPXzRyM7qZ0yOJ1FAwT6d44uNywpx340Qp4+dSDhF490+qFj1yseWrIcn
	OGDKUdLJyF9US3NlziFnjetTJ5HQDHK5Kew==
X-ME-Sender: <xms:y0VxaYT4nK-pOxv95CcxByOxbMNMJiirP-u-Xq0Iwaiht6TK2CA-NA>
    <xme:y0VxafyFtdMKBABFJfZNZ029wsSYX9SDO5d5pzJaiCdrxBftD6hdknwR809370Tne
    fCEl1zI-nwJTNdkwspWJRjaYhBa2kD0RS265Cgcmwze1OhOUZ5U>
X-ME-Received: <xmr:y0VxaccCOW8-UlwL0VFgR_LLsyyxJUb0tsgz5NOjaCDFpXFZuR-8yg9C88hmNFsH8uXNhgQ1pr-9ACeDlLb9H-oF5Tt-DhYI3W0eyMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y0VxaaP28JWHNtY_xsNKaRWo_YqaJJGrUuCyWuq3sUqoU0O3H_y_Yg>
    <xmx:y0VxafvFNpDGhQeNmvCTUR2O8g6f1OI_CINjtPKCOLai2qg8WmlPoQ>
    <xmx:y0VxaTCuSf1q-plx8n_XniW9BDjLKzpdfrt3LPiC3jsLbgmdSeIxFg>
    <xmx:y0VxaWYfPMYbWCEKb_5QizfPIMa3Y8gaGKmCi5IibNNnHDrAxR6l7Q>
    <xmx:zEVxaQqN6OlS5WLPKKAOKhhIzPBdQSIPVuCJ91vi6m2g6jM3IcldyPlT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 16:31:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,  Ezekiel Newren
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
In-Reply-To: <20260121212024.GC723458@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 21 Jan 2026 16:20:24 -0500")
References: <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
	<0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
	<CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
	<c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
	<CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
	<6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com>
	<20260119055947.GA3100271@coredump.intra.peff.net>
	<CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com>
	<20260119204010.GA3148606@coredump.intra.peff.net>
	<CAH=ZcbCNeYATxqAeXcGd9kkHzJq2y5BpMrChSzb215EHAjHsbg@mail.gmail.com>
	<20260121212024.GC723458@coredump.intra.peff.net>
Date: Wed, 21 Jan 2026 13:31:51 -0800
Message-ID: <xmqqv7gur6t4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jan 21, 2026 at 02:00:15PM -0700, Ezekiel Newren wrote:
>
>> What about adding clar unit tests to make sure that different ivec
>> types have the same size and layout? e.g. sizeof(IVec_c_void) ==
>> sizeof(IVec_u8);
>> sizeof(IVec_c_void) == sizeof(IVec_u16);
>> sizeof(IVec_c_void) == sizeof(IVec_u32);
>> sizeof(IVec_c_void) == sizeof(IVec_u64);
>> ...
>> 
>> As well as other tests for ivec.
>
> I'm a little hesitant in general to have run-time tests for properties
> around undefined behavior, just because the compiler is allowed to do a
> lot of tricky things when we get into that territory. Plus it is not
> really _solving_ the problem, but perhaps just alerting us slightly
> sooner than the production code itself crashing and burning.

Yup, by definition, testing undefined behaviour with code is more or
less pointless.  Implementation defined behaviour, maybe, but not
undefined ones, please.

I thought you already gave them that having different possibilities
in a union would work correctly, but perhaps I was reading a
different thread?  I dunno...



