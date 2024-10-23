Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB51CC174
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700362; cv=none; b=JRUhUU8TLf/cEXwDjpc/Z4Y5g2ZjT1tqPDvwRI6v1CUM0EO1ReSZYxhJG08lV83K5DpSvFgV7RVVJT2rQ1fs4bDakY4EqKdzewQoRbEzOjqlDpPsPv4kS1PQyKAkgJJEv8sN9fGTkliCy5a21WOE3TKFPTf/1AWyE4jtGrHfyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700362; c=relaxed/simple;
	bh=/FYxpxMHocTakbxCm4JGl7PGRrZBE7ZREbPypH1Ra04=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NdpwRiPqNFES1X8kZjuIrn+OdSq1Y9+59Fv8wxGP2r9nghbSgQkMEZWCihsdSBPaQam0lKxZnG3NpkrrMG7uuYrcJgby2xN7wEYer4BFfDn3BmuQDCNJlGx0SZ/yh4XNRjpdx0kdXAD2Zzb7Ynclyi16SQCWKCQiDy55w/YbZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eR4oKDuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m829/B32; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eR4oKDuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m829/B32"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ABA5813801B7;
	Wed, 23 Oct 2024 12:19:19 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 12:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729700359;
	 x=1729786759; bh=NTiZxKsepbJppFNc81rVG7+q8hzaCXS4RKngdMP3zpo=; b=
	eR4oKDuH50E1etMSM4YJNuvwmsVTi6upCH/0EHonvGn5tZMmmYtoUWgePkQFKPX8
	62+Gz75+IpoYJxQIBq0HhsXkpALAZTd0GuImYE2VtVaVau8mIPbHrfD01Esoi8L/
	bfab7N5jEB8nvDRVPqpA0xdAec+iHZO6atdF4dz1+w83WST5HpNX3uWPpxHnZtW0
	lNCp61g++DbO5AaAap3R8Of6q3Xouj/AL7eHMM5kvManxtVRO0k2RKtLrRCI/zef
	E7zgV85Kxmp3QcDus6itNsFVGTL89mwEyzebpYnPID+5KIp2OER8Gn5KyFHroTkJ
	y0t4zrn+fsqhYxOWTdzj1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729700359; x=
	1729786759; bh=NTiZxKsepbJppFNc81rVG7+q8hzaCXS4RKngdMP3zpo=; b=m
	829/B32uS/WfzGofFWcWEjzRsy/Kn0DbfKA+yrEBxxGEw+NomBMVGpOJXBVy9kvU
	3KLoFVI5yR92RMlz8MgRKQF8APu3BfK9bnjTUTz9ac7liGCny46LIf6VJSaH4gOI
	Q0UTNrbVpBtjWKh6n1WZXAG43LTGGWR3pIBT8TFPmD6sasCm9kNef3prQzR5sMnR
	seH73O4lsT7eSYpt/AfY8GXQLemlaFdvvxxxdIbc99iFJLucOoI/wBqoeWgrcwU0
	D2YrHp2wllAJsMBRtoHJsc1y9adC8m3XMiZ4QhIRvd5dBNcLAFevtnT91J3Peai4
	zsFnDfB8s0rXcHot83xJg==
X-ME-Sender: <xms:ByIZZ-CbJQLd-xqxppGyVOKoehILYQhTSDIw2mINuzPk7AYCS9fvhp8>
    <xme:ByIZZ4i6hO7P5CNlokbyVjc0m_ku5o0N5qnLMqdjFpvw4qgv6av10veW5TJyramtS
    -_ACR46_fjDQRhzMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ByIZZxn02ap8U2FW6WwgYD2Q-Nh6yIeP-FqekPykMI4re1I8prCfsg>
    <xmx:ByIZZ8zQCopPfF9ts0x_E6YUIkmwzNDFVwJqz5UIwTIar0Ip4aWfiQ>
    <xmx:ByIZZzTzhR5-EpPxciqjP4JRdJWg51RRbolILgGYzFB_tW4n3xdjsw>
    <xmx:ByIZZ3bhXyQNIPXq3dx5OsVbejD1s74I7rZtn_QZ5SD8qompZxMytQ>
    <xmx:ByIZZ-eyoFCqe3YuXtq4xXmZO9WljERkOKDdipGYvDImGfmGoszZN8m7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E08B780068; Wed, 23 Oct 2024 12:19:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 18:18:58 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <b106fb4d-3488-4fef-aca8-32e49efd0124@app.fastmail.com>
In-Reply-To: 
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
Subject: Re: [PATCH 1/3] compat/mingw: share file handles created via `CreateFileW()`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024, at 17:04, Patrick Steinhardt wrote:
> Unless told otherwise, Windows will keep other processes from reading,
> writing and deleting files when one has an open handle that was created
> via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
> flags such that other processes _can_ read and/or modify such a file.
> This sharing mechanism is quite important in the context of Git, as we
> assume POSIX semantics all over the place.
>
> There are two calls where we don't set up those flags though:
>
>   - We don't set `FILE_SHARE_DELETE` when creating a file for appending
>     via `mingw_open_append()`. This makes it impossible to delete the
>     file from another process or to replace it via an atomic rename.
>
>   - When opening a file such that we can change its access/modification
>     times. This makes it impossible to perform any kind of operation
>     on this file at all from another process. While we only open the
>     file for a short amount of time to update its timestamps, this sti=
ll
>     opens us up for a race condition with another process.
>
> Adapt both of these callsites to pass all three sharing flags.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

(Reading back) By default Windows restricts other processes (so these
files could be in use by other procesess) from reading, writing, and
deleting them (presumably doing anything it looks like).  But it does
provide flags if you need these permissions.

There are two calls/places where you need to expand the permissions:

1. =E2=80=9CDelete=E2=80=9D for appending: need for deletion or replace =
via
   atomic rename
2. When opening a file to modify the access/modification metadata.  The
   current permissions are *likely* to work but you could run into race
   conditions, so the current set of permissions are buggy.

The commit seems well-explained to this na=C3=AFve reader.

--=20
Kristoffer Haugsbakk
