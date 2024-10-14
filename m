Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355C15B551
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900398; cv=none; b=nhT2g5BX0U0RWOG1B5yUXMCBxGcquEzCcSse1eLZU2ntwYUeN7/25Q1qRZqiIkJ8WoOcATIiNNr21DDHJCIDoE2b6nrTCTnRKTItY6USJ9r0wSruYD1slzLr7DX6MFgKtNIzemrnKfgcGTaBfO2rT0KiU4dYx7h2ly1ttW7Q+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900398; c=relaxed/simple;
	bh=e+JKv6jTcWfpLzAMxPrabHFSWf01NJIaBQykHdo2pV4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oD6kNFJEudWIjRdwUGyUCGp1fgZy+UuoGe1pLyL6okDL3WuJMZzhxWrVo7jCLbBgED76j1KsU/HkD/ZnWgjt8VR4oqGnbJZ7ePtv24S157LdLh+t68Ngxk1J9rtDIsaFRXuKnhxi68cv2bbUna4I4dShJ6zvbjIp+wo7eEoY/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VlJLVNH5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SfFBB+P2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VlJLVNH5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SfFBB+P2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BCF51380279;
	Mon, 14 Oct 2024 06:06:35 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 14 Oct 2024 06:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728900395;
	 x=1728986795; bh=3OKzDtFhASvd/IZyvyg3a4RuHUYM1tv9qopesCp6dTA=; b=
	VlJLVNH5RzNI4A0EegrFPdJsuuSjJqS59XjWOfYooGzoBe7s9fLDjmxaiAA8gPSp
	n78zoUp7Aoi8Ng1QSvVOa6YXCFada0k7cUuemrlRmSVos6AlmrFNmDcFQZWtDHDS
	5dmTrAMdOxML1OvLJvSgX8bR+9HrHqaeczLxJJSrEVC+Q4spY8jQOjLeQxfGYj2J
	7HqO2EyOPLsiin2E+4G5MmV6JnDkakM0L2HV7AsMKVccd1PDgb8CLCcx6fYnLl/B
	w3QqgpEyXSdimdjq7PerLGhuwGTYzpeYhOzyTaAAeFLZmIMp/k6xKxDcMBnLO3N9
	oYL9WH/qvzInIVraoMJqvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728900395; x=
	1728986795; bh=3OKzDtFhASvd/IZyvyg3a4RuHUYM1tv9qopesCp6dTA=; b=S
	fFBB+P2d0zvPQiiQmS7AXUOJoo4c7kdkSUMdDeVA0uege78Ha7S9PKQPPx48tNAx
	M+JLVAQUMbLlc5sbEpNbxsKw9dlp47kemMe+dAYWgs4QCr7WtTnt1gYbmf42X4cZ
	rtHWZBcvPQCwXql14gtooogr+SM83vSKzs6wTZRTz+Eygkbb3N8gHs4n2KWxIzUn
	qHuqq5Xb81wL/w+BiHwMXJfpiAIHdJjyXEy4peGJ/qgflRqGtb13xCU8AtOx7C6F
	oYwaYZu6nPtAghexTbeqSaQdk6Ro8pf0BMUXSGqYMT1jA5TG75OxRGD7UUDHJ8qO
	KXmqjUwkNQiL2jZuSodhg==
X-ME-Sender: <xms:Ku0MZwuuzADr9M4WjCjEnK1n2oieOFXFMVmEGaqKwmeGfmpaiEh3ULM>
    <xme:Ku0MZ9cYnn-TW54sAxC65yJaI7ZJ8zzdLUchgz-DXyKCRCxjJxSVrinJ9UwbiZrRV
    IPgCd9zSHgHp5b3Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigv
    mhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:Ku0MZ7wVNrCWkpsFgZdMzCxv7zaSDxHud7eRmPA_dtep2qqJgeputg>
    <xmx:Ku0MZzOVwfTyGYJwoXI1cKG8j23uy-bpbtV4VAUoQoPMbIvAa5wy8Q>
    <xmx:Ku0MZw8dwCP3BHDrT37gZwIB-GTa1r-rdKqDoU6E1IrmdTbO2AlWzQ>
    <xmx:Ku0MZ7V1oh8ciBME1967Qw57wfwioPbnfx2Y7ec_pjUtQn7DWQg7Rw>
    <xmx:K-0MZ_b83U75b8gDZVkgEgtBzNROMAMU8NqNd7qfJHpD_mEzKwcFBxn7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 80903780068; Mon, 14 Oct 2024 06:06:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Oct 2024 12:06:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Usman Akinyemi" <usmanakinyemi202@gmail.com>
Message-Id: <63b3f6e1-d076-4522-9dee-79516200b8c3@app.fastmail.com>
In-Reply-To: <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> Cc: gitster@pobox.com
>> Cc: Patrick Steinhardt <ps@pks.im>
>> Cc: phillip.wood123@gmail.com
>> Cc: Christian Couder <christian.couder@gmail.com>
>> Cc: Eric Sunshine <sunshine@sunshineco.com>
>> Cc: Taylor Blau <me@ttaylorr.com>
>
> We do not tend to use Cc: footers on this list. Also note that as there
> is a blank line between the Signed-off-by: line and this paragraph the
> Signed-off-by: will be ignored by git-interpret-trailers.

I thought that gitgitgadget checked for missing sign-off.  I=E2=80=99ve =
seen
that message before at least.
