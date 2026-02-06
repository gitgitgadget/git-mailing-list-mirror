Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB702EBBB2
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362024; cv=none; b=eK/PqqLV3/Q17Bhr8Wd23Ap1hPMI2EEpg+aSL7EnP1eQgJjMW34AKhTrjL+I7Erhf8y5+Z2UlOZt70vQ1LL+ZiG8VblEpqxpP1SG4RHJZdGzox15Pxim3e0B2Myul2FBaFjrTYdg2mRotvPQzKZg1DjW46rRs8u2Dvk75QfdGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362024; c=relaxed/simple;
	bh=nRKeDsT8q3Qoh6rcgqVGs6hMq1ffsA08iKb/4ZzwO6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmo+J/Z/CaSdVV4rQ7Efy31NvVxTJC8q3x7RgEQq/+myAAoo7g1meAPFAgji4y/nU+bR8LnjVNpjbJaos9rxfzEiL9fxhcnKo46x0cLs7Ie99gmQACwgpOhE4SVo3FDg89q6/rsPB6z6Ce3CPc61SkaDuipjaDqKAOISPcN46Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VNjvozat; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=paZuph2S; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VNjvozat";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paZuph2S"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5C557A009C;
	Fri,  6 Feb 2026 02:13:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 02:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770362022; x=1770448422; bh=vtXDBMtQ7F
	lA2bjohnp1Bvboe6uKiizeCw2aj+qpjC4=; b=VNjvozatqSNKrLNhmmM5soYvPX
	7drxjo9BwRkn2Yag6PHPZVxfXcd0P1wc9kjnrShprkBhSsENjaY9nJJMvAFTc9nz
	LC/laiKmt3gTydeUMPU/FSaNAzCfMVg0r/PFZZBWdOYgGgoOonkZOD5xoNZLsORZ
	pQy5lDGeoyk79RwXcQ+Pb8QYz02HQ8UYRC77U+5jveDZg4ywQguhOvmwvDlB4lmn
	mzBuFqmqQ3TqTD5xO0Bv9dq9SVoT3wATlvJHMebQI5GrjX5TI+PIrOVMZBtqmPfu
	7TnRLTivyJzA2a93x9g/mhjta01y941dKPprweAkppTw4bjbao5x7+p1qbmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770362022; x=1770448422; bh=vtXDBMtQ7FlA2bjohnp1Bvboe6uKiizeCw2
	aj+qpjC4=; b=paZuph2SVLUzzyxDwGSrMV4k+/qtbkrEH998QFEHm9AmtZFhorQ
	7husd5P2/LXCCbH7BFycmGVJ6egrHqfivLdp7mmLBHODEZ41EX5WLsG1MjKfaVsV
	97YSFNsFTkcqZ/IJ+O74+YslL2SRl9TvZc1y84VNlsXFljTDSAoTYcXtBSevdy7a
	33m46ref/6f5MyKNGJSTc7/tXMN06WUiE8RiUoPWoyzxaRbjMEdbmW2qI3L6QFqr
	2ujyGFFS7jZEGbDGuEohJVDcaL66E7Scr6XvcQu72lZz3S6m1SCry+UljE3Eej7h
	7xKJD3aILBs5YUeO8j0uOOtIAqp1JenkbuA==
X-ME-Sender: <xms:ppSFaUxvyEiCpLsaOrIz0rd-i-YFhirQTa4rMwZEno5TK6Wz_AKfMg>
    <xme:ppSFaeRK-Wu4WnyBDpjn2R2d-z6DI3NjMfUCuRXBCO7XzRLiNzssVIK9Fq2F7udtF
    Wvb5ujkXc56-dFHEEQO0f2jrl4gDSJmk3r1QVLnjcpOw_LXuRIDiuo>
X-ME-Received: <xmr:ppSFaT-x5ugGjXjwOP59BccEjuuWBh2zs4SNCD3bVeBr6Hkw0lSgcWvQA1LuuAZbwCPjjBn-eLxqOZ5CV9iM1uVtgp4_9FR8gYEsNYR5__A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:ppSFadpaZp3UMs2Xh6_kYYIX0KLUQ-WUsAKRBLejZfxSR8bSgC8VCA>
    <xmx:ppSFaYkI87Cntmdenq-DjKPQDviy5G4NBM5RTz77oKfhrhfMFSHwKw>
    <xmx:ppSFacKjCfvueANSpBp8JSgdY1rtGZh-rMDsR3XYHpGLMsVGrUfYUQ>
    <xmx:ppSFaVy4p5pwOb2P_nQZuzEIdgsrCp7Yvoyei6xDcXx9ItywCfUUMg>
    <xmx:ppSFab617JkOTamIRFCDZMgaRtDAvrZC9l-TT7sdb9ZnYT-MA4N4b1rC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 02:13:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 272ac38c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 07:13:40 +0000 (UTC)
Date: Fri, 6 Feb 2026 08:13:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Message-ID: <aYWUnM7aA5SJBdwS@pks.im>
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
 <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-2-0449b198a681@pks.im>
 <aYAIVw5UMQeP3Ilr@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYAIVw5UMQeP3Ilr@nand.local>

On Sun, Feb 01, 2026 at 09:13:43PM -0500, Taylor Blau wrote:
> On Fri, Jan 30, 2026 at 02:27:43PM +0100, Patrick Steinhardt wrote:
> > [...] There are two possible ways to fix this issue:
> >
> >   - We can fix the bug by using `refs_for_each_fullref_in()` instead,
> >     which does not strip the prefix at all. Consequently, we would now
> >     start to accept all references that start with the configured
> >     prefix, including exact matches. So if we had "refs/heads/main", we
> >     would both match "refs/heads/main" and "refs/heads/main-branch".
> >
> >   - Or we can fix the bug by appending a slash to the prefix if it
> >     doesn't already have one. This would mean that we only match
> >     ref hierarchies that start with this prefix.
> >
> > The first fix leaves the user with strictly _more_ configuration
> > options: they can have prefix matches by not appending a slash to the
> > configuration, and they can have ref hierarchy matches by appending one.
> 
> I would definitely like to err on the side of more flexible
> configuration options, but I am still concerned that this change would
> lead to somewhat surprising behavior.

I think my point is mostly that this somewhat surprising behaviour
already exists right now.

> A couple of thoughts:
> 
>  - Like I mentioned in the earlier round, 10e8a9352bc (refs.c: stop
>    matching non-directory prefixes in exclude patterns, 2025-03-06)
>    takes the opposite approach as what is being proposed here. I worry
>    that users will find the difference in behavior between
>    pack.preferBitmapTips and for-each-ref's --exclude patterns to be
>    confusing.
> 
>  - If a user wants to list all references that start with
>    "refs/heads/ma" in the string prefix sense (that is, matching
>    "refs/heads/ma", "refs/heads/main", "refs/heads/master" and so on),
>    then they would do
> 
>      $ git for-each-ref 'refs/heads/ma*'
> 
>    , not 'refs/heads/ma'. In fact, enumerating 'refs/heads/ma' when
>    there exist references "refs/heads/ma/foo", "refs/heads/ma/bar",
>    etc., for-each-ref will output those three references (but only
>    "refs/heads/ma" itself if it exists).
> 
> I suppose there is an argument to be made that we are dealing with
> "patterns" vs. "prefixes" here, but TBH I am not sure that is a
> distinction that is well-understood by users (nor should we expect it to
> be).
> 
> The original intent of this configuration was that "suffix" in this
> context meant directory suffix or exact match, not string suffix. The
> implementation does not match that intent, but I think there is enough
> ambiguity here that I wouldn't consider the change I'm suggesting to be
> a breaking one.

I wouldn't quite frame it in the way of ambiguity, but rather in the way
of it being very niche. I would argue that almost nobody out there will
use this configuration outside of hosting providers. GitHub will
probably use it correctly, GitLab doesn't use it at all.

So I guess it's fine overall if we introduce a breaking change here.

> Overall, I think interpreting the pack.preferBitmapTips configuration as
> a reference pattern gives the user both (a) more flexibility in which
> references to match, and (b) does so in a way that is consistent with
> 10e8a9352bc and the existing behavior of for-each-ref.

I disagree with (a) as you can do strictly less, but being constistent
with (b) might be a good thing.

At the end I'm not entirely convinced by the arguments, but as I said I
don't have too much skin in the game, either. So let's take your
approach.

Thanks!

Patrick
