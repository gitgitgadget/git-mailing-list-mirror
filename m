Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63E37BE6E
	for <git@vger.kernel.org>; Mon, 11 May 2026 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469795; cv=none; b=KG/o9lrJCEdiRyHkFxH5xYWx0IH92QUwMj3b1gM5c61wLHWOOkb94rREktYr9rb8/7lS/MWd/NBFJ+W+6XqRTkO9777tInFgEANlN1d2UW3RdnNKfkilMbcjDfoboYQGfDxqNNWJ6Do4Vhop5YktZc+4DOiEJmikTyxr6llXxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469795; c=relaxed/simple;
	bh=MLPTi7wjEdpUy1J3NQtyLaFFC1q9530gO0IO9rFG/E0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qjS8jfTLIjSfmyCygDDVWNmHUhE5hDNoXouK6s7b+owG2YGmQgd+Rv3HLwmcs+OOHGClvIzm0PW0komYDZn2dJ7EoWoxh4qARzHqX2hWv1ziELUkzysymJ9exKg8SPWnsjnkgT2zRvL9R4Fz8jmabTsG8fMM1A47AxnObTQsGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xCmY3eB9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4iIwxhe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xCmY3eB9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4iIwxhe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C3AE71D000A1;
	Sun, 10 May 2026 23:23:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 10 May 2026 23:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778469793; x=1778556193; bh=aWcn5d6bwb
	agfmNx3RrKwe7M3byJdz0ptxiCfxQJWH0=; b=xCmY3eB9XXhem/zbZjAxspKuMd
	boJ5s+hbQDn1UlKCa/3LEx8BAkOMwsg8thViHSuJcrvgBeOtlf30JQjv8nFstKFu
	pJMJnjLzMFCNPWxQSA0eA2f1IA/hmI+05cU7DwXbUxXeu8eWRKEL6YKdrtN32x5n
	8HkHqLLu1E/hm8Sb1a5B2I8Rzj320PdOlXF7AgjlJPcQVQeBIVlaOAgqnw1LFdYn
	iWP5owDgduIKWUPXvs9wDD4bxmkCPbwcZyphiE9biWvrkMe75tu+6qb+VJ9jaVG4
	iR57gPdgtSKIL6I525RiB6ow3ngTw5Mqlxe4amP7rteNlyAe4PWeZcVDvS5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778469793; x=1778556193; bh=aWcn5d6bwbagfmNx3RrKwe7M3byJdz0ptxi
	CfxQJWH0=; b=d4iIwxhe4m83yXXlBkT/5s+e/jUQqejWZr8OHZbU7tiC36H+vES
	uCakByLCeqnEhH3N5wriWc02oix288eJ0BWm1BP8M2L+Sb9/9l2y/eS0jkELpXD5
	dY21LS2ztmpcH5FOrxbhuHThX53BFkrS0gCdnVsloMClHxzZbGP1elQO+i5fQRLt
	jyGPKa+dj5VrJ0gDyrSj8lUJpmOfUR4txCUlZHMoEQFm9kEoQ8BQwYwymZYEJ5GI
	kGmlHzbOIN8VlRRasoII2TRPEyuVFtX4LbzqCADG2u7OQdvbqLTTYo7kkg7PS+kU
	K5nyQtJShlm9S7nW/dAqMLFhqA8/NJlS5HA==
X-ME-Sender: <xms:oUsBasGf0-k1xAhpOD57fqdyIohM5IxIPNeNIJF8BpE0sBkA4Du4aA>
    <xme:oUsBasxiYAbHxlwVHEHcAxU9yztCEEyJUHX9IhtaLFuGycJShc9ZjKUkT32Yf3RtR
    gPJi2l5ch_cs2DSJgvN1A5DHVE-xAKbXihHh3c-fQ8a9_rz2xZAiQ>
X-ME-Received: <xmr:oUsBajhhW4DPqx6MSSl71y2j1uhXyAo-UiLtx0B88UI3ApMZinSwRg3mldWYrVgTnYuhRaT9SrtHVJ_T6n2jpD52Arbr8p2TGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfefgvdefudetudekteetveehiefgvddtjefftdekfeejffeghffggfeggeef
    feetnecuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oUsBanw4q9hUj1UgCYuIA6Oe2LkqZ8OunpCX4XapUTXDY7v_0dBZwg>
    <xmx:oUsBamLwVxrwprP1KnsJGrdfXjVvTjS_hoacPbrKdzfE2VEFZahxRQ>
    <xmx:oUsBauTmUto99k8UW9JtT37NrLx496Tx_oWJFq2MX-Nj93rWt8tHvQ>
    <xmx:oUsBauowwHCLMAjrzau59FsVL7gu9Y7xzSEqgHyLXnhkjdVjsoYJJQ>
    <xmx:oUsBas4mYdGAW2j8R0GTAHh1Cw76eDUEhmkz1JSYqplFiPDmh7XqovIs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 23:23:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] build: tolerate use of _Generic from glibc 2.43 with Clang
In-Reply-To: <20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im>
	(Patrick Steinhardt's message of "Tue, 05 May 2026 14:26:03 +0200")
References: <20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im>
Date: Mon, 11 May 2026 12:23:11 +0900
Message-ID: <xmqqzf26sk80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Instead, work around the issue by not using -std=gnu99 with Clang when
> using the Makefile and by disabling warnings about C11 extensions when
> using Meson. This isn't ideal, but we at least retain the ability to
> detect the (mis-)use of features from newer standards with GCC.
>
> An alternative to this might be to simply bump the required C standard
> to C11, which is 15 years old by now and should have support on most
> platforms out there. But some more esoteric platforms may not have it.

Wouldn't the approach you took on the meson side to pass
"-Wno-c11-extensions" be yet another alternative?  I think that is
what the other proposal (which was only for Makefile world and not
for meson world) did, even though it may not have been a great
implemenation to help only those who use config.mak.dev

   <pull.2291.git.git.1778120192298.gitgitgadget@gmail.com>

We would need a patch to apply at lesat on v2.54.0 but possibly
older tracks if we plan to keep them also buildable.

Thanks.
