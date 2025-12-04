Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FB196C7C
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842895; cv=none; b=nLCfGz1A93EgAN/bqL8tK6z9nS1wlQF4iJ/LLD+bzLdPG+twar8asJApdJhPw3ALIYFsIFFfI1R3N09Uv6qwH0IJis3nIi76Hf5Ds8FPRIRaRFrEyZmhruoebj9rVCbTG8qFUBUFKOVvPinrfa8iQF1n1BaZ3qrz+PUu16AECyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842895; c=relaxed/simple;
	bh=M29Usc7ah4sZw7fPmSzlMM9BHF7Xqqum4I7klzV418U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nGk52QuqvrxPrZ+vWbityIuyjmR/ZYNArzMxvbM8/3el7/IGRJJ5e9zFkmfqX5euCZizAQ0y4jaS4jcL0XEoymvnp/Ix4abzXGI4Vjsrxp811/0/fjymN3wodj4vmCznj1uPWwLHZhjxmFKTYVUaWviWdXfYSuZjOQLBpoengm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DWMgcsik; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qECQN6Rn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DWMgcsik";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qECQN6Rn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 379507A01DA;
	Thu,  4 Dec 2025 05:08:12 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 04 Dec 2025 05:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764842892;
	 x=1764929292; bh=kEA8zc9KZjDIbpF3JXBlWaimHwf2S8dI5qyklRdPcuM=; b=
	DWMgcsikvlGYfwKFS+EoaLQO2HAtF+taKuAHS2vmKsUcYSxo6ci8oMwi86cSWWkj
	Sv5VjPGyzlnRAF5/IRXNtMhS+n0kWrjlIVYFnpH0Kj/LSa2n4PPrIwuWds5M4D5Q
	S8VIpnpcwFTF8CK0AETw9uzvrueauBlnJDLkBvBrRCVXJlcZwoNvWsPR2fYiSNw7
	tBIjCvkauAa6YOiIWUoVFJVkoQVsnD5+aVs6EHMTakPq9QeLGpTmOk87CqO63zVv
	HaS6hnjnmeVsvYMw4HK4ZoihivoFLNagKWckLnuDv2KvV/tH1JQ2vSMQ3JeGs1iD
	7Ahze516c3F85QO+Vy/Niw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764842892; x=
	1764929292; bh=kEA8zc9KZjDIbpF3JXBlWaimHwf2S8dI5qyklRdPcuM=; b=q
	ECQN6Rn6/9U119IPDZy5SzmXFuUaoBwdsS8gIsF6APTyQaUFe6cIDgSN/d3w+T3m
	wG0m+D43i9w0UgZstW4PigFOI2e5xMMiXArPCXp3pzN0PmX84d8ueJZ8Uo3z2tmm
	4YOcyLKdq9LPZZWn0x1/MMWxcMoRPURu6csW3xPT1lb7HKpkikh0zFyZTm6rRBxK
	yTMDvWR+4wG1plAA7wKuKOniKrLrdB4YUE/Gb8ZlYEVN5HsosDpN3Y4pnpG9X3M/
	G5kArGZ94P+ZI+9Ezw+tJ2zrVTgpm67418GvOGT7czbgeq997WKuC3Tc3bTCgq4h
	itgnwsnF7C4aGTHQ2LKtA==
X-ME-Sender: <xms:i10xaeQMZSd_VV3bqReklIj8ZRjiXRaoTZlbRDXcGwx11gbLwLQLmgs>
    <xme:i10xaekoWgUyO6-TPSxrKlTjwzkIBRMkIGla1LAZpkyK49al1IpcZvdpCh0CQOjUt
    XOS9PLfrWIOvghYTsxPRsCpC_cmhkXvSBYhIsUAeIhD6wWiWNpU9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeelfeejudejfffgleduheegheeufeeffedtgfeffeevudeuleffgeek
    tdelueekieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:i10xaRusB-ZUn8ulIwVdvLxNU-ghRD1EKLfhn92Tb3d4L3TkqS4ESA>
    <xmx:i10xaSMNk9HYSuAsVLvOlcItvYvmAonRJ93uTfNNY6WNqvwleDnw6g>
    <xmx:i10xaX2FDzq08KZ_z-JG9ypg2ZIR_y1sAKaMzG5xDC_MsjvjIPzr8Q>
    <xmx:i10xaWOlVyr8uegJE11cZB6iesdJjLAtPNtsIrWPpJfVHXWJZKhThw>
    <xmx:jF0xaQhMJFQKXocINAmS2lHY2dksTDY1DppM3GI2itcOvX3G-8WXfmJ7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE6A21EA0068; Thu,  4 Dec 2025 05:08:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoCHDQFv_cPs
Date: Thu, 04 Dec 2025 11:07:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Taylor Blau" <me@ttaylorr.com>, git@vger.kernel.org
Message-Id: <3d396982-8da4-4e30-950b-3034dcc987e5@app.fastmail.com>
In-Reply-To: <16dd8441-b828-4526-8d21-76ee834b398c@app.fastmail.com>
References: <16dd8441-b828-4526-8d21-76ee834b398c@app.fastmail.com>
Subject: Re: [GIT PULL] refs/notes/amlog from git/git
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024, at 19:31, Kristoffer Haugsbakk wrote:
> Hi
>
> I have noticed (a couple of times now) that I=E2=80=99ve used the stal=
e =E2=80=98amlog=E2=80=99
> at the GitHub mirror. Maybe there was a temporary maintainer at the ti=
me
> (see the bulk of the commits).
>
> I merged git/git=E2=80=99s =E2=80=98amlog=E2=80=99 into gitster/git=E2=
=80=99s =E2=80=98amlog=E2=80=99. That adds 193 new
> notes on commits that are reachable for me (presumably all on =E2=80=98=
master=E2=80=99).
>
> PS: git/git=E2=80=99s =E2=80=98amlog=E2=80=99 could be deleted after t=
his is merged to avoid
> accidental stale fetches.
>
> ---
>
> The following changes since commit [no common base; unrelated histories
> (squash: cd046fc8b70 (amlog, 2022-10-23))]
>
> are available in the Git repository at:
>
>   https://github.com/git/git refs/notes/amlog
>
> for you to fetch changes up to d3d558e9824282479562a721e2a2a1cbbcf7c01=
6:
>
>   Notes added by 'git notes add' (2022-11-18 18:30:49 -0500)
>
> ----------------------------------------------------------------
> John Cai (1):
>       Notes added by 'git commit --amend'
>
> Junio C Hamano (31):
>       amlog
>       Notes added by 'git notes add'
>       [=E2=80=A6]
>
> Taylor Blau (588):
>       Notes added by 'git notes add'
>       [=E2=80=A6]

I see now that all of Taylor=E2=80=99s amlog entries are in `refs/notes/=
amlog`
for gitster/git (at 6b6c4b3fb846382a93fc1c94747a90cbe1b5e833). So this
is irrelevant.
