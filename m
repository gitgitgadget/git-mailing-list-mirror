Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485481876
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333236; cv=none; b=chXGqGOGcYidN54GCTVYS8OX7nSfEZ5kbrH7jBb7rd+ZIlXnfDfqzNeL8xE0M3SoiMu1DuJgDjo7rcdXdL/utNKafy7VW4Jo1ZwSIJVENr8ylrFB6zHk3g95sJ9hMxbv6+/a3bZWzbXNXAoViCzfKRmoS0ee02Ggf/kKlN4B6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333236; c=relaxed/simple;
	bh=42WSCkV8gxIstHJc2y2NQnxQSOc70CAHzV4WUQaqTk4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=AZMyG9Zk1xEydcETk36Z1sPmhTK12nZ0kiTl6SYrj3Od3QOv8tqItTw1KLXRCKOGzhERXYfH2fsUWeSmYnR8XoczmThBD3qrJuPqeqV1wWeRG4MQlfr0g4JB3t4qBVozUK8KN8szdRGbvoyaSKhJV7Z6XtvjVdFgBogaAuyp2yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=BxRzxbas; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nvb3LpSt; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="BxRzxbas";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvb3LpSt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id B197A1D40839
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 16:00:30 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Dec 2024 16:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1735333230; x=1735336830; bh=zO5FTVnrST
	QOky63FeKdUTMqbG7FADDVcPB4QSRhAIA=; b=BxRzxbaslmfTZe3NKr/wpLiiwt
	siTuhtBEkKb2t3O2O3e6cV1kHPX5nXRSt9ZEInDzKfTSrepBxuCio3tacpwOygl5
	a2yt4Bj4pQZMjknJdeEZhOEYkAARLteK8BkAls5vBwyDF/1KmVATjaTd8MjXXGb3
	v4GluUl0eGj+BajUQ59w97KZ3vz2EFHFUq6M8HufvafzUBFfTAGH1qVcpS+GZBkx
	XR91kpuEw516i2L39ofyytUCg/DrdcTAvxz8sE7EdatAfJejHkqIjYdWfoXiDw96
	/6pCPVsnZxHc7apwW1vHYvbNIppgzN1/KPO6BXOYd3EYF+T399j8OXLacjAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735333230; x=1735336830; bh=zO5FTVnrSTQOky63FeKdUTMqbG7FADDVcPB
	4QSRhAIA=; b=nvb3LpSt2QXVtCtRWnXISzdHlqvP6elpIzg+L7z5cQuECHxUXlg
	RdPi3Z5DebOLwaYLZDEiTehmBMuUQzwJ5s91nV8WwCI7eLhmkNpVPPzv0UMZflRk
	TYX+3GNvdl57EGLC8n2NeEyxm9YIs561+GXyw/4NjOntkoOhQpjSKDPSFSB4RVTS
	RvnGpeHeeAt0EL9/TKUSuILUNr4PNKtHnkIiEjdRp2CrV27/XsQ/fKG9lLYyn1Ix
	Zaq8QbNf/7C73Ev2tcNjFPrmQm32YWqGYDhVAR2I2qE2fIHHx3ZhTqSMHsCGop1/
	TDj0VyszWmv//PsvgCYBga9gzPbqAnft53g==
X-ME-Sender: <xms:bRVvZwgK3v-UpoFsQH7Ra_Li3K0Tv7bUiFdILdkMHYpUUCKTx2Tr-g>
    <xme:bRVvZ5CR4-XrIqTdLX5i2EkOnhNxEfvr0vYXbiCkqUqYz9SnPLpjdTBBXKcLeahRx
    yQ-0gOhzgjOfd7qC98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofgggf
    gtfffkuffhvffosehtqhertdertdejnecuhfhrohhmpeforghtvmhjucevvghplhcuoehm
    tggvphhlsegtvghplhdrvghuqeenucggtffrrghtthgvrhhnpeejveeigedutdffieeghf
    fhudejfefhtdekiedutddtueefkeejgfekueeulefgteenucffohhmrghinheptggvphhl
    ohhvihdrtgiinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepmhgtvghplhestggvphhlrdgvuhdpnhgspghrtghpthhtohepuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bRVvZ4GyzF5ktNH1WQ0kmg3kKCMPyGNY0KJAcBMUV-PY2JtV2mysbw>
    <xmx:bRVvZxRTV_e2skMFSEYSUXF2XcFhquLjGlfR2S5aueOqCbP-mJFuEg>
    <xmx:bRVvZ9wbhu-lolSv6di_CkTRQ-n8Cnmu82oWw5JBIh4lZA4E5aJk5Q>
    <xmx:bRVvZ_4g2HB5PAyj6wdXlvNSJ3sUdGNO84WajB4zTjQTR61jjZKN0A>
    <xmx:bRVvZxibPXMyFREwT9hgRf1CSop85rC4ON0x05SiGMQphQbcP6DwVgJp>
Feedback-ID: i8c5e488c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3BECFB0006A; Fri, 27 Dec 2024 16:00:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Dec 2024 22:00:28 +0100
Message-Id: <D6MSAFOGX1QP.265MYAA4V7HW4@cepl.eu>
Subject: Could git rebase be persuased to update .git-blame-ignore-revs ?
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: <git@vger.kernel.org>
X-Mailer: aerc 0.18.2

Contributors to a project I work on suggest to introduce =E2=80=9Cthe
official=E2=80=9D .git-blame-ignore-revs, but I am hesitant to do so,
because of my fear of heavy burden of maitaining it. For example,
we are on Sourcehut, so there is a lot of rebasing on the topic
branches: could git rebase be persuaded to update it?

Merry Christmas, Happy Hanukkah, or anything else!

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@en.osm.town
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
Necessit=C3=A9 faict gens mesprendre, // Et faim saillir le loup des boys.
Nouze z lid=C3=AD lotry =C4=8Din=C3=AD // a vlky z les=C5=AF =C5=BEene hlad=
.
  -- Fran=C3=A7ois Villon: Le Grand Testament / Z=C3=A1v=C4=9B=C5=A5
