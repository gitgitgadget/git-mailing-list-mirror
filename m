Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94F1F12FF
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069669; cv=none; b=i+98d4OR876PI60Yk7mfGPBP+AC1tshL27X5Iso9q7dX5Lf3ErujKU+AuFfzLcKSU/BdifEEd72XfA9Z23Rx7LB1dLr8Vux2UWTlNzJlKtHvBvefl+lyc//8hAfm275Men7+ttXBkbGj+tgkTf7DmSMTVQVSjgPmZWpC+HkBzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069669; c=relaxed/simple;
	bh=LmvnUpTBzZGCWW7Fs03LZh9TkDLp6b2ntdIf8hVqnoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phFNEQdYKSvNTeAJjDfnZjXRew8/CfzoIVNGhL0kphY9SeWVkfGVSSoTru/vFssoCa8izh7YH3xHAJmVSHd1Qb6K0ae9ZpjbUGudrS+D3GqRD9Qhsx+uFjshYKXLDOii4G/+bEDnGG9J+ADc8s2oSmPJ37mUOwvFakvPYyNGZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iNc/GchY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K08QAhsG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iNc/GchY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K08QAhsG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD37D1140213;
	Tue,  4 Mar 2025 01:27:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 04 Mar 2025 01:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741069665; x=1741156065; bh=ZqgzpRixJ4
	j8gYT0M6Y5Qutt5JFDPTuTV8OW2ePVH2Y=; b=iNc/GchYDf1QXXAQVSKIfCme7U
	nOBeTADmraa/Bc1JWu3NGOuULnm4OFfKRXbLv+lK31wIkl1kqx36Q1rNUo1PEOGv
	0qdFObhKKMcz+91Dq8m8dGvEjPLb4cnwj4RVEDsLpWficKWJZklMp7+E3cRVE+t7
	5XmCNmG3sR5ijW71Ye/lMtlTgG+lWjUB1oEKpJSeCEH/yT0LuweR7UkR1c5bkN0c
	MICh9awGeVxEBFKiTOVNwu9GYahzLDO3JeQz/nHu4argfVPRzQha0+ikHqysV1Pq
	mzyua5GF6CmjHIotu4Q1MeXb0ovkWNVTvqNlDfTLnNa4P9fdZYR3cq391Xiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741069665; x=1741156065; bh=ZqgzpRixJ4j8gYT0M6Y5Qutt5JFDPTuTV8O
	W2ePVH2Y=; b=K08QAhsGj85hEprJjhDCfJA4xzmY2isys6l4FOWb2lMC7pPehEz
	EkI0sFdh+ztXtgL+yqF+Mts03e0yaqDYq3zGdqGpzyc5Z64TkoetU9Say8AEB+hJ
	K9fJv1v/t9j6nHtl4rV48uD8Zc/eYbsyU7tygxWBGS9aohABUNZcMewR/x9IF7ed
	cCbko0LnNfqb4zhHpsl5ZeDkBrZBOPHGJcaLdaCuTBqnLXc//Ww4JcoQ9LwRA77G
	nKSLIPFzyzW6pCV/TulO+alr9LKlX97mJ1PEq/QuG50HUNiq9xnfNSkF6GcbfwYi
	bT/graoc77quc2kdMyT0aMn4PVwP9hL30nA==
X-ME-Sender: <xms:YZ3GZ4sS9HH4xUL-5wwSMPbA5QsCY9U5BLn8iPfII8_2HFnZSoB3PA>
    <xme:YZ3GZ1fjrrcqIkt3fPDPCcpbXW59al7zEghGBQzcme2OkoFwynTTLAhOKssKpL87U
    aMjfgTtua-r_NI1Xw>
X-ME-Received: <xmr:YZ3GZzxOS1MAhwfqP4SUuN42RwcXUxTdZD-bPY3VLaqUEVXXh7n8nMMIlegZMMir_1XEglPbh8j_KvG31jlvqHXGi3l7oD9VPMRAS6NaMp9QSt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddufedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YZ3GZ7OjjYu-lfMgx4DxDTVWvyfzd-YE7KeUI0i6gaOb_cCkL57fyQ>
    <xmx:YZ3GZ49JqQvroNL8wj8Sw3y09IaIpMLj1AN3e-1typYDLrLmIYCQ3A>
    <xmx:YZ3GZzVo5WGpskbIu5NgeZAXzFHsyWunP2ja_SkaHVbMrYOUj8kr5Q>
    <xmx:YZ3GZxeOxkN8cV83lg9UHRCsr0o0sDhvrODdYJgcFhch2XlCSzPj-g>
    <xmx:YZ3GZ8YoHTalcOwbMmsYMaImwT1dUuVj6kHZbe_xnDonZvmAeljKWNqe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 01:27:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a213653c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 06:27:41 +0000 (UTC)
Date: Tue, 4 Mar 2025 07:27:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2025, #09; Fri, 28)
Message-ID: <Z8adWTssWtaNTfx4@pks.im>
References: <xmqq7c591sus.fsf@gitster.g>
 <Z8XJnJEHZd1dFE96@ArchLinux>
 <xmqqldtmvyfa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldtmvyfa.fsf@gitster.g>

On Mon, Mar 03, 2025 at 09:03:53AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:
> >
> >> * sj/ref-consistency-checks-more (2025-02-27) 9 commits
> >>  - builtin/fsck: add `git refs verify` child process
> >>  - packed-backend: check whether the "packed-refs" is sorted
> >>  - packed-backend: add "packed-refs" entry consistency check
> >>  - packed-backend: check whether the refname contains NUL characters
> >>  - packed-backend: add "packed-refs" header consistency check
> >>  - packed-backend: check if header starts with "# pack-refs with: "
> >>  - packed-backend: check whether the "packed-refs" is regular file
> >>  - builtin/refs: get worktrees without reading head information
> >>  - t0602: use subshell to ensure working directory unchanged
> >> 
> >>  "git fsck" becomes more careful when checking the refs.
> >> 
> >>  Comments?
> >>  source: <Z8CMx7O19PMs9sVY@ArchLinux>
> >
> > I think I have addressed the comments from you, Patrick and Karthik.
> > Could we make the patch into "next"?
> 
> Mine was merely a small kibitzing on the logic flow structure, and I
> didn't really looked at the larger picture beyond that part of the
> code I looked at.  Let's hear from Patrick and Karthik (cc'ed) if
> they find the result of the updates satisfactory.

Yes, I'm happy with the current state of this patch series. I'm a tiny
bit worried about the new call to `git refs verify` in git-fsck(1) being
added this late into the release cycle as we're now exercising a bunch
of new code with only a few weeks of testing. My basic assumption is
that mostly noone uses `git refs verify` explicitly right now, so all of
the code we have introduced there over the last couple of releases did
not yet receive much testing at all.

So while I think that executing the command in git-fsck(1) is a good
thing overall, I would feel a bit more comfortable if that last commit
of the series landed in the next release cycle. But maybe I'm just being
overly cautious?

Patrick
