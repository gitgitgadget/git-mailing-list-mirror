Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38482B664
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744072338; cv=none; b=KCgssJcVY37UDF7YnUiib9YhlW7B5VXMh0fuIoA7Hi8M//r2Ckg27ZiWbx2eu2YG/KIR+OLooNNgwDqj1pYLJX9AxPrAw/bb0J2SoFrRGJIVyhJ7cL+zygmBkHAmfA0vO1qYQrlNQiriKEBEgZnrutbgsTc82FAW5ancjOUuzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744072338; c=relaxed/simple;
	bh=jxopTikwPmi9BZQ8A/47r+Je6xQKtbgbpzjgGBhb/WY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OtMg61xKJSQ2xCKK7AwJQVuk59zdHVstC1ijGw8xpd/pevQvTPbxgemXGi62K/7s6IPzaAo88farDoiXCoAGCvtshCfbtd/X5LYcX7j7Apm40W7fsdw1W6SekdNa+HF9NnNJVvBpSGY0IEjTKMPcvvJUnFYMbmT+0y3zTBsnV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SFTHzTy1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLNHDMj1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SFTHzTy1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLNHDMj1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AA4125401E9;
	Mon,  7 Apr 2025 20:32:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 07 Apr 2025 20:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744072334; x=1744158734; bh=PiiGxxOlmX
	sdITHyVVOi4dKOHNfMNq0inbDMixXzv9Y=; b=SFTHzTy14MD5vz6jAW5ge+LGJY
	o5Gc2VmqCq8pP86ttcEp/NmeP9r1gj3RYNBPVXu7T7XHuxBXTT0b32hMXYTWaDAy
	L3EcUah13xNR1IomiUsMV3juB3dDZMqkizNokQ8HVoG2AsceqVsZcEL/hUxJjrVr
	1WhG+5QabTySm9OeT1f0Sdt02+q1psEhVskvI0N3m07LWcpdmo3iR3XHEuHSFouO
	sGyD4n7/s0MlDAFzVi/RPmX4lkJvmYW0ZNjdGPKkA24OREvoRcvyr0gDu+n3kvHc
	oTBcLJSNZm6voWgMyfFNwlfZs6kMZpVBCP0QLlQxemSOP1pQOv4gf+5jlNLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744072334; x=1744158734; bh=PiiGxxOlmXsdITHyVVOi4dKOHNfMNq0inbD
	MixXzv9Y=; b=HLNHDMj1jg5Xk5BhVbvLk7cm/yE9yAkQYp0V86JXY0k7xtb9isQ
	eHiG9StZGKXLecnxLeY1ys29i2K4vIVQIr7mDIm7RQJv2yPbmiRY3nqEkwuItgCt
	vSJBsaLgvkz7to+zYsPzem31/HBSO9pIAX5bzcNa64SyYyBu+e5TVlSgRlLVmuBz
	XTgUUbmGgwTromYQujV44x4/Xb35Amt0F30Cv6tzZUuG5hPnIWVaxk9NoBQCk89J
	YYB9aOJlojTaf4a54OGhQBmCfdEzi290743Shs3E7Pcd+U50jrQOe9WER63ibUy2
	uENBGetH1/0WD2E91ijltbxF/9Oq0Jup63Q==
X-ME-Sender: <xms:jm70Z3yn6bVz-eEKfysm2GUrw7eInkWFkUh8LELuD263uSFptbzdSA>
    <xme:jm70Z_TTO5fdP2AfxFOdz6HVgJSYlTADxDVOfq-L2WiNTY84KDjGcXn7p2AzbBpb1
    D98RX2GV0YHeS6wvg>
X-ME-Received: <xmr:jm70ZxXPNhn8PyXWtpvtTyxkjT6-IIEB528sXIItx8fakgeCjrnWdK29swTxOKL_1fr7wPKYsvFEp6f8xTAGDH7PxfWzE9WV-6Bd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jm70Zxh2olxL_eRZPvvGBASb6QkpfCiOFrlmPbk7cbnTsZF_KTtl0Q>
    <xmx:jm70Z5CcqVF824qhbm6Y9FLKCma7yysvOF7wnoAK2Ly1DlkT9jCNSA>
    <xmx:jm70Z6Klh919fey260Ns0DntapkPjYF0T4w9mIuv5c1bNCPcPsnWDg>
    <xmx:jm70Z4CjhtEss5vw7AuOluvqYzoHZODVIGEVYYL9s1_-R_C6IxowHg>
    <xmx:jm70ZzlOPtLhY8nSDdsdYK32SNGrQlFdkXg8sIwLS6iOk7GEW5b-aHcf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 20:32:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Toon Claes
 <toon@iotcl.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 00/11] builtin/cat-file: allow filtering objects in
 batch mode
In-Reply-To: <CAOLa=ZTY4AE4ONHoZX+VrHRC9461utdV6g7FFbWtnGuay55G9g@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 3 Apr 2025 01:17:38 -0700")
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
	<20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
	<CAOLa=ZTY4AE4ONHoZX+VrHRC9461utdV6g7FFbWtnGuay55G9g@mail.gmail.com>
Date: Mon, 07 Apr 2025 17:32:12 -0700
Message-ID: <xmqqcydn1oj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Thanks for the new version, the range-diff looks good. Good that you
> also added a test for "excluded" message too.

Thanks, both of you.  Will replace and queue.
Let me mark the topic for 'next'.
