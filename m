Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94A14EC73
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699570; cv=none; b=Zwn9FBuw1jzRDrfdHfmriJHvrHxX0vmOxD/DRo6nParD6o39SFoclHJM1qZulB5LOb5bEjpFLqXEw4lstkn4QzYJGyIiLB9ehejiDB4YPyhgNFprg2aFBVBi9tXtfodjVGsS7By87aZzpwAQrmUBQzDfdkVKlidej2TXgLY/Lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699570; c=relaxed/simple;
	bh=yJEIcXv5XLrjDe80rXDCLnZSjQtx3ckaSYgkQYQaJIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWnASDsNa9/OEeE5IljdoQZG0zhyuaZ85cFq7KVVBtzI2B/d9PeBFXl0aduY0i7FER7sSXcOVwV249xYN3BaPKgaFGCpz3OwgvPX8cTwTMk7/Fz21Q+iMxppoop1+ppoln5bA8NMNr9Ap3oe3yn90kZO7hWXaKjI0GYBo8TIkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YwYM/ifA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIIImtqd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YwYM/ifA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIIImtqd"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8B3A4138FF8A;
	Thu, 15 Aug 2024 01:26:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 15 Aug 2024 01:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723699566; x=1723785966; bh=OwaeHXMVsc
	TvQZ6TSnAumsUwbQJEOzKvADReg9M2rnM=; b=YwYM/ifALzh110ELi2jEOect/v
	fM1c7K33U+agMvqr5ei5gAzNIZsamn7hs6oVsOo1ZDOKsfqUnXiH57VT7t9Yd2hb
	MwWcR+y1hJbjuGtJ/g3ZQDyA8NTJ6Hg9Q/C0tIuXJUROh0I2/GS50Rd99o6idfph
	u1ZSBAVe15Lcfg41dXwj/bRCOWxG7z8ZkKyXtJu0Gm2qdlR4yVqyf4DiPJQ1krDD
	Sfg34Kicc5j2J9a4f6/HHCkHn/Ouz53j5ItkWTtf0aE3DM7bxn6myJwmiy2TqD0a
	VTO0tmE4jmNtQ+Oty2TQ5ePtLD4zHfNqsauWec938QEVIKBPK84gBM2kMCHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723699566; x=1723785966; bh=OwaeHXMVscTvQZ6TSnAumsUwbQJE
	OzKvADReg9M2rnM=; b=kIIImtqdK1wJClxxjyrBiVtCEnVltkQGjgmCPP1ffkJP
	rywKh4Gi58Msm3El3ntJU3L2tZcqIt/IgBjehuXavlnNRzBOHzrr9YyZqweaXlRJ
	yhSwqKmVRWTyRZcdnBy0agbSEFHehOTIlxWocSlZan46sC4WEG4I+r4/hpq7hnQP
	rw8HES0es/2C/wKQLBPR6+D6ZSCQ4DadQ+lY1DcnPXiIpSIoBGPRobFHyfKmUxPP
	1Y9wxhwNbpLcHgInik4+NqQSgNQZL9+9JB7CAxIdxUEajbS/SO3hxWpQTXmE9y02
	2M05Br6n8J1mcFCYOCN8/J9pOxOdV1sxjq7S7TzsRg==
X-ME-Sender: <xms:bpG9ZuociHdvAjaJ8QbWjISAOGsOeyHA384HY8v4CliL0nGn-N7zKQ>
    <xme:bpG9ZsqnnApr9AiRG8Ywvu4bj0dfje0HabHlEc_mhwpOTD1VyirH7b3oKyYhUK8sv
    JT1klVdORyZzBfB0w>
X-ME-Received: <xmr:bpG9ZjNFCxWmmZsWIZSSQtdXlG7lD0y7P8Xi7OgihcFQxC0JSeIhGrJF1XPzjGEIkIr9kBIeE6IwsV6iKp819hcOSMZj7wtu4ZWGWsnbdCguXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:bpG9Zt60319cpdkc0TqgAjPJxRoLLsrpyzI6ct7BM3iCYWyu5uJxng>
    <xmx:bpG9Zt46q0vP2_Zn0CAlVezzwWOjUkZDD23j__UZRa4fdN7imNakKw>
    <xmx:bpG9ZtggWlgucSB_5GBUygfV6dIc8jE2iBAxTWZ87pER-v5WIHrGtA>
    <xmx:bpG9Zn6dn6GnaMWkddsybVPjGMcRdeGTGS6e4JUD7HYnX8lCjzmnlA>
    <xmx:bpG9Zg0ejFJ3yI4ep8FzOaCfNarael9n4JwtUiDwgNmR8Q1umK9nPI1d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 01:26:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f037f50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 05:25:42 +0000 (UTC)
Date: Thu, 15 Aug 2024 07:26:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/20] path: stop relying on `the_repository` when
 reporting garbage
Message-ID: <Zr2RaQCbi3Tpstz7@tanuki>
References: <bbaa85ebad458c60c59784b690be8be2ddbe76fc.1723540226.git.ps@pks.im>
 <20240814182850.1273188-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814182850.1273188-1-calvinwan@google.com>

On Wed, Aug 14, 2024 at 06:28:50PM +0000, Calvin Wan wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > We access `the_repository` in `report_linked_checkout_garbage()` both
> > directly and indirectly via `get_git_dir()`. Remove this dependency by
> > instead passing a `struct repository` as parameter.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/count-objects.c | 2 +-
> >  path.c                  | 6 +++---
> >  path.h                  | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/path.c b/path.c
> > index 069db6ff8f..97a07fafc7 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -365,15 +365,15 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len,
> >  		strbuf_addstr(buf, LOCK_SUFFIX);
> >  }
> >  
> > -void report_linked_checkout_garbage(void)
> > +void report_linked_checkout_garbage(struct repository *r)
> >  {
> >  	struct strbuf sb = STRBUF_INIT;
> >  	const struct common_dir *p;
> >  	int len;
> >  
> > -	if (!the_repository->different_commondir)
> > +	if (!r->different_commondir)
> >  		return;
> > -	strbuf_addf(&sb, "%s/", get_git_dir());
> > +	strbuf_addf(&sb, "%s/", r->gitdir);
> >  	len = sb.len;
> >  	for (p = common_list; p->path; p++) {
> >  		const char *path = p->path;
> 
> Callers have two options here for accessing the gitdir: one is including
> environment.h and calling get_git_dir(). The other is passing in `struct
> repository *r` and accessing r->gitdir. It's not entirely clear which
> should be used in what scenario. Sure with the second option the user
> has the option of passing something in that isn't `the_repository` but
> practically speaking that's not happening here and also in the large
> majority of other scenarios.
> 
> I'm OK with this patch for the purposes of the series, but do you think
> in the future we should introduce get_git_dir(struct repository *r) and
> change get_git_dir() into get_env_git_dir() that simply calls
> get_git_dir(the_repository)?

Good question. `get_git_dir()` is implemented like this:

        const char *get_git_dir(void)
        {
            if (!the_repository->gitdir)
                BUG("git environment hasn't been setup");
            return the_repository->gitdir;
        }

We could of course introduce something like `repo_get_git_dir()` that
takes an arbitrary repository as input, like this:

        const char *repo_get_git_dir(struct repository *r)
        {
            if (!r->gitdir)
                BUG("git environment hasn't been setup");
            return r->gitdir;
        }

The only benefit that this has is that we double check whether
`r->gitdir` has actually been set in the first place. I don't really
think that check is all that useful though, because I expect that the
caller either has a repository, and given that a repository always has a
`gitdir` I'd always expect it to be populated. Or they don't have a
gitdir, but in that case they cannot call `repo_get_git_dir()` in the
first place because we'd already segfault before hitting the BUG when
trying to dereference a NULL pointer.

So I'm not entirely sure of the benefit of such a function over just
accessing `r->gitdir` directly.

Patrick
