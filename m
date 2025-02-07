Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93216DC3C
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908972; cv=none; b=Y+WnRdE0Tx1BSzqV5xps0E6KkgP8H8H6DhDqQ9kenPg97BijQYyxBtFejxBkQMCgMjKy0/BPDYOBL2vIY5HcCCxYyDDno9j/8EXXvrSgKJaxoSyeW1whYDhF0SGN/nC3SW3VmyM36FbmRTEJWJupgzq+HW7AlsybqWr++5Y4HxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908972; c=relaxed/simple;
	bh=iIXLrNjXddOYUfzSMgCpc3yDdxuYCCi5VGkSX/OdwSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0XK9+XP52Ybhpa1oYTR3BAVZl2yOBm8ELkztUXxWruT+bsW7/dU0ord2iJ1ykPS95cCC08ScoMZJrjVXEBO9gK/xJZjffoXLirJI52maBhZyDoC7DJhTbEhear3PZ8PSbv9aG2rdOY0jtcQEVuqjag+cjpRo9A42T+92BB63xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SBlmnxNO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rm3pyILi; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SBlmnxNO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rm3pyILi"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5743114010B;
	Fri,  7 Feb 2025 01:16:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 01:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738908968; x=1738995368; bh=yVQBckZdHz
	R0NlVF/uT81II/aN+pR2zsFQSA0sCB+GU=; b=SBlmnxNOA1PedS4ajoV9h/q89C
	jG3XfX13eIsg7ExwQfD4PnSFYoS3jWkGKHm5EEFUooAGggVzKL7OOY1vveREp+K+
	CnTf93t0WUSh0XEtnPtU6Vh2g8BC5zDCdP6Z1kcJ6X/jXliX5zMDOBbtULIykVkW
	VbSUcfToPjDKGbN6wnuNjEqe4lbLhysTuMMEoRicqSJqnABM+/fan9uev39Ed4Nk
	dcBeZaEXQDOOZluCO/NjUQIFTFqJOh0c1vrJyPCcH8vhVMdIqo6Qa0pwEXqTLNoS
	U/btxVkoEXwp5/iVsPDjWjGt37fD67dwzFZ0XZ//TfMoKKIcK9zPZfF6wyuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738908968; x=1738995368; bh=yVQBckZdHzR0NlVF/uT81II/aN+pR2zsFQS
	A0sCB+GU=; b=rm3pyILiRthopv7+q0Ar1M/T/N4qjVYwxDwenxLhg8D7cKurB6T
	AXIbSoRIdGUgM2cDKJDczXJVmB2zYAG2UdMonyD6JJ6aW95XPBELh9QRD3vb16IN
	JycdOFd9RIZPM+qtvcAL3xIQ4PQi2zSHVCfP76JELst0PTbH6WP95mOzcqb/uKUw
	8MF8+ShjM1lF23lPmZ7EJlhdKrXMK4+dKgY/fNhiupboirWUw73fvaYR5eCbRlfq
	zSrEqZBlWXljF0N+Q1Oy5oHU27A3LTMucmJal6k/DQLIxm+SBpa/e3dE8hxJ6kvg
	JFRftPRVfNDVG1bc82zjSCI36xzVaKdd3Eg==
X-ME-Sender: <xms:KKWlZ-E89s-5lsM5L2ULwYev8qdILxOTveOwM2ftM_jpJ69uUQzgxg>
    <xme:KKWlZ_Ut7Evcn2Sr2icWCbZHSM1O5zxnBwtkKlAqvm29xvtuPIyS0mM3bZ-E64cKB
    jQdjtW0i7rHa7lgJw>
X-ME-Received: <xmr:KKWlZ4IHFlA5x18wrYkl80XKIW8qyjRiCGSyKT-ZmpCIh-0Vii-OQ50p3ye9Ppub7Q1DmVB9a3ZM8hYfI410AYPRwGrzI8-vFJJhHUxlX0KSKjNS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:KKWlZ4Fq29AmZU54KbhBNvBsNp3Nbhz1aU19H6OoNt1r3ApZ2lW5BQ>
    <xmx:KKWlZ0UDTFj89DFo6C4KOTE088x7lxixzL5QLeQxiLm_z8nrm0--5A>
    <xmx:KKWlZ7P-zz1na_2oZniP5mkBhVdk8eJrujDEACGH8Vskh51NtZhoqg>
    <xmx:KKWlZ73VBarawRKcz6LIfLJ0GKpjU_u6VTR_kjWxqBd6HkReeCW4SQ>
    <xmx:KKWlZxhUmKiaWkuP7myPj2QPS4iOZOQfJtfHrkK_pG6fJSfywJksiHnB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:16:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b574765b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:16:07 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:16:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/16] path: drop `git_common_path()` in favor of
 `repo_common_path()`
Message-ID: <Z6WlJvnHHCEW6p5P@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-10-4e77f0313206@pks.im>
 <Z6TbMGcPftyhUyC3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6TbMGcPftyhUyC3@ArchLinux>

On Thu, Feb 06, 2025 at 11:54:24PM +0800, shejialuo wrote:
> On Thu, Feb 06, 2025 at 08:58:06AM +0100, Patrick Steinhardt wrote:
> 
> 
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 2cea9441a6..761e302a36 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -151,7 +151,7 @@ static int delete_git_dir(const char *id)
> >  	struct strbuf sb = STRBUF_INIT;
> >  	int ret;
> >  
> > -	strbuf_addstr(&sb, git_common_path("worktrees/%s", id));
> > +	repo_common_path_append(the_repository, &sb, "worktrees/%s", id);
> >  	ret = remove_dir_recursively(&sb, 0);
> >  	if (ret < 0 && errno == ENOTDIR)
> >  		ret = unlink(sb.buf);
> > @@ -1102,6 +1102,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix,
> >  		OPT_END()
> >  	};
> >  	struct worktree **worktrees, *wt;
> > +	char *path;
> >  
> >  	ac = parse_options(ac, av, prefix, options, git_worktree_lock_usage, 0);
> >  	if (ac != 1)
> > @@ -1122,9 +1123,11 @@ static int lock_worktree(int ac, const char **av, const char *prefix,
> >  		die(_("'%s' is already locked"), av[0]);
> >  	}
> >  
> > -	write_file(git_common_path("worktrees/%s/locked", wt->id),
> > -		   "%s", reason);
> > +	path = repo_common_path(the_repository, "worktrees/%s/locked", wt->id);
> 
> From my perspective, we may use `repo_common_path_replace` here to avoid
> using the raw string pointer? This is because we return a changeable
> pointer "char *". But we pass this pointer to a "const char *". This is
> not critical, but we may make the semantics clearer.

I don't think there's much of a point doing so though. We only use the
string a single time, so using a `strbuf` doesn't buy us anything. This
was different if we already had a buffer available that we could reuse,
but we don't.

> > diff --git a/path.c b/path.c
> > index d721507be8..f6b795d75f 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -634,10 +634,10 @@ const char *repo_submodule_path_replace(struct repository *repo,
> >  	return buf->buf;
> >  }
> >  
> > -void repo_common_pathv(const struct repository *repo,
> > -		       struct strbuf *sb,
> > -		       const char *fmt,
> > -		       va_list args)
> > +static void repo_common_pathv(const struct repository *repo,
> > +			      struct strbuf *sb,
> > +			      const char *fmt,
> > +			      va_list args)
> >  {
> >  	strbuf_addstr(sb, repo->commondir);
> >  	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
> > diff --git a/path.h b/path.h
> > index 904eeac068..496f27fdfd 100644
> > --- a/path.h
> > +++ b/path.h
> > @@ -233,29 +233,10 @@ struct strbuf *get_pathname(void);
> >  #  include "repository.h"
> >  
> >  /* Internal implementation details that should not be used. */
> > -void repo_common_pathv(const struct repository *repo,
> > -		       struct strbuf *buf,
> > -		       const char *fmt,
> > -		       va_list args);
> 
> So, we finally mark this function "static" and delete the declaration in
> this patch. We cannot do this in the earlier patch because
> "git_common_path" is defined in the header file and it needs to use this
> function. Make sense.
> 
> However, I somehow feel a little strange especially in [PATCH 01/16]
> that you have added a comment:
> 
>     /* Internal implementation detail that should not be used. *
> 
> When I see this comment, my first intuitive thinking is that if we
> should not use this function, why do we need to expose this in the first
> place?
> 
> This really introduces confusion.

I've touched up the first commit message to explain this a bit better.

> > @@ -384,11 +387,13 @@ void update_worktree_location(struct worktree *wt, const char *path_,
> >  	struct strbuf path = STRBUF_INIT;
> >  	struct strbuf dotgit = STRBUF_INIT;
> >  	struct strbuf gitdir = STRBUF_INIT;
> > +	char *wt_gitdir;
> >  
> >  	if (is_main_worktree(wt))
> >  		BUG("can't relocate main worktree");
> >  
> > -	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);
> > +	wt_gitdir = repo_common_path(the_repository, "worktrees/%s/gitdir", wt->id);
> > +	strbuf_realpath(&gitdir, wt_gitdir, 1);
> 
> Why we don't use above pattern which means the following:
> 
>     strbuf_realpath(&gitdir, git_common_path_replace(...), ...);
> 
> I think we should be consistent.

We can't because `strbuf_realpath()` is not prepared to use the buffer
as in-out parameter.

> And we should not use "char *" type to pass to a "const char *" type
> here although this won't be harmful to the program. However,
> git_common_path_replace will return a "const char *" to make sure the
> caller cannot change this pointer.

Passing a `char *` to a `const char *` parameter is fine in general and
expected in places where the string is allocated. Using a `strbuf`
everywhere wouldn't buy us much in cases where we cannot reuse it.

Patrick
