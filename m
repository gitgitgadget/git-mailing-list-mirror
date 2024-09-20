Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D51BF37
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853495; cv=none; b=JOhwOn5bLa3kxpxBOJW480RpJSOod8QoDYQEDCmsGUlrSmNg8SWW9NpuojZxVUz3hxY72S9XAq5IzEgXJAIDbAvzez8PQT/72k4n3PVWZuutZJFdAiZIn9iraJK5jr7ZdJKQGCPuwVH/FutXMJ6t7U1SdKUD11ywKx+qsXOiPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853495; c=relaxed/simple;
	bh=B/slf0QvhkGz1a6I87oMxyR5hSV+1AfOKKoTlh3L1nc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=pFcsOpx+3zKXnpFfwHPB1ptgIAnlRLFvsZJO84L8VwT43z0vvj+8tbrnHUNLCyOOIpgbiYadsKnov5Aze9MYuYeIU4jIixAhi7Ys0WdGHk1h7w3qgwG1wX+wKHi+kBr14PQ3nVQ9xYNu7LE564DjsByUR6IhK2vfSZl0/U+TBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CHOIY2i1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EeBPYAUJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CHOIY2i1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EeBPYAUJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4268413801AE;
	Fri, 20 Sep 2024 13:31:32 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 20 Sep 2024 13:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1726853492; x=1726939892; bh=VA
	sN9CCawi04emSINXU0fRXKWWd1SeZAGWrbGPxvOas=; b=CHOIY2i1bAYFGl7j60
	ACsbYhl40L9A8lFwLvlSYG17XX0V2QevhLjS8KOjgM9oYkJp40HT3NmkkXp0pTg0
	UjN2BOVdwPGoSu35Pgfd9hDJacvbJAy5mKWerxLCjWZim+veTxHXDMY864+VjvlH
	EPP1FdeuXY8nzsOvGAYkqiiLiOJvG/md8MPJHA53tyjm99YQeZ+oc7ZVj+5c6KmF
	Oedi7FRNQcupB/RRkY4Yk346iz2QQuyMGq50QuTsHCHHNgyPTYILDPzpHgqrSjli
	kjor74HOzqTSNtQ3HqjPSMCdbI1kpVYfR4NlujBbt//AM3thvvxCYMSdD5pCld/M
	5wfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1726853492; x=1726939892; bh=VAsN9CCawi04e
	mSINXU0fRXKWWd1SeZAGWrbGPxvOas=; b=EeBPYAUJnm7sYeEFa0jDMKLkII929
	BhJ9C6oFgt6V1d3qaqHb4uWGy41XZx43ByE+k+vlyWzihliu/sNhaY1JbOXgZojZ
	2pbj4BY1PIu03pNPRxJKlxb+FlvpiEN4Y/fnp4odNwaiSV3tiZeH50CIIN95OhS9
	c8tGjSoWtFv7bFxm4cO2jkSC9bTL0qZjLLiZDUQVrmFFCchzf5fHWLfs8t1DoZuK
	2GHO/7QYixw8IYSFee3KnUxM9h1bbR3qtJ0Rg8uCWOK0VShTXQwA1vjRbMCDAl00
	B1yQkW5teXQwGRefx+JQw3cHfmrfeWgLorWETDLH/r79KXoWLzzFtg4QA==
X-ME-Sender: <xms:dLHtZjBW128YP1Xw9vCVS92KM8AbDkah3aE8x0EkEdTudHW_g66ofBE>
    <xme:dLHtZpjuVHKr7PfOGiwJHIQtA6mg9TPyJ1UYqF_Bskq2RsypniyEWnITR4BGIXiS7
    NwFWoCnoaYptm591g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkffutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepieduvdfhuddttedtkeeguedtgeej
    vdfhfedtgeejleeigfekffeljeehheffvdeunecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dLHtZul-Brj56Z9g4xSdbjMDudyfpv53SALgNGZzlGyTmmq5GYxABA>
    <xmx:dLHtZlzLeIJWIdwDoJmE3Pe_hXA7GZJu5td2PYpKakhoouLEiRtEsA>
    <xmx:dLHtZoQCN5GEhhvPV_1OOgSp6S_2C7Ay1gALNyqrqTQd76OZFk0QoQ>
    <xmx:dLHtZoZGRYvehoF0s7WdKd7kj30GuKqtZIRRF314qePL4ZRTGUZiYg>
    <xmx:dLHtZjdchvjKMQeFexFLoWrtmrSKoM4UGw3JYieEcZhvDPwH7o2HRT_S>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EFA3A780067; Fri, 20 Sep 2024 13:31:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Sep 2024 19:31:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: me@ttaylorr.com, git@vger.kernel.org
Message-Id: <16dd8441-b828-4526-8d21-76ee834b398c@app.fastmail.com>
Subject: [GIT PULL] refs/notes/amlog from git/git
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I have noticed (a couple of times now) that I=E2=80=99ve used the stale =
=E2=80=98amlog=E2=80=99
at the GitHub mirror. Maybe there was a temporary maintainer at the time
(see the bulk of the commits).

I merged git/git=E2=80=99s =E2=80=98amlog=E2=80=99 into gitster/git=E2=80=
=99s =E2=80=98amlog=E2=80=99. That adds 193 new
notes on commits that are reachable for me (presumably all on =E2=80=98m=
aster=E2=80=99).

PS: git/git=E2=80=99s =E2=80=98amlog=E2=80=99 could be deleted after thi=
s is merged to avoid
accidental stale fetches.

---

The following changes since commit [no common base; unrelated histories
(squash: cd046fc8b70 (amlog, 2022-10-23))]

are available in the Git repository at:

  https://github.com/git/git refs/notes/amlog

for you to fetch changes up to d3d558e9824282479562a721e2a2a1cbbcf7c016:

  Notes added by 'git notes add' (2022-11-18 18:30:49 -0500)

----------------------------------------------------------------
John Cai (1):
      Notes added by 'git commit --amend'

Junio C Hamano (31):
      amlog
      Notes added by 'git notes add'
      [=E2=80=A6]

Taylor Blau (588):
      Notes added by 'git notes add'
      [=E2=80=A6]

--=20
Kristoffer Haugsbakk
