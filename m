Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF618B462
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289366; cv=none; b=VZR2P5LJjbTIOh8wV0njDL5SN3CmWQmc4qFJoo97GO/Lf/JED9YMXaVQxWXIvKYpZV7BE9gcNYWXosjDsxd+8LCMWM5evDfDgktyxJPTd89IqscCnpMSN6dlO+DGQ39Z61MiF6LCSkViX11ic4ycZNWXe4ardHLV2EQ+zGzVrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289366; c=relaxed/simple;
	bh=cRYnuv6Scv6VLF2oHaNjMKxcog7IADV6ndvI6x4NO3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VINwPhd8oOmxbqoU6xkbbSjoNO3cBb9KpfG5vMnfRCplTAxPkbLSy/t01MVYoBer74h8mtsnc77Q89BDUPDbGTEzt+BC0KHdqEsHBjCVXg9okVfuUd469m/+bYecsEEQ4Ua/wrY+soUvmTqVWD6PelLBe8CzCbm8BWxrccH8FYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OB95rdPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbaUahg2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OB95rdPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbaUahg2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8858125400D5;
	Mon,  7 Oct 2024 04:22:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 07 Oct 2024 04:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728289363; x=1728375763; bh=gquDTs8CU4
	nHlACTLdn8NM5tLS2p9nRQF+yTaA5ODUk=; b=OB95rdPgcBKY93XxAI6Uktrgfa
	h1bTxTlx0CGbrPfftQ68Q6BFSrwy/tisD0Txyzopsiy5tK3mgMRc/LaeEdj9XoMc
	6JLK0BPa58O9vXU9WiHTrknchfKN0aytMMluNnGNc9V6nzw15YE3pF5SN8BNMclj
	D8UhYfelUlXyg6Ad7FVP0qqpHR+Jm1SOmn2EfmdsfOn8Ii68DcwpoAOC2cd/muSN
	0upZWHBGv1WBiiCJVnZ1ITLFf8gQsyhitZqBQS+enL7l9fCmTWKVZ41sKC2stpuc
	ns6ITDZhkYkaglr/io1RrelB6dpEkDPHpqB46Hkh4gPsq4aNyAIFEBWCQaog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728289363; x=1728375763; bh=gquDTs8CU4nHlACTLdn8NM5tLS2p
	9nRQF+yTaA5ODUk=; b=JbaUahg2NQHT8B9nrH4FlU/XpeUEyKp/2APeh5qOABbN
	WThjYPbfC3UzbbLGpdLyWFNqXM5Xfs09EFZrEwdZqvTp2zLUqYSEw++xLeK6Lm8X
	I+7Dw8yenz7of38xseWDnk9/YRjASsD6ICXVhCe3zGQpMQyDibdATmsaYRlV3QAM
	YOi3VrnBBRsaabkMtYnh9mRTZhkkiCerywN0YRAZ+LEtzf1Xyfc9fdWyaitqw1aC
	iKjd4lLyXL5zNCTGnzvzFgWa9VY3w95ZF3Nve4xu/sQw+W2rLw2qOSiH0blAIv6O
	TRu71+TQZILEdEh+9JvQIgg61T16ZuOw8VdTCb8uUA==
X-ME-Sender: <xms:U5oDZzhgqVdxzbl4Ah3e8B2IvF_vR89ZaiETHVXdQKCdsVix__SYEA>
    <xme:U5oDZwBkJgs6TnMmDyHL_rpFR7bqAVmj57D2NULXTcVoUiG5AZeegmWs8qZgEEQ0S
    GeqyIpy5qxw6vbWig>
X-ME-Received: <xmr:U5oDZzHskGSFOqlE-SUM9AIwv2WWpC5nFvo2GC9jYLoafMrbh83I79gp9VOGhA1KRKXENqkkmgS3NFXE7znDvmz9hC03hnx1z_a8XrqTOpv5ltjOZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsuh
    hpthgpgihinhhggihinhesudeifedrtghomhdprhgtphhtthhopegsmhifihhllhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepgihinhhggihinhdrgiigsegshihtvggurghntg
    gvrdgtohhm
X-ME-Proxy: <xmx:U5oDZwQD-IVil6z3edd-W1Zk5lj5pKTWYFwkgdBgj9HTtD9gZoBiJw>
    <xmx:U5oDZwylQllX9Q0XmiOZmjabSXs2JFJRQx8OpmV4Eey0a_CgXWJ3AQ>
    <xmx:U5oDZ26qn_E-mRhTPlx45_XjeqTq0gxNYki-2CSTRhZ0T65fsyxqXw>
    <xmx:U5oDZ1z2H0hoYDWRvjrNQjk7hn59R87hZ6MyInSkou6g_XqbUcChgA>
    <xmx:U5oDZ3lDj9lUsAMDvtwQJPGXFcs6ilnzsld5ufiHiZgTqpf1-YWi3JzM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:22:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 806b01e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 08:21:43 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:22:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v2 5/5] ls-remote: leakfix for not clearing server_options
Message-ID: <ZwOaUA5pCc6k0k5d@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
 <39c07a6c8eed645e22ae55affd015ee55ec59571.1727093878.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c07a6c8eed645e22ae55affd015ee55ec59571.1727093878.git.gitgitgadget@gmail.com>

On Mon, Sep 23, 2024 at 12:17:58PM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
> 
> Ensure `server_options` is properly cleared using `string_list_clear()`
> in `builtin/ls-remote.c:cmd_ls_remote`.
> 
> Although we cannot yet enable `TEST_PASSES_SANITIZE_LEAK=true` for
> `t/t5702-protocol-v2.sh` due to other existing leaks, this fix ensures
> that "git-ls-remote" related server options tests pass the sanitize leak
> check:
> 
>   ...
>   ok 12 - server-options are sent when using ls-remote
>   ok 13 - server-options from configuration are used by ls-remote
>   ...
> 
> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>  builtin/ls-remote.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 0a491595ca8..c3fdda08409 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -169,5 +169,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	transport_ls_refs_options_release(&transport_options);
>  
>  	strvec_clear(&pattern);
> +	string_list_clear(&server_options, 0);
>  	return status;
>  }

Indeed. I've also got a patch for this pending as part of my memory leak
series, but didn't yet send it out. So I'm happy when this lands
independently so that I have to carry one patch less.

Patrick
