Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10B40DFDB
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712169; cv=none; b=bPWv5kP6/Rpx4iY90buhzfLZFOpNa9wUVJxSy6R5xe49ppKBGJ0HGvZmuYg8Cs04tE1MBVmo0jJNfNnUMJWNiePVvCAE5oMRD5xYWgsJSk+Rsh2Wu8pU0j+qR9if87rXO6cRxGBofkTsrwPaYNZRauDVr7C1LemCuILeag/IVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712169; c=relaxed/simple;
	bh=9xsHST0C8g1BBaKLAiegNghpYC+QDcGgGUp9nn6uB+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ora7b3V6POGTQ65xc3W9i8tQ8dHHTAGlCtaNpc76zPWrFU2V3AY13U5qIdFHbv5WHxB07Yqfw/B0HEj4ZFRGBY6XQ/Lw9nGIlr4vtdzsphNJH9K6Tg0zHW/Pw+gYFCTD4ahAMiUVfJ/mBqI8KncxD+K8QgLfjAIg/rbmkVfzVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pftLyNKB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ugPQGiq8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pftLyNKB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ugPQGiq8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B60B7A01D3;
	Thu,  9 Apr 2026 01:22:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 01:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775712165; x=1775798565; bh=TihcgILnJp
	TK8NdtYI459H+KajN+NNLlyNQcCjo0R8I=; b=pftLyNKBG+hAMDhXdGP9AUeuwW
	S/odD/zf6uoNVpn2iNirQRrMXzXWkqvSM+BtqrxJvFa+bqE/vizlNGLovoMnOg64
	t6B1qJANYxVYNFcPQ1k/NF6Amw0tGrM2RmJTUMGN5lNXaXrcvqzJO/a2InPmV3iH
	eI6LbfGwrdPT52IX/kJMhQFyUQCSxxXF/9kIXtav3RpbPILc6wI5g7QGHcUhSow/
	WWdU2GMKMwdM2PXQh/y2ALddkaMCI8u2/AOrkbtVl2nMYUyJCoh/rApAXgSXWGJY
	KYGDBow3w7+MQ8MWGmKzlje80US/teEkqA0b8geIDqx5IqzszLeZGAwCwztQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775712165; x=1775798565; bh=TihcgILnJpTK8NdtYI459H+KajN+NNLlyNQ
	cCjo0R8I=; b=ugPQGiq8/6y73ddrC6bxL13TpYPNznoWelJ+ogCkYksYN0winad
	+JKsa0VQKvickq1QR13Fn9jKYpZUXy+Galb9Nthf0/kqulLBmQBIdwuFYCeL5/TI
	Tl5H5TDAwZDxp6CQea/4uPYCPsbd8qhIppDY6Msm1iXPQMxS8JiaHD6sw+SJ+tLy
	duSMZLL09WZGIyWTNK/SRUVETXe5ZRGC/0Xj2c/I7UbVUhyuvQzzNwsMqU1CK8aO
	R+Te/xJJi4NpEL5d4e2/UGS5nA45fEoQAosnZWBn72JMAFrSKeIuSI1PvsUqmObX
	Gj0jjFC6Z1pBWbkBkvrnlAI78EOOdXxHppQ==
X-ME-Sender: <xms:pTfXaXQDdVTiJdiqbU0dpIXTKJBpJTtLnoPPxUbtdw2eLGg0WzJBbA>
    <xme:pTfXaexPcLYVnuHUrj4AzKSO9R_KgK_kWdJ-X3VKXySdYr1cuXs0D9O0yG1LCnd2t
    mHlnsW2dqm8ik4qokrAxdfxoeScSC_dWoYEkdqZIfTFqLCB4mkeFQ>
X-ME-Received: <xmr:pTfXaacFeR-HlQCgnrxaux33aBIixnriCRoN6eWy6JMWLZOITzsOrWtmlov36rwyeifuOoVE2b4ZOxivcyfXmIVE2CZJWkAl5sDNjeBq4CU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pTfXaSK7aVGEGRq649MocIOawbDxTmfqTXGIDpIkBhXxHNTaX-gYMw>
    <xmx:pTfXaTG3Q5EaIXS9R9J7fxnUpsHVRYKii-GHdUvIBeNiB5JNp1aamA>
    <xmx:pTfXaUrxLq1XXJPH15gNFUpbfVG82hCMJ8_6RH0tYxd_Cw1qRM0mnQ>
    <xmx:pTfXaUTrkWE99Y5fIT436RbY9YWsTe6nn8mNXUT2a3rFa2Ov7bibGA>
    <xmx:pTfXaarb9BMxyzpuxBfXIqzBpXttqwWPyjsV7pWvVIlohT5I_5q_biDo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 01:22:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff771bb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 05:22:41 +0000 (UTC)
Date: Thu, 9 Apr 2026 07:22:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] odb: introduce "inmemory" source
Message-ID: <adc3mAItBiKMUFNJ@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <xmqqa4vknjab.fsf@gitster.g>
 <adYQPmnajLmVr-vh@pks.im>
 <xmqq5x61xgvv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x61xgvv.fsf@gitster.g>

On Wed, Apr 08, 2026 at 02:48:52PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Apr 03, 2026 at 08:41:16AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> 
> >> > this patch series introduces the second object database source type,
> >> > which is the "inmemory" source.
> >> 
> >> I cannot read the word without a hyphen, i.e.e.g., "in-memory".
> >
> > Fair. I think I'll keep it as `odb_source_inmemory` in the sources,
> > which I find easier ot parse than `odb_source_in_memory`, but will adapt
> > to "in-memory" in prose. I already did this for most of the part, but
> > not in the cover letter indeed.
> 
> Fair.
> 
> FWIW, we do the same for "in core" or "in-core" in prose, and
> "incore" in identifier names, so the above is understandable
> position to take.
> 
> But stepping back a bit, does this new "in memory" refer to a
> concept that is different from what the rest of the system uses "in
> core" to represent?

No, in principle it's not any different. One of the reasons I decided to
go with "in memory" though is that this backend may eventually be
(power-)user-facing via the planned "objectStorage" extension.

This extension will work similar to how the "refStorage" extension
works, where every backend has a schema followed by an optional payload.
So for the files backend it would be "files://<path>", and if one wants
to configure a temporary ODB source that doesn't store objects it would
be "inmemory://". And overall, I think that "inmemory" is a lot easier
to understand intuitively compared to "incore".

The counter argument may be that this really only is for power users
anyway, as it's a rather risky thing to do (e.g. you must not update any
refs), and such power users may understand the concept of "in-core". But
even there I feel like it makes sense to rather say "in-memory".

Patrick
