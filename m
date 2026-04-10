Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F17145A05
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824277; cv=none; b=AsbAbCq6cGt9lJLDwl7xt8SLzEJHpUUCk1Ndgr+gfnFGKIToKKePTOANylqaEBZrkPoB7/67APtK/0vTue/q9hIoai3OKyKkkb9iiAF2r6wuGZK/PdRlaZug69K8ucwYydzudDYdPvnvtmXsAgQbRwm2pH3tiMxSmS65UcjQNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824277; c=relaxed/simple;
	bh=RNM3R2fcL1+emjJBiqfJy73nJpEVywiyw/qaSHLuvBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awrKE+0nRnlE33iPt/Bn/RhTT2vYyxs9ojmV+gcqm9KJN8ZuckhqylEXP9oloWnDepR+vpC1ilEbPdYHx5zHNC7IJOGQ5OP3wJokZ1ljbwiuDX4kKxmoRnkS8pnX/ujI+NN0pJY69lf5Uo2W7P9We3ZMEdt6L9q4reDkJUwqWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LXD/2aJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aicUu55e; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LXD/2aJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aicUu55e"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 763F11D00262;
	Fri, 10 Apr 2026 08:31:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 08:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775824275;
	 x=1775910675; bh=BbwK3CFGgzuZL7KYWAdlvAw2WzzgW2rrylr1uRuyuvU=; b=
	LXD/2aJcBpaGA7gJaVMP+XUVzvkbGVoevyODUVDiLRMH3O2aypLE+WfcaoJnkvgt
	7/Ir2v0RhA5qWqtkmzhdl0cLYRE+6o02rjJMNoYXHeSsnWynqyj/U6V9zN/sf59H
	h1ZTA9JFjGZwh9otiIU4Kc0PtQ46ymUm3TN4yXAApd6wXyI4XP59uAQqHgcipDP2
	ISLwDJlRmqgGpikAA3JuzJiNTiNE2KJzmFNYtz0L+Pr4YA2DvuAsGxy5tgKExZYv
	o0aqQebrRyWqQf1YszosLr8OfZUJ4ECabIfn8EwZf9lgZCnX0xdj4JxaiK5nK3Z/
	Mt4V5rQfW4ogJx2RPjyeJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775824275; x=
	1775910675; bh=BbwK3CFGgzuZL7KYWAdlvAw2WzzgW2rrylr1uRuyuvU=; b=a
	icUu55eySaNQ6stjANZWKrObH+jB5Q4S7usJkY/zyIEmQgiK7sP6/DlTzGP4LJyy
	XFkhv3HfnJ2rtSX6eAelxmtUWl+/DCaSfwgzCdWl880MA71FTMiStla3+CbI27IJ
	Bx7ClwsM/5mqnxOBXQF+ELwdLSMvk9mirXIGMLriK4j1+UvTHqU2tNwgsM1Hg30y
	dbQDaccb+B6AOhWFmPH85guPmTvqPON1k1+AvQOYdUkBNmhzU0IMuurnwvAnLoil
	4TLdkYovdT3qhaeXhO9BHtu97h2s050YL8VcNzmTbY6ZlvyYKDZBeafZBUhRYJsw
	aglJa+NWkgMKKGuYQhenA==
X-ME-Sender: <xms:k-3YaQb1i54HVrsOHE-EFctfLcYzrUc6qfXdilHQSi7xAqAQko7uBQ>
    <xme:k-3YaRZX1i3GCEUP1gVb4Giza4t2WAguwg2M6oylyOXQlI9Rn0q_0mTt9j97QdDcR
    5_vUe8MF-WqhetYLuDO0rTo1bPPiHpxiiOInk9hwHuxRFSbw3uq>
X-ME-Received: <xmr:k-3YaYnOEafjE-pHWvOzLxvQk8RZlVVEIe04fnjqEoQImJjJKQwDhasWnqTmBZUKBuIC-nKMpjAfAWNi6R3s3amrvitLP3mo_qGHBZxh7bIPmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphihthhhonhhikhhssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k-3YaVxPSn6SiuiEh0mQOh_qEk2n-19Q5mCi0m9SIUth_J6pRtS89A>
    <xmx:k-3YaePvhmNGEkOAnTWtDHPBDyF9cVOKRKOsPmCjt8BxgP4vktOjEw>
    <xmx:k-3YaRQB1jgVEI8oEHKsjHpCYt5CcVLULkesqEqOPaeZKMWidPy9Xw>
    <xmx:k-3YaUYgG6pbfHoSaSRNwhuu1U0PWFlBzpAumW3A3N-rR3Zaf7qEYw>
    <xmx:k-3YaWJQzFnL73RsGB-R8RMEBn_GdJyYvMVJAL1OuZavRzyF120bjcRM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:31:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95ea289b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:31:12 +0000 (UTC)
Date: Fri, 10 Apr 2026 14:31:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Pascal Chambon <pythoniks@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug - git fsck never ending on git-for-windows
Message-ID: <adjtjv76Th_lPRKv@pks.im>
References: <a07a6a49-0520-44c7-b9c5-2173465cc1ca@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a07a6a49-0520-44c7-b9c5-2173465cc1ca@gmail.com>

On Fri, Apr 10, 2026 at 09:20:20AM +0200, Pascal Chambon wrote:
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> > I launched "git fsck" (with various arguments)
> 
> What did you expect to happen? (Expected behavior)
> 
> > A long run of fsck and then it's over
> 
> What happened instead? (Actual behavior)
> 
> > A (seemingly) neverending run of fsck, exceeding the expected count of
> objects to check:
> > $ git fsck
> > Checking ref database: 100% (1/1), done.
> > Checking object directories: 100% (256/256), done.
> > Checking objects: 190% (54090/28351)        -->  (process still
> turning...)
> 
> What's different between what you expected and what actually happened?
> 
> > Normal, finished fsck run, vs neverending checking of objects.
> 
> Anything else you want to add:
> 
> > This is a quite old repository (from 2012) with quite heavy media files in
> it (70 GB total).
> > I've tried to "git gc --aggressive", it worked, and pack files are
> numerous and about the same size, but the fsck anomally remains.

This strongly reminds me of the issue fixed in 13eb65d366 (pack-check:
fix verification of large objects, 2026-02-23), which is going to be
released with Git 2.54. Could you maybe verify whether that commit fixes
the issue you're observing?

Thanks!

Patrick
