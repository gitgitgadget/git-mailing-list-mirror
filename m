Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE2145352
	for <git@vger.kernel.org>; Thu, 16 May 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857772; cv=none; b=qM7MeXtqBirUO53v9bveUzBSwSrJaZswW11J5lX8wPAtZhGHd5V5mJTCnCyX2stpmmTIM679lwTNKj8VCv6+QOeOtvXMG8fLIFbAG/nUfGO/bO8q/ezna1HCyxhqt2F+0IEjDq2voGUg1fzxHCI0H+TUMFBRQrj+UzXqHNCo+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857772; c=relaxed/simple;
	bh=uVMvMKW+L24hlbvRYt64wwquHyPRXTmxuHgmvkj5rDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+q3jXQZc2CGx+zGsqe4uTXDJ0O6GCuC20QiVCEASNqEUlRBtpIzWCxdT0IvVCxM28RgZNkHbkE/WXH0gT0Sl2ITgjpq8iF+e3OsTIG5PD5RQeQE0Msk8Ec2C5EgemKwWRQb7yrtD/KxyW6SXoF4iTejadqoC+P9nOURntPxsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bSWWERAt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ge1ubVEs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bSWWERAt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ge1ubVEs"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 884E113803A8;
	Thu, 16 May 2024 07:09:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 16 May 2024 07:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715857769; x=1715944169; bh=P15JDVu5mT
	mXQXhlA6I40s18KIIMQ90xc/sWd0pZn78=; b=bSWWERAt8DhD8dheblIkKhqBH2
	2oA5RA8/rzDJZj8XzIEE3BmDXaOsHRcSsrUtWAUnvdCs/fWA2B7cvI2JexZ8a+mG
	WbeAm8mHL2EA1Uk69F3mzAnzJYQatWwFw0GmgktmzvQESJWC7T5rWHgtEunwMCl3
	kHV14DRc9yWGHYQOCrJib9UX5Gfy25Je6454Kv4ZCukxgr8U1VYooBO8xXOR1YZw
	QfyMfLdvn0Iv8QAJtd2VkAlpmx1SPKgD3yLKzLJhRHdrH4k87ylqJgnqfV388Paz
	wDAiwuJAJAHlntWSluudULNggQ8rs4WrnCxiNYj3B9kS0HfH+zjFQjwUBEVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715857769; x=1715944169; bh=P15JDVu5mTmXQXhlA6I40s18KIIM
	Q90xc/sWd0pZn78=; b=Ge1ubVEsneC4a4MqaLcTwNS25ApFRbU4cYwH4CE4xE9x
	8ZvAPMXhIcejwaj8NlJa4F72vq3ZzQG2NfCvDRsPiHq3lrhNsrMQu9ye+xhoPaoo
	2YbDKMjUdRGix44ElwE9B/yzXtXTNt83nWnrbaSGHjaKx2IWjkHmj9d9Kdl1MvIe
	yPZfAVHGvWgpgSRfrNfhm9ftrZO4S4IIwl2GFWpQ6boSBsfS8AMpFa65c6hjDKaz
	V/jMDHxDGNIaYm0x0CGiWGKUDLQ29lpEymIxvXRgq3cvcYT6oAws6gMWX3EE4BKI
	hbPi6pHsjRrkPjg/POVPPhrWBffDxmFoS1RD77/nQA==
X-ME-Sender: <xms:aelFZs5eWR6Mf38opLvuK7xbrdsnFehfocjEH-KRJqIF-QX65eTA4w>
    <xme:aelFZt6NGIk0JqDFtVRvOnbsuohQsb1YQO3bt_XGcu3_5j8c8XHGeJBH0oSKPHz2-
    WfLEFzBEsibgtIxsg>
X-ME-Received: <xmr:aelFZrcz8rIFUywPDkbl6xgP2dr5i-G17jkeSGQEZUqjaNaaThViopeuLRf4xlo3_FsJj441EoHgg10_y62-BisSSPlzsqiD8ozjkTVwzVqbEAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:aelFZhLbLW-vHhNyDAUrZlf1vjROAdPJlP9BFK-aDurKiFLSbXnICw>
    <xmx:aelFZgI3NFYVUZfTQ2JuWCmDcUc6hqLk9B2gp5ajyEBUJwJtd5XGTw>
    <xmx:aelFZizUZZAaWCthugsQoigjUtzyZF5eVspXWTdTA-49An-hd72Gbg>
    <xmx:aelFZkJwKCtw7uarv5U2ZizFV5aBykWqrHp2OWu_EZvxQS_CoXCoFA>
    <xmx:aelFZk0T7L_0tObfN9DWeSyh2JAaW36ftL8Xms0PRN_Wohx8m05Wr7wH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:09:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 25b454fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 11:09:04 +0000 (UTC)
Date: Thu, 16 May 2024 13:09:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 3/6] update-ref: add support for 'symref-delete' command
Message-ID: <ZkXpZss_RZbIvZp2@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240514124411.1037019-4-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ErGt1AXWW1VCLFd8"
Content-Disposition: inline
In-Reply-To: <20240514124411.1037019-4-knayak@gitlab.com>


--ErGt1AXWW1VCLFd8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 02:44:08PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
[snip]
> @@ -1317,14 +1317,18 @@ int ref_transaction_create(struct ref_transaction=
 *transaction,
>  int ref_transaction_delete(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *old_oid,
> -			   unsigned int flags, const char *msg,
> +			   unsigned int flags,
> +			   const char *old_target,
> +			   const char *msg,
>  			   struct strbuf *err)
>  {
>  	if (old_oid && is_null_oid(old_oid))
>  		BUG("delete called with old_oid set to zeros");
> +	if (old_target && !(flags & REF_NO_DEREF))
> +		BUG("delete cannot operate on symrefs with deref mode");
>  	return ref_transaction_update(transaction, refname,
>  				      null_oid(), old_oid,
> -				      NULL, NULL, flags,
> +				      NULL, old_target, flags,
>  				      msg, err);
>  }

Same comment here, should we BUG on `old_oid && old_target`?

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 8784c59a53..fbc6b234cb 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1689,7 +1689,7 @@ do
>  		test_cmp before after
>  	'
> =20
> -	test_expect_success "stdin ${type} symref-verify no value is treated as=
 zero value" '
> +	test_expect_success "stdin ${type} symref-verify fails with no value" '
>  		git symbolic-ref refs/heads/symref >expect &&
>  		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
>  		test_must_fail git update-ref --stdin ${type} --no-deref <stdin

This change belongs into the preceding commit.

Patrick

--ErGt1AXWW1VCLFd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZF6WUACgkQVbJhu7ck
PpRXCA/9HAazy+fzKAOV1vtvQYArpenr2C16bHrl1p8n5SFdnFP/Q5POJCl5LkNO
7oh3UZyyWnVvPDsR+2fx3+VTp/lHoSjH96+GK7wI/5AjlcsI+aTMPVMLie+hFPwJ
adSWGA7l7KL7UW6U6BBDfO1TtmMypO7HM3QG3BAh3wIijWUjHFxnVsJk+7nADm73
8Ltu25jkQiJxcGlB1LNXdO8SApl+GbCTv6BG3hAXQLCveilDwPK1KDO66YLxldEo
JA1RscHRP3a3F2wxg/5aQW7ZVofPmi8S4x3FyGAERJFYFlEn4b6NB6Bl0qHlyzcQ
jrZhhFI3OKJqbxdS+PUNNlHzZcYYvmCp4yrcdJBU/WUB/8q/stXhaDf2b/IwyNwy
RKT3syBsg7R+wPxwWfYEfzejfdRFpGA1X1/2ehdHXXtP6wKDbVGWUBIot1Us4kQr
MGYdPv+++M8hjKp6Q53B2q8u9jNHRaMEvY+UFlL134Z2hejIZDl6E6OzdVUAtJXV
UV/5s0sTfT1KUMVLgQYDMJN1txOI+1zZf5eZCeolBXhVb6pWuE51HBXREyWXUHNI
R/HuftrXJGeD8qiqBG0YCQYi4B1PlRz3IVqq4svXJX03tvnOKKbqHyRtZL7ATHA4
E6H2+94khZl4hLU0sIeYLUktMeJt4es+LXkMHSdokI4JKNiLe6Q=
=aYub
-----END PGP SIGNATURE-----

--ErGt1AXWW1VCLFd8--
