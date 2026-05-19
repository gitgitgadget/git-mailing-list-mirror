Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28639DBF5
	for <git@vger.kernel.org>; Tue, 19 May 2026 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234480; cv=none; b=RtAlTriT8LTZXwf2cDFsNQVWxcd+PgP1QbKoyCS91ZBzePorzPIRQK8cFmyZGq6hEwO3fbWRUWaz+A44Ojlf4WaQIWSBvkp2S+RJoMNjvE4zFtzwyPxAReounkPbmJr0xTD6uxyaIcBYDVmAXjtYO00MEcfMpvF/NbCZd6xfhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234480; c=relaxed/simple;
	bh=XkIJQtFx/dXijlYJf1dV9RDEizcpSwXAKex5FQHEoaE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fJhINl2FvUpAlOBZ/HgjeEW8aMs87iMmQoE2SELVCxl0B2QHYojOwOaDa2+mTjczHCXXsqWzrYeoOOSAmn6amgZLSJm73ul+82BVVlHaIuZYi+NTSNILaJw/WxMsGMsKd8yYMXbwk2Tp4re7wAFnkKvc+14VauaCcxG6nvr5cpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AXhvK9lj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JygbYv8P; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AXhvK9lj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JygbYv8P"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 777657A013D;
	Tue, 19 May 2026 19:47:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 19:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779234477; x=1779320877; bh=/6zcZRYJbt
	onG7M8d665pQqu45NTv/RHP80M7GP/Og0=; b=AXhvK9ljSPtEuCwb2rakuU8TkZ
	ti2QxN28zbxT2ojaVd0YewL+6idb4MYYLu89dEzoSmikziHNVl1qI23qRz3yXniH
	x9CjchDy/s7Vbs1Xen8W+wYBR+V5k/ATre+FQ7UX7X6zWgqRjTaWyfQPWbQBjGK0
	ydjkvEoC1X09UuohWDBzKhiTnRgQcWReFqPE3TwHiUgEvhYanEFIOOKYPxmNjnir
	EPpga5Nn0dkrKkvs2zHjlxwQnkjbRV8h8kmJnIxaINMMt4sTFmBtEEmSBs0XkC13
	2vd4ewQFYI1jNcRCGFaEHsessQxpytF3byjQ5KbxQnrkogkaGLZ060nQcj8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779234477; x=1779320877; bh=/6zcZRYJbtonG7M8d665pQqu45NTv/RHP80
	M7GP/Og0=; b=JygbYv8Pbq1yIwiU1xjzRwWJIPWUjoqunrgqSTAZ/0BV0x3FGhl
	lRY5B8XvNF4x7FR+eFfoVWRkTNfGLoLGjr5aOVY0Z4P5On93sulUmXKxvILSr3qD
	Pkpgf4YglbqwCbp4tbAP53x1lVCfFl6Z6JeIxh/CbQfN82v7upgRgIPln8G+ZSxe
	hEXYbHrKbK40FbGMgdPP5m/B84Jkt4SJF+clEmakaxV8C6fC2z7Xukk4wBWc8ElX
	Q3gKVctqnp44L9McQfLdDHcAJ1PwkYN9YCEXUYJumN3LXSK/SmGVH23CiDvDXtIO
	yujNR6mT3d/VAFddYATKnSzo+po4aM/sETg==
X-ME-Sender: <xms:rPYMakPXoGhXfH7FNq8V7LL1SIG-3B5Qzi8VZ30k3sHAbaJLrYFwiw>
    <xme:rPYMatPdc5j5VGixrhBG08KusSKS8CDlIlVkzPqMlkMVGX7mFofNfKYCu8t-x2Y45
    fz7VgUYRzH1uL3LUgScLikmPPCFFk-vTnm-jRgZvGKlQqEsgYa_Rw>
X-ME-Received: <xmr:rPYMatjgaGaCVAXKmmBrl6xGOZAy8MBrTvML1HB4X2kEv52Y_cHk26nnG9Cf8A6Ytj28QNbRvFn-sFDRK-D04VsZPmvr2GCpEcsrVsTdMuz6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhdrrhgrmhgrnhdrphgrnhhtsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rPYMais6efr6UlrtQRJ0AmggCD_jqob4n3XasdSd0hYBpDG9ZxGkHg>
    <xmx:rPYMarQ6OcE4nb7hJgiYLjb2eWXX2f47ujR8ucpSkNodXg06M3Ocyw>
    <xmx:rPYMam0WWTgMKjeC5mnqnxq9cXcAaFLJAGcleffOsF1UOlZEgytffA>
    <xmx:rPYMagvWaq7mh-Ou_jT865V9-Wr4wfSsgAZ5udeyf83t6uUjgnILOQ>
    <xmx:rfYMasAAM7Oq3SbDUObrkkkwnH1plJGzihSiN4RdpRZCSYWeudEWisv2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 19:47:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/9] Documentation/git-range-diff: add missing notes
 options in synopsis
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
	<290fe06d81e956253d3a06fc1e16848e0b86b603.1779207350.git.siddh.raman.pant@oracle.com>
Date: Wed, 20 May 2026 08:47:51 +0900
In-Reply-To: <290fe06d81e956253d3a06fc1e16848e0b86b603.1779207350.git.siddh.raman.pant@oracle.com>
	(Siddh Raman Pant's message of "Tue, 19 May 2026 22:00:30 +0530")
Message-ID: <87v7cjq7vc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:

> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
>  Documentation/git-range-diff.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This has nothing to do with "external notes" topic, no?

>
> diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
> index 880557084533..5cc5e2ed5673 100644
> --- a/Documentation/git-range-diff.adoc
> +++ b/Documentation/git-range-diff.adoc
> @@ -11,7 +11,7 @@ SYNOPSIS
>  git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
>  	[--no-dual-color] [--creation-factor=<factor>]
>  	[--left-only | --right-only] [--diff-merges=<format>]
> -	[--remerge-diff]
> +	[--remerge-diff] [--no-notes | --notes[=<ref>]]
>  	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
>  	[[--] <path>...]
