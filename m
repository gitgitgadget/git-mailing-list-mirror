Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0517582
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453499; cv=none; b=tOrKbqRLCqGeQRKhkhtJJvy3q0OLONbJ3Lzi6GbjA8Vmdi0k2MtI5y+l5Tx8zKCknMjjJGiuoWzc1xb06sLsOvs6uZAetNxy2JwFpVVXistdtbHRCE8SE4pCPyXe7hJaIyjwCLxCQ8S/yMJ1Bi9/EzopKlMTB9DUBmkXDvVmJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453499; c=relaxed/simple;
	bh=H2ZxqILMTbxSLjZ/5jq9NtW1Efg06BSrtjuI+FspNzM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEHIWxV4maxpdw/qyRuoPXYuHXEA2B57+shqMxm326yKIFEtM5vdIFcQ787EIAIZpx1ImQDQhVkAWs6wKhnKg8cFgMqsUersGbJ+OA5o5Ol0WDNyBvHvHNHIXSNX7O+GLGXY2gWrVpQ/XV9c/w6PDlKarOdGlDO+uFpSXY3Y8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RwZnWe7X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XZ4YwCkc; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RwZnWe7X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZ4YwCkc"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id AB4F41380263;
	Tue, 30 Apr 2024 01:04:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 01:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714453496; x=1714539896; bh=317MUEhxsT
	AzghgUpJU7dAE9nl8fexk19+tgFJ3KhwM=; b=RwZnWe7X6KltbHaHJqsZKFULaw
	X61RNlxCq8HSjDYSJHFzq5kOhpDdIAyCrs6goWs6r3z8tlIKZUCCkXcxTstSjGGj
	oy0bRN7x3JFMoOPJ0rkP7qqJprR6t0oZ9iu6Z0kywdpShRmQf8Rw7PCq4o/hISFW
	NQq23d2d+T3OAY0RpxhxwSXQ378GGTPWnnxGpKE/oN/FFCOzeQ0ZMOdhVlK1h+MS
	nFE5sBdea1WVYzHDPTm1cA6H9n481BzVHwPNSnfMNcoZQc9d4ptPzjrU/BysZPJJ
	AXdLbpj8KKVZS4v1KdU5DGDgzJv7XHDhugbk+20d2Q8X5oadis7OAinkK0oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714453496; x=1714539896; bh=317MUEhxsTAzghgUpJU7dAE9nl8f
	exk19+tgFJ3KhwM=; b=XZ4YwCkcr8hmpycN9P+4OlfFKTBBVEqsN66Nr1gGSgeC
	u0EwGzfxr9GHLXLwXlJ+gKLfWxREJLynRklwcy52v2aBed72ZC91P24T0V3zS+lF
	wSmsb8jWCakuqa9422MfZjxa3q2TBAbKt1qk9s+TzG/4Ed3w3PB2yxYqS48q/AOt
	hoZvQHFhJvW5SO9L3lU+lO+Gt2zIo0HrThFvpSahHaLR/6opv/qy0XmFgqd34SJ2
	r9zGqyAEg5KPnjWCH8Cc/WUpBX9xN6L2SHrw5dffSwzGBQJojPKpXSHm3pLGiWGs
	wyfME73xnBkFkgpc9a9xE+NpjbeWrWhAqbIlJpQIZQ==
X-ME-Sender: <xms:-HswZjrs-YsNWER27wIv7cGQ_MKrQSa2kA2I4-7-QpOCVgmH1__ieQ>
    <xme:-HswZtrME32LTDQdDTks_nVnU9gQXEPNdq8fV9OZISQ7uqA4YhvEeWtEDJOg_tHvH
    UWCIewCx_PybHeyxQ>
X-ME-Received: <xmr:-HswZgNt0ueMNbG1isj3VX4FRHvFG6YasiBW-xuYXgYoRa7hGZYwSYVHGa2KIg4ywdU5B4m7F4d6WG9hfZ74bvwazZiaWETc8orCSoxZrMdfSAvOhead>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeivdejfeehieetkeegjeevfefftdevvddugfdvueehfeefjeefteduuedtfefggeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-HswZm6IMCBqyzlnXyIzseGFS6KZ0TS-X1_AHWs4YtEGUY9PqXhgzQ>
    <xmx:-HswZi6v6LR2OCUaINoj5Uk90R6qHFqT-eAToE0vx8rYsoP4CEq0Jw>
    <xmx:-HswZuiGxPfqxkuc5-BpIcjVytKNgBoSRkbuAPiQSe5CBgU45Hy-jg>
    <xmx:-HswZk5yXxB-_zKhHqW1loNhdDyuhfPAbXD8TqTYeMcG4HEsgsbOaw>
    <xmx:-HswZiE0PXf_Nb_O6otrT-gl4kL_Z6QSThGM24LUuWFpY4ug8MTA6Gbo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 01:04:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c2eb12c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 05:04:34 +0000 (UTC)
Date: Tue, 30 Apr 2024 07:04:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <ZjB79eQbuQKrTzF8@tanuki>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <D0X33QRECNTC.33V5ZK9NYIE1F@jamesliu.io>
 <5p5ot4juki7v2lycups4jhadxcw5yzpqtjkwgxzwrlrpu6mlmt@gis6xmwjjh6o>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p71asVRP3ZxxYyOZ"
Content-Disposition: inline
In-Reply-To: <5p5ot4juki7v2lycups4jhadxcw5yzpqtjkwgxzwrlrpu6mlmt@gis6xmwjjh6o>


--p71asVRP3ZxxYyOZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 10:01:15PM -0500, Justin Tobler wrote:
> On 24/04/30 11:59AM, James Liu wrote:
> > Thanks for putting this together, Justin!
> >=20
> > > +check-whitespace:
> > > +  image: ubuntu:latest
> >=20
> > I wonder if we should pin to `ubuntu:22.04` and only update this for
> > each LTS release. It seems like we've done this for the
> > `static-analysis` job above.
>=20
> I'm not sure if it particually matters. I know Patrick recently
> submitted the following also using `ubuntu:latest`:
> https://lore.kernel.org/git/01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714=
371146.git.ps@pks.im/#r
>=20
> I can change it though if there is strong opinion one way or the other.

I'd say it probably doesn't matter much for this case. But using
`ubuntu:latest` means that there's less maintenance going forward
because we don't ever have to update it.

Patrick

--p71asVRP3ZxxYyOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwe/QACgkQVbJhu7ck
PpRwpw//c/0Se3Esxt2uyAditqJnV63hDSF/pM9vD/rn2LBdmLbneUw2PxTyyW6b
yPCUn/lZEYON9s3Uw108t6/XupKXk/8ulTivkapqWpVaWXAqEBeCaS3XfMY/K2T4
4u+WSikeZ1WrK94JM3oxf5iSKQVvsOyXvW5TFC34t23B095HnY3+rBUFXVPzWOj+
JD0B9FG33L5Phmi8SV9hVwoq8z9cng/DdleaeHI/4FQe89p6iUJ28q/OAasEru9I
X0IGW5/Cv21+1733BogdUqSNIrcGYC4MGoQWed91dfvAOUSlNrqyD8d83hQMjk0Y
TnXJ4Yfgc9VfAm1rwgnHnAuZhVt9JzdJK+uWm7293ECahAyEu3c57IUbdYB13un+
/pkpn0dV/McpIG8UK1qG1se37iUoQnt4oG73ZOJ8PS35QW7OWFJdCI2UNloOspoD
HbgY97ORrZ6bkbShGdluZ1HT/H6rtN+Jcnv0JijnZxZ/EXIbVOMVK1HmEFO+lcEa
OpJoIkvORG6gwabScVjPY5BhSY/PQLKE+jiMd+LT+19kd+bw052oXGxUwSrc6Fd/
5KKtOC4AoahnDRTdQzedTiNm3Wx6wj2t5bmNXbIJPL+fGXzgJWgdq4TLXLNCoG0k
I4P3uw0JG9ipBJR+/PHgQUyBrdnMaLZDntv8DTxmbrFUvf1CenI=
=IuPa
-----END PGP SIGNATURE-----

--p71asVRP3ZxxYyOZ--
