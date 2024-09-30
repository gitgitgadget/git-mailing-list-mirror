Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3613201
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713868; cv=none; b=mk//npPsfDrP8p7PLDha54yUDQ1g7CHOP1p3akcG9z5uOcI05bPcySrCadoQuRxWnombgkMs2b/nJTIr/vQBXvKiT9cM0+BoJTWl+uEBxkXCBt8VD+Y8OZpG7HZQ2r/p5JQyvS979G+fnX7BWL34Psecec3mortbzbr2xn/x6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713868; c=relaxed/simple;
	bh=J4tifzzK9VLsi1uer0TIQQgIk1/WBXGWxVQFwErbbKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eqSeQ9C2IsdqQ/nGt5+xyGByqNn65KwyZcrdqPFqu04+L30W8xqJuLn+NY7BbYfiHlNeW1ramNlJ+PTbRfc9j4UOS3X9uLuHc8PSI30fNCcvnpmsQ5LP+0xKSGIhnZGT80uYzzN71HJb4ELcHTPRhakIkBQKgccD5y3J1EsWDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dyXM6QtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImdU2s48; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dyXM6QtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImdU2s48"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EB4B138088B;
	Mon, 30 Sep 2024 12:31:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 30 Sep 2024 12:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727713865; x=1727800265; bh=gaSuq8n7Ua
	q+gd0GfQeuJY3Ujdzzbl1wzfIh4FNh6mM=; b=dyXM6QtWsf2DP85sZmYkAx7Qbg
	fmIP4FC52YqzRHBWLypxD6Asj1JKjZ/4QZoDjma9pydY3mjso5RSi1iIlxoFNnes
	AFkCnsXH3l0FUiposvIRe+bIZ9L87+vE6P5W8ZrTI+FNovwUaCZ2btC+tslD6yfb
	Y+BY3gyMU2VyowtEfpVh17EpdreXBL9hXz7ViJ4v0ZwtnxvwHsNF2wfZhfVWlbb4
	FLgHH+ByFL8pl0GkiUqD4sxlTgUH//GmgCydfE8HZzje2BNp2ZQGAZNmEvJZNP+F
	GypVmfa+8S230rxrMMLW/7aTiFL7HgXybcJz61w6mc8uVlNwMC/tpE8VlRyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727713865; x=1727800265; bh=gaSuq8n7Uaq+gd0GfQeuJY3Ujdzz
	bl1wzfIh4FNh6mM=; b=ImdU2s48yWleNXlnjHRlAyQwMl0wuFwZfsOd24WIFjca
	jk0fohlZECR6cKmKVR5i6WBF9kJo5TPa/Pdm0qHa+Af/HuKRumUmdfXgz3+tZAEb
	CCuoLpSFT4MzMwLjGqcjYx7BG6hgPx4mVHqc39eUAbQVMiz841EWSLhiiFRIzfid
	wrP8gx+OBH+Ev4bIR8dTbK7TjXd0APFB92fJ88GeGl5srXdQcceEoGxrbelTs+bi
	YO1yqf87wgIpYwhPk3MgVFVaDDY8nDkrOCECPY5217kKZ0pG9ZIZPVAoEyBiWrwJ
	Qhe69K+QKbOBL3sZTT0unITdKcuA+lhLZ5UreUJlQQ==
X-ME-Sender: <xms:SNL6ZtMxE-5quT1Z6pQKKQ4DriO1pHl3GyvCjGGCpYowmDBE33Okdw>
    <xme:SNL6Zv_kac3It_zaWOeoSHwmOe61oTFDoCnJ22EOmbObMl-_V3a92-zJEJm0IPjge
    DOkIxg5iqmjbEhv5Q>
X-ME-Received: <xmr:SNL6ZsTyR85QF8a44BuVGFXRB76fD9_isH9by2uJiwGOETMGUq13EwfYP2oYV-7TUXuH1GXGwrMmg0oFxxOsBAYT_1eQPKRXtxcMJis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    hhgvnhhrihhkrdhhohhlshhtsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrhhnihgvuggvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SNL6ZpvhUYLTpC7s_kiH1C5wzWDC5SP8wVvtAK3pP7gVaP4hAX8zfg>
    <xmx:SNL6ZlcVtq5oBQDZkPDmKVQ-9_ZEMkCpVw6bnmFlURbXE7RGbB5Y7g>
    <xmx:SNL6Zl3czZkFqV2WIasBfVUA8xf5NIBVLwLWyv69zmsi87wWEJ8p8g>
    <xmx:SNL6Zh_z-64dUIQ39x0q1boY2j8tTO_kean8Ek_fmzrmpe_aAawzCw>
    <xmx:SdL6ZkwUqah3pZ4vynFl4UCg_Cihi6dblYplMBmfzeR15sepe3iJJD_3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 12:31:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: phillip.wood@dunelm.org.uk,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Henrik
 Holst <henrik.holst@outlook.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing dependencies
In-Reply-To: <157253c6-36f8-43ab-ad17-c6c8811bd5a9@gentoo.org> (Eli Schwartz's
	message of "Mon, 30 Sep 2024 09:57:25 -0400")
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	<xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
	<29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
	<xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
	<b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
	<ZvOTL0cG8qRY8OXe@pks.im>
	<1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
	<ZvOn_wChzEgXtpMd@pks.im>
	<3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
	<xmqqv7yil70d.fsf@gitster.g>
	<39508a38-d98f-3883-3887-971385a3805a@gmx.de>
	<d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org>
	<a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>
	<157253c6-36f8-43ab-ad17-c6c8811bd5a9@gentoo.org>
Date: Mon, 30 Sep 2024 09:31:02 -0700
Message-ID: <xmqqr0919k8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> Sure. And I'm happy to (help) improve the documentation. I've already
> pushed a fix to the page Johannes linked, since it was many years out of
> date (???) and didn't reflect the fact that meson will automatically
> detect the Visual Studio toolset for you.
>
> (Note that since meson will "automatically do the right thing" here,
> that means it is practical for a plugin to run meson under the hood for
> you... much like how cmake plugins handle things.)
>
>
> As far as reading this thread goes, though, I assume that in such a
> future, people who want to build git using meson in Visual Studio would
> be optimally served by a slight reorganization to ./INSTALL to provide
> guidance on where to find meson and what plugin to use, which provides
> an additional entrypoint for clarification. :)

Yup, whenever a procedure changes, documentation to guide folks
along the procedure need to change.  Otherwise they will be lost.

And it is very good that we see people are improving the candidates
being offered that way, not just enumerating how it is superior to
the status quo (in their opinion) once adopted, but making sure it
would not inconvenience or alienate existing users who are used to
the way proposed for deprecation.


