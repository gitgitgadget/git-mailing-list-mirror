Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FF3EFFC5
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187803; cv=none; b=g+RyMJ+VEg/y8p7lkpfP1mIH7FXk/onA73UILU5i5pzKEfeBd1xV2RbWDlqvXHqv/K90OOWGKlVxJh9Z4lNdpjoHNFXgf9YEhFqoM6I6WDU8QggJPZyO/fzdun128TLO1s+eWkVuTw48A0ooaRUJXqZDklrz7D8MZLKNcVHeMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187803; c=relaxed/simple;
	bh=r9DNZKws51lw58ZDknRL1rM3YofHKxQTrm7skSG/Jvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFXooCBWjbUDPWVmeoCPiJNmU0+Spf9i10LO0PpKbINVLPlZT2HMmnoLDwim5rqDtCIiEDfdltcYJ6KUsXPIsc1LqfGypMf3YL0dAaFfjl0pcwQ1XVMONAjHatnXXECyg8FPvyHOqEUMKHB/499+cIBOpDSadcy8lMf9vlxiKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=afpBjYUO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CX8SA70V; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="afpBjYUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CX8SA70V"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A64997A0149;
	Wed, 23 Sep 2026 14:23:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Sep 2026 14:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790187800;
	 x=1790274200; bh=OcR4iELaA7qekMeGfs5fCzCQSgV8GwZFmaJS+3/L9pI=; b=
	afpBjYUOFDcJ+jMcouxnZSccSYJoJx1r3IsJp5CXa6BhfnZjgo9yU/sM/Me+9jCG
	hYr6jLbnP1FfmgNNjVTeAdynDzqlibko1/6B4ZRb41iYJl3gyH1DYwYzgs87JcfK
	FJeKWVuZT3bYbMFMaBBM66XYuxih9ltRkbucQ30CRgSnbhZZBXcOx9eVgyQ5H/0v
	tZ8+wycFrf3gtiFni4EivO2+7IRIIGSLugULiWWiDRMx5D3XfC+/V3Q4uS2366L1
	gOP7y1pjjZBBt+N9y3FfDSv3JWjpzoy49PbuDiuO7OZ1US2bGQU9CD3hpdi8avIs
	23x2aA7qCFsUQeWpDaG7/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790187800; x=
	1790274200; bh=OcR4iELaA7qekMeGfs5fCzCQSgV8GwZFmaJS+3/L9pI=; b=C
	X8SA70VWJy75N8q53qpJx/af7hkfKYAvXeF1RRdneqftej0chsXQky1TyA23l3j9
	KqElwunCqJtRFs1qaNxPMg3L2Oj3b6HZtOwOxVFk2oAan9xQE3jzPyskouk2i4LS
	DXQiP8DlD3DcrVFyZyAP2pfH1h4yyKGSB/Q8XoD7kDaG5Cv/slHvJTIaUMDIlEpV
	JRFF/h8wcnD0UpF2DoQVb0wbLUN4UGXcBVZg3xvrOanu2i2uXW3MGcfZMUhfWZnG
	kQiI4w4Yhxg2GW22AMH/3Tg4RsfRyvsR+RH+UWO0/UOzd9rFy4AhRVEGuoTYLDpt
	oInVCs+BCn+CeoUsFjA+Q==
X-ME-Sender: <xms:GBm0aj6-8lKajJ76NDPQW0xJkqe_cYb4_7_O_ntyuJ4vcfhha1A_rA>
    <xme:GBm0agWsQD_lPIZR23WzpB1B2VMVf-9u4cQdJuzUy6SzbeBL_JELrSLE9wUqYo-Hb
    yYe4ILz_rvg69N9H-um6AiX-V__RnDn8JhV0htcU-BbtIkxBDRt3hX->
X-ME-Received: <xmr:GBm0an3ELyjzvUaBbQOZWpsiztzNVlzTwTsFJFH-Vx20YfFkbexUFw>
X-ME-Proxy-Cause: dmFkZTGMRBDl/xrXoHnLbEKpUiNXpn8qR34jfS94H2JRRehAxSK/LoGmGslcoJtp/rwq65
    QrrQaS9ePi6AIp1DGqKzjQKxWXSq1jUGT5KIqbgYNZvhjht+DmRhOVjg5YctnloKPRLbjL
    9wEMwFkNJm65zuAVpSksvAQOAB6b7eO1S0iS7k//4LT6R+JSoK7TTNB4SjoVU2QwEHBXUg
    0uVDn6hzdBK2hFb/twKlyfoG6/Fq7vHeTeL1nM9xJPFwNQsAgA84aH7JZN3QoT9lhcmJrB
    lEGZ+qscciX15bXvzpLjYlOuUiqNgtJRtDagxgboN9QrNdC4CzFFlITQY97ar5dB+ZseOs
    g6E674yhGCW6Vh0dUYqnWhzttiexuG8ANIXiuZLTs5FQ8iRQCfpPvRxuaKokasLfLu7xd7
    Uf0Eu/2atEtnx+niMUO0htwMOzbCZznjuxB3j3hObzMOGE3KiJLnzhC2L91gdAIyMCyje5
    NNcIUWiQ6gzEuHZWFNrXTQ5wW9ER8+u/beoC1R59+r2WuWRmzsfiBsR8s2K+0j/AqDy5qo
    XwlUjwnBO0z05kQfIzNriaXOnxgNXPA9/qBmmr+74GuIFCrr5uUkmlcyYMxsomGn10NRTC
    y7hOTLcdAqpMbN4RlN2orPb/IwcdJMkBJcfhwdQY16mMqp3xLb9dc3M1Xgqw
X-ME-Proxy: <xmx:GBm0at165XjM3dIMsjlqrHnWaCRuId0uoNaCMieb7y2Kyb4LmSzgMw>
    <xmx:GBm0aq9ZNfrDoQZfc_hyppVR1cwL9nmfK6y9W_nvyBvvXTgDsi8nXQ>
    <xmx:GBm0aq3qL_F1nwrtNnKrlge5nO-4vHsdpc0uWBk1vHhGKskJGBF5WQ>
    <xmx:GBm0an9jjYmgyfmYKNb6x3eAnCOGbsUFHg_F8BI-1lJay8ne6jpuww>
    <xmx:GBm0aoWuVk_uaFGgdFbHD9SzKYRxoQdFLZk4dCmhJbcBSBQZqTQ9A6C6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 14:23:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 177c2d4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 18:23:16 +0000 (UTC)
Date: Wed, 23 Sep 2026 20:23:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
Message-ID: <arQZDXxf0139omx5@pks.im>
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
 <CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>

On Wed, Sep 23, 2026 at 10:48:14AM -0700, Elijah Newren wrote:
> Hi Patrick,
> 
> On Wed, Sep 23, 2026 at 6:16 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > In 6257588252 (commit: refuse to amend during conflict resolution,
> > 2026-09-01), we have introduced logic to git-commit(1) that makes it
> > refuse creating a commit in some cases. This was done to remove a set of
> > common foot guns.
> >
> > One of these foot guns is when the user is performing an interactive
> > rebase that stops at a conflict. Most of the time when we stop at a
> > specific commit we want the user to amend the HEAD commit, so they have
> > been trained to use `git commit --amend`. But when there's a conflict,
> > they are instead supposed to commit it directly without amending the
> > HEAD commit. So to remove that common pit fall, git-commit(1) now
> > refuses amending in that situation.
> 
> Are they supposed to commit it directly?  The conflict advice tells
> them to stage the resolution and run "git rebase --continue".  In
> fact, there appear to be a number of problems with using a plain "git
> commit"; more on that below.

I dunno. All I can say is that I've always been committing directly
myself. So it's certainly a workflow that used to work alright. And...

> > The logic that detects this scenario checks whether the file
> > "rebase-merge/stopped-sha" exists, while "rebase-merge/amend" doesn't.
> > And this is exactly the case when git-rebase(1) has stopped at such a
> > conflicting commit.
> >
> > But there's one problem here: this state persists even after the user
> > has already committed the resolved conflict, and consequently they still
> 
> After reading ahead, should this be "...has already committed the
> resolved conflict via a plain 'git commit'"?  Resolving it via "git
> rebase --continue" doesn't have this problem.

... honestly I don't think I even had it in my mind that you can just
continue the rebase and that does everything for you. Thing is, I also
like to verify the result of the merge, and committing myself allows me
to do that immediately.

[snip]
> > I'm not particularly happy with the proposed fix -- it feels quite fishy
> > to use the existence of MERGE_MSG as a proxy for whether or not the user
> > has already committed the resolved conflict. I couldn't come up with a
> > better proxy though, so if you have one please let me know.
> 
> Yeah, I'm also a bit worried about using MERGE_MSG here.  In particular,
> 
>     git reset
> 
> removes MERGE_MSG without moving HEAD.  With this patch, a subsequent
> 
>     git commit --amend -a
> 
> is therefore allowed while the conflict resolution is still
> uncommitted, bringing back the foot-gun that 6257588252 was trying to
> prevent.
> 
> For the short-term 2.56, we could either revert that series (it's a
> long-standing bug after all) and try again after the release.
> Alternatively, we could record HEAD when the sequencer stops, perhaps
> in rebase-merge/stopped-head, and then reject the amend while HEAD
> still equals stopped-head and allow it once a plain commit has
> advanced HEAD.  stopped-sha would remain until rebase --continue,
> since it is needed for the rewritten-commit mapping and fixup/squash
> bookkeeping.
> 
> Longer term, I wonder whether plain "git commit" should be rejected
> while resolving conflicts for rebase, am, cherry-pick, and revert,
> with users directed to the corresponding "--continue" command.  Plain
> commit has a surprising collection of behaviors:
> 
>   * During am or an apply-backend rebase, it ignores final-commit and
> author-script, losing the original message, author, and author date.
> The corresponding --continue will report "No changes - did you forget
> to use 'git add'?" even though the user already added and committed
> the resolution.  Amid the generic recovery advice, the user must infer
> that the corresponding "--skip" is now needed to bypass the patch that
> their manual commit already handled.

True, that's an issue I've been hitting a bunch of times.

>   * During a merge-backend rebase, it reads MERGE_MSG, so the message
> survives, but the original author and author date do not.
> 
>   * It may bypass sequencer options such as explicit signing and
> date-handling options.
> 
>   * --abort behavior then varies by operation: rebase returns to the
> original commit (orig-head), `am` leaves you at the manual commit, and
> cherry-pick and revert refuse to rewind because HEAD moved.
> 
> Having the operation own both the commit and its state transition
> seems much easier to reason about.  I would leave "git merge" as an
> exception, given the very long-standing "resolve, add, commit"
> workflow, but I think plain "git commit" should eventually be
> disallowed as a way to resolve conflicts for other commands.

It certainly is much easier to reason about, true. But it's definitely
a breaking change for something that mostly works alright and that does
have some benefits over the "sanctioned" way of doing this via
git-rebase(1).

> That's post-2.56 work.  For now I think either reverting (and trying
> again after the release), or recording HEAD in stopped-head seems
> preferable to relying on MERGE_MSG.
> 
> Thoughts?

I think reverting is probably the safest change for now, and we can then
discuss how to properly handle this. I'm not a fan myself of refusing
the commit outright as that would break my own workflow. And I'd assume
that I'm probably not the only person using that workflow, also because
it does let you inspect the result before you move on.

It makes me wonder whether we can instead fix git-commit(1) itself to
maybe not reset authorship information. But that's probably a much
harder change to do, and probably it would make the mess that we have
with the ".git/rebase-merge" state directory even bigger.

Thanks!

Patrick
