Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23D4C81
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743310611; cv=none; b=FS10MflcR8x2va3ry1nj5nHaQmzEbEb+B5eHrSV2s0xwce7Q9rQCTEhr6mwOY9vO+nydbI/X1fnboDQ3dK7J8cOHFNYjAMWUNKe1LcE89WEGOcpcoJDJx9dVBpKBUgY2IPph/kbcnQ5ClU9kPR2x4If8xKORYEJBy0jei15je54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743310611; c=relaxed/simple;
	bh=VvsrzO+CSpTBspflPgJEYU7JUS+G3G199CICOgSxuYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcY9mip5L9n4QeVzmvr+jEunHCBVjYa3EuONRf42mS60kVOov5tyc8b/74WQB1H49DIfhFpw2loKcBKSSJ7JSnflvIIXDrd+qa330a5k+xV+kAig4JaTkcm9yo7Mx0IRBXlHmi5C2f9DlMAXCat5DZeJyyArkxkpVbFd2GVH0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+b5PenS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mtwSIA/P; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+b5PenS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mtwSIA/P"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29743254011D;
	Sun, 30 Mar 2025 00:56:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 30 Mar 2025 00:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743310608; x=1743397008; bh=J6O/wX6i4Q
	rArDq4cpEvmN36sH6P0fNZP5bQ0W5Xz9M=; b=L+b5PenS13DFpnOQ74qomkvwO0
	3ogjP4dnUfeTnSWn3ZAN8efe3o1w4n0ZmH6DN7ZdeD3B1mYkbS1US+FQyxX28qU4
	N4zLCdZshYzd77j38mQswgEjoo065JBGQYB1e2S4yX4QYsr9nDHH6fpC5sIaM95D
	X0OHnnHoRaVVNwhBuEsq4AvilZFoj+UNQDxJrvUlsdnZ6HhQRzUBY5Gg2vR+nCo2
	fKA0jMro9497gjKMgkdwFFFLA0CwaC0u2dO9CW292i8sJdCI0ad2AE3H3glJymGp
	21AfGAo9OexfG9bGPgBoQ/6ilqkcyBhmGsoVyP5WTmrXKKK+flqNF0AXe5Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743310608; x=1743397008; bh=J6O/wX6i4QrArDq4cpEvmN36sH6P0fNZP5b
	Q0W5Xz9M=; b=mtwSIA/P7UTNlXb3d2D05N9sNQdDxABfaUUcziqCuUFj/yPXKAK
	LZ1NApH561+S/+v4Lf031Xqk/yAS6eAgHcOBA+Or8NGwomTIQtc1lN360UUJ8X+Q
	zK4vK209KqeoaIm9FQV1BoJgDSu/9xM/X/stRqE3KviciPAM1YhztPDiKlLvlVWL
	7+OAqzBD2K5sQACNO/WF+Zpf/l9aaFHGys1iL+czua6IzAFZw9MIcJ9Qr9Xzrw+1
	iudPcxFzniWZazv/ecNu/QMkOEAF1h8TpRRZWY8pHMa0oU39bbuH7LO6tlV9phJC
	FSwKmb+RBeYfa4OT2K/o1zm3OMns4c7GX7g==
X-ME-Sender: <xms:D8_oZ4klp1q5-9PEcFLH8n543zjsJl0cJc6ddpUr0xliqAWEkSOdxw>
    <xme:D8_oZ30tJnUdCScxNPhmv4u7ElEGCpTULT53tryci9dr9e8U5xKCA19ePhq-Cy16n
    8a9zHee9wJ7MFA-wQ>
X-ME-Received: <xmr:D8_oZ2oEvHoawSe5Tg2OoRUpIioAyUev2B9izqor-j--Sqij50T7mM-dXIOXYswX6nT_pYQTVHQIrdc0Yel35z3Hp8cvwPbGGDkRhAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:D8_oZ0mJoHBA1l212az5XP_c6Hg-KsxNMdB9nL8nYwyka77rVd2xVA>
    <xmx:D8_oZ23OQUnMj1Ej4CoA4YK5klilzarvNGG5giso31yFYTVdMxEbfA>
    <xmx:D8_oZ7tu3aO4kx1p-6FKGwEynhMtAkqdCGXRRejObPV4ahUtiJKhlw>
    <xmx:D8_oZyW5xWcaAgZquuAQDC309jUzmTKpEy6i2hAFNwXo8a2Lo1tO3Q>
    <xmx:D8_oZwr_PGDyRpsKOuJ6OF7QvGaGPJxmCQTRYFqD0wKCBlg8_E8Ub7JA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Mar 2025 00:56:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  sunshine@sunshineco.com,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] blame: print unblamable and ignored commits in
 porcelain mode
In-Reply-To: <20250329-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v3-1-10f695ae519a@gmail.com>
	(Karthik Nayak's message of "Sat, 29 Mar 2025 19:21:16 +0100")
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
	<20250329-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v3-1-10f695ae519a@gmail.com>
Date: Sat, 29 Mar 2025 21:56:45 -0700
Message-ID: <xmqqecyfazg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void emit_porcelain_per_line_details(struct blame_entry *ent)
> +{
> +	if (mark_unblamable_lines && ent->unblamable)
> +		puts("unblamable\n");
> +	if (mark_ignored_lines && ent->ignored)
> +		puts("ignored\n");
> +}

Doesn't puts(3), unlike fputs(3), add its own trailing newline to
stdout?
