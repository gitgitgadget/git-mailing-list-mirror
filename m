Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CC20ADF8
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578186; cv=none; b=AP6NZ/Qz3FxRVuGtm/tQIMOsCVeEe7ES2Zs9W7eq4mJGH1JX7XH33GCIv3vnjQMLstG+ekdxWDc3tQdsdMyMBAC5jzBJDm67yuu17clPnP2wxAD2HYzt2mzUrcaO4Wa4BUrp3GzhVL9u0NECY6yZ1GabE4H9Ofo80mr24fNvJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578186; c=relaxed/simple;
	bh=UVMD6+M2u1/dXqWF2ZZ0/U7MqbH5niVPsjVe4c4WX8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs70mebsvVuALzZv8AcZCv5ZU4Uv5OOZ0s2eg+jbFXYJmQNT14U/GYgIHNt68mp3hf7Xk7u1qfSiZ9TW9Mm7TCCFJZW1/kBBFoGmvgxSkfknO+DZaAlA5WJ/Oq2eZ3N67vvIDpwz0/1ReHqWdtGE0VOsFvXnzbxS6mBebbPnhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G8alk2Yo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f6hUTXGw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G8alk2Yo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f6hUTXGw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id CBEEF1140152;
	Wed,  2 Apr 2025 03:16:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 02 Apr 2025 03:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743578182; x=1743664582; bh=WBnOr2RviC
	QoAAOLiNFJEyMnppvDOqCxHsviWjGRdio=; b=G8alk2YoHmCs5OmXKdA+vO/fmS
	60FSaNKStO+B/065KRsdDRN9QpW6/xZvbquR7xAzllO7Xkk+KuSeq/5OAK3Dk3HP
	bcqiaMaHHV1Qhrn3S0yNZpeA4saln1lrskXC/vCdEA+IVVbHJ8Pm+4tfQZt5J5IR
	ByM1i/rT8ya9Dc903DK6+RS8nTM+Q3PcVq/CdE9yARFUEzXEaP7b27G0K+kvw59r
	Y3uIVJkxIM8gXMLgudby3gjALM1O7ZoYII91bUUOnBXw62fkyUqQVTk7Dnsz9Cnk
	T9rWaCTwEUNc4/ONR7fxmLD9eCRKVRxxVOkpXXnh4E7PY+Mu/hQAl7mw0dwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743578182; x=1743664582; bh=WBnOr2RviCQoAAOLiNFJEyMnppvDOqCxHsv
	iWjGRdio=; b=f6hUTXGw0VV8HBspZaZUsouE6nfL/KWmaM80+Gac6k693Z1qpsd
	Bx7SKitnCNQXUXgA/p03/VWgLcWs1Rt5X/xChVSiBu8Qv4BLtp0+NK4sHaoeijOy
	BNSAOVcTlEFo4PFJuvEB1m+ZwCWXZy6bJyQq4ralA5skUpr1pJnJsrIp3tJVDBDJ
	vhzJE8IW9kEbpaCL0eTg3wTWtVHSjO8Rhkga16zkLz/xHPveBuaOE5qOJLa041G8
	994K8eKeN63PgS1lTEEg0aPQK1qnAI5GVQdTRc13IPk40LkX46EzBJhPZjWH34eH
	UrZbyKuIx1YxlVdGBsyEdLUsaQirekVL54Q==
X-ME-Sender: <xms:RuTsZ1JitrpcHyar8NSOLNlt05ZJ3eJiwgoH1y4x1FL-9cjAZSCtBg>
    <xme:RuTsZxKli2N88x_qILFQXpt-oHgwv4JZZA_SDRnAC6LlQfhansSIR6T7XZ3Dma7NG
    b5-KlTEVDX9kVR_cQ>
X-ME-Received: <xmr:RuTsZ9vMu5i-OWC4CjtKxkIt7js_yQNoI2hTjeMpcEcxqQrPnxJqJJk2s_8b1FMGGGWdSw8f1n1JmUspIhEzxVpwxesLPAUoaQhPJ_0zTdXNxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvefhfeeftdetleeugfdtuefgtdekuefgleektdeh
    geeikeduudeuveeghedukeffnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:RuTsZ2ZnyspzE76dz7yetJlkaB_Ea8gnQkeBTyHrb5z7QU16lrx38Q>
    <xmx:RuTsZ8ZuXzOTiDyt8fqmW05OR0hA1RnNjEP_bCpH_WlQRsy0-oASgQ>
    <xmx:RuTsZ6CqlvC_EAF97xovPuzABgO_6LEE1AuG_ngoSlByitGU7mB6dA>
    <xmx:RuTsZ6b3j0vMCsF8DtKySHIHAex6c_bSizsp0d7BXZgWTJsh6VL27w>
    <xmx:RuTsZx-foii5wVrTgr2aXEbqDsbjrX8pVAWD-tbhuspign-RUN0RJ1Rs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:16:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 32c85e0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:16:20 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:16:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 06/20] t: introduce PERL_TEST_HELPERS prerequisite
Message-ID: <Z-zkQyRCM3BkovgY@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
 <20250327-b4-pks-t-perlless-v3-6-b436de9da1b8@pks.im>
 <ee5e082f-6ab5-b996-9a0d-f7e5192c01be@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5e082f-6ab5-b996-9a0d-f7e5192c01be@gmx.de>

On Tue, Apr 01, 2025 at 08:26:36PM +0200, Johannes Schindelin wrote:
> On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> 
> > In the early days of Git, Perl was used quite prominently throughout the
> > project. This has changed significantly as almost all of the executables
> > we ship nowadays have eventually been rewritten in C. Only a handful of
> > subsystems remain that require Perl:
> >
> >   - gitweb, a read-only web interface.
> >
> >   - A couple of scripts that allow importing repositories from GNU Arch,
> >     CVS and Subversion.
> >
> >   - git-send-email(1), which can be used to send mails.
> 
> There is also `git request-pull` which is a _shell_ script that runs
> `perl` to parse the output of `ls-remote`, and there is `git
> filter-branch` (which was apparently not yet dropped?) that uses Perl if
> the `--state-branch` option is in use.

Ah, indeed, thanks!

I should probably mark both of these to require Perl in our build
systems so that we have a source of truth what requires Perl and what
doesn't. git-filter-branch(1) also looks somewhat broken because it uses
Perl directly instead of using PERL_PATH.

On the other hand, maybe the better fix would be to just convert tools
to not use Perl at all anymore so that we can eventually get rid of this
dependency altogether. It feels like we're quite close, and many of
these conversions are low-hanging fruit.

> The patch looks good, in particular when fetching the `b4/pks-t-perlless`
> branch from https://gitlab.com/gitlab-org/git and inspecting 8fc639f99d9f
> manually, as it is a rather large patch that is pretty much unreviewable
> on a mailing list.
> 
> Using several write-only `sed` invocations, I identified that there are
> only three hunks that are neither adding a stand-alone `PERL_TEST_HELPERS`
> prereq nor adding a test preamble of this form:
> 
> 	if ! test_have_prereq PERL_TEST_HELPERS
> 	then
> 		skip_all='skipping <something>; Perl not available'
> 		test_done
> 	fi

Thanks for double checking!

Patrick
