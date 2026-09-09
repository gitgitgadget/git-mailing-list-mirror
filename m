Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD923CEBBB
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945829; cv=none; b=fZ85Tzl6ddRxzWgmoCCIlSJ7UdqPzJ1uQeBQ/0Ked6N+tnTUDHRLuEc/WoqhpjTNl0N7bTxLmFv7pnFX1yXO43DF3HUmV/SjEhlfPhTIbjk9CNOst7ip9VBGVwSfgXfab93lVh4BYsh4Utxqu4U6vdxmMN49jHMrYtfMEqwzQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945829; c=relaxed/simple;
	bh=nEwB+DwmUb4+btA/aN3JQJ5U+GYrHiqeXMgw4wtWWnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdbiPG5DU62QAkdIfoRhmCawDQ0jzrRfjlBPRHpfQ6lBbEXu79Jn1NYcaJubNPNrwvq9UfofYFkQv3z3MFMjkePRVehUy6nclMex+aD9A7XzpURYgYvKyex6rzfv1IeECjWZPqQ4ChCV58kwlruaY0+aOuGnk0OQ+9obK/jAKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o+ZKULbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CTrLgOsO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o+ZKULbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CTrLgOsO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1994D1400083;
	Wed,  9 Sep 2026 05:23:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 05:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788945827; x=1789032227; bh=TOM5nonGhm
	33SiQvBH87TwoH8Obdt9TNbiRDKEZUuUU=; b=o+ZKULbDFKchyYDOYC9eb30MTI
	/V7CCuoH9QvSgAi+PcY27BbYn3HbqKBLZW0ZBkdOFHTBu3h/BnpH2tM/Va6h2Tl7
	GiFrBj6yNkc0P1AAx/7domOp510l7JEMQVOMmSxv2smqLG4JKchQb9i661exyk05
	nEfxFdW94Jbt0996GzgVTw/+4bD+bCfoA2Wrx1HOolaU1FNlmVpji/G3GHgzr7x3
	56PunH5ueJl2bMcH0t1yCoDgDaGAiJ/pLcN5NKX943He+g6c9CZ9Vvzeqp7Zonp7
	esWzUEN+UtbVUQC8lMeJ5Jty3TRWDOGny4ozmWVQLCNhN+4HXBGVCzAUuArg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788945827; x=1789032227; bh=TOM5nonGhm33SiQvBH87TwoH8Obdt9TNbiR
	DKEZUuUU=; b=CTrLgOsODSme9v0yOj+Kwyw38BzY7RRt7mRzRis8WTxAztYJPa5
	qGgF0hikF31JbZ6Wiibj5SnTcad4abEdS2fAhyup+6uI2DX+i5zwiFxKIL7coad7
	09Ws0FnLuInaLtBq+mViDC/RMOTlTJyBjW/QXTmGExwtTIfvT+glBC9E63u8m4PH
	nj0AhmFuBErJr9k6L9dtrIxJx1rvSaftKffqCgT7FywrdINFZ5XWeUcajOSqN/P2
	ntG7+tyrIszqBw2GG4W+vBR4UWuySr5QYQerAgBx983tx/5iT4RE80psbCuQ4yCS
	wQXTzTkIeWhJ+Wf91v/dAnrigLz9f9e40ng==
X-ME-Sender: <xms:oyWhasn1VZefA1xg8jyRjcjJNIDFfcnqGFzjG67BKtAfmALaWCpX5g>
    <xme:oyWhai395vBb5IRJQNSFdDBrsHEn9CFGwJG_xlAXBu0txaRWX7HHsee-hjEkgcHZO
    1rjrkZyJEnjKePLem16AmKV6DMeSC0LEu-XNPpxfdyH5J9e4NyKkQ>
X-ME-Received: <xmr:oyWhavpHNvN49uqcQQtQ912YUcl-d8DzXidVwKwCpJBaLKA557kWd_tvv9tCRffqHVcG8g>
X-ME-Proxy-Cause: dmFkZTFRkYaBeIOhonHYd0fRWCptJhQCOECbXmyyZvIhjDwA4EYhW8VkKKsRAqzlZfUzTW
    zZxm8nO7cu50rM3KSb2Y3WC/xwvXKsXJIfH4AT0z0fDFkVNUckPME/KMF89RmYHRc+Pp5Y
    dgx4HPzg+TXpISnhXxXwD4+e7ypLA1M5OJbbNT+InscDanRh7hlUeesmwihU2j3IPM/KjH
    v8ScVhJocyMhRfr/y/ZvT5u2Y9LTO84ZcyYpZeBe/ZVFqC8iYblDwOLeURWUpqjcVy7cP0
    inpVhJ0cICOcyzlEPDw/p1xmi9ZxbETIDHT3b6Eg2O45go3yHvSi3ABy+8DWwXJ/5jTQgL
    nyj6Kqjx6QSxg8o2iehOGwKcR8EUcxl/7iysDN0J3KSQBlNCTONsEf9i3Musa51EDoTlD3
    B+sW/KV6tqqMwBYOy7OT42sagT01xPuQ4R9D5KAA65JmzFc60AVh8DDDEDHKk5pzlB1lde
    sVxnIlYpu31pAsDPiruizW1rSEj6Dbzk3gmHE7YRKXpEDaevkxVlZlhyMEiqzh9hzKqpEu
    ROhB9pn0fB1r9BACaLL8kvRRdh/FdxewGjg5tux4wUwBNh99jXA8GeQNZVKF0ukVSAvW2e
    YndTQcTiOPqa//jG4mS1+M8/xLFLH2FWPgZ6Zx94+TNjbzUnGvlu0GulJlsA
X-ME-Proxy: <xmx:oyWhandPX1LvVtaNh2e4W0xWMf3t3DqxyUTVQ-35-tTbjH41Hnk4yA>
    <xmx:oyWhamr17tSt2PhFPwpVQ7iDdXG6Y7O1KsOf4aG1-czPTjhOcfhP5g>
    <xmx:oyWhagEIitLqcspDpb8e_ENsLPl8F1J8vKhJBtozV5s35IMmRNuhDw>
    <xmx:oyWhauthzW7mFNubjti9btOlS24tp_mnABULVDczFoPGJ9-pUnkfZQ>
    <xmx:oyWharJqSx3ype3XKrzxseJ1yy9onxUniu_j6B0QBuM0-tnarqx7BvQO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:23:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec62df9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 09:23:45 +0000 (UTC)
Date: Wed, 9 Sep 2026 11:23:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/11] setup: allow "git init --ref-storage-format="
 to specify a payload
Message-ID: <aqEln6yto1xVNjqz@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-11-6733c90ca5b0@pks.im>
 <b2e0b347-5847-4ed8-bef9-441fc4dccd8e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e0b347-5847-4ed8-bef9-441fc4dccd8e@gmail.com>

On Wed, Sep 09, 2026 at 02:24:28PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:48, Patrick Steinhardt wrote:
> > diff --git a/Documentation/ref-storage-format.adoc b/Documentation/ref-storage-format.adoc
> > index c5e29ec831..21d62557b7 100644
> > --- a/Documentation/ref-storage-format.adoc
> > +++ b/Documentation/ref-storage-format.adoc
> > @@ -1,8 +1,12 @@
> > -`files`;; for loose files with packed-refs.
> > +`files[://<path>]`;; for loose files with packed-refs. The optional payload can
> > +be specified to change the root directory where references are created. A
> > +relative path will be resolved relative to the repository's common directory.
> >   ifndef::with-breaking-changes[]
> >   	This is the default.
> >   endif::with-breaking-changes[]
> > -`reftable`;; for the reftable format.
> > +`reftable[://<path>]`;; for the reftable format. The optional payload can
> > +be specified to change the root directory where references are created. A
> > +relative path will be resolved relative to the repository's common directory.
> >   ifdef::with-breaking-changes[]
> >   	This is the default.
> >   endif::with-breaking-changes[]
> 
> I think we need to be a bit more careful when modifying this ascii doc. This
> is also included in Documentation/git-refs.adoc and
> Documentation/git-repo.adoc.
> 
> We need to check if support should also be added to the former. For the
> latter, I think the inclusion may be fine since it is only for informational
> purposes.

Yeha, for git-repo(1) it's a good change even, I'd argue. But for the
former I'd also argue that git-refs(1) itself should learn to use URIs
here. But that's a bigger change, and one that I'd rather avoid doing as
part of this already-huge patch series.

You know, I'll probably keep this specific change out and only change
documentation of git-init(1) and git-clone(1) for now.

Thanks!

Patrick
