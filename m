Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7519925B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543889; cv=none; b=kq8L0eJlwO30BtZCbOPmzCxawJ9jDZ0cp1fg7grxXO8s4D4HIY4zvr4dKZQjBK3yYHMoErayFpjCftBG4Tf1Rc4vXrrmO52l0GQTebA3ds14W4YoD49I4W0OkgFVGHfyA9C3lJH+uUB33ZYhVl27PRLYnipy/bzzZNuxBb86E38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543889; c=relaxed/simple;
	bh=49ykooHSVpwPZOJGtEorhtV+U8NiXKpta5nh9H24WVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIardh99pgYR9mshFpnBkxMXgoXIbQ37bh/ZvwZjoMx4rK209KxeUqPnxBt9f9jODT/gIOL8O9pKeyVpOkNEvvy+oATGqHZz0VE9FQuV+ZyeqLjYRO0Xjabgab/D532l4LX5l4QFKWSRM3aQUzIFEMmAopW2q/tOFcu2zU9+ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=epbPHWOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kYTiuTlS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="epbPHWOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kYTiuTlS"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9231511401ED;
	Thu,  5 Sep 2024 09:44:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 09:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725543886; x=1725630286; bh=owTi1sygIP
	2GZEal0WxuUd88nWDrCTGQFA9usY986ZQ=; b=epbPHWOH0LfsB/1Rg50qr7oQIS
	c/kJKHMeb0bRD1mh/YLBSQQoXwEvCDsF/gMltTxpx6h8i6xUp56+Qq+kUfjJKr53
	KgNTE1adHq/3JvOiSQu9SobUluhkuIQxku34XaoSlrshVrLnKow157JNx/CXIXxy
	3YNMo9KnpR81lTp0Buz/mAryLWb+eo79E+q0mOiDkmluyyu4RMGZ1Id9KP/dvI+Y
	b9czKVaQCFEHJbUI4Cm7PF3Ew6eoqPXzs4XZ8GMIjcnqKbrAqOFijiu1qB95d+oD
	HomxWlmXZBZMeghGtEUGeyOxTEYTjH5IqDH4HdCDpoUQp5LT1+I3bXoSFkJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725543886; x=1725630286; bh=owTi1sygIP2GZEal0WxuUd88nWDr
	CTGQFA9usY986ZQ=; b=kYTiuTlSkctyQ0c8zNkxIXvg7+9gOnOtsw8uVm9qIXpn
	mf2kUiJOuIT4Si6OP5NAsLjLK4UfSSrElTh9Ao24U4so1pe4F7RM/l2oJ3POD65t
	FcJzod6IvHywdK3JiHYdtM/aEsk8Dk/OpQ6WWwPfTZF0Y8DW4JVHK7bup1if/44F
	RD6j15Yd2ny3DRd70k5J2HxL1L+wvPX1afOmTefx3g6TN9WTiG4iEetR0BG+44dW
	6fUtb5QdUSRJFlJAl9SSPFBJbC++KwXZOSQ8fC7OgK3vhtYb1hA1X3lybthJH7ss
	n7o9zjmbHxuKDydg5w97G2ls23m2s8VCQzag5GTZyw==
X-ME-Sender: <xms:zrXZZkMIVrX_EYQLfKYgJTcSRy-GM_sduYtpc93KCSjXnTgAR2avmQ>
    <xme:zrXZZq_Sx4D_pdUYGjumFUAa9hI_ySKJweLsJ5U6zNaAWteLSXSFivDaGwbndS7M_
    KFogTCE4BZQmWrdEA>
X-ME-Received: <xmr:zrXZZrRGEk9fsB2w_P_a4hs7JQsGmetdH7FHPcmKgcuMSuTmHknET4eO-nbarSz5ElXKKc3drTzUGvNqpwMB5JUKzmNYdzo0QqWHRdhEyUCQ3zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepgihinhhggihinhdrgiigsegshihtvggurghntggvrd
    gtohhmpdhrtghpthhtohepsghuphhtpgigihhnghigihhnseduieefrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegsmhifihhllhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:zrXZZss-IaFR0ny_S32qFmHT9zzLX3rtN3V0tlVWbsjjUc-KYV-zKw>
    <xmx:zrXZZsfi-aJbspwoz9a_e9jqt-OdB9snXeuzym7qNbnfQIFZMz3Q1g>
    <xmx:zrXZZg31fgh3A_4mGWrAsbnBr5fktyV33fM19fX7KnByu3Qayjr5ZA>
    <xmx:zrXZZg-W0U6IEyQta_S30-BorOmqwDkkiw93taYtaGbCy2865u60Ew>
    <xmx:zrXZZkQEskCYysUs3i6fdpNnHhFJjujOQup5GB9T5vfaehaMWXx5Et7i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 09:44:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8646e74b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 13:44:31 +0000 (UTC)
Date: Thu, 5 Sep 2024 15:44:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin <bupt_xingxin@163.com>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: Re: Re: [PATCH 3/4] builtin/clone.c: recognize
 fetch.serverOption configuration
Message-ID: <Ztm1w_61vjEkiC4C@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
 <ZtbgafDQwbU9tBoq@pks.im>
 <366dd64e.7b53.191bc028796.Coremail.bupt_xingxin@163.com>
 <ZtmQZQHnwYLNvT0F@pks.im>
 <3ce04aef.b004.191c21a2159.Coremail.bupt_xingxin@163.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce04aef.b004.191c21a2159.Coremail.bupt_xingxin@163.com>

On Thu, Sep 05, 2024 at 08:12:58PM +0800, Xing Xin wrote:
> At 2024-09-05 19:05:15, "Patrick Steinhardt" <ps@pks.im> wrote:
> >On Wed, Sep 04, 2024 at 03:49:28PM +0800, Xing Xin wrote:
> >> At 2024-09-03 18:09:45, "Patrick Steinhardt" <ps@pks.im> wrote:
> >> >In the latter case I could see that it may make sense to instead make
> >> >this `remote.<name>.serverOption`. This would also remove the unclean
> >> 
> >> I named the new configuration `fetch.serverOption` mainly to follow the
> >> `push.pushOption` pattern.  Since which server options to support is
> >> actually server-specific, using `remote.<name>.serverOption` is a good
> >> idea for git-fetch. However, how should we design the configuration for
> >> git-ls-remote or git-clone, if we wanna provide all of them with a
> >> default list of server options to send?
> >
> >As mentioned in another reply, I think that putting this into the remote
> >configuration "remote.*.serverOption" might be a better solution, as it
> >also brings you the ability to set this per remote by default.
> 
> I agree that using "remote.*.serverOption" is better. In fact, I also
> think "push.pushOption" would be better as "remote.*.pushOption". What I'm
> contemplating is whether we need to add a configuration for a default
> list of server options, so that when "remote.origin.serverOption" is not
> present, we can fall back to use that as default.

Junio proposed in [1] to introduce `[remote "*"]` syntax to supply
default values to all remotes. You could pick up that proposal and
implement it as part of your patch series.

I also have to agree that "push.pushOption" would be way more sensible
if it was configured per remote. I think it would be sensible to also
introduce "remote.*.pushOption" in the same way and have it override the
default value of "push.pushOption" if present. So the precedence order
would become (from high to low):

  - remote.someRemote.pushOption
  - remote."*".pushOption
  - push.PushOption

This should be backwards compatible, too.

Patrick

[1]: <xmqq5xrcn2k1.fsf@gitster.g>
