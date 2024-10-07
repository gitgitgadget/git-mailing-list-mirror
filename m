Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5DA2D
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302578; cv=none; b=XEUZeR0gde9Pa1OUmUpEHoU2cdeEWQqS23QrQ3ctNpQtVtEXumWVjvdQiGMBtpwvIOR1mxlkYTO39sh8VIWj/YKIyqLuhKMxX36iG5JSeDXpYsqKVTxk7cN4oQhSLPkc7+LXo7DRs6iB5sci4LpTQz1gPVBtWgTnm3eJbfarVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302578; c=relaxed/simple;
	bh=PUlqOnZn+hwYSfnmW9M75OPM7+WBmhyUcyPSuGhc4iA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tfg2FTn0EF2n2ls9xQgftloZ3kr208udURsU6BUDecWxCedIkjwltp8e7JLlhd469e1k9jvYqHq4NbvWuOKcBkMC4aaRK5llOEe5X7OWM/2Le4a1PpDh3pcDDk4nA0EMHjtVbPfVo5SRAnOzmojoToN5dyUBvLZVdJQg5figdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KmwoGA9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WzMIdhUU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KmwoGA9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WzMIdhUU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D27CE11401A3;
	Mon,  7 Oct 2024 08:02:54 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 08:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728302574;
	 x=1728388974; bh=9114pob06RfF5rD3K8whrjkh5niP3aWDprjTMKJzwBI=; b=
	KmwoGA9yPGud0bplNxcLsVSZ4+rNLU7JM1Nx7ORyHut5qe3iyrF4GiHU6IsJQf+V
	DZKxX6LrfRrO2oxyRWyxox+e5TPRtb0Gyr+2a1Jm5EF64miCqN27NTqpnh1Ouvlm
	M1ojihwQ9R/d0QTTCyl3iZTo1naHunXYd4fsavwg9WtxHg5hefE/McZpgEWuCzeH
	WNeBOEZfr00d7U60GwavI96DErYeRTFc6Devtf/GzmwH66G97Hy2usrLSVSM5kqG
	+mSAOsDVHm7QfewsaPl6BoadTUE+WfIebuYpDmjbx+JJZ7kjN5uAzk/oQqulSxlu
	YShnBW6gwE0r8HBxA0xpyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728302574; x=
	1728388974; bh=9114pob06RfF5rD3K8whrjkh5niP3aWDprjTMKJzwBI=; b=W
	zMIdhUUM7wVUO1Fahcxr+/s2ZP2D8wIOimxJ3qS2/Irq9+rIRD4jtF0hPFx9Rok7
	ONIauLzb/PKZfyDwOqqo9D8WlVavgSjS0UvguQKOEp4Ujq3aoClwvdX273PI8QI0
	xFmA2J9Dib+aLG70A608Tx7+nHC/ICicEEYVtDwTAq3bCLSvqL/tpsSUxUn4NiZT
	8PVBc3hBhc1kuYVsNesD1ANAu22Xz2H2MaGMChVxLRfzTieU36hohWws7P6oDnsI
	nBnAsyome4SCcgRu2hkDPXjawI+423lXMxRFhLsC/tPoniUM8NwMbeZxYT3F1HDe
	9itcl2tB0HA3sEhJNsuVg==
X-ME-Sender: <xms:7s0DZ2ml-TFXfn6UdgIy7mFd9aj1iM7laPeStGI33TrrftG493pRCew>
    <xme:7s0DZ93fqWTuw7FwQsYs_ykfMseLUTksGVowwbG7j6q7E2w1Zb16-eUuhgFLSY4cH
    bDtRtmlQ5j7_wIQnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7s0DZ0o3kXjiodY0k0qvKbzt7AxWBy7yP-sG998eiHYKIBi6-FGIqA>
    <xmx:7s0DZ6lynDZkZNbt5EOT3hF01hJcE8DTkUPpAZ_3O1VybpRzAzJJXA>
    <xmx:7s0DZ01ssE0zAST5hpdqsQRtjtNUAnXFW10XiyZQ9jM89GnXc3ekUA>
    <xmx:7s0DZxvnTbPy9MtuoABEPf_mnPAm4AckXtdi9bYWgKCwxjOwLJebtw>
    <xmx:7s0DZyDW7c3tTwMhCk87SuaHeavrKDOXcnvDp9cXqENl32GUe2AcQ14G>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D512780068; Mon,  7 Oct 2024 08:02:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 14:02:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>
Message-Id: <b41ce281-d3b8-43c3-8b27-f5dc59601ca7@app.fastmail.com>
In-Reply-To: 
 <fef203471f4492af1468a0c91088324c394effd5.1728298931.git.code@khaugsbakk.name>
References: <cover.1728298931.git.code@khaugsbakk.name>
 <fef203471f4492af1468a0c91088324c394effd5.1728298931.git.code@khaugsbakk.name>
Subject: Re: [PATCH 1/3] doc: merge-tree: provide a commit message
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024, at 13:10, Kristoffer Haugsbakk wrote:
> From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I think these got double upped since I used `--from` in format-patch.
Then I used send-email.  format-patch warns against that:

  =E2=80=9C Note that this option is only useful if you are actually sen=
ding the
    emails and want to identify yourself as the sender, but
    retain the original author (and git am will correctly pick up
    the in-body header). Note also that git send-email already
    handles this transformation for you, and this option should
    not be used if you are feeding the result to git send-email.

So under the normal use I guess:

=E2=80=A2 You have someone else=E2=80=99s patches
=E2=80=A2 send-email sees that you are not that person (because of your =
config)
=E2=80=A2 It puts the From in the message body (it just works)

But that wasn=E2=80=99t the case for me since my ident is still the same=
 as the
author.

That went over my head before I sent.

--=20
Kristoffer Haugsbakk


