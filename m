Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E1288C86
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851737; cv=none; b=oAhD7UEMRLUIxyfkw3OyYezviYTS9Xx/usBEKXR4o4Ijawv9IlPIRHUPMJXfg0A5i6+MJFpI9fc4m7AlU29FYOxAJWZDsYBWC78nwfRMLcR6j89JO4M8WKODhNGHbQOYlcPv3m1qRoqUk5nusIZ9QH9p/p6HdGAlt+tC+sErHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851737; c=relaxed/simple;
	bh=mG+yyY7xNV3QgA9VKLC9QWpp2zg6qinBvGSNoIHL3FQ=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=osZvitWvPClYe0P24NW77cUQDbU/mwZlEklMN9ZHiI5DooH1P7UC31ocqo+zI7FijrEScJZUbxgv7bByv3lx8SQuWeu6aW3Ma6QK+NfywhXy6ayqknPEp3cLhv2rIGJ1lvKBiAvleTrbrGU8GkcR9qZOOcCbnnw+Ryar1vNU3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mfz1tQsQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHh6bDBO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mfz1tQsQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHh6bDBO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB16E7A0170
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 18:15:35 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 18:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1770851735; x=1770938135; bh=NY2GJKJFvE
	yr3JXnBhZ2rXL40zFiIm4Lntfv14mIjKI=; b=mfz1tQsQE9F9+qlbgUY5Ae1wJ6
	Be3gCUZc93UjYz3ijR8R3zbNNymvoyXlenAJsATD2N3GVEAIWpp2CiWl3/o0f3MJ
	WTBmYnJcNLVq1eo3owuNybnqd0OTTQb7JVGEufFU60q+ovmq/dA7MlZ9xqR067c9
	qM+6c0OB+YGVgHAjF7gXMWfxqK66A3zdfOGFMDdbxU+NZ+P0Y3to/mLYAzMDrkOg
	3P4e9k7uWkI/fyT9H4Sav+B5zpt4e3lZnMP+XvtBugfr5VBqjraC2OFEE29rtx/Y
	1ddDrlxK2nGnCMNH9WjRJ6uWk6HnUdsKUsJoV9gf7g03qSjjy8UvP15D6nEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770851735; x=1770938135; bh=NY2GJKJFvEyr3JXnBhZ2rXL40zFiIm4Lntf
	v14mIjKI=; b=DHh6bDBOimjdfuipd4sDY4QEJ7nJLGbupTjsWxA1hVIEN6MaPsI
	XSynYtxsKuWCGD8ZSc3C4nBqJ+KGaFRFZ4EWC/f+2bQkPmiMToOqN0VWWNoYCOCE
	mmskvERhmkKwj/aCA+1C7KCE5wcIVBa2cqWVnh2N4Lw7DwVKEPYDpjO72+mXxV6f
	raI/fFfEVbOXuZ/zfmLB2jM7maEwr76FlRKD4uSyFCpmuzXsCvx365huqd1hw45A
	3v0Evo3nCjfskUC2nxn0s8ff/424CdTyb9W/vfcLQsvD0YD8EoUiYX4zNcpww3cE
	Fh7+ITFkFtOiMMY31x+Mv0h1EampP3vky8g==
X-ME-Sender: <xms:lw2NaaFryqjZ2CRoSV7eJxCbicSsTQegv2S2kDGfn59Fak_toIgjWLM>
    <xme:lw2NaWJN3WwsOqQl6XbOlqQ65tfVE1AduNRESH8rqIKm0R5vKr8ejVw1KMpAM6leA
    -fBwnOeT3h0aVOiMnad2XVTDwTPugX88BIdnckRsztjf2TJLe4N6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtqhertdertd
    ejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgfehgfeujeejvefhffekkeetteelhfekhfdtkeekkefhffefjefhlefg
    vdefueehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lw2Naf0H8jxaCv0vZ8Zh9vrpXV9aTaH6vKzsJ8Opf9MCVP-6m1hqJw>
    <xmx:lw2NaeA17JH2bvV6qCZbZwa0UxKleZAXUTumpghgy_rfazBmnyNhWA>
    <xmx:lw2Nacwln-WzV8SqiKvxjOaXAqK3z7bOTryq9P8pV28UnvNPlJOySQ>
    <xmx:lw2NaclMc0IkeLblFcZZgLEJ6HNSOo63mxmVff2oxZrDAmxn62dApg>
    <xmx:lw2NaWKDtdoJVoSX8A27LBmIkCxvt-1mWaM9Cg_UA1JMHcCHwgf39YDA>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4DC9E1EA006B; Wed, 11 Feb 2026 18:15:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Feb 2026 00:13:36 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <2b07489b-1689-4ecd-9cda-012540fe56e2@app.fastmail.com>
Subject: cat-file: dies with --batch if reflog entry is out of bounds
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

    $ git cat-file --batch
    HEAD@{7}
    <commit>
    branch@{20}
    fatal: log for 'branch' only has 5 entries
    [died]

This is a known limitation.

It used to just die without any flags until recently in 393bbb21
(object-name: make get_oid quietly return an error, 2025-06-12).[1] That
added a `GET_OID_GENTLY` flag which is respected here. If that is set
it returns normally from the function with an error.

Before that I was looking at `builtin/cat-file.c` and guessing that
`GET_OID_GENTLY` would be the thing that made `--batch` loop on. But it
seems to be the lack of `GET_OID_ONLY_TO_DIE`; that flag seems to be
used when you do a one object lookup like `git cat-file commit
HEAD`. And it is indeed not set for the batch modes.

`GET_OID_GENTLY` from commit 393bbb21 was added it seems so that a
commit in the same series could try to look up a reflog entry in
`builtin/stash.c` and give its own error message. And go to `cleanup` as
well. It=E2=80=99s the only user/usage.

I=E2=80=99m pretty new to git-cat-file(1) but it seems very consistent in
returning =E2=80=9Cmissing=E2=80=9D for object names that don=E2=80=99t =
exist, =E2=80=9Clittle red
riding hood=E2=80=9D and malformed rev expressions. Is this the only
could-be-an-object input it will die on?

[1]: https://lore.kernel.org/git/20250508234458.3665894-2-sandals@crusty=
toothpaste.net/#t

--=20
Kristoffer Haugsbakk
code at khaugsbakk.name
