Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAC233126
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180200; cv=none; b=sxtcwnN6c9nxejrIC2wnuoDr7RDcrh/9/q1qoTIVh+p2XMz/OSYgwG7qF6H3a3AJQjKWtGca5ilVY/l0VcsvDoVwAFZITUYSPhR8h61hxaU2v9qDez1Xj1hlqt9Oe6BK8Kpb1tqg7FDJKbYFgnLrCevxBpqJDyXZedZ/+G+Nb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180200; c=relaxed/simple;
	bh=aarCsKQVxsIkVa+Tz0LmnGv+0U/acel1xg06aST6KZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h75ISbnxTZvNnaZPbKSEDLAzU42pn/6LHQnd62PYIMxIz1TZW85AvkPdtibU/vbDVi+KhALiAbjDIq7HJO53bA523qYtautU7UusmRW1k6O7pxem/M4YrQTT6r1ovH9RxRCAtfk0GAFbVvPuwbtfTazULofD5B62XGZ7rSMNcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NMyaFg6N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxT2tb9q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NMyaFg6N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxT2tb9q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DAB51400094
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 02:03:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 02:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791180197;
	 x=1791266597; bh=DWeGYES5rlKB6u71kok0jSZy3+xwJ7+ZGo3shJYjdw4=; b=
	NMyaFg6Nc2gZxeBTCXdMj8qTVsTwJcp7elk0gzz6Vh5/tBpaokVD5N1+pIM2dxiz
	fW3Q85f3Flb3Pqe+SlPQfSADdaRyDihZz69tRYpG8s1TwrKIDC7FgTOUB1HgOLRd
	+iYLk5f4YY8Dh9Wel/celsvPrC25dkuzolFjhBoA7Ro3BXRtBaK5NJj0UNLceDzs
	K2ifCh7bvL9tk1AYagF/LGOExN99c3+ASlOabkE7WxTseMyZX6ut8s+Yy4WRUiXO
	7DTYYa0BKgoD4PIyHccPPQFiVElYwZppXPxkzZXIswFYjv11TTCKnUMeW/rzFr1j
	l//dmLkXgrBOU8mcU5IWEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791180197; x=
	1791266597; bh=DWeGYES5rlKB6u71kok0jSZy3+xwJ7+ZGo3shJYjdw4=; b=J
	xT2tb9qq/vYEXCB+F/8MO7k8jNLUrmqv6I7WGJ5FpNo+q6VyF3Mm6nokyoSDtlfZ
	WJEbH5xc3hCcLEv16mVx7MS0dTLkzBSywPztAr7z7Y2792Iv66QqzaL+TfbnMcj8
	CZPc9a6TN0le9pp4Ndt9Z8ch2ERJaSp3ZN4MlDKax3jO+kGbSouaojWb9P00JT1O
	2z3L8JmdWpPlc8Uc7J5GRZ65Y04AIilis5ynL/OmmMAtF8BJTQGVUHVxQ5UhAijH
	V5ttck138bFwKWNS3BkG63yX89ZyEGP/rTv+DSAlBp3KqBV29vWzWPTVFbNsJyfi
	ZDAGWAwrvpCH/FQBPLvcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791180197; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VdivYNnMwyHSsP5d8ClaybyGmYVEXCS5g1jpztFiR84sX3K
	mz9WQUFDgTEZHXowOe/6m5KjsVxzxIidjBlDk3NsnH/zFrE+N6DG4H7mST+QwEdW
	2u/Wf8rEQHm6UThy8AnfKw+4QbxAUcbSeEqwbPDFqiSPYxTFa1gcI3Fn26BC0yiu
	WAAfqlD+yan1U7RRWVgVQniRVsFGe+3Yq+5Sla8UEn6/blkwThfe7enGKzhDzHwC
	1BO6mFLM5dcolTlsasm6pDAq2AXpNbDZKjKaT44KBk6KkHGVUn7bostcc6hOqoMU
	k6aXvUQdqYioW4O1fhP62RmCbLJ7iQ29KZaI/iw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+XF6U+OdaIygqeFJORQQavvI4zkRq+lq2CiUGkZc6RM=:aarCsKQVxsIkVa+Tz0LmnGv+0U/acel1xg06aST6KZE=;
X-ME-Sender: <xms:pT3Dat4G9pfYS_Lbie7BzraabNmAy38j2p2RqXmk46GpvWo-Nv1YNA>
    <xme:pT3Dah4hw_mTN7Wgt15cMf2wVF_F8z-mlH0Vj860dqTeDVyf93s2GFfV31rYWinU9
    oM8uPy7NUK9gpLA8mCSUU6-4EIGE8HOguv8Hus9Lm9F908P-2hD8w>
X-ME-Received: <xmr:pT3DapcbaKHv79mUd0sUfWPcEXLqM4rjO8THPS_L77y1j4V_7njzAXPdkxIHWZ1I3ITaxX4>
X-ME-Proxy-Cause: dmFkZTGA3om02MEqX9VGn8igTXeuy2X0lEUouSzBJWH1BfTwf8Hnr1LG68n4o6//USC8J3
    GsTe4TYzCmgRh1srMJn+Fib5l0wFgs5i0V4t7ZcqTcXi8MdF+J2XGbwoDwlaZX3jUrGhXi
    eBcd+I8QToMpCPY/jIbvpcpsSTqhr4kZn59DEwOH/C+1T3ObFL96UyDFbXJP9PxXOBR+2A
    /B70YZyWH4zs2YRkfbEin6GBp0QtD7HHklNipaObD3auyAByx/dwkP3OTxrQ+ACJSnoxlr
    89tx5HjIw8wNRIPnKlvoKcTv42Y2QK3H9lYJPBPXcSsxXoQi9Ry0vbX6KDmy/6vnofegVE
    1Pl3emasMUzN4xc3FD/eS+g9fctWSvzS8hyg11pJmdX6VrNDbpRu2g7laco7Cn+QnpQFOW
    5mzMHc57dbvahhlFTnC/NznysE5+Q12vkCiqFCkzPaWh82WeSSNlJjs8Wp25Tp8xx1e/QT
    zkljYm8l0jst7oq2G9H3E0DQ/NZV76cEgZGl06+GT83Xk0Z+h3n4iqOCsT3z/xacml6eds
    bks90N+Nkpj8RjJhW8IND4PJSvTYCvSDE3gLcR9DISWp36hmg04GokfVjeVUc2/6sYqMxs
    DlP64B2NW6FUjYRyWLC/OkJLzedUhyHBc2s/OUxIaotEd1WFI9YO5UuCG5vg
X-ME-Proxy: <xmx:pT3DalB3cXxe5-buI0xnbf6gIa14nOtARW7JzBFXnIBBWwDKo7P5zg>
    <xmx:pT3Das_igvgCDHWK-5RP0liP5ji22sDUO_RFqFsz1N2m-3xnvr0w8w>
    <xmx:pT3DagLa6k62FfSi5WXCJVuuJ3pW72Wnf8KFLVByVIrtz-gECP6eiw>
    <xmx:pT3Daliyn9eOFohtuac9cRNhvLzKCdP3qacFG-5i0AsCVTaDP0J-ug>
    <xmx:pT3Dao8E8pxa8zOVjAnUv_UohwCEOWdOTJ9MGD7hERsgx5F_xF-hfcpL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 02:03:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a34abadd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 06:03:14 +0000 (UTC)
Date: Mon, 5 Oct 2026 08:03:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com
Subject: Re: [PATCH v2] refs: run copy and rename through transactions
Message-ID: <asM9m-_ZoX_5UQ-I@pks.im>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <20260923133651.74120-1-maciej.ciemborowicz@gmail.com>
 <ar-N7SA63fN_xx9P@pks.im>
 <CACQ=SRGSEsbNz3v3obd3JUOs2MrROnvuHkx1Dm51seCcv+12Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACQ=SRGSEsbNz3v3obd3JUOs2MrROnvuHkx1Dm51seCcv+12Cw@mail.gmail.com>

On Fri, Oct 02, 2026 at 04:16:08PM +0200, Maciej Ciemborowicz wrote:
> On Fri, Oct 2, 2026 at 12:56 PM Patrick Steinhardt <ps@pks.im> wrote:
> > why can't we make this whole mechanism completely agnostic of the
> > backend and implement this via pure transactions?
> 
> The part I was trying to preserve is the existing reflog semantics. A
> normal ref transaction can express the logical ref updates. In example
> deleting the old ref and creating/updating the destination. But branch
> rename/copy also moves or copies the existing reflog history. For the
> files backend that currently involves filesystem-level reflog
> rename/copy and D/F handling, while reftable represents the same
> operation differently. So my assumption was that the logical ref
> updates could go through the generic transaction API, while the
> reflog-history operation would remain backend-specific.

Yes, the reflog semantics should of course stay the same. But nowadays,
this would also be achievable with only backend-agnostic logic as the
reference transactions have learned to write many reflog entries for a
single reference. This was added back when we introduced the migration
logic to convert between two different backends.

Now there's potentially two caveats:

  - I don't think we have a way to delete many old reflog entries yet.

  - There may be a significant impact on performance.

The question thus is whether we can avoid or fix those caveats somehow
and thus arrive at a more future-proof mechanism.

> > Is this new behaviour? Is this retaining old behaviour?
> 
> The source/destination revalidation is new validation required by
> introducing the preparing hook before the backend locks are taken. The
> hook can itself change one of the refs. Without revalidation, the hook
> payload could describe one state while the rename/copy later operates
> on another state. The intention is therefore to reject an operation
> when the state observed by the preparing hook is no longer the state
> being committed.

I don't feel like that's sensible. The "preparing" hook is explicitly
run before we perform locking and is documented as such. So it is fully
expected that the on-disk state may still change between executing this
and the "prepared" phase. It is the responsibility of the hook author to
handle such cases, we shouldn't do this ourselves as we're now starting
to assume semantics of the hook itself.

> > Sorry, but I'm going to stop reading here. This is not in a state that
> > is reviewable and has way too much stuff that is obviously generated by
> > an AI without much thought being put into it by the author. I don't want
> > to invest my time into a topic where the author has obviously not spent
> > their time thinking about it, either.
> 
> I'm really sorry to hear that. Yes, the patches I prepared were
> AI-assisted, but I do feel that I understand what I am doing. I would
> appreciate some understanding, though, as I do not work with C on a
> daily basis. The bug report and my attempt to fix it came from the
> fact that I am working on a Ruby gem for per-branch and per-worktree
> containerization. That is why I had to write git-hooks-ext, which is
> how I ended up running into this bug in the first place.
> 
> I am not insisting that my patch should be merged. I simply thought
> that submitting a patch might help get the bug fixed faster, and
> getting the bug fixed is what I care about most. Karthik Nayak offered
> to help fix it, so perhaps it would be better for someone who works
> with C on a daily basis to take it over.
> 
> I can, of course, also prepare a v3, split it into more commits, and
> explain my reasoning more clearly. But I cannot guarantee that it will
> meet your standards, simply because I am not yet familiar with them.

I'd suggest to iterate then. In the current version this patch is not in
a shape that is ready for review. The patch needs to be split up, and
there are a lot of gaps in the commit message. Taken together that gives
the signal that you don't really understand what you are doing.

That doesn't mean that you cannot fix that with another iteration
though. But I'd suggest to take your time prepping the next iteration to
read through the code, understand the concepts and doubt what AI spits
out.

Thanks!

Patrick
