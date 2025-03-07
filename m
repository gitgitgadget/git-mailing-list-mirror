Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115563CF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334994; cv=none; b=D5aBRkkn78cye7O+8V4/yKSlAHHmig2EZpACHzCURUgMuySVGm4G13bZK5Jg4G/C8ikmLLIV85yu4ay4VpxDXJkYLbejCqCOcPnhxo/WcQB0ldl5daPiqQnf2avjgeH7It6MKEcPTn7u1zSA2ydDWF1/v0ZxDIkUAKm/7ZcEYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334994; c=relaxed/simple;
	bh=G36Kzc08uCm/SvljEaYAWsn32ENStb6xspUK64c3aYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz/nPZtk35gtl1Fv97UIU44grf77cqNq31xaV/yN/m+lpDMlr7lZgQU5MyUXNi4F3FIIvyOGU2hpygDvdhUJ7PJmzmtJkZXiKSD2n5uq3r9Eux3O7/FvX+O8+50/RQ6NA0u93jM4myiZeOn8EVpWBnn6uv7DXgtssXFCctx07n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KAaxDbpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0hYLani5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KAaxDbpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0hYLani5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12FC811401D2;
	Fri,  7 Mar 2025 03:09:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Mar 2025 03:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741334990;
	 x=1741421390; bh=qTDlALA10dvTH9j8tzoaBbSVF9lSYlEvzKqTT8PsxFg=; b=
	KAaxDbppHpmZuO3x46Miu40hu2IKwI6IFcqD01NahaOIytAkT3ggEwXMfBteDEU8
	LRJz7ZJtvN+qhxSjZ59l/+5as9V4qInF+Bu/gWec9QoR4H2aWTWG1AeGmEa9rGDp
	l1v49Iv+69lm60ZWsdFE1BpELzAOHc0LIH7vVHt3YZZw80Js2GgNWnKnrr9K1Vkf
	PQ5KMPnkY9yWd+Dn4bDzvqlsZJlImdkV1n4Q9I4kjgfxK2B2ci/rDY2DqS+VBtGk
	uLzlcNua+J6j43657SmfGdMxDYtFb0nJEQtjZOBJWb5Xt1SCsx41bfIlN6Xw21J2
	pbseopcrdFLcCpz31g5pwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741334990; x=
	1741421390; bh=qTDlALA10dvTH9j8tzoaBbSVF9lSYlEvzKqTT8PsxFg=; b=0
	hYLani599tMZKNZIto8c8xU/dTE585xo2fKnWoeqzXiyzN6n1fuqpLVE/wyUWE9Z
	09oPdQzw7QvpJfRmb3ROX3v1eVVGE8gCQvtNcw28uJcjyDMB5vIuTnl/ybFl6hL6
	W+n78d8ExfrheCmaBqDXuCJCg8C05nmgJgzetc3+veUQzLRt8xu7sr5ISxZrw/5l
	VHcVN/XAW6BGhXPlDJepCIlrVXu1aBgb0PvbHNhnEQKwskpGBINB+U75OzQkLNCl
	Q1liW14XiJSukjBcM61/G9CsJwIG/NgJrPSW46RGxUuQSw292M74JsPceNoLKvOM
	btLzU3+94/A8rg0uLK1bQ==
X-ME-Sender: <xms:zanKZ_UQ8Rbtido4VcizXYYzHuImKq3rustd7IvF_ElOuOyfpcat3w>
    <xme:zanKZ3lysrmjhBqjrw1ZBkBgg7HEeldKMT3i-tznhA5mZ94g4Z4Qo8iS--VU3KRAv
    FBn8N2TUCJrAJeYfA>
X-ME-Received: <xmr:zanKZ7bLv9D48sr-UNkLuDOtTVc562Ov6w7bZkztQP9uf4rG9I00xs34foS7dD2dnN2Bv8f2T7S84luBmlmWU49dcHnQPbpHx1vAhVVw3stm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitg
    hkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhn
    pedukeeuvefgkeduffetvdehgefgvdehuefgtdelueekueffteejteffhedtgffggeenuc
    ffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zanKZ6WsWhcyhy83Vmd7LlVy844s0HzfJ3f5jz9otXVypaZBuTRQAg>
    <xmx:zanKZ5mEF-O4FBM2ESUekBFbNrd48SJobe4EUjh90qtWkycZtzynOA>
    <xmx:zanKZ3eHFz6w9Pj0sSVvBFfzjZmLVZdqYbslkXBc_dgT2Sf_SACSIw>
    <xmx:zanKZzEpCxrj4wO85OcLSDvmbfdRFXhUPLDsO3hNkp3IwXU2KJ4x9w>
    <xmx:zqnKZ_jEBgH7R_Ns-PaYBWlNZikq8D0Gf_t5FNClCTVShso7t11zaAIl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 03:09:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ae539eae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 08:09:47 +0000 (UTC)
Date: Fri, 7 Mar 2025 09:09:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>, git@vger.kernel.org
Subject: Re: Discuss GSOC: Refactoring =?utf-8?Q?in?=
 =?utf-8?Q?_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <Z8qpxj2i3vFjJe4l@pks.im>
References: <20250305104650.238392-1-ayu.chandekar@gmail.com>
 <Z8g4dTSFQDTi9ueU@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8g4dTSFQDTi9ueU@ArchLinux>

On Wed, Mar 05, 2025 at 07:41:41PM +0800, shejialuo wrote:
> On Wed, Mar 05, 2025 at 04:16:49PM +0530, Ayush Chandekar wrote:
> > Hi,
> > I have been studying Git's environment as I'm interested in working
> > on the "Refactoring in order to reduce Git’s global state" project
> > for GSOC 2025.
> 
> Glad to hear that.
> 
> > Some basic changes at the top of my mind are removing the
> > 'have_git_dir()' and similar functions or shifting the
> > 'local_repo_env[]' to the repository struct.
> 
> Although there are few callers calling `have_git_dir`, I don't think
> it's a good idea to remove the `have_git_dir`. This is because we need
> to reomove the dependency on `startup_info`. It's not an easy thing.
> 
> For `local_repo_env`, I don't dive into. So, maype Patrick could help
> you here.

Yeah, things depending on `startup_info` are definitely a more involved
thing to address, and I wouldn't necessarily recommend it for the
initial batch of refactorings. I'd recommend to rather focus on some of
the global variables we have in "environment.c" that store configuration
values, which are generally a bit easier to tackle.

Also note that `local_repo_env[]` is nothing that we need to adapt. It
only stores a couple of environment variable names and does not have any
state, so it's perfectly fine to keep that variable.

> > I also read through the patches [1] and [2] submitted by Patrick.
> > I can see that we also have to shift core.* into repo settings.

Yup, exactly, this is what I mention above.

> > I was planning to submit a small patch moving access to
> > core.attributesfile into repo settings. However, before
> > proceeding, I wanted to confirm if I am on the right track
> > in understanding the project goals. Could you please suggest some
> > more files I should look into??
> > 
> 
> I think you could work on this but I don't think this would be a small
> patch. You need some efforts to figure out the solution. You are on the
> right direction.

It would be a bit more involved than a typical microproject, but I don't
think it's particularly bad. It would involve a couple of steps:

  - Investigate all users of the `git_attributes_file` global variable
    and how they interact with the variable.

  - Adapt `git_attr_global_file()` so that it knows to not only handle
    the fallback value of `xdg_config_home("attributes")`, but also
    knows to first read the value from the config.

  - Adapt `git_attr_global_file()` so that it accepts a repository as
    parameter so that it doesn't need to depend on `the_repository`.
    This will also require you to adapt all callers.

You _can_ use this as a microproject, but as said it's a bit more
involved than what we'd expect. Which isn't necessarily bad if you
manage to pull it off, but might make for a bit of a steep learning
curve.

Alternatively, I'd recommend to read through [1] to learn about
the application phase in general and [2] for recommendations for a
couple of microprojects which are easier than the project you have
picked :)

Patrick

[1]: https://git.github.io/General-Microproject-Information/
[2]: https://git.github.io/SoC-2025-Microprojects/
