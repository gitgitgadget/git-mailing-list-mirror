Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695129CF4
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172142; cv=none; b=ZRolpWKrxa8Mn4m8rUCLZGNopwQV3cLyoG26fIjVSRrT5/9yr+ysvUcAJvPqpWHTSRyl4nGnnsNs5UvXeo6fv5XNwWnhPan1j9GnDz3h+3n7ptLHupgqWvlLjPI8LtcpLPFxy20qau/Q4V6QbDowBpA6Sn5OLsZyk35NyxjdYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172142; c=relaxed/simple;
	bh=WbP+IG4UbzzQmLCr2BgmAG1hHoORtxyXee2RE0AAPoM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M4Vs1JfK8c9vd1iV0uI3+gkiKpV72vNGJxd37cp8SYIq67XcQsMdBkoKuMpbCg6JWtYVcRiPDJopW0EZfFWNfybSK/tdCDndVnxu+kyOF/m2vsdmDxpVxCVXMZht1fP7hxMPEeEbf2LeXmUG/ngTnmT1HkIGD+G17Bp9alz2azM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hKZ912OT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1FliXtb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hKZ912OT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1FliXtb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B8CD911400D6;
	Sat,  9 Nov 2024 12:08:58 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 09 Nov 2024 12:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731172138;
	 x=1731258538; bh=L+XA6tlhoRE93IRwZjmM4O1nE869C9OWn9WlvstWDHw=; b=
	hKZ912OTB76049w9kts50J693AKYqHzei6pvCMZmTXidGGjVlSP4IiaIaXR+3PuH
	0Bz1jc9n/qO8qJfEE/hGXf1jVBD4vcZTnISjaPrSHYxFFMeXSVnKCqyJ0EPqmnCR
	SwWq6AX4U6kLRMzHtsiSdARLREPrBh2e661STYJz6l8eN3AHjSxA+5n9PPwzPiOL
	rKXXT2tfAyOWGwnfpJY6w/ML+YpjTzOXNcGdxmfGv8dIu4balkRDLE9Lp98J9d01
	JDFclLvpSugSHvLToQ6nG4Bs2iPWyXHcQePDEWZEXPPUFhPHDtYd+mP/oTgE5OgL
	7IlkEDuGvsEWoegMsba49Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731172138; x=1731258538; bh=L
	+XA6tlhoRE93IRwZjmM4O1nE869C9OWn9WlvstWDHw=; b=I1FliXtbfcs94OMf6
	YWW6/Kox+7qpC2N+wjbJxhPA6l8c3nLy2LoPZQY6G3e8X/w9et3Ed/f7Mfm9xzp9
	OS8OywfFOSZ6JMJFBl8e6OHSphpRYdzw0KYOTnP9AK3N7ZcIJnb8sSbc360ljC75
	qnDxOwLWR/gE11PakME2VPxs7shuTb/6j2cPnzhPfiqifqixMVZt16iM5h55vgxk
	wP0qNf0OLyhM363kDeNvhedV1Ly0UEgVlnjbPjH70zjVEwptkWIIWGigTylVAo6C
	vEU7/VGXKXigG1R5iEUg8PwlfJJ5lGP6pYnJzvCmYlEeyHw4K99lnmnccrr9wKKl
	iMw7Q==
X-ME-Sender: <xms:KpcvZ5NUaJ_bZClbS46NhWOIyrTcOn1GpyLr0MGzubIJNI5Xq8lhH3Y>
    <xme:KpcvZ78w4lSlRnQzxHtehl5Bpw9IrTqoF7mCQu2kI6ZIN-jJQSjFit7JT_fG3_UpN
    V6-K59PgIYGBh7H_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdekgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecu
    hfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthht
    vghrnhepffejkedvjeegieegfeejkeegleevheeiteettddvvdeghfegheegleelleevff
    dunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhgrrhhtihhnihhmrhgvvdehsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KpcvZ4SzjuVMp1je-1QKds3McfIO9WAvDouevynI9un3WPwPekOWJQ>
    <xmx:KpcvZ1tzni1FQrASzfuQtjiaTTIxzr5VIBkp58EJ8XvQJdeNT_DRpw>
    <xmx:KpcvZxekQkZPJG9lVunwD6vI-Dpvt1_QUpV4WPdgyJtnoujPV2oarw>
    <xmx:KpcvZx0k54HTES9Qo_x9_zaqohFDc2DTJ-Zy8FW7M8JmPEFN0RKYaw>
    <xmx:KpcvZxFvkJcFimrOtOeguudq9-HUS7vLR7D0hJurjxXV5Bt2WyDdDUae>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 60419780068; Sat,  9 Nov 2024 12:08:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 09 Nov 2024 18:08:36 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Martin Imre" <martinimre25@gmail.com>, git@vger.kernel.org
Message-Id: <1d383dbd-a409-4199-84bc-652784835167@app.fastmail.com>
In-Reply-To: 
 <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
References: 
 <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
Subject: Re: Feature Request: Interactively pick fixup revision
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024, at 12:41, Martin Imre wrote:
> Hi,
>
> first email to this list, so please forgive me if I'm doing something =
wrong.
>
> My usual workflow is using `git commit --fixup <revision>` quite
> frequently, as it eases the code reviewing process and allows for a
> clean history later on.
>
> One thing that is always cumbersome is to first find the SHA of the
> revision that I plan to commit a fixup to.
> I usually use git log and then copy the revision.
> I even wrote a script that eases this process using fzf:
> ```
> #!/bin/bash
>
> res=3D$(git log --oneline | fzf)
> ref=3D$(echo $res | cut -d ' ' -f1)
>
> git commit --fixup ${ref}
> ```
>
> I don't think fzf is really necessary here, but it speeds things up.
>
> Anyhow, I'm really surprised that this isn't a feature of git.
> I could see a `git commit --fixup` (without a revision) or `git commit
> --fixup --interactive` open up the git log and let one pick the
> revision they want to commit a fixup to.
>
> Cheers,
> Martin

This could be useful for a lot of commands.  I use git-notes(1) a lot
(just as a niche example).  I often wanna just get a list of the last
commits (e.g. `@{u}..`) when I want to edit a note.  (I should try to
use fzf for that, thanks by the way!)

I=E2=80=99m imagining that some RFC implementation of this could get rep=
lies
like =E2=80=9Cbut why just for `git commit --fixup/--squash=E2=80=A6`?=E2=
=80=9D

As far as third-party programs are concerned: see this section of the
Lazygit readme:[1]

> Pressing shift+a on any commit will amend that commit with the
> currently staged changes (running an interactive rebase in the
> background).

Not the exact same thing of course.  You don=E2=80=99t get intermediary =
fixup
commit since it just runs interactive rebase in the background (so it
runs an uninteractive rebase=E2=80=A6).

I haven=E2=80=99t tried Lazygit myself.

=F0=9F=94=97 1: https://github.com/jesseduffield/lazygit
