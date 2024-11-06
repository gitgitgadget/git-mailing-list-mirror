Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1D824A3
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874864; cv=none; b=RzBjYVQ0QSu1OpbYdrKRQRSJKPrvOh/q1LSeBgzoxZD0YJF7Afui7UGdh9ZDMU3OJ+S6g0zVqqf/y/VHuX/wsP+f0PkdyQtLa/L++52W/q8klNujUxeFTtaxoRIp+URy+W3X/z+oJWdJAc0vpVr2LFXKwDw7XNUq4AXvcUUjGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874864; c=relaxed/simple;
	bh=y3RsZY7YR5Qi2BhVXzT4ZlkfVgMse+dsQ60JDkGHwzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYb2k02xnY+z3CGQHF/YU0sLr6b/3sdebdWitXGDbRLrhJxH8SQGVFTWQA486FQ8CLZt/TBfs9Hqk14ASmQw9W+KsFZz82keBMLKuF1fR+DXnjMOQwbxz1QwnoL38LcAS0BYWg5BWpszBWVWySogfwFatb6ekbfCwauQyIpyhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HJJsyFdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKDfkhK7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HJJsyFdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKDfkhK7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 96CF713801DF;
	Wed,  6 Nov 2024 01:34:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Nov 2024 01:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730874859; x=1730961259; bh=Ios/bUbkFt
	Z6iA2/A4ln8ib3/JvCFmUBrrKCtvS94QU=; b=HJJsyFdZBAmVqrPZCcQvhVPc6T
	emK5RW3jBMFVdRpDkJRKTe/nk8Jwh5RwKROfOxe9ueQHelA6459PzL81OeWmOfzc
	VX+N5tuDY7blGHnbLPja1XHGIG4lQ6grISlPkwyt1xu/COP9KYXrD7k029yQawgV
	ux406shnFvCzaj5oaVdZdn/oagPOLuKVfU9SMgTquKcUl5SMfimXm3hZBUsifSfl
	5UpYRppOHP75Di+b8cu24uOy07jcFT8ffqShNs+8V13OrtgBDVs2lP2c/5+OPg6T
	Yuipl5B2LcmtNxRD3HQMoFQOw57/Xnf3XyLTlCCqlomjxFqcnklkEIa7XmEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730874859; x=1730961259; bh=Ios/bUbkFtZ6iA2/A4ln8ib3/JvCFmUBrrK
	CtvS94QU=; b=dKDfkhK7+nYwPD3LTW2/s9V6EnctYm2+ZbGgXF/1d6A+UfGKSVZ
	39bfZg+wanFCpxZkz0xbtj6K+Q+fgK6nYGZhi4v9dAGfFtm/ouG1p4YedTWJ7bJw
	J/9Gxb4IW1CS7HI90/WPrNAmM+AknxUrJOvWe6hAhoh5egRJV+W+8ynk4Zy8VkE2
	6nkKHlh3R7CVdT5rEcIao0IGUC4LvF9HlmHAc6wREt/ldTw1GI7JhkvGqu5t1l2c
	xZjKTzRfM40D0L5Obxfakxa6A+OO2XAvHhk41KD/U+OTiuonQRsa1FsUylL7l3Jx
	otn/AI2yLh3Rc+9LbneWQeLfe1jaLBiaZNQ==
X-ME-Sender: <xms:6w0rZyZ-hvzHUQI-apnMA_LxoiDtLfSuy-g6mvMqpLzhjBJdC3JyQQ>
    <xme:6w0rZ1b2l-E4Kl48YGImPjwyvxLQLxYlmltVsMEHfUxNI2A2D4PoweLNOVD9RSuRf
    cGDAqeJzI98jFhJEw>
X-ME-Received: <xmr:6w0rZ89-rTcX_oUywQbQ_xdnluBh5YbWs3U7c9wQfawaoovdiwYDqRVoA9uWyFX9Ufz57dlIV-SZBN_vRzF4m84-uBHLioYP2wh1StlslS4V4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6w0rZ0pkhELUw3hVwmIoLnDT5nOEUh7dAvWgGscdb3exibYsbk88hQ>
    <xmx:6w0rZ9rz9CDgDAFnSmuUWo_SI71934W_-ls1X6aj7q_VONYd-FkB6Q>
    <xmx:6w0rZyRMQHVUcsOd-zrYnR9V7BezLQBQW3SQGcJMa_0hAnQqJ4scKg>
    <xmx:6w0rZ9pUlozLNOzOlSlvwGIk_ymDS7SDdYznWJp7ur4M96zVWO2TKw>
    <xmx:6w0rZ-nkh3x0RM0D-ctFo69Otj_BbdBDXOxV9RLv86vf9FEEUXgXGW2X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 01:34:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd29900c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Nov 2024 06:33:54 +0000 (UTC)
Date: Wed, 6 Nov 2024 07:34:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/9] ref: support multiple worktrees check for refs
Message-ID: <ZysN4GIc9JELkIKS@pks.im>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYcPwLB5oLTFUo@ArchLinux>
 <ZynFNQ8SnvTJlVdN@pks.im>
 <ZyoVA-p4JXPaKTny@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyoVA-p4JXPaKTny@ArchLinux>

On Tue, Nov 05, 2024 at 08:52:19PM +0800, shejialuo wrote:
> On Tue, Nov 05, 2024 at 08:11:49AM +0100, Patrick Steinhardt wrote:
> > On Mon, Oct 21, 2024 at 09:34:40PM +0800, shejialuo wrote:
> > > @@ -3558,6 +3560,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
> > >  		} else if (S_ISREG(iter->st.st_mode) ||
> > >  			   S_ISLNK(iter->st.st_mode)) {
> > >  			strbuf_reset(&target_name);
> > > +
> > > +			if (!is_main_worktree(wt))
> > > +				strbuf_addf(&target_name, "worktrees/%s/", wt->id);
> > >  			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
> > >  				    iter->relative_path);
> > >  
> > 
> > Hm. Isn't it somewhat duplicate to pass both the prepended target name
> > _and_ the worktree to the callback? I imagine that we'd have to
> > eventually strip the worktree prefix to find the correct ref, unless we
> > end up using the main ref store to look up the ref.
> > 
> 
> Actually, the worktree won't be passed to the callback. The
> `fsck_refs_fn` function will never use worktree `wt`. The reason why I
> use `wt` is that we need to print _full_ path information to the user
> when error happens for the situation where worktree A and worktree B has
> the same ref name "refs/worktree/foo".
> 
> I agree that we will strip the worktree prefix to find the correct ref
> in the file system. This is done by the following statement:
> 
> 	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
> 
> For worktree, `ref_store->gitdir` will automatically be
> `.git/worktrees/<id>`.
> 
> In the v5, I didn't print the full path and we even didn't need the
> parameter `wt`. However, if we want to print the following info:
> 
> 	worktrees/<id>/refs/worktree/a
> 
> So, just because we need the `worktrees/<id>` information. Actually, we
> could also get the information by using "ref_store->gitdir" and
> "ref_store->repo->gitdir". However, this is cumbersome and it's a bad
> idea. So I change the prototype of "fsck_fn" to add a new parameter
> "struct worktree *".

In practice you can also derive that full refname from the worktree
itself, as the ID is stored in `struct worktree::id`. Would that maybe
be a better solution?

Patrick
