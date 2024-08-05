Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D447158DDF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862698; cv=none; b=CXWAXPpS70VQqL2MMk0UlAE/FEqZoB4QFktTvZaFpjRIeB3q7fbKN/8v0XmwkPDk7Y+bTc80JEnxr49QeyOhkVTzAs3tcwsND7C6QwsPUC/eB8VgYSL0r+h+ltzv6jnN+72mdDeVsNh810xbdr67s1FBdi51lBQJDcWqJpwpD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862698; c=relaxed/simple;
	bh=DKpN1L+aEZffe4FgKR7zp6o3bv5LelzIVNMsOws+J6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agK2H9m9u8G392EzwPXi0q/6giJU7xu3w4F6h27ySb6ZvP5fZ9EUFe6FB5rY2kq+pfqKn7eR+2ov3oR1EaD6awDUKz1mWxO1EvgmVZfUtIrXXwG/NNnRYPkXjdBLG8g5lI/ubVUuA4ZP9NhJTjRkuWW4p8pPcUp3PW6Xn2PGRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n6/60/rP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h9RC2x2F; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n6/60/rP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9RC2x2F"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 326521151B5F;
	Mon,  5 Aug 2024 08:58:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 08:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862696; x=1722949096; bh=KtaWcPO6ZF
	viMtW+h4XFhL/4/3orBUu9MIngBGR8mkY=; b=n6/60/rPsphS/Kv/yDX4zWsV3S
	6vCKKcDEgmSQwhS+w17zTRzZ+f5zvBIiEjQ/RX/d0XdClJVCBlHVxzdXsBbGje80
	s/2jZ5lFDVVRQmUIoxjtRxe2RQMEdRDPENtOUCdqyphvrV/uoPoBp5bUT/uE7tqc
	TKbK3IRof7az7zum4Hp/FzZijgfv2mbW4XKZOSED5S8Jyac/2mmGfLtoCsauv+QK
	lkrRb/+pdzb4r/rh+TqQkkcH6P1nea3ATumEH5TTCjdQYrGHpcgDVBK0Pov5HmYZ
	xkBFyFyFHmdti2FMxuPl3krKHnP799zA6mFtXAeYKEzSk9dyX1YEXV9Tqvng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862696; x=1722949096; bh=KtaWcPO6ZFviMtW+h4XFhL/4/3or
	BUu9MIngBGR8mkY=; b=h9RC2x2FTq4eNsIK4hsZT3V2H79HxoKw+NG82JcufyGW
	h2T4FYzztu41F8/CxL659Sc4JXNYHk13/oS4UnPEPkV5lAmVBUgmTtIFTCNjdZC9
	0iSDS/CTS7G7yrGAc9C7/IRjPjOKppIVnLRctGsKbNR29I9IbqjnIJdQf20/v5Af
	p2JmE3h7sWsObdQhk3V216LUjyGINK3V1CX/9RmuYhsnAMwwPcA3gaB4Sr4qpyi0
	I6XtcmQo3w8i3S+oHq0Woqls7Cxn1kvqYevRoVLF4DE/hxTtsG+cLvuxnX6L/BAj
	qGQTCYJHKK8/UDAtH5lYLSllnqRrh315OdiV4/FniQ==
X-ME-Sender: <xms:aMywZnZ_Tx99DmMNg47tQbAsA_WDkTi16GkspjMKP0_6yRSie5PTEQ>
    <xme:aMywZmZlG95kfIg2bxywnPy-gbs605aEKDH4f4PKXToyZ1Z1XbGcLl_V4KggCHNVW
    KBNjt7rdcsTuEFvRw>
X-ME-Received: <xmr:aMywZp8oLBSy2CNBSY7uHuyfKHnXvzANhXKkxP6Rh5EUKTcAn-hvgrPkQGDFBOWTo7KKI_s8IybMPCOUrfzo-jcB4Jm0P6kf9gANTv4AY5BeNaYAsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:aMywZtqRw9zfBj5oYdWdwjn0zrU68vs_KkNxAyEc7A0p4GxMlqnC0Q>
    <xmx:aMywZiq6inE-JryPc7PsqoQ3a7pGtGKCiQl_c6p6dLcpTWu1B28d8w>
    <xmx:aMywZjSc8YYXWWsWkipilTt_lnAipcDFygp-fs-Iu_INgQPQcbhKxQ>
    <xmx:aMywZqrLwxE-_yypgaZwj79XuC9iYV9Y8VQM0GqG-WG-C2_Lze7OxQ>
    <xmx:aMywZjeuEz_JQ7MQm2eU9aRNGpKoZkW4f3apb40cWXhY8ZQfFuDBHs9d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89d55cbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:13 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 04/11] fsck: add refs report function
Message-ID: <ZrDMZN-73ZxF95Gb@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumQthEwDjoDs6u@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTRurJ+mQmgAeBGM"
Content-Disposition: inline
In-Reply-To: <ZqumQthEwDjoDs6u@ArchLinux>


--aTRurJ+mQmgAeBGM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 11:14:10PM +0800, shejialuo wrote:
> @@ -216,6 +222,16 @@ int fsck_tag_standalone(const struct object_id *oid,=
 const char *buffer,
>   */
>  int fsck_finish(struct fsck_options *options);
> =20
> +/*
> + * Report an error or warning for refs.
> + */
> +__attribute__((format (printf, 4, 5)))
> +int fsck_report_ref(struct fsck_options *options,
> +		    struct fsck_ref_report *report,
> +		    enum fsck_msg_id msg_id,
> +		    const char *fmt, ...);

Nice that we got rid of the parts that don't matter for reporting refs
now.

Patrick

--aTRurJ+mQmgAeBGM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzGMACgkQVbJhu7ck
PpRspg/6AsQ9CvOBUvL3elW068l+JPU74YYJr8cOMZVMIPT4Nfji7/Uz2yOjOKZh
s4hrmiZ5+qZwNV0l2V4963xEbVYBBvtcYwEeZ1xgY6ZWfKBCNJcM/C6Mr6VcDZ1i
yXmnS//jXnsdLpDQxzOA038i+ihmgNw5Qm0rU0qSNtwiYS+fHFINCFsSByF3h0Kt
UIFgM3suDi8CaHcaFUM6VCFt9kCsxr5UFetLE2n7DKLTVoX/DPI/DrUVMxRsRyx+
AizlR1Jx4Bv4M/BzeE2gxnIH0/l4Zk5B//2amOoV9+JTJyB/mB7+Q1hxL8sxYj9w
3ukEUQ3C+Kr5WiJOa+7foWIWfqxNeLD8PlceMXMGwvkjQnTPmcScuhq0RscQMIn7
c/rZHJb5ZKIhA2Nuaq2pQE010r5FIqnwIEsyTfohh+qT3hWaBOHkorkKrY/S7MKs
I5EEvF6FUAOOd7E0YTih7AYe8sn97OIiE+dlF0BREakIkJTRuSjjXYmFe3lXwXIn
VfSC9dLef63EPGht1VJrtAbA+nciSXSLAMXYeToa7StaxDyyG+3LCM+M2Cof/hbp
wVlA3yMK6xrPFedlW0XgHrfPpU5SL20KHWplr7wSnW9NRRPV5jyFVMl9tnelycEb
F7Tth5i/FLewHEybPg2TO/ZvOZtv2MktWdAjIwHeTpiXPyxDfbg=
=ONYT
-----END PGP SIGNATURE-----

--aTRurJ+mQmgAeBGM--
