Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0303E9C2F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437988; cv=none; b=jLUl4mEM8AnACnijBoph3RK5cwLw/F6zEuyxhUB43D2kzUNUxByyreOpFiPeC3N2Hi6GunCG8lEiCW1kEo9L/jC4su9hRiVw+uBtxCxfh4Ynnfur6wxNH2ik4Q46P0kP/8LjElPMnvm79SF0YZgfE2QH+9d3ZhyHPdefBAaq85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437988; c=relaxed/simple;
	bh=G019Q0pcp1AextoSiufooAsg8fUM8F3mwU8Fm7kP9nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4GyUBaNkt4gZ07KwFFvBAdUAh5lgLcl+4T89NjZNH0W3f1ICNVzk9F0KavVyqLS+QUKXiePhgD2h9OVhA7GuKO+uXiT6qPjc9l9mR9gZdYLkLvliwxnlF+ncf03wG1kGf7tbsEkfy+bp5x7+dCYXhoS5Hw+FCXw4IiZcGn3TpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MnDbbI+u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T5vMmfiy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MnDbbI+u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T5vMmfiy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 81423EC001B;
	Tue,  7 Jul 2026 11:26:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 11:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783437985;
	 x=1783524385; bh=xlZqoB//hR6KnPDLD6XHzNPnIhDFmTH7KlijwVZudT8=; b=
	MnDbbI+ufEa4m0RdELwvRFE4tJEd4AODYRCHff6EpLgAmfEKwMt9WugSmzf3WLH1
	v4Z1gd0ZqMkQ+83M176g9fwr5rloRm79spGoHAz7NWbV6ASi72Uq1lna/yiBcsCI
	3Kz8zyqrApkaexaFL81r6nZDeQJO6xyOdCtPFG0vWvTNLax95wbCZt9sN1y15mHe
	5v/KblJFb3heVMXRa/kqhg5P6IGFTqMqU2U3Ay9orfWs5f3vrWyIcC99Kbyr5Zw5
	yDdc2wqUcwd2+fVFsKp+EcPMF+9SZFAt+7Qtcctxgcbvug4LyYJ7J6TpnKQ+QHCH
	HYoO6SDP/CYrk/D7hmbR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783437985; x=
	1783524385; bh=xlZqoB//hR6KnPDLD6XHzNPnIhDFmTH7KlijwVZudT8=; b=T
	5vMmfiy2atsuO9BslmgZVncx7eEwUDKsxlCdqOYAknaKVIvgWXVbAa9PTAUBCV3n
	TCdkN60/kl34kQa6pBqTubxRirL14gNXYo8uMiIGESLmTQhdI/fVZfCGjA+RNDIv
	iiCtEmegjXWud9olE7WUrMgRjblEaJ4F2M/6ZAlv4+j1Auc8PD47ziauiurKfK39
	ly5xr7IwTVFcxv+/58q4mJwoGOXhH4BodQF2kfLPEhQK8O1nw8LT1gOp2L8FkmpF
	qXDyYp7AfOARTqsncjGaOTiYc06COyIYE26q1oJyuIpQn29gjF6XzOVGzUaUqZQc
	GeOK3OdmzcmuckMmKc85Q==
X-ME-Sender: <xms:oRpNagZi0Z2Kqii45zVB1HZbhN9uBfwxghhAXcDhUWE7xEkYjWlv_Q>
    <xme:oRpNas5KYWecbzIPECCU4NHlM5cnlcj0YTyP4kMZwSMR6lu3n1rbDDvSsuLyOVFh7
    N6R3BEtXLJ8WmHO7ew01vDPDgLCTnzZCM1IGi5OiXbxUYCzOyQ_Hw>
X-ME-Received: <xmr:oRpNarCqnzz3t7BaE96xHCE-gCxcvPuJPXutvkLkFS4Qi8GVhcAir2pzPKuGQGqeIZwwhOfVDqsbwM-vla3cpntUwEQC84pdKdGerccvWA>
X-ME-Proxy-Cause: dmFkZTGWcv0FJ3Sk+fRKTsD2b9Pluww4GLX0XXiMwJUp0j9n+TNJlncDt4+mD3FCmCnPc8
    GEL/7L6khLzQchkYcowncYPihoAEgg0b19UXwSRBM4SmzdHUAhkV416YeEesR3SOOAWHtJ
    HcW0m0bkPZFsiotei5feZ1/zNmeUBI3Zx2D+mXLzFuwPoJdN6wUlcBsvrzaf25V+rE4pVg
    MtJpnWU7Lw962isO30b6UFeRPwvcsMAx9MOvWi38if0mXQG6DhSXvW6Xj82pywmMR4WWom
    /FyaYSZG80rjmPwlevw10pvU+Xn30v0XuPivucUxAQJEZsOBWQn06DDZworCZKnf/84ojo
    I19O1FB8w5B0nQis7gTeXHumPQFk6+RieHQsqBRdNKjZY5XkFHAimssQqy+EdKL3j5LZ/U
    5prCPikTAArR30+WoxCA0xAPQhfdBEIifhl2PNl3qTSf/ufPhPUBYQEk0nKcAbHoiD9NSh
    SSNwLEF4gRKteLTrgWfcoorQP1GJN1hxH9239PWp4/8Als3xBuDIYyh9BNbWmq4+xxY8t1
    3HLeYqUCcANnljBXgadh3zeuITutj4EeuuA9fmow1Lu5Zhh+4CKtS0igjHV7Hvnd8rjO1z
    yhc6r7TmvvWbuy8W5HN5ivC8dc9TlqZ59PMsJvqsq4Pp+XDmvJ21zjliOLxg
X-ME-Proxy: <xmx:oRpNaqcmkkGifCg43yHUKqgWerSCRSWxUAWavr-aDxGR2ar1O2MY2w>
    <xmx:oRpNaiLHIQREDsMUI4nq-WTCAbu9vW6rWnZdqGedF8MMNmAw3EdRwA>
    <xmx:oRpNat2WEyJOw8p1Ho5v5BPzsTcb2bHGJCbHo61lGgLXsVLBAIcV5w>
    <xmx:oRpNasgkYR4bJ2Qalt469eDf0RwkRolcumJZUu74I2J0zAyhdFXyig>
    <xmx:oRpNahdzoZbwL0r-2VdcVRynp-KjRSvqCqW6OeLD0Og4Ubx3xdfeMSu_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 11:26:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d52214a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 15:26:22 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:26:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chen Linxuan <me@black-desk.cn>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
Message-ID: <ak0am-pEdtOvyBp4@pks.im>
References: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
 <20260703-includeif-worktree-v6-2-a13893ad9a7f@black-desk.cn>
 <akeW4yFC8uuu2o8a@pks.im>
 <CAC1kPDNBecLbmZwjfR5-CsNheF3rcbZ5=SQ+cwjzpFMjFr9KGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC1kPDNBecLbmZwjfR5-CsNheF3rcbZ5=SQ+cwjzpFMjFr9KGQ@mail.gmail.com>

On Mon, Jul 06, 2026 at 08:18:39PM +0800, Chen Linxuan wrote:
> On Fri, Jul 3, 2026 at 7:03 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Jul 03, 2026 at 11:13:18AM +0800, Chen Linxuan via B4 Relay wrote:
> > > diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> > > index f3892578e4ff..4e840dfdb35b 100755
> > > --- a/t/t1305-config-include.sh
> > > +++ b/t/t1305-config-include.sh
> > > @@ -396,4 +396,132 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
> > [snip]
> > > +test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
> > > +     mkdir real-wt &&
> > > +     ln -s real-wt link-wt &&
> > > +     git init link-wt/repo &&
> > > +     (
> > > +             cd link-wt/repo &&
> > > +             # repo->worktree resolves symlinks, so use real path in pattern
> > > +             echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
> > > +             echo "[test]wtlink=2" >.git/bar-link &&
> > > +             echo 2 >expect &&
> > > +             git config test.wtlink >actual &&
> > > +             test_cmp expect actual
> > > +     )
> > > +'
> >
> > Okay, this covers one scenario. But with "gitdir:" we're actually able
> > to use both the symlinked and the real location:
> >
> >     test_expect_success SYMLINKS 'conditional include, worktree matching symlink' '
> >         mkdir sym-real &&
> >         ln -s sym-real sym-link &&
> >         git init sym-link/repo &&
> >         (
> >                 cd sym-link/repo &&
> >                 link_path="$(pwd)" &&
> >                 real_path="$(test-tool path-utils real_path "$link_path")" &&
> >                 cat >>.git/config <<-EOF &&
> >                 [includeIf "gitdir:$link_path/.git"]
> >                         path = gitdir-link
> >                 [includeIf "gitdir:$real_path/.git"]
> >                         path = gitdir-real
> >                 [includeIf "worktree:$link_path"]
> >                         path = worktree-link
> >                 [includeIf "worktree:$real_path"]
> >                         path = worktree-real
> >                 EOF
> >                 echo "[test]gitdirlink=1" >.git/gitdir-link &&
> >                 echo "[test]gitdirreal=1" >.git/gitdir-real &&
> >                 echo "[test]worktreelink=1" >.git/worktree-link &&
> >                 echo "[test]worktreereal=1" >.git/worktree-real &&
> >
> >                 git config get test.gitdirlink &&
> >                 git config get test.gitdirreal &&
> >                 git config get test.worktreereal &&
> >                 test_must_fail git config test.worktreelink
> >         )
> >     '
> >
> > The last call to git-config(1) fails, which is inconsistent with how
> > resolve the path for "gitdir".
> >
> 
> I investigated the symlink mismatch.
> 
> `gitdir:` works because `opts->git_dir` still preserves the discovered or
> user-provided spelling, and `include_by_path()` matches both its realpath
> and its absolute non-realpath form.
> 
> `worktree:` is different: `repo_get_work_tree()` returns
> `repo->worktree`, which is stored by `repo_set_worktree()` via
> `real_pathdup(path, 1)`. So the symlink spelling is already lost before
> we evaluate includeIf conditions.
> 
> Changing `repo->worktree` itself to preserve the original spelling looks
> risky, because several users access `repo->worktree` directly, and setup
> code appears to rely on it being canonical.
> 
> My current possible v7 approach is to keep `repo->worktree` canonical,
> but store an additional absolute, normalized, non-realpath worktree path
> for `includeIf.worktree`. For the ordinary discovered-repository case,
> this has to be derived in `setup_discovered_git_dir()` from physical
> `cwd`, the worktree-root offset, and a validated `$PWD`, because
> `set_git_work_tree()` is otherwise only called with `"."`.
> 
> This makes your suggested test pass, but the plumbing is less trivial
> than the original patch. Does this approach sound reasonable, or would
> you prefer different semantics for symlinked worktree paths?

It certainly sounds a bit ugly, but I'd rather have something that's
ugly than something that's inconsistent for our users *shrug*

Thanks!

Patrick
