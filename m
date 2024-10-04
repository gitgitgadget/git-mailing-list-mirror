Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087B1C7275
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058939; cv=none; b=rEMfmVrGmaRBNukTC0wb/YIJwDFXzedPO6cEXHGGKHlO00KC8Q7kZVL4M0yYWKyQg0uOJ+we/vRkt98DUCPXXTrl2TxQ+VjLjz2/xL/KqBryAN0hRBd8Y0pGaOwSBEmB6iNeOf9mnD3IkffYhq10VyBwHW+onwg0LO2mAsiPIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058939; c=relaxed/simple;
	bh=xyjuqnJgBLzgbG05RAPBvaVHVIWCLQu3zo8cVKjF/wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t+kpCLZprUFberiL2zZZBjlYqIm/iWOWaZrmH27hMKX38VHWzKuRDU78uhkQilgp2sVxXTlrRno3KIUf0xL97EwjVgx8cGk9mLQ3SSmg3bduLesw2VqBj2Du2pBkYF7XjwVMQRXdwbOoK3IXGOpk4LpvcbpqT4tnWF8tWczFHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oycFADhL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SG0CPcKh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oycFADhL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SG0CPcKh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 72EA4138029C;
	Fri,  4 Oct 2024 12:22:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 04 Oct 2024 12:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728058936; x=1728145336; bh=xyjuqnJgBL
	zgbG05RAPBvaVHVIWCLQu3zo8cVKjF/wg=; b=oycFADhLJ+00t2clNwX1C3v3Nf
	r6Rwe3r9LENRl6dZgLtt57rBsxZ+HACmB2gQuSU6ri3d4LH7h2tfcQTdzbQs9vXd
	LH5JbiDS/5dwot4jlJozjvAnKiu+/YK18h6DPod2wOUETB0lYRxD5iUj0upSk4yD
	qIwSFwtJN+2A41XoP4fGXFwQN71Eda5FHvGlYj7cbZuBvu0Ep0EEXHtVCNt119aP
	zxAqh0cjj4ZpAJF3Vh9r60h5iuVvabaqW55VX53xUUGqzPnng47izSrpD3u+kUkd
	ljk/NLhUtHKYS1PjaxOWAVc9/saaJYugx1ZKfzLv5SDRANnLd08bBXGO9RTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728058936; x=1728145336; bh=xyjuqnJgBLzgbG05RAPBvaVHVIWC
	LQu3zo8cVKjF/wg=; b=SG0CPcKh07N/2OE4DU3dTc+ydN38v7qlKXWS78QOrNKe
	uV3J34/H/4SrWV1EEgdCy06UFm3CRTfMgfzNyu0IZO6hSfgQu/t5yfUI230I/QrO
	aS9XaFyRZvt2cgbfLO5yCIrV6MvnAKlIcP12Wh6EE40nIAInhz4PF3Hh1VwhWL00
	e1dcDfO+LmhkNcQTnSeegQde2wWUGoJbK3yghCn3lMHWgClQwx/hOmEA20q6ksJm
	Pu/dh4pKsIZtEnrMGjtVNQyy8jxCTf7+JHvqumgdXgn9EJ4vLoXQQL78tOuo5zsV
	hWlh6U4uixoJ2esoMsw/YY3DJNK2ga7/1DQOWUXhWQ==
X-ME-Sender: <xms:NxYAZwezmLuTzq72Jc3wLENoqRseU7XTyW2Itm5_FcHDxduMMutEUQ>
    <xme:NxYAZyOgRnVVRNzbPkr58an_4NFClUx0AbOgWu9JdiNcR_CBhFhsY89BconqcpLyd
    C3sfz1ZlqQDwfoMTg>
X-ME-Received: <xmr:NxYAZxj5lVRsDUg594_I6Unxt0oWMby1XdhYihRUKKv1n6OByaYB2s-bpvVRokc0bhxv-cenbFfRqwVEmDZ3MrBcI8klTTpyAM2wgh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NxYAZ18Lqng5CSJZjZR3RgUpjRJgVNFMd-d9iryAhGqPqLiD6bOfsw>
    <xmx:NxYAZ8v1dUD50xwC6D0DBQwc_vCA5p-Jkjr8iOtTkru_6eJBQgZrXg>
    <xmx:NxYAZ8GlGI-GA5sEkHMq_AgjGi8nsJg5yG1bressu3GUXyxdpoYiRw>
    <xmx:NxYAZ7OK87AveL500Y9fFyzqL8fAh6UdBlv6cxug3yf2qN3N7ULHvg>
    <xmx:OBYAZx95dPYn5yDnNNGSwGtuXjs4Bv87NZN7oHVOaJ5M1AkNQ2BsBFnk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 12:22:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King
 <peff@peff.net>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] t0610: work around flaky test with concurrent writers
In-Reply-To: <f83e23f1e76454a80e3e53cd02b3bb5bba6b8da1.1728044178.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 4 Oct 2024 14:16:45 +0200")
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
	<f83e23f1e76454a80e3e53cd02b3bb5bba6b8da1.1728044178.git.ps@pks.im>
Date: Fri, 04 Oct 2024 09:22:13 -0700
Message-ID: <xmqq7cang7nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This fix can be applied to remove some of the stress with the Git v2.47
> release pending. If would of course be preferable to find an alternate
> fix that makes MinGW work as required, but if you take the 500 lines of
> code that is the rename(3P) implemenation of Cygwin as a hint you
> quickly figure out that this is a rather complex problem.

Yup, this is good for 2.47 and I agree it is sensible to punt the
real solution after the upcoming release.

Thanks.
