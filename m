Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E93563FD
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222964; cv=none; b=KTCBzC28WIoATXsoHzEugJVFor+wUStM5xlRN0c7K+NfjcOLsZutXOc2Tm5Fc1ZcnQFKfThsvczbswxfq0OSD7yT5G6uUsNw+A+AG9y8EAacr3RYCAhUfc+pbgas34T7B3tURLagOoo4u1lJFhyG8C3qaSG3HPI4xPy/lVUoJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222964; c=relaxed/simple;
	bh=idX0Frl/p76TO4oiZ0NrpgN+bxMmpwXWSKVLwnI1voE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSsWeDVbF9KR7Qw6zhqlq5IMqB8I4E0aSG4VRfUxC9b716kMNKwHtqpAAvO2TzoX5phQ3avavFOr6+RX9QQ41wY65UWn9JnFUuXiSt7qZbJ11G66PcxX4i9KK7voa/SR8CvPS5RH0hJaQfbXF/vJMqK1r2ubrWzXR4rQxP18rtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QTcEa9g9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptk3ZBOb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QTcEa9g9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptk3ZBOb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F1C1140001A;
	Mon, 12 Jan 2026 08:02:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 08:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768222961;
	 x=1768309361; bh=OLotSmMcLQ0dll8Ilov7c+Wkf/LY/K75f9afgekLYCA=; b=
	QTcEa9g9nakdEpcOv8HUiamQReSdbCoeF1z9NmwkzT+HDrbARMq6SJH2MNlsCdGU
	puogihGR8jqkVfZyvVopb3TisD9s1ofwxgXbfcTIQ5givEE+uiDKTsHCQQdoIiDO
	c7uaVgfNQkLv3kkS2n4UkuAqEF9Ny5ozBt4bva7b8bD57+5WuR3r20PNakj2hPQ8
	rh8NyCa+lFP4UBIgzKf3IZ2dsl2NZclj9VkHfHAJOmf/BIcCV8gd8wR1WlVIG/B2
	QdW8Sx5ZKyEaprHm/VwdFD6mObLEQ9covMt5BAp2urnWxxN2XIa9P3q55AiWkQcU
	UqQYr4BODGGpCS7+wmkCew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768222961; x=
	1768309361; bh=OLotSmMcLQ0dll8Ilov7c+Wkf/LY/K75f9afgekLYCA=; b=p
	tk3ZBOb+dwth4dYGnzJjLj7YkZTG6MHS4BuciJWJN0wyrOC2H5QpnxwYUGcAOdyx
	IWXFf/FbqWEReDcdjY5QW91hIwsZ4gIKL9Yb8rzWuLeYYjoOySGr067PkBSLrGcS
	jdxFdJ19JO4uTQEpq6Pnqs/sNO9M+2r2czMZGhaaB17GT6T6phrXdYmRvHR30YVq
	rtRFAJG18ua4Dz21xK4dd4JElXlE6C9mQSC/9udl7XTsV55F56OFuOBK2GCGII/S
	4TurKJjEfIwDBFceyCr4o9UE7JDarUikg2KHub0dNaRV9pubZ9YOZfhtFjdO20+j
	D/1QVY1pQAA4OEkDMdmXQ==
X-ME-Sender: <xms:8fBkae8xKMhpxikFM0LVPNMhplDQIgNPXyw2PZKgo7y4T8Hjau6aIg>
    <xme:8fBkaahnf10nxg7L9MvlnxXuMnGpkoeDt3ysk3Gl_AJmQBnET0z9A1XYueXvAnxX8
    ubox0ZBi9WK97ZI9BIo9IOXPZ32edCzpWOfa4J0Mx_lGssWYoYwJA>
X-ME-Received: <xmr:8fBkafZLkU0AcUWliXrspB4IIl862P1r4cM1JVKB-ff8oJgMKY_Isr_r-1LtgyW2QLHNpuRt4BDM_EhySP-vBr3Z92Unxya-QrKwLiKrrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghilhessggvhigv
    rhhmrghtthhhihgrshdruggvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8fBkaf-Ykh79PRoRmYB4y1YjeG17zZ3mYzwZnEB7OchbvX0xthJJeQ>
    <xmx:8fBkaRPVfi38hz8zGPKAxG-j469oIT_tp4AYrWm72-fvVBXOArZA4g>
    <xmx:8fBkacGc8mQXuyQI47usRX9dEDsmQ5swKDEqhT-FMJLs79WsdK6roQ>
    <xmx:8fBkafwxp50uiJ2VyxD_XKME-sBTdaRGP6Q2O3i_ZQUD87rsNwEs8A>
    <xmx:8fBkab_CsJJxVaBxvaDM2Wbz_-TdCLrE8mFNPabv12X_XmHwk2qE0L9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:02:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b786e62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:02:39 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:02:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v9 6/7] builtin: add new "history" command
Message-ID: <aWTw7I7JPUnRBFR2@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260109-b4-pks-history-builtin-v9-6-8766101814c6@pks.im>
 <CABPp-BF3jat7zStaydVa=fGHd7b=k6_KgDHt41XkOz+fMF+gbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BF3jat7zStaydVa=fGHd7b=k6_KgDHt41XkOz+fMF+gbQ@mail.gmail.com>

On Fri, Jan 09, 2026 at 05:17:25PM -0800, Elijah Newren wrote:
> On Fri, Jan 9, 2026 at 12:35 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > new file mode 100644
> > index 0000000000..5a9d931efc
> > --- /dev/null
> > +++ b/Documentation/git-history.adoc
> > @@ -0,0 +1,56 @@
> > +git-history(1)
> > +==============
> > +
> > +NAME
> > +----
> > +git-history - EXPERIMENTAL: Rewrite history
> > +
> > +SYNOPSIS
> > +--------
> > +[synopsis]
> > +git history [<options>]
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +Rewrite history by rearranging or modifying specific commits in the
> > +history.
> > +
> > +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> > +
> > +This command is related to linkgit:git-rebase[1] in that both commands can be
> > +used to rewrite history. There are a couple of major differences though:
> > +
> > +* linkgit:git-history[1] can work in a bare repository as it does not need to
> > +  touch either the index or the worktree.
> > +* linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
> > +  current point in time. This may change in the future.
> > +* linkgit:git-history[1] by default updates all branches that are descendants
> > +  of the original commit to point to the rewritten commit.
> > +
> > +Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
> > +your commit history that is simpler to use compared to linkgit:git-rebase[1] in
> > +general.
> > +
> > +If you want to reapply a range of commits onto a different base, or interactive
> > +rebases if you want to edit a range of commits.
> 
> "If ..." with no "then ..." ?  This sentence isn't complete.

Oh, true. I noticed this error, but only fixed it in the next commit.
Will move around.

> > diff --git a/builtin/history.c b/builtin/history.c
> > new file mode 100644
> > index 0000000000..f6fe32610b
> > --- /dev/null
> > +++ b/builtin/history.c
> > @@ -0,0 +1,22 @@
> > +#include "builtin.h"
> > +#include "gettext.h"
> > +#include "parse-options.h"
> > +
> > +int cmd_history(int argc,
> > +               const char **argv,
> > +               const char *prefix,
> > +               struct repository *repo UNUSED)
> > +{
> > +       const char * const usage[] = {
> > +               N_("git history [<options>]"),
> > +               NULL,
> > +       };
> > +       struct option options[] = {
> > +               OPT_END(),
> > +       };
> > +
> > +       argc = parse_options(argc, argv, prefix, options, usage, 0);
> > +       if (argc)
> > +               usagef("unrecognized argument: %s", argv[0]);
> 
> Oh, the manual is just a placeholder that you'll extend later?  That
> makes sense, but it would be less confusing if it started out with "No
> subcommands are yet supported, but will be added later", with that
> sentence removed in the next commit when you add a subcommand.

Yup. Will change.

Patrick
