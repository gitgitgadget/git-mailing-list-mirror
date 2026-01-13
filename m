Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F32F6925
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289484; cv=none; b=dzZVyteI9wl6yJgnEHq2vMklCJUrV0al4QhyGwDg3zwH1lfPbgbhwMTMybP+I651Ohxutph29RvjQgGgZx3zSBX5F18ZXN+SglH+aohUAs3v/2ej0TD0FWJ6/UtQvcc5wnCF+/jSUrDcl680+yA9AsM5yERLfzZrNTcyT20YM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289484; c=relaxed/simple;
	bh=ht3U83OAktcoAuwmHNFJDkavo2MUuyjqvagW0dDxan0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQInqDnO/C3voB6/CeCnzf2E3RLMekI72YNl1Bzk4hDaXg8UT7TiiPekJ+nSPBHam1z/cOFnUChl3UfNgqQKNHQAoDTLW5XATzFj1Ng7OL6v6wIWcsFH5HTppEQxWUt1PvM1i408o4jkzr0YRIDAdV3uwwhYlRQR/s1YYnKte9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UsLhre5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVfEPuJH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UsLhre5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVfEPuJH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61044140006B;
	Tue, 13 Jan 2026 02:31:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 02:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768289482;
	 x=1768375882; bh=e2r1mkIv+yUCantihfVVGxeFlw9Ao7z5ykjYM3HW7Jg=; b=
	UsLhre5e/aGZgC7dMHs1ts8+g/cX0rgxFlrxzjN+rDSNplnAQVODn/PgMNg5A8sm
	j5TU+9UC9GcqUEODuHq0cKkRJsnK1md41eEk4mM38oqRDRL8BH32pN5zb3wPZQGX
	R0rWvwjlZi+oW8jFPK/wieV+Ixa0WQM9o5EpvO5xjTy3KPyhvyC8cqWzg3fIRoEX
	/9PEeKwX5SrYvKp7JHoR88eJsAQ8foZarRsn96XItB4nUnybmqEs5HtF+o/Z5tR6
	zIo1E7yR/OKZL5uSv3S4x5Nq40utjefQqayzYYa71zDaapTqexvrAbg6k+0Q3LR+
	9qP12RWxqtUz5s8UWhjSag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768289482; x=
	1768375882; bh=e2r1mkIv+yUCantihfVVGxeFlw9Ao7z5ykjYM3HW7Jg=; b=T
	VfEPuJHzUn4SbbDt8ucTaE8PUJrCzXuXJj+bpfc38tFij7yVAqOp4WIOKBD+5CSJ
	FKvNaRBj0kB2O4V+O6+G9lyV75Wsm6xT4h6JwBkg219DbcMNcbNqZwt74UC4sQ40
	gxtVkKNcVC/y5bF+RWC5Ia5LXf4VySEWsE9ps1+mO1OGY3PputqTkk7hiysccONn
	5xK/x1I8Fw/Hh4BWGmwtRTr5sFgGBZfeUj8PRM0l3Li85gJRJ7pB7JGx4Q2b278W
	XmYb6BzEJURyIIgePnG4Iw/HaiJ782DgCrmBbBvkdkt9gs3UrbQkMjMBs+FG/dRA
	KKsGWLxEkjlp2sZhmPwcg==
X-ME-Sender: <xms:yvRlaae1-Sff6QFZPsJEYNyRvtr0rZEczMFxOhCSo0YM5FhBrShJMg>
    <xme:yvRlaYmby25GR3NuPm3Lb8kLGqY57ydCTXQJ9966j-gds4xbzvrM9hTkoO81arha7
    iRI2-ruEP4z7FgYComvFsmJtxV2AAnb-IEBXMQkfTYDvrge-pAv>
X-ME-Received: <xmr:yvRlaZaMaH3BREdK16yu6TepGjSEUlJia76UIlw2gJpIa9HHQgqsh6QIrYNVvVHUtfrVO26ChqdTdz_FqjbZTfc8ZEKFNqeQz_vCGC7Qcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhhvohhniies
    ghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yvRlaV42pUhgAwzYKMmoAuUtNjrsKqlzJqyCq8PgN9_r2dU2Kw492w>
    <xmx:yvRlabBr1yoVT-1AXH9Jma8NeQrDWSkMw6V4AYvrQ9ZwfNWCOIiF4w>
    <xmx:yvRlab8HUni4rrC-XzilQjkcVMHBELxlw-OHtR-Iq1UpASn98H8muQ>
    <xmx:yvRlaeFkYQbqxLFvV_r7HRQrNG_0-Zqb5JrV_U1ueDGBDWPsVtnBhQ>
    <xmx:yvRlaWShS2_-UciUS4aqrN3R_mJbhMbwG--VAlHu2vr8LTHoVwKH838G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 02:31:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bba932c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 07:31:18 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:31:15 +0100
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
Subject: Re: [PATCH v9 2/7] builtin/replay: move core logic into "libgit.a"
Message-ID: <aWX0wyQ_2Mn9ZOEJ@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260109-b4-pks-history-builtin-v9-2-8766101814c6@pks.im>
 <CABPp-BEo5jGBgJBkCdu_GHstsbEm4mCpKO3NWvNfcjDVC+SbLQ@mail.gmail.com>
 <aWTw4ezgeloLB0R2@pks.im>
 <CABPp-BGM4AxoedD3uUnS+12n5c0egd8pw-=cRsO64oDs+G9RkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGM4AxoedD3uUnS+12n5c0egd8pw-=cRsO64oDs+G9RkA@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:00:16PM -0800, Elijah Newren wrote:
> On Mon, Jan 12, 2026 at 5:02 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Jan 09, 2026 at 05:16:41PM -0800, Elijah Newren wrote:
> [...]
> > > It feels duplicative to have replay_result include a merge_conflict
> > > field and to have replay_revisions() return an int which signifies
> > > whether there's a conflict.  Can we remove one of the two?  (Perhaps
> > > the merge_conflict field was only a workaround to the weird ret
> > > setting from the previous patch?)
> >
> > The idea here is that we have a generic error code that tells the caller
> > that _something_ happened, whereas `struct replay_result` gives the
> > caller a bit more context around what exactly has happened. This allows
> > callers to handle merge conflicts differently from any other error and
> > makes the different failure modes a lot more explicit.
> >
> > Some context: at GitLab we actually have the use case to surface more
> > information around what commits have conflicted, so there will be a
> 
> Interesting, but doesn't answering that question presume first-class
> conflict handling?  How do you determine which commits conflict
> without that?  Or, is the first commit we process that hits a conflict
> sufficient information and you don't really need the commits that
> conflict, just one of them?  Or, do you presume that all unprocessed
> commits after the first one that conflicted would have also conflicted
> (even if it touched files that are conflict-free so far, so that
> commit would not have contributed to the conflicts)?  If this is done
> without first-class conflict handling, there may also be an assumption
> here about linear single-branch history, or else some kind of attempt
> to continue processing whichever commits don't have an ancestor that
> has conflicted, so that we can enumerate "commits [which] have
> conflicted".

Yup, knowing about the first commit that conflicts is sufficient for our
use case.

> > follow-up patch series that extends `struct replay_result` to return
> > more information about the actual conflict. I'm already planning ahead a
> > bit in this patch series.
> 
> Wait, above you said you wanted to know the "commits [which] have
> conflicted", here you seem to be suggesting you want to know about
> "the actual conflict" which might mean you only care about the first
> commit that conflicted but you want details about what conflicted
> within it.  Or is it perhaps the set of files that would have had
> conflicts across replaying the whole sequence of patches (in which
> case a bunch of the previous questions are still valid)?

I was simply being inaccurate there, we only care about the first
conflicting commit, no plural.

Thanks!

Patrick
