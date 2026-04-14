Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369C937D133
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151422; cv=none; b=cz2ff6A2oHXYr+kPR8YRROXIQxEb8cMC/KcHg5jz8VjAxITyfX3Nb0DBp+h9Umb1pi27YhllBPUGy747x7kIjZqI7QA8Ylf2uLEoDTFPcNnjDGHp1hB24Bp9Fvj+rhZOlGRhO0E7qv1hdPr9Sndz7tAvTcrC7iMWJknPpl4dyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151422; c=relaxed/simple;
	bh=tgwK0rKnKHUYnyk6/8UdFOYVdcqrAIz+6rwXbzaXHoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLWp85JPeDFQ7vX+XsHjI4Vqqk03+CBouGRYeE1jnVa5p+RhFGywlRCeXdx91AeguIEBq/8jcwuYzFzp4oMV3oQO5BeR8hRTll/ckTGT1YFMN4c1/sJHPq/H3RmtdSH9/j/rMBNE8pcmYi35MRjImm/bZaHTIR4UrcHpfkSJ4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0a7jQdzm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJX10a1Y; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0a7jQdzm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJX10a1Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 547FC7A00DC;
	Tue, 14 Apr 2026 03:23:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 03:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776151420; x=1776237820; bh=/Hm/Pmp56A
	OZhHb3L6w9Ttq8jT3bo7Cp/Z+kT+cY/HE=; b=0a7jQdzmHTqWv35LfI25ZsUupN
	VtM4xwa+d7hgfYSN8ld55cFXXDiExn3cHv4G4St+z3MegZAjTm52w7CsPa4xV/q1
	5Ze5HtnJtKOtnRm+rdpnoUQCXkSkpMkgxaucIbGIeCZX0XQgnETgKfr1tbJbRTFd
	qYg851yxixsiiLaWj80S+3pYno32LDizQmBQpMWrYsY83csbe7P576R3Qm0S7YsC
	4zLx2jPcnelStU/wjv2G7sBYKKLFjkgC+wpod7gEIKf9I+e7JPgZHNzhW7qSvE27
	zhdULiYXP/I4qZ/kL1Ois9x/D06CuOLN87MDX91hc+i3/EB8lll25TVGnrrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776151420; x=1776237820; bh=/Hm/Pmp56AOZhHb3L6w9Ttq8jT3bo7Cp/Z+
	kT+cY/HE=; b=HJX10a1YnIQHowg/klRSBq5l5Mf0KfGwc61M6GwcI5AkblSjgS5
	0Jk0GPU9Z3v/WCQ9kR6EAOJscC2ejJ3cxThdv0RrzdqA4Pxba4a1zDomIi087LmH
	655obh7O6/gxob8/y1rFRB3j3SDf2pjk3qukCr+HBxeN4JqeRFDuUiWt4tt7E/Sx
	3+Qvuhs7rqpr7dnVVSSpiDfJupRrDhDIHH7utG6AGlLMEwgQ734muaI/ScJEH+NG
	dDcCBzJV7iQz4TwHTB0Z8/EVR/YOOczz9IbEaGHsdu/6Hb0JbcugpE0ydIDzCI/B
	0f07UXDky+b1sQpiw8dLBAn1Y2YyCySLZzg==
X-ME-Sender: <xms:fOvdaUUOgPidcT6Ecy14q83OxobBR9a1sAfR0boxtL8fJJJ5OcuyqA>
    <xme:fOvdaemwh7EeLXnxrE4NnbFZEDxBIAKBS8Ptm4Jjy5f9F4_5RgR6sHeIOdfRzpgqp
    5bZ1Yrp7FWavfD4sNoWnmvgrfcL5OBdL8EqzDsKEe6TkA0iayl2>
X-ME-Received: <xmr:fOvdaWCfzNiC8GUkRcBNIGtj3NNsNxec-eLicyUDnaNU2mNKs9R2kwcoteR7RUryUxkm-5x7bFgd1YEowEmeTER0kaY4cwbWDIj0FN8MtqBxXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhephfejteeugfekhfeffeektdegvdeffeeiffehue
    fhtdejveeivdfgtdduieevvddunecuffhomhgrihhnpehgihhthhhusgdrtghomhdphhht
    thhpugdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fOvdaedkqnrCQQlTVl2pDJuehdYzVDKEYpx_ClwKumOMrTGtQ6yVwg>
    <xmx:fOvdaRL-7pGa2HYPRXRgYwytdGFVzjInNCfRBFdE3NN3MdAZYLNWpQ>
    <xmx:fOvdaRdFNk2hEtjZaoHbQGR_QKsQeY5Rt7Po-O_oRQPw_v0_9S5QKA>
    <xmx:fOvdaY3H9iAA2n7jnprfeRyYYcBikEZUkU30oHFtm2bBg2xcSJJ4ug>
    <xmx:fOvdafui2oeW23rPtv6LpbvwO6iOzkouswPEdMzuYQWrDbkwaYBufEyK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 03:23:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93ed2176 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 07:23:38 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:23:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <ad3rdxVSrV9U4a9D@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq340yfivf.fsf@gitster.g>

On Mon, Apr 13, 2026 at 06:09:08PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think I know what is lacking in this patch.  Following the above
> > section (which is a good conversion), there is this bit that needs a
> > similar handling.
> >
> >  t/lib-git-svn.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git c/t/lib-git-svn.sh w/t/lib-git-svn.sh
> > index 2fde2353fd..24c15d17eb 100644
> > --- c/t/lib-git-svn.sh
> > +++ w/t/lib-git-svn.sh
> > @@ -27,13 +27,13 @@ export svnrepo
> >  svnconf=$PWD/svnconf
> >  export svnconf
> >  
> > +x=0
> >  perl -w -e "
> >  use SVN::Core;
> >  use SVN::Repos;
> >  \$SVN::Core::VERSION gt '1.1.0' or exit(42);
> >  system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
> > -" >&3 2>&4
> > -x=$?
> > +" >&3 2>&4 || x=$?
> >  if test $x -ne 0
> >  then
> >  	if test $x -eq 42; then

Thanks, I will squash this fix-up into my branch.

> The above is queued as a squash fix-up on top of the topic, but with
> the topic merged to 'seen', we seem to be getting a CI failure that
> appears specific to macOS.  Compare the failing
> 
>   https://github.com/git/git/actions/runs/24371204585 (aa13593)
> 
> with the same tree without the topic
> 
>   https://github.com/git/git/actions/runs/24369661492 (ad8b884)
> 
> The only differences between the commits are
> 
> $ git diff --compact-summary ad8b884 aa13593
>  t/lib-git-daemon.sh                | 13 ++++++++++---
>  t/lib-git-svn.sh                   |  7 +++----
>  t/lib-httpd.sh                     |  3 +--
>  t/t0005-signals.sh                 |  4 ++--
>  t/t0008-ignores.sh                 |  4 ++--
>  t/t1301-shared-repo.sh             |  2 +-
>  t/t3600-rm.sh                      |  2 +-
>  t/t4032-diff-inter-hunk-context.sh | 14 ++++++++------
>  t/t6002-rev-list-bisect.sh         | 17 ++++++++++-------
>  t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
>  t/t7508-status.sh                  |  4 ++--
>  t/t9138-git-svn-authors-prog.sh    |  4 ++--
>  t/t9200-git-cvsexportcommit.sh     |  3 +--
>  t/t9400-git-cvsserver-server.sh    |  5 +++--
>  t/t9401-git-cvsserver-crlf.sh      |  4 ++--
>  t/t9402-git-cvsserver-refs.sh      |  4 ++--
>  t/t9902-completion.sh              |  2 +-
>  t/test-lib-functions.sh            | 12 ++++++++----
>  t/test-lib.sh                      |  8 ++++++--
>  19 files changed, 78 insertions(+), 58 deletions(-)

I'll investigate, thanks for the hint!

Patrick
