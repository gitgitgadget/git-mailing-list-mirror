Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C371753
	for <git@vger.kernel.org>; Tue, 28 May 2024 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897813; cv=none; b=JfTw9Bzjujpa3oNgmjSX5p5XmZ/oYonRwvqdK2tjuRsOTc0jtx+f1kXDKvI0m3nT9afw5Hr1xTLPphIdGVv6CJlCXRBB704+HbDw2cuokZL2nBFnTDYv8W6lwvJ3Ae5KNtPPNZbAJx5236Pw+LtXVLELgFwV35aoKQi4CFcvu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897813; c=relaxed/simple;
	bh=w5RedsJHyrQFviOf66qow6HthWxAmc0aMFg1gkQGTzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGAm9FVYkC/FogazM19oeoKAsQxsEoQIr0+aHDdeNlqce/9VdIpiMvnAH5IdHUXAWRCpQBmEAhytZUUmmJpd9i6TowGsBc7prQYYXLHRQnTNJbLUa9KvN+UNFi3vFa+RK5p8w17i3ykcgS/4YTOzrtrAnmnkyB3/i/AuzLe+4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WyIYueYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBRTiypo; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WyIYueYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBRTiypo"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 33FF818000E5;
	Tue, 28 May 2024 08:03:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 May 2024 08:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716897809; x=1716984209; bh=vafLxW2+46
	mb0xwME3Wx7KnSHejyYF29Bk7VX4BFyxg=; b=WyIYueYLv8XiTT4Ijmb81ss6CY
	YznvWjLmTUj34KAtsOI0tV6PJ90JsDm7hbIN0qgS+wQBZmG53D5bNCm+irv71/GE
	UViXk1TtUQubBbfIifJ27ag9ZUZvw04aWMb4uvWe8NgIAJy0H+yfOoSK22KCsVbH
	xPrdUGPgvTJlBNiLgpxxKcCayLRVwSyfuFlA8Bb3SjdEyAOI1S7X/JMCKO5H4Pmb
	w6t3XfbKo9bo82azBG5otsk3jatgl96EJMg5GvlrTH8MxLR0FZ4V4quQ5OkpQ6f+
	JnwxFHqVauaCAsD7Vxt+1H2Mp4AnS8mJQM9ayJvfj+9bJNIRXQGNp2MBSvrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716897809; x=1716984209; bh=vafLxW2+46mb0xwME3Wx7KnSHejy
	YF29Bk7VX4BFyxg=; b=MBRTiypojE58o5kKG+koVggVtAjM3XHmmw3dCAaRFeku
	turKZw7Gi8/S8ji/iQBEDH7wwdO14TQMU0AovlHUeLQpi4qKwKbApTpaxOUsRdUL
	26MZ7I9YQWcPL/9CjNZH86bcu/zqriP+ummiAvq0htMkTPaB+1t4o6QGYPmkY9Km
	fRClgJux8a12BBXQkjbK7rX8xKSU4z9U/G4IbJ2voiP8HivzmvzMAXErN7JRPuzv
	0wWED8wBlpHr14F0mjTB0N63PDcftuZxVDlIz1xYqqRcQMrC7ejRlV9nkKXKG7lg
	YSWWv2HqpgM2O612UBjhHrRwsL6Y798JWFbLTrLPYQ==
X-ME-Sender: <xms:EchVZtZYb-ToSZjyB40Xfzb8SE38SdTYfkZMnEi_dS19QNWJEd2KAw>
    <xme:EchVZkYzdw5cRD3gdXxy_l5pzXZ85oliMArD-Q8s1xuq00Ze3r0X4uYCJA-XKzurz
    8kDUMAfzb9zqcuYFA>
X-ME-Received: <xmr:EchVZv8QujANFGfsnP1r0w3fpvgJ12TxI9b92Ht0brFwhZty87mBmrzezHr_vhl2hsJT-QBWdvMzvMdffhMYQ-X6MC0sGhuxBWksXM7huDz7v3zv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EchVZrrCdfxTJX-sF4WSbgV86mtW_UHxd4WT81_YivAsWWc_pB2mRg>
    <xmx:EchVZorJ0lbLkyU2isDYr82dVZDl451mWchxvvS-PdmLwcjfNLYW7g>
    <xmx:EchVZhRo8FCc08IbdqOaiUpMV5DcVzxppm3UrK1Y7-Yra60M0DrAEA>
    <xmx:EchVZgra6zCFANIORkI6Qwdm9YdpVgJ7PFqPygH4tiCBDhVUtwnd1Q>
    <xmx:EchVZtDWCENMVFbQ1yBsb5da1Z4l2GLGRimHUtl-kt5KsLiRuJIv4Rg8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 08:03:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 23314862 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 12:03:15 +0000 (UTC)
Date: Tue, 28 May 2024 14:03:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 2/4] unbundle: introduce unbundle_fsck_flags for
 fsckobjects handling
Message-ID: <ZlXIDXfc_1lGb51J@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <057c697970ff49301cd9dc6adef099f53d440c3c.1716824518.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QtjtMOiV7ErfsrvT"
Content-Disposition: inline
In-Reply-To: <057c697970ff49301cd9dc6adef099f53d440c3c.1716824518.git.gitgitgadget@gmail.com>


--QtjtMOiV7ErfsrvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 03:41:55PM +0000, Xing Xin via GitGitGadget wrote:
[snip]
> diff --git a/bundle.h b/bundle.h
> index 021adbdcbb3..cfa9daddda6 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -30,6 +30,11 @@ int create_bundle(struct repository *r, const char *pa=
th,
>  		  int argc, const char **argv, struct strvec *pack_options,
>  		  int version);
> =20
> +enum unbundle_fsck_flags {
> +	UNBUNDLE_FSCK_NEVER =3D 0,
> +	UNBUNDLE_FSCK_ALWAYS,
> +};
> +
>  enum verify_bundle_flags {
>  	VERIFY_BUNDLE_VERBOSE =3D (1 << 0),
>  	VERIFY_BUNDLE_QUIET =3D (1 << 1),

Wouldn't this have been a natural fit for the new flag, e.g. via
something like `VERIFY_BUNDLE_FSCK`?

Patrick

--QtjtMOiV7ErfsrvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVyAwACgkQVbJhu7ck
PpTKYRAAjreKG/p7IBz2ypC353bIrzLR8XYiicr5r45BR9JlCm5fphGTWt7ctWOD
W2WZhfOwm9NJO9kPZKZRvzITbRpBR/szW3JME6hR09gg/mUMLS070a+k0wrvn5/y
DMiy8j+MqpksC7Di7aRSRpDuZ0wcaHTbDHX27x1dGK5UXY3v87s49GlrUdG3WWIN
DKsDp/Qpmd7fr4EwA6w/YrEzo+IhigvBO5fLe1C0Spx+wrx7n2hibYccKPIn5Hiz
U3L+otJEJhjM8xDO96U78qtMLbvasIhcn5trFEFqK7sTfRWJrSsBWzrRaR0tTayC
JAatlO2BrLobcTayRoNYPtEl7Bvlv1Eya0TPurVZjnu8IjL5+CbxKbAQm/ZUZZZv
KW6U+NdOU6EPmWkT0XX/wP8BNFbDz2LF+q/IUXONm9MnvmOJFG/Tgci0dwKfLKhl
lh21oDPM0TSAS6ezhUWPLXMEyB7zm7rYl9TL9UF5iGA8D+SGypIUJDfc+f70lT6A
wRD72/J25A+sqLaznglkfa+AYhBbJfMs5GHxbjY0LQZOrnONgOZ94ZGG4vmssqc9
upm7E/WQ1xuZEgSmNrQN6HtZrZJFEc4NE/gOk8tUStJuWPR5+UY1Mo8IPq8aOuKZ
BhcpTgd7YuQzRNjtMbKh+crhClmfUi3v6lwZ/zq5UBEYeFpl5Zo=
=M0Vz
-----END PGP SIGNATURE-----

--QtjtMOiV7ErfsrvT--
