Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630E278E5D
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961831; cv=none; b=CW2Sayj6HvSfqe2I1ArThZQ3GA/2RSWe3U3zWQcKnqJZ5+elUzQFW/NK7SNwkkA2HwqkVQsTPkD8nXHSUuFjoE4IdNkgtL+S3VCQcG02WupcvjjNQOiGmHOP6yZeLtr2hrff6CGKzDLd/YizGllJj9gT5AV0SqmpJcDDMUP8vdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961831; c=relaxed/simple;
	bh=D5hNvOOkgUb5Lmgu5SuGAHiLKipmnKiDZJLJNbqe1PM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q9YIKQFCisTllskKDLUxqgE/4VmGKc9GPzyjk4PyWB07GPUCO02YVx95DxGa1xdJhfcJYbm45sLHf6e6amGNMQ+qj5SiwPeM1R31qKfRzRo3Skd5q7XQn4jKp2zCH46hfztu785rSaVRB35l9OPyDHr4cijan8ey5eJGZQoYZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dPg3Hc2k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZlCi4/p; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dPg3Hc2k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZlCi4/p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93AAB14001FF;
	Wed, 17 Dec 2025 03:57:08 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 17 Dec 2025 03:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765961828;
	 x=1766048228; bh=lk1lG4WYMsoLgAkiDKw2D5uKQ4GJ4Y4nzJW03bUyhoQ=; b=
	dPg3Hc2kFwmhzW/H5UZR9sjgM3SWKaYcZ8DK8nxkTEua6oiOOz/j1mRrbnPQRsZG
	0N7F+vLeL2anAZmSDNcZijRLRqAC3/FrJSzfEXBMsMzYVSlWHCh8SpWi+1eP3O1x
	PUft0nhBoM4qnAbIjKccRmRs3BWOP88MO3pie3I0LMTFVyBx82ORy+uPSz5Sp+hU
	S0yq2BL2C/GGJg8u7tsBpi0G673Oox9CAQ11t6ctP21Ttad9ftAhjLKSXGmS0M88
	j4XwAYa3JSk39uLQSw5TOPwi2x+jAjreiSqKPzX/fMW0ZolJK+qHPwyYmEhdFCef
	00HU38MFuIeJGHOad3rBQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765961828; x=1766048228; bh=l
	k1lG4WYMsoLgAkiDKw2D5uKQ4GJ4Y4nzJW03bUyhoQ=; b=MZlCi4/pCs1mZ9gbG
	i6K8wFjGHZlSzB3xwxA/Qa8x/WBnvb/prjwQnsMvABL5AnBLNlh/5M1aotQM+afH
	rEgFtEPv5uWWpX4CBsfJ78OXh+opq/GY7DVZPxqLPJlzDleyqIq3rZ5UAN0vRNBo
	Dsdm+cgY0Ip86cyKbFmZ1OKFi/LulGH0cWnweJLyzMnr4+3zshYLGO0NJgbnr2Wp
	C/n3U+9OrlSRZWSw0jDR/yYazM81sSeRy7/+p+vj/qYKKMMZuS/TJ1rXruzbfeyv
	OOPmMsJGYJje0m64O2srZOVDjBKu+5EigFPmB/IabdCNPZ3qUGEDbBdl5mzBG/nX
	cgOQQ==
X-ME-Sender: <xms:ZHBCaelHP8Kc6L2elnBsgmO0ZysG-P1wNP3SHewp8exThKrTDBTXSDI>
    <xme:ZHBCaQrI58OMOhVT-VdWpIt328F45qb9PtkMuc3A_VzH8UAIOvJkFXpB1IbHUgSQ1
    PrgzvNpl-Q3w-KRvkN-5M_jkd6Ju0Iis5l1X9LNpW6HLGlI-xqXBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfhffeghedtgfet
    udejleelledvhfdvtdefheeghfelveefhefgtefftefftdffnecuffhomhgrihhnpeifrg
    hlvggvughkhhgrnhdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsihhmohhnrdhrihgthhhtvghrsehhohhghihrohhsrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZHBCaVR7f8GhQXOroM8_CnITd2-5DTcD3dYiX1tx8NZmjlerS3oV1w>
    <xmx:ZHBCactDX51O7wMcyFsFwoeipV4Furlqqu9i0PtCx3xHZP64jvyQSQ>
    <xmx:ZHBCaSa9Ygud3vcSTtmRi_ER0u6gAji_DojFbckEU3DzQapfgbMt5g>
    <xmx:ZHBCaZuYmn-vDqOHh91gx_y3aV1sG317FGCMB62Sh9Qh8z-_7H5XEQ>
    <xmx:ZHBCacl_8n8DCC215fQDsgtCdqRLK4CPDIONlY8NF-lGj_PbLed6dyaF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4A3981EA0066; Wed, 17 Dec 2025 03:57:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah6w9HIwkd0F
Date: Wed, 17 Dec 2025 09:56:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Simon Richter" <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>
Message-Id: <c0a51f7f-2c3e-43b1-9e0b-668a450b0348@app.fastmail.com>
In-Reply-To: <0e1e168e-e90c-4aba-a474-50d0df75a8e7@hogyros.de>
References: <0e1e168e-e90c-4aba-a474-50d0df75a8e7@hogyros.de>
Subject: Re: rebasing on top of reformatted branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025, at 07:33, Simon Richter wrote:
> I need to rebase a branch on top of a version that has had automatic
> formatting applied.
>
> My usual approach for this is to create an empty extra commit after the
> branch point, then filter-branch all the commits on my branch with the
> same automatic formatting, then continue rebasing. Because the filter =
is
> applied to the tree, no three-way merges are performed, avoiding the
> conflicts.
>
> Is there a way to automate this in a nicer way, especially if I have
> multiple branches that need to be rebased in this way?

I haven=E2=80=99t tried it but git-test from git-branchless should be ab=
le to
solve this.[1][2]

> > git-branchless=E2=80=99s git test command offers a solution to quick=
ly run
> > formatters, etc., on an entire stack of commits without causing merge
> > conflicts.
> > [...]
> >     git test run --exec 'cargo fmt --all' --strategy worktree --jobs=
 8

That sounded great to me when I first read it (to transform the trees
per snapshot). *Obvious in hindsight* considering the trend of
autoformatters in various languages.

=F0=9F=94=97 1: https://blog.waleedkhan.name/formatting-a-commit-stack/
=E2=80=A0 2: Not to be confused with some git-test(1) scripts that run t=
ests per
     commit in a revision range and store failure/success

I uninstalled git-branchless because it created so many weird refs and
hooks and I didn=E2=80=99t understand the overarching goal of the command
suite. I still have hooks like this laying around. :)

    #!/bin/sh
    ## START BRANCHLESS CONFIG

    # This hook has been uninstalled.
    # Run `git branchless init` to reinstall.
    ## END BRANCHLESS CONFIG
