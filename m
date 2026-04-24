Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1933C194
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013634; cv=none; b=tZroKzpLHK+BW6l8ebBjITdo4iccdnf5h9n6Gaa1JzODF8h+KCfahcYdbpRvztv/q6uW4lVqYloHn+UefDDG64gzwgDaEw+yFFfXO4gdk0/GCCBJeko3EYm7E7hqFd/Xht0uFSggf0gsTmnW/UxEyEtiYk5Eon02M7j39VIqWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013634; c=relaxed/simple;
	bh=B1HaxiQf/SHdwZXGLr5ZLae7BznMZNtk5BiICSRqmGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWgufCgBmZQZlPTY4uteGzR2HiCGcjrXeXatIyPbUdcN1v8WKo9NUD5X5eLpVKU/Y1eMc8DNBi16byTLfnsSKEx74iKvU47SsjFc9A+2XOEhqnyd/HZmHehtr9qr+Wn9S/r/iAPH+noTvE+MWhz4mgYsgRABImphXiB2e1qSUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vbdvaXrG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mU3VL+aP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vbdvaXrG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mU3VL+aP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC3C71400064;
	Fri, 24 Apr 2026 02:53:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 24 Apr 2026 02:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777013630;
	 x=1777100030; bh=EAVHanLoT8mMSaGrJrriSchtXK2Fjt3p4bQQap5WqiE=; b=
	vbdvaXrGz2eHgCFMTjEzHRuyRIUNNH4BQwrh/18DBRz6+HxdpotDhQ0qKx8AQS0M
	/2PWZKyst5pLQH8Svl9vHuzoSZrp5bU22AaAQMKrQxAkV1DvhMiIEK6YLnwMDjk7
	9ILpCZaHZUdmWwHxqKH7CZGK4soEpHKbYqqxl3lK7WuM5S8wAkbJYZL3xbqQS8nK
	hRC3cgLwhXASpsjViXxC7aQXFDose0waldXujrKh7U9iYsdEDMzxGepZPoXCMMIJ
	Yijo8lm2EoV3lxjogefgEjsPGj0ZTdShGY6ozibhNL5uZo8CNUvVCsG59uOXrBqh
	4xaytccTIZVr7NG5SrJJgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777013630; x=
	1777100030; bh=EAVHanLoT8mMSaGrJrriSchtXK2Fjt3p4bQQap5WqiE=; b=m
	U3VL+aPIbHICgiXwEEvmDclQ3PSB62bFuxvRsNyznUxWbigYAA7QwTRYFWkgbvqW
	hbS27CGBSFR4lz2NwtYGfMBHjOPF+OiJdLbOpoHKIjn7R5kllQCDrKPnBksUOtno
	aXRxMChVI/mA5Rg3gSHXN6/YfSirLQtLBH37CGg76/ChoR5+QGl6z57MOwuBOovQ
	RAjwjrufbIto3sY8qVGkFO+pXNKoQpHO6YS0Y+h8JKLhiEvtTl09zjGbxgH15fQ5
	fQEc+T+nCr7ntCHb8fzgVPolG9nfW0UvvP9miHDa3ShZtzrTVSf7xKGRh5QzYMWs
	jWmWh+4R1TSK63QO7u1jA==
X-ME-Sender: <xms:fhPraVVTIr-szyfLM1Fo-C9DOJuJai31gbtbC40yXfmcCgV-S0USqg>
    <xme:fhPradDQqXJJTjrHafJBNCKRQi2sVQU8Jc_kwkUwShZF3oFS81hT5whcQ3Wn0Rjsf
    9v4xVkJpWr_HufM7CL9soUSZd6KeL5LLT_SQ6yQyzOC_XVX9yedKQ>
X-ME-Received: <xmr:fhPraezQJnjlZszI91t0NfxQuymftJDxkqSVOeGRDy1xKnZPPU1uv_sQkawymCcN_64vSLRzebgyhuWAdVdGN0r1iSE1sM42mCoXRT1gmn8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:fhPraSCAlTI7UW47ELf12wNsjTh49UdoWIsnhgmxPig9GaolvSkayw>
    <xmx:fhPraTbJpSJmX1ju5jDP5i3S9LKjniKWgu4Q8M639udj_kr3sF-e7A>
    <xmx:fhPraSixtg_WwojL6PhqtynSl-65mEnA0FpwRTWYq1ufKMiQnWWOQA>
    <xmx:fhPrad5npkIvm3AUVEJwxCuAj0fT9Hd-tF0FlNU-N81hkdYy1m-Wmw>
    <xmx:fhPraRc2nlKnRM2z0-UslyRyHySUxtbf8E1sajvmsjPg0pgXEfQaQbFb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 02:53:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf8f4a2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Apr 2026 06:53:48 +0000 (UTC)
Date: Fri, 24 Apr 2026 08:53:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] builtin/history: introduce "fixup" subcommand
Message-ID: <aesTeWQqMTFd4gy8@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
 <20260422-b4-pks-history-fixup-v1-2-48d4484243de@pks.im>
 <CALnO6CCBA=OSvKT8D6-YR1S=x3VOa_MpzWfK6FJWPSXq0ysMPg@mail.gmail.com>
 <aenCRKxak1l6GE3H@pks.im>
 <CALnO6CAZQxvqEqDhahFs7NcjENrU=Dg=cbFDkEeAE3+h_3R+8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAZQxvqEqDhahFs7NcjENrU=Dg=cbFDkEeAE3+h_3R+8g@mail.gmail.com>

On Thu, Apr 23, 2026 at 05:18:50PM -0400, D. Ben Knoble wrote:
> On Thu, Apr 23, 2026 at 2:55 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Wed, Apr 22, 2026 at 03:06:12PM -0400, D. Ben Knoble wrote:
> > > On Wed, Apr 22, 2026 at 6:30 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > > > index 24dc907033..3cdfc8ba02 100644
> > > > --- a/Documentation/git-history.adoc
> > > > +++ b/Documentation/git-history.adoc
> > > > @@ -53,6 +55,19 @@ COMMANDS
> > > >
> > > >  The following commands are available to rewrite history in different ways:
> > > >
> > > > +`fixup <commit>`::
> > > > +       Apply the currently staged changes to the specified commit. The staged
> > > > +       changes are incorporated into the target commit's tree via a three-way
> > > > +       merge, using HEAD's tree as the merge base, which is equivalent to
> > > > +       linkgit:git-cherry-pick[1].
> > >
> > > I'm not quite sure what, as a user of "git history fixup," I'm
> > > supposed to take from this. Does it make conflicts less likely when
> > > creating the new fixup? I imagine it doesn't help with conflicts
> > > between <commit> and HEAD that newly arise.
> > >
> > > Anyway, I'd think the mechanics are less relevant than the end-user
> > > behavior at this point in the doc, unless the equivalence with
> > > cherry-pick is supposed to tell me something about that behavior.
> >
> > There's at least two more or less obvious variants to do this:
> >
> >   - You generate the diff between HEAD and index and then try to reapply
> >     the patch on top of the target commit.
> >
> >   - You perform the three-way merge.
> >
> > The second item is definitely more robust compared to generating the
> > diff and reapplying it, and we use the exact same strategy to perform
> > cherry-picks nowadays.
> >
> > > > diff --git a/builtin/history.c b/builtin/history.c
> > > > index 549e352c74..6299f0dfa9 100644
> > > > --- a/builtin/history.c
> > > > +++ b/builtin/history.c
> > [snip]
> > > > +       /*
> > > > +        * Perform the three-way merge to reapply changes in the index onto the
> > > > +        * target commit. This is using basically the same logic as a
> > > > +        * cherry-pick, where the base commit is our HEAD, ours is the original
> > > > +        * tree and theirs is the index tree.
> > > > +        */
> > >
> > > OTOH, this explanation helps quite a bit here :)
> >
> > Hm, okay. I felt that this explanation here is even more technical. How
> > about:
> >
> >     `fixup <commit>`::
> >         Apply the currently staged changes to the specified commit. This
> >         is done by performing a three-way merge between the HEAD commit,
> >         the target commit and the tree generated from staged changes.
> >         This is using the same logic as linkgit:git-cherry-pick[1].
> >
> > Not sure that this is an improvement? Happy to hear other suggestions.
> >
> > Thanks!
> >
> > Patrick
> 
> Hm. I think what I meant is that the in-code comment makes sense to
> describe internals; for users, I'm not sure what I should get out of
> that description of fixup.
> 
> What I (think I) really care about is that it behaves a bit like `git
> rebase -i` with a "fixup" command (modulo conflicts). Especially since
> this is quite a bit more porcelain than plumbing, no?
> 
> Idk. If the 3-way merge is valuable to keep, maybe it belongs in a
> second paragraph just to push it out of the way of the primary
> description ("Apply the currently staged changes to the specified
> commit")?

Ah, that's what you're getting at! I totally misunderstood what you
wanted to say, this makes a lot more sense. How about this:

    `fixup <commit>`::
        Apply the currently staged changes to the specified commit. This
        is similar in nature to `git commit --fixup=<commit>` followed
        by `git rebase --autosquash <commit>~`. Changes are applied to
        the target commit by performing a three-way merge between the
        HEAD commit, the target commit and the tree generated from
        staged changes.

Maybe there should be a new paragraph before we start talking about the
technical details?

Thanks!

Patrick
