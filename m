Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060C23909C
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864831; cv=none; b=TBONZpzelB71hHVKPPMwrFBP9/SSu8QkHYyO35YBKw8USH0aWMHVmsPhy358iXs+CvhRDkQUfyCszaz435QprGbWYpp42WB4d7zHpXwBAsRx23PB9swN6Yn4Bf/sh+SGWILFCVi2v5EezxxEy+/r9TcQ8yOpBtyswX1u4Rp50ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864831; c=relaxed/simple;
	bh=T6+4pvCNJdS4s88CXto7lM2oiUY0rKuTqQvnCjc+OfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kALhP1jQY/ocPxr2qCaIvQGub4on2V1fhzFqeN/LM67yb5gPWfihl/uCIiP5T+wkB5KOqPZF5kgXrhdts9jKpNbjW6xyAkEoXefXSpSzlYBuMOqaCpPO7sKSKDVNiveEJ9CKH/oYdJegaOvF07FL5I6YV8aU9MhAhXL8JLPYInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QlQ7KE3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+1hsVyq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QlQ7KE3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+1hsVyq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CC327A01C0;
	Thu, 23 Jul 2026 23:47:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Jul 2026 23:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784864827; x=1784951227; bh=RfLfgQpUQy
	/+adjQLk3EJnCIhBAvBZV3xLDZPkcZT1M=; b=QlQ7KE3xLS4g5ECXbT5W6Y5aUH
	ABCxFUijD0+J0kifuvmBVBpwhVJxtTKIV9PwDLjGSV8IxK87lcw63RZ1BBTyDVul
	iuXFXxopvZLexjXTbaUucYQfO2yWVVNhWhctguHDqIuLI7/kVqBw8BTS+Iu2pAVL
	LCUC4pO8EnK5aaUPa7DN0hh2awbxZAd/YUYdXUdwWQZg3txTbc9p9xnyjFSsW2/M
	kMN7A1WXAr4wOwn+64gJCUHpwrJFWZQ3+OnEIpPUSYtEjCY2+NPiG6rYM0kHIbGq
	Jg4hhP6PQHULY0RUQaXr8RBGFV3cqud+cFJnT1o0GA3rP29nbp8Yk3IqqkVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784864827; x=1784951227; bh=RfLfgQpUQy/+adjQLk3EJnCIhBAvBZV3xLD
	ZPkcZT1M=; b=c+1hsVyqQVD3LHY5xHve0IvWfREs67hM5XPwXezc4nT/7cJrRih
	sLy0jCl6UHP/+LyFP+jw8ckW6XeRoRQZxZqP+aXVd52Y2GlimYvBF3fdxtWEcIim
	FZg2nP80gM33hZeuzct04LnmOTYWUgmOq62/6IoKWi3zkUY2HdHqvK3WZF27gbFz
	hhPowzSIL5VmQK8G+pDqvzS2EBV2qOsvprhkM4Oadcf0RElEWKlBWrSMvocEHlNK
	VJ3gYxcdbV4LROKXryUgcI3B0qtf+87tPMdVXsCGl0aMjDkNxg4uSOljC2frgPJl
	1xO3RVSwRFhD8z63/ztnDVKstQQE3CQklYw==
X-ME-Sender: <xms:O-BialGtdbcTe92YrR85VWtaRguotrRC5IVNl8NpxdYjJl7g2ZzeUQ>
    <xme:O-BiahN4qvYEOfK8PgStZoyD5Pa-gKqWmuMx5SNrq2NFFi9JmWA7evg49tb5umBTg
    CaiUFPwt2pqd7Rvohq5loy0DtEAyefxYwik3dor_mWmTgDwjvF8_Q>
X-ME-Received: <xmr:O-BiavfEDP3YV28naAyE4t6ebSQe3ZvkySF2CB0IIWgviGbedfZxm1SpbjJ53s9aa4L1mKtTmfUPmxE3zuEJJDeAUVMWwYY_n_T8rTuNiCo>
X-ME-Proxy-Cause: dmFkZTGRVFhtSJ1+1DYIcPQS86ki5pKkwdjBqwa80WzHkhHHnD7MSRE4HUmPWBSNyEMi8U
    i3y55u/hQuYp7gu+ByWSKyxbnE5087AWUgcvRc5jkTjSKmNdi/WHU3a5NZ+tBjoTbdp6V8
    wbINhIMrNvWQc4RHT/VovCA+3EIA8gkFPBOGS85t3ZOL6HgffY9QT3hHNY71xaju9whmd+
    8KIPMylTuMe1jJdj4SDehKJiUL5KLH04uDWtv7Z18QXPlMrxZ/nJE8aU53L3Mh1vMW9y/P
    bsv2DydAXau7pKL35tkekgnjRVbHsNSOSSZjNyApunu5JQGSFpZbfuK0KKlcH7UbzJhkFW
    Dys+AGjtU0C8M8W8+enM2O76B9sybGJ93I9DQNk+mF1Dyp1BdMkvMeqXlC8AKB2ZdK5vD0
    3N0ja9Sgakw3ztaVKfmARNtz3yvL3WzqOy0ELDK9BekaZAMJbkuJjn3fVoc5gPL30hanEW
    OZTWlrA6l/RSqUqbMKmiUUXeRB3mPghKEyGhWoKfcxPYQ8itvchBac4o4k4y2xd/dOtM8b
    fyHYJxFmfmmmZ/WP5QY0krU7I9MF631ea4OIM7I3lQiZgvFGHMA+Kini8AO3L1uLjyhIIw
    2iPEmuq1ouLTceVz3qIcgGiC0QpV3X21FmefFJqMgOFA2CMRpE5mKELJMXfw
X-ME-Proxy: <xmx:O-BiamvxuoIHpEatMP8hnCoNAlAvyZ2G0SyTS6VzgC4ycsLd4m2rNw>
    <xmx:O-BiaompOCzpBD54FnBQoccIVfyhWV0INHBkLZD8Sx5AzOqoFdP0gQ>
    <xmx:O-Biagyfudh7l-eiSOCLoSS8kcdTQaa0F0UFqkVYPmmRH1HyEMcGXg>
    <xmx:O-BiaiPINmnJJVCJch171iuAbgVI1wjwz6IsmwWLNtS6vsMHGFgmpQ>
    <xmx:O-BiagJ1R6LS_LhkvBr8T2KAh_7KPlIcqhWHmXJGpmzmlO9F90mr1TcR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 23:47:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 423d0720 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jul 2026 03:47:03 +0000 (UTC)
Date: Fri, 24 Jul 2026 05:46:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	git@vger.kernel.org, jltobler@gmail.com
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <amLgMqkqxR8mKIbT@pks.im>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
 <amCuLpT6vYzo1GF8@pks.im>
 <xmqqh5lrrplt.fsf@gitster.g>
 <20260723104943.GC604358@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723104943.GC604358@coredump.intra.peff.net>

On Thu, Jul 23, 2026 at 06:49:43AM -0400, Jeff King wrote:
> On Wed, Jul 22, 2026 at 08:49:50AM -0700, Junio C Hamano wrote:
> 
> > I suspect several of those 'transactions' are actually misspelt
> > 'temporary directories', but I catch your drift.  That said, a
> > redesign like that feels more or less independent of the fix for our
> > immediate performance regression.
> > 
> > After all, didn't Peff show us a case where no odb sources were
> > being flipped in the middle?  Simply setting up one object store to
> > borrow from another via the alternates mechanism demonstrated that
> > checking packs across all object stores before hunting for loose
> > objects in any of them makes a world of difference.
> 
> Yeah, exactly. This is really a regression in alternates performance,
> but it just so happens that the quarantine system is built on top of
> alternates so we noticed it there.
> 
> I'd expect "clone -s / --reference" to have similar problems, and also
> for sites like GitHub and GitLab that make heavy use of alternates for
> object sharing between forks. And those would pay the penalty on just
> about every operation (because we'd expect the alternate to be holding
> most of the objects in those cases).

You're right, I also realized that after sending my mail.

One other angle that Justin and I have been discussing (we were at an
offsite together over the last couple days) was that we can do a small
course correction: instead of handling alternates on the ODB level, we
may be able to start treating alternates as an implementation detail of
it. So both the handling of alternates, but also the handling of the
GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES environment
variables would be moved into the "files" backend itself.

This would solve a bunch of smaller issues that we're currently
grappling with where some of the concepts in Git really want to operate
across all of the alternates:

  - The OBJECT_INFO_SECOND_READ flag can be dropped as it becomes an
    implementation detail.

  - We can fix the performance regression because we can now easily
    reorder access to read via packfiles first across all sub-sources.

  - Commit graphs and bitmap really are a singleton, so loading them via
    multiple sources is awkward.

  - The object storage extension that I've written got quite a bit ugly
    as it wasn't quite clear where exactly to draw the line. Especially
    hadnling the environment variables mentioned above into the "files"
    backend removes one point of friction I encountered.

  - Object database maintenance needs to be aware of the other non-local
    sources.

Also, doing that change isn't as bad as it may sound at first. We'd
still retain the whole `struct odb_source` list because we want to have
them for submodule sources. Furthermore, alternates aren't required for
isolation either as we currently use them via the temporary object
directory. An alternative implementation may use a completely separate
mechanism to achieve write isolation, which is also why we have made the
environment variables pluggable that the `struct odb_transaction` ends
up passing to the child process.

I think overall this could simplify some of the design, and it makes a
bunch of issues that I have been struggling with go away. The devil may
be in the details of course, but I think transitioning towards this
should be doable.

So I'll work towards that goal. I've got a patch series already that
removes all of our calls to `odb_prepare_alternates()` as a first step,
but I'll only send that in two weeks once I'm back in office. I'll then
have a look at how bad the subsequent steps would be.

Thanks!

Patrick
