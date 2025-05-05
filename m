Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171313DDAA
	for <git@vger.kernel.org>; Mon,  5 May 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455596; cv=none; b=PXELtIgaXCN2Kw1l0TDeKwojtFmt3KznVaUcNOZ/aYq7e2litL86flF6Be/fNG7rh3atJ+Ni1nP1BtPXNurn+CJVFzdfw4LrSAfuT1l+cNNT9vErS0iqmGscpZ5hs0mZ3MlLcIH8chtwZzJQFEzT867oCOQcdENRz+Cy8oapfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455596; c=relaxed/simple;
	bh=v1w7MJVYAzpjpmTUFNnBWIm/3jXHyLXJy5nOyj2x55s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj/lNhOlBdTVc5Y1ToUnoOHic+mxuIi5lKRskascGonxxVA91zHjhRmY/AVfv+2IxxHk6ZavEerFy97eYL7/lpWnNluUBtndIwCqlLdeGrRKxHqnh+/enM2Kk8XRVp4c7cHwRiJruidGUyKpqk4EacALIrJuqJC2cHnIlA3f6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hOGfjHyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eR4EjHOV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hOGfjHyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eR4EjHOV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AA29B1380EB1;
	Mon,  5 May 2025 10:33:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 10:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746455592; x=1746541992; bh=g/DSGvmpUK
	fwvIXQxcnF9H7OjVoP8hfQRQ+Fexw9bI4=; b=hOGfjHyd7H7AFAJMd4Vwf4PsIu
	V34PEFk+3fTifzfU7TD0GkgnVcw6az7r94H8AlL/JM3IiTOV1On23Vb5dnlvvpmU
	52FF9C/ozB0aFOXEJvfw+6YL0jbObdcmLBvEdHixi/suzJ+rCvhA5cSAViT4wU9S
	WiDTDicZ/LvHyiwA55r6E8nryTHlytJO5wqycfzDG3RS0pXOe4PytySZnFcrWQHh
	PtE+a+bbzZu9ZAYLX9iv3PE2FKomvD6Z+xcIXPGZ+emTF99hs4KleVTA8NWePL0B
	Al/GIKS3WqC/FFAOduHLxsPn7VA+srQ1pskhfa2Udb+uY/691TvDdnTl4wKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746455592; x=1746541992; bh=g/DSGvmpUKfwvIXQxcnF9H7OjVoP8hfQRQ+
	Fexw9bI4=; b=eR4EjHOVHZWvdRHVLoszISFpfRQVXjJgWrKGLmrSiLtpGzWsnqn
	5TesWxhwBvku/T5N2fc4fV12HyZWLFKiO6spotwOnXxtEOpMLwrtFOSKAnXLQIIP
	z7zQYtyTOlaMINevCLffHzt/3kF3wOZ9EHWlNYRGRvCqdoKJXnA2e+qgaIVhEKQf
	wLZtktIeG4Iw6socXObOuo2A6m9u9w2rTCWgZlLwlEHhIYEZ1RgthCygtmxa9fMf
	aSi4mpUUr8whtcc43oIG1Ta46aiA/+XnQCbWKA6rArcW0I6Gh6EReVjM65JKgcMN
	DSJTI/ER2eh3+7llE1WEp0tJYHlgvT8LGNw==
X-ME-Sender: <xms:KMwYaCwzpoOyYgQj4asQ5XLa4Jizt0KxvHpLJnrPGvhaQO5DipZJog>
    <xme:KMwYaORtQ_zExXziGWKwqCU4gNwFpRYhovyWiypGy79Hz56X9HBGntovZR63W9erg
    RI_evTziSjxM-Mj1w>
X-ME-Received: <xmr:KMwYaEX6APuv-ZBuk6G8doDj0uvEGw3JoHFuKDusCPA86ACz7irKTyxvE7PgXPecd9P7MQsnDJqw3CgxgjnnekLHrbcgkVtiQ7Pdm1wvqhutsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedufeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KMwYaIj5w5IRXUh_UDdOTUgTfpKIlT1x7E5ENiL-Nc-_VWHK-eB2_g>
    <xmx:KMwYaEAzRcXQRxfpP2Y9IuCVZwlSQNzcBFMjcn15Iq_7AffsMcRiNQ>
    <xmx:KMwYaJLuaGqdSBInoRNyE1-Jw3JGYAPk1oEnEaB0Bpq3G27r6M-FIA>
    <xmx:KMwYaLBROpIc-Uu_o7muHNmQIM1-QGkkTQUswHorzgl_jx_kBzuXUw>
    <xmx:KMwYaEdsmydnsedcBHMLfgu4skTY8rhEs6FuJUnBrTES2kqj7qydjrcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 10:33:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e9a4cbe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 14:33:09 +0000 (UTC)
Date: Mon, 5 May 2025 16:33:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] contrib/buildsystems: drop support for building
 .vcproj/.vcxproj files
Message-ID: <aBjMJO9VSAVjOQWB@pks.im>
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
 <1ec2a4bb1d58ea8cfa6abb2a0e625ef3e0db2a1f.1746430790.git.gitgitgadget@gmail.com>
 <aBi8KQWP4YAi6Gph@pks.im>
 <ddcbbd1a-dd36-a115-aa77-d5bd3c210cd7@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcbbd1a-dd36-a115-aa77-d5bd3c210cd7@gmx.de>

On Mon, May 05, 2025 at 03:46:14PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Mon, 5 May 2025, Patrick Steinhardt wrote:
> 
> > [I] wonder whether we also want to get rid of "contrib/vscode", which is
> > similar in spirit. Both Meson and CMake can be used natively with
> > VSCode.
> 
> I would like to avoid that, as the `contrib/vscode/` files do not even
> have anything in the way of building Git. Instead, there is a
> configuration that allows Intellisense to find the symbols' declarations
> and definitions, and it specifies a little bit the style conventions as
> well as common terms that the cSpell checker benefits from.
> 
> I use this on almost a daily basis, so I believe that `contrib/vscode/` is
> in a _much_ better shape than `contrib/buildsystems/`' Visual Studio
> support code ever was. For that reason, I am a lot more in favor of
> keeping the `vscode/` stuff.

Fine with me, thanks for the explanation!

Patrick
