Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A53150994
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963675; cv=none; b=iHFvrHIsfWEYoVfEnzHsJLUyWl/5C8pY3zF0+r87DAmJi4zHWNX3C19gqIqscRO0YMCtMdoyEWc9seOEeVih7rlEnq0fj9LNcNCb47A+SXe5CkFgfl4Upl3BD4A6mMO2Y6LyKjGoR/wzLkApYQfOneEMNebBirWFh/Lyrt64d+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963675; c=relaxed/simple;
	bh=v736yHh7xrL51+cy8Pc1waH8Rzw0lI/pQfAoTXuVQpo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CN4WI8mdu/m4RWL1uGZkc+8tvYYC1Dya2ocqUK53vvUbq7sqATy76RzHcvkf+9eyXyMawHUkU3UYZTw6UJNDEWB+1yJzvE6EH4K8v0LTvCa2SrGaYp1lZ6VJeOkoqOIhh0VQ/yiACsTgwE1QFmSifuUI2qtviJYvaKt1qeQUm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jwdcMatp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kztBzK3t; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jwdcMatp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kztBzK3t"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A3CF11140174;
	Wed, 15 Jan 2025 12:54:32 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 12:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736963672;
	 x=1737050072; bh=Ni408KZwNDhAC7mc58Y97gkKLmUE0N/XubiQfecftf0=; b=
	jwdcMatpmiCf7Vr5V/tx1dZWgCgdnskbgKU0Ft/Dws1laj3EFa2DONA9u4em0UKq
	wMcDdd1OhmVggrnJvABKrZkHLlxEIK409jiUYhQHUKUrQ7DCVKEVwUjcCU+hhAgy
	6k0uVU8F7TB5jxsy7tjm+jrSNz3cMpwZaguTfaQF1MQcByK3OdDhXkpypsavYEG8
	rWXN2mhlbS3eBJS8gOPdGgkfTfRJQukst0nbBPvJZT4byAtK3T9KIlSvTMX5L93b
	M1svlIAl0WCoxRA78V+SaB+jpsHVOkGRPU9hGyC2xNa61ApQKmwzMG18jlI/N+XC
	eF6Ff8hcnNfZTcxwPQ3w/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736963672; x=
	1737050072; bh=Ni408KZwNDhAC7mc58Y97gkKLmUE0N/XubiQfecftf0=; b=k
	ztBzK3tzY/M4ZeNbSHFXvlNHdkr0CIpKR/fPNwxeY158Mr4Mo0IZRfYpYtZqep3L
	xZ+KrycmQN8kTlIHDkC2/bQZH4MYMWcEQl8Lze1yjDqkKKBJ7Fdo7HrDl3183q1a
	ZQk6d3HB2l745jg5l0ugdyBq8cGGqEEtZXxdVZ4pZsCYBaTSxbnDssqRbrgJzFYO
	XtScOqqNfo8TD4dAFR1hWrDqGx1Vivo2Qy8szKMw+/wnCjZQaBeonul7pjzX+FER
	BWU5vRU4IsxdTbo1fkvRckYxUOOktG+tgJXiomi35fgL2E4is7FY3zEJzILYTqxx
	VlOPVj+QaREG6tpGQm3nA==
X-ME-Sender: <xms:WPaHZ5LKVIE_blQptYqFRVpfVn1Tqr7Sl04kYPARdeC3Tw2ou-qMcDo>
    <xme:WPaHZ1KIp-FL0njfjjAQAhM8L26FUU-68hXE4HCaSTmrJXtWo2hphElNIK-rWcdl3
    e3WumjuVimpYie23Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmtggvphhl
    segtvghplhdrvghupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WPaHZxsPx1eOOVL2bDHhbaYSlvXasj-M940oxAgGe_prvipNhhFNCw>
    <xmx:WPaHZ6YcG9PIbZJg-RpbpXWs_0omjZ4WzS9VYYKKCd6xsuaeI7yb3A>
    <xmx:WPaHZwYblNe_lRLZzlmzL7cvPwtZHS1Wc44-SSFAogVS-R_Imj_tbg>
    <xmx:WPaHZ-CBxXh7oOn-gFXMBdSh5V2_zhR59Qp7kejidXAnSfK9Gya8Eg>
    <xmx:WPaHZ4FDKAjtq8L3ZnRIa7DR6NsAPC6zxCy8fQXo1KbzFjJn0EkPKz-y>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45FB178006A; Wed, 15 Jan 2025 12:54:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 18:53:52 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonas Konrad" <jonas.konrad@uni-muenster.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: git@vger.kernel.org
Message-Id: <6b6e5488-8a61-437f-acc8-e5868c4cc9cc@app.fastmail.com>
In-Reply-To: <c8365a5f-bcda-40c5-bcf5-ebfd9a04ae64@uni-muenster.de>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <c8365a5f-bcda-40c5-bcf5-ebfd9a04ae64@uni-muenster.de>
Subject: Re: Git branch outputs usage message on stderr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025, at 18:14, Jonas Konrad wrote:
> On 15.01.25 17:55, Kristoffer Haugsbakk wrote:
>> [snip]
>
> Was just about to share the very same results, leading to 40 commands
> out of 142 built-ins outputting their usage info to stderr. Some
> additions on non-builtins: git-scalar also outputs its usage info to
> stderr. git-lfs does not have "usage text for -h". I have not tested
> git-svn and git-cvsserver properly (do not have installed the respecti=
ve
> modules). On another note, git-p4 does not know "-h", but then gives
> usage info - to stdout(!)). Lastly, if you still read, test
> git-http-backend and git-filter-branch, as they show special behavior.

Okay, `git-http-backend` is listed in `git --list-cmds=3Dmain`.

That one doesn=E2=80=99t support `-h`.

    $ git http-backend -h >/dev/null
    fatal: No REQUEST_METHOD from server

and

    $ git http-backend -h 2>/dev/null
    Status: 500 Internal Server Error
    Expires: Fri, 01 Jan 1980 00:00:00 GMT
    Pragma: no-cache
    Cache-Control: no-cache, max-age=3D0, must-revalidate

git-filter-branch(1) prints a warning about =E2=80=9Cglut of gotchas=E2=80=
=9D, waits 10
seconds, then prints usage to stdout.

    $ time git filter-branch -h >/dev/null

    real	0m10,058s
    user	0m0,023s
    sys	0m0,041s

--=20
Kristoffer Haugsbakk
