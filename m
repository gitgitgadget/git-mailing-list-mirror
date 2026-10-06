Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A900359A90
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288531; cv=none; b=FgC1vi14RoX8KNl/fJnYc4L0CXo56U2tcVaYnvvivfme60QaFn8GGAVIsMk+D4U0v686iCOyu3sH82ttdrwIs6LH8ymMlJBbSIbhUy8RVjnmRSq6kn62yAO0lMw9N7TWYKcozQZOZO+diEENy1jQbRDVElDemiKA54ctA/hM6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288531; c=relaxed/simple;
	bh=4nX12nYsjmC7OI3mb76cLQxSwrsOysZvDINIua5waZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvxzRQ1VRBWXNmX4d/N986pwMraagEudHjwcLy7xok0P6N0BunO2OZ2MOzlRSDeXRqQ4PYQVA7hQAefMIYN7xcRg9D/8pt0a2G4CcSm/8oosOiSXYG3T/mOeXD30SRWDBQqQbakg+PQLNKu98rKpSf3NO/p4HTXSXuuUAswXt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SzFS26Dd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfveIBHd; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SzFS26Dd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfveIBHd"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 22E211D00170
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:08:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 06 Oct 2026 08:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791288527; x=1791374927; bh=7VCnA9HKS/
	kJw9ZASxZQWUejYnTLD7kKnfQPyrOr3Ms=; b=SzFS26DdkMEWDztByHGeAs6LZV
	R4YXz5P7zQmiaLnSCs5UerI9BxjD70pKalrgtnj5uGw2q3mNbpJz6GAAz0emvEP3
	CcPPDJhjCeuJxtbO05WY+kIkF1AAEoTX9ve52AXjwHzcqAZ2mx5M5p9E38j7WcVg
	VCDl086QDZTPWvYWEyvXxt6ovZNOossUGiMsqjC3a4IF7ZI9LLKCoHSdEYwkCtKg
	SzoUA114NpraU4XHC7w+EYNqCjj3FjNbnUqVTZrtOZYMphA4dLJ+zBn8CXVAHIhj
	wsWVgzXyWFm1i3Mr6mHuxuV8fvICEYqVDSo7ZC4rbJyjjJ9jqCj/poKgLhgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791288527; x=1791374927; bh=7VCnA9HKS/kJw9ZASxZQWUejYnTLD7kKnfQ
	PyrOr3Ms=; b=CfveIBHduvGYzems4o9mtLP+aK8CDHlVkPKujSAokV+mcS510Zl
	aaSaqEDoCdJR1Ke6iaA871K2qh0skyffQBUqLYtr8bmbPC+kP0CLMNNlv2mBH6nh
	5Ac9LGTX8SBKRzrKzV6Sqo0kpsAEFBTBnWYiXDNSPt0coC5hIBkLsqwqSr8+sb4J
	dapTt56LdChj+1s1Q8ZbBsss180xYiZD4cgFMDySS2AiJxmRDWmyg498WJ6KC6DP
	VVj6btsNCCfWn331l3BCSIx0qh0eR3C8poSi22ae2EEnNYhWr95HemeDJryBWJnk
	WA9rjbPUGeSe/ZwE9pJu9JmpHQQpM0YuYYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791288527; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rJXcy0adZm4nmriS6mhlnxdfy2KSee8IENrWlYeL3jylQ0i
	1hz+8EEOX9BfPl1xpQ0oIjr7IPFir+RbaruPSJJLfNiqjQ20v1mIfhcQ5YNIhXqh
	+ahYNMSBluUJd7KH9UxfebHn4AyS395x7dqf7NubJwaTIGvFpW5eVt8WfeLj3wLN
	7uMfUOXinRbkghLGUlcZ+JevRrLP2zkizgBDQXS5qpS4LImW/ngenP4qypK0KgQ3
	LxHbKd3VzVaRjb3PhpQpkjYqG9zGNiYASpcL9xGhSWH+WxqG7WDs6t9g4fzE1JFC
	XqokVmD3o+0ykkGqb+QJ7Oof4Xox2HqPWDThbkw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2U1LbeGj1o0uoePWWBXJfflj0SMJOaRbez6moa8GlH8=:4nX12nYsjmC7OI3mb76cLQxSwrsOysZvDINIua5waZg=;
X-ME-Sender: <xms:z-TEammdADroH9szEqNpECqE9bP0tnw6yApP0g8E4Y0dTk0zK_Wgeg>
    <xme:z-TEalRTTRwOgG3zjLqVyByxRvWDgt142DCFcbZvuSYMVUI5e2_woU-T0KJ0-lTou
    zcUKP9FICI-ibg1dozjFUMSMyK58fh7q9_UdpPhKqQyzKZ0u9fz8g>
X-ME-Received: <xmr:z-TEaiD7t2OZFFrLwz8A9zNfykTolh2SxRS2_-PbgiV-0f9kCOw0rNZ5Us1EXodmQbdoLA>
X-ME-Proxy-Cause: dmFkZTEys02T7K1UT2ZkGHPuxNggpwC2ugiQtYm2+1OyFxBxZNMOqGGT5DLNRyteUW+yAP
    /8g8RoeAZBLsgCTyBwFU125SZuE7rJb3wI8DveKsHVucpqy7ZanRo1G2aK6OEkSsVe/erl
    LBiyNh57h6S6XV/rjWt2hcU0DUdpBT87jWG1dvYj+GYqHZiS5Q9dPP6Sw/ZurhfLXCQ/ky
    aZOb25G0uOi3RjJGNP1aBl8SBGV8HfzUPiVyQ23UOevVOoTREoM9KnWsLp6dpQxRs3AEB3
    rHk9IRSOx7c6BtiXrpFhffJvnp3Uwv6aRKMRwT2pDyrj6uLfeiwdQgXOklZSsSNpNIfOPa
    VfZwXmyKCZYdkqszXcMIPp/AiktpzMyXiNQwE71qI+IszFuFYvj5R21NgoRAciHvLoczpu
    d8W4CrabZW0REFAdk2iZvMjpN4vERp6g/4PiFrPzXk6qKCL54aUA+JF5npnJGpqGv3XreE
    6k8YmBig6z5gJ/R4AxBHA2ECoHTzOBH1g/MFDTa8GuOCKhDzxG+yrFmM8yhm/I2vy+MIVa
    4vxYFdVlApg7fXEkFo6/AZVDyBb7mpFF9Efawa0GQq37o7t3aUjgAyCraQy7ymqx8HLEzc
    N6E1h3S9JiPsyCRZH+py778iGDVfIhIdpd+E6mFQYY+a8kk6Vp/iRNPsgbKw
X-ME-Proxy: <xmx:z-TEakQwP-tuLDn-oaPjz7bKudLxLbXzp8yxMSyqQGvXkuGa_nihVw>
    <xmx:z-TEaoogVtAz-3HyOcP3Ua5J600K-OK_hjM87p6U954YcF0BgiekOQ>
    <xmx:z-TEauxXsctI0y1Q4XUkXqrrZNSuI53gf8jKX8zxT3UwlpFatCDwpg>
    <xmx:z-TEalKB4zJROwxzTpPlaDuIwHzeKisWxwfBszahN6erkYf7TLfA7g>
    <xmx:z-TEaqj55KqLVBiOh-7BaAJ7d5QlHJCml1lPtXrKFlwEtNxHuetCPAdm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:08:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d979c30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 12:08:44 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:08:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] connected: add incremental connectivity check via
 rev-list
Message-ID: <asTkyiIZvX1ztMrH@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
 <6ad528f4bb42a960910eb4fe917a3766fa55d598.1790600552.git.gitgitgadget@gmail.com>
 <asNZD7AOC6QL9q1d@pks.im>
 <CAL71e4PFpMPoSxFdnscRFiMB3ozudr64TjeQc8VKcO_M_MfJ=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4PFpMPoSxFdnscRFiMB3ozudr64TjeQc8VKcO_M_MfJ=w@mail.gmail.com>

On Tue, Oct 06, 2026 at 12:37:40PM +0200, Kristofer Karlsson wrote:
> On Mon, 5 Oct 2026 at 10:00, Patrick Steinhardt <ps@pks.im> wrote:
[snip]
> > > +The incremental mode, selected by
> > > +`transfer.connectivityCheck=incremental`, avoids traversing the
> > > +full tree walk of the boundary commits.  Instead, it verifies
> > > +each incoming commit's tree against the already-trusted trees of
> > > +its parents.
> >
> > Can we define "parents" here? Specifically, I wonder how you define
> > "parent" in the case where you perform a force push or when creating a
> > new reference. Is it the parent of the first new commit? Is it the old
> > state of the ref, if it even exists?
> 
> Parent is always defined relative to the commit we are
> currently verifying.  For example, a push may come with
> 3 commits (let's call the tip T), and then we do the
> following comparisons:
> 
>     T   vs T^1, T^2
>     T~1 vs T~1^1, T~1^2
>     T~2 vs T~2^1, T~2^2
> 
> T~2^1 and T~2^2 must already exist and be reachable and
> so we can trust them to be connected.  And since this is
> relying on memoizing already seen results, it's important
> to run the checks bottom-up (reverse topological order).

This is the part that still eludes me though. How do we know that T~2^1
and T~2^2 must already exist and be reachable?

I think I was coming in with a false expectation that we're somehow
getting rid of marking preexistingrefs as uninteresting, and that is
where my confusion comes from. Because ultimately, that does not seem to
be the case -- we still mark reference tips as uninteresting, as far as
I can see. And then we can of course easily determine whether a specific
commit is preexisting because we marked the boundary as uninteresting.

I was probably primed by my own earlier patch series in this context
that focussed on refs, and that may be the reason why I had skewed
expectations.

> > > +Incoming commits are processed with ancestors before descendants.
> > > +Once an incoming commit's tree has been verified, it is trusted
> > > +and can be used as a comparison base for later descendants.
> > > +
> > > +This gives an inductive correctness argument: every parent of the
> > > +commit currently being verified is either already connected or is
> > > +an earlier incoming commit whose tree has already been verified.
> >
> > Right. The big question to me still is how you identify
> > already-connected trees without having to read all references.
> 
> That part works just as before -- rev-list finds the
> already-connected commits implicitly with the --not --all query.
> It actually finds all the new commits, but we can deduce the
> boundary from there (and the pre-existing rev-list code also does
> that).

Yeah.

> > > diff --git a/tree-verify.c b/tree-verify.c
> > > new file mode 100644
> > > index 0000000000..5c11c2251a
> > > --- /dev/null
> > > +++ b/tree-verify.c
> > > @@ -0,0 +1,316 @@
> > [snip]
> > > +static void verify_commit_tree(struct repository *repo,
> > > +                            struct commit *commit,
> > > +                            struct verify_state *vs)
> > > +{
> > > +     struct oid_array base_trees = OID_ARRAY_INIT;
> > > +     struct commit_list *p;
> > > +
> > > +     /*
> > > +      * Parent trees are trusted: boundary parents are already
> > > +      * connected, and earlier incoming parents were verified
> > > +      * first due to the topological processing order.
> > > +      */
> >
> > I feel like I still miss where exactly you establish the trust boundary
> > between preexisting fully-connected commits and new commits.
> 
> This is the same as before -- git rev-list produces the trust
> boundary based on reachability.  I think the only new thing here
> is the inductive leap.  Once we have verified a commit just above
> the trust boundary, that itself becomes a new trust boundary.
> 
> > > +     if (commit_list_count(*commits) < nr_before)
> > > +             die(_("cycle detected in incoming commit graph"));
> >
> > I don't think we should just die, should we? That may not interact well
> > with git-receive-pack(1) and others that expect a broken connectivity
> > check to bubble up errors so that they can properly report those to the
> > client and clean up their local state.
> 
> This is one of the advantages of running within a sub-process --
> we can safely die without breaking things -- and this is in fact
> how the existing rev-list based implementation work, it will also
> die with an error message / return code that the parent process
> picks up.

Ah, right, I forgot that we're running in a separate process. I think
this will also become a bit clearer once this series is split up into
smaller individual steps.

Thanks!

Patrick
