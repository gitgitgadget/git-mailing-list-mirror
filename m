Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC114BF92
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223019; cv=none; b=IcI6CSYcYUsA18lkKWC3LMEhbxR6bVXyGPOPIT912J3/Hu6IdhWRtVjDzln0qcF3RLI7nAjgZDho6verd8IO8ocQ3ZZyDwOoK4PWqPkmrCtg/MA3L+9fCdxVQ22A1qUv4Z3R20Ve893SyOmclcGBQHLbxACN0KdEF8A8GzO8Cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223019; c=relaxed/simple;
	bh=LpRp3FZF9ciaYptp5yyfD7JLcKw04qt+ews3S1VgYwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLdBaFlIKrP4iExI7OTXVAgE4J6VXHZWYyTWYbmt0w3i9NPfcN/6XJEkEXtCThVXDRstpTLsMK7WsJQacm0w4m12njgf8lh71r99YRq9tOkX5L6HQKQ/+zy414ZOR/9JoO/wu1iwbBrRx2nkLYDyuzcZnLNMbfnESxiRDsb4Vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CWKfK65I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KE1P1mvJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CWKfK65I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KE1P1mvJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E0D2EC0076;
	Mon, 12 Jan 2026 08:03:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 08:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768223017;
	 x=1768309417; bh=6p1ow4JzEPWRyPG/IhxHTD1OgAE18I5JfUbD3RcZEl4=; b=
	CWKfK65IZNyaDVJ5OhcWWurpu6LooW59QjbMKUq39J0IJjCd1/F0VpVki84oiLWR
	tQDmLw6wi+dsJCX/AMDuZEJUS+A/Vh5OQhbo5g+G30Z5a0kpuLjfhHZIxp2kMWJK
	VeLa67PZ+Sr6FDg/Bxwz/nQQ17wEBlygW2nurFjVxPmla1n68bgM2Nm/BeTgTJL4
	X7aF4Lxyo2N+/4WeDeHc1h33TqdwnU7fkk6m+rXbFq+m5gRcmls6KYwhxJhfNtVq
	0P/ozBnMF88wi9H/In/WSGwBQysZSvqtxHicJVm0jL1bjO8JLZfNuTXoDHL618A3
	MuuzF8wDNTsv+MM0ggy3IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768223017; x=
	1768309417; bh=6p1ow4JzEPWRyPG/IhxHTD1OgAE18I5JfUbD3RcZEl4=; b=K
	E1P1mvJBnNwBWBMAfXejB+Ryszc1Le6o1aUf/FEf295gexivsOwIYTnokb9skrYJ
	+HrsxKFunBVIW1Jn7LHGjxOC5bux2ZSzAC6InXYs4EsTupR3IVTxgn2LkqJ3H2Ef
	NUGMY/1BJ+cc4UkZvQ092jsZ2eW3r3xmdudZKX3/uu7cyqwAEkuaqw5ZcaoGhjDD
	JzQE5X7NQzWh8SRgg+8gEUy5qeB3lZGNEzRCPanHRJg0PXTR685rpo8DBZ33SD1p
	FJ10d4rumOH18mUxv85SiYHWrrj9H2hhrkDoZNAY9+Lf2PivcIw0UwoqzDMiO2L7
	8owXNRuK2rBgWSX9o8sZg==
X-ME-Sender: <xms:KfFkadsy_DDqbdfStUANIIa08AqebKaRTVBCY4A1zW7gwcvPZsXrNQ>
    <xme:KfFkaSTUJ_o3-_ppVMilKt-58oGIHycW3P3mEGBnCaBduie6iCuEfqPLmngpSNjKR
    9mjplCU5lgpI7NVT7lIr7FyLQSr3lrA08FjIyvnkIcd1nHjlt3VDQ>
X-ME-Received: <xmr:KfFkacLkDt0eMEo3n7cOVWTp6Xj-hCayX_81VchnwdveFBhoA_9VSHR9HLe4ux5RykG9P633DmQpzNtNarKiQ8VLAOQcBj7ITBqHHCIpVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhhvohhniiesgh
    hmrghilhdrtghomhdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgrshdr
    uggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjnhdrrghvihhl
    rgesfhhrvggvrdhfrhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhrgh
    grnhhovhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KfFkadvvY9IJoGL9Q9n68pnvZh8jItJFC6M7WcD1zlys1O7eDvq7Xg>
    <xmx:KfFkab94eqxzOngXd9iK-avxqZ8L55At6twdOyqNQV3URkzIgXyUtA>
    <xmx:KfFkaf3Us5WD6eJt8_Ni5UAslMoVivcpsPv-f6O2Pk-18UO35XlmFQ>
    <xmx:KfFkaYgLwte9gfwf21UvryyKWD8TEKo2JWXU01ut-kaVr1sLmVD_iw>
    <xmx:KfFkaevBQyK2mfTaT39P5S_ph1Ep_EQCezoJLmjcki0X1UDlJTyfdinC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:03:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce64fdf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:03:34 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:03:31 +0100
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
Subject: Re: [PATCH v8 7/7] builtin/history: implement "reword" subcommand
Message-ID: <aWTxI-j__VGkPrVb@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
 <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
 <CABPp-BHFwvg5A295kXkc_axoibNhGDn4ZUkm0uE1u+358xSZzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHFwvg5A295kXkc_axoibNhGDn4ZUkm0uE1u+358xSZzw@mail.gmail.com>

On Fri, Jan 09, 2026 at 05:20:04PM -0800, Elijah Newren wrote:
> On Wed, Jan 7, 2026 at 2:10 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 5a9d931efc..4eea317e5c 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
> >  SYNOPSIS
> >  --------
> >  [synopsis]
> > -git history [<options>]
> > +git history reword <commit> [--ref-action=(branches|head|print)]
> >
> >  DESCRIPTION
> >  -----------
> > @@ -32,8 +32,9 @@ Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
> >  your commit history that is simpler to use compared to linkgit:git-rebase[1] in
> >  general.
> >
> > -If you want to reapply a range of commits onto a different base, or interactive
> > -rebases if you want to edit a range of commits.
> > +Use linkgit:git-rebase[1] if you want to reapply a range of commits onto a
> > +different base, or interactive rebases if you want to edit a range of commits
> > +at once.
> 
> Ah, was the previous sentence here from the former patch just a bad
> splitting when you were rewriting?

Dunno what happened here, to be honest.

> >  LIMITATIONS
> >  -----------
> > @@ -51,6 +52,22 @@ COMMANDS
> >
> >  Several commands are available to rewrite history in different ways:
> >
> > +`reword <commit>`::
> > +       Rewrite the commit message of the specified commit. All the other
> > +       details of this commit remain unchanged. This command will spawn an
> > +       editor with the current message of that commit.
> 
> One isn't exactly "several"; I know you'll add more later, but since
> this series ends here, should that word be changed?

We can just say "The following commands", there is no need to be
specific.

> > +
> > +OPTIONS
> > +-------
> > +
> > +`--ref-action=(branches|head|print)`::
> > +       Control which references will be updated by the command, if any. With
> > +       `branches`, all local branches that point to commits which are
> > +       decendants of the original commit will be rewritten. With `head`, only
> 
> decendants -> descendants .   Or maybe double down on the typo and
> extend it a bit into either 'decedent' or 'decadent'.  That could be
> fun.

Thanks, this made me laugh. :)

> > diff --git a/builtin/history.c b/builtin/history.c
> > index f6fe32610b..59011ea517 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -1,22 +1,404 @@
[snip]
> > +static int commit_tree_with_edited_message(struct repository *repo,
> > +                                          const char *action,
> > +                                          struct commit *original,
> > +                                          struct commit **out)
> > +{
> > +       const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
> > +       const char *original_message, *original_body, *ptr;
> > +       struct commit_extra_header *original_extra_headers = NULL;
> > +       struct strbuf commit_message = STRBUF_INIT;
> > +       struct object_id rewritten_commit_oid;
> > +       struct object_id original_tree_oid;
> > +       struct object_id parent_tree_oid;
> > +       char *original_author = NULL;
> > +       struct commit *parent;
> > +       size_t len;
> > +       int ret;
> > +
> > +       original_tree_oid = repo_get_commit_tree(repo, original)->object.oid;
> > +
> > +       parent = original->parents ? original->parents->item : NULL;
> > +       if (parent) {
> > +               if (repo_parse_commit(repo, parent)) {
> > +                       ret = error(_("unable to parse parent commit %s"),
> > +                                   oid_to_hex(&parent->object.oid));
> > +                       goto out;
> > +               }
> > +
> > +               parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
> > +       } else {
> > +               oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> > +       }
> > +
> > +       /* We retain authorship of the original commit. */
> > +       original_message = repo_logmsg_reencode(repo, original, NULL, NULL);
> > +       ptr = find_commit_header(original_message, "author", &len);
> > +       if (ptr)
> > +               original_author = xmemdupz(ptr, len);
> > +       find_commit_subject(original_message, &original_body);
> > +
> > +       ret = fill_commit_message(repo, &parent_tree_oid, &original_tree_oid,
> > +                                 original_body, action, &commit_message);
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       original_extra_headers = read_commit_extra_headers(original, exclude_gpgsig);
> 
> Does this grab encoding?  If so, should it be excluded as well given
> the repo_logmsg_reencode() call?

Hm, good question indeed. I think that makes sense.

[snip]
> > +       } else {
> > +               strvec_push(&args, "--branches");
> > +       }
> > +
> > +       setup_revisions_from_strvec(&args, &revs, NULL);
> > +       if (revs.nr)
> > +               BUG("revisions were set up with invalid argument '%s'", args.v[0]);
> > +
> > +       opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
> > +
> > +       ret = replay_revisions(repo, &revs, &opts, &updates);
> > +       if (ret)
> > +               goto out;
> > +
> > +       switch (action) {
> > +       case REF_ACTION_DEFAULT:
> > +       case REF_ACTION_BRANCHES:
> > +               transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
> > +               if (!transaction) {
> > +                       ret = error(_("failed to begin ref transaction: %s"), err.buf);
> > +                       goto out;
> > +               }
> > +
> > +               for (size_t i = 0; i < updates.nr; i++) {
> > +                       ret = ref_transaction_update(transaction,
> > +                                                    updates.items[i].refname,
> > +                                                    &updates.items[i].new_oid,
> > +                                                    &updates.items[i].old_oid,
> > +                                                    NULL, NULL, 0, reflog_msg, &err);
> > +                       if (ret) {
> > +                               ret = error(_("failed to update ref '%s': %s"),
> > +                                           updates.items[i].refname, err.buf);
> > +                               goto out;
> > +                       }
> > +               }
> > +
> > +               /*
> > +                * `replay_revisions()` only updates references that are
> > +                * ancestors of `rewritten`, so we need to manually
> > +                * handle updating references that point to `original`.
> > +                */
> 
> This is a good catch; I was wondering if there was a way to put this
> logic into replay_revisions() so that other callers need not duplicate
> it, but since it just takes the revisions to walk over and that list
> is empty, it'd somehow need to know about original->object.oid; it
> doesn't have that info.  Hmmm...

Yeah, exactly. I was also thinking about whether this can be part of
git-replay(1), but ultimately it didn't really seem to make sense. After
all this is about a commit that we're _not_ replaying at all, but that
we have manually edited.

> > diff --git a/replay.c b/replay.c
> > index 8c2f2d3710..5203f9db4c 100644
> > --- a/replay.c
> > +++ b/replay.c
> > @@ -254,7 +254,9 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
> >         struct commit *commit;
> >         struct commit *onto = NULL;
> >         struct merge_options merge_opt;
> > -       struct merge_result result;
> > +       struct merge_result result = {
> > +               .clean = 1,
> > +       };
> 
> Wait, what?  Why is this being initialized this way?
> 
> Same as I said over in
> https://lore.kernel.org/git/CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com/,
> why is this change here?  Was this due to hitting an empty range?

Yeah, exactly.

> Actually, while supporting empty ranges didn't make sense back when I
> mentioned it to Siddharth (because users always specified the ranges),
> I think it actually does make sense now that ranges are implicit.
> Someone could use "git history reword HEAD" (even if "git commit
> --amend" already exists), and that'd result in an empty range.  So, I
> think the change makes sense now, but I think this particular change
> really ought to be documented and motivated in a separate commit
> message rather than lumped in with the other changes in this commit.

That's fair, will do.

Thanks!

Patrick
