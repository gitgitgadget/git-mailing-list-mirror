Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7A3FD141
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633516; cv=none; b=DgwFXwE5zZnqpuiFVtlzzq6ovLRMGwI/NQ9M/hzyw9lboexeUL9eFstEd8bg3cSPM+8Ir98IMH20sxVFMMnmh7Dn1p1lOpgtWfY1Y8dY7LIVek1++tXegfJOdG8IBuplJ4xMthPrS3g+S0Mh7A2AlX5+G9zkrB3QYDg5mXt+ZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633516; c=relaxed/simple;
	bh=/+gdgz5az5YCOoS4mKZX1jM6At19k3FpHLw0t15NMaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BvFr4uBOzhquUGzLE7eMlTCue2tF8IfD5Bac7szvvijfcSwdSRUa7BCw2QZzq/S/ZOmp1KPBTiSSnYDth67ylPNT7n+9EMpDlFkKtd1HizG3aV4jYurBue4MttQoSAqZew0yhOX7wYPK5KKU8hnGaknaphJ9mLhPdoPjcesVlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=by962Uyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c13bSgBx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="by962Uyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c13bSgBx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5322E7A0154;
	Fri, 27 Mar 2026 13:45:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 13:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774633514;
	 x=1774719914; bh=OJJRLBOsNV6DaFNQVcqNFxtvaI9Ei9p6Up8H7W0Txpw=; b=
	by962Uyujwr5Ols0+vkmTwHWznntnrE1kjEM0CD+XDVOHn6knMHHB4VQU1qanF3I
	kJY/uM5lAC2L/zRodI5UyqG363dajvPh9a1FsP3u+B9f5YHqmaHbr6eCQHQSVD5Z
	k8A911GzkD88GhnDVGCAfUaCYphSY9+A+8nCd9ifzCEg/mhzk0V7+2O7d6abTb4G
	V4IiImkEGk7bq6gY8BP3LBTUCKOvGnPU5sPEMBh79HEfXS7nWbjZ997thvcsMdVT
	UzDpZl5NZQlunkx/JSRl6lJ8BOBMOIhKE9oGv2U6dK254jgMvEY39PbP8fktpcR2
	BeVo69iyQRTx/vJVUpv3cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774633514; x=
	1774719914; bh=OJJRLBOsNV6DaFNQVcqNFxtvaI9Ei9p6Up8H7W0Txpw=; b=c
	13bSgBxuk5WFlRcSnC/HTGgwmlmF68N7zsJQDG+jqe3hnuIPZg8+Y4PXHaWAfGA+
	nyizVAVik52SnuD6UBboNNRkxx0vgctqR6YfxKtuhGQeC9qEzPEShKBe5Rzcelwr
	UT4oOsjLJiyBpi6usbSTIJo5JWno13cNYKF3YxyoRA77m/nnu02Cnk0YSS0vZRFv
	IgYmW7DLSLx2K+vOwN9uttIwFi/YTIJxeFQs+X/rMqAZHsgoIsbB1qU95dVDg8bT
	TqOkOz0Lxprc4ThcHea5YNEC7rROD3rU2GLHv6cbw6N69teNiU0UgMXPW2NvCYpi
	riPFmEPw5Q7kKye8KV1cg==
X-ME-Sender: <xms:KsLGaYow6MnzjvNKlX7MRNOPuRttCRvWdY4pHZiWzGOgcelnjpx4Vw>
    <xme:KsLGaSXoIfbp0U5hG4kGEvDitWi_VaMJ6pu8XBhybxXHA4JtTulSUu8RtoH_lwF6C
    WPDNfNebobHoLTscR6nYBwUnYO5GO-3Yt3xo_KCMFVkkFL1XMeLnQ>
X-ME-Received: <xmr:KsLGaXBw4KMO1ot-rKQOE6RSawxRyu-pb7OOFZ-lmf38qRIS-NkTwmTaB0yJiCHzLE54PEtxGt_2b9MDq1YNPmkOPpQdU8hU9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqh
    huvghnthhinhdrsggvrhhnvghtsegslhhuvgifihhnrdgthhdprhgtphhtthhopehmrhho
    ihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KsLGaW3vwRbcgRs69kG3Bo3YxZbpcIEOfKKCnaMyVv6L_2fmuH3W1Q>
    <xmx:KsLGaZ2uoJIfXVwbfxEnc2jdQtcOd1Sl9ny0o0GvfUdlwVO6e4dznQ>
    <xmx:KsLGabCFN3nGwEtNnL-Hc6I7Je1yknxf44j8lYRiMtIsYzOcUOXlXw>
    <xmx:KsLGaY6CCGsFX1f49Xzm_ex0fpZc6vaU2ojHsElbyfatVrG8WVUBNA>
    <xmx:KsLGaaKcWdokhzN0WT6eTIssB7tvueHKuc_eoqH0NbixKx8VZ1Chli7E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 13:45:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Quentin Bernet <quentin.bernet@bluewin.ch>
Cc: Mirko Faina <mroik@delayed.space>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Quentin Bernet via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: fix git stash grammar
In-Reply-To: <6b5a5bd8-0631-4c1b-b87b-c75d99dc9c50@bluewin.ch> (Quentin
	Bernet's message of "Fri, 27 Mar 2026 18:36:54 +0100")
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
	<CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
	<acXIl2cuBv0ifiK6@exploit> <xmqqqzp5mfh5.fsf@gitster.g>
	<fbe531eb-b742-4cd1-ab6a-2eaaf8d236c5@bluewin.ch>
	<xmqq7bqxkyd5.fsf@gitster.g>
	<9d0befb7-4f2b-4b47-bf9c-784fcacfe418@bluewin.ch>
	<xmqqtsu1jipp.fsf@gitster.g>
	<6b5a5bd8-0631-4c1b-b87b-c75d99dc9c50@bluewin.ch>
Date: Fri, 27 Mar 2026 10:45:12 -0700
Message-ID: <xmqqpl4pjhef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Quentin Bernet <quentin.bernet@bluewin.ch> writes:

[administrivia] don't top post.

> I'm assuming "#leftoverbits" means "this is something that would be 
> nice, but which is for another time"
> And I'll leave the pleasure of implementing that to someone more 
> well-versed in C and git internals !
>
>
> Therefore my previous change (current status of the github PR) works, as 
> a reminder, here it is:
> ...
>
> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> ...
>   git stash clear
> ...
> Is there something else I should do ?

Without any additional effort on top of what we saw in the previous
patch, I am not sure if ...

>> ...  It would be sufficient to make sure the readers understand
>> that they may have to disambiguate pathspec with "--" like any other
>> command (like "git log foo" when you have both file "foo" and tag
>> "foo") in the description part.

... is already achieved.

Also, my earlier "if the log message said ..., we wouldn't be having
this long thread" comment still stands.

    https://lore.kernel.org/git/xmqqqzp5mfh5.fsf@gitster.g/

Thanks.
