Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AA847C
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734790739; cv=none; b=aMSbEM9pYF4C1x9QjQPwqjne7f47pCkfmpL2aJRiJ73TzBYmtXSYXh8yIgvbBsTmBO5e6GwgkF0G+xLIyQx+Z/R8qzsXoJo2noUNu8LmkmDA3m2jSEucZcAZROqMt8wGnackKf3A13vPr72NplOo8RpAiCo3ozZp64a+ewUMNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734790739; c=relaxed/simple;
	bh=1wRB8pQL581lxDS600s0kikpFW7l3sMxIsPfBychGP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S04srasOQzhwZGNlrwfaPAatZfe4zZjetWevXe82UbzYEluiun7U7WuyRS0JM0wM+9VYB4XSkugtbgrjstPkHeBAjr3XqklFpJwfK0uUPy9Mzk1LaM9bVH8lkZ+mdpXxejZMmhyqn+b3UJH3HNB6/FYBJCOVxS7+/EHwpFXaHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rbh7W6s2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kRxX5i+M; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rbh7W6s2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kRxX5i+M"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A1EA7114007F;
	Sat, 21 Dec 2024 09:18:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 21 Dec 2024 09:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734790735;
	 x=1734877135; bh=in96REhKJUodjLUZtXYtObNeLn4S+YsRXjb9RHf5LH0=; b=
	Rbh7W6s2bHZIRyy4FnPVV967Ky4vr6m4rpM6spNVYyrFtcADdeHzHrcjHHSJpV6A
	JeSthM1q6j06wQTGbMGMzzzJs9W0/VBFccktiYIztAkG00/QtgqGZa7NeeykXeY5
	Hqq75wILJhOnPKNBQ9mYh2QmEMRY/71Or1suaZRVi47fENtC0tnCho5W7KnA60bo
	B9UEQFeYKmx7ks3yPn9ZcOhe6vM7HHMxlRf7tAzl24RlTm7blJ45Yix2gpzpWCQo
	Qi64DAyzVjVlZeIE+G71vmP8xDABX0BdwedlTBxKy+exNOsIfY0R3SqsOWfwxzbU
	rZXXGVkU1ipfgmhjWgrJgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734790735; x=
	1734877135; bh=in96REhKJUodjLUZtXYtObNeLn4S+YsRXjb9RHf5LH0=; b=k
	RxX5i+MXIbf4WrjlVL6YqTAcNFzlUGUO0271IBj3fHy9HWyNJ0vVkMlPvfCpI1lS
	nOI4DHZ8q2qBml9+IA2KkNIWqf7stTOpNXp46BXk3ObVjawbGSH+HSkf9BUiVkEk
	PitwL6fdXLqV8HX8IOp93VEBmTp2eRY80Rp2d7YE0rZdslQRvOtwtcKhxnoRzRBm
	4mL2d9cB47eqQ0YsOAk6A8tAR5y4CEUlh/Ua9ALzecZtj3Ny4atLNz7Qrd1wP4hw
	cSgt/rq6dc+KI6vz45deGyyO0EUs7hZr2UDhtRyrPNZ/Xb5XkgpweOIiuRtnN6yw
	lQhOWxOO0yTaQ/e7Pw0Pg==
X-ME-Sender: <xms:T85mZ4buOS3GnDZ3zemIfZcsHe2uz2GfQh5ykIpIjb9MA-eNCi1wTQ>
    <xme:T85mZzYPda0LfR7r1NRYOYJTiHmXPUwmjZ-hyC865o_3D0NLMVxDhYWXLeDA5e750
    wKheM4X4QE4z0uruQ>
X-ME-Received: <xmr:T85mZy9Wqtfq56bYc56Lt8F56YhN4h4fGQ4kRga5LpYrEn_jy0wh6JVpNe8h-HxQWfLPGbwGO-0amZLTddNDdes2mTJuaFUwFg_YcOYlP2Pfog_SMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:T85mZypYLFcbBX3XoPjzuM0KFHApdXgusrQXxlwDY0XJFR9e5S8y8A>
    <xmx:T85mZzoKE-TeOyVi7Edw7mjgSPq1OSyajX7JCPTu79upKqAWeXSTOA>
    <xmx:T85mZwQTqnEnozMPTsXeKr9jFqoLvTLBZtQb5_VPG46Vx4k2M0IPAA>
    <xmx:T85mZzpCzaRAmY3vR7rOxadRMaVdqXsNhl7NbfS55JTQlnqmqP7Eow>
    <xmx:T85mZ0ke66daifQ3lF8Mi31seyFens-BDHnlWogHag-diiqP5O6-eJ-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 09:18:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 440452ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 14:16:56 +0000 (UTC)
Date: Sat, 21 Dec 2024 15:18:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/4] reftable/merged: fix zero-sized allocation when
 there are no readers
Message-ID: <Z2bOOn4Oad9b9Ycr@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-2-12db83a3267c@pks.im>
 <b4ba502a-b689-4736-9712-443a137b5d2c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4ba502a-b689-4736-9712-443a137b5d2c@app.fastmail.com>

On Sat, Dec 21, 2024 at 01:40:32PM +0100, Kristoffer Haugsbakk wrote:
> Hi
> 
> On Sat, Dec 21, 2024, at 12:50, Patrick Steinhardt wrote:
> > It was reported [1c
> 
> A Neo user, I see.

There are dozens of us!

> s/c/]/

Oh, I even saw that typo, but obviously forgot to fix it.

> > [snip]
> > the result. Now that we do we notice and thus return an out-of-memory
> > error to the caller.
> 
> s/Now that we do we/Now we do notice/
> 
> Repeat of “we”.  And “that” can’t be be used since it has nothing to
> connect to.

Indeed. Will wait a bit to hear back from Randall before sending another
version. Thanks!

Patrick
