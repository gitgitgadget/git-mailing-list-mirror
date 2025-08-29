Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD381BC5C
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452772; cv=none; b=LMkhwyHcDiDw2HWzqo+bhPiyz6X0gZdPZ5fpSIsa6xU7ZvWqmAiNAcipdSFkOAVC+nhW77u4SLtwXO4dauHss0u01WFho0iTG9LqSexQOyXui+bBRhP0E5DxVMolIZaFnOXOP1l+aPEjRMC9wNiLn0/MOSaRj6FLtCvTGD1JVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452772; c=relaxed/simple;
	bh=bPAYZEapaADE1kxzcOzLXSH3oVRuR8uUfB+cUgLHkEE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SUsMj+M1xvpqGpTXl5kg3QGmA5xDnXosMngYNgzc8JlmzFFR8OoIag4i82IkIj0vsjdM2hxPkqxNw0UPbqLvGeScW4tGQgVOooEv1662XyTGCc3PnUZW/XXe4xBtPi8hT5+8v3RSSWva2BwaLWf9gSc+DyEDklTIf6sEaeXlPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=El1It2Ia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOuEqx4l; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="El1It2Ia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOuEqx4l"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B40C77A012E;
	Fri, 29 Aug 2025 03:32:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 29 Aug 2025 03:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756452769;
	 x=1756539169; bh=qppU2ZElzMUF8HxGs8sX97IZLK4hXjWfzXizfuQOC6w=; b=
	El1It2Ia6w1kjCgAYvVGSzZoALE9DrELTXdvUOXkZrGm0nghsGSGwBiCLFAkOEtP
	kb0kWlVAq8nSCiefpRyyN4PRRlCO5tQh7HXs7Bhupam0eJz/tcuU4giWZD3tJyVY
	/+Rp333D38v8mB4BEBqH4/bpXQpNPp45JH3AK2BrJPJX+FJb3OqYl9nvZ2Jc/yu0
	J0txeOAf23JsRUW2L6bJdESCqlcsfKSVqLxqW54pX3GYNsOD8RWNwMI2FmTxmOP5
	e2RLFzisM2CZ0DvVaRtKd6d9HxeLePjQBMc21vvAVq8s0l6hA70w1wuRZDrg88Su
	/L7LFcQaxvZLU31N25PcOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756452769; x=1756539169; bh=q
	ppU2ZElzMUF8HxGs8sX97IZLK4hXjWfzXizfuQOC6w=; b=iOuEqx4la/tR5eCkN
	3gC20Kn8gaji22FQVdjW+Q0QuBs+zV6LiNxiRD2f99y9VvzvfiQcO/Z41dsMlDrZ
	1KQKQUXR++F+OSzZuIhiEN15H3Jdi+sCEwLXHBfF3WnjPLValA0aKFX39hZAhuIs
	x+oXJcUrcIoPYDQiWN6vfVTe8Mk62MeByLA6EecqWL/rF7MCEo5/mpUwLHusGeM7
	Kh23OXyKgAd7DdXnO04fhhDmfpHzWQ9MuG9X914lqoLu5+3djUYm7da7q6uM+gyo
	lz4faWjUq9nTM63uU7gZiNT0pTiIVljgcKpPqw0mYZkXp+C/HGxq7U542CT1xoyD
	jOhZQ==
X-ME-Sender: <xms:oVexaL4F803vAAfmsvcwQecAqfaXpv9ir9q74n4o41zL_vkDFvkJNHE>
    <xme:oVexaA5CwN6y5vnePdBNxqPUArrmpcpZX7fg4UqTIVKV3tUFKzbY3IFCqS_JOPxt1
    M80Ti8DvTQ0UJfwNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepffejkedvjeegieegfeejkeegleevheeiteettddvvdeghfegheeg
    leelleevffdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhhmhiesfhhrihhpphgvrhihrdhorhhgpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oVexaH9WRTYnVXzD7Cprw3uC8iV8pWtM5Jga0y8eVWR3F2BPeai6TA>
    <xmx:oVexaMprFjDcTpKFLl4SR2SEXmzjlNidSENg780oN_UyxrB-zODTyA>
    <xmx:oVexaG9MM8YZPhRwEQ9G-87yRdXJx7x4dJFVPsnWOcX7MVhnDKFtAA>
    <xmx:oVexaAX4aw51D5AJsw6KhqdJCtTFKEEueAcVkJ4H8noW1WhmSO83mg>
    <xmx:oVexaDOhjM8DyXnljbslPFjvDG8EwlM_K7Ge2Zn6nrAJ5wxCEBWIOiy5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F9E81EA0066; Fri, 29 Aug 2025 03:32:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkMA6QeNSR0c
Date: Fri, 29 Aug 2025 09:32:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ron Yorston" <rmy@frippery.org>, git@vger.kernel.org
Message-Id: <aac16c10-df63-4ff7-af39-954e57b112d1@app.fastmail.com>
In-Reply-To: <68b14aad.X1BRkbvYn8oZ8Dhp%rmy@frippery.org>
References: <68b14aad.X1BRkbvYn8oZ8Dhp%rmy@frippery.org>
Subject: Re: git whatchanged breakage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025, at 08:37, Ron Yorston wrote:
> I use 'git-restore-mtime' from git-tools[1].  The latest release of
> git broke this.
> ...
> [1] https://github.com/MestreLion/git-tools

Issue: https://github.com/MestreLion/git-tools/issues/82
A PR: https://github.com/MestreLion/git-tools/pull/83

> What happened to politely deprecating things before breaking them?

It wasn=E2=80=99t deprecated but its use was discouraged starting from
52f425e1a9a (whatchanged: document its historical nature, 2013-08-09).

--=20
Kristoffer
