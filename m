Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14C366DC6
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777912; cv=none; b=Yfwi6DyyN7+e1c+BHxLt7Zjg4QO9hSjZaPGnrfDukTK6eBAcRm6nRSaNWwCtaP3RM4RRcG5GbhGPPxSKQvDzRmDNdbGfSduW1/SjFlcelmUE7rEzElT8eb3i4mva5KtQhLkItbOdSxKN+Cn9DI3RZHhrugUYMsUBthhLrRJVWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777912; c=relaxed/simple;
	bh=bdwvJ3YvDn3IW4HZ6naA9bQ9M58QCO5fSaFnu0hDLN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0Qedxi7Uw/U7m9YdQ1ocOY2aO2DaKPLn9WqmVFTfJjkDEuvC8N0kIKV3K4wZXgprGpwkWmr4+wtPHqSl2zEaEgPHX+3ay9/Q2Pqo2qb+1vZ4/8ZHbWftLKJ0lrH8f8qR/YYomZjeFDJjCMpRUSPgKxmcJLO2HkGM/NAPTgBL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EvRUV7t3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SII9Hy2v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EvRUV7t3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SII9Hy2v"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BB19EEC05DF;
	Fri, 30 Jan 2026 07:58:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 07:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769777910; x=1769864310; bh=+6vIMAmSFU
	BScEiy8zOwSfC9QZdLQe36HZ7bpxp4U2A=; b=EvRUV7t3VSe6ANibIJTNq8vfBJ
	7bRfNNt6E7sEAez6Bcbsg8iJNlHcFZ7SIdEr0DMu5pxZEaNM7GoTrmO+07cimhNP
	Q1oQT1HdQvZpIuBdHPs4jY4BQHLSuRSIuRT6B9GSYcKm/l8b4gaTim3zv4/iaSna
	fLmW/uXor5dsKiMG6wdJcouhPxwzDqM5RliwkuNI/041lmSnwDTJ8C6cpVNPVQd9
	LsHAeDMWPIVbD60kCDJSmx8gCoIabeshAeMy+2rZfGKacde6K31COMmTpx1ybzge
	HliANd5BQsKWOyUVSF/mUwQnYH8uKIYIAlJj4HZbaE9Qu29ib2VQ5zRWkB1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769777910; x=1769864310; bh=+6vIMAmSFUBScEiy8zOwSfC9QZdLQe36HZ7
	bpxp4U2A=; b=SII9Hy2vTxh8rTlNqbbVmUGGgaibNt4zOs7mkRKews1fvgM+Pyf
	lsgHyne/VHKn4tblqtmFdpcA+Q32JfDik5cwGdSssAqZXpmombpTgcSUKg0MgLaA
	XC/L0TB+azwb+0sIatsL/NYHcPRiEnSgLJh/i+VZrZsaA8mxfg2Ugy1dhb1CottT
	dF9NGZL9rn/R4dN0k5Yj0VP5ffaXLNpJgIRXJx+EHyH4okldm2kIse3+hzprBrJf
	t95I1nn+qeG4Y9aUblh+q/1RdxCTXbUi9MbeD2iZAXX24oWAtD8YNQBNjHPWMd08
	rjgNnqc9ueCKUIiIAGYJmHMwKxvtUPf55Sw==
X-ME-Sender: <xms:9qp8aR4XfldV3aOSsvrZJAem7SxjT-6I6rytpu9e1nHTPNQmPzB5FQ>
    <xme:9qp8aU5rsLUHZs08dOPGkorOa8Syhlzrj0D3yIWYyBBsm0Lz9CvZH60EkVpph_3wF
    Wi1XZ7r9hjCeMy56fVx6ixTnWdR-BkXsNh8OXNoqYbb7hkhtz8I8Uc>
X-ME-Received: <xmr:9qp8aWG6tqBaCpBz-Q5X30cNHAZBw_UF0FMZwfdM9un02Mzxeg6w9PrF8_ZrQbDQGGDeEwtFnaSqtD6vDq1B3FX5GT0TF3aXwZ7_40O_1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:9qp8aVTKhrAfmtgdInF01q9WV3yOjluOhvChV01E7Z0kiYjM__GZVQ>
    <xmx:9qp8aXsbYop3bjMCj4Rt1n90PUT488YBTozpjh9wxCxSjt7msAXwGQ>
    <xmx:9qp8acwgcq325szY7APNsAbRD6LCIm72suQRSt4Ic1A6SvHGl5rhUw>
    <xmx:9qp8aZ7xs2Jk28ClV2Q7sbOZ3JFICBm0aXdfKlU4H8YqEinPJzmV2Q>
    <xmx:9qp8aXBmjtQMMhgUKNXN75gFzqGkVFqGXQ-IZkTbLQY2YBZj2hC--nwp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 07:58:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5aef4851 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 12:58:29 +0000 (UTC)
Date: Fri, 30 Jan 2026 13:58:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Message-ID: <aXyq7_yo2tVv7y38@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
 <aXrGfGUJQ34JAmuz@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXrGfGUJQ34JAmuz@nand.local>

On Wed, Jan 28, 2026 at 09:31:24PM -0500, Taylor Blau wrote:
> On Wed, Jan 28, 2026 at 09:49:21AM +0100, Patrick Steinhardt wrote:
> > The "pack.preferBitmapTips" configuration allows the user to specify
> > which references should be preferred when generating bitmaps. This
> > option is typically expected to be set to a reference prefix, like for
> > example "refs/heads/".
> >
> > It's not unreasonable though for a user to configure one specific
> > reference as preferred. But if they do, they'll hit a `BUG()`:
> >
> >     $ git -c pack.preferBitmapTips=refs/heads/main repack -adb
> >     BUG: ../refs/iterator.c:366: attempt to trim too many characters
> >     error: pack-objects died of signal 6
> 
> Oops. While we should definitely not BUG() here, I am not sure I
> understand the desired use-case of specifying a single reference as a
> value for pack.preferBitmapTips.

There is not really a desired use case here, I just happened to stumble
over this bug due to playing around with the feature.

> Looking at the implementation of bitmap_writer_select_commits(), we do
> not guarantee that *any* reference specified by pack.preferBitmapTips
> will receive a bitmap. That's because we don't necessarily enumerate the
> entire set of commits when determining which ones to bitmap.

Yeah, we don't indeed.

[snip]
> > One resulting weirdness is that two refs "refs/heads/base" and
> > "refs/heads/base-something" would now match if the user configured
> > "refs/heads/base" as bitmap tips. One could arguably change the
> > semantics of the configuration such that a string without a trailing
> > slash needs to be an exact reference match, whereas a string with a
> > trailing slash indicates a directory hierarchy. But such a change would
> > potentially cause regressions with dubious benefits, so this issue is
> > ignored for now.
> 
> (Setting aside the for_each_ref vs. for_each_fullref issue for a
> moment...)
> 
> Am I understanding this change correctly that doing something like -c
> pack.preferBitmapTips=refs/heads/foo would match both foo and foobar?
> 
> If so, I am not sure that that is a desirable interface, especially
> since we went the opposite direction in 10e8a9352bc (refs.c: stop
> matching non-directory prefixes in exclude patterns, 2025-03-06). Having
> the two behave inconsistently from one another feels somewhat awkward to
> me and may lead to unexpected results.

I don't have too much skin in the game, and as I wrote I agree that the
things are a bit nuanced here. I think there's two major ways to go from
here:

  - We can either fix the bug and say that we accept all references that
    start with the configured prefix. "refs/heads/main" _does_ start
    with the prefix "refs/heads/main", so it should match.

  - Or we can fix the bug by appending a slash to the configured prefix
    if it doesn't already have one.

The reason I picked the first option here is mostly because it allows
for more options rather than restricting options. The user has the
ability to both match hierarchies by appending a "/", and they can have
ref-prefix-matches by not doing so.

I'll adapt the commit message accordingly to document my thought
process, and...

> At the very least, if we do end up going in this direction (and I am not
> necessarily advocating that we do, since I would prefer a more
> consistent set of behavior), we should at minimum document it in
> git-config(1).

... will also adapt the documentation accordingly.

That being said, I'm also open to adapt my approach here.

Thanks!

Patrick
