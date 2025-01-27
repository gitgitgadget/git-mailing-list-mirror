Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57721172BD5
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964657; cv=none; b=DBrNhZzxTeRROtJPu0Ph4e7XHTlddWBGbqFirmf1X/blbvqr6Ew6KEJpEW3ceBL3HqjOO+7h2xyuDjrPUOPvKaijhET86MGqEROxR8HKp14O7GMkh+0J9OmiX6l6IzSEjLLSBKR5nS4UcG7JkP91anihG3oQOtsjVCbKwr/bECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964657; c=relaxed/simple;
	bh=Z1M6ycNsKFkw9LX2LuKXl8KjRYw74cKLEfMZm3qT39c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCbujkHgCwNMETo8FoeQJk1BgBtZHDYIV+uMFUjr7NKN/8Ejr8J52TuZD9EdrNhoa9jce9LTMyXZ9k681yJHi/YF1GuxyZm3fLf/MsjFSPr7mMWpewJ3JGQv0eVAsXGdDAVXfd1etQle/JJiBshhIQzhN+3RsMRbJtWKjMDZBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DhPAYw/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q4DAoiMk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DhPAYw/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4DAoiMk"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A160C1380B09;
	Mon, 27 Jan 2025 02:57:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 27 Jan 2025 02:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737964653; x=1738051053; bh=LLqjHdY7NY
	l1ZD+Q8BYDM+xmSWQo6/XWyHKtxFpi7Ow=; b=DhPAYw/atGdTJ5P3qoRzx9YugA
	sUgsjcke4LLAU3HNJ5MHy/VlxjE5C3EkRbC2JcxuOmaPYD5/lfNpjI5B5M+XEecl
	qNfa5a0rahebfcStl9vY5OhrBiEvIwRCPhEZht2w+Y6X67IJIWDRClUHk3QA9Bwr
	rs+wXzX2eL7hEymNf1AWqNOiA9HpXxh9pWa2FMX+OJEbT+aNoMp1nFBpkVNtaiC5
	HuJnKnvRYU1GhR+K/iuGSymys/xP+MmbXIn97S2WGqd5U0B8rN1jZJnuexqNnU6U
	ekz9TqUX67FNiHhz8/Tnlweq0r8We24LF6o8cqgCkEm6v8Ngy0oYimY98X1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737964653; x=1738051053; bh=LLqjHdY7NYl1ZD+Q8BYDM+xmSWQo6/XWyHK
	txFpi7Ow=; b=Q4DAoiMkW4gYjPbj5mm09KLg8CjjDGDWuiMwgU0K8daf1BHCEp+
	vSYnCOuMs3MC2e/GIoPJyHUsOgpmlmqzt/YUOndyV+90aMkg8wJ/4GwCswNGWO1t
	Krl/7PyGxZzizVe/6B+NLDaQhur9+BRUTvYWnVxJelMKmkMKYiUNqrFW/wZoutL4
	FU+5dq3GKdPdMjxTuW8PkaU6w8L1VWQiLaNj4XjzgMwQ4WUarOY+ci8Q75tKNJMG
	N1ecZZQFxcQvgtXnAl9wWma9Det/xYMJpoCSK/HFtIFrPdmOyW7IlPU5enUZ7nu+
	Zfa5Bj6MPHV2osz/qmEXULvG8L8MAbOr+qw==
X-ME-Sender: <xms:bTyXZ2_G7CdDZmERqhj4Yuj4AEocHhFF14gfvxVAhYzrDVcT6lRwkw>
    <xme:bTyXZ2tTYjJI6S3BbhUEu2cYPAlm5NWOU4P5foZ4TGUteGFLev5oLmjMwaOEytaIC
    r8xb_4vfg_z_rcVSw>
X-ME-Received: <xmr:bTyXZ8D-03IsgDMFhoPg3z5F4VRC1lih3_mFx9wi0FQRl-rcggygNznZb4cwYse-Hr5SPtyML-aQKtedRC9U6OASkFIrPqGvujmUTU4PZyXb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepiihothhtvghlsggrrhhtsehtqdhonhhlihhnvg
    druggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:bTyXZ-djB_kNLEeRDXCijNu9zvEUWCklFMgscpzVvjmOQDJm4xwoNw>
    <xmx:bTyXZ7PXHlO52YRmh908RWW6ihRjhwuq_Ou1Yd2oa-NuTBmb8FtkiQ>
    <xmx:bTyXZ4lF161u-PvCkZq48dFggU_G1af0-yeAZ66DkfETzq9FERPOng>
    <xmx:bTyXZ9tCC8hew1jBryUfM07modTzKfqS_UOdQnKSLuhAvJCvGZikYg>
    <xmx:bTyXZwoyksu5WFXIcNP-GhYSJoW8FPIeN6-F8HMBex1mWxFNx4ZZ4Tsd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:57:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91a812ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:57:29 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:57:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
Message-ID: <Z5c8aEVP7NLpMN3N@pks.im>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <xmqqfrl6wdux.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrl6wdux.fsf@gitster.g>

On Sat, Jan 25, 2025 at 05:41:42PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > index ebfb8ba423..a555af8d54 100644
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -224,8 +224,12 @@ int uname(struct utsname *buf);
> >   * replacements of existing functions
> >   */
> >  
> > -int mingw_unlink(const char *pathname);
> > -#define unlink mingw_unlink
> > +int mingw_unlink(const char *pathname, int handle_in_use_error);
> > +#ifdef MINGW_DONT_HANDLE_IN_USE_ERROR
> > +# define unlink(path) mingw_unlink(path, 0)
> > +#else
> > +# define unlink(path) mingw_unlink(path, 1)
> > +#endif
> 
> This one is yucky.  All calls to unlink() used in compilation units
> with the CPP macro defined are going to fail on a path that is in
> use, but in other code paths, there will be the retry loop.

Yeah, I don't like it either, but couldn't think of a better way to do
this.

> Regardless of the platform, the code must be prepared to see its
> unlink() fail and deal with the failure, but I wonder how much the
> initial "if file-in-use caused problem, retry with delay without
> bugging the end user" loop is helping.  
> 
> After that retry loop expires, we go interactive, and I can
> understand why end-users may be annoyed by the code going
> interactive at that point.
> 
> But wouldn't it be too drastic a change to break out of the retry
> loop immediately after the initial failure?

In general: yes. For the reftable library: no. The reftable backend
already knows to handle this situation just fine by simply retrying the
deletion on the next call to git-pack-refs(1). So the file will
eventually be removed, and it doesn't hurt to have it sitting around as
a stale file meanwhile.

> Unless the case found in reftable is that the process that has the
> file in use is ourselves but somebody else that is not under our
> control, it could be that the current users are being helped by the
> retry loop because these other users would quickly close and exit
> while we are retrying before going interactive.  What I am getting
> at is that it might be a less drastic move that helps users better
> if we moved the "let's just accept the failure and return to the
> caller" after that non-interactive retry loop, instead of "return
> after even the first failure."  That way, we'll still keep the
> automatic and non-interactive recovery, and punt a bit earlier than
> before before we go into the other interactive retry loop.

It would incur a delay though that is basically unnecessary. The file is
not being held open by the same process, but by a different one that is
not ourselves. And because Git opens with `FILE_SHARE_DELETE` on Windows
we even know that it wouldn't be a Git process that has the file open,
but something else (e.g. JGit, as reported by the user).

Chances are slim that such a third-party client would close the file in
the exact 71 milliseconds that we'd be sleeping for. And combined with
the fact that we know to clean up the file at a later point anyway I
think I'd rather not incur a user-facing delay only for a slight chance
that we might succeed unlinking the file.

> Of course, if we are depending on the ability to unlink what _we_
> ourselves are using, we should stop doing that by reorganizing the
> code.  I recall we have done such a code shuffling to avoid removing
> open files by flipping the order between unlink and close before
> only to mollify Windows already in other code paths.  But if we are
> failing due to random other users having the file open at the same
> time, at least the earlier non-interactive retry loop sounds like a
> reasonable workaround for quirks in the underlying filesystem to me.

As far as I'm aware this isn't an issue in the reftable library, we're
being quite careful there. I'm quite sure that we'd otherwise have
gotten reports about that before seeing reports about JGit keeping the
files open.

Patrick
