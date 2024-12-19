Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852578F2D
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588159; cv=none; b=NogBCm8aNNVBGDlU96KaZEec5tQ8HCQlDZtgY18pf9Q9hqYbWpSa7vVUPQObvK4CptGHN/AQGZ4J8a42gTdzC7BnH+wGNMm61AGVH32UIckL2VwhZXQxAB0skHgDl9FKOFonZ9ztGDv3ZdnQhux6uVTaEeKHve+DnkoknSVPmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588159; c=relaxed/simple;
	bh=fmDfUA6yNpoMZbajoK/4ReTEs9kxBvYyn5OVGTIqzYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+KGBDp8IEL4OARR4bmXI/2/3QgxTsQQjT290rLHJmKcpb2LCLKPnYOI8ZbWwINZCZpNUEqKH0pQ/SNOrBKm55Rz8oyqTk36hs1XiwuN/J3lBqzhN4unGAITLfuUm0qH++16V0DXQNplgoUISCUNPUYRmuty/oF7ES8n4hqVi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ShU503zM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rrcwlsg4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ShU503zM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rrcwlsg4"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 599B5114013B;
	Thu, 19 Dec 2024 01:02:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 01:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734588156; x=1734674556; bh=rWzkbtiu9Z
	y/CeDPRk5e0z8KUisAmLg4n4JJOqfTC/0=; b=ShU503zMeyoY0ZxgcGPU7R7LIV
	nVsjH2Y3U+04yQQavzHK83kSxJLzgEJ7Xjr7iUtmuEnLoogw0lCxEKbgBUwpcaXu
	yZHWhRCB4IUOIzTMdlbmxarK0E6+X08J/ecN3GwMqk5le/6KLqF5mEhFHhHumfxb
	4vauU1yKLWR7slQDyZWj6wRKiLvmZpJT8DAsL1dGLAykAlCn+E+sitOgWzAbtr2b
	0eAXonXeggzWzozoElKWkNcD1til8+B4wggL4V/F5h0TPUuRJ5is0uFMkNaWw5J+
	eSBLyWpZClfWq6qgjwq9Hlj+1rd4Vc/f1Ma8YBozd8lO6Sduwl3sx+tAgvTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734588156; x=1734674556; bh=rWzkbtiu9Zy/CeDPRk5e0z8KUisAmLg4n4J
	JOqfTC/0=; b=Rrcwlsg4loSIGzNkkmecW4QbX5YNA0QfvpGWxWehYaiLbUI0dOr
	3Ge8vyDwVB0OTEdLUstRIydRG+8jhz+XN9xkla/peJvfl3wZRQAC9zZom75P3ZKy
	8aAUPujKUuVJpO90088b6Agfdxafjbsurlq+4WlA+2xYyZ0NmCD/er/tXLUArv9x
	OTPdsVFLOYAlZCrzuHyDdA9QGhiJ7B0BbOZDb9/J8NOnhP7yge4QL6EmN1sjA8iR
	jJXx445oleMFHSMu8mi1uD+neUuJe0sSYxMMbjFOyqmQ5CXxBj1R2naziPF0CJ5Y
	jHGeesYV9iomzHP29f1WiGzQ7VTL+v7Zm2g==
X-ME-Sender: <xms:_LZjZwiI3fkVpUKDuaVyypaJiwnSS-pUniPAyhjBZzatvCO92XOMmQ>
    <xme:_LZjZ5A34ApshU5zI5h7E-gzypi63UpZUbXjKLSPgZmRBajyF74g_HSH2yFkyeD8H
    qx-Etbmz-33Zs2mrA>
X-ME-Received: <xmr:_LZjZ4FggyMg8hXlyCeFlMgz6t8Tk1_AA3vsXaRLvPcJ28ZaL5kZt2dkt0Qb269eSPvhJwYpdhae9LGZdbgbFCUqnOMQqCS6mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleelgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghgrghsughothhmvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithdqlhdutdhnsehgohhoghhlvghgrhhouhhpshdrtghomh
    dprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_LZjZxRpc0GEz9DBGAShPN9o-LZwkLhpqkVY6runoPCNgz5flAYdYg>
    <xmx:_LZjZ9x5PwHyEv4GKn9Brw3A0DD8guXmAAFsDC0Nni_tOZF4tEJJGQ>
    <xmx:_LZjZ_4mOS9UcP5FVeRaKgX1rb7lzrQv8aQI8tH4GeYsFN29EH6llA>
    <xmx:_LZjZ6xfIx1TjK76VjeuStUc_GhvNzT9e6W0IztndA4NtnCWAjlrlw>
    <xmx:_LZjZwrObqIdnn_m2Dt9NPfHWrMgCe1NuzYZ5SnCT-GcW3TvAGmoG9Q1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 01:02:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Git l10n discussion group
 <git-l10n@googlegroups.com>,  Jiang Xin <worldhello.net@gmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
In-Reply-To: <Z2OAebI4pQ2K57vA@archie.me> (Bagas Sanjaya's message of "Thu, 19
	Dec 2024 09:10:01 +0700")
References: <Z2KfIl87JOWdcGR3@archie.me> <xmqqzfktujuk.fsf@gitster.g>
	<Z2OAebI4pQ2K57vA@archie.me>
Date: Wed, 18 Dec 2024 22:02:34 -0800
Message-ID: <xmqqh670nrb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Wed, Dec 18, 2024 at 06:49:39AM -0800, Junio C Hamano wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>> > So I'm interested in GPG-sign my commits (that is, ``git commit -S``) for l10n
>> > pull request (which I should submit in this cycle). Is it OK to do that?
>> > Drawbacks?
>> 
>> Instead of talking first about drawbacks, we should consider the
>> upsides.  Why would we even want to see your GPG signature, when
>> most of us do not even have your GPG public key in our keychains?
>> 
>> What are we trying to achieve by doing this?
>
> Just to ensure that PR commits are really from the respective authors.

Yeah, but my point was that it would not ensure, because practically
nobody has ways to validate the signature was created with your
private key, and public keyservers have been tainted long time ago
with fake keys with the same fingerprint, so would not work as a
good way to obtain your public key and be sure it is yours.

If this were "because we would want to eat our own dogfood", and if
we find bugs in our code when different person sign their commit
with their own signature scheme (i.e. you may sign yours with your
GPG key, somebody else may use their SSH key, and yet other people
use their X.509 certs, it might give us valuable insights, but the
resulting history may be irrevocably tainted if the bug is on the
signing side (if the bug is on the verification side, that is OK).

Thanks.
