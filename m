Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4221B983E
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358194; cv=none; b=HH62GjuWT2MfNzo9gpBNS6sSMj9EEHrv2DZHGMJ1HsBuRtLj8hPQviFZDb0psjHGSBUo+5LtAOHmoSFLTP8ysADLUgtDZUFsBXUwMocn8q8eKeQK0bsQ2TJK9xYXpIR4mGcMhmiJlX6vXUpqPcmqZynPC1BXy64MtzmMyQ2UuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358194; c=relaxed/simple;
	bh=L1C3ewKP00hKQAjPkaEA/67q7RcKM+FObTj+uyx067s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHtwXRqGy3uXHy+YLJUFslGj64YdoMnggfcXdYyMCvGFR4f8u+hhStXOlVDVJhbu81djRXYmZ0H5JwsRoHVTQacw4V/6JQTNgiJg4cZiK63GTqfPu4/8jRXBFHZCtXrEMdT6VySvwxW2rYKT3FVkZoBR5kk/DVBM8hSrZ5WnsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iU1NmJy8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBjoFT2P; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iU1NmJy8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBjoFT2P"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D64D21380473;
	Tue,  3 Sep 2024 06:09:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Sep 2024 06:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725358191; x=1725444591; bh=Yz7l5K6bKp
	Zp5iSUAiV7eirEMKeuuMh+iCGAPog2/PY=; b=iU1NmJy8R0Lzw6niPAXy7xiUJC
	Ijr8nfllcVHrULwQBx9iQZQzTGlKOieQprEsfc7O2gDHp7KPQrbSKVDVq9pPntmy
	VzB8VGhrkTyDuX2V4Zt4GpK4nrb42Rg61VkODiNgTEEio3dicq+akZWDBLX+MliD
	4UqnQ3cCdCxejNL7tgwAn8/PKmoMH+sUS62ef5V59/kwAq3vJdYJP5QmRbG/vf8p
	nwS5H7bEbUKeg4MXqjOABbDxH0yQbphtnYDTrG4Nq7Cz+pQ75TB3cZx9+5mwKV3q
	KhNPnwuMHkIGdGyr2C0DRg+u+TVxLGMm/OaA78HVSdR5Fi1su6wlsW2Aierw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725358191; x=1725444591; bh=Yz7l5K6bKpZp5iSUAiV7eirEMKeu
	uMh+iCGAPog2/PY=; b=aBjoFT2PVcqCZF9nD9yzJudynVN8xKdzTf1vmKA2r+MY
	8DJM1nmK84HOWIZM371CsmH6lVXyXQnZC/OA26TukDBjPvwCNe1l1bXr36+bYE1i
	vSppL6SP7cgCvhAgR6fOJs/P8cXcg9Ws4YPBWpgpflYGd5q2ngeeyuN4qKgf88QH
	U2lpkSmDMsEcMenHOx7mBiJxx+equ+wuM2ilFHcDutp4KW9ldLj0X+OhF+jKpiR1
	NAGWqJl9uqXUbJlcsEgFX0VypxbD30FeXvZjB7R+4d6Ip0RC7P2owwzqC89Y/s+l
	/Pg19BGLLs/rlubZbVvA+3P74WBTDVvMZjBm9CtiiQ==
X-ME-Sender: <xms:b-DWZqipIE6Q130axY5qX8DDCrUONySb0uIvoSwVVGh4519ksXlvZA>
    <xme:b-DWZrBIK_u4Jje56msxU-izGltT1rQz-xf01JSX6uzm5XxiTS0-I27Je-zcHBE_P
    TpS1ORfL9EmOag5ig>
X-ME-Received: <xmr:b-DWZiFrXG6KE6MQV3skbJwaSOTTgeQBboCy3m5jPTpBUaJAocA13sdULN3vZhTBsgkKJiXvb_jGhbTncb5Co70ESZu4_1-S4xDWB8BA5UW5Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghmfihilhhlsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthho
    peigihhnghigihhnrdiggiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghuphhtpgigihhnghigihhnseduie
    efrdgtohhm
X-ME-Proxy: <xmx:b-DWZjSv6Ko_0gDoLFiXfDwsa3AuujHsdMN3WfqICSkI8X8d4Bn5Aw>
    <xmx:b-DWZnwVr6rXg2vNWjIcGTs2wJsHo3mxndT2WxzPzE12c-oUYiBWgA>
    <xmx:b-DWZh4qENEQvH77Z5KgonJp3tfD55wnVcBw-IRR6pHgVqqNY35Caw>
    <xmx:b-DWZkx0_tMOARAUtklQ9YRyN_dap3ilCdwqwrntaTnpuNL2ThFInA>
    <xmx:b-DWZunIK6MYx-sCrufXufOivmL5jiF-ry0tVa4wgLn3brCARyzsTLIo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 06:09:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3659122d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 10:09:43 +0000 (UTC)
Date: Tue, 3 Sep 2024 12:09:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH 4/4] builtin/ls-remote.c: recognize fetch.serverOption
 configuration
Message-ID: <ZtbgbIOxOB2_MzOA@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <8962031f9997c4030cf32652908fc431f3bf9976.1725279236.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8962031f9997c4030cf32652908fc431f3bf9976.1725279236.git.gitgitgadget@gmail.com>

On Mon, Sep 02, 2024 at 12:13:56PM +0000, Xing Xin via GitGitGadget wrote:
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 76c86c3ce4f..fc9930193f8 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -81,6 +81,9 @@ OPTIONS
>  	character.
>  	When multiple `--server-option=<option>` are given, they are all
>  	sent to the other side in the order listed on the command line.
> +	When no `--server-option=<option>` is given from the command
> +	line, the values of configuration variable `fetch.serverOption`
> +	are used instead.
>  
>  <repository>::
>  	The "remote" repository to query.  This parameter can be

Hm. So `fetch.serverOption` now applies to git-fetch(1), git-clone(1)
and git-ls-remote(1). That feels somewhat unexpected to me given its
name, so I'm further leaning into the direction by now that it should be
a per-remote setting `remote.<name>.serverOption`.

Patrick
