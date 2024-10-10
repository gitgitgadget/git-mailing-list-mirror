Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7518C03D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543315; cv=none; b=oJQTwFjI1CfTWTKpLA+Qd7Kqc2r5scUBFG6z2zaBwvGzXn7oxt19TtmlPGKKB7meJTNKjlUbGeLsEkPxf7essFgL+JGzQDw71hHivddi+PXhRFLg8viJBzO/lnDCKE+tpuI0u2OusLfMzxXEaZ/4iW+4MXKi5QInhJJLzZ+GK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543315; c=relaxed/simple;
	bh=IkAhMabTRb3b+ggtC4iatdeH2iQU5c4J/E98+5MrDFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpDJKwOqSCO5AiHWpwNydb/WeaX3MPYXQpViHZMSla8tMb8u291vUhEHfyiDNkaQ439pVm6SBZn3vsQ6xqcCUCqxg9rPbNH7taaixYiOW2b3fLP13/f8c8rEdZDDYuGpJ//LycAzmLFzC0cqbtw5iBCASwW/MlswuSDzfEAlOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hdkaEbbe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1ON6cyc; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hdkaEbbe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1ON6cyc"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 29AE313805F6;
	Thu, 10 Oct 2024 02:55:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 10 Oct 2024 02:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728543313; x=1728629713; bh=W29ptr309m
	PvaUekT+uf4Gdp0CfnOnEYASLJ6m7Gtt8=; b=hdkaEbbemav8AugAtSyR2pemZO
	ssz1F/QcJK+Uuj067YKVzszhOdi0GjfIU5pE+MK4O6uIPyhDhkbQktxpr30auw8i
	8aUvftnAfvBlI7ofzq4frzLAknzA9J8//J4rSB8YeDiNasajAI26zInhw21HnAsf
	cI5rHtoP27DmMmtFgPZ6CYUA69HeEpUaMFzktV4at7Awv/sG1gCo1+i/kyirnsK4
	7s6T9YWkuC9z54vnk0VhPJDr5qaGS+QfXpuOo5gPQzG8dkPTFNAhrhLicVRSSIwQ
	TszaiK2TkRrdENGqx8gwjNQleDNQlkI7xSBzQPbxiPDo/S/0w57S8HhSV99g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728543313; x=1728629713; bh=W29ptr309mPvaUekT+uf4Gdp0Cfn
	OnEYASLJ6m7Gtt8=; b=E1ON6cycM78KrL6nbz6do05CgbxpUS6z1fqWPCB55pHM
	G1OWLeQpqb6n1f/TgN3obJRH+c1Ua3+szK0SkSfwKIN3xGg7lqAjCN2v2N8L+Mge
	81SdM2I0tPezHIp2f5Bb/AhjQ4XH7p9MHEqm9/eQ9u3/j9iw4etXAbt0X7/UN2X7
	LRU/TpzaiPnTXAlEZtc7fBCacQ7HfyQit6RcTilW75pmss9+1Eocz0YWqYtPgF1o
	B5nMNKxizOHUDN7Pji3jRzpxcmMEhZ0KwzYHhMLJzPWznWzKI3eIIcbcIskqJbS0
	CTeii77pH+6G7EYn7UqCq37R9ZjUtmZrgV2aECIR1A==
X-ME-Sender: <xms:UXoHZ1zmox5ErxuEHdAO1AnNzWqVzNYC61Dc5kOMpA8Nsy9WkQt8ww>
    <xme:UXoHZ1TZhblDvc80sneHLBUogtRD61Wq9CB-ucbeYjZzgZOyfkzeoMP2m0SBs1IrL
    NLNvncc2xOKjcnuqg>
X-ME-Received: <xmr:UXoHZ_VYD2jjJQDaMarPFt5TcHKGpL8azl2wXuuwxJVWbY9aBR_oCG60GVE9i2DlFJ0VbpgRnlPjvK-EFRgSHLkHFxGQAQrfX7K6VravkAhkFMdh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhgohhnvghllhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:UXoHZ3hqNNXCRuQRvt1-Sn1NJQ6mF1djL3DuvSV-GwDhYp4UJnYq5g>
    <xmx:UXoHZ3Dp3FFxH7Ic6i-z-Ky1dP5zxW60YjhOMwKK5Tw5QtcHChksXQ>
    <xmx:UXoHZwKh8ChUDIiBy_dmdDwGbzBXfbMUBD2Bcq1Qjv_TfV-IEaDltQ>
    <xmx:UXoHZ2DrkTu-abSVBBRRhNXLRsVf6DGf3xCbuvIo3mSZpO5lyy7WhA>
    <xmx:UXoHZ6O0ccympvLHykCKN1oUwsH4XfCATN0yoiuyiwH2aY9YCTAFCZ8R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 02:55:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3926145b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 06:54:07 +0000 (UTC)
Date: Thu, 10 Oct 2024 08:55:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] compat: fix typos
Message-ID: <Zwd6TGeksR9UiM8i@pks.im>
References: <20241009114940.520486-1-algonell@gmail.com>
 <20241009114940.520486-2-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009114940.520486-2-algonell@gmail.com>

On Wed, Oct 09, 2024 at 02:49:34PM +0300, Andrew Kreimer wrote:
> diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
> index e92be5741d..15ab2d1d40 100644
> --- a/compat/regex/regexec.c
> +++ b/compat/regex/regexec.c
> @@ -292,7 +292,7 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
>     concerned.
>  
>     If REGS is not NULL, and BUFP->no_sub is not set, the offsets of the match
> -   and all groups is stroed in REGS.  (For the "_2" variants, the offsets are
> +   and all groups is stored in REGS.  (For the "_2" variants, the offsets are
>     computed relative to the concatenation, not relative to the individual
>     strings.)
>  

Do we want to fix grammar while at it? s/all group is/all group are/

In any case, this and all of the other patches look good to me. Thanks!

Patrick
