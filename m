Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AB2417C6
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573575; cv=none; b=qDCJ7uCHBMWCAxe9mf9u04iWd8JDJySuDt2/DLjwQTBIUTyVJy3/0ojdPWaYKFTWwT8sfIAq1raoSpkH4eUgCjWQvpRDP5eIgPmqY4EPK0A2XQpcPos5zPZvrtf+JCH4E8iRAmFv53gvlJ2oSbWuweMuljdIshr3LNzfEl3wqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573575; c=relaxed/simple;
	bh=Se/s+jufxmN0pVID3a2fUPkoQd3wfdI5PBF87NP9YHU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QRh59l6n7L6GDk1QT4+t7PPlGSKx4CSmMCjvEEtMmTRNO15QEdbsA7HcwWnWHxbtsqquD5DqnVL2OKYbz6gI9umvE9V8k49ZdQOjyPyuzmS2mY8ce5eSY07R+kmUsnTv4J1MT1BBpsk1tAh47Y43ysoj2OsczF+1MqNXk1fU3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Xz/eUDnk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKyAI4hu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Xz/eUDnk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKyAI4hu"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 47B6C138037E;
	Tue, 10 Jun 2025 12:39:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 10 Jun 2025 12:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749573572;
	 x=1749659972; bh=4WgaMpv9rFjP+WCJ0bXBUb6jI/X6s8MWrZO99ICpGv8=; b=
	Xz/eUDnkw2ANLHcIsTOFOd86TNZsu5gikuFa9XPQKwtbuMAhOnZvJu0U4Dg6Msr0
	qa9MBEBBn3P+qIm07gdBAZq0u+iKyb0tzbHSpLWh2BD1eC/TC2fwDREOm51AYytf
	thqJEDJnNA6ObHbAJ6odXz8yuIkn10AbastT92ItadNXyniZxtRNhiUNh6oyRqs1
	AOYOa5RvEfDlQiZQDn9v4YF2vhR/U3rxkcaS2oAGJ8EXZF0T+CV/+yDMZ8anL5yA
	kPAXyWjcNnTuWbgCkiWx/BdOo00XnOnrBTx1PNR3ug4Nj809OffA7WywAIsuUfi4
	MRc0ryqL6f+vV9Gpgk7FFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749573572; x=
	1749659972; bh=4WgaMpv9rFjP+WCJ0bXBUb6jI/X6s8MWrZO99ICpGv8=; b=K
	KyAI4huy5sN70D1px7WDEYIyLFzMs+I/ZBmxl18mtJoRD8ZI04wPaYKO8Qg7+9dz
	FAjXFva9/N3CCIO77ofX4P4m/4ASsihlQuzndWXHz8yr83lGlMcDN+gKLe8x29hP
	Cpw8Sr0+Vxe+kGQEEV+Ip7vrAPiPPmpjORZrHjN62B0KJKOrv3JY9Yb/da0hbvUe
	CBQHbH5s8N1cG4AptqFJxWu5+S1Ku6fnAHCwlcGZSHaOp+yXlBX77w5EKKXXByYD
	l8grbVHPryZEz9nXxwf4zFLuyLf0SXBoBvPolEJlDVLmd8jcZze0r5oaKHidBujf
	1YKQGPhKhiOkh+mC9qq8g==
X-ME-Sender: <xms:xF9IaD5akfIbdxeKcR-XqrRArHmdmLg427RMcLpYSNjeJEsl_R-GbaU>
    <xme:xF9IaI48FRwiUtYj5_YTUB4mGfk4ikV9LssuWW3aAcLnCv9IkjYoe9_P5rcEZ_0zJ
    voEI9G-Pw2aew3NRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrghsshgvihhkih
    hoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xF9IaKe0uvfoUJkfnT4jjktRThAdNkYDSWQh4Z8mAsH_OUrdY-Pxjg>
    <xmx:xF9IaEJhpNmLPCJ0z_Ico4H1lNTaAr1gxaUGnDD9Vn4LVtnpqQCaHA>
    <xmx:xF9IaHJ5envBjt8m-j8E0zTbOrvZtDGaQpwhpu5YpDS2I18SAsNp2w>
    <xmx:xF9IaNy9QO7JY4gYu7gdAUBxnRDVAJSPWGIF7sf3qqYxfMLSL8y15g>
    <xmx:xF9IaMmlxiBW86ZQflvdjsGE9m9lPseJ5SbMsGW1Po8h9VlQUosNVLwe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F1DE41EA0062; Tue, 10 Jun 2025 12:39:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1ecd444e49ffd2f3
Date: Tue, 10 Jun 2025 18:39:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Lucas Seiki Oshiro" <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <0e4a7c78-8e64-4c27-8ae2-c2c664dba0a9@app.fastmail.com>
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving repository
 info
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025, at 17:21, Lucas Seiki Oshiro wrote:
> ## Motivation
>
> Currently, `git rev-parse` covers a wide range of functionality not di=
rectly
> related to parsing revisions, as its name says. Over time, many featur=
es like
> parsing datestrings, options, paths, and others were added to it becau=
se
> there wasn't a more appropriated command to place them.
>
> This way, many of these features would be better placed in new and ded=
icated
> commands. This kind of movement had other precedents in Git, for examp=
le, `git
> switch` and `git restore` were created after `git checkout` became too
> overloaded.

This is something I=E2=80=99ve wanted.  Thanks for starting the work.

--=20
Kristoffer Haugsbakk
