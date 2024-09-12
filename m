Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228619341C
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135503; cv=none; b=NY9nU2wRCEEZ47jWSt1B+1sTR3SDjUnakg4d14NIPIHYBqpUE1p46dmFTcNEO9tJA3KzV6d8adEQcO830ahPYgawKbTSSDUk21FWctn/cq/aGZeUBI88tm+0o30SFme7w0ZHnb2Mob9ofuY19k2s6cZXlCAuzv/gwmoQaggS6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135503; c=relaxed/simple;
	bh=8wMbLGcDwpdyC6VY6JYlgtTmjeUx9Ve6s621P5Tux9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXQi0Ud8odsbkAajZUmfA5C5v9T2yneJkZBPfkqp7tDVZm8/cA/Ruhjni0YrKMbFXE06Ea8qwY0XbUaBI4wBrSfdcFe4SkUWDXdl6TFXdV2pM1v2UpQb1eNdfpKsHqsCAi9yHOqzfPDTy4/IQTJvx801rsqB9MHjIBTvglICF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RrwM1bhy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLTRwhBk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RrwM1bhy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLTRwhBk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53FDE1380449;
	Thu, 12 Sep 2024 06:05:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Sep 2024 06:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726135500; x=1726221900; bh=Uxl7p/GUWf
	Ni/duHj0KpwAYGvJwssGTO2dXW4IJPp7Q=; b=RrwM1bhyq5W7DEepanzCQdqExH
	SSING1wLwuwuBEn9plfrjc+E5JGd61g1M6hpmsX0/VPUaXIHXx++V4mJ0fhg1wjz
	bypW0fMgMMHVYeXk/L4V9a75iFSUcFQq+62V5NFIzGMgPs/1vj9CXvuInWU/FYEP
	KCexhxYza9Pmp9UenIH89/Drjk3Vo7wY7LEY7wwb52eX//iPOkSo1/UfKW77ZREs
	xDBqRB1394sKHiu1DUryex9BPAejUcukx8LoJ7jNvB/QlJqOln2Bg9wF9B9c7a5n
	ZFxmrv1eouECObQSjPMuDnxpwZcLDX8VNKEkYHmUpy+EqkyOkgWQpm5SLvhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726135500; x=1726221900; bh=Uxl7p/GUWfNi/duHj0KpwAYGvJws
	sGTO2dXW4IJPp7Q=; b=kLTRwhBkFYx9NenUl9XZH9vW/vjy0uE2lFHKGqRtrBWT
	Fkf6tqJ3GAQAQKPC9c+f9E0Q4NidtWIOKzIociJS0UZCJiFkE+HfqmV43GpgHmQI
	S4cuwhsNP7NZq/Hiq6fxuCHh5wwfQ+CZ2B85CIXJlvoqk9pPh4d0Y5H9N16DdD+v
	xRc2uH5APSIfEjEsxsFb52fuKIDbKeXDL+YbqJEMWPpwyMcnHKC0QHipUcNsJtZL
	QhjFVFInyzl1OAVEvADZd1PZsCXwoXN7HygnApUphcNtVea6bSqyBPEO+J6kQ18d
	TnNcM3jo1O8k6INPufVf7JtEDnzXkBLCR2ByeCrNtg==
X-ME-Sender: <xms:zLziZoHPwaKOptYkZFSCwWwbfu5KfKtxOqGahAtSULt997ofD4o3hA>
    <xme:zLziZhVc1d240ryqQWGhUi8FQqlCmHtRhqmS0rVh_mFIfvfWy8PtIW_HtDb9--htj
    UxZ_vtAJET9L8eg8w>
X-ME-Received: <xmr:zLziZiJrTzUzI80oT7iF7kPPa_DxBVPrjwy1ALiQk0AyA_t-RLui4B1sIUKBG3CModVHsKmREKmaULZAIO_oULdB1RsFMyU-WFIirNJQsX3j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:zLziZqGVTJFllWwlT6uGOUseEjt6VHOaq3uJx9W_4FxE8PN8YJoDLg>
    <xmx:zLziZuUfunaS1YtSWVODsiB3adjMN8R7qxQ0KDwQCKvcWCejzUoQtw>
    <xmx:zLziZtPu6UPmJECVKEEtrziYFdWnfhh24bW9qB4BTOeaE2eWhmGkeg>
    <xmx:zLziZl3TTa4OXHZ6Td-OEipxBqJPhwndj_9kMwa9k0bUSykAC1tqlg>
    <xmx:zLziZgflCvbH2R0X411Jdn78Dfv1J4FCUYr9E8pZ-OQ5bKxnisqedDRS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:04:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 900b61c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:04:50 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:04:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/4] remote: print an error if refspec cannot be removed
Message-ID: <ZuK8yihccDjgQGZV@pks.im>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
 <xmqqseu56hhb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseu56hhb.fsf@gitster.g>

On Wed, Sep 11, 2024 at 01:52:16PM -0700, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > If the existing fetch refspecs cannot be removed when replacing the set
> > of branches to fetch with "git remote set-branches" the command silently
> > fails. Add an error message to tell the user what when wrong.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >  builtin/remote.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 794396ba02f..4dbf7a4c506 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -1603,6 +1603,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
> >  	}
> >  
> >  	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
> > +		error(_("could not remove existing fetch refspec"));
> >  		strbuf_release(&key);
> >  		return 1;
> >  	}
> 
> It is a minor point, but would it help to say what we tried to
> remove (e.g. "from remote X") or is it too obvious to the end user
> in the context they get this error?
> 
> The reason why I had the above question was because inserting error()
> before strbuf_release(&key) looked curious and I initially suspected
> that it was because key was used in the error message somehow, but it
> turns out that is not the case at all.
> 
> IOW, I would have expected something more like this:
> 
>  	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
>  		strbuf_release(&key);
> +		return error(_("failed to remove fetch refspec from '%s'"),
> +				remotename);
> 
>  	}

I don't think we want to return the error code from `error()`, do we?
`set_branches()` is wired up as a subcommand, so we'd ultimately do
`exit(-1)` instead of `exit(1)` if we returned the `error()` code here.

Patrick
