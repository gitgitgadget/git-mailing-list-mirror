Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B0257851
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902027; cv=none; b=K9JC9B1Rn0YrIHX1d1cosmwtlCO8E8teGvMXWZkPKZoh8lb/XjEEDwXNLY6qyqvP7Qm4JFHUOlN9jJ0zItaoPM13MwwAeAfvl4ESsV1Q4tinTJSqWqqwxgNrbWONx6nFOHNo9AAQx2wj0iyRDU0gj2XjQ63pj0w7NbWPjnvjin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902027; c=relaxed/simple;
	bh=ESgb8Iu2uGEn5MK+V2lSz7LBJwltmZYYkLk6XLBVgLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edGaswqcRtXRSQhSPmd6UhYyiVxbxdaKw6N9C832Ar1lRZwpwgFsOCSWnPcMlBYAqtRlRqDmbMX+xCAviC9/FfAaj7xDMkeCza0b8+fA2os20ziqcey6EaSWAvDU6YZfChXZ0oJjGc5Cay6ehf6vaH88/WgUWwDmZXUylDGU5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AIw19EaJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+5BeXYM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AIw19EaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+5BeXYM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B13591400426;
	Wed,  3 Sep 2025 08:20:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Sep 2025 08:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756902024;
	 x=1756988424; bh=wSAHgykDdo2QwtBJrvlhxGKzos0dlpBTQB9yuaHfuv0=; b=
	AIw19EaJ0Dwjb9TL86hEDNea4wBQOKDwvZlISjg+6XeGuLLoetEaaAe/Drx/ssv0
	Iykn2/n+Kx+GVJuaI8uoXBzYV6V2w+Ep1Hpz4+yrF7uukTo/WYShvVNO+vNT301t
	9JHfJqbgq+ix7XQAfOAr6EQkbxX6keQcgh2cd9aNvPIplJmfRW7mm8zIVRcLY1TQ
	XRe8Vz6yDAtkOHm/Lncq08fTYww4UKNNZd9NHsZ0Jh7vdq2nXM0WcAcm1T+iGQ8j
	HFfOnKSow1q1dTDQvAhkjVJrZ6Ow78zXo5V2x0E9Zxn5lUScfvOJQcv4nTDW8PJW
	OoEpSDZ9VqFZVoptnTZZ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756902024; x=
	1756988424; bh=wSAHgykDdo2QwtBJrvlhxGKzos0dlpBTQB9yuaHfuv0=; b=U
	+5BeXYMpy3N2ydQFqtkMFpcCAgavsjho9SXqEXCyV7aEaSYa1L3t+Sg0Hxao3k6z
	2HGY0pZ5k61HgCOMToA6en4lw2I/YAtDaanMRkpYYXb2/9jLlY48wHFNrfJmXj+Z
	0ILhaGXHbiHwmGRu2lsXPTRdCX1menaT9ySaMeQboGc0AbCSe0QkXStdjKRLeqmc
	5VZNEYYg3efLsiR9EyX2NneHTnq1u/5orvfeRKSAJSaAH11Mas1bDNQmN+cHgvIs
	ym3Aw9DQQr6SkpVkPTtzeMICOEAUQIF/0hNquPzsV4/5l/AKiSUtU7c5rhdKFdlw
	T9euvfyfVD683wF63Cr7w==
X-ME-Sender: <xms:iDK4aKCdpiuvl57pXvATUX_voCtf0YSW8ieYnI2pkkIsRuu3cmpCYA>
    <xme:iDK4aCG5UkKM1yoLKoYIqbCarDm8HoqTWVGYCioFuTIqGFsafv6RpcrhMCI4rtztQ
    qnKcldn3aQrckBHGw>
X-ME-Received: <xmr:iDK4aEDnp2b1BQ-wTt0CT5fYs4buGqvv9ZQFax3ceIsJhcpfAgvxJmCrO0Tgtz-u3GSItMcPO46488HYTPVVT9TE8GDywCBCO9FQRbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonh
    iisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsoh
    hrghgrnhhovhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iDK4aKXK9YU-mfuXWzdTO5pT3MuMqV3GyvMiJBWTw_m5Q1D8JSv_IA>
    <xmx:iDK4aArmIBYVsjCqEk1zcd1rUfFLygwcyTv4vMS5j2tBzkOG85OwOg>
    <xmx:iDK4aORJwSsCpoGbJLsnPos3bEwkR0VVMofD4WEPvXLM2xhNfdTlZQ>
    <xmx:iDK4aC1JSK7dgHt2SCRSVuyze9_pasGHKZXBnPsBBICS460M_dcM-A>
    <xmx:iDK4aH_rUjgFb6AKF7aDDGte9_32UMsGnvDLKL0g-qT16JyIsTQs0FXl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:20:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3e7a75b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 12:20:22 +0000 (UTC)
Date: Wed, 3 Sep 2025 14:20:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split"
 subcommand
Message-ID: <aLgygyUuQCmR25qU@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
 <CALnO6CBRv-Jvm1FsUAkDSyaNNRXtMukReKzefvCw5-vj=-pnCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBRv-Jvm1FsUAkDSyaNNRXtMukReKzefvCw5-vj=-pnCA@mail.gmail.com>

On Tue, Aug 26, 2025 at 09:14:49AM -0400, D. Ben Knoble wrote:
> On Sun, Aug 24, 2025 at 1:44 PM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/builtin/history.c b/builtin/history.c
> > index 16b516856e..6d3f44152c 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -517,6 +527,285 @@ static int cmd_history_reorder(int argc,
[snip]
> > +               wt_status_collect_changes_trees(&s, old_tree, new_tree);
> > +               wt_status_print(&s);
> > +               wt_status_collect_free_buffers(&s);
> > +               string_list_clear_func(&s.change, change_data_free);
> 
> I think I'm supposed to see the changes between the old and new trees,
> right? Does this only happen if I use the interactive machinery to
> edit a hunk? When I try accepting some changes and leaving others for
> the next commit I get no diff in the template.

Yeah, it's supposed to show the diff between old and new tree indeed. So
in theory you should see something.

> I did try to add new diff lines to a hunk, and nothing showed up…
> maybe I'm holding it wrong? I'm pretty sure I compiled this version.

Do you maybe have a reproducer for this? It seems to work alright for
me, but I wouldn't be surprised if there was a bug here. The wt-status
interfaces are quite something and I was tearing my hair while trying to
figure them out.

> It doesn't look like it's triggered only on commit.verbose config, either.

Fixed now.

> > +
> > +               strbuf_reset(out);
> > +               if (launch_editor(path, out, NULL)) {
> > +                       fprintf(stderr, _("Please supply the message using either -m or -F option.\n"));
> 
> According to the usage, git history split only supports -m, not -F ;)

True. I didn't want to add too many options right from the start to keep
the series somewhat simple. We should eventually add it though.

> > +                       return -1;
> > +               }
> > +               strbuf_stripspace(out, comment_line_str);
> > +
> > +       } else {
> > +               strbuf_addstr(out, provided_message);
> > +       }
> > +
> > +       cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
> > +
> > +       if (!out->len) {
> > +               fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
> 
> It _would_ be nice if this and similar errors left me able to "try
> again" without losing staged changes—I think I mentioned this before,
> though. And with the in-memory indices vs. actual working state,
> presenting a UI here could be very difficult. So it's an
> understandable choice.

Yeah, I don't dare touching this yet, but certainly see that this might
be a worthwhile addition as we iterate on this command.

Patrick
