Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5E158DDF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862705; cv=none; b=sfKl/dxBsfVT8LaVAmmka8KT7yvvZsm+jHs7QLUeboY831c8TRvb7qh4FnVG8qEQl9ZKtIX58RY7CiRC5StH9WjObM50Y82WUW4KMCHvv9/XfmdeC8O80A7PZj8WU7r/3CFR1UK5VDJW0knBJbaelFvIAS2Bew5b3tcm8d/noWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862705; c=relaxed/simple;
	bh=Q3CX/TL4BYKXHzIwhMka4xZ4ikegUJlZNbgp6ZnN6Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umqbVyEnVNsYxRhQqPC644XCU7MkwtAC9pXVkRZvX6TJFZqJXEaMeKzByEyxX35WeL12iCoVXJo0AgPhf9+qen4GDuSwrwH3nCp7dafOzEKOAk4WI+Yv2WN4398sLMPVu+PS/jO8mzoFQ4ilvQSGE9PgQnO48txjYa/hd5pI4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lo5NgAz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GobiDsCO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lo5NgAz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GobiDsCO"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id BC3DF138FC82;
	Mon,  5 Aug 2024 08:58:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 05 Aug 2024 08:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862701; x=1722949101; bh=Q3CX/TL4BY
	KXHzIwhMka4xZ4ikegUJlZNbgp6ZnN6Dw=; b=Lo5NgAz0be/tgey3EdWhIL2aB3
	ayc5i/ZKYFXJyWkGxcKSH7ssXWSfnWYeFqiRGW9Zwv8O3beNc853fyiVFxBmXJ4o
	vmf28zFV6W/m4an7n9cRHjr/O/mqW+q748ORo/o7uT+WPlBJDX26PjDtEszslPPU
	BI07rpBpvSQkMywWLQnC/hpT0riBdf6C0QBOL1q259fdj3IsWtRaeQXsgLtgVZ2S
	swvutLoxZoZEYzDPjIyooN5yklbtzGIVX2Rir1l+KdZBwdO2bCnXChU3gGyogJKY
	7x94wQ5HlWQF8PiSurmWCYGyy3GKTbGDNAZ5kIcOTKXPIQ+6ws5M/8alJBQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862701; x=1722949101; bh=Q3CX/TL4BYKXHzIwhMka4xZ4ikeg
	UJlZNbgp6ZnN6Dw=; b=GobiDsCOXe1/HQC9YpjT1q+rYU+ARrf0Gp42Z2Wtn2mR
	ennD9ahfIDuU1uHVtTeCsbVaFH0trszoR+583dreJLohj8+zKMqz+jjI3mvYljTb
	u1kOJfYwB/pjsjMS+J591K7Hyq71Q1eR3FWUi2SJbNSrP6oCxtbyFg5L9CzYxJuO
	olWmchw7R7ZDESCtLe6O7GLWcnFVqrXTIKh2n7o3/DYVmrFx/ToMTQb7eaXaxq0G
	wmf2bFgrl/ZYtrqI9UNsmjyhf9XduHESHvkwJ5/hC//JbKEplzf+ZyP6GNPnwUfR
	l/CcGOrQYj8GS7qRGZmKSnDkIJRpXceucDyUERQ5/Q==
X-ME-Sender: <xms:bcywZn4XAFPe7l4wYS4fSiaC2Jujh6idhpVBlUGsKRFkrbZL6KS9-A>
    <xme:bcywZs5QQ6BUIEaBEuA0bSTxEZOc5LtSf5gWX07aL2fw847WU197rd_Z66E2yYLEQ
    vvSPKeSgRk8EM2YJw>
X-ME-Received: <xmr:bcywZufTitDakjqFNQL6ebLp4H-dRVTy0X8oiMPHx5JLgiCbF9Ig6u5f-JKvG2w9u6-CfEmnWxb8BI7FYNmuuVa4Zsq8tF2WH4TUDJqSvDbQUPQImA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:bcywZoIvVXWPbLsYQQzxzYmx3FUETq0wEKLrWq6DM5opkdNcCEgczw>
    <xmx:bcywZrLKD0IaUvG63wvrh2MawWRmwZjqLlmTH0G1_BefC3HZrftIJw>
    <xmx:bcywZhzW0wlIgtSA0df75DnzE2TJ0DvMopoUUJQvswrzu7eIiHR9JA>
    <xmx:bcywZnLj_J0Gmn286hGjkj4TQXyBe1s0Y2WTNT6wwR7iyMhRG9JFCw>
    <xmx:bcywZj9YuqMxie6ReZlz7yAsepdeipL3ie-UoRWq7CO-_Qo085UrgnUl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c992f9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:19 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 05/11] fsck: add refs-related error callback
Message-ID: <ZrDMaegRZSjP9twB@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumS7l6FjFz50DG@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yeItaIlCHDIoW77+"
Content-Disposition: inline
In-Reply-To: <ZqumS7l6FjFz50DG@ArchLinux>


--yeItaIlCHDIoW77+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 11:14:19PM +0800, shejialuo wrote:
> We have introduced "fsck_report_ref" function to report the error
> message for refs. We still need to add the corresponding callback
> function. Create refs-specific "error_func" callback
> "fsck_refs_error_function".
>=20
> Last, add "FSCK_REFS_OPTIONS_DEFAULT" macro to create default options
> when checking ref consistency.

Nit: personally, I'd squash this commit into the preceding one. They
belong together logically, as the preceding step doesn't make any sense
without the error reporting function and this step here doesn't make any
sense without introducing `struct fsck_ref_report`.

Patrick

--yeItaIlCHDIoW77+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzGgACgkQVbJhu7ck
PpQPqA/+KoJBLoMoegN7JMAgfsFkZ/xgd9gMQNgWD4nBp7u9VRXQWTX0HTBuRWTQ
x3VEstTmir/mEq+u4xdrfuI9W/8xPD8g7rT48MT4K971pih+uD1AW9Tsn9/1FdCw
aVli4O9E3BQeXuNGjKFbUaWcu6UiQ3ft3IkI49qRohuM+dLVX29YKhQ1zP11fYcZ
j7cq0pnHJdaxc1PQHOiltpqI7GL0o6ARY6q9djNBb7Sy10JFtwFTlP5zVLqxDkX2
EgZADsyBJAnIJ7yEl7A0lRCpUaKTr3Gl+DUK886VI6yHSbmq3iU8pp75PwZwxYBp
JvCqA2hDaFZscC6QLpIJtsyx8tRCVEve+xAHHrWfvLbSH4G03+BBH6RoRm+0Hk4b
/kAg3LXSWtr5BsLM/Y0LDH20ybWfMShWCrMhgOXtqWXm/Vngu+umphixGkbMYYdJ
ATi+f47Ra7gahT82vQbSDMnJgL4Dt4GhgIV3zNK6CoSjPNQUJeA/x8SmKRQVlTan
m5B0Xpe6o7ma2BI58out2nDLprXftEleTxAyMZXXscWGNAe1ESSXoLU0XJqFuLWm
6eG+cXk3qEDuRVWRByy7MuGcb8FcdrpMtWtTZWcUklVwC69HTMUHvpCkDxpSWZTl
rHqyarWC85aBlVPSs1mwzHjSINmM2wWVN5CH+BvIG+US1AjOdkk=
=GXeq
-----END PGP SIGNATURE-----

--yeItaIlCHDIoW77+--
