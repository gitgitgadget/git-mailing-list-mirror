Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE801D9A66
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956193; cv=none; b=OUx5LEzFy84mtdAggaefkGvnhlqePwcBoCdrEuBs97DE7MyvOlbNdchRrIJIi3Ebi5jfhprpPIgr2DGUZ2gN0SChVtLvQqqekVut9Z0wlQT+mDNME2VfuAWGF6sM7LHF/CbH08/6/Tm6CKpBsixoPWOjPW8byjEW2RoUd1TsQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956193; c=relaxed/simple;
	bh=sp9Y03GCMpsoHwRmzn5v8etwaJQeSVqydu5FBHCeNpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO3mwxn7Byyvs7jNNUrC6tIafXvnsizEgTjRa4B+KHj5x2FXGTo3cIg1JZ9PCqEjm5yRMne0bMlAdjIIrdLtmD/20/ZVszfR4u/BdlapRTjLdgNQ6q4PrirUH3XYcibO//zYoB4P3G7lB0eb/+HyRYr5iXYLd8AUMlIbFnmTuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BIjpLnyq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sipPD1q8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BIjpLnyq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sipPD1q8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E17B7A00D4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 01:36:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 14 Oct 2026 01:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791956190; x=1792042590; bh=KQnnhG4swp
	bpMjl+CAbECZ9IJZc+AZb3bPBw6euzS3k=; b=BIjpLnyqjie8jCJPeZTdzBBBr5
	/tBZPnMHE16M/vHc+FbNQb+2Fj5HY+3uGWAWv4cj1hAyLi3mTl8WbaOxMAp0slKf
	kbYdeaOWHMORmrE6lgCD2nHSc/hHXW0BryRLO9DdnA/eb8GxbNeKvg7tCqhnocGj
	Dilc2nAA6+1l3+3BaQuwF6nCPX9tTdqVEkoYBltMyXLwIWOD+zmarBHLQUPOkvvO
	DnQDlOhUWd/cJzRnJhfSFQ78TJ46nzGRqiBYdUSguz+4/cJm60DuLZzM28DywZWZ
	31oxLRqMW+TdHJzFWUCFBERgipay4T1eDAUEkQmM8zr7jFfvhLsTd/X/MgvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791956190; x=1792042590; bh=KQnnhG4swpbpMjl+CAbECZ9IJZc+AZb3bPB
	w6euzS3k=; b=sipPD1q8VfZ9XWr5wJSb5maOZLC5VwqudYERXfbrnjkHNfFc7Y1
	YAwRD49lJsMSvWTYq9vw/qtVJnmnKFNBFnCQi7widtJLE4e2zPym2n+PsjXHj4hs
	f7O88jWvZTsx8R7rRZslV8QPvXTBuaD3jXfBIEonvk1XOLBGB2oUW4AFY6B2yx+9
	g8V6X5e1Wnk/HVWINZWJ5CBC0ZlSo/yWX9Qdwu1azM/kOzZNqyw4BMqQbOggDyEa
	bI+psjCuPxH2Rnlb61U002zDhwQFi1ypN4tMpJXtfOfBwXq/h6UqG9XErghVAv8d
	IckiYh2PYj/sF18rL6qzVG3UuWCLyLkS4yA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791956190; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GDxsVUzE8LPdGsimhsLcVsGj08gHaE/Ms3d8KtSdPGyysju
	Qg/pv60UUikjynWI4GMQcZMyZbSKjLizc057gOJnOV5YGmvFCGBh1QpCm9GzpTXK
	5rovn20FVdes/ni+IZbCvReEiPC3ojZtqeSKj/umTRv/a6GuSm5FVNJMYyL+reH5
	3pS5tcW0CFH3+ncB1TLVPEXju8/bxLG0En4lU66/Cu66xV8vq1CrCInOuCMCANuh
	GdM1E2qIKf3sIfl9aDWUpZiBbgxmbYRQUKFbuox9GOc6/sutZ91a/6Mioeyf+Zfa
	YGWme54d5FvCw5zWZyRdudfwIZRpYSkqfuaa5HQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J6akP/ycdzqLnSIM7y2S4CdA5/GMgO/EYaQvJWfMDFk=:sp9Y03GCMpsoHwRmzn5v8etwaJQeSVqydu5FBHCeNpg=;
X-ME-Sender: <xms:3hTPagzl7SblP6kSK1lLw9g4HiQ2aXYpaG8PjLTH8EhGDntd4f7hLA>
    <xme:3hTPatm9EMIDGjw8viDszmJlh6SMm76X2bwR7ANr1yLsWfmFLGguk1dz685IU-Yy6
    2Li-mRicI2q0Dby4iCGLk6k_pXofubnoG7ZCSt2qw6mNrdwb3cT18Q>
X-ME-Received: <xmr:3hTPapmaM0SrPL_4CI7SDPNyA_FZbcK1PJL8FInPrh4zLZo-OLdDFg>
X-ME-Proxy-Cause: dmFkZTGoDuhgiBEfKY3EcfYLdkSn3kM8cXa/NprLTw6v2KVbsHjIgX6LWgbGl5oYXR+gqQ
    gTUav0CEyzMcfI+azVn9awjZqArGRjzh7sB/Tl+9N2LmYa8xxcvYN+zBgnMSgUCgwMEzID
    7h+XUAk9Vng/XgNpTECJvCQepv65t+SB//WYVvVTEpfU3J+wEtgZKFqzkU8jqIsGAtE80Y
    Txy7uJZqYOR1Qo39JpoGuepyhDJtMa/83jqb8ybJgRpf7pRJHorJ74kMy4OFrwmiTxpKmk
    K6Jwo58cYrl9PVV3m9z4vSl+e3R900nFr06ai65aHPZrifszeYhJfYNwQRfl/tUC7l2oEu
    l8LCqPjEd6n2hZWZgNZ3AkowwLY3QcrozxJl03v7SlkxbAboHxsVblHKereID5qmHSEla1
    OMz0Pjj+qSfGFrGhYtMCcQJRqcAZEc1RLNHKbW8iHmbV0A33Twmg/xJAKcoS5FjvMdLnDf
    miLjYoFHpPRg+uKVpfhV0VSs/978ix/ItFqZlIx5H8ez5r9jccJGZ0ew+8e0OQK7TeNoNw
    sRtk3wXFfcxnIgZxG4QsmT3MkJ87ZSlKlfCgEzhP0SQb9ujYB3QGK/OOVMVivwuwSj6xg8
    zdwoodmFCB6EACk2cOA0reboDuZNnBstdTfzyY/pQCrrtr9aHp0vCCel6saA
X-ME-Proxy: <xmx:3hTPavxnGiljuhQh8F94lNEcmyY9sTvoqq2AzD56WWJukqCuPsDV4w>
    <xmx:3hTPauokA6zPYvybNMAx_BGvwHs1rz_wz5j1ma0FBzVkIIl6LS-1_g>
    <xmx:3hTPau73BgMcUOkzf-JgZDFBp4FqeLNlT4hjR3WLnc_oEy5oWAdktQ>
    <xmx:3hTPaldAY2tX1g1Fi62uzBzdYsrMW5lhG1rhWZTTe3ZWTiv6ciBccQ>
    <xmx:3hTPaltSCQp3jUZ42W975oyNOS96kaN1XpNXFRLBeBvjF8Ck44b99FII>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 01:36:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b9132d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 05:36:26 +0000 (UTC)
Date: Wed, 14 Oct 2026 07:36:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v8 0/2] rerere: wait for MERGE_RR.lock, but not in auto
 maintenance
Message-ID: <as8U2Ao_oX5KsI1b@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
 <as4ikRUi0NZv_jKr@pks.im>
 <xmqqy0c1zi6j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0c1zi6j.fsf@gitster.g>

On Tue, Oct 13, 2026 at 09:20:04AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Oct 13, 2026 at 12:07:51PM +0000, Thomas Bachem via GitGitGadget wrote:
> >> Changes since v7:
> >> 
> >>  * The rerere.lockTimeout entry no longer says that the command fails when
> >>    the time is up (Junio).
> >> 
> >>  * The lock tests grep for the "Unable to create" message about
> >>    MERGE_RR.lock (Junio).
> >> 
> >>  * The wait for the background unlocker is now in test_when_finished
> >>    (Junio).
> >> 
> >>  * The rebase --abort test aborts its rebase in test_when_finished, so a
> >>    failed check cannot break later tests.
> >> 
> >>  * The test "merge fails once rerere.lockTimeout is up" never waits, so it
> >>    is now called "merge fails on a lock it cannot take".
> >> 
> >>  * In patch 2, rerere_gc() takes RERERE_NOWAIT again instead of its own enum
> >>    rerere_gc_flags (Patrick).
> >> 
> >>  * The comment about waiting in setup_rerere() now says "by default", and as
> >>    in patch 1 it sits directly above the call that takes the lock.
> >> 
> >>  * A comment in t7900 says why the tests with a held lock create rr-cache.
> >
> > I think this is in a good enough state by now. Thanks!
> 
> OK, thanks for writing and reviewing.  Shall we mark the topic ready
> for 'next' now?

Yeah, let's. Thanks!

Patrick
