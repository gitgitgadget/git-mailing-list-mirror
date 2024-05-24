Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649CA2C694
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545647; cv=none; b=JHkDWgPbYkvUaDhEyG+aizh5v1Y04nLy7Q9etJpOjhnsyQZQD9YG/feLuKKQ/2O2hMGCwWGqUdyCAAAD3QfZRUJyAyxsoC9gx276dF/EiMkPpYqVWTk/RPpmqsx4S/VK+zvoy9IxOQ/MSuisXfj50AQvOmTYZxz8QwD2PabT+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545647; c=relaxed/simple;
	bh=LbewEcdAQ+El0gmRKUSOQy+bI+EAv16aBJ/4QJc/9qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAjQfmqhxKKsn5ceM2Ce8QqSX3tUhTUOsuD6LXUAVrGkdWi4LINIPrTXjhZolZOhdBDu7UFZdnMijgi8rOh6u7WEdKUB0ji2h5dPpqjIegrrpgXoMdi7Wj7CPxI27IeKQHP8CdjiD+DxTOxW9GTltBvyjZu1Lujp6sjctzZMGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aQPUgK28; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nXeHU1ht; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aQPUgK28";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nXeHU1ht"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 669C813800DA;
	Fri, 24 May 2024 06:13:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 24 May 2024 06:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545633; x=1716632033; bh=LbewEcdAQ+
	El0gmRKUSOQy+bI+EAv16aBJ/4QJc/9qg=; b=aQPUgK28YWn2V0KLjEVd21kBaY
	A0nJSuAsgLD6of64gzFsz65f+DodV19HeleFkMS7GTcYJ2aJ4OSJFKfeISQhc8e7
	EwVjm6U0s98d7efI2bOEIsrCL/FZ7j0VOCiJR84zaEWZ2llVsX4CMwK4sn4MlFCL
	fJr6he7KAT+yq1oi/msfULpy60JDFo6CIcAsxM+sEDo+PW42rbrwkCaJEcXzEj+i
	5ACwYGt6RXn+lRor+QLSx6XfB4CLh/OiUNrO1bd7NG0B39nLMKWJsmheta0siBjj
	WK+sEUlfkcoVhU7bPThLOF8qMeWBJRxc1jpa2rjMJ+F4Cao4fbjaBgfy0zRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545633; x=1716632033; bh=LbewEcdAQ+El0gmRKUSOQy+bI+EA
	v16aBJ/4QJc/9qg=; b=nXeHU1ht27mw6fgmFHgAhQrgaIzSJ0zctplcrXlGATP1
	zSFflrj2Wogv1BYYdxvbYYDKazEP/BJ66gvE4ULuY3OxRfyuT5WN/jipMUos/UfQ
	ptybOW8AfeBji5c0+ySNTNfAFdZFSXNfC+YO4ugG+p4yd6Ch6xuslemPV1Fv0MgG
	PKEY0TboWsvdAKJOQ2OtlvoolQ5pvdmUjAs36yQs3+7drQEssmdsH9HTdA6R10kT
	PIEaAZdCLsp89RQuiBRWdb2DwUgq8bjNCDzVPeS5BRucZPt7JS0z5Bxv+JTLytAc
	Nq7wESXzf8kgjErffcakXGJJvrW4ruXX0gjTOKBfBg==
X-ME-Sender: <xms:YWhQZs4THYfSojX-KBkXcFiz-ZtBu2OqMJp_j2O77G5tHLp9XANCCw>
    <xme:YWhQZt6eCtVMM16vnAmz3oy5n6uYzsUQEfVYbohPqeMtUuiLxIiq3bYpoGqwUXsaz
    -4GsAw9CneLJnqB0A>
X-ME-Received: <xmr:YWhQZrdwSTCxoAYPIEcYbGlogD9SPZ9ONJjpI5npiLnqbh2UdoUGxxcX2C-6_P1aXgdL8yAKxHTXFpqU09zBD8UPxa7H-UFpIcNUJezCUTC5BlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YWhQZhLUIGr2zSGwgsrL4NyGXS_kIVVDhMVo7uoIX-SbG9Rirh-A-g>
    <xmx:YWhQZgI8XgfEefMZxDqc7VmZG14XKNp21iuei_Sb5Ql-xRXDYJ-3JA>
    <xmx:YWhQZiz1x1u7D4wUY1AE-7aq3kyzFhe6LP3hW46jj30_zCzKg2nmfg>
    <xmx:YWhQZkJ9lllUpSAH6eWoOrRt6xrTkZd3fXOgj2OPoIeQiceKd0SP7Q>
    <xmx:YWhQZk1UEa-hmaFww3TBKbFoI0jSwk0Rda1-EweBq7tj1m7SaiRvQ84y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:13:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 10ab250b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:13:48 +0000 (UTC)
Date: Fri, 24 May 2024 12:13:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/21] config: plug various memory leaks
Message-ID: <ZlBoXcJr8SJFiZbc@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <70e8e2651306e9d221e5e472720a7610947580a7.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Litis4D+iHz69nru"
Content-Disposition: inline
In-Reply-To: <70e8e2651306e9d221e5e472720a7610947580a7.1716541556.git.ps@pks.im>


--Litis4D+iHz69nru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2024 at 12:04:12PM +0200, Patrick Steinhardt wrote:
> Now that memory ownership rules around `git_config_string()` and
> `git_config_pathname()` are clearer, it also got easier to spot that
> the returned memory needs to be free'd. Plug a subset of those cases and
> mark now-passing tests as leak free.

Junio,

this mail now uses UTF-8 as encoding. Does that fix the issues for you?

Patrick

--Litis4D+iHz69nru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaFwACgkQVbJhu7ck
PpRwWQ/+ODGGfJ30r0g1e98bWU4QzCqk6XplflJEtF15KwTvrwiKFO8bqLo8p4SE
MHex4yPjAl8YcgRji4uwyh5iW7QAauY8T7tK0r6gRzHWKA79I/zPAJ8wDBkpHsdT
H+UxMBCR2bkzBpx5h8lcZz4N26VFsVBvHG57BJrXGw0u38y/4ChGBW5BiAQ3ybts
rBjdO90Cyt40EF/0m65w4oF7nZDPEQmDIa8VF0/ijigjKHkvhqq0CIELdunoWsfj
S6LY5K0FWrqApvq37uzyIT0PGFZRiUVMzbyWVlZiwdRC/pr1wVFUE+L42QgFCLuS
CxJ3lDi5y93tTydz1BXHFAqaC/I/Vl3St6AxbaybNiMTe2dvPDl2570j7jhwhdxf
fh/+LV4OnEgn0Z4Y/mlfg3Q9vkZJTF735f6vxlWkpNJUG9OdTj7XZDZsjwJ/xXgV
y4dc7ztDF7tHR6wXA/QzFDmN6NF+K7/ZdLFAHLOlVEDNFKgkiN0dtYmymDpUSzqz
BAht1LIlLOcbT7V+2wBmecfh39vg6mJgpy05tSXvh/E/PtRsjGif1eTIPh8a8hdK
0GKei+uOgHbjz9jv6sA8B5gae56K0mSCq0AO5SYo+Rk9f4B2SXGGog5fMwgOgBul
7hwku+DeQUxU+Ru5Mb/f+ZTEeEb8JVu9DsLzT8r83tdef6R2Ryo=
=ODCq
-----END PGP SIGNATURE-----

--Litis4D+iHz69nru--
