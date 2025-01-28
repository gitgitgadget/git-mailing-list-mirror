Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE51B413D
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097447; cv=none; b=nyHqPKbZHMsBg7tgyoI8ebAhJ+4vFW5mfc+CLDjt/ynhDahkltNsMNnALW+K0vrB+6KGEQkIQh9nMIVpn1XxBDxUMUnra+KldwwT/GH4k+XRVQfd6xFzm6t6gV9Tanyp7QtQ0bs7lRYAOZAuihoka0SAF/BvO/TwQ7+TMjb/28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097447; c=relaxed/simple;
	bh=UgeJ739bHdaWBLlYxltjlyMIy3a4jQ4AouJpanhl3Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kD0fJy5ltSZGNqY8eHI2waiNhWDhLgDXcXMgBIYA/w4g9w0LqQVhTqlvm6C4MejfCMZe5WjSPmzbuZHVDDwd1NgklVm1i/ejOVDd0zA3xNerlyMLXzZepGqkNaYmBhoYLu3MJfAanIPQz788wcVe1j4pFbo797d9qJvu9IP5XHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bUJGTeoV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+9A8sP3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bUJGTeoV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+9A8sP3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 853471380C7C;
	Tue, 28 Jan 2025 15:50:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 28 Jan 2025 15:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738097443; x=1738183843; bh=6CQm8FmorE
	kaM+Kx79CkhDpnqmQpmUfBKOQ7fSXkr1M=; b=bUJGTeoVq2R6zPaRrbhWXYcNL4
	ZzYl+royCb9xGWiWVjdJPqKrFNG/n2aYs2p1d9RMEKerfTNVJ/ZKA4p5aubhd0bB
	jb/Wxf6OEiLTyW+7LRTdVWkPjOtIhznpbzMOAB9T4zWa12aObizYV3KeSD5eui53
	eBMKsjGiErPzBpHF/wyPh4cMMA6cQm9m1gB5QAyWLPw/+wHaISYeGbvutk47x3XI
	EV/O08rZg1yTGEYgA6gQaAoFAl2CyZ49hkuBta9Q08JQT3GqFqvCE4mde4CvJkjM
	qgPRKG8s4SHALSueFiysU2Zom1Ow13KmDy7DEL/9cmvd3l2au3BxUyFS2xnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738097443; x=1738183843; bh=6CQm8FmorEkaM+Kx79CkhDpnqmQpmUfBKOQ
	7fSXkr1M=; b=j+9A8sP3BsD5HN8w5XqsJ0O4P9uoZ5L7d+fXId9MYF4Ag3haqUo
	IqnzTQG02GjPfdPiR02M1CbJC2mtw8rXc5wer0QYqiFnvt9XgMvdsALggA2CgKAC
	9EHXoJOXWbhEbLgyWib5/bsPiqqp7TK6lf7iCemSMOi+qdHcRHe15vu79Z0gzg1E
	VY8SqNF7Km1DTRzmTLRoJIkF8JbKI8dBSlxLorc0fOwVjRKRq00JOjMWLmbh2ums
	R+M38Axlm8eiiDDL2BTM7lDjnNjTEXXZOidJpwKuete2NGduMrWvoJgE0WeVRyLw
	eG76Y+lNzEMJMkqlkg0GzV7PGxICtFsW7NQ==
X-ME-Sender: <xms:I0OZZ9wKkKEo8F10hePpAia0TuHTDNFhUSO7MRCkOHGzo7E3QOnuCA>
    <xme:I0OZZ9Rj3EbcLPurjhB2kO0yjcHfhGkfvBfpLD1G8U_AA1i6007C0uHzfmSlqE2xU
    WZNN73AkJUhENeSSw>
X-ME-Received: <xmr:I0OZZ3VRVwTN4ZHm2c_fDgqdQEs-wYdpUkBdp5zRIE2PY-dsn95AP6ttpUhXmGpUh42u4XzuZnACmTbc6oRIpkPW-ZQHsoNhT2pj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I0OZZ_g4HB9jj4XEe87MYLBApMEcxAV4bLVgTczAY6K7QHaGCAixMw>
    <xmx:I0OZZ_DVFmuN5NdQZQBdVlbZr3T7fb0c1alyU6ZeIG9VU3e4IOAHSg>
    <xmx:I0OZZ4JTFffQKcumQ1tpMrx5MzsYtPHXaMnMR2lY-_ZpBFvptTNKvA>
    <xmx:I0OZZ-DrkIdCrv9i2O-ZmPsBBiBfbsgn3_vZUFyF7cTVSzLn3Qtnrw>
    <xmx:I0OZZ67Yh5Kj9KB0O-MaKMRlic8DB_K3MuLBsC5eZ0UjjeltBTQgOS0o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 15:50:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/10] compat/zlib: allow use of zlib-ng as backend
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
	(Patrick Steinhardt's message of "Tue, 28 Jan 2025 09:41:26 +0100")
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
	<20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
Date: Tue, 28 Jan 2025 12:50:41 -0800
Message-ID: <xmqqv7tymzmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v4:
>   - Add a comment explaining why we can stub out `deflateSetHeader()`.
>   - Add a comment explaining why we have to cast away constness with
>     zlib-ng's `next_in` field.
>   - Link to v3: https://lore.kernel.org/r/20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im
>
> I've adjusted the series to be based on top of fbe8d3079d (Git 2.48,
> 2025-01-10) with ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide
> a summary of configured backends, 2024-12-30) and ps/build-meson-fixes
> at 4e517e68b5 (ci: wire up Visual Studio build with Meson, 2025-01-14)
> merged into it. This matches what Junio has in his tree -- sorry for
> screwing up the previous base!

Looks like this is getting close to the final.  Will replace.

Thanks.
