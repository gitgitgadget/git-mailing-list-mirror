Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B98B172BCE
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882565; cv=none; b=SNNiS4i2q6wcsZIa0jnuVOfzm/SgA+PSgcyICxAzirBPWM2NN7rkdAFBYqUSfIRXm0chNxlNB/h3I0wCIxcta5uEl62RE5Nn8q9C0kQ5EmvymXcrNXsVcabFVUQ5m7zpyrNju0TrMxii8JkclcBukfpr+hPcLe5LTtGsgZuD0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882565; c=relaxed/simple;
	bh=f2c7P0esqchwGUIlHs0pRU1+j5AwdkckbFJx9VydaPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9rKDrf4cPEfumDwtGUUYm0+KDDzVS/3SvStZM9Vz9KBmS+KLLu6+jxSU2YFDDS1Vu7/eKareWo4dLVN1KiE3PsRNopP3Eg1OlRmZEe6l7APPQXLb2ZotX9okUMxwLNzPRFRyqQJtoZfXFt46ElVh6Ev9TTIK7PX0jcPjD7AFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KKrD4J0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bmg5IpQr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KKrD4J0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bmg5IpQr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CCBD13802D1;
	Mon,  9 Sep 2024 07:49:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 09 Sep 2024 07:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725882562; x=1725968962; bh=857E0pXv6N
	k53adskogHr1UaZ8R8RGElkNyTJL2+LSs=; b=KKrD4J0vEwDMPCGmAwjgU0NOlf
	maRIgxmYhqYZTajAhWIeSJDr0r/lKstZxzBUZo1LarAUPlC5G3w9Pco9RqFmwSAX
	rgYUYENf6VM3ZuPSrgPZibeQXq0S5ge5s6Kakij2u48InV0ksXx3fhy2BjDG2k65
	+0WYUIzPUxS+xoQZosXnGbtsNhvMiF1W0FUti5EdP7t+WfTqartpJwssWHTTio7p
	KmQ9Eztf0MbrySK8gycLay8SBBK11mDAvrUmO80EuO1apQ6k06yKFjFl4SCwBBAy
	hCneu/8r2go806Ekxv5Vo7FAPmiGxuHcZn5ujhxjaHdBRR4mTXT96HADByVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725882562; x=1725968962; bh=857E0pXv6Nk53adskogHr1UaZ8R8
	RGElkNyTJL2+LSs=; b=Bmg5IpQrLztqTDUEBff0m18o6eRWBr7fnTicb/Z1xH/z
	1d1sA7BhP+9D/1QAQLw59jPFuWxr7pIYmLeYuyAneUKjXmAvu2sumywLY1Pql4OM
	BHFXR1dctudp5IInsSlm9lAPcwNq9jubYHKu+jjaSmh0HpCSEujrihD4DrTnLeLb
	HM/HV4IR3WP968H56EE2aIdFDgq9dWfgW/6hYZWJH+pd3a3D43HXSa0hrQrb/4vi
	L/GDPcd1co6DBr/v9An9k55lwe9A0Ru0yJ/Khv7t6EWrY8UvcROL69KFFHepic0G
	dckYugFFWsdPdaLWWH+sOf7te0AWKhsHKCYlrfTllA==
X-ME-Sender: <xms:wuDeZu7kX-dM424nCmOBjYe4yLVOyeta040A0-YegL4jdzz_-FF3kw>
    <xme:wuDeZn5p4GLlp_9NSZaPCNu18X1csvFXuwrtiXk774DxVvWGe_8BDsA35WuFjEqt3
    ldibQOHPpZZgzRPig>
X-ME-Received: <xmr:wuDeZtd23DPkh19tTiGeu3boAwkc3vKKox8MnK57zV528UiHltybe1Yi4K7ZKpvnHhAedi097WE4bYTaFm7H36QWN7D6YGbGs9jOEv6rsp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghuphhtpgigihhnghigihhnseduieefrdgtohhmpd
    hrtghpthhtohepgihinhhggihinhdrgiigsegshihtvggurghntggvrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsmhifih
    hllhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhies
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:wuDeZrIvu2xhUfPKPy1ijAWdTSw-8S-N2T-xwEN8gW2DZiBIoeadVQ>
    <xmx:wuDeZiL_6AjleF4KRkQy1FWa6bXrxIVd5TThsi_pCyz0KOTClg21IA>
    <xmx:wuDeZszJq1BA1VxpzRLtrihaL4mhi9M7Wbr_EcNj5DHljNzShQk_uQ>
    <xmx:wuDeZmLFHxPu9BV79x_CahVf0KUYf1HL8guwT0Gz72hE7loQHdhFGQ>
    <xmx:wuDeZq9haCbdb7T-AEiZ6dEWX1RW3hKG07QjD1kfQMnS3lQMsqiuQfwd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:49:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88157793 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:49:17 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:49:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin <bupt_xingxin@163.com>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: Re: Re: Re: [PATCH 3/4] builtin/clone.c: recognize
 fetch.serverOption configuration
Message-ID: <Zt7gufVmnMIGraNx@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
 <ZtbgafDQwbU9tBoq@pks.im>
 <366dd64e.7b53.191bc028796.Coremail.bupt_xingxin@163.com>
 <ZtmQZQHnwYLNvT0F@pks.im>
 <3ce04aef.b004.191c21a2159.Coremail.bupt_xingxin@163.com>
 <Ztm1w_61vjEkiC4C@pks.im>
 <3a7b1ced.364e.191d4b07a1a.Coremail.bupt_xingxin@163.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7b1ced.364e.191d4b07a1a.Coremail.bupt_xingxin@163.com>

On Mon, Sep 09, 2024 at 10:50:21AM +0800, Xing Xin wrote:
> At 2024-09-05 21:44:41, "Patrick Steinhardt" <ps@pks.im> wrote
> 
> [snip]
> 
> >> >> I named the new configuration `fetch.serverOption` mainly to follow the
> >> >> `push.pushOption` pattern.  Since which server options to support is
> >> >> actually server-specific, using `remote.<name>.serverOption` is a good
> >> >> idea for git-fetch. However, how should we design the configuration for
> >> >> git-ls-remote or git-clone, if we wanna provide all of them with a
> >> >> default list of server options to send?
> >> >
> >> >As mentioned in another reply, I think that putting this into the remote
> >> >configuration "remote.*.serverOption" might be a better solution, as it
> >> >also brings you the ability to set this per remote by default.
> >> 
> >> I agree that using "remote.*.serverOption" is better. In fact, I also
> >> think "push.pushOption" would be better as "remote.*.pushOption". What I'm
> >> contemplating is whether we need to add a configuration for a default
> >> list of server options, so that when "remote.origin.serverOption" is not
> >> present, we can fall back to use that as default.
> >
> >Junio proposed in [1] to introduce `[remote "*"]` syntax to supply
> >default values to all remotes. You could pick up that proposal and
> >implement it as part of your patch series.
> 
> Given the addition of a remote.*.<subkey> configuration in Git's global
> settings, such as:
> 
>     git config --global remote."*".demoConfigKey demoConfigValue
> 
> The current versions of Git may produce errors with certain commands.
> For example, running `git fetch --all` will result in:
> 
>     $ git fetch --all
>     Fetching *
>     fatal: '*' does not appear to be a git repository
>     fatal: Could not read from remote repository.
> 
>     Please make sure you have the correct access rights
>     and the repository exists.
>     error: could not fetch *
>     Fetching origin

We do not currently handle "remote.*.something", so we'd first have to
add support for this syntax.

> This raises the question of whether this can be defined as an
> incompatibility or whether this is acceptable. If it isn't, I prefer
> using a `remote.defaultServerOption` instead, as it aligns with our
> existing use of `remote.pushDefault` anyway.

While for this config key it may work alright, I think supporting
"remote.*.something" is preferable. Ideally, it would be generic enough
to apply to all per-remote settings such that we don't have to add
support for every single config key that applies to remotes.

Right now we only care about push options and server options. But
somebody may want to globally configure proxies, tag options, partial
clone filters or something else. And if we got all of that without
having to introduce `remote.defaultPruneTags`,
`remote.defaultPartialCloneFilter` and similar options I'd consider it a
win.

Patrick
