Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B92B9A2
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360014; cv=none; b=ivpBhYSZJVmDZAKY0yWqlOftkVIjKoGMwyuQomBMojgzp3ADHG/uTh6kANZhg0JaWZpFvW2Bf5znvsqY0Sbr2xsD9TJZa0jYzWmyZ/GFS4fRMXSDBjbiKOvPLTVLoh/yfxO6AHZ/RwKFNuHxcs0HgL8se5Dbl+YbjCq7NKP2cmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360014; c=relaxed/simple;
	bh=41trTW5pKhIxXH7jX6vHeqd0ymqT5XLjIPzbmiicdb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7C/EEkwEBK7AYVSGo9zB2mp8t6WomDIDH5tewBVFk4slPWQHkRpBB2HFmweXqKVAoPjlTylXZ1e4dNhtJh0lOPlNms8O+jLGp4bvFmhQB5RB2TqCtp/GOPLo+Isec3sWRZSnAxbdMPJIc4GPJU0606aWWXbGq1VUEKM95cjs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DhJSLBrZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ViPntn/5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DhJSLBrZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViPntn/5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7795F1380609;
	Tue,  8 Oct 2024 00:00:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 08 Oct 2024 00:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728360011; x=1728446411; bh=2pJl/JkZQA
	yZh+92+PKpTqhr8lkQnd0MO6dfmRWA6ng=; b=DhJSLBrZVFHHVxH/z8rLVnmxhS
	Z4dvWUMHKqSpQ/PL3Sb9l5x/5r8mB0TtT2i+B1aAIFX3EwVgLnox+OCGIEzIHqgZ
	QFZa9iC+RsuLQQClvXgUCJkkuH5XvWxTO71mtdX8W1VUU9jqVuUnY2iBUbUxqhv4
	ESpbrfVntuF69UKMmAf473SeXljSQm0jKScnUMh1K6KHmXjF8Pxll+db1gD0/U47
	UBMH8mlBmyYfdD/r4o9Q9OQin23jyamdsXQc8z1PUr4u/i4HW8LNEVIPnxwNebo2
	evAWcyzZOb9zLUTPkJbn9CAXEBBVkgepTFID7VMzrz64dpQUjd2A8Bdey97w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728360011; x=1728446411; bh=2pJl/JkZQAyZh+92+PKpTqhr8lkQ
	nd0MO6dfmRWA6ng=; b=ViPntn/5cx20gulOuQPaE/erzrjOo5VEcsI16tsg6UY3
	QuExM8DDB8Lc84+JMisS1CHyUW5Gs9YXW2GiFaK+tyQwayyxZLX5HGNPZe5tkFRE
	qIz0dAJ6Rc1NrSg/VYlFHZewj/WiFc2QxuzJ9lSJJQyRNz8gFzjK2SdQbbbgozg1
	Sy2Su/Gz100v0HvtzsJp8wRmxyMw01fWXz88R5aWJw1PJ651LqKm87IgGxo6d38m
	JYRiLCyM7oBfZXYQwbUEFluWkVCqedsKMWKEBL6glef3Kr8oZMgOHeREhVso/t9t
	/bqWI385WpkeLESPxaOZhM2GMRFeAd7pd8/zg2dsrQ==
X-ME-Sender: <xms:S64EZ834ebf1lVNjdG_LECqZZfsa_ml4RZ3QjF6WfUiHMDs7ZDBEag>
    <xme:S64EZ3E5aR-2wlxMFUw-VJIOuRNdoUZDbc-Gv3Cnl-KnlpwyxVRgIrVYkXl6RuIaY
    mAUeTajXC6LC0fSVw>
X-ME-Received: <xmr:S64EZ05T9dJZ7IPiUNTcq6v3hhAhodN9YK1dsJjCNwIMQgKJXbahSfoBMMZiLBqJ2dScztk0F-fBob96T8ZavHVRB-zVlEmjdDb8Jz0r4NodxSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptefhvdeijeettedugfffueekgfekiedttddtgedttdeu
    udfhhfegvedvgeehvdeunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    huphhtpgigihhnghigihhnseduieefrdgtohhmpdhrtghpthhtoheplhhiuhiihhhonhhg
    sghordeiieeiieessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhies
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsghmfihilhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:S64EZ134F_CEcDIE9bqBhKuqDYkdk4L1ZkBCa2RCIR1zMYBhRaXW_g>
    <xmx:S64EZ_ERWJvRu4oRDN8G87XLUP0XSwj_6zBiJJh97PUPAbw1F1wADw>
    <xmx:S64EZ-_FsE2zlYhPApV9aCuaO8_mAlJkKYnG8Z-aEK5Rho1gDllQtw>
    <xmx:S64EZ0mSChOoPcdwHhvpcfFkUfTXthRjTTZVxxCVGNKLlxNoAaa1QA>
    <xmx:S64EZ04rO9JqFMOGbrxFAM4qQcJGQaI4mLHOMUV7zpILVy5ZFAAhiAZm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 00:00:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9eaf5da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 03:59:09 +0000 (UTC)
Date: Tue, 8 Oct 2024 06:00:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
	blanet <bupt_xingxin@163.com>
Subject: Re: [PATCH v3 0/5] Support server option from configuration
Message-ID: <ZwSuRa_2OeAAv3pQ@pks.im>
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
 <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>

On Tue, Oct 08, 2024 at 03:38:14AM +0000, blanet via GitGitGadget wrote:
> We manage some internal repositories with numerous CI tasks, each requiring
> code preparation through git-clone or git-fetch. These tasks, triggered by
> post-receive hooks, often fetch the same copy of code concurrently using
> --depth=1, causing extremely high load spikes on our Git servers.
> 
> To reduce performance impacts caused by these tasks, we plan to deploy a
> specially designed pack-objects-hook [1]. This hook would allow the packs
> generated by git-pack-objects(during git-clone or git-fetch) to be reused.
> Since not all clone/fetch operations will benefit from this caching (e.g.,
> pulls from developer environments), clients need to pass a special
> identifier to indicate whether caching should be enabled. Using server
> options [2] is suitable for this purpose.
> 
> However, server options can only be specified via the command line option
> (via --server-option or -o), which is inconvenient and requires
> modifications to CI scripts. A configuration-based approach is preferable,
> as it can be propagated through global configuration (e.g. ~/.gitconfig) and
> avoids compatibility issues with older Git versions that don't support
> --server-option.
> 
> This patch series introduces a new multi-valued configuration,
> remote.<name>.serverOption, similar to push.pushOption, to specify default
> server options for the corresponding remote.
> 
>  * Patches 1~3 contain the main changes for introducing the new
>    configuration.
>  * Patch 4 fixes a issue for git-fetch not sending server-options when
>    fetching from multiple remotes.
>  * Patch 5 is a minor fix for a server options-related memory leak.
> 
>  1. https://git-scm.com/docs/git-config#Documentation/git-config.txt-uploadpackpackObjectsHook
>  2. https://git-scm.com/docs/gitprotocol-v2#_server_option

The range-diff looks as expected to me, so this should be ready
to go from my point of view. Thanks!

Patrick
