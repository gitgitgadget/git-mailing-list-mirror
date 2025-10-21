Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E33346AF
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047054; cv=none; b=AGE20y2otu9EcZ29f1bhjjjMEdUoL+2bxLunIsCTYS5R4DZ4G8UsVS8ir0IWYoRhQNtVNeMfiEeUbNbP6hfq85MEAHQgdBR6Oh/s4l+6YmnMl5KR+P8PoJpXXZ+T3eWuJ7WPjmDOFQCsPHgK7XF4GyZVcq53Hc3F+jLbYPSQyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047054; c=relaxed/simple;
	bh=mFeYQGOFYCPP2zl3Kt6WoZA6orHVRrbeqfSfr3GAGVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYsGr8rEN9WCOrZIrubFmVCJnHQ0F/bm37+L2QmtswDjkLksKaLoaNXMkDetSsBJEBHZ5FVA0zubLZwf4LM0M0MwNhjvZhAr4RBvETHOl7oMZYim5iMGWig9dsfU4wkj4EGvDDeEGMcX+Ouqt794Ky1BQnc2fU/43uZIzJvxe7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AL4H0bqa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XbySRrpb; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AL4H0bqa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XbySRrpb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBD2014000B7;
	Tue, 21 Oct 2025 07:44:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 07:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761047050;
	 x=1761133450; bh=FqgIGvS1YqzzjgZjE+8n3qPW18W6C3K0FiNaSqOxtq4=; b=
	AL4H0bqagKi25wve65B/U6OwKbbjuzMKksAOGG2kFfmdBlG+cupA2b5fzyUmXsFh
	c13pYx5DRIUJZDjLgICUh1qWjVVeXmPQWp1Z9a8FZhcHQLnn0UNI+DtxRAjItKh0
	Lymrs1iX4bSW2VLEWlWFZpJVxCnuLGtpgDHO+9iPu33ETaq94rwFJWuA/IfRn3hy
	YusuhUKjlwr5iHFXmtKj6RrElh8hAu/d0HMoDAP5Itxy09juE5IsCiamlo9uUdyk
	43pqoxsUnpguDj7JochEEIz/7Yv2u8O1JysrfC9rzdjuu3Sf9zEJIbGeunpcb3lf
	mt42vZkSB9V07uSMbXT5HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761047050; x=
	1761133450; bh=FqgIGvS1YqzzjgZjE+8n3qPW18W6C3K0FiNaSqOxtq4=; b=X
	bySRrpboISPgGuc+ZGV5jAHXR0BQMG0PBk11swio4wchCD2jryBn4xWqGSWeQhVt
	6teS2G9Je6iGcIbfTKTCg0KOsGZyexGnVr6VUX4iWb+4Tl8ZYWQ/Sr1gMolORTtA
	tYCig24vkfZpCLPcwfngMfRwdVMXKGMyLssF2N5du9iXKn4oofu+hNNDVYavEar9
	tAEhu6L/IqUssn4zHT7a8OUoSUeVZSKDkwUiUgp9ktTW9gqgY76kSTCuzIIhKZ3j
	OFL+L3ULC9v3yZ91ZK8B5uYg0inwG8L39vr52oLLiGczapx5xfBDreYYCq0MJPFQ
	3eCFcbXsx0V9nhIVpFJBQ==
X-ME-Sender: <xms:CnL3aLSW3POEVsc5LYP78Z2D5kpc7h9WY_pvXHn7KiN_goDb6QzxrA>
    <xme:CnL3aPXC9TxCp1GzQdH-Mdn-LUHebxmbcHQveDWuebk4UTf3iiLaXG90-fCjC66rw
    S-84lrcDs4vlxxIw5wf4e2LTgtZJStwAYl_66wT7exr9KjfENWZrA>
X-ME-Received: <xmr:CnL3aEf1xXhebinZqUgao_M0BQv5BG_JsWnKzaoEs4okjMTLogpQQl0wIzsa11lWuqaxNQu-Rm7YCBKMEVH9cUikrO8-KEnw03WXd88vcegIdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhm
    rghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:CnL3aLLupwMWceRt5WgAIEY-0gPLvwhdY1eSBM7-1LC7qjyCDraZ6w>
    <xmx:CnL3aJy9jFi_GvLy6tUernItRwFaD-9y9wSFzNlzMSHJjS8hE6UqVQ>
    <xmx:CnL3aJuZuEtO_zOI__B4lphwhNWVojS07jhyr3mtcSC4MNUSsvcHtA>
    <xmx:CnL3aEClheV_umD2RHLBBKhYmP0xjJO9ez9dMw18vUNBw7dNmLSqVQ>
    <xmx:CnL3aIv7tBRbOspA90pUVzrVhFc4XkXdpPsrAZdRp9E2kH1y9NQdPlju>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 07:44:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 806992fa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 11:44:08 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:44:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 12/12] builtin/history: implement "split" subcommand
Message-ID: <aPdyBpuLfuYOLe7q@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-12-8e61ddb86317@pks.im>
 <CAOLa=ZTnsHxK2+rRsAErY_zc1Rg5WNrmcDBiPgDk38zb9TNfkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLa=ZTnsHxK2+rRsAErY_zc1Rg5WNrmcDBiPgDk38zb9TNfkQ@mail.gmail.com>

On Tue, Oct 14, 2025 at 09:38:51AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index b55babe206..83d675afea 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -40,6 +41,26 @@ rewrite history in different ways:
> >  	provided, then this command will spawn an editor with the current
> >  	message of that commit.
> >
> > +`split [--message=<message>] <commit> [--] [<pathspec>...]`::
> > +	Interactively split up <commit> into two commits by choosing
> > +	hunks introduced by it that will be moved into the new split-out
> > +	commit. These hunks will then be written into a new commit that
> > +	becomes the parent of the previous commit. The original commit
> > +	stays intact, except that its parent will be the newly split-out
> > +	commit.
> >
> 
> So in essence we do this:
> 
>   Before split:
>   P1 ── C0 ── C1 ── ... ── CN
>         └─(target)         └─(HEAD)
> 
>   After split:
>   P1 ── S0 ── C0' ── C1 ── ...... ── CN
>         │     └─(modified original)  └─(HEAD)
>         └─(split-out hunks)
> 
> I do wonder if S0 should contain the existing message and the new
> message should go to C0'. So perhaps more like
> 
>   After split:
>   P1 ── C0' ── S0 ── C1 ── ..... ── CN
>         │      └─(split-out hunks)  └─(HEAD)
>         └─(modified original)
> 
> Mostly because when you say split, I would assume we keep the original
> as is and add on top of it. I don't really have a strong argument though
> :)

Yeah, this has already caused some discussion beforehand. I guess you
can argue either way, and the suggestion from others was to simply allow
the user to edit both commit messages.

I don't at all mind going into that direction, but I wonder how to call
the "--message" switch in that case. We could of course just call these
"--first-message" and "--second-message", but that feels somewhat
awkward.

Also, I already have it in my mind that it would be cool to extend this
command so that you can split into arbitrary many commits. That is,
after you have split out the first commit we simply go back into
interactive mode to create a second commit tree. Rinse and repeat until
we have no chunks left anymore. But if we had such a mode though, then
numbered parameters don't make much sense anymore.

An alternative could be to just accept multiple "-m" arguments, and we
then apply the messages to the respective commits? Dunno.

> > +	const char *commit_message = NULL;
> > +	struct option options[] = {
> > +		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
> > +		OPT_END(),
> > +	};
> > +	struct oidmap rewritten_commits = OIDMAP_INIT;
> > +	struct commit *original_commit, *parent, *head;
> > +	struct strvec commits = STRVEC_INIT;
> > +	struct commit_list *list = NULL;
> > +	struct object_id split_commits[2];
> > +	struct pathspec pathspec = { 0 };
> > +	int ret;
> > +
> > +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> > +	if (argc < 1) {
> > +		ret = error(_("command expects a revision"));
> > +		goto out;
> > +	}
> > +	repo_config(repo, git_default_config, NULL);
> > +
> > +	original_commit = lookup_commit_reference_by_name(argv[0]);
> > +	if (!original_commit) {
> > +		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
> > +		goto out;
> > +	}
> > +
> > +	if (original_commit->parents && original_commit->parents->next) {
> > +		ret = error(_("commit to be split must not be a merge commit"));
> > +		goto out;
> > +	}
> 
> Do we need this? Since we also check for merges in `collect_commits()` below.

Yeah, we don't indeed.

> > +	parent = original_commit->parents ? original_commit->parents->item : NULL;
> > +	if (parent && repo_parse_commit(repo, parent)) {
> > +		ret = error(_("unable to parse commit %s"),
> > +			    oid_to_hex(&parent->object.oid));
> > +		goto out;
> > +	}
> > +
> > +	head = lookup_commit_reference_by_name("HEAD");
> > +	if (!head) {
> > +		ret = error(_("could not resolve HEAD to a commit"));
> > +		goto out;
> > +	}
> > +
> > +	commit_list_append(original_commit, &list);
> > +	if (!repo_is_descendant_of(repo, original_commit, list)) {
> > +		ret = error (_("split commit must be reachable from current HEAD commit"));
> 
> s/error /error/
> 
> > +		goto out;
> > +	}
> > +
> 
> This is also checked within collect_commits(), no?

The problem is rather that the check is wrong: we check whether the
original commit is a descendent of itself, which is always true. What we
actually want to check though is whether HEAD is a descendant of the
original commit.

The check in `collect_commits()` is slightly different, as we verify
that the range provided to us is actually the same. But that check
shouldn't ever hit if the above check actually triggers.

I'll fix the check here and drop the one in `collect_commits()`.

Patrick
