Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929024B1E7C
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734755; cv=none; b=I4IojchEMtaskuVYQZjvjghqIhwG6qiu0sDUsFMwlQe0WlgHNo9b8zjwbIS1heMwh3XYYQ4BvCi0y1W8m3NrgrpaYNjGnps1DsF+uuEud+dWt5loKLan/p8IbT92IE3BGBbDvZzv8gzrUq1WquDvj4Oka4kTFhVzB2UdgPVI/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734755; c=relaxed/simple;
	bh=WNGWQR4uTP0oJxJ4CBW/IhwuKiO+XFmcw3dRgHny0QA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4T+87ZP3adkB+DhBHI7RJW3OcqEtiizvYUpcudTVd2l1qdEVUzwB6TZ4gCcCi3NiWxOinW/dWlmG6Ihgm4suej0QnVCtiUVYxRZNSFHYuO2qGiq4zfglKTHu08t8W5NYP13PhhkZqu3KeXblUy6mfR8AIVw9DWmIGWNFi4fzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L1DnhwV5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rSgeIN1C; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L1DnhwV5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rSgeIN1C"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 58EF22540125;
	Thu,  8 May 2025 16:05:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 08 May 2025 16:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746734751; x=1746821151; bh=hWmpnkNtqp
	xzm8MmeJc7X4RGHqZQTnHeYznxM9Vjz8M=; b=L1DnhwV5Pwg8pvzRDXgn98FAsj
	LfVB4W3QF/nxF66tUQuZBQeRTgIoDTirfrtJGkAJjUJGxS0nY2n1CigdBIsFuNhH
	QRp6blMRzw/yR6hQIrtWxj+8nQ5sVbpwq1285z92GYlrGK2O78no5xboXMM9khh2
	5uiV9ZOWLgd5aA9QMA4LMNO4pdSvg0Q09LECOyoC5MDBmEAmkaJBd/d2HQXBPaQM
	3cLdtANoIkyTc7UYISK8FxGIZpynRdSdik98A/uwpHdKp8O+PYrJtnoeDoNn9bZf
	e9CxBmHM4hM87tX6ncRZ6x3SOkx57gliUW9NR21FnuvfowrjbO0Tjxg7nQ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746734751; x=1746821151; bh=hWmpnkNtqpxzm8MmeJc7X4RGHqZQTnHeYzn
	xM9Vjz8M=; b=rSgeIN1C1XVk5wzLGeFriUtGgXDv9PRPCO+wUIHwl5or6v00QOM
	emJAuk0Le+rJiLhbi1yFiipLBj7YTywI8M3Lm+AprjzI947Wx85f4WPvpnysnbQQ
	+9eBOSBJFyYaGab03jlNIZM/4wxk3BO/JfBnLJcjwTU1m2P5JCeW5it+Y6jcNC3L
	9wicoUG1Mbw+KWGkdKT66b/opyll4Wz5o6ewHze+TLhjQVUWnIgP1Uxm87Jl/WtH
	6P1DDg3nooGTNi2boIQDmIHkT6cXcLPuB1e4IsJU/g8ODEhVUO4GGdte6CH2JSJ8
	JfH+T5vnlgqA/4G11r07xrukPFcVlWtatfw==
X-ME-Sender: <xms:ng4daODPLY_3LaVC53CmruMRXRdopTn4lxWnbDzDCMisRsYFFJzsxw>
    <xme:ng4daIjeuknxGXVGLzmcKLEtRQ_q6jWNlkOAgFEogLzCoACyamr2Sd7Rk_utmb5oF
    CwNlU8q0celqhvgrQ>
X-ME-Received: <xmr:ng4daBlIP1UaOFrfjv6_V3PZJs4XaZe2fz2VcBoesqP0Lt1Usz7hc592sAvOp7BqAQrhkWKAcKMKm798QH0pDt8CjNOVYe0k3RI7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ng4daMyUp5C5Bfbq-pzIAa9qYLoOWaH3mlaPanG5OD3B_pH_2pP6vw>
    <xmx:ng4daDRnXXfPB7NHEVQ5m_EgUnvR3hnf3Wd7HdvbAX40WC_e7FiRlw>
    <xmx:ng4daHZFVHotSXwgvV0koQtpvrnVa6BNPiUPS3KqiM17BSo7v3FBAg>
    <xmx:ng4daMQor5ue6SnqoeVfK6q0ZhB_tjsaVCtq5fhOfl9eZOUH0Kvulw>
    <xmx:nw4daMtHDtpJUQSrlgt_vSz3Mk_7d9jL-F6pEC44uZq3pCNcll1WcQog>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 16:05:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
In-Reply-To: <20250508195714.GA18229@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 8 May 2025 15:57:14 -0400")
References: <aBtzn4nwLsI9p5Cp@ArchLinux> <aBt0BDTuOfUuCHE4@ArchLinux>
	<20250508195714.GA18229@coredump.intra.peff.net>
Date: Thu, 08 May 2025 13:05:49 -0700
Message-ID: <xmqq4ixu6f6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> -	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
>> -		/*
>> -		 * We don't want to leave the file mmapped, so we are
>> -		 * forced to make a copy now:
>> -		 */
>> -		size_t size = snapshot->eof - snapshot->start;
>> -		char *buf_copy = xmalloc(size);
>> -
>> -		memcpy(buf_copy, snapshot->start, size);
>> -		clear_snapshot_buffer(snapshot);
>> -		snapshot->buf = snapshot->start = buf_copy;
>> -		snapshot->eof = buf_copy + size;
>> -	}
>> +	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
>> +		munmap_temporary_snapshot(snapshot);
>
> The original triggers this conditional whenever the strategy is not
> MMAP_OK (so MMAP_TEMPORARY or MMAP_NONE). But in your post-image, we do
> so only for MMAP_TEMPORARY.
>
> I can guess that the two end up the same, because snapshot->mmapped
> would never be set when MMAP_NONE is set. But if we are going to make
> such a logical inference, it should be explained in the commit message
> (though my preference is to leave the code as-is, or to pull the
> refactor into its own commit).

Good thinking.

An "extract" step that is meant as a preliminary refactoring should
not make such a change.  The change may or may not prepare the code
for better maintainability, but I agree that such a change needs to
be justified separately.

Thanks.
