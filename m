Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67137106D
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155124; cv=none; b=HMzDXnEZDNf5yqD3PTgMfmRe42wELZqzXKhcB2POo0dVHbo7ji8qiDNChb00ia33mivrIvPj8TkrwOV3RICgEq38rfGZsGr7dDhquGXTq+2f6Z8g7Tag/HQsw/rPJ88lLhdIM9plG1MQ9jUiFXWzuEifWArjqgEnL230TRdOQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155124; c=relaxed/simple;
	bh=mQTbD4VrQcsAh7y3/wSee/bt+SRtQZ+OpBV5nTKInlk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KU6epxYvZO5IOFq+B0KBEIFlRgWhxhre1eq9v4b8+o7HFoeeG0jGpd9gbomjZ3Bbr5eu+va1W9NKb67nmGE8+CL5C7K1K/TPDZPHB05k+epzrAahH/lf78tT9fFfab9gBDUo10eo7/Yp75Lf5jWNb0z09KxA4weKsLggjJFPngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=R3RO88WR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSC8Yntt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="R3RO88WR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSC8Yntt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AF6C01D0005F;
	Tue,  3 Feb 2026 16:45:22 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 16:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770155122;
	 x=1770241522; bh=xSxeJKdEjmtKUQ04JI3zdXtWy7xQ+uFJHJPIks7OBdo=; b=
	R3RO88WRUZV6qIJyLKptJw18hvZpFaEbzTGdV6o3V52wvwHRDsO0fAzNrxplAYXv
	7G7OSUMuJy9K3L3g1jrCumpA+n2kXsiND8O1dIIc5hEeuAQd7jY15/bzPJhvrIqG
	aQzdYg4oGOCg0m1hzYOUdB6eAMaG3bVcDlXV0ITBv4Ma2GSV3KkDeY7KQq7tbdj0
	PUXhM5d+okhgX/xGzBSKOydoIK4ZKLPfO36Qm3GaEnZhR3fjgxKWLVxBsA08j1Wf
	NTHcC/5XngWI5A+/PtGAo8anih1H8mp+nusTNTyZGguepRv8hMQFl1do2m7NQnPj
	Y0cj/UpOdTWsE7rkfmEzuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770155122; x=
	1770241522; bh=xSxeJKdEjmtKUQ04JI3zdXtWy7xQ+uFJHJPIks7OBdo=; b=K
	SC8YnttT9lKgq4eDFhI80uxDvb2stoVf9XIojS8qygICEi0vWkW86800vF0aAnfP
	LcvuczkPtiCVZnWLXmKvDuYmCKAJUY7nWwz13978VajgSdgPgUddiQ4dS1U4QCbt
	pZNVe+WO/d3cQM/dTIbZbXCVxt4iblcJKZogaKpxy6Vd/i+cHuoUb9g2Ttwo1jiw
	8UnIEuvPkd7oqhd8ETKcz5IrI2tSzyKh1hi/xseqc55tCbS//eSVyF/GvBjrEo4I
	3r9eI4qnl5wsRTTej6X52bvaSa6T6n4gWZSQSc4HD59T0oVO+5dHDIEgXM2+ggnK
	o46KGUMLQ174JE+0Owjmg==
X-ME-Sender: <xms:cmyCaRSwSuLSVznBVBBAv1Fvg1tX2gDvLDzwzlBlGHjDHjKYP6HzcJ4>
    <xme:cmyCaVnE_flBWwDqU6scyjJtSa9vLFvmHH49K_HjQslAxJ3fIVoE6M5ii1DYU6d8e
    6AJdmCAY6Bp3cDfYTdSRRLFoBkxf5yoGbGLMqLt8JGOvi0RRebJE2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cmyCacuBXZna4o322PxLB34mfr2jm-EsGoJzZuHmtHSYFSDkIcOsKw>
    <xmx:cmyCaRMpW-l3XYNXdHLX6ZarYVL-lhLxnmTvfP3ZFFEb8v2fZpYQ3g>
    <xmx:cmyCaa0KnQQ-wjMXtqXEFqYDZQjbfG1ylyElYbaAahFGFq1JU9PVoA>
    <xmx:cmyCadN6gvZy9BS0SYDl3CH5TVUSpK_XWE_3mC82YNxzpwRqlO6rfg>
    <xmx:cmyCaZLqfvG16zdkMyeDVZmpUczEBBSoz86kdIQ9NkIhvr0Kp_EtJlHF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5213F1EA006B; Tue,  3 Feb 2026 16:45:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXMcA4Iy85D-
Date: Tue, 03 Feb 2026 22:44:14 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <6480aae2-d2f2-49dc-b8da-ec7cfcfbda30@app.fastmail.com>
In-Reply-To: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 0/4] doc: some more synopsis conversions and fixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 18:03, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> This time, git-show and git-submodule are converted. Some mistakes on
> previous work were also spotted and fixed.
>
> Changes since V1:
>
>  * fix mistakes spotted by Kristoffer Haugsbakk
>

By the way. Sorry that I managed to reply to the v1 1=E2=80=933 patches =
on the
previous round instead of v2. I noticed only now.

Too much copy pasting.

> Jean-No=C3=ABl Avila (4):
>   doc: convert git-submodule to synopsis style
>   doc: finalize git-clone documentation conversion to synopsis style
>   doc: fix some style issues in git-clone and for-each-ref-options
>   doc: convert git-show to synopsis style
>[snip]
