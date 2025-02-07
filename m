Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1A18B495
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908983; cv=none; b=AOElK1OYVTYRkLlPSPOZlRBVusFZOgTJK59VkDx8F4GUtcH3j9Yn7czOlFc0IULAXlJ9Y7mrytVGjIMmYdjz6GVcANPykUuXWGI1rdAP7KG5qLpPCPiobNj+6/s6BgvNU7Mz6Eaz1qE9x4AjdufY/qTeHs1xWiYSTaH8nkePEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908983; c=relaxed/simple;
	bh=F0PqQVPgOtn/XZ3kj4ze4+xvjBewj3ojAqJ7Oz6ZmtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aff+aD3ZzcXn7ZPp9awhEFAMd2miKEH2Tss5hAKERUmQegNQepHaQNxYgNkhAeO8q6vH0qOQbqMb9JeCFvoG8mKiXi6jRqTIOqUXsN6UUe4AEuEHG2YI3PN55nyGdtXVIyU41SEXpN/WfxA5rkICCr6URtSnAZEfuR4nbiFFYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qaz4oVpu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXSDM/We; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qaz4oVpu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXSDM/We"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C858D114017C;
	Fri,  7 Feb 2025 01:16:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 07 Feb 2025 01:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738908980; x=1738995380; bh=U3zsP2taQl
	JHE0qUAKHJaHVwEITr1aasDxYUHu2p/a8=; b=Qaz4oVpuwCRYngkKWQ9kpGSlRk
	jO+uXyntnWW7yWRO0Q6/KmVXTJ+jhp8VGbp/Tg5ukaN4GcAHBR6KzynPJ+kGcOV0
	wgv3FYseRxOQR47CjSsBruwbGzhZ9iaWVGculBm3dw0aX204d5Sa7KkwrVhmZ0xH
	lF5SFfsv7SA1nmaDrVLtE/CSBf4rD/wrTAAaIp/Bj1zN5Jl5dAyWwrCP1XyyZ6S1
	H7lqYTkcTsN9DnUTcPJ4TCqRvRKDdJJYG50FwNBovK7LXgsoyCEgzDbAFFyCH9JM
	HturusFu2g9fnde7uy4yR+gACkzlSfxbH9/b0U9zNMSmpBWJDvpk11OCa47A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738908980; x=1738995380; bh=U3zsP2taQlJHE0qUAKHJaHVwEITr1aasDxY
	UHu2p/a8=; b=GXSDM/WeGFznffQQPqSaYow04iIc/r1b/g8IYVD4AX09pycQavx
	XwnZr9dw18unpOrNx9xoahjxObq/gpPjGdX29CBULzdRZfjeDHXGZ8Q0pZ8LDCD7
	S5YtlQrR5ANY6YmsxT97VuoYCwgamVpeJSKz15B+RhkdotBVYi66v1ejvGS6wT2I
	PADRy8nSTzujZp3HDgoD8ER/Eu+376AxqUlbAUnh/oFioB6HmTIuvHZ0SUMe68Ol
	krg3wjY+BTm9d12yRt1ia1xVcMXyMCEZfelURvxJWSOvQbF84+ODeFWIkj33AJoF
	EJshtAG7qrEwOdhKO/2PQz6O0s3hvO7K1LQ==
X-ME-Sender: <xms:NKWlZ9P9iqtO05XJgwiBAXcU8E0K5HL7XCo83lLrBG-YdxBntGEiHA>
    <xme:NKWlZ__AsypIfMYbcFcf9er_ki5Zko72tMME7sRr3SvjueiBNBfEPf2h0uexaJPRM
    iLZHQabtxOZkTUYtQ>
X-ME-Received: <xmr:NKWlZ8SeYrLzmNkyD7HpD9P4XjjNj3UIV15n7OgG4FIFvBjsHeu47-cCB1eN47PsmGwhG22R4qhNLbEgDlpfDDXPe35lYVgR6fZx8szVAGbk-c9t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghj
    ihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:NKWlZ5sdNShHaizXrfYy-w8qhSqwMs6g8RLtq26LqgQKFc7BLkgr0g>
    <xmx:NKWlZ1ehXsj3_sMpfeJb9OP2gFj3QZfBWHgFIqoZRBbIl-Xb6Ljo9Q>
    <xmx:NKWlZ114WQRZ6ilr6sHhMqUz6FLzmQ3wPYPo2mymYAy2-9FDbCT2kA>
    <xmx:NKWlZx9flUpBEBT4uFdshse7Qjx3jB0KPXhf_KIXdECjovD6tuikCw>
    <xmx:NKWlZ2rixbHAg5zUjYpcbT21YzNKKfDXKqpLTfAiIIt6Mzb9fqxZ9R0N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:16:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f33f02a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:16:18 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:16:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] path: refactor `repo_common_path()` family of
 functions
Message-ID: <Z6WlMvasi64N3dQQ@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-1-4e77f0313206@pks.im>
 <Z6TFZGNjs3Xfkh9x@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6TFZGNjs3Xfkh9x@ArchLinux>

On Thu, Feb 06, 2025 at 10:21:24PM +0800, shejialuo wrote:
> On Thu, Feb 06, 2025 at 08:57:57AM +0100, Patrick Steinhardt wrote:
> > The functions provided by the "path" subsystem to derive repository
> > paths for the commondir, gitdir, worktrees and submodules are quite
> > inconsistent. Some functions have a `strbuf_` prefix, others have
> > different return values, some don't provide a variant working on top of
> > `strbuf`s.
> > 
> > We're thus about to refactor all of these family of functions so that
> > they follow a common pattern:
> > 
> >   - `repo_*_path()` returns an allocated string.
> > 
> >   - `repo_*_path_append()` appends the path to the caller-provided
> >     buffer while returning a constant pointer to the buffer. This
> >     clarifies whether the buffer is being appended to or rewritten,
> >     which otherwise wasn't immediately obvious.
> > 
> >   - `repo_*_path_replace()` replaces contents of the buffer with the
> >     computed path, again returning a pointer to the buffer contents.
> > 
> 
> I want to ask a design question about this. Why do we need to return the
> raw pointer to the `struct strbuf` for the last two cases? I somehow
> understand why you want to do this. You want to follow a common pattern
> for those three functions. But I wonder should we let the caller to
> decide whether they want to use the raw pointer?

It allows patterns like this:

    if (stat(&st, repo_common_path_replace(...)) ||
        unlink(&st, repo_common_path_replace(...)))
            ...

So the reason is not that I want to follow a common pattern, the reason
is that it's useful to some callers.

> And in this patch, the return value of the last two cases has never been
> used. Until I read the next patch, I have seen the usage of the return
> value thus I could understand your motivation.

Yeah, that's fair. I'll adapt the commit message to explain this better.

> > diff --git a/path.h b/path.h
> > index 5f6c85e5f8..3c75495e1a 100644
> > --- a/path.h
> > +++ b/path.h
> > @@ -243,6 +241,12 @@ struct strbuf *get_pathname(void);
> >  #  include "strbuf.h"
> >  #  include "repository.h"
> >  
> > +/* Internal implementation detail that should not be used. */
> > +void repo_common_pathv(const struct repository *repo,
> > +		       struct strbuf *buf,
> > +		       const char *fmt,
> > +		       va_list args);
> > +
> 
> If we decide to make this as internal implementation, why we don't just
> delete this declaration in the header file? Do I miss out something
> here?

We can't, it's still used to implement `git_common_path()` in the
header. We'll remove it in a subsequent commit.

Patrick
