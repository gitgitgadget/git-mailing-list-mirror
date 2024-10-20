Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279011C83
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451725; cv=none; b=FSWJD3cWx4uquCt1oIX2TA1IaXXUjoIBdsF91GbhwlQfjBpOSr6edyzLX2X511ZWUhwy5mI9a/wd5IolSxBMsDK4eN/b0m+ki1NtNSTkn9RoW9VLrRhOxRHdB60jkWiPLeprWolwPrPBxqXO3cB2c3zjOj6BYRCtj0QpbPMVapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451725; c=relaxed/simple;
	bh=rzNItI/x2uBVuZ2ccwiyxFHYT+2sfMc1LsudQOy46oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZX1kKaLV3M7IdzGwCeI8mp0cAzUs94ZbqBuveTrTOcdTIHTPiPp3aaKUatqfF0WjB24dsBHAkc8TKDsH7N9VlrBNr3/nIz7UQ/cSRinyO04aUFUe1CX30g3sAhlAs492tWzikuBl5QP96R+8xO8LT61LVoaK/dz6gwUBXniDZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hdG2e4+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Je91NQTQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hdG2e4+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Je91NQTQ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 393D5114015B;
	Sun, 20 Oct 2024 15:15:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 20 Oct 2024 15:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1729451722; x=1729538122; bh=74
	Mz3REe7roD6cpCGpz3OxzMwvmy8gD+iWz9d0+v45U=; b=hdG2e4+5qi/rEnJZXm
	kr5lRFY/sacyb9vMjpvuH79xseDtn7lHvhHqHcGyNh36y2dXHrxJXXEv1melYteN
	vES5Uq0RaA+MzvZBOWwPYkAEpJhMWywHqiG+wxG0XODdVEWEUKXu/f+4hbIAUsxy
	GAKzcSNZtk3SJeeTmSMOKTOqK44L1rQgPWFmzVDoX0ESrWJ974LXF8+R5++vIn3u
	RmQj7ywqtsra930Lk1Aury+3abpsLH3AAEQePwB9kpRsb9WZzhqJFhXWAm/JDfWs
	7IioTcXqcu2s4GyYTZXE147WaTn5aWvNlni4JG+R4jbWuQ3ceW/EILeLfH3NHxqf
	hOkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1729451722; x=1729538122; bh=74Mz3REe7roD6
	cpCGpz3OxzMwvmy8gD+iWz9d0+v45U=; b=Je91NQTQqiBUqsNJK21y6LwNqLP6s
	lqD7CLQNOgGIz4Ec8Bb6OGMKnO8EUBpoLNgCSxfcWpHiNYnUx9P5c5XD2ywkhGIR
	8YGtRCrBBe2oAWCxLDTy0DsQxEGZliZn86x80nHCk1QT2qjLoZDqDQl2lEUS2U/a
	teFOP4+OuBu49NsnGo6ENH7PsQhij+gjpfww4x3PlFxik4/esYvRTRw78QBGFmGx
	j2ZVohze+HsXhEwEO56YnOqm6V7mniJFJe9wD/LazCcjaq0QID+u3CU2g9s3vhlJ
	CXNdoVnMRhiXUAFyPQmOREfLtN7OUhmCa+I6gA1UNLcY+zA2cLJljM2NQ==
X-ME-Sender: <xms:ylYVZ2ZL-jl-ksjD-fN1AinOELGF8-5-8y1YgKrkkaDUYfB36femgYE>
    <xme:ylYVZ5baTc3NUK_w91YTJ01S6FUMKJlVVSMmKhHMbBipKgIHYKakM5YAftTDKzn4S
    _2Gkjtswm5ydd7iIA>
X-ME-Received: <xmr:ylYVZw8uMequd-D_maoo2iBtOTZ1mhyF_MyVTThLA5OZQUNk3AkRqNqx3Y_Kv5hsJRpPTskjuabJauBwDi2zE1HoavPj2EosAiRK8zDhzFztbjJVLnMDepPZ4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhveevgf
    ffiedthfeiteejudejudekgedvgefhhfffjefhtdevfeehvdevgeekjeenucffohhmrghi
    nhepshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegrvhgrrh
    grsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ylYVZ4qCCaPuBDsyJCzcSzR3WC7O-7vVGYUiJ5-_yYADXIdA0M_sVQ>
    <xmx:ylYVZxpV0DXY9Cz54c48RqKFWxlCNMeXFCm0SuYk89fY5YnGeUW9LA>
    <xmx:ylYVZ2Q0CJeFoCt9MryvWaw4x5_A_iy9djuPzvUzAleZxvMT94Pe_Q>
    <xmx:ylYVZxq4XSSs51miXlwGNmAvCWst5SR74EryfhBlAVlBFSpy12VQXw>
    <xmx:ylYVZ4VCtST1abCGp04qGh9QzRUMKu0hC4F1KqZALtJG8lt87knKlIpL>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 15:15:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: [PATCH 0/4] Documentation/git-bundle.txt: promote --all for full backup
Date: Sun, 20 Oct 2024 21:14:58 +0200
Message-ID: <cover.1729451376.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 63a431537b78e2d84a172b5c837adba6184a1f1b
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The documentation for git-bundle(1) now properly covers `--all`, the
option that can be used to package all refs.  A "Discussions" section
has also been added to address the naive backup strategy of copying a
Git repository manually.

---

The part above was for the-topic-summary.

And that about summarizes it.

Okay well.  I was prompted by SO questions like this one:

    https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo

I then compared VonC’s answer to the man page.  The first thing I
noticed was that `--all` wasn’t in the synopsis.  Then one patch lead to
another.

+Cc is just `./contrib/contacts/git-contacts` minus Junio.

Cheers

Kristoffer Haugsbakk (4):
  Documentation/git-bundle.txt: mention --all in Synopsis
  Documentation/git-bundle.txt: mention full backup example
  Documentation/git-bundle.txt: mention --all in spec. refs
  Documentation/git-bundle.txt: discuss naïve backups

 Documentation/git-bundle.txt | 21 +++++++++++++++++++--
 builtin/bundle.c             |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)


base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

