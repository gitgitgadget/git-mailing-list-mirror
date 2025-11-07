Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BF2C1595
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521150; cv=none; b=tQXIfllkwBoFKYnuMbR94A+8OZpHY8o4TpU0V+inE5tUQEwwZyh3Br/5i/63Rsd0Szn69Xc0jPVoVdWxTMeGJf+NFubZtT+ZuXB7YrUNPnaMMojCh6oukCgWxRY4qGadKpOFWtFwJqskgpour2qT8k8yOcKfmCh1v+D+CqTw6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521150; c=relaxed/simple;
	bh=+BiZDn/XxDwLHVtLiqe3V06feK3bMw9ophp6vqEBBQo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nurpegZKqIwOqhWVWbHVNwFLQEg8axROc94wE9egGCWva1B1qUlnOruA+d0vZEA+Cdkv/4wTDMzFVSC84cfUg0r6Z0YsAmi9wQsHZTUd/DjiQFAOU0Zg2BrYy+8Ve9FqC/80dxTLjldE5yNrID1wPcMk6RXMKxYU0Bv4BK+vppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=G1U4p1Ft; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tqeAE+lf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="G1U4p1Ft";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tqeAE+lf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CFD3EC0206;
	Fri,  7 Nov 2025 08:12:27 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 07 Nov 2025 08:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762521147;
	 x=1762607547; bh=+BiZDn/XxDwLHVtLiqe3V06feK3bMw9ophp6vqEBBQo=; b=
	G1U4p1FtfX/8o95w6yRqc7BvibuEqqo3XegAaAhhusMf65xS+hgXvR8EHjGXtbCT
	I+IT6LC47JOZLL4oLeKwTa7NwZRpA2n7WTDWExhoRRNHsH5rpHiTFtSKVbPDmqyk
	V+8wYYLvOzoXvk05gBz13pmgu+FdDhw4WQrG2f+imwKYr7AHV6moNT8XsLlBuM4U
	FXHOw1d/opsYPHqOVKBghfGWvVo+YXygAeZwMMynbFzSGsDsi7eVTrk2wWzcTonV
	4muolReRLaldorx/UqTaR0kGhmsIq6wWm99Kyl12LYrI6xNREsFQ4cboLKb/9bUo
	MIJG7AOWv3gF2Cf+7l2SbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762521147; x=1762607547; bh=+
	BiZDn/XxDwLHVtLiqe3V06feK3bMw9ophp6vqEBBQo=; b=tqeAE+lfKPP4/TZBR
	9IVhiEx6efRKposoYCjrXKpDIzR1LMYgoIPLigqlMLPSdJqiU0lqJUuGW1Gk2pm4
	siUNBktl1+HUu8+rqymHaynwksh6fNIt/HY5WLknkr9r/mZzi4p7A7KUGv2H9YZQ
	KbBxJMSd0ysCyNsb3Upj8Hxavn+H2eyXYo4tUwUKi6YmZXNs3SWUu2EbEXgXSIG2
	Wfy2J92YWzVnpgitNgtymbnq0FYkH1NmJyNm5MyGaVhnuCG4sodGs/RLetlPaCFB
	hCpHqFEa6MTzw4J6meN/YBVnRWBmWd9x+uTo9Ulidet1sSevYez8xnZbmM446pWS
	s8q2Q==
X-ME-Sender: <xms:O_ANaSc8VETyEVKSpzUEFojkced_z3ob-oaa5-Kxdguuv1gIPOhg7Ec>
    <xme:O_ANaXB6a-cI5tR3v1QjDsrpJmLUTlbnSOsoBdwPDoBgtR3ks3Ajs6COu-IcDY1Ok
    4FfLObfkRlE6HfbT0EPyfcytui0iZaKPZHBWVK039sPMkYZpmph>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeljeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdfhjedvgfev
    hfdvjeefleelteffgfeuhfeihfeuuedvfeevteekteeugfehtdenucffohhmrghinhepgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgssehprgiglhgvrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:O_ANaRL70d4GSlXtWZ4yAgQqem_pSsrvuOliJlcJqGzbBDsxJwVcvA>
    <xmx:O_ANabFbbL9z3XT3hSIvQm8l2agJZFBFC-fn8yQqFf-ScLobNMDMSA>
    <xmx:O_ANaRSOdsprx924o9iL7sZ-Hr2axnxBkBaf29EFIuy0GT57UVQ93Q>
    <xmx:O_ANafFhKKjLPjFqRrs6Ixlgiype3bkka8Vzr7yLDlh5594w83bN7g>
    <xmx:O_ANaXlAUZ9SvEyikA9bLZ-OMUV_kIzf1eY6n1wgihJLCTDd31RK0C7f>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A3AA1EA0062; Fri,  7 Nov 2025 08:12:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Awswnt8A2oaw
Date: Fri, 07 Nov 2025 14:11:52 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Franz_Brau=C3=9Fe?= <fb@paxle.org>, git@vger.kernel.org
Message-Id: <671d53bd-952f-4849-9e5e-910e49d4c4e4@app.fastmail.com>
In-Reply-To: <20251107124041.d6aac4345e89a9ac092c59e3@paxle.org>
References: <20251107124041.d6aac4345e89a9ac092c59e3@paxle.org>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025, at 12:40, Franz Brau=C3=9Fe wrote:
> I am using "git whatchanged" on a regular basis to understand what
> files specific commits touched and in what way.

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).

> I vote for not removing this functionality from git.

The intent behind the message was not to cast a vote but I can totally
understand it being read that way.

See: https://git-scm.com/docs/BreakingChanges

--=20
Kristoffer Haugsbakk
