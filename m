Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8A1991CB
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550384; cv=none; b=G+RGiZLOJa2xOp3N8HkKq8MZZMWcDXjnNY6AOh827LaRoRPXtkwKHuOGBR8p8f48YpuvK0bZVGxzi0eISEb63c0IjZkJ6Uk9MptsIDpyEwrYpXkmtBjz0qbXJAKkSkxmJvNxH21ECYKKFQ8J5+e/Kgw0p1IqrmcPzcza2Ky4iqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550384; c=relaxed/simple;
	bh=sSiYSeQgZr/h0fFvtYsbuGfKLRtiUHLcDBjKlj3v9Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSO7SAY5cAUFi7mo6Wmfr3zBGxL2ENQRdKJ/7ym3JF6J/d+AjvEuPHcMIixeZybSzWqxTSLgDLMicj2dwz8e9MXqpaP5aLuhWDZsM86MmPfxVbnOBeJwBSfy7xW2b4Q4oRKoUARV+/HYdJTH0ndSGznNJ9kyv/073EDJ/Z6T+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wj2Ike8Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aDA7b8Sj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wj2Ike8Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDA7b8Sj"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DBF8E1151ABC;
	Tue, 13 Aug 2024 07:59:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 07:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723550381; x=1723636781; bh=cmqAPwRRoy
	US39bOahgtT/yLBzZgL+gTkX+c5N+N2pg=; b=Wj2Ike8YHU+uDjz04+MBgr7lKM
	advyfniyfRIWlQIPfWFU5N1eSPgaj/uqCyexOT0b7pyDPKkdtMnTFNnllRdz0tXL
	gjNZ4lvDidGy+TbxwqcHWasMAi2JGpofUq3VtiW+U6YjZOTaQUCIeXonND550HHJ
	apdpky4H4m9DBhlDwSO8XBonlV9JYkWkrs3jpnB1E11cCRo2fDjsxHQDj7uy5bzy
	JYqynBBU79ZPAIrb8OL+jsIOzfKc8qJNrFKhwRUx3IqTX9vUFZiQoHIvgjuvmPgG
	by4fAZ4bds3ELPwiOrfh+kPpU7n2UuphMpSaw23a2QdY6f6QFAVu/kBX0Teg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723550381; x=1723636781; bh=cmqAPwRRoyUS39bOahgtT/yLBzZg
	L+gTkX+c5N+N2pg=; b=aDA7b8Sj+rzLp5tddd8nn3Y3+tEnHynLuy64y1+OVppu
	5t2o8xN1M1OdV7HIX/QLu96nMPZSzPGF6GkSZYMej3LFmJ1jvNwZWPIGqLM5CwV6
	obF6kkOAb7bpSzaCe9lMXpUENSeUvxFWmVk7EicqYuacO845RqYbZ2g4uIggvcek
	2oCaa5tFdOEwzTROCcdm1UlSVKhOJ/i2asVRisn7jjSHKqljRuvMPl8QkbMva8mU
	IUR0UhnuNgnFB8eR+6nzthRJ73/WiHivrWpo6yXaxKr3IklgbomEXTLijB1+mjDA
	5c0Cuj0uFrfbKkWXWkXjmzAerbhb+HWBgIkjgBUIuQ==
X-ME-Sender: <xms:rUq7ZgoCj9kAhY1GRogZ5RnVuKvp81AixNCKnDwiY0ws2wdmH2572g>
    <xme:rUq7Zmr25vJ54D7qQ6g4y4IALKwU-r3rg2ZJ4c35ipcmO57iEeO4KLWVk-XCHndfx
    36PnnT_gKLSUTgvDQ>
X-ME-Received: <xmr:rUq7ZlN_0vonTcIEpchcqv27odhdpY-Y8flC50xfbBYHMDFC5pbgDaa54aqDm5BJ1PjccQ59CWAeVzIH4QoEh4baayCNtwvABV2C0cSprbvPaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rUq7Zn40bIl0Oi2hlinpGXhZwj54WVv6T-NWSw8snhn6IwXO6cVnvA>
    <xmx:rUq7Zv5Rp54GQl2PqrGoKo22-LQZuehjNebXqMAd89i0oZmM7pcLWQ>
    <xmx:rUq7Zni59juCF9j5BhZJ_PxOI6-IKWwt8TsfRR8mvFQraiaO-mdVew>
    <xmx:rUq7Zp5Z7K-6mOOIMbI3JYsSftUCmgeXMyWD65B9lfV2NhpAjd1WLQ>
    <xmx:rUq7ZvFg_7eRfT6MDXKHoQ3YfSI3uGCPsu_M_vbSZEMGJMvS5i24N0tC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 07:59:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85093a2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 11:59:22 +0000 (UTC)
Date: Tue, 13 Aug 2024 13:59:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
Message-ID: <ZrtKoVFci6cdvMS_@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
 <779795d2-eefd-4fac-b29f-9943f98bc83b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779795d2-eefd-4fac-b29f-9943f98bc83b@gmail.com>

On Tue, Aug 13, 2024 at 12:29:47PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 13/08/2024 08:18, Patrick Steinhardt wrote:
> > 
> > Fix this bug by asking git-gc(1) to not detach when it is being invoked
> > via git-maintenance(1). Instead, the latter command now respects a new
> > config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
> > detaches itself into the background if not told otherwise. This should
> > continue to behave the same for all users which use the git-gc(1) task,
> > only. For others though, it means that we now properly perform all tasks
> > in the background.
> 
> I fear that users who are running "git maintenance" from a scheduler such as
> cron are likely to be surprised by this change in behavior. At the very
> least "git maintenance" will no-longer return a meaningful exit code.
> Perhaps we could switch the logic to be opt in and pass "--detach" (or "-c
> maintenance.autoDetach=true") when running "git maintenance" automatically
> from "git rebase" etc.

It's actually the reverse: the old behaviour when run via a scheduler
was to detach by default, because git-gc(1) did. We now ask it to not
detach anymore, which fixes this. Furthermore, the default behaviour of
`git maintenance run` did not change either: it stays in the foreground
unless the `--detach` flag is given. So the thing you worry about is
actually getting fixed by this series :)

What _does_ change though is when we run `git maintenance` via our
auto-maintenance framework. Here we now do detach the whole maintenance
process, instead of only git-gc(1). This logic is only being executed by
random commands (git-rebase, git-pull, git-commit etc), and I'd argue it
is the expected behaviour.

Patrick
