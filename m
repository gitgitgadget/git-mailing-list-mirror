Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30436215D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606573; cv=none; b=HhWZ6/R3jHUdY3wQir3QPJxE9NMeBdP6om6UeWlkV00bNi3qkf8xUL59+yt/91yP/CIbViasvhOdAuNVQlJrPS7T6rqybmFx2k/rxpB1gOO30blmbpDjyEDuKQqMNVRkpfEkm+MMvH4zB6myt+UQ0Nf+Gr1x0fCH755rBgKL8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606573; c=relaxed/simple;
	bh=sB4DbfL4f067RDxhy8f6VBnMUG7jsGDgDSDlzU3uzIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMGq6d6AaUKsrrwYHPD94io6fDdzHQmiw5BFi8cBAhGmlH+k4FYMpkfzJ0K8kZ8PhlIQWWsPGGTV0g9JarFq2jzxME+srQYA30Pa77xD0NUweAXNRVc5upiqdrHTD/Bm0tCEEugh1/6SHGlZWYn04BjVEBfS0M+OSu5Ak8Z+23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cC84tXDL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdcAnpuo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cC84tXDL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdcAnpuo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 32C501D00107;
	Thu, 13 Aug 2026 03:36:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 03:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786606570;
	 x=1786692970; bh=p/mwBwu7wknWzE1UjSgpF5A+a82WgXfTmhn8mz2Mjm0=; b=
	cC84tXDL8YdlBeqIa9wUJ2M3I1Zj1ei2vsIIwJ0MYn0YVSYvQ1uuFvXmgejltC6a
	potsO8Urdkcr5AmMFjQd64i1svt3ItXtwjG+jikvzyk/rp/aCtG+aqcYHivL9QjR
	sqrw4+6dq/CXgR2mgHqJsFz4b2rCwZWaMtf4y8RVvG9J+DurDGIl2gLYgZtCRS6v
	rMUy2/mPD4Sc3u+RboCzSQscl8wufWNE4wSfMHN1KlYLslUnoahYwtUSYwrtqpqv
	7g9H+eXYaoxuLaw0X6HkvTLsg3KAAdKdmgGS+qJ5umPfRY3WXio5dJ5qhlYhnkxP
	vgZw0/2FlRnyIbl5xySk+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786606570; x=
	1786692970; bh=p/mwBwu7wknWzE1UjSgpF5A+a82WgXfTmhn8mz2Mjm0=; b=I
	dcAnpuoKPDGsFCZr+E+KQR5D8oXrjWZKneXyGjz8sLwpSQTXyiVEcm11JDmjGFVx
	vxAfeL1GQCmZdtO8cTr1b5ple87cy+YyM39g+fKQ7Cj44WCy5aRlqx1nAMMLXVVq
	NKI9I/Pp+6MnrQwNB6SzVLMM/qI2314q2hmnofB2nalFpEMhXE4bjyoYpYMpqdv3
	hQdwzVJUcCWsZewFw7bSKKwSt/sNkKbiGg+1iaWbuHFWwkPJk5JWNXieCEPY94On
	oJstF+plUe2svyqGL25+XjbxauZx7ZAjrJsCXN0t+7JZceTz9CJ0BkFVGNTfiHkv
	CWLANAWglBIR2rCXUUicQ==
X-ME-Sender: <xms:6XN9as05jCP21zi1NKSZbK3nWiXxTeIPj1LvCEmhR1QUWoqBBV2w0g>
    <xme:6XN9at-wy0jwAbKL34iRPb8c1fmru9o6I-kW3NocUIfg6o9cURnWTP0nJ4RrqhlmX
    -MS1AzAalEqxJJNAwZ-QR41mmXN4UJFxPrPq3mD9_xu8hXcpfICCg>
X-ME-Received: <xmr:6XN9atM7SRKZD4H3Ff461KWn3HLnh1Od7E8sOB6xYGiKPgtJqAqddyBRF34b9shXFqWT61eQl0EtbqwCGWqkTUzWhz4lxSLOA54XnIYLa15P>
X-ME-Proxy-Cause: dmFkZTERXG1Rgb/IllmB+fbERYHN5rVVd8XsInZ3BA3CF+anz852xuTzWLfvfs1Q+x/bgG
    Xef6ZY16GISflO6lt7gDvxwEm1OFsxIO+wcS5OZfA+Cz/XeNaPoFYDTCTdpOESlHdOKSox
    8HX99eBe5kYAzFc289kr6quhiybIzpCsRtMWKr24r7nQjql58DA++a0lzAEQFONxi81v9B
    D8+TC1KNWgXLVo91YmTwiHmSLlVx6QzcxzJ4jrYdPmT3Lu7g8e1omB/f6ssAebrhP/gQ2Q
    mJO0b+Hy9EHHdKFe+IT0ChN6yzAMjceowW4YWPnZ024p02lGI+BKleRThIm6gKxFPKLVhO
    6uNpFTm6dCY/FjXGkQdasJJICjM2FSnoawi6GaJy29jaI77rOy/SG4X6xcKQ9zSmke1QIx
    d7tKzKAOUdnQ2Lki9mUn8cnES5QiW4JnmCSwP5s/PQzfi+qpgyfD1ZZzkIVU0KrTnFARHZ
    3Y5h+4YhGJYbSbSak9C9x+SLtc8AuOwe1MoKI6oe1LBCK76F8LyRGdv1/SOv23/ImK8rBF
    Lqlar0sfwj6vyiH3VM9D2zFa1Y3ZmEQ+SySUU+qTvclpkJfbsxvaaZoJPnVTY38dued5vt
    3fALvVdsv0KZwhTHMuNCm1IJjSeylI5USaOzYu76hQ2y5KWpAgg51XrBeJQA
X-ME-Proxy: <xmx:6XN9ahc1EztMcrU9O0elbB9FCMsWnC7ziqcGiZabr8Jq-JTmfaOPcw>
    <xmx:6nN9asUBKoHvRkuYWtkUHbu6F9SGdouA9T9p8_hgbelChCJuhQddGQ>
    <xmx:6nN9apgYEjhrRqHAK4PmtbrlsylQdWVW7DRwJUBHyBmNj_ImY1ZPlQ>
    <xmx:6nN9ar9QJvQ4VdH_Z33UZKmqVX_q1lgzCOSoOUlLa5mAXyNdm8KsGQ>
    <xmx:6nN9ai4Um_Rot-IffSrYZywQskN1uAcGlR7n3RZeJ4GanlCBwG0RJFmC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 03:36:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 14de3cf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 07:36:01 +0000 (UTC)
Date: Thu, 13 Aug 2026 09:35:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <an1z3uy7Xtqw3U_l@pks.im>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <xmqqfr0jw20t.fsf@gitster.g>
 <20260812212955.GA152730@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812212955.GA152730@coredump.intra.peff.net>

On Wed, Aug 12, 2026 at 05:29:55PM -0400, Jeff King wrote:
> On Wed, Aug 12, 2026 at 12:51:30PM -0700, Junio C Hamano wrote:
> 
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > 
> > > In one reported use case (https://github.com/microsoft/git/issues/970),
> > > N equals 37,815 and caused a slow-down of a simple `git rev-parse
> > > --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
> > > 0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
> > > increased from under 2 minutes to over half an hour.
> > 
> > Face with Rolling Eyes (1f644) 🙄
> > 
> > As we grow older, more and more extreme use cases that we initially
> > thought were simply crazy become reality.
> 
> Sort of. The quadratic adding became a problem long ago, hence
> ec48540fe8 (packfile.c: speed up loading lots of packfiles, 2019-11-27).
> 
> So this was something we already dealt with that regressed. We can even
> see the regression in our perf suite:
> 
>   $ GIT_SKIP_TESTS='p5303.[1-9] p5303.1[0-9]' ./run 589127caa730^ 589127caa730 p5303-many-packs.sh
>   Test                         589127caa730^     589127caa730
>   ----------------------------------------------------------------------
>   5303.21: load 10,000 packs   0.13(0.11+0.02)   0.45(0.42+0.02) +246.2%
> 
> Unfortunately I don't think anybody pays close attention to the perf
> suite (partially because it's clunky and expensive to run, but also
> because it often requires human judgement to decide when something is a
> real change and not just a blip).

Yeah, that's a problem indeed. At GitLab we do have Bencher set up for
continuous benchmarking [1], but due to recent changes to our CI setup
those are now very flaky because seemingly, we flip-flop between two
different runners that have different specs. But we're obviously missing
a test there with lots of packfiles, so we didn't catch this regression.

Thanks!

Patrick

[1]: https://bencher.dev/perf/git/plots
