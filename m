Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89A1E495
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020718; cv=none; b=kEZFr6EzmfsFibxB2QWZQGOV24YqHGrwvmu9mADcJ3zStsR5gFZeTknpUkpUqjMhQcjVHolySkqkedog2uw/uk4rMSqNkOxzeScrOu/HGlAOOss5gk7bBI1YCi5bFkzfI6dFf9OQU48igJPqhZtgL/RsM4KhoVuB1AXD6WKUcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020718; c=relaxed/simple;
	bh=4zd7mLsgGFyPEeDlkXiwKWXqFb/rVl3azXBMZXrL7PI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=gMh9fTLBtGjZzVZIxBl8AmlJpcPXedQ4bxhx0sznq0rbdPAUJaUmwSvTZi7B88n9pGNi7d4i2nT8botYygAFnO7mi0ClwzExV4vGJrW0ivbK3qDePnSt4nYyncL+ifyjtEvY8fAI8fUmbqlTuxmC4pmvnX0VpzMThfSb7peBHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=oRmfDZTw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L1vaojgL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="oRmfDZTw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1vaojgL"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3E6AC1151B07;
	Wed,  7 Aug 2024 04:51:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 04:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723020716;
	 x=1723107116; bh=/zOiLTp5e606YrIlCRDbPALwVgbVQNp/bzxPncFpfIo=; b=
	oRmfDZTwEkWJ7QV5Wm2PHZW8a1fjDMaVAx4X7ekq/k2QxU1ZDozn0qdJszjKflAI
	pbpoo1rimuQw+2tWNEHX54s4WsljoYq6/NtkoNnGlRs6LwM2nEmxnTWs8d28rlXB
	xgzYMrnlJ7SmIO+9r5pnGO52Lla1wgj3Tksa36SQeFNxzIkNPCXc4kWY3RyYHR4w
	IO/Qz2hA15NjwRqU0ziAp3pXr0OWVNSl8TZeWIdE+g7JkO8BetQAJPbn46erVdtU
	K3FtjVBZcdmEf/CFF3YEcKGO12F1mVpZ2AeXPQfApDyZyazd4s7rnW7YT2PCu6k+
	zTQ7FqqsTHNsAEcI3RDfwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723020716; x=
	1723107116; bh=/zOiLTp5e606YrIlCRDbPALwVgbVQNp/bzxPncFpfIo=; b=L
	1vaojgLBlLAizzbOgrjVC8FbC4Abni+akBoj3qrs7q7wi7Swjfv6pDq06u0ba59X
	koZde/Q1J2RNcQX8u9lbeD4pZEhWozykgE+diM46nx1PRooxmyCCncHSa4wefp99
	zbr3C+h3gX1X+YlBLU809t8vZhqs4PaL0VeIl39XNT1cXJq7r6Hj6jZh8jEHV4uV
	rZASOeJ4VjvJqxoxB0S1oR6XxBNw6AmIzE1ICSDRbZdgGskFW7iCyxmszHV25hE+
	Xo1LPnj6Qxp6G1pP7w0RFXpzvLJiba+pogS+O/ZGJp8kEC5Cp0aD5ecmdnqq8k6G
	E8Z0q2Ri/zeMWboPnG7nw==
X-ME-Sender: <xms:rDWzZqQwHNqM0qiwDFrhZRtR7-_jJ6vE_XTGygP8SMfQhDx3d7C2kQ>
    <xme:rDWzZvwp2ojOL8gaMLy5VElliVD-IjGLYL_vkxDMB6TsntmAk2ltQXauI98JpBMI_
    a2iKY3JlVDUFRBmtg>
X-ME-Received: <xmr:rDWzZn2gTHoq4krvrYXi5moy4t-Yeatih7NNoe_TFwt6yQEZjAl7w-xrVPjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:rDWzZmAP8Ii-mFOOJB9GIggOqXDplxXtRFSFcadBF49qyo2Zs4cjjA>
    <xmx:rDWzZjiQyqT7liWMrmyT4qssq5qbac_3Tf3Pnnf1r2f06SIGIAOpkQ>
    <xmx:rDWzZipUWCyhrXhgsXm4kF34BnEDndJFo_f1dHRQc3p1rR2yodvqmg>
    <xmx:rDWzZmgjj7Lmwu8Qf48nwm2FmXO1Xmgtni9Fb-lH82gnTxWaHkkLXw>
    <xmx:rDWzZmtskmrXUOBy5JWEGbJojT9_VL-lZV2Xq96cQ_foJ8piK9YES0I->
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 04:51:54 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 18:51:52 +1000
Message-Id: <D39JV83QXD5C.3U74JE9YD5SGO@jamesliu.io>
Subject: Re: [PATCH 18/22] builtin/format-patch: fix various trivial memory
 leaks
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <bf818a8a79385af739345e22c74550acd5f31a0b.1722933643.git.ps@pks.im>
In-Reply-To: <bf818a8a79385af739345e22c74550acd5f31a0b.1722933643.git.ps@pks.im>

> diff --git a/builtin/log.c b/builtin/log.c
> index a73a767606..ff997a0d0e 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2023,6 +2024,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
>  	const char *rfc =3D NULL;
>  	int creation_factor =3D -1;
>  	const char *signature =3D git_version_string;
> +	char *signature_to_free =3D NULL;
>  	char *signature_file_arg =3D NULL;
>  	struct keep_callback_data keep_callback_data =3D {
>  		.cfg =3D &cfg,
> @@ -2443,7 +2445,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
> =20
>  		if (strbuf_read_file(&buf, signature_file, 128) < 0)
>  			die_errno(_("unable to read signature file '%s'"), signature_file);
> -		signature =3D strbuf_detach(&buf, NULL);
> +		signature =3D signature_to_free =3D strbuf_detach(&buf, NULL);

Do I understand this correctly, that the multiple assignment here allows
us to maintain a reference to the pointer returned by `strbuf_detach()`
in `signature_to_free`, and we do this because `signature` can take on a
different value below?

>  	} else if (cfg.signature) {
>  		signature =3D cfg.signature;
>  	}


