Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AF3399B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103329; cv=none; b=uG1TtRjebRZ3GiagpYgHvT91FR/5L4XQCJenEaLQiL/6ou2i0KuKaEGCfQIrRsdjxYVse5g0RyUEgaH2PBUXWZ2uXO1TKN/QCLlZo/GyJsNi9ewGNrLPXviOP5oybfgH1n0nZzHDVOOL++4cK/XtUbh01yDIgSiCTFvYKR7edP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103329; c=relaxed/simple;
	bh=OjG4L15rVuTw1A57B5tTdC8HDkXqGl0Y4WvslQULmXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF7RG+sORGXURb9LdDrhdKVsQpshs7rqLJTK+MocgsoYJ9aOuW+OwZaeLpGlvpJpOna5iCI3JJTfE//ADoPnE3WDMA7GgPkbaWWSl1/aOol4uOVDRU7Lrv01nYaIpyJ5Krmv9YV1l57Jk/KmUsvrVzloJfEp9vWeIuFkKhfZjoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iI82/LPe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uHysb/mF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iI82/LPe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHysb/mF"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CE66C1151BC6;
	Thu,  8 Aug 2024 03:48:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 03:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723103326; x=1723189726; bh=OjG4L15rVu
	Tw1A57B5tTdC8HDkXqGl0Y4WvslQULmXM=; b=iI82/LPe/L/f1q4ZebwI8OAJD/
	0LwOS/w4pwr9GQwUdZ98xRXLHViJpwe1rEuywdRQvmMycH/RxyK6R9TjksPufKIK
	/r7oe8g+TeKlV49lfDJvGtFfCn7IqzZZcIkSOglP4eFgfGQlDnsJbDfXHBz6tuJD
	IV/c/Y8PK7bkx7BMxIKn4sFwjALOKdaiAJEhnYOHP6+a5boGih0zXF+/A+zXHQ0+
	6zNY36waWN2iKwJ60RrcQWAuTaYF/9Zy1p9quZjrWFs3eAPVQr3RpV52Cno79Ng6
	9uEU8OpJ/Hmk2NPZDro/PCtQGLnetm9TbCfK89rnC9czL5DVDwdBg8r8JMOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723103326; x=1723189726; bh=OjG4L15rVuTw1A57B5tTdC8HDkXq
	Gl0Y4WvslQULmXM=; b=uHysb/mFlLdS8b0lLYFQXVfWup3o76VYpybEAD9hjkAm
	DQf0RmZzHrqW7Bf/kvz4/i3rsWB1G4y+c37p12O1xMFow7tYl3aCp8NgSXoRhElD
	vaaoZdLDcqA71gwuFFvaNItA25fexIupxWrWWHyPhdNLeFMGwaXohrGiUge3tDh+
	pqXXQxY3XRv+/c5hlF/CT5Bbcc84S2+JWR6XjGhogiWfp8F9Qv8FJq138Xlm9kR/
	NPR6SqniXe3T2qS6TsR5wcwD6QX8FqAek8W4b56UamIqOEaZ1mIgbAIpZV7Ai69D
	dijdHcfyzYNJqhI0TteL6I6ZuH4qZHZusnBhqMswgQ==
X-ME-Sender: <xms:Xni0ZsJXUEuoWFcrNvUNaURy-MOZwl-6tTqek_cDLYKa69Xz_yoGiA>
    <xme:Xni0ZsLF26o7nN_oFlmAX_1_TFRfBB5BoCrb1GXFiaXSuaCwzTQI2IeQgC0RlfdK1
    MEqmfzzgUlFq8YniQ>
X-ME-Received: <xmr:Xni0ZsvXd7XHmKP8DyzxOLxlGKVQiXAl2elIAHbc9rqCmKGmRIvOlizJCvYngcXZhKJui1NgRtzFC1VnwBB0aa9H9eH3TggjTfrFsnar-7Hrn-Hn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtff
    evleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhihrghnghdrthhonhihse
    gshihtvggurghntggvrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrgh
X-ME-Proxy: <xmx:Xni0Zpav7i2yYk7Ngi0PI1yo9btzAYiM8YawToS6g30Fpmmq5CAehA>
    <xmx:Xni0ZjZL7S5YsZ3wcYxyF4PnhQ3nFP2fxz4v1a2GHnXkkQM-WI5Iuw>
    <xmx:Xni0ZlAmStfyl1bZHsk3DrzmYdMMUp8CYhHfQS2cW5KQdyuJpLbDKQ>
    <xmx:Xni0ZpbBW23ze0wZitsfeOYQKxhtpH5OcbreMoyWZEcYwC6816zaRA>
    <xmx:Xni0ZvEFk-1-UbVKPwU0uX5-g-6epYiqlpqvz7_LvAc20z4Hj5UsEg_C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:48:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c20982d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:48:37 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:48:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] doc: pack-objects: clarify --missing option
Message-ID: <ZrR4WVtSs5deJCPu@tanuki>
References: <20240808062120.34629-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wx9rC2ybs7SeAN4i"
Content-Disposition: inline
In-Reply-To: <20240808062120.34629-1-hanyang.tony@bytedance.com>


--Wx9rC2ybs7SeAN4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2024 at 02:21:20PM +0800, Han Young wrote:
> Since ee47243d76 (pack-objects: no fetch when allow-{any,promisor},
> 2020-08-05), we mention that --missing=allow-any and --missing=allow-promisor
> do not fetch missing objects. But this is only true for missing objects
> that are discovered during object traversal. We will still fetch
> missing objects read from stdin.

I have to wonder whether this is intentional or a bug. It rather feels
like the latter to me. Let me Cc Chris, who has written most of the
infra of this feature.

Patrick

--Wx9rC2ybs7SeAN4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0eFkACgkQVbJhu7ck
PpS5pQ//XmdRBcD9tHPTxh/A+Xu4LiG//qaWvm3aqT7Fnmtus0Lu+1MhaKdHSGX+
fm+1xUQv0KnEXwKcxnoS4p1Z/tXj/JNtwCxTDdVwkxDA4Luq9prM6CERfILWU7+w
nGR8OD1a1+P2ccv6hJ4wE6G2o++H/IRgb3VJh7gAjrPfnFAmaT+x2QJumFshZLiV
ZEbjqtETSTWNZxtTB4fwUPdisAm7DrlQqrspaxPuAbysBJhnYuBr7ktiGhaH3Og3
oez8RQLJ8h6r6XbJbSk0Fb8GVpZJ+YFIeA7X9lD50K74WMbqGnmf76le4hGmE2/A
SoVp9JLEdEaaVAPlVRvOBWblgr+6XTxwVqe63qE7Sp9jRcfD6lpKFUnT8AA+LZEh
7V2sS9J+VHo4okgkUTp4p9BexDHwyQnRiGoEIkJ8zaZ69D7uoB4SuX/POOi8eaAS
fINGeCwLwgoDkmZXKHGGeJ6GokvtZFVQsDxmork0zhm+K9qxg0jsFh5NIPP5epa9
DE9chGB6y3JUS7Zt43y+v4mdQMy6uFK4UmKi/b/XGPqh6E3wN9NjqzAy56CdplC0
8Q0ovsJmwLQomFc9XD/yB1V34BPTvxAyfTrRkjo+ISffX9ryv7gobJ6EqXbAa3we
xrn2341iVcbmuQh5tRRADNLQiVyxzaa/Wj8dATVeu6cCPuwFCXA=
=xZXY
-----END PGP SIGNATURE-----

--Wx9rC2ybs7SeAN4i--
