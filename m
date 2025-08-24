Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28881BD9D0
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756058635; cv=none; b=BsF1b3KRvlSLjAj1Z24bjnJ10UKAOjaCgRMnEUjBNK3aYmwAt6CmdvieR3SIMVXq7qgRRVo9kz/8qLm2zlPlI9ni9uTDyAzm994Qxwb1T3Vmd1PwxrNQ1kTc472rNKJ9gXpT+tGew48ZgQxtGBU6xVrjtfcwQB2MeTCAsdQZl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756058635; c=relaxed/simple;
	bh=UCxTEtgcz3uIFpXzGZ5AhhKD8oewWnU5OIuQNA67TwY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UZZ7nPsxHhj8VppTISxsbafYbFpGEFGLPKkPAwDbI5aMqv5S/NDO6ZiKO0E6OM3fzeNHsUnsBML1XdqREvF3fuHNtRJuQ/RF9b/csqnfRgCS/pX05kfKplNeR2b4jt+e8vRFVaRg5K+O5Ng6LlZ4xiJi8ToWMVo5v04H6lwKSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ufp8Ly8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a9uCgtuk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ufp8Ly8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9uCgtuk"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F846EC00E5;
	Sun, 24 Aug 2025 14:03:52 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 24 Aug 2025 14:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756058632;
	 x=1756145032; bh=PXe4E74C/TUvC/eWBd3/KYp/msTVP+ZkTeS9b/Ddh9o=; b=
	Ufp8Ly8WerdHrjDG8gL8Vb0nyBKtf4Pu6c/q8hngMvHO/pAs1MPaIewbOpLdm2cA
	bbhpB1DbC0XkuKyROK3asST/yXPXbNr+kfs72/C6Rtx7KkjE/8k5NdbcVcAPmeti
	3bslxfTiwG/IFWh2aI++L8Bo7FBG/JVcP337hjXNPxb47QlYVpXbm8NSrJve4k03
	F5MGkkBYuxFiGnNVOIvoErLFJFVwMDfgtjbOh9dh/q1eXHh3YSXr0KPeh/POmM0V
	DNV8RTJ/CEbK5AKortLs3wMvEBj74QMUVcqq1cqXYQI+5RZsRlzDj5bqki2FqGXu
	IFbTVjGUcQD7iM4aYLhb3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756058632; x=
	1756145032; bh=PXe4E74C/TUvC/eWBd3/KYp/msTVP+ZkTeS9b/Ddh9o=; b=a
	9uCgtuky4lH4uAkWi7ym3QJIWo02nZnh6mihipN14PqF2RiSmh+Vb1nlBtjHhrLi
	3d5rKBkx1RfjTJGtp7N/XKqXaGw/oKPz55dpuH4dlERfQNIK3hfhnVRKyZP8Xn44
	ZrwdOXsM59E5PhVv60bZgKV1cHfApBWYhIgwv/o94CQ4h5n16TAZl8MmYpEZyUx6
	PVNXsQvrMMykVJpZQngHya3gGBBMd0d2b8lq4ysZFrvi9YaBYmobvQRWNQZqYM/J
	cXxYYlCdvgDuzgKl9e1T/lcee4mlSjrjirIq/oL7WPi6iUaeeWDPyYwzxjEXl/Ij
	WCQ6u6CfNbJ9ku6CoMFXA==
X-ME-Sender: <xms:B1SraC-CzJioHD-E-8UEKrn2rDTllWEAs0n7TkpeIwQ2rt3QPhJWBVs>
    <xme:B1SraCvEU9lfAkhiqhaetR1_CW1jtJRNVkUYcRxlttUt3kuQPwl4iodfSl3Xp0uZR
    KUa3FQWIrAoRVXZbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B1SraHOwMiXWYmJ8uFMInezj_sMe1MuCbV37UbbIsz479mt-_4h_AA>
    <xmx:B1SraFxH1QxfFVnCeMdGT3ekDCUCFck-JpNTAM5JM7CEUCvqJ3kvkQ>
    <xmx:B1SraPVpCfipn8mAh-qla9lz3Hrz2sfLk4RNbjJ_XQn2XfkKtvm6dg>
    <xmx:B1SraPOW6qgWB-RGRceMs7tq0szY8y5WgWu0U3qd531mSTys3Ia1wQ>
    <xmx:CFSraDUQXqzQY958rATo9y4M1H_68TavpQd6loMkPeZxKeAk101Pfo7A>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE4351EA0066; Sun, 24 Aug 2025 14:03:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AynxT4ivsjwV
Date: Sun, 24 Aug 2025 20:03:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>
Message-Id: <602e215c-be91-458e-9961-c78cf6aed2a9@app.fastmail.com>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split" subcommand
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025, at 19:42, Patrick Steinhardt wrote:
> It is quite a common use case that one wants to split up one commit in=
to
> multiple commits by moving parts of the changes of the original commit
> out of it into a separate commit. This is quite an involved operation

s/out of it into/out into/

> though:
>
>   1. Identify the commit in question that is to be dropped.
>
>   2. Perform an interactive rebase on top of that commit's parent.
>
>   3. Modify the instruction sheet to "edit" the commit that is to be
>      split up.
>
>   4. Drop the commit via "git reset HEAD~".
>
>   5. Stage changes that should go into the first commit and commit it.
>
>   6. Stage changes that should go into the second commit and commit it.
>
>   7. Finalize the rebase.

Exactly right and this fills a conspicuous hole (in the rewriting parts
of git(1)).

>
> This is quite complex, and overall I would claim that most people who
> are not experts in Git would struggle with this flow.
>
> Introduce a new "split" subcommand for git-history(1) to make this way
> easier. All the user needs to do is to say `git history split $COMMIT`.
> From hereon, Git asks the user which parts of the commit shall be moved
> out into a separate commit and, once done, asks the user for the commit
> message. Git then creates that split-out commit and applies the origin=
al
> commit on top of it.

The interactive mode here seems just-right.

=E2=80=A2 Split in two, give the commit message for the new one
=E2=80=A2 I can use `git history split :/'The second batch'` if I want t=
o split
  a single commit multiple times
=E2=80=A2 I can use `git history reword :/'The second batch'` if I want
  to change the original commit message as well

But it=E2=80=99s interactive-only, correct?  Would it make sense for a s=
tateful
split session so that other tools could be used to split the patch?

One nice thing about =E2=80=9Cthe staging area=E2=80=9D is that people c=
an use whatever
tools they want for things like selectively including changes in a
commit.  Likewise for a rebase session.
