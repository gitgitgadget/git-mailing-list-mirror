Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C332264DB
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398293; cv=none; b=c5ObI7MVSDaFtNw2lCo/1i6on6Toc1EcEmnhG7ineQH1OkvGWh5Hd+LjXmkR/NsGVqKW987lWxDhuV5GdgOANG6PBSHLlaRvEXK2g0F2Wl2SRKQuIGEAgr+v5CVq4hAkMeoXRJbUKtA17rI8/3nU1+64ssuRAQlcpyHYzUUWDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398293; c=relaxed/simple;
	bh=bvujvFVe7C6TOKGce9S3Nnj3TUgkGgNpt1W1/EpNyFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihqk9pFPjexYISR4B7kwrWsjzXlHehejP5I1TlT6dca1LguBxCBJLIjbtDkOyF4R9SRmrcxppRgh8/gyAlaNP2XKKQ7rEJFswJIis7Esz5sT4tfkJoDwR7fC9r9Lbpx9KEHciViqVcRDxPccsJy/XxkGyI+edFPBrnnAmblD5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZqmiJuwR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZqmiJuwR"
Received: (qmail 11400 invoked by uid 109); 5 Aug 2025 12:51:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bvujvFVe7C6TOKGce9S3Nnj3TUgkGgNpt1W1/EpNyFc=; b=ZqmiJuwR7CVQTi1M34//+vwLq0IjK2MhXeizHocV6lQZCekpROxnqQZdOHgZUQDsQgsiPGC4fvpfhrKjeN2AtBgVb0kGfs0cIGPK0+tGlXPjdijAs9qripnLbPCnzKvFxag9HeHXmIOSQb52MxKuVcznka0yKYfbzBQ/bqW3Iu+/EZTyNd7wYTa8u210rT5hSvwol2UHDlF2ryy2uej5CBGEWTHnJC+xrijoks5d+5JgZw3IBFg9QhpLVCTxuiR6qAcN49PQXCPf+w8nLigfVypM2pYDiuqJxhsw1BKzEa4dI92yGZ6ar/vZsu+pjlPicbOgFu03xtHE9QAIiKGBog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Aug 2025 12:51:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5358 invoked by uid 111); 5 Aug 2025 12:51:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Aug 2025 08:51:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Aug 2025 08:51:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Message-ID: <20250805125120.GA1291837@coredump.intra.peff.net>
References: <xmqqms8fbilv.fsf@gitster.g>
 <aJCBlnHp-db4Nd5w@pks.im>
 <xmqqqzxr88jg.fsf@gitster.g>
 <aJDI16RBR9QKdtW9@pks.im>
 <20250804154129.GC109984@coredump.intra.peff.net>
 <xmqqectq4ne9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqectq4ne9.fsf@gitster.g>

On Mon, Aug 04, 2025 at 05:34:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I just left a rather lengthy review of the split-HEAD patch in v4. I
> > think hit has a few bugs that we need to address.
> >
> > I'm not sure if the right answer is to just go back to the v3 version
> > that simply rejected the racy HEAD update (since that's more or less
> > what happens now and nobody complains).
> >
> > If we do want to stick with the "silently skip the racy HEAD update"
> > strategy from v4, I left some fixes there. But I'd worry more about
> > maintainability and regressions in the future. I'm not sure if my hacky
> > "pretend the HEAD is this for splitting" patch is something we'd want to
> > carry or not. But if so, I think we could at least get a little coverage
> > in the test suite.
> 
> Between the "honestry admit we failed and reject" and "silently
> pretend nothing bad happened", I'd have to say that the former may
> be more preferrable, and I hope people would agree.

I think I don't think it's pretending that nothing bad happened, though.
The user did not ask us to update HEAD, and we are able to fill their
original request completely. So there really was nothing bad that
happened.

To me the options are "try to do the best thing in a racy situation,
even though it almost never happens and will be complex and somewhat
untested" vs "do the simple and stupid thing that does not happen enough
for anyone to care too much".

-Peff
