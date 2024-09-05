Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396E196D90
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534323; cv=none; b=UVmEqfuRo8q8TlJvOAphaJypGqsROM1w1c7jL7Z6jWLQrdv9SX58n9t76E8ja9dhzuIp15H7rO53by8VESQA31fjDWqlk3QH0zbLoAMg1AyPq46vB0PyZujuTP/u+oF64IDeavo7Lfq4hkSiMHZ+FLBOQIMUHSZ8a3DpM2p7hBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534323; c=relaxed/simple;
	bh=l1H8O9dbVMBraJUumrTtWWMIFz/4xG4upTOSbbM5RXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLthGoVuvHpoTkmhEH/fOe+udZDLsNnbieaWsRHXibIYQOfCdkQ/KF/kZfP4NFd3UhiS+F6hfhTA+LSool9yp61IEgYs15klKubaQ7bv995X97o81CYVXYuPJa7Ibd8g3IdO2cdmnBXLMjjL9HbznQziiqDEUCgCfVnW+fqzEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ejzn2MNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LekVznhf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ejzn2MNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LekVznhf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BDB26138034A;
	Thu,  5 Sep 2024 07:05:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Sep 2024 07:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725534320; x=1725620720; bh=r7DzJw81X+
	MDoiWZwmNucOhRXckAuFyYMEgypNvJISc=; b=ejzn2MNT/x9OyrKIr62/WJwYE2
	tAIOxZg9pTBamkWqPqQs7OkdCB0frDLi49kl7sQq7YnSIZ3V7EbHcIg1rOByU6PS
	BiH3pJAYUfKEA4rZscm7yyzfVDnQ5GIMNC1trMAFDM3T4v3lko+etlpTIWKi/mVF
	40UgDoJqOL6HkNJoYRRh4q3bEEhVrSyAzsrWArJA3iP67T2uE1GPqQ01dWeCeoxS
	SjGW4loOmSt8kNpwrD9h+XR0+gloPstZDO4zrOj9POgKM6zyAi9jf/177Vt8R9vb
	qXhRZWazMLsc9LERI1Qn4UKQp/bqDxV5P33+hpfUZIMCL9MM3eClablGbaQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725534320; x=1725620720; bh=r7DzJw81X+MDoiWZwmNucOhRXckA
	uFyYMEgypNvJISc=; b=LekVznhfG72o5gS3ZpIwGe/uk76cp9FBHre9ZvwA/AAo
	phWVDRZ5k5ErJt+MLMq9FKUMwqGJY38QQpJBi1Epmc3fc34H+4NPPRlCgfY3bm+9
	mI8dj8g33aBrGSPFN+4ryq7o9t1WfMB9YbOIb+u+LWydpf+lf3AH+fJNIWp+UeLN
	z+wX2NbCxAFC22nd/e7qaQp2wwgcBWs1soB0+aqT6UZCw6z7O3+Icbb4RGynBRO2
	7sdqctRlOT79q9XiYdsxtlTyaVsQYTOcTw07VpG9uwsJqibia3QuE9zjxxmasWgb
	f9xXka3+PO9h3MIF67oQmsy1OH5CeXG+/D9fMuBvIA==
X-ME-Sender: <xms:cJDZZlIog3zuciNLUUsi-oVfWnbVqoYyPj1gCfFV2sLsdKSuwBoaBA>
    <xme:cJDZZhLzn2mlWK0zs2d_oL4gO-14RnVgr03IUxOdnSDF2zK8wydnKMdIwyUY3hcsT
    wgQb9M4rrZsN4Cy1Q>
X-ME-Received: <xmr:cJDZZtsCdVV_3aWYJZHfQuQaJ7WO5qiGFHdNQpcubvFh19WtaAVc8cPIOYQVB3icyTsozCC5MWgm8DYJoFZ9rP-cxdYmocLMkqFbQc_LRSpJFpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghmfihilhhlsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgihinhhggihinh
    drgiigsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepsghuphhtpgigihhnghig
    ihhnseduieefrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:cJDZZmZlKlTcVzlzG0SMGLP3W7TGBikBa_X1MSMV1aA5DkQwHMWH5A>
    <xmx:cJDZZsaUchd5QVbB_NT9G8_LwDL_k2HaFyO1zKTGhXoHyn7QT0_NaQ>
    <xmx:cJDZZqDY4UiloAmH9aYBb4ZP1XPz66CvK2X16YsRxj7k2ay3QYL-1A>
    <xmx:cJDZZqaN5tYHUP72tF6HzNcs6BS7o3OJZ9qMxwU9U4VCg5Yb75dUaw>
    <xmx:cJDZZhNGM1Rh8N9I1HCC_h1du8qYYSoeUuLq1yhIMneKMlPiLcrso5FX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 07:05:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa34e0de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 11:05:06 +0000 (UTC)
Date: Thu, 5 Sep 2024 13:05:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin <bupt_xingxin@163.com>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: Re: [PATCH 3/4] builtin/clone.c: recognize fetch.serverOption
 configuration
Message-ID: <ZtmQZQHnwYLNvT0F@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
 <ZtbgafDQwbU9tBoq@pks.im>
 <366dd64e.7b53.191bc028796.Coremail.bupt_xingxin@163.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366dd64e.7b53.191bc028796.Coremail.bupt_xingxin@163.com>

On Wed, Sep 04, 2024 at 03:49:28PM +0800, Xing Xin wrote:
> At 2024-09-03 18:09:45, "Patrick Steinhardt" <ps@pks.im> wrote:
> >On Mon, Sep 02, 2024 at 12:13:55PM +0000, Xing Xin via GitGitGadget wrote:
> >> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> >> index 8e925db7e9c..105645ed685 100644
> >> --- a/Documentation/git-clone.txt
> >> +++ b/Documentation/git-clone.txt
> >> @@ -149,6 +149,9 @@ objects from the source repository into a pack in the cloned repository.
> >>  	unknown ones, is server-specific.
> >>  	When multiple ++--server-option=++__<option>__ are given, they are all
> >>  	sent to the other side in the order listed on the command line.
> >> +	When no ++--server-option=++__<option>__ is given from the command
> >> +	line, the values of configuration variable `fetch.serverOption`
> >> +	are used instead.
> >>  
> >>  `-n`::
> >>  `--no-checkout`::
> >
> >I'm not a 100% sure, but I don't think that `fetch.*` configs typically
> >impact git-clone(1). So this here is a tad surprising to me.
> >
> >It makes me wonder whether it is actually sensible to implement this as
> >part of the `fetch` namespace in the first place. I'm not yet quite sure
> >where this whole series slots in, that is why one would want to set up
> >default server options in the first place. So what I'm wondering right
> >now is whether the server options are something that you want to apply
> >globally for all remotes, or whether you'd rather want to set them up
> >per remote.
> 
> Sorry for not explaining our use case clearly. We have several internal
> repositories configured with numerous CI tasks, each requiring code
> preparation (sometimes via clone, sometimes via fetch). These CI tasks
> are ususally triggered by post-receive hook, so the concurrent tasks are
> actually fetching the same copy of code.
> 
> On git server, we want to deploy a special pack-objects-hook to mitigate
> the performance impacts caused by these CI tasks (so the packfile
> produced by git-pack-objects can be reused).  Since not all clone/fetch
> operations can benefit from this caching mechanism (e.g. pulls from
> users' dev environment), we need the client to pass a special identifier
> to inform the server whether caching support should be enabled for that
> clone/fetch. Clearly, using server options is a good choice.
> 
> To achieve our design, we need to add two patch series to git:
> 
> 1. Support injecting server options to identify environments via
>    configuration, because adding the --server-option parameter would
>    require too many script modifications, making it difficult to deploy.
>    This is what this patch series does.
> 2. Git server should pass the received server options as environment
>    variables (similar to push options) to the pack-objects-hook.

When you talk about client, do you mean that the actual users will have
to configure this? That sounds somewhat unmaintainable on your side from
the surface. I guess I ain't got enough knowledge around the environment
you operate in though, so I probably shouldn't judge.

> >In the latter case I could see that it may make sense to instead make
> >this `remote.<name>.serverOption`. This would also remove the unclean
> 
> I named the new configuration `fetch.serverOption` mainly to follow the
> `push.pushOption` pattern.  Since which server options to support is
> actually server-specific, using `remote.<name>.serverOption` is a good
> idea for git-fetch. However, how should we design the configuration for
> git-ls-remote or git-clone, if we wanna provide all of them with a
> default list of server options to send?

As mentioned in another reply, I think that putting this into the remote
configuration "remote.*.serverOption" might be a better solution, as it
also brings you the ability to set this per remote by default.

Patrick
