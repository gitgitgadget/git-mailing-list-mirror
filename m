Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551602E2DC3
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938441; cv=none; b=SQa6bxZ70/CdjrZ+FrV6x7bFOS2pUMZjM0aYJdimG8LdUXIqWrE4ERoN+9wBPk/mhmevgaYgxzd5fD2hK81WyNG+axJpX0uE1zeMx3mTjzHRVkCDFBT74ZkxfGkr9tztG+mXLvarR7AvBUdoSGfba/okIUcsHSIvShMRIbf4hdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938441; c=relaxed/simple;
	bh=VLc3s3L14DQw1RjEDo+1Vo2u685KMS8GUCrZewA2XEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aA+hlXMdvVX/3gPzKJXHoUzM3v0/fD3WFSVFvuVpujtzQ/F06GWas0C+ZonjErJnpn15gsF9FGYTcU+hpAHNlNby1MlSYZpnrvkohq5ILjmD+6slorSx80nXtfvmLSVl9+VHzPohsY8NHYz4OSU2S4MnW5CmJAqBFyAC+onnuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L3n+A7nX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZXkX7qV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L3n+A7nX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZXkX7qV"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 689FF140006B;
	Mon, 11 Aug 2025 14:53:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 11 Aug 2025 14:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754938438; x=1755024838; bh=TMrgd6j/Gc
	Tje6KO+MJJb5Ky2RVKzFCVJikX443rcTg=; b=L3n+A7nXU9J9oECE6NGdNRdyM7
	usadM6QLAyznWcOlnNRTrI5ZYn1zMxApD9nIupcfpeMPRVwtiCkEgTJDXhDjbD3H
	w89W5XROef4b364lKmAXqZkBWLYJRhR58b/iYKjm4kYmeTDKuw77uxeEutpgx+wH
	Bfa7CUneMqRTDUDbYJNVHxchlZqnA8/iB1rRk3xwwTEZOtx7HH9KLPkacdNaiNWp
	AzOwroBeXeqoksg+kuQhGAYg1nGW/5zRO02li9jqtNRA1YQAlxXxKrs+eBi5EkH6
	ymt3DGyoclPXsM4iW17YN0ow48XRgD5nfpprpi72XuHsdfiqeZovqYs0X87g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754938438; x=1755024838; bh=TMrgd6j/GcTje6KO+MJJb5Ky2RVKzFCVJik
	X443rcTg=; b=JZXkX7qVgaIPfKPzlsCCC16knvVbnqhNlPxqRVuTC4IvDzFAKmB
	j0vm2DNt1GJ8fHLSNyb6jC4UFqAE5iISqRDUa5wARNR8FwRi1JI2w/dpkBMez39T
	HlkOddGpA4BOD2aK2uRaYzpPQqwkKGuW85NbqPT2pufkJXiB4xe/RdilFhb3VtAH
	qUpQbUgtUrr+RFRY/ycLBRRMhUiXsj45zie5IVk28rZMMJsCuswPqWyOHcCNYFP5
	qfDo6dkAgBpwba3TZ7yLD8x5qAh1UsR2Xxx65ILQDr1kOuHN04Xa1dYrJRO8hmpg
	wEsCVSbqXprGg0H6LV1Tam3qh8jf1HkGl4g==
X-ME-Sender: <xms:RjyaaGWUIUs03DkeZD6Z2wiO_QTlWkiGyCLyEiqA7ryYsQYPaQS7Qg>
    <xme:RjyaaNL6pPkN_yFGJSGm7PVbpJun00SKd0UDc962WgsXreEQq4diO4cVZ2pIh4zBQ
    FmG3X_NiayVLf-RIQ>
X-ME-Received: <xmr:RjyaaG-FT7NItPU2rzo0OErEW7SRiPqQJ-p2o3NNtZgAu4S4W0fBtNaeI4mfzrlsqlo4AIyI-yHiLB-0TFcJtH-MqPv07KBO8kk-S9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgv
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:RjyaaALAUrymSG2iC0Mw1PN_5z377a-L8dkCgj3S7ezRXLMX66jqug>
    <xmx:RjyaaLnaK5SZcegdSsTwzblro0VRHiFkARJj_CQ-pXCZUibBmdEt0g>
    <xmx:RjyaaENqpRVsA7qbRT_0trjFHe1H2FerTwL-FmJ7hE3_1eV34CBc7A>
    <xmx:RjyaaB1X1_8T9mQgRxgD2cpKB3T0ek5h84TTVssmgKmAJLDAlOQgSQ>
    <xmx:RjyaaPkzYyl7mHdEuDaG5kYVIFr8TxpFHV8Or9JcugLbmyYZusJeu7EH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 14:53:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jon Forrest <nobozo@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] abbrev: allow extending beyond 20 chars to disambiguate
In-Reply-To: <xmqqfrdx517b.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 Aug 2025 08:26:32 -0700")
References: <xmqqfrdx517b.fsf@gitster.g>
Date: Mon, 11 Aug 2025 11:53:56 -0700
Message-ID: <xmqq5xet3d17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
> which is counted as the number of bytes, since 5b20ace6 (sha1_name:
> unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
> change, it extended up to GIT_MAX_HEXSZ, which is the correct limit
> because the loop is adding one output letter per iteration.

This is half a truth.  It is correct that the loop used to terminate
at GIT_SHA1_HEXSZ, and replacing it with GIT_MAX_HEXSZ is wrong, as
MAX_HEXSZ can be much larger than the max hexsz for the hash function
in use in the repository.

I'll be sending a reworked version that takes the current hash
function into account.

