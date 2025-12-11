Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2226CE25
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765470880; cv=none; b=bNYAOjJgYTqIk5bCekcwpUnTdrwy8hJMaX7HyG47d2s9SJRigQJyi25RDW5wxIhGiNIu6CqbkLE/BAZudpPn7fx14JAwlF2SjW7SJgeqLF2UPJFGKfwB44V3wGvgYJZrRmW6RpSKKoappQFdlDDNmkO3CMOE9UWm+rCrqzic8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765470880; c=relaxed/simple;
	bh=Kb5sPDBzbRz45O2/e1QVl+xpqEoxOdQh04VoUSshQls=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=CGjhdQXWXterqOJJGGZJov0EpKFfVQSTaEFZh5AgWaCbKretspVTY7z56yYhtpaNkwrNppbW6PPz0yIFiDODeXK2zCIAoJ+FAtvZKdlpCfxcfMsdGswQc1ZaC2EL/Do7youPZgULvSbJnqDB8Ph2K3mDVUBw95MvD6B5+juuQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=J2InCX/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmMx6LHx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="J2InCX/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmMx6LHx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9424F1400184;
	Thu, 11 Dec 2025 11:34:37 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 11 Dec 2025 11:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1765470877; x=1765557277; bh=dh
	hTk/0vEqLrOHosNQNWtSKKguXjCZOE9raSgnt0vCk=; b=J2InCX/NYeuZ+PQ9Ib
	4b5OprlFRv4gix89JqcwZk5mByWEERrgDlwquVMqQBqdNvU48LAYgOUtMgjOPUJP
	h2oTBZ8rNhAG/Tuudaz7ni92tI2dbEEOgzh7k6LWP9du3yhABpy3a1Fsxk8AvRx9
	IWScIy+eltFbkIWN+oBSVyiSqAneD6Pnfv721pxNBotk0TxyE2f/iKMkL+4C0OBZ
	eraa4FQrpvXKz0TWnwqHelj++9Ou3g9QmaejkJbstLoGBazSM+vKoLSkv524VQ/N
	Wfbzq5Jasy+VD8Fth18j5sq2ByGw0ZrV5j/brHDp3F2qSssLVk6eSFUombA0mx66
	VKpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765470877; x=1765557277; bh=dhhTk/0vEqLrOHosNQNWtSKKguXj
	CZOE9raSgnt0vCk=; b=FmMx6LHxtVH9DGuBFmnDP+/Q8Y7kTr/16Z8y8+ycILOz
	tTNpIbK0/paUCtxlb6cJGRYhNr5qxfaEDJG/qThKqAok5lKLzw98v0qkbEMUuhwZ
	NCJL3UGqgmWquPq6bdOdwCfRWXyKoNtKrsjxFsiezHGHhwtKsqQXt4mBGvG0DdYZ
	IWidkMz/SAlKxBCrcPGZWwM8dzeIW95iUAlhmQCcjzilb8SOCC1jZx6RVSfYK1uu
	8PoqG3OhAtrnkCkuxRkt5fX7bP/WSpZxyeThJzd5WQaMGbaVhQVGVGtCwflA3ZfS
	lBpwHJVo88269RfAApdjyLI9rS+LsUnwM2FiS96wlQ==
X-ME-Sender: <xms:nfI6aWAS6Am46S7WoNbKwUjK8r7q6HXLD47_M_dNxj46xACoqlIpnRM>
    <xme:nfI6abXmYMTfcWuTgzh9H_giHDrYB5DayVLuxHvCV-sBS5vYg_xroFtInWtGmwThd
    Lc9107obYr2ZuQXFU69fkyJS885PEqZahGxRPNoKyYiJtQEy-6vKSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhf
    fhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehffdtffeitdetheek
    jedtteekfffgteeftdeukeehheevhedtleegieeijeefgeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nfI6aYvR26Jpanp8zKQyAYhQ5IdOvLd_sn0G4vw-6FLeiA9L_EaJ2A>
    <xmx:nfI6aTZj2bPHFqnp3oAY79XtK8pAhCU4VN4isLVpFKXtRZ2gE95hIw>
    <xmx:nfI6abU_QBaeLug6Rg9EPvA0kGqEfHCZl-oKKy7lky20Lae-w1ARUw>
    <xmx:nfI6aX6pC4E5mTBh9suuZ_qCPiiNKhaftFlyHmEgDzZvzxhIYlUUBA>
    <xmx:nfI6aUE7AV3oORXBPRU5CAZyw7eEpHtH2ATh8T9LSbVe3wXvJLo60JVl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 745331EA0066; Thu, 11 Dec 2025 11:34:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYXSK5mE1Nlw
Date: Thu, 11 Dec 2025 17:34:17 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <3d83161b-ec34-404a-bb0e-bf4da7ac1db5@app.fastmail.com>
Subject: [BUG] replay: segmentation fault when mistyping target to --onto
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

    $ ./bin-wrappers/git replay --onto=3D"$doesntexist" "$commit"'^!'
    Segmentation fault (core dumped)

I did a bisect starting on current `seen` at a0bdfe7b (Merge branch
'bc/sha1-256-interop-02' into seen, 2025-12-11). That found the =E2=80=9C=
first
bad commit=E2=80=9D 15cd4ef1 (replay: make atomic ref updates the default
behavior, 2025-11-06) (which is on `master`). I started with v2.52.0 as
the first known =E2=80=9Cgood=E2=80=9D, which I manually checked.

Same segmentation fault on `next` at 674ac2bd (Merge branch
'kh/doc-send-email-paragraph-fix' into next, 2025-12-10).

The following is basically the bisect script except I changed it to make
sense outside my own repo.

```
#!/bin/sh

make || exit 125

# Mistyped `seen` for example
doesntexist=3Dboh1eixe
# Current commit for topic kh/doc-pre-commit-fix
commit=3D8cbbdc92f77a20014d9c425c8b9e4af46e492204

./bin-wrappers/git replay --onto=3D"$doesntexist" "$commit"'^!'

if test $? =3D 139
then
    exit 1
else
    # Presumably regular failure:
    #     fatal: Replaying down to root commit is not supported yet!
    exit 0
fi
```
