Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A1275844
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882014; cv=none; b=ExmVSFenb759VPsDqTqYElMEe4qVw1829VrxvuI1kQkYn6I1M3sKyiVv0Vh6bw8vgTtKCdFQT/EnXAF2Y39rmv6Q2Ac5LafwzZaCa3tSRvXVVxtmrvofh3McqS6AcDr2jYxF2lhZMubaK5La0U6otCl36cvW7ZxMsns2tfkfweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882014; c=relaxed/simple;
	bh=kqE5c4zYnVtOvomsfsi9DS0NJ5KgHEz9bYmIVBDlYis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaRlMIvfrw3U0KHaJUqN/3AejjsulF7Mw194f7BydVhQQy2+e6j8zyrfK2zjqKIBwwR38SP/aa8Y10l2ruhAKafplyvKfz4gizMrfGnTOAoZ4jtXegBMouFAZP/01SQGBpJHRhdol7I8nMkVyNrQyRFclY1nD1tUMR6WEU+q7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QIkS8GC+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGL0yvUc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QIkS8GC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGL0yvUc"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 48090EC0763;
	Mon,  7 Jul 2025 05:53:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Jul 2025 05:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751882011;
	 x=1751968411; bh=a6DoP4HjmqKIGoEQJaUgLGowBj1tHGZFThiqCK5NC1w=; b=
	QIkS8GC+/VatdGu6BjdmN7VCWvLSRCc3qFd3d+H1nTi6TRdd5azSHfZOsYGIxEXr
	wt2IO1oCnpikZVeT/SALSXl7fKcpQmcNYrHBI8SYHpEMba1NOSEreG/5xQJkxheI
	aMCbCvSkn/0g6Olia3Wxt4RJ+gQKGs1vjz3wuPFJuOyOrehCeBTz0bnUBU4YqCJb
	/Z3HCDptMfgkBIIuRtONOGz0pD+xdtfb2zWOrZWry51KLzlZRNOx87L9Xj2llqHt
	ZlxAtffJbKzBVdxCovanASFtUOAHb3UUm1wypgFtyE5z1IDJVt/NcDjxYJckFmQS
	Cnm5nbnZshb+Xa+xc6bD4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751882011; x=
	1751968411; bh=a6DoP4HjmqKIGoEQJaUgLGowBj1tHGZFThiqCK5NC1w=; b=j
	GL0yvUch3Qc+1+OYrwFDUsrKkku7HOe0BQc18VgRvSM9uqldKXFpDp73AFJ+0HXL
	rwzzZ4YAMM0fYK8hFFFWImgKjXqi0194YwdcBP5e7wQtIzoenFuaB+jdGPEjMnd6
	x10o1wyO2OQsw/0+TrQiGcsFOQnFhvH2bfIm3lFC/GzlP40GiAVvH3at1BCzmJEC
	pCYGwtczqxxxRPKSAlFhB5xjE7X4k5ZJYdswTZNoWbLSvpwQGu8ax5nHouHUbFOq
	XmymNrt1LAVN0DNbITZyFS2VUtD2IovxpSXFGSnSvKHF0wIWKv3c8+feWd2tWAcb
	at7OSH/Qh9uZThUQ9eaEQ==
X-ME-Sender: <xms:G5lraMCY5QQTIxAzwJ5-rIMgvJ18hzhAQcLgvb49udjgH0lLSYYs_g>
    <xme:G5lraMFlQpm8E_D-8iWUwqUq1MooQO3DZFvmP22Lwa2zc5Fsj8miv0Ew-RBFsefLW
    B0TgiFtD6mcpP1PpA>
X-ME-Received: <xmr:G5lraGAnTKMSEZlh91gSAamNk_xBraEd2rCb9m3e7JCl5Uri4O_1hGlJuYuvF1Qb08nPxF6-lYidCUxgXuWA5rYGjRxDBj7ChesdJt0HZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:G5lraEXYAceppr-sFO9aqpLBOJTEeporSNWDFr5-Nx6UNB7i1wDwmQ>
    <xmx:G5lraCpzAOwzHf2erYMCMK3KdYktiiLxRFe0Su_cTwPqt69YHh2Xpg>
    <xmx:G5lraIQgO-72yZmoYVf8ORWCDxUOxz7OH9tTgqaWt0CHkKe2oFag9A>
    <xmx:G5lraE1rfI47ZVx27v7RHgHCJNNQ7Nj9Uic5qi08LAibUR1GwovFkw>
    <xmx:G5lraDl8-1z7yLIPemyEMfVXVMcqA0HFpZvwWxgIixJQUgrXGj_CqhU7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 05:53:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc807665 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 09:53:28 +0000 (UTC)
Date: Mon, 7 Jul 2025 11:53:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 12/20] t: refactor tests depending on Perl to print
 data
Message-ID: <aGuZFIWFA3J0VkDZ@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
 <20250403-b4-pks-t-perlless-v4-12-be20ac3db39a@pks.im>
 <aEiNBwUkjbo2QlFY@szeder.dev>
 <xmqq5xh3mgg9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5xh3mgg9.fsf@gitster.g>

On Tue, Jun 10, 2025 at 02:31:34PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> >> @@ -241,8 +234,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
> >>  			test_commit_bulk 16 &&
> >>  
> >>  			git rev-list HEAD~16.. >in &&
> >> -
> >> -			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
> >> +			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
> >
> > This conversion results in the error:
> >
> >   sed: -e expression #1, char 41: unterminated `s' command
> 
> This not just misses the terminating "|", but the conversion seems
> not very faithful to the original.  It used to create tags 1 2 3 4
> 5... but now the tags it tries to create (unsuccessfully) are the
> names of tagged objects in full hexadecimal glory.

Yup, that change was intentional. Anything past "refs/remotes/$r/tags"
doesn't matter: the pseudo-merge patterns only match on
"refs/remotes/([0-9]+)/tags/", so the final part of the tag name does
not matter. It was simply easier to slightly change the format than to
faithfully retain the original refnames.

> > I find it suspicious that the test still succeeds...
> 
> That is because the downstream "update-ref --stdin" does not notice
> anything wrong in its input, which is empty.

Ugh, indeed.

> >>  			git update-ref --stdin || return 1
> >>  		done &&
> 
> And the step after this, which is not touched by this patch, may not
> be testing what it wants to test.  test_pseudo_merges produces no
> lines, and iterating over the lines in that file produces an empty
> result in "remotes" below ...

Yup. This is a consequence of us not having created the tags though. The
pseudo-merge patterns we have configured don't match anything, and
because of that the test doesn't do anything.

> >> @@ -258,7 +250,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
> >>  		do
> >>  			test_pseudo_merge_commits $m >oids &&
> >>  			grep -f oids refs |
> >> -			perl -lne "print \$1 if /refs\/remotes\/([0-9]+)/" |
> >> +			sed -n "s|refs/remotes/\([0-9][0-9]*\)/|\1|p" &&
> >>  			sort -u || return 1
> >>  		done >remotes &&
> 
> ... and then it checks remotes has no duplicated lines with
> 
> 		test $(wc -l <remotes) -eq $(sort -u <remotes | wc -l)
> 
> No wonder it passes, as remotes is an empty file ;-)

True.

But in any case, the test does what it's intended to do again if we
append the missing "|" terminator.

I'll send a patch in a bit, thanks!

Patrick
