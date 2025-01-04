Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4F36C
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736011611; cv=none; b=VV7RVs7zZjLMJFl8Pgsc20XmK/MPvHdbetNC6n0uUdiVmnDidu0aCrgP+GwpTkdFEAL6i3qcCcN2dIsqpO/Vp05JNjKrPFKmQqy67jWExaw9WKIUaeJng/10fE60epXntKjJlu9PFhjOjJJboUPC7jVNvaupVrVi+sLBnC1cDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736011611; c=relaxed/simple;
	bh=r9Cj+CUbLxXS7/pajDbLbXK0C+mxUDiQZBidrph7l2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cBmyPxIlhs/9uzN5ZdnRAOYNIedwqFQoipn1WcXSLDPJJX9ibTZyVMF89BNuFKw3xsFGjimV29/W7dDzooDQJpmE63rTw9CnYDxUSf9Y3zX/+dQYwGqTpXdisPoBz4bwj0wDX6NNtNF882nAS42IweCnh2ma65As5X523LhdDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oEkeXJum; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yaf7UHSv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oEkeXJum";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yaf7UHSv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D113B11400EA;
	Sat,  4 Jan 2025 12:26:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 04 Jan 2025 12:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736011607; x=1736098007; bh=d5iwIFQ886
	yR1LlX90SArCxwKq4H6/lTY3ryzuxn7xg=; b=oEkeXJumhuLAyXt7fUhqeqh4Gh
	ZEiCokwsk+1lvXcLUX4BKDbdBtMIcHKMAnaq5xsaZqueazC00u0Uv7kcqJY/oaHX
	MEfloe19zTwZdigWgldfUMGfjS0499fx2AN3irdPybLyvLyAZwyDi2efwgVk6q6U
	5O/LNDFWgoJdIbBzUr85ELoGC4v+f6oeYb5JJUDsSG590wfMQaXpDX3o7zTVnn6v
	m/Nr90dwoKtlnYqbpvxOwOQas2zmvlXjLl4CZpK/ZSLeOJfQyOp+IgLCdmj1D6i9
	q1e2aS5g8r76OTi27p/512YOnNnXsUzYPi6EpnEQf9PNZRaLgD8rCygk6oIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736011607; x=1736098007; bh=d5iwIFQ886yR1LlX90SArCxwKq4H6/lTY3r
	yzuxn7xg=; b=Yaf7UHSv3XPsiNoqrfPveBwYZOwWfFScfBjGS3czftQKmMUKkun
	Zt+mvIjldRbV5Za2EU2XzlQaAm5zfHaZVKzF4b78kUnTfmX4Oxq+HZUiuB1i4/mM
	IFgNwSrJL0EAdMka0nnVjXjJG07qE1A36Em/Ntc4rP0KAwd5k7O6XSU2AXACp1wn
	EwZodzmtvNXPJvRa6DgA0XDBt5hN8OXLzpYxMuTuCBJnjN04NFVzYAaY5g/lAfgv
	MrGJygZpAQ5WlzhKswqhkOWzM3I/eb9D9IoI7GfJDG6VpwzdciRwkkxwgpNK8c4K
	RRAs/AeTcVbQ7t71TbTUayfJK3VweTX6fBw==
X-ME-Sender: <xms:V295Z5SVdNuLtCIHZm4n8JjP7CwI87Z8zla3dM3PjvxpSEjuI17bkg>
    <xme:V295ZyzEbLNJCf7Pa71vv_oy7goByNUNNv_H1oB5C7ePDfa_iCzuB0xKm6tdA9jhU
    LUvDFWbKFw6ZwAb1g>
X-ME-Received: <xmr:V295Z-1mfxWLejbLFaBEQSi5f4-OhJhxVzF9s0TXj2rL8pVDEeyl5zu_HA_wfab96e-_8_OLp5JdI8s8-oN-wf2PSatDwcfWs3Tt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:V295ZxAtF0vfjm-1VXPKuMOUj7nLd_1PUZMCQ4oa1SX1Rcfu_ovUbg>
    <xmx:V295ZyhUXnIo5dF8k8RjCgPuBqAZTBFr9qnc22J7kpla_X6mzCaZ2Q>
    <xmx:V295Z1phjDcIj4up8dzuS7Np61crsqh8UTjB2mNp11rvnUjitnzIVA>
    <xmx:V295Z9jg0QMnh6WdMsBvaheVe4pAqDxJd94lUmGii9rLNmROejlifg>
    <xmx:V295Z0YRJIlcXzGf5huYlccW3i4KCf9Xmk5FkmgVQikp1cseMg5vDuB7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jan 2025 12:26:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] object-name: fix resolution of object names
 containing curly braces
In-Reply-To: <13f68bebe90549ba19452f12abb6fea41c2517fb.1735949870.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Sat, 04 Jan 2025
	00:17:49 +0000")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
	<13f68bebe90549ba19452f12abb6fea41c2517fb.1735949870.git.gitgitgadget@gmail.com>
Date: Sat, 04 Jan 2025 09:26:45 -0800
Message-ID: <xmqq34hy4hii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	for (cp = name, bracket_depth = 0; *cp; cp++) {
> -		if (*cp == '{')
> +		if (*(cp+1) == '{' && (*cp == '@' || *cp == '^')) {
> +			cp++;
>  			bracket_depth++;

Checking cp[1] before even knowing if cp[0] is the end of the string
(hence cp[1] is an out of bounds access) smells fishy.  If it were
something like ...

	if (cp[0] && strchr("@^", cp[0]) && cp[1] == '{')

... it may be a bit more palatable, perhaps?  At least writing it
this way we can easily scale when we find the third character we
need to special case, hopefully, but again, I do prefer if we can
find a solution that does not have such an intimate knowledge about
"@^", which I just failed to do here X-<.

Thanks.

