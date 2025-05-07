Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2311215F72
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601619; cv=none; b=iRjFXb9eWyYmdX4BoHcNnRSVAQfeq1u73CCrpj1dJYsP1UVbtvov8ZLqugqPPyDqGZOly13hHAm2eBclylwunDms4GEuKtETlRZk3xS9g9zRNCMqAhJciIxhJhWLLp53xJMim2hssWys7sqgtwq4hbey1j/FY7iGWmBci840Bv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601619; c=relaxed/simple;
	bh=qK01Xj1aHo43I3RvguD78+CxGDjP1efBPsNtps24S6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNaabJBv1S0FIodp4Pinx7c0LJuc1xOJcACaV/gwZRDKB30KxqJBV92wQ65KGkYSc38fxUCbe5T/XZ/Advra860AYNgaRo6rZIYEQBLPVP2oi+CCyz2h496e9ICdwI9ASh7aqkEeY0fsr80PtNABlYewwXfUBTeV4xr/QdggyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RZEb7OYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=enyfO7Gh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RZEb7OYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enyfO7Gh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAE992540101;
	Wed,  7 May 2025 03:06:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 03:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746601616;
	 x=1746688016; bh=BMp48bvCzH6Wak9s/u3F3J6tFw7bLjrEEwCtccECHUk=; b=
	RZEb7OYNAla7YcXyR+z/ZqVjFpQo4OlprhY51Ftl0AdXAnLpWa9qI7oimZqDOI32
	kA54N2/UCypBL4ZmfZWJkLHivn79AhTTz4dIquxyLkudWksT1ODWUEkRtDmdoBhF
	30D2bb2gxsUgQMXIQvkpkmhxTypFXUpwb7BLS5txi2oAsW3z082X94z28pW91dNA
	xb5UAXMKBmLqR71mkt6wkTnEkkscY0QuUdQrrgVMorWJW1eJVdHBbGyXUFuN1edS
	/X7eL/5VJLF2wbKfUfCAOrVVl2U/V5ehh/8E58h6UHyMCv75rSRaqXyB6p8FJ0qY
	3uqSQwaqraYAQdNYxcCAGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746601616; x=
	1746688016; bh=BMp48bvCzH6Wak9s/u3F3J6tFw7bLjrEEwCtccECHUk=; b=e
	nyfO7Gh+dhReLtj2NpJuy44sKk8PnRhgzJhQT8DncBFqsntcPsCT60cR54HLJPyl
	YPxsEj1vxq2ykuyc9mIv6AaK6YA7U16q9Bej1zdYcdpYR8N6TocxUDGEcdCXgxIA
	DVkb7Qb8h9/nh3r3bGCGKdFR3kWuS9IzeN5njbFJHfnV4Ne5yUYJPpV61fPuJKD6
	T3nMYHXQIGGSpEySt5gZvo3/aErI6H7mOkNMqPrjPjWF5YTznOLH2eOSLqy3epud
	WoUmn0IUn5VVZm5oIw8+AR4RYjcpO8ctXtcjmWwDi0m8mCLnzHSDSkU/usGbPH2j
	8xE0zquHX8MBpDD2pwRqQ==
X-ME-Sender: <xms:kAYbaEiqh2hATl-BreyALvKwBMdn9qANHSaBFIRfEgrIezurHuI0nw>
    <xme:kAYbaNBMFhcp5rYZBR4mnwRFkgVdb02JVxPlVgFNZYJG6k9sFC2LnWhdcYvZmfcfY
    zpfcKiEkYSmnWy2WQ>
X-ME-Received: <xmr:kAYbaMHsoQTebzTBqmZ_vv2UYNDRd7RJcTgtg_nmy_8lBl87PATIrEGzLnOhU09gNDIfGz4Hcy-CKOGnilTY2SFpsXbQ7LAGF9LVO4x_CzewkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefgteelhedvkeelvdeukefgtdffhefhheehvedt
    vedugefhvedtveelheejfeeuveenucffohhmrghinhepfihorhhkthhrvggvqdhprhhunh
    gvrdgruhhtohenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    tghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:kAYbaFSgdlhe20U8MQwgeQ4YlZkv85zT8yubwPP06pCNaJ95xXl-gA>
    <xmx:kAYbaByAQSARQ7oIMtPwFCZvYD1yYwvd0XeedFW1eFrJ4W1n6VYTeQ>
    <xmx:kAYbaD5Qs3etKko-2E2oNvTbEfLJP8jSDM1NOiCyU33j7LdMNsYStA>
    <xmx:kAYbaOxvNkHoAmboW93aPm48l6M1f7dmX526w4rXSm7YIN_WyxeJwA>
    <xmx:kAYbaL9o-zqy3IVGTK_7S8FlAvB1ABnz42bLmfGr0Lm_tTocsEj6mHc6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:06:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46887db9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:06:52 +0000 (UTC)
Date: Wed, 7 May 2025 09:06:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/7] builtin/maintenance: introduce "worktree-prune"
 task
Message-ID: <aBsGjVqYr2jY6oJ6@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
 <20250505-pks-maintenance-missing-tasks-v4-5-141f4df906a1@pks.im>
 <CAP8UFD2cuMxdpGFuBoKirw2mko6gt-djndqqZy92NypPiiFCYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2cuMxdpGFuBoKirw2mko6gt-djndqqZy92NypPiiFCYQ@mail.gmail.com>

On Tue, May 06, 2025 at 09:40:55AM +0200, Christian Couder wrote:
> On Mon, May 5, 2025 at 10:52 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > +static int worktree_prune_condition(struct gc_config *cfg)
> > +{
> > +       struct strvec worktrees = STRVEC_INIT;
> > +       struct strbuf reason = STRBUF_INIT;
> > +       timestamp_t expiry_date;
> > +       int should_prune = 0;
> > +       int limit = 1;
> > +
> > +       git_config_get_int("maintenance.worktree-prune.auto", &limit);
> > +       if (limit <= 0) {
> > +               should_prune = limit < 0;
> > +               goto out;
> > +       }
> > +
> > +       if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) ||
> > +           get_worktree_names(the_repository, &worktrees) < 0)
> > +               goto out;
> > +
> > +       for (size_t i = 0; i < worktrees.nr; i++) {
> > +               char *wtpath;
> > +
> > +               strbuf_reset(&reason);
> > +               if (should_prune_worktree(worktrees.v[i], &reason, &wtpath, expiry_date)) {
> > +                       limit--;
> > +
> > +                       if (!limit) {
> > +                               should_prune = 1;
> > +                               goto out;
> 
> Eric noticed in a previous round that wtpath is leaked in this `goto
> out` path, and it seems to me that it's still the case.

Yeah, our mails had crossed back then. Fixed now.

Patrick
