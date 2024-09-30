Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBC190471
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707797; cv=none; b=WroXyrYeO4cf2WRoUqYbzNQ4aGF2+XHwIxmWMuWMXxPlZkQx0ee6o4P8bPi9/UkMOoh/RySsY596PEY5dDEwc3sWkR0t5GjEf9/VmLg+0IPdCFcmc2hH+x0+5Z/yta+etvKwTsaj6ztypyYLlwHc3p4iz154GeVeaZE0w6k2IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707797; c=relaxed/simple;
	bh=k0cu7nzDwGDccMI94/ImVYd35W1iS4bdiqqwKT8o/zQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jgEJoIB9LrZ9pZY7S6wro/d7wst/6z8NVVIvndlnGPEszjFUqlVk+KgJJXDwRFgxv3aDXX09242NyApoCjC4XbRA8MYbjJpgts2yW/+ggp+tdYWXC19FVcp3MmMIatwafNoytpZ4zw1gKi7ISHqdAxcUY/7eyQOHmwiiBbUNlbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Lx4Du6Hm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m9NYBrmT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Lx4Du6Hm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m9NYBrmT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E30D1380435;
	Mon, 30 Sep 2024 10:49:54 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 10:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727707794;
	 x=1727794194; bh=+cxdIytyECrZAcPkXSSuNwvEIW8WLQI0qCW4GWfMldk=; b=
	Lx4Du6HmjZVsnNJdQ/yDcUPoDPm0a2FSoVjEdo2A1odiwSsbTz9I6rhpDtH0ig8A
	KcmQ//FoudAs8Ll1LQiYXIfSRRN06QTVlWvAQM2EvyfIRTz4NGRpswZHdhQKr1dh
	GI7AvRseGR/uIMXnYqs6bMCWg9hTXNCdMgO2+4Lv8imzeW/TUqDHvgmGkjEjcxtc
	7/4fmvrjjdCJtFhIqPsO3hbV7i2yt4ZqXG2uq79DLScMxhMdqOrVPYf6B+ioarHO
	ts5lJ1zS5UMMir2OgSNPsUSYp8jAQuAcpv7NmaX8f5pDpOd8bPKlm5Es7nGOF9ny
	WXCwQJe2QEkcGCbO0DctRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727707794; x=
	1727794194; bh=+cxdIytyECrZAcPkXSSuNwvEIW8WLQI0qCW4GWfMldk=; b=m
	9NYBrmTZfCVxgduhqZnwo9AZOW5ck72zRn32mSvpmKRmdXEtfIoL4mAajcxCGrdw
	zwHrb1AmYi5QMMExgw3Pt4PibKVTlQpsmxgGLZpdox5i8ZPxBVu4yKABs8UD5nKX
	Y3k9Ej1eFUiNJoEyIGq09yFmp1jXwFagFFnv6tZKVRSDq7NKfzYM75MxkXBV8smh
	YNaZa+ahqNwaF19dWRODWedPL0ampM4phPo3A9oT2iSvvQVfNyo2Zh0Fp2ByRAjy
	AZ+qGSAIsVjmwJcJMtHMIQT+aKRrh2kddjssRi4s0ot1mqdpGcsPoySTSX73Qj5t
	Uu/P4GDszYce8GZszxAvA==
X-ME-Sender: <xms:kbr6Zrr-ucCLmzMpyenCfvSj2od6W4ko5yt0ewr1ezn58FDsnJ_WBb8>
    <xme:kbr6ZlqtepFiJiIDvKw3P0Qhwivt3hKdhdlk4ylCez0Zw7grxpcqt276ClZBJFGoD
    0GgO0Yd34wPmAzvDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfduhfejie
    fggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:krr6ZoMDU_tz-N-hWIQvJNiG7aW_A5Tfc-qkkjnyTjnjJc6jKWPDKA>
    <xmx:krr6Zu6cJ7OlxneOH0HPQusoMfsf7V2Vcaf1GrbixhtPfAvsAM05fA>
    <xmx:krr6Zq5phyo82RnAo4fBKdtel1lZyiXYI65KeiDU6eeJZWQIgzmpTg>
    <xmx:krr6Zmjv6JWrlJVRhL3FRLSFltWBFOdjIrDNuf6j0vZQtpOgSyuSNg>
    <xmx:krr6ZqG-CKsPRSLvq7iWfDb6oMLDx8uBp4yuVRykg52VtDnScBltkCHb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D45CB780068; Mon, 30 Sep 2024 10:49:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Sep 2024 16:49:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Johannes Sixt" <j6t@kdbg.org>, "Git Mailing List" <git@vger.kernel.org>
Message-Id: <93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com>
In-Reply-To: <6d6b2ff0-b4e4-4442-a3be-9b31742db280@gmail.com>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <aa981bb7-dd3b-4e63-9769-0fc2559983e6@gmail.com>
 <6d6b2ff0-b4e4-4442-a3be-9b31742db280@gmail.com>
Subject: Re: How dangerous is --committer-date-is-author-date these days?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As a Git user, I don=E2=80=99t understand why some people want to fiddle=
 with
this field in rewrite operations.  It=E2=80=99s very hidden (apparently =
you have
to use something like `git log --format=3Dfuller` to reveal it).

I can=E2=80=99t speak for power users.  But regular users?  Well I see q=
uestions
about being very deliberate about setting this field on rewrite
operations on StackOverflow (at least one time).  But I can only guess
*why* they are particular about it (this part is often not explained).
And I don=E2=80=99t know if they know the true =E2=80=9Cspirit=E2=80=9D =
behind the field.
Maybe they are of the impression that committer date and author date
*ought to* be the same?

Of course the aforementioned patch by Philip[1] was done in order to
make the available options between the two rebase backends consistent.
This option `--committer-date-is-author-date` was first added in
3f01ad66549 (am: Add --committer-date-is-author-date option,
2009-01-22).  The email that I could find[2] for the patch has no
follow-up replies.

That option was added to git-am(1).  So not a rewrite operation.  Rather
a =E2=80=9Clie=E2=80=9D (as it was documented on that commit).

Which ties me back to the =E2=80=9Cregular user=E2=80=9D point: most peo=
ple don=E2=80=99t use
email workflows.  So adding commits from email is not something they do.
Surely most uses of this option is in git-rebase(1).  And most users
might take for a given that author=3Dcommitter.  In turn also that
committer-date=3Dauthor-date.

Again for those who care enough to hunt down this long (words) option.

=F0=9F=94=97 1: https://lore.kernel.org/git/20200817174004.92455-4-phill=
ip.wood123@gmail.com/
=F0=9F=94=97 2: https://lore.kernel.org/git/20090124101750.6117@nanako3.=
lavabit.com/

--=20
Kristoffer Haugsbakk
