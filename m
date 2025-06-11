Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B02571A0
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641504; cv=none; b=HPXa53dEBz0H8ZJrkI9w8vFk6Z8FsSOtW0o7IPgz2o0ZRbVSoLdTbuG/mu+dybNOYtuhsAui+sJRLNQMbUnUfO53dyjqou1FEw4XgIpG57Z+O6RTqpZ8wBVIzL9I6DozTZUZ6VUXvo4fHwqwo4+JT60k07c/oRFr1vW10NDYPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641504; c=relaxed/simple;
	bh=qMDUQ7X9zGGZbifSoTt524SXfQhUGD/qo6APQhLpukk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uNh++MOy3SNf0eldDKTeJUfdgCfDT1K4YQRXY8eytaT1EZvldjGpsJNfXhJPOY5lmd2Jb1IZvLMdPKWJTjbmMT3o8iGsCN16ZSMVU/06N+3A1LA/iWlqZGhrowvQTPOOwsob4r5JdEq0L+k+q2XNlhWLlmrieja8SaN+fhrYwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LO07CmRS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g55vBCLb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LO07CmRS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g55vBCLb"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 629351380090;
	Wed, 11 Jun 2025 07:31:40 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 11 Jun 2025 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749641500;
	 x=1749727900; bh=LuV9Dn76IrwUnevBXu6LnpYhFLaP6+HFDMHHOvcMCyE=; b=
	LO07CmRStFGgwNxNXQEkSuTclnPt4F4NH7xMADVCY5oDalx5aOnUSLS3ORRtBF1X
	kpgpGjHrBv4lm8rjH/NmzqTMRkIbixoVi5owHVS0zi0RJAazCjzDkwpzMZ6HeMTq
	FTXUlDtsESkh3rZwRHCqgGMygrZFF+22QqcOriPmrvzbJbyJECmnK7Anatcd4+o7
	wzhTIzLprLQzpRplFQo3iD4JV/k/P+AbVW/K5Gc3noDyUBmEiOYB90TswHX0txDb
	FWRapWg8ADDx+k2aPkQBXdmLxypqKHMYZPX6X1QP/ULSodE3w57k4eiQSqMXi7zm
	YbV2LsaUMxv+Lh21h9LByQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749641500; x=
	1749727900; bh=LuV9Dn76IrwUnevBXu6LnpYhFLaP6+HFDMHHOvcMCyE=; b=g
	55vBCLbEi5kJlE0LNXdvWtEKUr+E6TRwgUpjC/Axa9M4kd3S4Nx5XfcT2YIVkyxr
	y/SJzLnutz+G+RA7pXzoqS+BDPtu4mE1kahxP9bf2wFT/3MplPSQm+ZisVTwS93e
	tM7xmcp0+0xXTbUnUeRKYW0faA9uJWKONJe9p1r7TStPGN7IAK6KZU2ghUs6vTkh
	1oF9vz++kmuRz4rbAfI/ZkJHSGC2zlS46EzvhgKOtLjE4zf4VICY2DCatyomKIRf
	MCLXRR8jUIkOJLOicgzzUm6jIE0DyHkDl44aEWEIsAVOu/VUPx3KjKAE2e49HYQb
	3r2O2xsQI1noI6dchd+GQ==
X-ME-Sender: <xms:HGlJaBQ5S70wDIKp5EVKrUNa0wnyjWzkBMkb_Lgj48Ed4tU9wmyeQQg>
    <xme:HGlJaKxhtWx6SzbGhqoUkWsFxDi19yRviaw7Sk_tuNM5blto2x02K2cUla1AZoAlp
    Ztfn3jdLGg74_82wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HGlJaG1262iRW6d9R3jrZ39gogz9hHnkclG0SznSky2v6VyezWH0eQ>
    <xmx:HGlJaJDGBjAowuFxNGWZNmCilcb2rhoVJgceIcECNIHSv0ARZu1XwQ>
    <xmx:HGlJaKivS7Ll2LU8id_8O5GOePmzgiYTBYcjG-6lr-m2nFGYnOPWNw>
    <xmx:HGlJaNpW0QloXo6AC4weZok04f4TeZhzdadbWuaOGFay7EJrGuruSw>
    <xmx:HGlJaJ2jUTsAkirERtiRP6VBUOj_N_Kajrd_qmHTXhrKvP_FUIFCIYHd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 063D61EA0061; Wed, 11 Jun 2025 07:31:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tce62894c57363d57
Date: Wed, 11 Jun 2025 13:31:19 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <8498845e-3580-4f37-b60a-8f32c5d41f15@app.fastmail.com>
In-Reply-To: <20250601223225.464076-4-sandals@crustytoothpaste.net>
References: <20250522185524.18398-2-sandals@crustytoothpaste.net>
 <20250601223225.464076-1-sandals@crustytoothpaste.net>
 <20250601223225.464076-4-sandals@crustytoothpaste.net>
Subject: Re: [PATCH v7 3/4] builtin/stash: provide a way to export stashes to a ref
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I only bring up this minor point since I read that there will be a next
version anyway.

On Mon, Jun 2, 2025, at 00:32, brian m. carlson wrote:
> +--print::
> +	This option is only valid for `export`.
> ++
> +Create the chain of commits representing the exported stashes without
> +storing it anywhere in the ref namespace and print the object ID to
> +standard output.  This is designed for scripts.
> +
> +--to-ref::
> +	This option is only valid for `export`.
> ++

The existing options say =E2=80=9Cfor [the] `<cmd>` command=E2=80=9D.  S=
o that=E2=80=99s a minor
deviation from the convention.

--=20
Kristoffer Haugsbakk
