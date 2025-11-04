Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECEF2D6E48
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299941; cv=none; b=XO0XVeF6SqJSYs1cd0p6JHenlOol6Kd92oSspgdmZVraH+8hba49DO7O0VDoiAEFVqRzpNPodXwxuRVdGDuIFTvSKt6G/ecuChMD5tO72awoHSsmGsqpvJXV9dKo0oHnK+vV1bnrpJN8ASSApdMn3w/l9mmAjNdxYrbtNruGmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299941; c=relaxed/simple;
	bh=NyyIIyG1HInH77vh796FSkGvrHEIR625fu7VaOBCgNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERv7WVtGGwNGOFDTTKi/CZY6MCbfPtCdF0cFgO7q2sy95JkMiGr37Wx0Jj5aKCjuvEtvyLzvHpkWLQN/ADYBfFhDCVdkH5OKTxI0E7vQeZSxKz39pj1qvPAbkWKUXsry62fInrNvq6LuOL8SqV3X2coKWGswIJlm6CeLnWX32R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FKapllZF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0WZpuaH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKapllZF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0WZpuaH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 816B3EC0596;
	Tue,  4 Nov 2025 18:45:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 04 Nov 2025 18:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762299938; x=1762386338; bh=jOJp381YhO
	TpLURrGrESTgr4TaonBesTb1udMrgIaAI=; b=FKapllZFpPcg0qC8luh5nuhWCq
	mgbEGIpgBZdpgwuDcogWA0JCJNlLKLnSDWlWDQBvdT/O6cRWHM6OA198pQVco9c5
	tr3VCh8x04j5MWtzxPvUyzdp0PZ3C5jdrw18/65rfaxxcRy+9cUDvKtPbAWD0O2c
	a6zRgJT2Np4qCgPHWFsuGD1sKwoRqwjd5jSFqB5xbzeY7DBrQ+EvLC4y76xQWy8t
	e/1YAiqmSPcwVR7HC2/kSJ6Zdj8kAwdRi3ja5OhtBGcDDJYtBOrD1WCYQ6iu6iAd
	sf9x/hf2EH7P/bFLJ8MbAhG2/RaHTOBe0RJtJXzrtJ3YDgcSJL0VmJIxBL8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762299938; x=1762386338; bh=jOJp381YhOTpLURrGrESTgr4TaonBesTb1u
	dMrgIaAI=; b=C0WZpuaHH7nD8bf7TLiU1mv/df/KKGfiT8KsMTzitzFJhCHsBZm
	uL2r0+AKqP6QDPJsMTjIEYVZ1S1yQRpqAV5y00/QLeYH0rhY+5OoPXJbAhaAKbgu
	fnPSN44OhLH2W/hBYinXX03wXyL/tXIm2CaS1zG//6K5og7XszgZFZQTxrQXBDBN
	5Ul2DBU0eejDFgxJo04BfGbdK2YQSy52AlmNtgeAotU+xqgrSMjGPV2uE1vumlfe
	/Dp6u5DB8elaf2CCFsw6dPPPwH6Ty00e/00ppcLdktWefdBb1U4O7CTa1M+D02UX
	5TJMwZdvg8/OeG69KJtCMMHFFMicX9eW3WA==
X-ME-Sender: <xms:IpAKaW60V4M-6bPVI7fl30HAO1zFztyaw7fgAGGVhaLm4b1Upuy7gw>
    <xme:IpAKaSKrqHC9Vprx007EL14AMd0BNV02LBvINUCtNoir92PcQJylXEcNnhMMFXbQA
    KrZpHrwVkrRaEOicPWXn5cUhwrWdEdut50jILO1Oe0RBclqnJYb86A>
X-ME-Received: <xmr:IpAKaXtFLayfClk0pCbsBO1tzLT95wgj-MlQy04bsVG6VCkMqhei0z0-dpNo67uweWos4DpTHWYCygVeUuXElO_5BG92ePEcYOVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IpAKaZKFxkFlAWtuoYn2H9Sv-QkjsP12nV8qcSgxzx7z2omOlsrtOQ>
    <xmx:IpAKaY_f1GOOn0U2qej5RRI1o0jh5mzVX26jMS0caCWEKuv5Pz52pw>
    <xmx:IpAKaawJny6VLji6PG2cfRkUuLmyk7bQNVnDsZpiS-V6t5GuzljZ1Q>
    <xmx:IpAKad4B0kIklCAgtBYWnFz-zHqfWoM_fpUV5vTaoecdOPCQd-nQ3A>
    <xmx:IpAKae8MSjcPVTfkxPQpI7UWldmGUcQQQYIfbaKXYakjF63TFiJNrMUV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 18:45:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
In-Reply-To: <5ac4f09e-927c-4125-adea-f7d5ed3d1caf@app.fastmail.com> (Julia
	Evans's message of "Tue, 04 Nov 2025 16:24:48 -0500")
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
	<pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<xmqqtszf2kro.fsf@gitster.g>
	<8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com>
	<xmqqpl9yshrr.fsf@gitster.g>
	<9ff9d97e-2fae-488c-990b-cb574fbe8c71@app.fastmail.com>
	<xmqq346tpliw.fsf@gitster.g>
	<5ac4f09e-927c-4125-adea-f7d5ed3d1caf@app.fastmail.com>
Date: Tue, 04 Nov 2025 15:45:36 -0800
Message-ID: <xmqq8qglnyzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I do not see the point of implying that the commit ID is not "special", or that
> it's only one of many ways to find a commit because to me it seems very special,
> since there is no way I know of to retrieve a commit that doesn't ultimately
> end up using the commit ID at some point. (though that ID might not be encoded
> in hexadecimal)

That is not what I am trying to say.  The hexadecimal name is the
most neutral way to refer to a commit object, and in that sense it
is special.  It is the way ref subsystem uses to record the name of
objects, and that makes it special enough.

But that does not mean that the name _is_ the object.  The
hexadecimal name is a way you use to name the object, but is not the
object itself, and the special-ness of that name does not change it.
