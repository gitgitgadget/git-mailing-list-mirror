Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A525762
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699331; cv=none; b=N/D4wUJUCDfC6+z8LI5xw4bk8NXmDOkg6guOW63cO32RAI/PEfy92uqzCY/vfyEeY2lcdA+7chwkJOHVmfrRwX5ga0A9cAC88kXAXcAY6qgvqPw0xsSHTIft9+bAPgkn6iapvatxQhVZZoHPUIS93oIw7VooXNB2RWMyN0c6GnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699331; c=relaxed/simple;
	bh=uW2bOD0GM/fie4Yk+KW/GQ7lqC+gHCjL5u/Kft/gvdk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=ZW6AfWUJoot+APHJH5XQ+abijLd7g6GGZPz6+e89Ua/Ed0N2AorRICK2ZlMj8h+BPEuTFEGc5QwZs62lDVAQQB6qFVgFhwCkh9YyRLU3XbCqZ5DILUVRW3lqv/n3tH10a1zYUrXd30PYrOig2Ia3ePevmqskTS9iDTcISOqOf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=c7/wOtRL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tn+QBYkp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="c7/wOtRL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tn+QBYkp"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id CA9E8138FCB9;
	Thu, 15 Aug 2024 01:22:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 01:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723699327;
	 x=1723785727; bh=267vOnxl9kjTKKzXM5jOOr2wUpJSrU2hamFYXVLGODs=; b=
	c7/wOtRLP7hhyAlh5TgXknEIj0s+r5JC5V3ClW+u1Opc4QBa3jN6vsTnO7Jjuekn
	Z7Ckz7CruOnMikPgOJhTqGVxIH1N/V4SQ3VnuxrFL1sHMoToBzXtAXqxVBU1CmtU
	LNgkUgcEoZXpI1MQe+nxYtpNcQyEUDeKGpkqlNACAIFBGmUJJ3acCUejxM+R1N6U
	HvfJcdD4fRV65Ownfkr0FqOYGBvbCgBYt2Jcg4g4S3CWhS67YsuaHtmVONpm864/
	wIqFXKXro4XOpJOstp/erAMcZd7yt1vgksmu5R/jzGKtyFcQoqxPhbafmImu/WnU
	UiL228R6bOnucnE+KDy7YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723699327; x=
	1723785727; bh=267vOnxl9kjTKKzXM5jOOr2wUpJSrU2hamFYXVLGODs=; b=T
	n+QBYkplUUR9oOQPZvYcp7aVCsdIEm7+E7g+kNw1TfFTmn1ORpzT0Im0EsM5KmSF
	9uA4Khlqa26hh/c8VG7aBYqRs3Lin/cnu+v4noJEaEBD27t+mKOy1EhKTrv4wEzp
	OnJ1Dom8SupgeJ6p7fJb+n2H6uciArpXMuJNWRV8/LDNvsnPCDf9u4ct1FWutA26
	eDttRcixaKuye0sNk4FOutULZharlNGpjZLI4PykWb0fQ3FxKAe1puBTJxF68UCe
	s+wHEnSxVgxqnJQd5s/epAxvaRoFnfqkEHYEisR/d8UH8P+XVXecdBlDNMfvgUU0
	iqi5jtTgkKYdHF9JTYBlQ==
X-ME-Sender: <xms:f5C9Zlq914_gQ1FLjOEQzMBaF_xjk3Mi470gygGtHl4nTupzGbZ2TQ>
    <xme:f5C9ZnqX6PX7XW3GggTskxXky6lQ0iBZ9H_ZlPsN_ZLaG1AjjAxWxvEd9unoRSLFQ
    J9ELjTI1m4i4CQY3g>
X-ME-Received: <xmr:f5C9ZiNz-BO3MWyn1VowzBbzQ3upgvtth-DUBpqfaKO4agWhGSBbMs6Ut9w6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeen
    ucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrih
    hoqeenucggtffrrghtthgvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheeh
    vdeikeettddvveegieelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f5C9Zg7kYXui9NF0C91cJcq-pOq7gOgZj3GjKTsBczanxUojeWXqEA>
    <xmx:f5C9Zk5yvhhBPMq79SCePv9AhF1CpriCro7mFz6NVkfitsciYhXjPA>
    <xmx:f5C9ZohblyjBvHDrF9r2g2dWydcPdnZZAPdlc1NU99h2HyHLrYtefw>
    <xmx:f5C9Zm66qwh_fEUjN2BOR_zWT5YLLrDz4iqKdPEb0jNXIHb395IQoQ>
    <xmx:f5C9ZkE7nC16vy0eZfcf_slDgc5stb83CyRfbXLzZNqXjSMnT5qGws8R>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 01:22:06 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 15:22:04 +1000
Message-Id: <D3G8EY3R09BC.2BKB6UND5J5MA@jamesliu.io>
Subject: Re: [PATCH 3/7] builtin/gc: fix leaking config values
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1723533091.git.ps@pks.im>
 <310e361371efc156c3aaac94439bdbeaa965155f.1723533091.git.ps@pks.im>
In-Reply-To: <310e361371efc156c3aaac94439bdbeaa965155f.1723533091.git.ps@pks.im>

On Tue Aug 13, 2024 at 5:17 PM AEST, Patrick Steinhardt wrote:
> Note that there is one small gotcha here with the "--prune" option. Next
> to passing a string, this option also accepts the "--no-prune" option
> that overrides the default or configured value. We thus need to discern
> between the option not having been passed by the user and the negative
> variant of it. This is done by using a simple sentinel value that lets
> us discern these cases.
>
> @@ -644,12 +673,15 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
>  	struct child_process rerere_cmd =3D CHILD_PROCESS_INIT;
>  	struct maintenance_run_opts opts =3D {0};
>  	struct gc_config cfg =3D GC_CONFIG_INIT;
> +	const char *prune_expire_sentinel =3D "sentinel";
> +	const char *prune_expire_arg =3D prune_expire_sentinel;
> +	int ret;
> =20
>  	struct option builtin_gc_options[] =3D {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
> -		{ OPTION_STRING, 0, "prune", &cfg.prune_expire, N_("date"),
> +		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
>  			N_("prune unreferenced objects"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t)cfg.prune_expire },
> +			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire_arg },
>  		OPT_BOOL(0, "cruft", &cfg.cruft_packs, N_("pack unreferenced objects s=
eparately")),
>  		OPT_MAGNITUDE(0, "max-cruft-size", &cfg.max_cruft_size,
>  			      N_("with --cruft, limit the size of new cruft packs")),

I was wondering how the `no-*` options worked since they're not
explicitly defined in the `builtin_gc_options` array. I guess
they're handled internally by `parse_options()`, and if the `no-` prefix
was present, it leaves that argument unset.

