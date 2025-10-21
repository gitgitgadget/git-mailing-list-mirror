Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8373280A29
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032476; cv=none; b=iPNZ5bGD2+Magtob51o2rDSdQf/rbSIBW5od7E9GyFzbxUQ2r8hk3vXsKNu/sL3SaJa1CkyjJcjwGp1dyNOgaZewlU3c8Yyp06mv/nB1pgsaMjlVzmakiTZKBzUeDjyW++a2uRDuId1sfAE0TgCDWvgkJFwcyVstT2HTlX+OAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032476; c=relaxed/simple;
	bh=2Mh5XUCQ+eMRMrABliMyqGUdXLw3/doPfi2ULy5qpmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSdfEFHx2wYPB5J31kfmUBiqVeG1xv3DcUuKFGIRamIftQXTUaJr2RHaq3RI67WVYqCim+3ULDkJZaMGeUehCA6vj9VbE2dPklneeAEHQVjbtdPiX238jM+zFO+PatLKA94rVdGsCiO+ppG9tJGnRr3R2CnRPlgvtIIQzi4OMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RV+ilENr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqT8qNAT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RV+ilENr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqT8qNAT"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6E621400085;
	Tue, 21 Oct 2025 03:41:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 03:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032472; x=1761118872; bh=1cIrPWd3Uf
	vx8WJAp642+HMyJnamTsZB1SbPnQG92qE=; b=RV+ilENrPzgZNGw1dLgMqiLKu6
	qsc9PB7Euzk/1rvVDgBo4qXb943st9IT8FHFPAgR/QXZR0glLcy/gsha6ZRvkDmF
	RHNcehXep9tl45THnW74flMwBuWBBy7bDA12kKKXlx7aqrfeNeFqFHeRDlsr4hWG
	qHcDTCl7wDfu0r+cryWTtiIbeYseTxjrinMUtttMcmDqF2BryiZIIkyW2UXxoSYx
	ovnr5hp54v7ofvSd2+W5YmYk+TnMzGCptjMV4FXokrXnRCn9+9ghAZFthekga/2n
	ob6s9gB5vUi8/GE9zhEm+rT2wZ61L99Hy5XnaqRVmmo1OHj6OJdy55xNKkWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032472; x=1761118872; bh=1cIrPWd3Ufvx8WJAp642+HMyJnamTsZB1Sb
	PnQG92qE=; b=EqT8qNATRKk3q0+bbmnTqMcl58z7mhBbmhry/QTlNByejLeq8g9
	4I/aRY7x3uYpawyTgX2cMatXqCD2UIukxc4C3s1gu2X18VIlh+pja6CBHqN8alBE
	zpg3BStyD61tnFo6AEjlgQgdHr5PUN9jqp704JYDZ7Gk2u7/saoGCmtyuS51CfQM
	yqRlW0fosU65j/KeWUs1eXZeDpXotCpRuVn7hy/S9xywroTbFSMBQT4dPbi3UE9Z
	oLJ7ut1zdZmI518eKbD0U50TQ0gY4HUCC5hvqcZ1PAwC7pdmf6l+rSZa7eAFl0BE
	SzgaXsy6jra+XoNrQ+qvfQYSlvNDuhaG2qg==
X-ME-Sender: <xms:GDn3aLVdyMwk3PxtOrGjVbIBCpBowbHNfTttnCMoIch4g2ahfQduKA>
    <xme:GDn3aGJkEMGd5Wncr6DplRx45txAUfAlT1mHf6n-by47ojOd1W2BoXZ4OzwDi_E_W
    71MHSfuer9aMIXhGm664doE7g9xHU97BmGFIyPxjW0xPvYUdzz_>
X-ME-Received: <xmr:GDn3aLCeoPtN9skym0mK3JB9KOirfJmF44SAE2rk0RWGRCy8IunhYSNtDIEEW_Lp1d4SfKjcBKaMTX2b6JCLMWJwx5hV10sU_LQ6xbbTYlUFFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrvhgrrhgrsg
    esghhmrghilhdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:GDn3aGdmwmmSgokMVZLIWecU_W7_XA_PgyQVd8QnCfo43sfMdh-e8g>
    <xmx:GDn3aK1TOuoJK6-IR_1wNCbNiVVt16kEJCf3p6h8Dq72T6v4IKiP4g>
    <xmx:GDn3aNjEIF2XP4y__qtbsxqqO7A2sYUSCOhWCNlNM-eXi6CkpAZZQQ>
    <xmx:GDn3aDnc9KeWt42Ugz8X4WhGHeUDOBmEordo2poJzud6LLptmDOjWA>
    <xmx:GDn3aNqFa4ymAyD3mMXsx1h0BJ6U7qlYq41dq5UiugqsIfnx0rs0X2m8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:41:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e4a1a795 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:41:10 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:41:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 03/10] hook: convert 'post-rewrite' hook in
 sequencer.c to hook API
Message-ID: <aPc5EzFRrDuI-0XH@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-4-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:37PM +0300, Adrian Ratiu wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 5476d39ba9..71ed31c774 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1292,32 +1292,40 @@ int update_head_with_reflog(const struct commit *old_head,
>  	return ret;
>  }
>  
> +static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct strbuf *to_pipe = hook_cb->options->feed_pipe_ctx;

Not sure, but shouldn't it be possible to set `opt.feed_pipe_cb_data`
instead and then access the context via `pp_task_cb` here instead of
having to reach into the struct?

Patrick
