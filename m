Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74571A3037
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139827; cv=none; b=X5jPjseNIdYiwS3wr2ZvC7WtikCnKPoKUQEQf6gWnOJ2iiwiiDCN3RbUC7jRmmOF7VJqzrz2YIfyu0fLDlsGUchyRvgd39VLJNaXhMOgOdb4bFoxgUOzDYCc0vnA7hpJLsou5ihn2TECqSKet0GqVehYX2kF7mUQ+gWr+1GKynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139827; c=relaxed/simple;
	bh=Mf1MpboTSLp3Jp8e0jbW53sMLGQo6eHgQW1U+vsbcI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfWKZcPoBbjmtbQSuwjE0kmRmSz3XxpGG8elUhZam53ofZGHUlOb+/Anjo7dnlDaduhb95CVCVtq1fNmLUtO9RAcYkEu348vEQe5qU8P28o3+C7pNiRlPTDhuMgKnuh/e8CDKL1axPWFdcJKRai36HoFCbLK3ux1uvdHsbKf5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s2Llw+lb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6hZuzIw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s2Llw+lb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6hZuzIw"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1817F1140598;
	Thu, 12 Sep 2024 07:17:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 12 Sep 2024 07:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726139824; x=1726226224; bh=IgLZH+TjVl
	JU4VvkNd7YkFHENYD7dOlO1nEKDDQQZpw=; b=s2Llw+lbXegqhj1CyxCr1rMtPu
	30xOa8kjP08eZi+bjIeX/xtscg7nkygYa85IPEV0b+d6XhiCVZ7WPtYgTV5vxGXb
	AgL5DAgKGjC62HF4fxU8PfNjYFgkrIiiOkUg1/kkAP6B2TkuJTMOqgpc2rUsVdsf
	NK2A2sDXwWqmxFCSkF05ugrXG4cXlyENRmeE81L/3KEufHSrR61amjMm4rRJz5qB
	kB5h/VAl/I46/VmIEEv5ete3ShlzYT6FswdyzRtAQJHQuv5uC+jjbCM258At5CQ2
	cV1zfDINecYK8pa3IVdyh71KPkLLkGMU+liE7ulBlNgqyKztT3Y2ciOonMZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726139824; x=1726226224; bh=IgLZH+TjVlJU4VvkNd7YkFHENYD7
	dOlO1nEKDDQQZpw=; b=S6hZuzIwx9/dzY+22H6U8PGWzcABeaLgi/n2Y1GrzBIY
	PMJWjDhY4qC0nEI/Dl7h0qNRPMkLj7g0kg9iPtJNZ8kWLzdk0RgFbcOPhE5Z5nsU
	NyqDmiVXLGcIa5h3lzuKMtU+8nDrsyM+T2Bg+14uUIO54WD9Zseytr9YcKMYxFbt
	l2he0l0fHMTo4yKg9OhtbkL6rSW3e7+GFc9d3Glxw5fWGqOpL5TA1x+c3nYmdsYR
	HBMitXSdBEB/rRqUV4pgxSX2BJd79L0wr18wlW3QWOcb3ZNexToxmlE0zN81mlPF
	Yk8hyeoI969Cy7DtF+VXJTYgOYZON4naCtlKJrgSyQ==
X-ME-Sender: <xms:r83iZoAmQUglh35SjeYjp1YCHN2lVRMyMTlu5rc1MTDwkhqq4DtGjg>
    <xme:r83iZqiAShIKG3BZFxj7_c1nqQfqr_lv9MlLYN53NOZpNL-ePjc1pOXi-LhTJts3N
    4HqYBkwZZQVm7WTGQ>
X-ME-Received: <xmr:r83iZrkPkPvFIlI3dJXDvSrMEqGwflAM99QqXseEN5rH7iDx9XXVjdcwmqFyp1v7jFiuOf-X_Msm2vQdyWljJ33uKv2wa0XHolnkCFRW_Lwm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:r83iZuxT5rvWCus5fvh-ls9YFSMP2F5uWtRHV-VfcoizZZNNhcEa0w>
    <xmx:r83iZtSHSzJz0X9shtMOoPRL_l549wX9wr1b6klQtqlD04L6326VqA>
    <xmx:r83iZpbph9ZLjnlomlsfhfxF-OmJWjA56TsEsuwjziveJSNCNBC0Ag>
    <xmx:r83iZmTKoFAA359LHFJY2tJrXwPJIMllt4e6Z76-ho6QjopC1udxZw>
    <xmx:sM3iZrPB0_OoTsfJek1Y63f2IrQt4YRQJ5A0SOEnsnHP8_brux4UQj1r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:17:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb8b2aa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:16:52 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:16:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/21] environment: make `get_git_work_tree()` accept
 a repository
Message-ID: <ZuLNjhWtNpO6T8Bs@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <22e9dcb28a981eaa1a37a8b41e8d061347ed6c2e.1725008898.git.ps@pks.im>
 <wnorpwj5stwekbdvqzz6oyom5ppqhcsg3afvujslmy45r2djdb@sn6voa5d2e5v>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wnorpwj5stwekbdvqzz6oyom5ppqhcsg3afvujslmy45r2djdb@sn6voa5d2e5v>

On Wed, Sep 11, 2024 at 10:15:06AM -0500, Justin Tobler wrote:
> On 24/08/30 11:09AM, Patrick Steinhardt wrote:
> > The `get_git_work_tree()` function retrieves the path of the work tree
> > of `the_repository`. Make it accept a `struct repository` such that it
> > can work on arbitrary repositories and make it part of the repository
> > subsystem. This reduces our reliance on `the_repository` and clarifies
> > scope.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> [snip]
> > diff --git a/repository.c b/repository.c
> > index cdefcb4002d..92238da3d9e 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -126,6 +126,11 @@ const char *repo_get_graft_file(struct repository *repo)
> >  	return repo->graft_file;
> >  }
> >  
> > +const char *repo_get_work_tree(struct repository *repo)
> > +{
> > +	return repo->worktree;
> > +}
> > +
> 
> Now that `repo_get_work_tree()` is accepting a `struct repository`, it's
> only functioning as a simple accessor and seems somewhat unneccesary. Is
> it preferrable to keep this?

I think it still makes sense to keep it, mostly because we also have
accessor functions for the other paths, too. It would feel weirdly
asymmetric to have `repo_get_git_dir()` but not `repo_get_work_tree()`,
in my opinion.

Patrick
