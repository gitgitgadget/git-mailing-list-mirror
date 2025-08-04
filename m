Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3521FDD
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322092; cv=none; b=Gx5lWOLop/RQLC+uXPjsSwPOnhgmiAEDRQXT5UgI8vgMFjMO6oIit4L+gGYoKUIN1KoiX1WLF2GmKr2sYCJuSUHLhE6T1uBh/NL9N1UOsQEwKD7weLHiB+gX+GCXzY7G1EWZDA3NZfdapmUwqGGDgi8oKHgVObeBuIVwg/yOXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322092; c=relaxed/simple;
	bh=T2i7qyrpv2uQuz+rxHmJncOYdfV6udBfb4cspc/QvFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF8KYH7MKkV1mUlKJlBYJ+p5Mi6pYmCMa2IfB+bKKj1wMSk0MhbDHYvZz5sVGHt2wm4GjWscVDIICV02+YtWULWcZTRMhKcA55urXB57u7WlukzpnowyEPFoOMPh1IEaQ3S0038imSUwnu18WGTEAzEcbKNaV02qUnOEFXsMKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B2vSAw7b; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B2vSAw7b"
Received: (qmail 1943 invoked by uid 109); 4 Aug 2025 15:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=T2i7qyrpv2uQuz+rxHmJncOYdfV6udBfb4cspc/QvFw=; b=B2vSAw7b0RkrH+SZlycVvGgW+trn+216sKORa6pRzi8M/edNMz9lNmfmx9fwVkXZvxaVPOKuohK30BPJKyRzpE0ZDu6Jr4NZJkjs+5701zLigW/mZ2wbeonaiH8VTRj2qg96wVbCqAk7S3TbYTJlQ/eTlBvBHArF2+3NPSVUC/CVHlfT0yVnbPOays2CkLpcQiPl9Sxs8KIc3NCzpnOWQhu5JOv3oN0ipLLp4IXIGJkaFlcIo3l32nikXqOSnMKphayprW17JljrXfifttTpQR8VnH5zndfHtnMVQwtX6mJAWw0RDsaXKW3WlQTY8CU31TTr50K6sQmdt0si+GlIVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 15:41:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21458 invoked by uid 111); 4 Aug 2025 15:41:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 11:41:31 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 11:41:29 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Message-ID: <20250804154129.GC109984@coredump.intra.peff.net>
References: <xmqqms8fbilv.fsf@gitster.g>
 <aJCBlnHp-db4Nd5w@pks.im>
 <xmqqqzxr88jg.fsf@gitster.g>
 <aJDI16RBR9QKdtW9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJDI16RBR9QKdtW9@pks.im>

On Mon, Aug 04, 2025 at 04:51:03PM +0200, Patrick Steinhardt wrote:

> > >> * ps/reflog-migrate-fixes (2025-07-29) 9 commits
> > >>  - refs: fix invalid old object IDs when migrating reflogs
> > >>  - refs: stop unsetting REF_HAVE_OLD for log-only updates
> > >>  - refs/files: detect race when generating reflog entry for HEAD
> > >>  - refs: fix identity for migrated reflogs
> > >>  - ident: fix type of string length parameter
> > >>  - builtin/reflog: implement subcommand to write new entries
> > >>  - refs: export `ref_transaction_update_reflog()`
> > >>  - builtin/reflog: improve grouping of subcommands
> > >>  - Documentation/git-reflog: convert to use synopsis type
> > >>  (this branch is used by ps/remote-rename-fix.)
> > >> 
> > >>  "git refs migrate" to migrate the reflog entries from a refs
> > >>  backend to another had a handful of bugs squashed.
> > >> 
> > >>  Will merge to 'next'?
> > >>  source: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
> > >
> > > I'm happy with this version, so if the above goes in I think this one
> > > here can also be merged.
> > 
> > You have an update for this one.  Perhaps your comments are swapped
> > between these two topics?
> 
> Oh, indeed. Sorry for the confusion.

I just left a rather lengthy review of the split-HEAD patch in v4. I
think hit has a few bugs that we need to address.

I'm not sure if the right answer is to just go back to the v3 version
that simply rejected the racy HEAD update (since that's more or less
what happens now and nobody complains).

If we do want to stick with the "silently skip the racy HEAD update"
strategy from v4, I left some fixes there. But I'd worry more about
maintainability and regressions in the future. I'm not sure if my hacky
"pretend the HEAD is this for splitting" patch is something we'd want to
carry or not. But if so, I think we could at least get a little coverage
in the test suite.

-Peff
