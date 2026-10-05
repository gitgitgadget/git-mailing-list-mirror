Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868C32F75B
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180671; cv=none; b=ecoIxp3B68TQ03CnOmk2sKDfkmHyfvqm+rhwA2Dp01bcuNKkhLGpGZ7rJL3dTLZqch3iho5lx4OkOZjDkxH3vVXnys9DRWVCV3AXIHPj1eYf17Hjbe67avtD17/Y0mXWKKRC0hlo9rJASZ9vmQESnB3dh1UcxMw40a73UDENNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180671; c=relaxed/simple;
	bh=kKjz9f58+SUy9y2fYxTqgEpeYTdckNzHzYwKIfNjtg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8FTr4OQP1T8FF0csb+5SDq21c2RGN7Ybdf44AnaYYGJg+RUunULIi0xVQVtFil/vPq3OwZ2DSo99z+R73Q/eNwZv/gb6FvelLVw3fnEul8Zuduft+6u0JAwGFiwYoy32Hj0MyCq6ivcS0m11PLseNwSHQ28PFqtT6MaqnPIdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r03Y1iVj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O9iKG/8x; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r03Y1iVj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9iKG/8x"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B67A71400100
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 02:11:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 02:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791180667; x=1791267067; bh=KLcoi8EkJJ
	uUJxQ20SVr5jTXcBJnp5skjjG99aT6diA=; b=r03Y1iVjOnscg/rIijK/vjBdhg
	ZLQaCu2hkYMlWeQzd/QuT9Q3PWLmgJCw7u271xxiUQ6Ns/4AA12yMMps+0ysCVVd
	NLjK1Erri8/z++/mOzYdIERj1JFyactOw97+sU3wuv7MqtxZGXSkoG+pfij0Duia
	gtp9MI/GClVem0orRA09ylHXEFSIvg6xgl6X4DxFMtnrREsui4t66jmRMyxqSjOM
	h/tOjj8KteZLYVRNrd9KhTYlXiRQzCnjdGXb9D6yWqwKzuSrtD2XyIGkMzV9RGo+
	9LR4teTpNFylmKdJk9B0qUA0o9T401OwMfy1af89Am4MmEXLf+G2Hi5EG1SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791180667; x=1791267067; bh=KLcoi8EkJJuUJxQ20SVr5jTXcBJnp5skjjG
	99aT6diA=; b=O9iKG/8x+H3RASeYbc3SxurrfruaANSCtPi0H+tw9+y8rji1pIc
	ERlUngkya0I43C6acD0dNwv4+mE3t/b4u8bwWjss5ZuWTtGJpCtdC1Sn4OjbV8mN
	LRKT23DnWzf/IEW4SR7c2csHezwol4bk/heq1xPXDZlTd9bE0U/8jKJk7ZLMPCWH
	waBiueiIh59W8RgUCCMNAmsuOEhQrlNARHimEsa7IAiU8izi2l6+A7MRPE+vlEY4
	A8y4LTE7kwAxQmWT2kQBus7ref2iTiMc/q/SbKAkXtvb+8e+eMhTdm22CIY8JehD
	WUYJSIeBIlQK/yOiWTDuJVvWjWSWCXKTAnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791180667; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GdGxekJBiZE7FhC37fFlrramqhllbrKh9g96gNAOvqQ2ACt
	5FXHzkfc5DAQKwfHgWUSqQe8/XbahITfVuQqc/wsIzhr21jFU+So5dQVnemQDaT4
	mGkbn4Mq+b2nvkjOdIUayhL+d9nlv/duybZBotBmrA7zRBu90U/HcirGu33S968L
	10y3OVXLZ6pBE7AWpMf4IB260JXzPHetOwZ/K5GB+b8jZud3jTXBin/cwgOe7tPC
	QZCZh4cAJZgZEHpFq1xo4ydbrU8wcZWyJmYX+3PxWiih3SzFJv/U0HkYfuu+C/Zv
	vSRj3l+CKthuNHfPPgwxOcXGTdPZNCESbu0ejyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DWeWvrr7GBRlFg9dFODyFJXJPcSeUfUi6IdcEY5nCOs=:kKjz9f58+SUy9y2fYxTqgEpeYTdckNzHzYwKIfNjtg4=;
X-ME-Sender: <xms:ez_DaskMKeDsJBBO1iBov5b-VKwUwul6yxdkV1XlL3uQwyQ3Pfzhjw>
    <xme:ez_Dai3Icc33_O-akBOLrb2ayXVzXohXASIfpXGvMiImP8UYkEFIe1OBoPiqiG7qq
    wi06oP4JKwx4ZmhgKAtRp_ajMoJV-T03Jb72Fxx0TVPb9QVDYI6>
X-ME-Received: <xmr:ez_Davq2sLA7IdTqofxB7beiib0G6jZHOyjw7AI65sxXk8BGfzvKsQuqn6EpUDZ2Rj59Gss>
X-ME-Proxy-Cause: dmFkZTGwuXTpFx0X+Rng5Hsy9U7lpKQdlTKhy21upGUXAP9IFJafpgebC1neXnpP4V5IW7
    zUfK51KzgD71PyDInBLu9yeSZi6zkG6Ree+H08Hn/reTmOkcKN70jD2VJICPbIWXIaP3uq
    MwWVeC12SXyOoSfE+Nw874+n5/6uBDI1xV00Q4CBkSPpxDxvqVU7iK27L9dG1aw3lHqV1a
    ofq63fXqcd/eYD5F+4ZvyMdNXKrJCSZ9WCejT0zZZFGTgv8mSHRUQ9xjhiBL8DkcN+UmBD
    VUvzWohhLKjwIDflf8FsHH0XmBU5r4u1qUl6e1AN3WQiKPt+IGK+g6p9mzm33ltR86F4d9
    Ingn1nm+PIrVyl4lEUHzynSf0V7AlGj3x10cJ6fu4ypdoruTbGnG6uGgcIhvZOcCgCju9C
    EzJkCfGfP4EkZKtOEWo+xj5NAkCYP7m/udWSmTIEdT6aLohqSrxz+8+XLiO1voRhDTky12
    QwC2R2xRjby0vBEw2pfKcGmIyPLwKUPFUduZHtPYCviKzhIHJZ3Q23BmpnbHsMOHf8xfqW
    9JKoN03Jlvk9r808TfZdlZ+lGnIOouFV5uyQBazvb0dTZyQeqPIQA4/XSXLMmX1vOgNcqO
    yhlrT6VNU722XWFZ45kLeaNNZbkVCxxTzrsjVRlCP9CjViSTTnzwgGEDMSGA
X-ME-Proxy: <xmx:ez_DaneSOlOaynmU-hvdKO0usE3yZX-eBgNGYc7vMm9vMb7F0d73YQ>
    <xmx:ez_Damp8fPTcNnv83-yrTcvSQ7BSv0Ifr_EImWzUAs-DQnEChbMCyw>
    <xmx:ez_DagGDFt3daJ2Tj1MuL3IzqpOUuqPszKN-o-YaM_RwyWFkNSapgA>
    <xmx:ez_DauvAH4eZ0OguidiG79Zc9RnzzXTPy6z4jpo6OHmN7eo5FyCchQ>
    <xmx:ez_Daq5pJpR5l7l4TlDITchjpsUl1HqcqngAFVKbWiA-nX0ZglysboJp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 02:11:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60f52126 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 06:11:05 +0000 (UTC)
Date: Mon, 5 Oct 2026 08:11:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Grant Moyer <dev@grantmoyer.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michele Locati <michele@locati.it>
Subject: Re: [PATCH v3] filter-branch: fix commit map init from state branch
Message-ID: <asM_dqY2aSdplISU@pks.im>
References: <20261001012347.3998801-1-dev@grantmoyer.com>
 <20261003010128.256757-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003010128.256757-1-dev@grantmoyer.com>

On Fri, Oct 02, 2026 at 09:01:27PM -0400, Grant Moyer wrote:
> The "--state-branch" option asks git-filter-branch(1) to write a
> mapping from old to new objects into a branch to enable incremental
> processing of large histories. This object mapping is stored as
> a simple blob at "$state_branch:filter.map" with one object pair
> per line in the format "$from_commit:$to_commit". Before processing
> commits in a subsequent run, the state branch is used to populate an
> object mapping directory, where each file is named "map/$from_commit"
> and has contents "$to_commit".
> 
> In f6d855091e (filter-branch: stop depending on Perl, 2025-04-16),
> we refactored git-filter-branch(1) to no longer require Perl,
> but accidentally started to interpret object pairs in reverse (as
> "$to_commit:$from_commit") when populating the map directory from
> the state branch. This can cause all kinds of bad behavior from the
> state-branch being effectively ignored to previously filtered objects
> accidentally being mapped back to unfiltered objects. One especially
> evident case occurs when "git filter-branch --prune-empty ..." maps
> some commits to nothing, then on subsequent runs outputs many errors
> while trying to create files with empty names, like:
> 
> > /usr/lib/git-core/git-filter-branch: line 305: ../map/: Is a directory
> 
> This regression went unnoticed because, since the introduction of
> the only test for "--state-branch" in 709cfe848a (filter-branch: skip
> commits present on --state-branch, 2018-06-26), the test accidentally
> passes even if commits are not skipped. The test checks that after
> populating a state branch with git-filter-branch(1), then running
> it again with that state branch, the resulting filtered commits for
> the first run and second run match. However since the filter used is
> deterministic, the commits always match, even if the commits in the
> state branch are re-filtered.
> 
> Fix the population of the object mapping dir by interpreting
> object pairs as "$from_commit:$to_commit". Also fix the existing
> "--state-branch" test by directly exiting with a non-zero code if
> any commits from the state branch aren't skipped. Finally, add a new
> "--state-branch" test which directly checks that a commit from the
> state branch is used when incrementally filtering a repo.
> 
> Tested-by: Michele Locati <michele@locati.it>
> Co-authored-by: Michele Locati <michele@locati.it>
> Signed-off-by: Michele Locati <michele@locati.it>
> Signed-off-by: Grant Moyer <dev@grantmoyer.com>

Thanks, I'm happy with this version.

Patrick
