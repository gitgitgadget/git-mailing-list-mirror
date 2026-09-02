Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1240A927
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340290; cv=none; b=a7Ga1GnrI5Z0kMDZzFG4wwPlpv9DRit4kFNjyIl8NrT1+hgwU5zRdhOSOMVuBJSN89oOVUmM6b7bRMvSkA1blP6MxaLm2ywpEw4baUKe7W7RwcxmSh14yMsobMmoc5w9gojENvwbwR0TpgpjEccFSqal2SOSme6+Tph9b+74yxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340290; c=relaxed/simple;
	bh=yZ9kNcjc6lBsBPPGruX27MdUug+JVojQUJnrxunQxU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srO72hd6vibmaHdMxI8LHh1+QLnJ0FA7nU3sErv+fRSWin012PJllIW0EE/eBjkNB3GHdU+GXJIc8yyEGph9vSqQFgKJG+L0KhPPNxUhSLNfmRhTH5C9JJHC6ErogtyOYkF7nyhfClAUOlGSzXDZIdM+4iJRrqNZSCZK8UBp2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NCSsvFeb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/yqEyBK; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NCSsvFeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/yqEyBK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EE86E1D0013B;
	Wed,  2 Sep 2026 05:11:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 05:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788340287; x=1788426687; bh=G6UX7/1cHn
	R8RPS/3tDOQfApXGP1aO3hoTAlc50w1vY=; b=NCSsvFebqGulMlPUmY6unFV2LC
	UkpQJqDDVChYcweXtQKqPO1sIHgECKORvOQhv6iYKCY9eLxWrjUpruY/aCBsChs0
	WqCdLyR+gejyhJPBa2Xmwt5y9Xs83ukadLK+oDhtjyOVpSkWVfxYW6b535uySlFw
	c/39JNxQnps6PM+x5NHnt96ynFWRW/a05Xge2X1xLSYiAOFRDAURlpc+TGaMVJMv
	PoC2rD2farS/COtDyncpjMOPuOKq2WqJMkg/jZZm2AR1VPdVFvwBX85ktoSe0GLN
	27sL+iC2VArer9J5UlZ1v9FLooazSqwbqKRT/EsU1kvDIgKNYwHN9jG2Cs5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788340287; x=1788426687; bh=G6UX7/1cHnR8RPS/3tDOQfApXGP1aO3hoTA
	lc50w1vY=; b=G/yqEyBKLPTq7f32ERJw1yXxv636lH03rsic5kISuX3NGdWSf5l
	vsqLTxPvLptDmqp2lOoRQDb44u6si+7mqhujrA+gWq25KUCiDe46Nj298gaUYV/w
	PAZBJwvuT1AvYiz2j34YWHyh92ZrN5QmVFu+DLzY95p9I+XT9Op0oaZeoluo0T79
	Kl1EWZl6FLZIs7Nphrpr8nKxw7ysFPm6ROT6LRjbrkLP9Drae6epMLWFbR4oZ0eC
	AxOhr5Vh/5i1rgPdvinmmzWWZ3wCFBr08ZXdGDSMMU8//Q5Kh33e5c//B2wayssE
	BKZYWbOejfXqtionJifvGTOvkuSRu5Os5EA==
X-ME-Sender: <xms:P-iXak4XZGwLd5v3GFgA-AXyoLSaOGzAnXvqIownMpd33Fe7PlwcxQ>
    <xme:P-iXar6fCQw1eAArVbdf9YLEHRV4LLBxa3GfWoOiv4MuyJBjB3OkpWOEgEeIuNqj6
    uVeqCgbAqDUXRN39LJI9_YG-EFJIdh-hgZNwHxeGAOxx5BVrAMy8Q>
X-ME-Received: <xmr:P-iXahGuDgH5kcVfqKsywwRPu2eI1Ver9ZAU4GOfUaVYVSN-Hg-082i1CCM-HFnSxkcsujc>
X-ME-Proxy-Cause: dmFkZTEQ8NqlhcJlBrU2KXxnrBuQCsbwIB51p2UMh7lW9Im9T12ileGqfcFOmrxryNn0wJ
    xigW+IzauOm58+MpMnLnKTb9QQQqmqF/cCkByFBobt8C8ZztWxkX8MHR8KUZUvi/AuQfJv
    snIMRmX2kH0MMnQLUtUp9SMQFZ0x4kmkYj/t7ZKNlcfEwh7vPxR8T7iYiSJzK5bPutgvbf
    YcKcxC0Am1LATt6Ahyw5bbHx3n43RwBDT5XuZ9JR9JGUygSxWU+CrTKhX2PQIZrK1N+Dny
    QVsDvQ87VNLZMLgS3pQSTWiAxmnvKc8wazDC0s78pJ2BgwgYrog9Ql6k4Ua0WgxwPYd0R/
    CqjK8nkCQ3k3WJP3uOZjxLDuDnNqowUAn7B+AHWODlRXwVdQfpVzhVd0tB2alAbtRI1dlu
    rSHDbUIh/VPn6tj9CmES3yw6moEpIbd3BFC5bccE/uWmilN1NynAsnECNwK7MTt4ebGnvY
    t7YIj4z/4c2g/QUdxNBOIOGHneklEqpZ9cXP3ZEjjVHW/WSgZmDDEF29Fi3sengEqWQ9hD
    +CLK6QO9/MeJ6UuYf7TLBy402U+f6Q5QjHDT5UqXCRoCPmFmvTkvoUwUhMnAnFQA/aHNA9
    lyJ6ojdpkrToYrWit0bg2qMXaLWPgzXZjq38QxaKa641TFiouhahduh/4s+A
X-ME-Proxy: <xmx:P-iXakSsKQGwext20GufhFLtw_wDT6pbnwPfk4dCNTD6PBawTA1Cnw>
    <xmx:P-iXaqvu-Z8P1rI4itIo8ZH7nxzPUlxo2pJZC1Jh0CJocQ7b0Twnjg>
    <xmx:P-iXajwsFJf9T_ieE6jQNP3h2gd-GdbG7Ih2yfZhOO0vkhveL3jhpA>
    <xmx:P-iXak5wOR67JWIIuL0JWK10fDxZ0cVsIzc-RQA2uT8AmMW2WXm2NQ>
    <xmx:P-iXavYF06z3XgIX_fBEgwqyaZ-G4trLPgWpnl39WoyYzLIJfkzquwsu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 05:11:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e7c8aec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 09:11:31 +0000 (UTC)
Date: Wed, 2 Sep 2026 11:11:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] repository: make repo_clear() idempotent
Message-ID: <apfoNaZL8dg9OpbL@pks.im>
References: <20260902055117.GA41587@coredump.intra.peff.net>
 <20260902055526.GA41747@coredump.intra.peff.net>
 <20260902062940.GA47676@coredump.intra.peff.net>
 <20260902064907.GB47676@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902064907.GB47676@coredump.intra.peff.net>

On Wed, Sep 02, 2026 at 02:49:07AM -0400, Jeff King wrote:
> On Wed, Sep 02, 2026 at 02:29:40AM -0400, Jeff King wrote:
> 
> > I'm not sure how much it's worth untangling all of this, but probably
> > not enough just to remove pointer indirection from repo->parsed_objects.
> 
> BTW, another curiosity: parsed_objects contains a pointer back to the
> repo that contains it! What could it possibly depend on in the repo
> itself?
> 
> As far as I can tell, the answer is nothing. We only ever access p->repo
> in order to get to p->repo->parsed_objects, which will always be the
> same as our original "p". There are some internal functions within
> object.c which could be simplified by passing around the
> parsed_object_pool directly.  But we also call lookup_commit() and a few
> other public functions, all of which take a repository struct. Even
> though they only use it to look at the parsed_objects field!
> 
> Structurally speaking these should be operating on a parsed_object_pool,
> since that's all they need. But from the caller's point of view that is
> just an implementation detail, and it is easier to pass in the whole
> repository.

I was at one point wondering whether the parsed object pool should
really be an implementation detail of the object database -- parsing
objects should not have to depend on the repository, but it really
should only interact with the object database. I hacked together a
series, but it grew _huge_ because I was of course also trying to bubble
up the changes into all subsystems that do parse objects rigth now. So I
discarded that idea eventually.

But I think making the parsed object pool become more self-contained is
a step into the right direction.

> So we'd probably need to provide functions that operate directly on the
> pool like:
> 
>   struct commit *lookup_commit_via_pool(struct parsed_object_pool *p,
>                                         const struct object_id *oid);
> 
> and then maintain wrappers like:
> 
>   struct commit *lookup_commit(struct repository *r,
>                                const struct object_id *oid)
>   {
> 	return lookup_commit_via_pool(r->parsed_objects, oid);
>   }
> 
> to avoid rewriting every caller with r->parsed_objects themselves.

I dunno. If we want to make this switch I'd say that we should go all or
nothing. Otherwise, if we retain both interfaces, I don't really feel
like it gains us anything at all.

> The patch below illustrates the minimal change to drop the repo pointer
> from parsed_object_pool. I think it more accurately represents the
> actual dependencies of the data structures, but it's a fair bit of churn
> for a minor amount of clarity. Probably not worth it.

I think there is value in it. While deglobalizing our state we tend to
just pass the repository explicitly into the subsystems, which is a good
step. But I think it really should only be the first step, where the
next step would be to reduce the state we pass around. So ideally,
subsystems should really only receive as input what they actually need.
This would eventually ensure that our subsystems are more self-contained 
and that they can be used more flexibly.

Thanks!

Patrick
