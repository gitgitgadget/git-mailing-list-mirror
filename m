Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A892D6E6A
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492586; cv=none; b=IbL8DbLbpaaVaY9iAhX/BLPXYjnqc6GUw2sX0nL+uzL9ACEzmPBDS6+3aSI7vEgkoBggh5QtaxWqPmWpFb9pR1SPuTvLWldVwXnMNnjvu7mdL3RH//VxPPY+1PLwOLoib5bL5MgF38SdoWA3WBV7zfrpw7BFnDeBXheGLz+KBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492586; c=relaxed/simple;
	bh=oN1CwvznMFijG8jCjtqWHSMONhibRcnV3/dFarVbruI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DpKCARxcRMPBybxtrsrM0pnYo58etPX901SnVx7NWtDn/yWVXlVvr5mJBtfqvTCP6A10/jQ8B3eAKnxsUhmWsgA4hGa2hwovfSyWn74BcCn7pnsXfGxp0+Wk2NxvRJCEJIl9x0O/9ufqi19moXj0EBdWlJnILc7isPM/yIWmUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jit8z2X0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CuVSx4/p; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jit8z2X0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CuVSx4/p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7147140016A;
	Tue, 18 Nov 2025 14:03:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 14:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763492583; x=1763578983; bh=oN1CwvznMF
	ijG8jCjtqWHSMONhibRcnV3/dFarVbruI=; b=Jit8z2X0ZFVbcg/aNrViBpVFVR
	hCIJtx1JSkn3jt9lhBC8jcMV1sZCuatXYlH7J8qOL/cKI0+SyYzM2avIgAT/E5ja
	PR39vyfCYjZrYGAmLpsyzQDo3h5u5U4pe5utdtl7aOLUXMdH9FbV2JABbpyCIGX5
	oYz4iL5ErYg4UBBdjqyUaCKRM2qZP/TkG2Z2nj1wQn+jg/HSyAU5TbgvBRj+XGp5
	9BdjPY27dZMDIYtyLzKmirqPvAFvK4hNFmN09PKbuvV/ZT9z7SkRXBs1n84auhqz
	vL4Nn0h+EaNsGq/cTKTqfHB4AN0LDcJ9Cn1Y7njBLCqcT0kyJRl9z/lrWpYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763492583; x=1763578983; bh=oN1CwvznMFijG8jCjtqWHSMONhibRcnV3/d
	FarVbruI=; b=CuVSx4/p2PzLV7e7Wj3alkvfFyep9Y+3ew4KpgGx/DS2xqO84WV
	RYTfXXKtusSBCfCL70dta9p/x9r/YM3YLPAWxu8N6oI23Be7GNgjcWaA1hqAnKi1
	sICAHC2jIxwSc6phNPpgOyfwO2Fs67kiFKTcznFZtzRmaKgxUpcwB0J0wgY6qYrV
	x7XfNjTUXKKjOtIH7Nu7grLnAgOyohvt11UL2lO2WU35uFaD9ZnHW4ifrtq3NaT0
	/r5toO4Jb5mFgxYI/31DV8yQnnRWLsxfW2lBBQWo1bD/OGuwPVU10/cewujaqMHo
	X8mj8P2pOyGdpmUXeBvYYMzv1HBJFUqbBdg==
X-ME-Sender: <xms:58Icaf0Qh6zYiCzLW0X0450Tlxq691ZZECq50eWZQNcTfzUSiqPx9Q>
    <xme:58IcadKEamzc3Bmb4VnPBnhxbsyrd7n8i0JiJDeW3-S9vlE8wU5uVXlUiONGiyV5Y
    W4BhzWh-fSe-7Zj1svBWjTTFGc0JntKYQ5GL0orfjUa-SQt7iHJ>
X-ME-Received: <xmr:58IcaWH30_1qYGpznLDd7aRpZnrxkj3Vw9X0FPDkPH2-cgLBCALVDv6b4c6DJSz95sPQPDwRZHIigB-ArA3A7rJmdzOfw89ThrUK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:58IcaRWY1iNPyakwWtDhI8jk3vOCDDRBBjpA9E40oXIQXlc5ROalxQ>
    <xmx:58IcaWwtnKDwmJ51CAPI6zzcQ3anKxNmpFpyiZqNI2J4u0CHeAlm-Q>
    <xmx:58IcaeRclhsS7ubuXZERjqJGErSqCG4PlMBJ9oeER4oHnMe4tEAGDw>
    <xmx:58Icaai1bbMVLlCuOWv1LhKNicHo_HqWP4eeKmLqUaU5WDH-7BOqRw>
    <xmx:58Icafnp4YE-IySC_9ytqG2FHBpVAIGv0VoK-gCb99y0cG-2ugk7CGWX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 14:03:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] fast-import: add 'strip-if-invalid' mode to
 --signed-commits=<mode>
In-Reply-To: <CAP8UFD03YK47nONVRV_wqOEanC8Oth1iRzsFv=eFhbFs6Q5mPA@mail.gmail.com>
	(Christian Couder's message of "Tue, 18 Nov 2025 19:29:51 +0100")
References: <20251105061918.3688870-1-christian.couder@gmail.com>
	<20251117043450.322644-1-christian.couder@gmail.com>
	<CABPp-BHY4SLmWY=V5aHJ6igN0GWeg6V1MoWDwszPe2O38wqBhw@mail.gmail.com>
	<CAP8UFD03YK47nONVRV_wqOEanC8Oth1iRzsFv=eFhbFs6Q5mPA@mail.gmail.com>
Date: Tue, 18 Nov 2025 11:03:01 -0800
Message-ID: <xmqqikf7duze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In "t/t9305-fast-import-signatures.sh", dual signatures are already
> tested to work with `git fast-import --signed-commits=<mode>` by the
> tests that brian's f6581e23 (repository: require Rust support for
> interoperability, 2025-10-27) modifies.
> ...
> Thanks for your review.

Sounds good.

Let's see how well this round interact with others (I do not
anticipate any more fallout---knock wood), and then mark the topic
for 'next'.

Thanks.


