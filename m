Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06237A83B
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940790; cv=none; b=o6otCdQb9lDEF97UbWs1T78SI1yAIwNMn5V+H9Xc2NZukLWJIQy/LrtWgz/P8RzcEJTKCybBUWumqkFqzTKZrBR2WjC5xfgPkTpyMo39jP6iczvxmlphFXNnTY5kWtYDOdM9ySozebCZAf9vDHO/LSAst1BsMxoEdhvXnp9p1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940790; c=relaxed/simple;
	bh=7PgK/B580HAFbLfrE9uQgsnvE7x2i8hUoX70Mt2DB1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTpRR3D+tI+KQkLE4hUwhldQXBjusDAvjlZRMoOJ7ef9559gqdoxoapoaxfctVMC0Mt3RcJTaF72x+NibAtVxrXJ9iVWJ73Id0ATkMzbQq1Luqp6paC3uLHPAWvk9Jb7B+IOV0CO3w+pejlrdcXBfHDSVqo5Z3dtIu1x5C8F8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jNcwtbT4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4nQcUcZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jNcwtbT4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4nQcUcZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91DA37A0079;
	Mon, 13 Jul 2026 07:06:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jul 2026 07:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783940785; x=1784027185; bh=U8Qwkp8Nj5
	iKSEI+vNC3W8CfUwT3XlJbkjg28Z4y7Rs=; b=jNcwtbT4lLaThce87I3I/SXDpv
	DNZptuMGi1jxGm+Pd5P/VxitDt+9dd0nP4qiKH8+sEvAU7cV8+aZXcHiGIbgENYB
	LcQ/wEEjzvRztVfP97UMc4HBAcWIwrbrgV2DieY/aKmy9vaxjGX0RTBhBAxrVW0f
	4AB7qhT1ZRxOeUd+c7p8mKIixi0IF+DfZ/IpPh8kOQXQmLom0FAiTmEBGnE+WfZY
	WMwTv0nfGn/NYXSPDUpr482qCAA+rgSYV8itwI/shGZoPArrrpD1GSdwUWCgdUb3
	loGWgVI4wtfGdtikK+L490yWCApclAPMy+VnJOF/K3m4ifjskq4qLzy+rOQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783940785; x=1784027185; bh=U8Qwkp8Nj5iKSEI+vNC3W8CfUwT3XlJbkjg
	28Z4y7Rs=; b=W4nQcUcZxGrZ5YCAvntAyvjUuN3DEY3tFsQ6W+QLSlTOF+fPH+r
	Iwd6iKbDf3kDqtLOMloS4Is1p4D6L0ayXiDVXHBuvfLMO8MIT1AGgbpFxnqWphQo
	3jl5ggxW4KXKFZ20QK/PbOZMq4lVwBwDvn7eniuvDga1nGMKJgL8TuqQYXtWacPN
	aMnfd+YjGAZktTiHF+/h3amSqsJGt+WGsO66i9TYo04R4SdYUwh69j7dDcXtQus0
	5l2V+58EfFw2FLWCjIq+7G1tg/mxbQyfgpGs24Yot+lOBu60ESqemGF2MBFol01K
	seqHn2UP7EeVfwMHR+d7Kr6CtoKZ7yQ2YpA==
X-ME-Sender: <xms:sMZUalaG4lrRawZTpsjRPkrXAu9VgYtJOACC0swX9iv7xY1Uo-AdVg>
    <xme:sMZUatHkGzFVIVadl3xhM_rXl-WBiRpGjkOqiYqmc2r3hoBRzGhuBbhSmJE8OfAmw
    ZNsu91cnZAbQMH0m3-nsdC3qXYX-5qp0vB4url_kZnyeASAFsU0WA>
X-ME-Received: <xmr:sMZUamIH1W7GAbzPM60S03Bnb4yrVI6ix7QVQGgdhTHvhvhIqmTRI8vMciGp_DxgGtzmRpeu79y2zGbZGWnsq3x3Wi1bxl329GbLZ43P>
X-ME-Proxy-Cause: dmFkZTFSRZe2YKKBBDN9/O5vlZiAs+IFvBXVmI8TWzhL/tNYodMlYg6NYueRHRRIp98xI0
    X7sHrbWdRvshgNT+WNJgzqO8Fq1NTUrcpyWsJsf2QFCkE0lxtx2uT5rnQhE0+Es+mOZMY+
    vwDZSXrbqt3uF9PI/KbD8V9KN0qaipF/tc2+KfCefyZ35Jd81EdKBdhHzTqtVVfMuvSyga
    Lhi4IR7olVU1ljXYJkcL2WqRXY1uzHcgv11Zvv6U0P8YzZaFaFbyWbVl7qeGascqJB21pT
    ZPxZMhjjhAd7ElRMaXHRbG+oAnQyXyxpJtw8JFskKIpZJb/GY4v/8eu9cY7es+EGgc+4uG
    LyN5RQ4gWjBDrbhctKeJBRVUMY7SmXrgSWGjQ5x6r2cZZz/loa8HQqaQvgKaF1TV1dB/Q6
    gF8oXBAYUaukTGS715lgYXXbx/nNCbFk634WeRBBw2vWfCvnaqKdMW+Taj/v9Kw8cqgACu
    uLHhuz4JCknhC61aP5de6RcCDICaHcIckaBEfzOUJW1HnWMs3ewBJUT7C4Hv2hKv7iXUCj
    K4PI0gr7bYVoAHEU4+pmAS1S3X6x13ACf7i5gyNo4DNkPVHE9kZvSJX/tWz0xR8EgnhDzk
    ByfbYHVo+0+4swEIFVBVuEeu1xQ10tD1IoDyDVeeLXELuFj/OwPd05mx5AsA
X-ME-Proxy: <xmx:sMZUaoOQ-7F9_icULCEwEJhcIQXOPrbwTD1RK8dP6YJPb4u0TOKzkg>
    <xmx:sMZUammVkBLIhSoFJWmBV40WyBHWSJL0nGuYAE4NvsLSUWD8jIQWzg>
    <xmx:sMZUas7uACd0L4zhFoIFlvE9zv5rR0IOi2PWkPyV5hXz2aBqKHfByA>
    <xmx:sMZUaq1_Z89k1MTRemYKKyEVBAcA4Z7PdelSvbvxTkM0lw-J3YzOsQ>
    <xmx:scZUakokThPh-h-fwnjP3RyDn8r7H82TL_JbIA4HlCGf3NxOyNTez32z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 07:06:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03595036 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 11:06:20 +0000 (UTC)
Date: Mon, 13 Jul 2026 13:06:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: cygwin v2.55.0 test failures
Message-ID: <alTGqS2_RmfGHvfV@pks.im>
References: <f65466c9-bede-472e-ad57-e72a5289be27@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f65466c9-bede-472e-ad57-e72a5289be27@ramsayjones.plus.com>

On Fri, Jul 10, 2026 at 07:32:23PM +0100, Ramsay Jones wrote:
[snip]
> Note that Patrick wanted to have a clean test-suite run on cygwin, so in
> commit 5f8af25ff9 ("t5500, t5601: skip tests which exercise paths with '[::1]'
> on Cygwin", 2024-10-16), he suppressed the test failures in t5500 and t5601.
> (that was about the time of the v2.48.0 release).
> 
> The changes to tests t5500 and t5601, in the patch given below, essentially
> reverts Patrick's commit 5f8af25ff9. This fixes all of the tests in t5601 and
> ten of the twelve failures in t5500. (I don't recall what happened to t5580,
> the single failure - the push test - was fixed somewhere between v2.43.0 and
> v2.44.0-rc0).

Yeah, this was merely papering over issues. I'd very much welcome a
revert and proper fix for this.

> As luck would have it, I left a note to myself about the remaining two
> failure cases. This leads to the remaining hunk, to connect.c, in the patch
> below; ie. the removal of a conditional (which should only fire for GfW and
> cygwin). The '#ifdef DUMMY/#endif' should probably be replaced with an
> '#ifdef GIT_WINDOWS_NATIVE/#endif' so that GfW is not affected. (Having said
> that, I suspect that even GfW should drop it ['somebody was smoking something
> exotic'], but I have no way to test it, so ...).
> 
> With this final hunk, this patch results in a clean test-suite run. :)

Nice :)

By the way: I was pondering multiple times over whether or not we should
add Cygwin to our CI matrix. It seems to be sufficiently different from
both MSYS2 and native Win32 to have its own set of compatibility issues,
so that could be worth it?

>  connect.c             |  2 ++
>  git-compat-util.h     | 39 +++++++++++++++++++++++++++++++++++++++
>  t/t5500-fetch-pack.sh | 14 ++++----------
>  t/t5601-clone.sh      | 11 ++---------
>  4 files changed, 47 insertions(+), 19 deletions(-)

For the record: I don't really have much of an opinion on this given
that I tend to not use Windows, except when I (once again) break some
tests there. Especially the path handling si something that tends to
cause lots of confusion on my side.

Patrick
