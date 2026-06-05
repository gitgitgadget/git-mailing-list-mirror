Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B63C2B9B
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678248; cv=none; b=Ugulr/MVcVJLvLwpmBJ7RRJEPWYRG6BVR6vqcTzmsEqV2ouSz81UMQdF8F6EFK5yCHleFmsPBojXBKgOL30fb3c2NBaw4veBGgxKqhfTBIJ3Eai9rotyk/2QEuzkyxqDu4gOjh+mHHAvOYDedVXOZdrr1tgTwrHJqx8rwygIf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678248; c=relaxed/simple;
	bh=8CGsTf5lx9n+IBvhJfVF4FpSij1breZzF97TF3uvias=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pv6/2tGOG5+irh1r6g4z+DYL3pJ6HFl/S20rzxWhnUm2Xs5jVAI+N1Pf8YXm/piVoRdglLbdlTB6KFPqOqfA+4bB3tJJuBBZpmWvhEfCAAfq2qINxzyeJWQK/VwfYJa6fB80R0VsPdpSpw6nQEnR2HZgTB2pLnYSLbTaGWxTi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EcXsA4bF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpKVae3d; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EcXsA4bF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpKVae3d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3C191400085;
	Fri,  5 Jun 2026 12:50:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 05 Jun 2026 12:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780678242;
	 x=1780764642; bh=hW2agU21eSKm4JrWIYiIbzrDP1mBeXsqBum2qQVRB0A=; b=
	EcXsA4bFZZjDPbYTfUZ8P3PRcTlmasEc6eENoO2anxKnoCIDy2e8RoD0RlpzcuHO
	DtMCeDPjnQcaRUbHg97WXsNh13zemkQbe7jBHBRYgNp7iYy54ulIlNfwDpCQshke
	l7e7P41RDMLvypUlrHcvQjPFlk4l3jz3nPMFFZJvMjMyDVQ71/tZFi41JcBoaccW
	P5QOsZzimNFtFXgsT+2NMaKFY0BwqogpDnZurbRadGtpp2RdtmfYUE8ltzdrurW/
	kogWfamMFEdmEaGSZpAQHejF8FjHjBIOMlnJdFf+djf3cwzJXAOvjgAwuJIGZYqx
	RhbKv7JVDkmninv7co9vuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780678242; x=1780764642; bh=h
	W2agU21eSKm4JrWIYiIbzrDP1mBeXsqBum2qQVRB0A=; b=SpKVae3drCoi0v67H
	PbC9lxBpm+AcSOfvCk45cnTHpNuAOG+C0ok/FZzqANH6D/Hp19cAOYUD5TmpJ00k
	PKPqIL6hZMkwDbiX9owpalWy3ih9G1LsoroFy14uijP0a1V01+9LO/mUbXjLau1G
	krhwVzRaGGehOjEnVkSmINltEO6oEJySf2q3lm9j31l7L0lS6K2tM0j4QAiCqxUA
	4QU0tsyyr/+sDW50LkRLlMUTio431CYB5UO2qiqfBCtCgJkz1zj8bRIjlM1vrgoz
	pM8Y5c0gykIWfakp1nBVYyt/GlbKwIbbeBW56b/jUFVvpG4pGobc6bkr4y4SNwj6
	4vxaw==
X-ME-Sender: <xms:Yv4iarmtKbUJYwiV2rIdC75-0kyczsAl0nCttsrcq2eNe8Lnq15S8ZI>
    <xme:Yv4iapoB7gToDDmoDsStpi93PbcgY0_CyYxq7rVxgJZpw_gX49_U03k4QXbZuriJL
    169lAsr9R_LIoNK6h2GFwZhg5yXuYdX_Z00-hVRjRYMQkzTzAJh4g>
X-ME-Proxy-Cause: dmFkZTFdSmVBnP5bpLTsxtSm1qZ0KvS7uGhRyBLLaaW1bVqlQr7ZThrwQLKHwZlMbFdSaJ
    2C0Q5Vhf7sGtirl6MyLYQVSNqdPlVsye3WRlxrOTvDU6B29n138o0jd0RFjQkfEHlj8H0s
    y3vVMzXqO+0h2foR37AJ4jWhaq6qzABwl+1LSGj/pOYGSM/tq4k35RNxaE1Toz/kbBtJDL
    Ru/qhRs5So8g3aBrv33qd0BsxlNp/2ipfTQ4HCfMCuKh/H6ix3B9zqLXb0fnOj4GELsUfy
    zp47W2jL3tlnqfjBDFYvN/Wl1Cx9ROPhngW7eJJnwKJHINg06onNQGbevopjo7FTiURIKY
    VPgEDayn4YhGwrF958KBSsh2kuO3NDEEWpRzcgQxSCn9uckJ/eNWD1eWIa8Ef5jVKx+bsw
    B3I2xgTNV0vR/qdFYCNeejax+MDoyCF+7fDUhXxniN4NcjDCZDWoAp22jnO2cKiKdehJcD
    0c0OovvqbO50X6VwCgbTOmDiJVdI/tPAbFIoM9AodY4m2vBnVx86wAK/KGIUX7xwmkEg/T
    bhxKjqfN5Q625nf/g1n557qvkoleLVZ2uv0/BKVQpDC1snv7e0kHq25WJ1wNAKpzLaP3AI
    +v0DSF2Z63qy8H2ECPvtBsXHIKdfFhB1B4KowmpPVmzz3hybNG0H4hPEFK7A
X-ME-Proxy: <xmx:Yv4iajITqASsFdrAPRSlBb7QuNsBFQ8p__7myno29VZoc9wjKS7KIA>
    <xmx:Yv4ianSZeBVRWvLIxN6QSzKzAC4TSAIjL4YETBSrt0f3HxST0-37-Q>
    <xmx:Yv4iajqY-vrQN4L8QUC32lrGiwZzBMK9svdaO8e61nFmNm2eIFXjFA>
    <xmx:Yv4iakqtHQb32qrTlpSC7v7o5naZZBndoEEzvtcLuQDMtRz8cUFEgQ>
    <xmx:Yv4iareIBnKPJlQEzKOBi84kM_hfPs5JpoQXQ_BqYEnEODVbj1YtgabA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A141302008E; Fri,  5 Jun 2026 12:50:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah6Tz1iNihxB
Date: Fri, 05 Jun 2026 18:50:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>, git@vger.kernel.org
Message-Id: <563fd8eb-187e-489b-af15-1551697b8849@app.fastmail.com>
In-Reply-To: <b1b15a47-0842-4a26-9a95-bfdae12799e0@gmail.com>
References: 
 <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
 <b1b15a47-0842-4a26-9a95-bfdae12799e0@gmail.com>
Subject: Re: [PATCH] worktree: record creation time and free-form note
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026, at 17:17, Phillip Wood wrote:
>>[snip]
>> Add per-worktree metadata so users can answer "what is this worktree
>> for, and when did I make it?" without resorting to external notes.
>
> A couple of thoughts related to this
>
> Isn't "what is the worktree for" a property of the branch that's check=
ed
> out, not the worktree itself? We already have
> branch.<branch>.description to add a descritpion to a branch. If you
> have a detached HEAD it is trickier though.

Some worktrees that I have that are not about one branch:

=E2=80=A2 For building and deploying the code
=E2=80=A2 For spelunking old versions
=E2=80=A2 For testing building the code/app with all untracked files del=
eted
  (=E2=80=9Ccleanroom=E2=80=9D) to compare with my own setup or my cowor=
kers when
  the regular working trees get apparently gummed up
=E2=80=A2 (for Git) with leak checker
=E2=80=A2 (for Git) with breaking changes (when testing git-whatchanged(=
1) I
  think?)

I would also like to (some time) set up a worktree or multiple of them
to run tests on each commit.

***

If I would feel like needing a note about these worktrees and it wasn=E2=
=80=99t
supported by git(1)? I guess I would use a per-worktree ref. That would
even feel more =E2=80=9CGit=E2=80=9D than an administrative file, but I =
guess there are
technical reasons for why they are not used for these things.

>[snip]
