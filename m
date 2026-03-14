Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD618AE2
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530208; cv=none; b=O+354nGmUSE7o3cDl9yfmbqpHpvGjVzx4KsjI3RbFG5OkJ0xDOH4kSaLCNVbPRnD2WyFGbXcksloW2+JPbnPWpItY0FRFNjL5xYkiMxxCFOqq6AG+Exp3ldr7O/YLdKhOEHt3TLrQyf4/zHk5RSN2NaA/8GJN/mKVxbik9daP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530208; c=relaxed/simple;
	bh=FrLEnMTDsntCiGWZNw4QKzuDSXmuzpSIHZLg4ASXopc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzBObDtfiG81mOO3/PIiXbKSnQJlN/ltQQgRjqetxVo1Ea+pICHixmRnGDy8kHVvFaQNoINUq6phr10zjo36sW0PSY93pSRs1mRgSoxGbtDs5APihrkBwIYe5oC0R8hXlVqCxkhM/qqmxxMAz4NT8pTndKrQyvhDmUfvxjLQzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hx/QzZlx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oen965EK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hx/QzZlx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oen965EK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AF7C1D000D3;
	Sat, 14 Mar 2026 19:16:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 14 Mar 2026 19:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773530205; x=1773616605; bh=re7eIdITrX
	S40JSt0tUaSOwdwZta2/RP9BUpyxRAKRs=; b=hx/QzZlxJq0DUob8W1384xfwj0
	gHURyAHFHewm/3N8hMYoYseyBiOl7d360pAePgSFYNnsbEjEjGft7nR5RA6GPBW/
	GuVZdMF88ekTBxS1Wszo+3D6QoEBhAvJ/xx3A9DYqkvobwEunbUdOaK70LgwLr4V
	iTMUGkqK0RB7K9xdVANg9D7BHZVdsBSZJ4G9nF0Sg90xRMkAvvLeNZ74+UvSqslV
	zocjT64JAkGJZt4dKr1XXyhS8KFefaTuTM6da/66OykjkyHeLKhMGL+sw8fC3etQ
	hTyOe+WJpNevHfpl2/iLQuSYCJckx3jSx4plEzMjSZ2IrRpoPvN3KTmHD/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773530205; x=1773616605; bh=re7eIdITrXS40JSt0tUaSOwdwZta2/RP9BU
	pyxRAKRs=; b=oen965EKOb7SVk8JlovjCbTHHY5vBb0R0g6cs+l3AazTCAqjom/
	2YqsTHeTnd5YBuLClsywEx95yrwzKhD9BgB31WYrMKd3FMd8dz/v3kf1D0G5KjLY
	bSYWuQk5sGZq28A3wodUsZ655miGtJnbzEf00D8EKX7zBhbz211YwTba0seObZpv
	980+ZnYaWocsQ2VIW5YuYcW4TL2Q/Z5CB1GVUqIsHnDwWDSXZOqqdYkEpvUIpsfk
	C1La2kV13+MQUVjglXipIX1xdc0X5NT/V3YSwc5pmBVWU4e+WjxCD3k6jjTDPk2N
	XkRVmJVAyRn4EydufjDGG/EL7AV/azyRgtA==
X-ME-Sender: <xms:XOy1aWrbEIfSGzAF5lfXPvRbE_6nDi36RfF0aYU5UgPxHY8T4jox_g>
    <xme:XOy1aYXpd9BW0rGp85u8q1KBkdUnXL8CpZFaTbBbhiy8KS0G5-hsXeK6o-WsN3p8p
    wVr0w5Fu16SR4VhptUx2Yw0eE8n1Gv7FFnhSaycKH705H7VFQt1>
X-ME-Received: <xmr:XOy1aVBGO2T_f9sNS8dzLR2GPs8vfXV4jLuKbA5Awuu5qRZDwftcqaIoH9IxWTj1yJobIqBEddis03SfxUaxbLYREvDWCyXD1d26p1AmLgrTB5oPKk7_Vy0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepvfhougguucgk
    uhhllhhinhhgvghruceothhmiiesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    epheeutedvhfejfeekieehgefhvdevheegieeuveeludfftedvtdegtddtleevhffgnecu
    ffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehsiigvuggvrhdruggv
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinh
    gvtghordgtohhm
X-ME-Proxy: <xmx:XOy1ac0_FgTh5Q0bNLJXgzSeqc69Xt_yF8uZAMVyaIj_WtvoXulPwQ>
    <xmx:XOy1aX0nPbifu1dlj5oAOldahb3gZ7Po_O03Nci73rRNPFsReihylA>
    <xmx:XOy1aRA98L_SvodQzN2u5bFtw7k2BQcwR_E4id6U7Io8c9NUBmusCw>
    <xmx:XOy1aW7W7si-trqkDz2HgY8Tcs3GKFwFHIQn52J2kp5SPIkHcVYbdw>
    <xmx:Xey1ab24uIAVo64Y_TX87k84k8TPnh-zJTSAngrR6gqD-AIerhHLkEDl>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 19:16:44 -0400 (EDT)
Date: Sat, 14 Mar 2026 19:16:42 -0400
From: Todd Zullinger <tmz@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t: allow use of "sed -E"
Message-ID: <abXsWp5gYbxdHbkz@teonanacatl.net>
References: <xmqq5x72m4lu.fsf@gitster.g>
 <xmqq3425lvtq.fsf@gitster.g>
 <abKG1U3fVuNV1w_9@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z/sbLSaR7WxtTn6T"
Content-Disposition: inline
In-Reply-To: <abKG1U3fVuNV1w_9@fruit.crustytoothpaste.net>


--Z/sbLSaR7WxtTn6T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> so this appears to be reasonably well supported across major open source
> distributions.  The irony is that Linux is most likely the OS holding us
> back here, since older versions labeled this `-r` and the newer `-E`
> wasn't available in Ubuntu 16.04.  I myself only recently learned about
> the fact that `-E` had been officially standardized, since I'd been
> using `-r` for a long time.

IIRC, GNU sed supported -E for a very long time before it
was documented.  In a quick search, I see it added in v4.1a,
in commit 3a8e165 (treat cygwin CR/LF correctly (and by
design, not by chance), 2006-08-07).

https://cgit.git.savannah.gnu.org/cgit/sed.git/diff/sed/sed.c?id=3D3a8e165

--=20
Todd

--Z/sbLSaR7WxtTn6T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQSvlwC4tRNlCF6x+moHOcdGE+n45gUCabXsUwAKCRAHOcdGE+n4
5rx5AQDIWmZiCs4tUI2WetWOEUMgo0loaY91vyWad2rtErigswD9GP7CMzT+sLHt
WnXo0jrvY7gj+c5GeCtqqxT8LTf4Jg0=
=uK+A
-----END PGP SIGNATURE-----

--Z/sbLSaR7WxtTn6T--
