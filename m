Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74152BF002
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492952; cv=none; b=rN7wJlyS7/bK/jjZ21bRWUaBKbY7y+lpwo6wIHQl428Y+bgugS/JoiYv/s//6CYFZD6cja5N4jqvtusCKQA5ewanE8H3Y1hl3FFy3UU14y92GhHQuNUlCTA2qf31uI+0rG/KXZYwwrvprgtWWf623BhhJ9a8JTab8wEZnDW9W+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492952; c=relaxed/simple;
	bh=ipYl3wI8KEktupBs3SpSLafE/cjCSMefHnhy5fg/eHc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hEEA3lABDIQDOCy1CrXwkBr7mtHYEvc9x9Lj5keMoBFg1h6ebTeIxl8wjyVciz8iEcM1PwTGBydJzbByzdZ3O48/6TrlvNYOwNsxmMkGtcKYvQnRugxYrLbG3xpeO1eZp5RJMJli+BzodeX5t3AhE4ij+60XK1I94kjifD6pEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LDNBtc9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A0ADoSPM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LDNBtc9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A0ADoSPM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 09764EC0108;
	Thu, 15 Jan 2026 11:02:30 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 11:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768492950;
	 x=1768579350; bh=cM6J3u+cOSRYk/rWZEn9OU60yjb6rEd4QhmtG5eBcJE=; b=
	LDNBtc9ZLK9UDeaNBx8YjuOem7Et/gtHgLsiVKZ6RPT3OCm/LT/vjJ4tp2LEgbGr
	wK5ggHVudufZyLjO3yAd/z7PODpH63wJvrPQAm6mKDkPmLMh7KdLizt72vhllT16
	WRfBqBP9TN6N8eXz9BcwcDtc8cYwZ+1IuG2y54NR5W4HTYTmO/am72upgsNKNFoi
	H47ytTzUI0J/OAA6HCAUaX4Cams6LZIS6Xurl16dPfD+O+mgA3GJDNdhVbV4IBEZ
	p4B+OxQ2pGeuO9UV8H/iFljvXdWFcmL075c8fpgCKo/3T8pmq604IuUcsHVUjFeV
	C8OhSXYbLujR6CzEdy2Prg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768492950; x=
	1768579350; bh=cM6J3u+cOSRYk/rWZEn9OU60yjb6rEd4QhmtG5eBcJE=; b=A
	0ADoSPMc9op3dq1S78bLazp2PTUQXeBhKMxcBF8ck3YgVKvPHfYunSlCcf2tHOBA
	SMeAiQ8SpndrvZrEcrq6NtA/VOxty2UMUiTOFuXR7Mz48zHMML6HOrDkWqC2dUX1
	Tcl85cY9SRAFdeUTyGQisJPyWluR03du2+hXIC66pzROHXfmrYbayfKJqsm2IKac
	VmvXWIoDOl59XhiZmVXPNjl4KrvXsfNtDfeMxceZaUepDcJdLizWiu41Sna6GaUr
	2ECPN9yNxyWREL0TqNE2IOMit9dPcrKe4jAEsj1dOGxVxohafU76x+kBzSVHAPmr
	AnrTgZo6SSHX32eof0YNw==
X-ME-Sender: <xms:lQ9pacK7Q_laq7gSpci5J2MMHplx9aKsHOCIdZXZEPbc79T4KMcMF9A>
    <xme:lQ9paW8R7irfuOvNtkiAIdAel3er-TJkcTouPPXIiy4wlvFtasKXvMNabswLfWyS0
    1z4tH3iHq2BFVdgGxr8l_sTnMjUyrmWR1MHLlpJ39HDSoHgGUcEdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehguhhsthgvugestghouggvsggvrhhgrdho
    rhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lQ9paUyypGuNXoq3opAeZ1pnxeYfOe4IOlQzpX8-7xthgLWSAoAfKg>
    <xmx:lQ9paWFAgOyD-RobhXavytWFwlNTd422yVRkn-xwILHh_oKJ5fl_mA>
    <xmx:lQ9paQzFHxEPz6XJSiMSCGhB4TBk0Ptg6LFiwHqOn27zcXWolvbMeA>
    <xmx:lQ9pafv7NTNqi-Xz_KkbEWptGnoYFzRyV54GEnts7lR8r56xzeTL9g>
    <xmx:lg9paZA0DgO0nG8OHcdQbdjnT9Z6OmHAsepCNgcpsiAmk6EmktnXRSue>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EA5F1EA006B; Thu, 15 Jan 2026 11:02:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4B423GE8mRZ
Date: Thu, 15 Jan 2026 17:02:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, Gusted <gusted@codeberg.org>
Message-Id: <bc0db8d5-3c5f-4dd4-9c35-ccb02a6bf5c9@app.fastmail.com>
In-Reply-To: <20260114-toon-last-modified-tree-v2-3-ba3b1860898f@iotcl.com>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-3-ba3b1860898f@iotcl.com>
Subject: Re: [PATCH v2 3/3] last-modified: verify revision argument is a commit-ish
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026, at 11:24, Toon Claes wrote:
> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
>
>     git last-modified HEAD^{tree}
>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary
> in last-modified
>
> Fix this error by verifying the parsed revision peels to a commit-ish.

Nitpick: =E2=80=9Cpeels to commit-ish=E2=80=9D =3D commit-ish so this is=
 a bit
redundant. Either just =E2=80=9Ccommit-ish=E2=80=9D or =E2=80=9Cpeels to=
 commit=E2=80=9D would be
enough.

s/verifying the parsed revision peels to a commit-ish./verifying that th=
e parsed revision is a commit-ish./

>
> While at it, also fix a memory leak in populate_paths_from_revs().

(Whether or not this is a stale sentence (see Patricks=E2=80=99)) Why no=
t a
separate commit for fixing a memory leak?

>
> Reported-by: Gusted <gusted@codeberg.org>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>[snip]
