Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381F1922DB
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729371467; cv=none; b=OoUV+uj5wGnz1H4FO2M9UNORSnug38X43oFNHht7EO0LeayVRx/JS0dNuG+D/TuYy8RVwJeo2HFtGFUKR668duk5wlKp9BQVHj0bDbKyCp+no/4jllVJ5O6B/vKUAy0UpFQkwMZfgbbgIzxwRSvYoCImEGPi+9pU7XtlY/S4t3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729371467; c=relaxed/simple;
	bh=YkSymvWXTM/CRxJVrOkLEJlvJ1QK/sMJZNVDk60OILQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q2MiPuz7ilYJSUTzWqP0Ga34IA4YxhZj2UaWoBr/X2Q1YlGFPH9zHm/3KZddrlyS3EMnuyJDc/H0sScybI/FKdbTeMLafuqGOE6muqH6oQnlfE0B2jG9Kr0Gv5yrESg0u/NeCzjuSJDDxcp+p5T0CMlchsaC9/IJ89prnEPc/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Gc5OyA4h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l/0alUca; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Gc5OyA4h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l/0alUca"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67D1D2540086;
	Sat, 19 Oct 2024 16:57:44 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 19 Oct 2024 16:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729371464;
	 x=1729457864; bh=K2kRtKPkp4Rmn1yUTv4cEPAzZfBMq4wBoIlxKfK3jPQ=; b=
	Gc5OyA4h89OGHt4GSVRvFNF+xUVAJJe3Tv1FKvmJK6oirm6QbJfV/+JDtBCOnqC3
	YtIHC5uF4ShJQo05Wm9sVB9hZAxew0fn9BdKHNoqgqypIh4Nz/Qb9ss1YLIvU8Wn
	SnjaOMa2XWJ0rjf1eJUQKCIWOEzXWAyworqs4wflcM7lZzMiiJEEeSsQS2ZovFW/
	t3kmdQ9LkaHSG3P4avfKVOlN6FknBrP8i1s0rmnlbIEm8hhKWnQ1+IJ1gSXbmv+a
	tsFttaO1o7AB4TOAoxdz9U5YhE2+YgEAwM1nUDQ1yz7cdpEg+Q6YRUx2aTkE/O5E
	3UIUTyeiAX/ZRgn/3rA6iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729371464; x=
	1729457864; bh=K2kRtKPkp4Rmn1yUTv4cEPAzZfBMq4wBoIlxKfK3jPQ=; b=l
	/0alUcaEIcKwHFHtXOwhvEyRB3IbhoOqIver2kOTsMhbjMoWkSvAH4BN5i0xeVsa
	MfdclR0QfJV96jMPH7Q1CHQ3aOX4kYH6rEG6/l6+v3vh1dq04jaXMgX2xxLz6ChI
	NUa4gEkGIK1Bz0WGqDmVE6M1WVvxFVl3Zk0pudUyjcB3VkBXIZYkPXBlGZpMd9UL
	Y7fKco4aWrDeli3ylGeLW8GtexxdWICAZr0ZUpwOATRonaIfn7Y+UloeMcJ3hcM2
	vklpDqn+2NMp3kraq+OqGD7vNvSMvw6+crtavLAIc9PWFujxhfsz0Li7XF21aCVi
	/cw/sWLNy31Ds0ty7SmXw==
X-ME-Sender: <xms:SB0UZ1VOT2vQaDtPL42RS3xJIeoOCeJFwM1T7Ij67kDt3yUG4O3xJqQ>
    <xme:SB0UZ1nUdiV-2gviYvNCKWmmOsE0yh-z7_-_Nc5TZBLLx1iSjxT4_TaJWbrDKDrrX
    ovDdH7PZ35zLSOelg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohephiehtgeglhefse
    hprhhothhonhdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:SB0UZxa4zJ3n_qXIQLxHaaUpquj6KkSUwYXG46NxyYN27TS2_r3nbQ>
    <xmx:SB0UZ4WRuSqxqvWbC6os1X3xXr7emZWTmkwiWwOgeK8miTcUjBbBTQ>
    <xmx:SB0UZ_k3oKI1EmagfAoeiryEZNCXntEcvQqEmBVA1OqE_NpgcapcfA>
    <xmx:SB0UZ1cn9Dh8PitlUD_pDcNbgyC1HCbV7-UgHe7zdqetzfnZ1wtzEQ>
    <xmx:SB0UZ9iAI5rQR3NpyB0a_lqAZW3uLO6xDbr2oBtZkmL0gY7gGPqRvFrD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF061780068; Sat, 19 Oct 2024 16:57:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 22:57:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, Y5 <y5c4l3@proton.me>
Message-Id: <348f4415-77cb-4893-8388-a2495a391a39@app.fastmail.com>
In-Reply-To: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024, at 22:39, Y5 via GitGitGadget wrote:
> From: y5c4l3 <y5c4l3@proton.me>
>
> git-diff setups pager at an early stage in cmd_diff; running diff with
> invalid options like git diff --invalid will unexpectedly starts a

s/starts a/start a/

> pager, which causes behavior inconsistency.
>
> The pager setup routine should be moved right before the real diff
> contents, in case there is any argv error.

*Any* argv error?  Maybe =E2=80=9Can argv error=E2=80=9D?

=E2=80=9Cany argv error=E2=80=9D looks like there isn=E2=80=99t an agree=
ment on plural/singular.

--=20
Kristoffer Haugsbakk

