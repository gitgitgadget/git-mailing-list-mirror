Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B222C08BF
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701439; cv=none; b=GAuJAjLsv3ZB+URv67QI/Pi0QcnIiclZ0HyVisfbpnsjr5uGxkjjI1tApnwIgc9H6jRlu8/NpCZjkTp27Qcv74OPThuOFWbk1GYTuOecKBNUQn41FyBayxtnT6nZpWxYR8Q988e7moNS3Xv46tdqcxJE2dmTLvdtBpS45zHJPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701439; c=relaxed/simple;
	bh=AFirIc23I5UDdwZgygDWxorFlpjT+KMwaA8H98cDtdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCxbmvLY9Khg546syqAVrhnWaNzbZ6MTldcpURIxxVjX56DatRGuBpXw9Qn8mkW5raKZ0+QlkAtxCHljTdYTiq6hPP3Vn9wWsv9aD33GlqSfUhZOYVVh7xXSGeMgRj6K5QMG7exSNXPc0zHmtC0lDgm5+8RDyp4UF4gJhiz9UFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bag5Neoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCWykzhB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bag5Neoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCWykzhB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C735BEC0575;
	Tue,  2 Dec 2025 13:50:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 13:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764701436;
	 x=1764787836; bh=enJxj/1rKdWv6ufPw2Xje0Bc+2q1OFfAgJGzFnMNu/o=; b=
	bag5Neoheq9cT9YiKV8Kjkhkva/R+OY3tKE7s5Phf4eLjiRlr2dwpMjuRG6yX3L1
	TanfOyjENZrCEKJOEui8szHp7e/vXzTyDF6rLoPZOnSeHwdIZVSdfarSP5ukJFwb
	fVl/sMsGlLkqcfuOXT34SgWgkmRjkxlrp/mLRSZVIyY5p9lLZYnlvTgzKYAR77R0
	1jiVYB6yclqVlEDcJzFF631Vkxqn50C1Li+MDN2IzRB5VK7q+BBVnPJG+3d3Cdw+
	LhqERBpyqU/Iv07Cwj+S79g4AhfdKyCSKzlBooIiY9paVXnp7LxeGcAw33mwWkGr
	VQhyggnJSI84V8IYJPti8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764701436; x=
	1764787836; bh=enJxj/1rKdWv6ufPw2Xje0Bc+2q1OFfAgJGzFnMNu/o=; b=c
	CWykzhBve41zH36MFuy/6ZncJE8vsznF+Lm6Vy0PTZUa+SvFyFbVJqftd3+t1rfO
	yb/ROza565LIPg/IxTXZRhpJ1ib7hr3J5HUYQQrCgv5yPrCcwGP1MNjHlz7Zya9Y
	yl2fqMzPE9Cd9Ou3SvytT6A7qLbanMTGdYNu+q6jf2jYYS+7pTH1yinAG+DwqSff
	CpFDHvkKIjB9gCdizMZSSHaNvN3m4F3/GrpvVbGsqnLBqQykDrbCV5rsUhXyvEIB
	Hl6yF12/2TQwIfWzFytbnTRhVDlRsRmgG0LvogtqAZoGVCWL8AjrcL82hwur18eP
	Kjp5JGKd7J6ivlPJs2dng==
X-ME-Sender: <xms:_DQvaUQPU5wkiUBifDHPhA7R1bmEJOgTRSCqgC-1BggaKKbPBVerQQ>
    <xme:_DQvaUV4eGwJB5MFBaiTDcwCwPQwS7ostfiDFoPdVPvqpPSuSqGHAo46LZaIr5NS7
    7IVFIGq_GaPnnF1O0W6v4aEb6ilLQxyzRiMJN9DcLgsX6ErdVup>
X-ME-Received: <xmr:_DQvaVcIE6j-zvhFWAFXuNzcyhGu4CAclavEBnifg9Qh4FONFXmWCDUPKHTDLyqCqDYWAC3Qhqg7RarhNcvMdKo0rLLZr7QLvLiUuVCUtXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvd
    efjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_DQvaYJsWdkdxDK0SM_LO5odUMbDHpFwEqjQPRZhUyIj7lvTfsSkbA>
    <xmx:_DQvaSwv6CfdaiI7jZ-EqwDUtDWKDM-gs0_DGK6LLoc8jj58UEEbBA>
    <xmx:_DQvaetTb04EyQWrgawkeDL8eyeIAVZaoGS7uzTQYQnx2r3yvcOLPA>
    <xmx:_DQvaVDZdlph8IW1_C9Pd_kOw-KmyxzfyEiG4wJpiJDf8NSNzV-Alg>
    <xmx:_DQvaVvx685zkna8m7L7wZkUwpqSdmXs2Og2kO90SyTiC1qAo_bWTuLo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:50:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e3492ff8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:50:33 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:50:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 05/11] builtin/history: implement "reword" subcommand
Message-ID: <aS805xbWBJMy4tBk@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
 <CABPp-BEm1QBP+CuSOn5FaE3XJVFg+Qbfzdp560u00ZERbNm6qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEm1QBP+CuSOn5FaE3XJVFg+Qbfzdp560u00ZERbNm6qQ@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:03:20PM -0800, Elijah Newren wrote:
> Phillip responded in good detail, but I wanted to comment on a few
> additional things...
> 
> On Mon, Oct 27, 2025 at 4:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > +static int collect_commits(struct repository *repo,
> > +                          struct commit *old_commit,
> > +                          struct commit *new_commit,
> > +                          struct strvec *out)
> > +{
> > +       struct setup_revision_opt revision_opts = {
> > +               .assume_dashdash = 1,
> > +       };
> > +       struct strvec revisions = STRVEC_INIT;
> > +       struct commit *child;
> > +       struct rev_info rev = { 0 };
> > +       int ret;
> > +
> > +       repo_init_revisions(repo, &rev, NULL);
> > +       strvec_push(&revisions, "");
> > +       strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
> > +       if (old_commit)
> > +               strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
> > +
> > +       setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
> > +       if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
> > +               ret = error(_("revision walk setup failed"));
> > +               goto out;
> > +       }
> 
> Don't we want to restrict the revision walk to descendants of
> old_commit (which can be done with `--ancestry-path`)?

We verify that both commits have direct ancestry and that there are no
merge commits in the history, so this shouldn't be needed. But indeed,
this makes the logic a bit easier to reason about.

> > +
> > +       while ((child = get_revision(&rev))) {
> > +               if (old_commit && !child->parents)
> > +                       BUG("revision walk did not find child commit");
> > +               if (child->parents && child->parents->next) {
> > +                       ret = error(_("cannot rearrange commit history with merges"));
> > +                       goto out;
> > +               }
> > +
> > +               strvec_push(out, oid_to_hex(&child->object.oid));
> > +
> > +               if (child->parents && old_commit &&
> > +                   commit_list_contains(old_commit, child->parents))
> > +                       break;
> 
> Is this last if-check basically a workaround to not providing
> --ancestry-path to the revision walk?  And won't it sometimes still
> get non-descendants of old_commit before reaching old_commit?  Or, I
> guess that's not an issue since you error out when you hit merges, but
> once replay supports merges, there's more logic that needs changing
> than one expects with the way this is coded.

Yeah, this is not currently an issue as we explicitly rule out merges.
Anyway, I'm using the flag now, so this isn't needed anymore.

> > +       }
> > +
> > +       /*
> > +        * Revisions are in newest-order-first. We have to reverse the
> > +        * array though so that we pick the oldest commits first.
> > +        */
> > +       for (size_t i = 0, j = out->nr - 1; i < j; i++, j--)
> > +               SWAP(out->v[i], out->v[j]);
> 
> Setting rev.reverse would obviate the need for this...

Yup, true. I couldn't use 'reverse' before due to the way the loop was
handled.

> > +
> > +       ret = 0;
> > +
> > +out:
> > +       strvec_clear(&revisions);
> > +       release_revisions(&rev);
> > +       reset_revision_walk();
> > +       return ret;
> > +}
> 
> You've pulled out some functions from builtin/replay, but you've
> decided to hand re-roll all the revision walking.  Is that because you
> first implemented on top of sequencer, and then transliterated to
> replay?  If so, I think we could restructure this; I think what you
> need is:
>   * Create a new commit with an altered commit message.
>   * Invoking whatever function(s) would be invoked by "git replay
> --onto ${NEW_COMMIT_ID} --ancestry-path ^${OLD_COMMIT_ID} --branches"
> (or as a first cut, even shelling out to that subprocess).
> 
> The first bullet point would be your fill_commit_message().
> 
> The second bullet point would allow you to perhaps drop your
> collect_commits(), replace_commits(), and apply_commits(), which feel
> like they are just re-implementing replay logic, and replace them with
> something like:
> 
> void replay_descendants(struct repository *repo,
>                         const struct object_id *prev_head,
>                         const struct object_id *new_head)
> {
>         struct strvec args = STRVEC_INIT;
> 
>         strvec_pushl(&args, "replay", "--onto", NULL);
>         strvec_push(&args, oid_to_hex(new_head));
>         strvec_push(&args, "--ancestry-path");
>         strvec_pushf(&args, "^%s", oid_to_hex(prev_head));
>         strvec_push(&args, "--branches");
> 
>         reset_revision_walk();
>         cmd_replay(args.nr, args.v, NULL, repo);
> }
> 
> ...although maybe it's a little ugly to invoke cmd_replay() this way
> and maybe we want to restructure that out.
> 
> But, I am really late in providing my review, so if you want to go
> forward with your existing three functions and then perhaps we
> restructure later, that's fine too.  The command is experimental,
> after all.

I guess it's a combination of the transliteration and that I couldn't
figure out how to easily do some things without shelling out. I plan on
introducing features eventually that also allow for example to reorder
commits, and I'm not clear that this is easy to do with the replay
infra.

So for now I think I'd like to retain the current infra. But I certainly
agree that we should revisit and see whether we can further refactor the
interfaces provided by "replay.c" to cover more cases without shelling
out.

> > +       head = lookup_commit_reference_by_name("HEAD");
> > +       if (!head) {
> > +               ret = error(_("could not resolve HEAD to a commit"));
> > +               goto out;
> > +       }
> > +
> > +       commit_list_append(original_commit, &from_list);
> > +       if (!repo_is_descendant_of(repo, head, from_list)) {
> > +               ret = error (_("split commit must be reachable from current HEAD commit"));
> > +               goto out;
> > +       }
> 
> Why should it be required to be reachable from HEAD?  Shouldn't it be
> possible to reword a commit from another branch?
> 
> Also, what about when a commit is reachable from both HEAD and other
> branches?  I know you started by basing on git-rebase, and git-rebase
> restricts things to just one branch, but that was perhaps its biggest
> design flaw that couldn't be backward compatibly fixed without
> creating a new command.  I'd rather avoid copying that flaw.  (Maybe
> the user needs an error by default if more than one branch is
> affected, or they need to provide an additional flag to rewrite
> multiple branches, but only rewriting one branch when more than one is
> affected is just wrong to me unless the user explicitly specifies
> that's what they want.)

For now we the commands really only care about a single branch, the case
where a commit exists on multiple branches is not considered. I'm not
really sure whether I'd call this a flaw -- I think it's as easy way to
think about the command for the user.

That being said, I certainly think that we can eventually introduce a
flag to alter the behaviour so that it considers multiple branches in
case the commit exists on more than one branch.

> > +       /* We retain authorship of the original commit. */
> > +       original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
> > +       ptr = find_commit_header(original_message, "author", &len);
> > +       if (ptr)
> > +               original_author = xmemdupz(ptr, len);
> > +       find_commit_subject(original_message, &original_body);
> > +
> > +       ret = fill_commit_message(repo, &parent_tree_oid, &original_commit_tree_oid,
> > +                                 original_body, "reworded", &final_message);
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       ret = commit_tree(final_message.buf, final_message.len, &original_commit_tree_oid,
> > +                         original_commit->parents, &rewritten_commit, original_author, NULL);
> 
> Does the use of commit_tree() instead of commit_tree_extended() mean
> you discard additional headers on the reworded commit, such as
> encoding?

Good point, let me fix this.

Patrick
