Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB637DAA9
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074989; cv=none; b=kJadne1WusddlWJWbYLFA236Y5tSbczFVZf22v4UrZwT8KbN16hW9+pnPjNzYvDWqqzgCvSAon9Y6WGwu0lVj8DOtQVyzglaQgDVHiO5eeKNvR3tdEUg/ialsi4h7UpruWK59gq1ok5lhvgrT4+lljgbfy66X6pYOAqM4DB2T9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074989; c=relaxed/simple;
	bh=t/0q6uYOt2N3PILdE1rdbbUOHpWHRwDhVBgP6ixO/gc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T9XrlWS9EF0Qjn9+6vcxFVV07hneNQzWByW3AyQ1BuR6Jwg/KYq15a0uqfxPuf4owrmtbAMHjj8RgJ+fIOD86YjddUzPI7xGV2PH6Ag/GirJQY685Al5kNwB6Uorf73TFqPtg+KlKnrtB0BXNodXBcNHMjySAJ078Nqoe1x4NJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=W/BPnlND; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JLlJyTz4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="W/BPnlND";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLlJyTz4"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0707D7A01AA
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:36:23 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 15 Oct 2026 10:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792074981;
	 x=1792161381; bh=t/0q6uYOt2N3PILdE1rdbbUOHpWHRwDhVBgP6ixO/gc=; b=
	W/BPnlNDP1RgV2IPUZj8j6mA0//PYwclUXACzUrI95fRlS7rAW5XboY6AeJuaiG2
	oiN4sD6pzUKdvsqz5TP5jKcS6W6SitgYXLCuUCl1tLgslqsfoy03brb8t/UpmA81
	kfQHoSkbj9RVOtxDAuKSbYcxTUQWZ5KgqVHhr00c67gB3WVYaETGo4cvpde7q5vQ
	yUp5fGYIalLE/iE3UuYi0uiaVLgx8HZVaXMYcpu16nyk5Q6mJwWT5eumJooAwGmz
	QwsVqlMUCqCx23dDbjygMMFBaVYaLu/7/xmq5TcUrPpzU/wl7Ha/GnFwpT7khdf+
	fpadR6cr4RBX42hK7p/xJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792074981; x=
	1792161381; bh=t/0q6uYOt2N3PILdE1rdbbUOHpWHRwDhVBgP6ixO/gc=; b=J
	LlJyTz4SNonlySNJ4/ZdX8d3MAoTZ0u+Vq5N7i3UBP1husrCo3emCLJSBeYwiiDP
	5d35RfYVwzs1lUU6ODZyFugqXZ1duUNUsy5JadVkU9YYh/CI7+83lVPFFpOnIAXa
	YS5wGocn2qCajxKW8TTmub1mTaKyWA6fV8TdgNLHQdXzNNhHWifNUEMKxm3TLXAc
	PgRrkNf5WhJQsjLxt13s7yNOR+DiBUkzCLSF5CzuWRDLUNmeeKJX0tTiCV5XPX+G
	SwwGeRZfmnEYPGvQYszzUTqfheejiqpxHAVTTQpr/38orb2l5337d9eq9nQpE8/g
	ITEvPqY0DYcxRQA2KEW5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792074981; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vkYtQpXbO4whZzHwjWz/n84UYk3rGObdhKdt4HwcsxSd28k
	nV16vMKvnWTH4XULidfQJckAelbai5r6YW7U6GikhIB9RQgeajdDi9qIK3JYQOnZ
	WRwtXTd9P5RCQj0zM0WWP0x980elCVNlBcNkAuKS5WGVpji/jnxvc/qhlVM8EDmR
	5I4RjMJsGnBckO4phCYtVFj4h/PFFjyamJoLOtTeWdo2IWiJKoHLLPr73Nlg4/Zn
	SsuuEPD09HSEF0VSAotTCHuStaR+AWyo2p7XwuHxHVRfp3wAE9RAupd1TJP7j5IE
	DpL8ySxdJPb3d+uyJip71HBvLnvAtCDDXBRYpnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:useG6E4rjEOwtKugVurtTxVH4XOev1cW64xHd7U5m2c=:t/0q6uYOt2N3PILdE1rdbbUOHpWHRwDhVBgP6ixO/gc=;
X-ME-Sender: <xms:4-TQara0vDxeHCMr3CVvK3nktM_Cjf6ikwVyMb05O2u8ecRhXQKOQNs>
    <xme:4-TQalNJC64-kS_PyjfsI2NPmxDkl7iCuIQeSOYU2WKJiHx4WefDjpU4ruESkFJAb
    Hru7wXjnGYga6e5LxEs84sd6FcemMLKmS--510zG0KGT3Wpn_NIrg>
X-ME-Proxy-Cause: dmFkZTFwARr1oyyTe0TrwwVFxI1b+fEOvyAVGaL1Nmg5GBavIPDhqmCF90svibdIY+vM13
    reZmvCR6bQnH31h7HH3OnGaY+71BfgqJR4K5LoOaeEk/zZDT0H3CDpLLzkJyk13IP2ZmUc
    1wWSk+7YyrQ0pZIE091xC6VrPn3kbKNQwgGxgVRTIU4QXvFg52WokUDYO4sFKAZHL/zpph
    FIJvDinfQuN3RrM/lkTBlJQVThf+tidFFMwxjQhd3L2wYuSo49yLcZetbpi9Xym4Tc0r94
    EVhSl/cqaEtSPjHkRSjjd2FYMyNpNH9EnmL2p2Zkv0q3E/CkmxoSiOua2wuMh33iLT7Qma
    TYX0RwUHHwOd5tdnmCWe18ARq34aoSRGRli4jqK503a9rgig93zEDJA+N7RnRTm40ODfTx
    1HslNlPCaSAeSFVKUPyFqp63nSwRVxHSAPGOvm8a0bA0x2Witp52IU6usep2JNMORVY+j2
    F7VwfNe38mO/A+4G8SpvSf5QOfqsQ74UCs5uG9b8mBCaNwugeSX3F8Hnsi5fS4u5Rrr2g1
    foXuXuJbDWw32j+JGO4qQZRUSUF1qQdmKUiP6kg5PQ2OZrwnknDFuSh+i7N4yzt7WZJWFx
    Mwoxy0qJG1N4d1zwYJJOa/SM4xXZh4oE5W9PHkKIOGPKXjvKIr0j1x0QMNMw
X-ME-Proxy: <xmx:5OTQat25jiVdE6g5PHjKEm2akVtKkM2fFMGU_akkfClgA_wBi-wc4g>
    <xmx:5OTQar00SB_YL9AHRXPI20AsudNVuoJiprVNHtP0cYdo5Q7G838Z3Q>
    <xmx:5OTQag--vR9ZQSMPoHzNhG7STa9NFdsF1OoFRKzCHiCvE7g-Nh1k3Q>
    <xmx:5OTQao3n8D4kJygPLVXm-2kvsSzOhMKb3m0axo6b1QvfNdeNcnH6Gg>
    <xmx:5eTQamWti1e024c6r-uIp_G_VpoFe5OBCDKBcKlNCOCW7Cu0l-W9yZPD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CDBAA22C00A1; Thu, 15 Oct 2026 10:36:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Acg_JYlhWR3s
Date: Thu, 15 Oct 2026 16:35:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <b55b6643-b9a2-4e41-8100-2de545004845@app.fastmail.com>
In-Reply-To: 
 <d95ed5bd679cea41320c39824b969377e8c88e09.1792070038.git.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <d95ed5bd679cea41320c39824b969377e8c88e09.1792070038.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/3] reflog: name the strings that mark switches, renames and
 rebase steps
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026, at 15:13, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git checkout" records a move of HEAD in the reflog as "checkout:
> moving from <old> to <new>", "git branch -m" records a rename of the
> current branch as "Branch: renamed <old> to <new>", and "git rebase"
> marks where it starts and ends with steps like "rebase (start)" and
> "rebase (finish)". "@{-<n>}" and "git status" read the switch message
> back, each with its own copy of the prefix,

Here it feels like we are thrown into an enumeration without knowing
what for. What is the problem to solve?

> and a later commit adds a
> reader for all of them.

This clause at the end of the six-line sentence seems to reveal why: we
are about to use these strings in more than one place, so we want to
introduce constants in order to not duplicate anything (no drifting
apart). But the why here should have been put at the start. And the
phrasing is also so passive that I had to do a double-take as to what
=E2=80=9Ccommit=E2=80=9D meant. A commit in the reflog under discussion?=
 Or a commit
that *we*/*I* are about to make?

The context is that you are about to use these prefixes in more than one
place. And the principle you are following is no duplication. Then the
details follow. If the details of exactly what they say is worth stating
in the commit message.

>
> Name these strings in reflog.h and use them where the messages are
> written and read, so they cannot drift apart.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>[snip]
