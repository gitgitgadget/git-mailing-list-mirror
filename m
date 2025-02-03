Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783E1876
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738560579; cv=none; b=NUrXpIgOHhgOgKJh+KvUSp51/X5gXxF67ku0cOsAAzx04a8qgwvyBSAg3au4c+5EuuUg3J+cj/j83jDAL/unmVFvpd5fLrH6je2Lii+o5KWi2RImKUcMB1RKcVdSifK3X6w8kA/j9CX/d4DuY6zhRtpfz9+GiHCtpPAdFOmcqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738560579; c=relaxed/simple;
	bh=bYhcuUvHtkU4wH1AUX51WMSwTtbsHBvY4xCZ2y81PVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6rXv9yIVpTJrJLN8G8uKG1y48gBlBnxtKCOtAUG0M6Rf4OcM0mW9U2as3ou/d4FJfgffR9FXt02PZLRO9Tsv6bu6VLOSXxdLQGkXElc+YkQOsNxpK/+q1/5CKlDEGtC7nSXLgmjD8T1GB+SYwCafAEVEL2Ko/FTOkpH1ocK814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Htlzz/AS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3cdNdiP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Htlzz/AS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3cdNdiP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 850B625400DA;
	Mon,  3 Feb 2025 00:29:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 00:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738560574; x=1738646974; bh=Nw/6qrcO1j
	Cx7N8n3x6QY36sW0qZdR/ezkvbsdIAOhk=; b=Htlzz/ASvVPFoGlp5nR1vWIJak
	8LcecH4V01vh0W41cZuodvwkurH/psq0cjrlMHj6oaFvGFlk3ev/j9uOK8hmbxzj
	pWDQeHF7KbQAxtGJNztX2P+0PsuNR43ajnZbdWWUgCwyRtP2h0pg2p9IyUeQjvzQ
	pAGmagRnzBXl/HQHmnvKOpL3oy+GPK9kdL0v08Zeu3V9l+rjczZoK1TbWBSmvQsf
	sIO2qp26lGYSUq9Q7swzXEhyo9qSGExYHp5F7rAknrTV6mTI8Smhr89T/XLaJTZo
	PzjoG8Ykf+CHNNoLYBBYYIMf4WqJ+nH8nLu9jg+oSsMVGNYQGhY3at4bkdDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738560574; x=1738646974; bh=Nw/6qrcO1jCx7N8n3x6QY36sW0qZdR/ezkv
	bsdIAOhk=; b=j3cdNdiPN8jEM36Ty/vkjg92VNs6cMcBT0kO+S4MkxviyPHRVaF
	el1Wtc6wDo6HJn0zxOghlNyHsee88lpITN+HWXesNvVla3Kz5erQuRNuV1EIMpO4
	lnMyM1eW7fbMDES27O/C/IiH3OvStMBCp9qDvg7PLctYLcINuBPEIXEBl+tz/q9l
	u3tUBGrtzsANPCnNcQeMi6tzkGxjO6tzLkgikHO5jmksrAnQRE5xJSQmBT7zLtXi
	ctqU5mxwC9VutqvNQjmaV7kBOY1E8RduTrXo8xkOLFJusrOE1YGcbN4t+AfI2e9z
	xSknGOgd73O7U0SjqnFpr+vAi8yjIAAypQg==
X-ME-Sender: <xms:PlSgZ3r3bSuN85j72AvGmEANol1wW3bqx65kA2ifM_DEy0ZUDL_F6A>
    <xme:PlSgZxoXmIIE9dXEXUKM5-lzQ-rZJ_Dus-BSv9ZvZTT5S7_PF6dsTsQmWXmfuL7cn
    gkpbYEqcSWyM5zs-A>
X-ME-Received: <xmr:PlSgZ0OK2w6Wy4blxOgmfmUNarJcQt_3ek9WYBt7uTlns59jO3DbXrQiyLnInBhszI_C1dMex3xzHbck60fZBL9dYRWFibPL-h_LvhL7CPpHGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:PlSgZ658WWaWPNg8Czumhzkya0OFY05o2mifq5GCY1uH16maVQsPyw>
    <xmx:PlSgZ24uygqFKIgHSGTyPZwOK221muy1fjLcZzsS4mJ3xz0kbNqkog>
    <xmx:PlSgZyg1G_D0qNAGWxC9lqc_Vq5NU9OHgW4YtC0gDH0N1o8gUWQgMw>
    <xmx:PlSgZ44j1dA7SouLH-PNnZGK2WQyFRK-SvpW_SM62m1-FZaF2Uwbdg>
    <xmx:PlSgZ2Fbl7ujPD3KEutChhtklfxXbIRDyJRWhYP2sBYZ3elyVw7-37HM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 00:29:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 794dafcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 05:29:31 +0000 (UTC)
Date: Mon, 3 Feb 2025 06:29:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_REF_FORMAT
Message-ID: <Z6BUOs7k1rzGOGTN@pks.im>
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
 <20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
 <xmqqv7tu623n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7tu623n.fsf@gitster.g>

On Fri, Jan 31, 2025 at 02:38:20PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Instead of retaining the current ref format, the reinitialization tries
> > to reinitialize the repository with the different format. This action
> > fails when git-init(1) tries to write the ".git/refs/heads" stub, which
> > in the context of the reftable backend is always written as a file so
> > that we can detect clients which inadvertently try to access the repo
> > with the wrong ref format. Seems like the protection mechanism works for
> > this case, as well.
> >
> > Fix the issue by ignoring the environment variable in case the repo has
> > already been initialized with a ref storage format.
> 
> It certainly is better than corrupting the repository, but if we are
> to do this change, shouldn't we at least issue a warning to tell
> users that (a part of) their request was ignored, instead of
> silently ignoring the specified ref-format?

I don't think we should. If this was passed on the command line then
yes, we should flag this and already die indeed. But this is an
environment variable that allows you to set the default format. From my
point of view it is totally expected that this doesn't cause the format
of existing repositories to change.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  setup.c         | 4 +++-
> >  t/t0001-init.sh | 9 +++++++++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/setup.c b/setup.c
> > index 8a488f3e7c..53ffeabc5b 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2534,7 +2534,9 @@ static void repository_format_configure(struct repository_format *repo_fmt,
> >  		ref_format = ref_storage_format_by_name(env);
> >  		if (ref_format == REF_STORAGE_FORMAT_UNKNOWN)
> >  			die(_("unknown ref storage format '%s'"), env);
> > -		repo_fmt->ref_storage_format = ref_format;
> > +		if (repo_fmt->version < 0 ||
> > +		    repo_fmt->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> > +			repo_fmt->ref_storage_format = ref_format;
> 
> Perhaps something silly like this?
> 
> 		if (0 <= repo_fmt->version &&
> 		    repo_fmt->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
> 			warning("ignoring the specified ref-format");
> 		else
> 			repo_fmt->ref_storage_format = ref_format;
> 
> In the longer term, we might want to consider automatically
> migrating the ref backend (by calling into "git ref migrate"),
> but it is a good first move to stop damaging the repository.

I think keeping migrations explicit is worthwhile. Migrations are a
somewhat risky thing, so explicitly making the user ask for them is not
a bad thing. I personally wouldn't expect git-init(1) to migrate data.
After all, it is supposed to initialize stuff, not rewrite it.

This is doubly true for environment variables, where it is so extremely
easy to accidentally still have them defined. I don't think implicitly
converting every git-init(1) to do migrations would be a good idea there
as it would likely do the wrong thing in many cases.

So from my point of view we should treat the environment variables the
same as we treat "init.defaultRefFormat" and "init.defaultObjectFormat".
Those indicate defaults, but do not cause us to change the format of
existing repostiories.

Patrick
