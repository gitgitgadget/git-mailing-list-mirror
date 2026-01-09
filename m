Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54F225785
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921908; cv=none; b=iOYbiEYKiCVVKQWuCrO5qxamQd3aI4JeofIh91rjKPbDnzMsVPvKyQ8Pp7Z1OdiEf6lAJrPVL7kjmDUhDrJr4L0pDwzs2F+5zyQdQcP0D07HoBVXCtkCUdSRXQsfCNIjiB6h8WBdQkn/h2AqBz2gud1dUmWtxg628qhbD4XHBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921908; c=relaxed/simple;
	bh=rn5FPcd7qz7Yp/GvZMMrknQ8fnbkq7ohxaqTDdc7d2I=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=Lttc7bAgOiO3yAwF5uRfW1aTxAI+QgVOSgysWhBjoGSpA3cZ1V2CFwpi5fCLY8FSfQUrEdkXgAFzfEZxUapfpH+xiflzYiqSBSe8s9ohQfaCIS0uIU6shgMklV8dFBElMMR9FSnm7e8kIQFlZBMIf1vd/uGj1/pDLOFD3TzNrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=q/diGx8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GxhaYv1y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="q/diGx8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxhaYv1y"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 360E81D0011A
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 20:25:06 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 20:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1767921906; x=1768008306; bh=j0bPZor4wh
	ECcQX9LydSh4r7YrHHZqKLBLiGnq0Vc6Q=; b=q/diGx8GHEfFHMb9SW1XyxjDAw
	asn1dnj4C9xR7JIhNQguOWA86NvM2U+//SgEPVfmEs0zn0BHRwZqSWWMmY24wDP7
	pKpfpoy6LshFO2u/0s6kjJpnhAjl575zQEQRXwbEdRndLu0yZzA7HBlgI8KOFsLS
	YWO4COJ7o/LF7bZfypcnMxbMnD3ISICbjNDmfq8QQh0k/99PyxOQL9m4PyAmcXLU
	aDC5N3r09/DgXMNZuAMfkRJC6xzXOupWbeBltI4oOqZg+qLValz6uYxQJRqeyMwc
	hUrktRrYSI40e6d+W/NoEmjEd4Jajw2iQPA+WK/71UUZW7C/dmwocSmyMF2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767921906; x=1768008306; bh=j0bPZor4whECcQX9LydSh4r7YrHHZqKLBLi
	Gnq0Vc6Q=; b=GxhaYv1yLQWrEYWfdI2UsbpR0EsYuja/lsQu6wPByt8EFvruBmu
	FEHYtO+SyLkoQJv1dkeS4+HQR0mETml2d+HCvROLcUYlpSVUI3oBeTXpCzYJp2gi
	KNiLlh8BA/TkoblN/3LONkj4XZJyEzrAKNJyaEvQ6fNUDm4ixTOchh/NDfi4YDrF
	geKvBNnCfAqJUoffdLkmVObH69zA7xzihyGKZcPa6X6f87Cr831xJHxZjvW/wSUG
	ZwXAM685SzLiaNdJq7M8Twh+ZGQOdQEiQqjV58FITzdjH/IMK+nGDSGyYxb0F9ug
	fawfjKEGoIzaelE9vls7+Shp0rNUyQyP/gg==
X-ME-Sender: <xms:8lhgaT2_CQ6Gs6mAFFb0h6l9kWCUHYfi0pbiij1jALdbTOEvAOT6mQ>
    <xme:8lhgac4OwsmcYwu4CYjnnBLRXlQj9oDvO3p_4twyiMhA33Uu502lYYOEC4cG6TyXE
    KfePhp25HAodzlpM4A-fx-haGMbZ5kObhrfoN4kaeYk9o4W-d9Shg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtqhertdertd
    ejnecuhfhrohhmpegtohhrrhgvtghtmhhoshhtuceotghmlhhishhtshesshgvnhhtrdgt
    ohhmqeenucggtffrrghtthgvrhhnpeegvddukeehtefhffegheefgefgleetgedufefhgf
    duhfevgefgheeghefftdffveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegtmhhlihhsthhssehsvghnthdrtghomhdpnhgspghrtghpthhtoh
    epuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:8lhgaXlOQhLAtg55cF1sg5SSbSnek-JLPmbXkeCBQ6hv6QPR0gcm2w>
    <xmx:8lhgaaygvQZsFZX-6QHgKuQqSttxoSpgdbbTO5gqxVaGc1a_TsH2Rw>
    <xmx:8lhgaajmzCRDA6veXqiU3CyHKwOhYBHIAqsqeoMG3wfGGORLyQFVzQ>
    <xmx:8lhgaXUSBNeRlNvQu9sYHVw91kJV6MZOD3zTKN8Yt1VPLmkAozWUIw>
    <xmx:8lhgad5g1BTfM6jO8YdLx3RwHLwfV1DCSMLW7bOoCwHZGdWWyJCC-5B4>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA4DFB6006E; Thu,  8 Jan 2026 20:25:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Jan 2026 20:24:01 -0500
From: correctmost <cmlists@sent.com>
To: git@vger.kernel.org
Message-Id: <72d123b8-b75e-4b1d-8506-95eb9ad350da@app.fastmail.com>
Subject: [Bug] hook: -Wanalyzer-deref-before-check warning in run_hooks_opt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

GCC 15.2.1 warns about a potential NULL pointer dereference in run_hooks=
_opt on the master branch:

---

../hook.c: In function =E2=80=98run_hooks_opt=E2=80=99:
../hook.c:167:12: error: check of =E2=80=98options=E2=80=99 for NULL aft=
er already dereferencing it [-Werror=3Danalyzer-deref-before-check]
  167 |         if (!options)
      |            ^

[...snip...]

    =E2=94=82  156 |                 .ungroup =3D options->ungroup,
    =E2=94=82      |                            ~~~~~~~~~~~~~~~~
    =E2=94=82      |                                   |
    =E2=94=82      |                                   (7) pointer =E2=80=
=98options=E2=80=99 is dereferenced here
    =E2=94=82......
    =E2=94=82  167 |         if (!options)
    =E2=94=82      |            ~                          =20
    =E2=94=82      |            |
    =E2=94=82      |            (8)   pointer =E2=80=98options=E2=80=99 =
is checked for NULL here but it was already dereferenced at (7)
    =E2=94=82

---

This does seem like a real bug, though I'm not sure how likely it is to =
occur.  It looks like the warning was introduced in merge commit f406b89=
552 ("Use hook API to replace ad-hoc invocation of hook scripts with the=
 run_command() API.").

I noticed the warning while compiling commit d529f3a19736 on Arch Linux.

Thanks!
