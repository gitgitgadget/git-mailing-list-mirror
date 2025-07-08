Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C3221D92
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957086; cv=none; b=uIdOyu4B9ANOKdPEW0rVUrA8lhcs9Qj96SodJhUigRjfsQXfi7cPHBt1/dHTUp5E6V44UNu+DklVBf4jdFEVCvlaZ0EBeok9etwgAdT/xCnXmLtJEUv00z6Gbkr5nqQiYM8yvAFNBLStuZlmp6Bz+GB3dfwahbTiRbB8gi7iGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957086; c=relaxed/simple;
	bh=0zEcVzVbloJqbN+29wK69kFZB3rqbdJFNATf/8mocB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbhumLjnS7uJPo0VXtQ9J+OsfEh5dzCfpfUeKhJBO3SUWg0df5Fe9dJbmo62MWqrOZ1FH7WjBylQed0r5/0L5PvTYY7Dagn4dHpQMW/J4FtF2mYcjuNlPC0XbFY2psab2ol8QOZZnGTSwptyoRBNIU6787FxdGA4qtFpmyo+Kpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WhHD8ZLP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cL31Be2b; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WhHD8ZLP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cL31Be2b"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 334E5EC02BC;
	Tue,  8 Jul 2025 02:44:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 08 Jul 2025 02:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751957082; x=1752043482; bh=G4WtZKgVvb
	DOyV+oe2PXt3/4yLxN3mqYWvkA5eJVa74=; b=WhHD8ZLP2pWHmKZ85dYd1MUp2W
	G8V+UIez0UNa+VOzothIKXezy9KN57XEDPze8KtSvT8KkTDK8gbqIkO7w9qTnKdx
	8KMSTWP/Sj7JO2mrNcusUdcKPYOnKS2mfAfAx//+mmGE0rTCzr0UItr/0bsjtwsn
	/PaJu4WXxTslTqMXiJbhcuLX3nxWNTQQRep+O6WdegJ77DYHbGQ5OWk1n6HxhTg+
	ocyTNxdTqa8W6VjdU48GLgJyFraQSPrmYe3MLLV8x7R6CPRPF4BIqXb4xe9z47of
	5/t59GIkLxwjsRLfZOP31Lahu3+fXJSZU54E1y8cHbytQPnA8gyt0AnZ97sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751957082; x=1752043482; bh=G4WtZKgVvbDOyV+oe2PXt3/4yLxN3mqYWvk
	A5eJVa74=; b=cL31Be2bFezbihYou0kPpHy9pDIcl+ub1GiWrUIBrVEoh8irdTc
	s3rj0soyt6xpNvrGgph3+0pUgEX1C2tZnMDegoXx9Cg/5IwTvuCd8bvWTmG8SYSB
	RzRnTg6oeXw2d9+Mk88pRg8fRYlA25qjXtboDDGMkeoNIf2r2tLGcaQQYsDHutFU
	1j7JKB0lBrOYUE9vOx8LP/Xhxaqdek2jR1zP3LBnJYyBtQW1qLWXJcNv9VWR3kC8
	NRIqRGfRYYrPXJvaiiJD9JWC1tqUAnx9sGJVo6HwVgxNTkm/TV250pvfa0MqW6hE
	y+3zqTlK95VxZ9Ne1dljAyKciWXrX5WlYDA==
X-ME-Sender: <xms:Wr5saCfSGsRmaJeOC6aUmIx5_OsoUw08kMHNJ31J_BWk37K6M7O7OA>
    <xme:Wr5saPeMrFqYmX1CxjDgF-wXNLX5LWb-lI7en-BB56-spt1Rg2VjYLgKWwSfhLj56
    A80Bcl8VJiixyFl8Q>
X-ME-Received: <xmr:Wr5saM9ynLD8qf8mee2J4ciDXGaVqbxeW5ebAS6fsj6zr2IGa1X-Y3zS_4EtJRc9r0JnB-MDHT_SEYzhuecww7nN26Mt4znv3yoHCK80fvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    iivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Wr5saLlX-IQE8EcVWPAkNjqXkiNasJKgnPVi0Oax-jWVfmO6IScOlQ>
    <xmx:Wr5saO8QqxMAY_7rbLMQ2oYU_YcjIQ_Q2SJDaPqV0rL3PZgQMiDhng>
    <xmx:Wr5saJn5M13AtG8LiW_f1zwx583YXuw91cC8d4z1KWt_LtnxHJzjdA>
    <xmx:Wr5saL18m4s8dVILquffeSu-O2qIRsIlAiH-n2jev5udFob39AKfTQ>
    <xmx:Wr5saC5tTjRLh0XcDRM3V9Gg4xWv2ArxeCtPCxTD7Vfp0gAo1jxah6hv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 02:44:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 092344b9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 06:44:39 +0000 (UTC)
Date: Tue, 8 Jul 2025 08:44:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] t5333: fix missing terminator for sed(1) 's' command
Message-ID: <aGy-VBk5nO8UJItZ@pks.im>
References: <20250707-b4-pks-t-perlless-fixes-v1-0-92b2de1c3dd0@pks.im>
 <20250707-b4-pks-t-perlless-fixes-v1-2-92b2de1c3dd0@pks.im>
 <xmqqplec3rka.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplec3rka.fsf@gitster.g>

On Mon, Jul 07, 2025 at 09:15:49AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In 6aec8d38fdd (t: refactor tests depending on Perl to print data,
> > 2025-04-03) we have changed some of the tests in t4150 to use sed(1)
> > instead of Perl. One of the conversions is broken though:
> >
> >     sed: -e expression #1, char 41: unterminated `s' command
> >
> > Curiously enough, the test itself still passes. This is caused by a
> > sequence of failures:
> >
> >   1. The output of sed(1) is piped into git-update-ref(1), and because
> >      sed(1) is the upstream command we don't notice that it fails.
> >
> >   2. git-update-ref(1) does not receive any input and thus won't create
> >      any references.
> >
> >   3. We then repack the repository with the configured pseudo merges
> >      pattern, but as we didn't create any references the pattern doesn't
> >      match anything.
> >
> >   4. We use `test_pseudo_merges()` to compute the list of pseudo-merges
> >      and write it into a file. This file is empty as there are none.
> >
> >   5. The loop over the pseudo-merges becomes a no-op.
> >
> >   6. The final test succeeds as well because the number of lines in an
> >      empty file is obviously the same as the number of unique lines,
> >      namely zero.
> >
> > Fix the issue by adding the terminating '|' to the sed(1) command.
> 
> OK.
> 
> > Furthermore, make the test a tiny bit more robust by not using it as
> > part of a pipe.
> 
> While I do not think it would give us big enough improvement to
> revert this part of the change, I would have liked not to see this
> "furthermore" change.  We are not in the business of catching
> segfault in 'sed' that is supplied by the platform, so there is no
> point in breaking the pipeline here.
> 
> Will queue.  Thanks.

Segfaults not, but if the pipeline was broken up from the beginning we
would have noticed that sed(1) returned an error due to the missing
separator. True though that it doesn't buy us much now that the error is
fixed. It's not like this line of code is likely to change regularly in
the future.

I'll not send a new version of this patch series to get rid of it, but
if I need to resend I'll remove that part.

Thanks!

Patrick
