Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181F2EB860
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514566; cv=none; b=DT0ojZOXxX8O6XHnqgEe6oBFF72svVkJiqkEGd7deXBeE7BYQHcspAIQoNW9toz6gCbQlCcyORsAIb35IkWQyhaYVfj0vs4y8zWwWWhAxdkhIgW62PRI/I2vO/fFjngN56S9Q7IpjTKASKwfiUv8PhuT8w01vHDk7ppf39Tddz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514566; c=relaxed/simple;
	bh=KVT8AXqRbL+2rj7fGU6DWKKEWmG7d0URo+Nur6aHNMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vrb8BR/PDw6NTYmFFeantBxDdzLmMeEBXiwuh47oES30K3PmW4SVM537sS2iMBYHH7guVcHjyDQDGt9iEALjUGBwickisFmDNALtRIQ/C4RjjOjdKerwEy99zPD31mHDSNeoRkOK6QHoSvRKyY3ntqbNsFJo0LlAuhn4/heMT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uxOCeL3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTaBePLo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uxOCeL3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTaBePLo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C9F29EC0301;
	Thu, 19 Feb 2026 10:22:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 19 Feb 2026 10:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771514563; x=1771600963; bh=tsB7byiB1S
	oHm/RBbUXMZnrQZIRE2hK+Hao5R1xqgB0=; b=uxOCeL3tRTm2/Q+2zL8V8r91DY
	PMqvQZT7pcSlIb5giW4h0Hyi+q+0h48S1sDg04Ur5YltijGzyp4ZFt8dFV4LnDSV
	Kce5Ln3qDPuidR+bXAgSR8PXuiOIp+IVLQP70cUWO/9N7gtxxEMBQvDkcYTzBNCV
	3j4FAe4nllkyBPdux6kU19eu3qy6zJQDDasG/Rs0azHSlzDm9i1zsWIHLQ/K+oeD
	4Dj3toWtswnmvf1rHHbuT1iYxfISp12fyh/2s4mlbFf3cll88Ain8FuNIhIe2PiB
	i8SN1/wUmp9B0j8z4ueejlVTBHox1Nvoa/m4XJV/zzK5woTIyoknMeRhmjpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771514563; x=1771600963; bh=tsB7byiB1SoHm/RBbUXMZnrQZIRE2hK+Hao
	5R1xqgB0=; b=TTaBePLoLGM7eRShSvmEeA2Kk+jaInvchiBeP92GW0BWmka9n8D
	jccJj6PMPTESLt4cc835NOaG1rwyKVIi0hPt+RJg7L1JiNK9Tu+B+/edsTvNeD8l
	b4S9a+2EqmaDxtgSgZX7RLqLSUpvCQQhFtAzAdok0WWJvUJCOJqJDQ4tow2d2Ms7
	O4/Ns3C/onWi9TtXrpa3Tsu/b2dYaUXOLgLKZB4+Z1o0uRXCr+V+vmwGSKdoMeeS
	gbIN9sZo0Fne/LVyc+eevOtm5o0v+JrRfypDaNJpBxKLOoc+Vf7ajU1ySH/sw8Ow
	4H17AXaFaIY0j3J8nk+Q43NXTmfWaot2brw==
X-ME-Sender: <xms:wyqXaTix0PvkEVhCESGpESMwoEvHFejQhWNSAQ-GPVrjniRQaRmMEA>
    <xme:wyqXaW6r4MFWP19xh-H9zqPSp18IE3Lb5PNZsuIbkoESY9i4Fsvy7PewtfJqUsfkl
    JjwGKuc066WSFSvznqMeDIXARcC7wQC2WJvXvmXvQprnAo50o_C>
X-ME-Received: <xmr:wyqXabZkKHe2FjRc5o9pXcK_3lKeeAJqd34sDEgoXTy5nd3lweKk-RkzkmyYzzdwnYQbKHL79MI1WaIosr9oXhc7pu_glBvl4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wyqXab6PFzhyuQdJU5fl0JEcYA6UIqkENcu-S7bJBJO3vCfLSTzgaw>
    <xmx:wyqXaeCkaonE-uf8VySgU0QTNGD54npxAU7heS4W-qeY56OoeAWvtg>
    <xmx:wyqXaRfNBZUOdP5u9G16r8rxNPRW3VSnzYED5IF05F6WfM9jKG5ZRw>
    <xmx:wyqXadJEKAMbL5tnPK7jMl1uhXD5_unm46jqh6LFiPQiUad0GJDPpg>
    <xmx:wyqXaXLL4QPjgE1YwqK0h0RMNcvZWlGOIpekR4And_3aWqY2WRPA-rZ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 10:22:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Fix misuse of `refs_for_each_ref_in()`
In-Reply-To: <aZYGrmktI6vwp8Ow@nand.local> (Taylor Blau's message of "Wed, 18
	Feb 2026 13:36:30 -0500")
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
	<20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
	<aZYGrmktI6vwp8Ow@nand.local>
Date: Thu, 19 Feb 2026 07:22:41 -0800
Message-ID: <xmqqldgo7o72.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Hi Patrick,
>
> On Fri, Feb 06, 2026 at 08:49:55AM +0100, Patrick Steinhardt wrote:
>> Jeff King (1):
>>       bisect: simplify string_list memory handling
>>
>> Patrick Steinhardt (3):
>>       pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
>>       pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
>>       bisect: fix misuse of `refs_for_each_ref_in()`
>
> Thanks, this version looks good to me.
>
> Thanks,
> Taylor

Thanks, let's mark the topic for 'next' then.
