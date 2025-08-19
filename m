Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4531B114
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631126; cv=none; b=d5eyz4TrYP1s762aUJ//zHHGrQrcecrci55QgN8xHxhKSlQAIhz/sKooL/Zg805Sd0NlJIqMIgOrteV0fhRaBYx6jn0yBFfTozNy3fTrsS9U3gT+fo1rtFkJoZGmgIOPj4ymiQH7ARWl9R2ZGpC8/11k9y3Kvfte3niRcqlLnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631126; c=relaxed/simple;
	bh=kxBEK4lAqr+jpwoAz5jQrA3Ibw///JqEG/BVBpsVAGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jYPpB/UTj3mYFKSbTz6NPyOuma65bxtT8zLbGm7mbZH69nxCU+HGoiPACsWf1uKCofC2W+66/Nl6ZTluroTpyhFVs5QVi+TbSRXFvaEM1SoaLPEuqopAfiZNrphLGYklM1u3wk/FPHbbLCJCIlgX7QVEJ2B0HOjk/J43M+pY9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LEPPbAVF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzHjWsk1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LEPPbAVF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzHjWsk1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 89D01EC0399;
	Tue, 19 Aug 2025 15:18:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 15:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755631122; x=1755717522; bh=kxBEK4lAqr
	+jpwoAz5jQrA3Ibw///JqEG/BVBpsVAGQ=; b=LEPPbAVF6gufelTCNYBTiPrBVd
	jF6zH5qjKXZD3ujOiNnIGARLf/3vuL0Sh6zdGiW/RDgelwCS7Fg5fxu0oUehkru0
	FWAZgynsAMA97tiiBuy8LIwG9JkgmfHG+Ify+cNE6Xc+xKOm8XN5brbptRT89sMZ
	k6p2Ddkn+ZbcMV6clyXy1c8vIoChLAeTdsa/5xQgSw76StfC0fr6h+7d3fASzdce
	8nAhOyteN8HvAw3FbX5ZNC+HAknIX/Xrk5h44lCQOTe7+41Svt7QI2jeia0pGcBr
	HvwL7wfL1uVTloHgtGFz4uer8y6W0v+/FBdQkUjpsDSUIRPvLMdv3XQRWXcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755631122; x=1755717522; bh=kxBEK4lAqr+jpwoAz5jQrA3Ibw///JqEG/B
	VBpsVAGQ=; b=HzHjWsk1e0+ASlkSDJrVgs4Q3TRcUwOC//+5/Uod4jM4oKUEVMs
	AmutK61qiH9CPwf1H4tGbgrBOS9ZCgBAsEtaNm1OsU8gmZbD3eIcZILYeTDGA2Ab
	Jhlz5gPzh1hz9ulGZ+CL0Q+jdrQZpEsnlCbvbG+cPBpIdVOH/UNw/tv8RUQD1bEt
	G1QUvErM2Y6taZodVD90jc5S40bODohxMTAC1yI4yYNg0AKjFWpt9d51CrNE5ZUR
	3E0QmTv9KTaHB8xwyIGQGkpLpdfaS9TJKImnWypGHqXSRXUX7D/JcaMHgPyDh+yo
	1ieiMzywmUvayhT9B0IyGSqJsRS8PQJNTzg==
X-ME-Sender: <xms:Es6kaEpOaWsoMMfH0Ll9OLFDM5idNN2JeHWUfQJUjCddqBX6ZBPGQw>
    <xme:Es6kaN7Z4uSatsIRfbm6iX2_m51GVox9OZCAFoLLsheIqWYYi_6q6ElmjDJ3vtt0L
    p_jkS9ERfSFt76HEQ>
X-ME-Received: <xmr:Es6kaCq7xok7pl6Sk_mssyThmoKsuE3BCEaIDKa-HUBpArSrXJpsBzn95LNCig5ohNsiN4RAs8j42kcuWMiRu3WUGXicR1BGAA230ao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeifedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:Es6kaHjo3pagAznqQTkV_7Bt0gX920MIhW3rGfolLKmQ-rP5PVPwNQ>
    <xmx:Es6kaEJM9uqhcVRFRoBI2tPcPuD8kHP8RA-FhNxqkqxU4LFfBib8tw>
    <xmx:Es6kaPDNDErULGm3DAQJpC6Wro4xoA1PpZMGIyTQKNBrggMfjhTu3A>
    <xmx:Es6kaMgP6GT3MfLEdwV6zx4grYhi2ZYWqZ5kiRo77DVNEFzJjsh4QQ>
    <xmx:Es6kaHOShvikqHgBBTZT0wgWp7rVvOnPbs8aiX7Oq1MXu59su0ZY6Eur>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 15:18:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/16] packfile: reorder functions to avoid function
 declaration
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-7-1660842e125a@pks.im>
	(Patrick Steinhardt's message of "Tue, 19 Aug 2025 10:19:36 +0200")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250819-b4-pks-packfiles-store-v1-7-1660842e125a@pks.im>
Date: Tue, 19 Aug 2025 12:18:41 -0700
Message-ID: <xmqq4iu3dsry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Reorder functions so that we can avoid an extra declaration of
> `prepare_packed_git()`.

Makes sense.
We usually call that "forward declaration" instead, though.
