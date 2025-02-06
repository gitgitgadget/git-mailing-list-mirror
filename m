Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FE2144BE
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835605; cv=none; b=mCWV2Af83S/WesolpVyfd76mqvED8rz5Bu0gGjmroCjXj3fc0SXyXCboTeJYmBvmpcyckzreLyTJ/ZB+YsvdsAeQiZcFiQ1UP9a1r0S+cJYDK95t4NS2aXGX77jPy7slnePHYvEjJ6KtBqFMcKzr4/hV72Fr2A8rriDYAuSVG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835605; c=relaxed/simple;
	bh=4E5vVgXIWSyLSJog3HjbNUXXUvxf8jh07+Xby5CRiaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzvBly/IEHxf+g1CLJo9G2grtT+oSaSAtOtv6Y13pOLl0lStuun/GnlNkwA3YXzdDd02dh88K9oUT8lKJRF9L5dSSAIEqBhYZ09uMtKqAO9m6OwEJuPgQqY1xQpBng+zJyhUiXk7ch7jJx6X/ZPXCGpRtpCYhnBNi9h856Az7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Br6KSJuR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yy3Cj9+P; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Br6KSJuR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yy3Cj9+P"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C0E731380139;
	Thu,  6 Feb 2025 04:53:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 04:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738835601; x=1738922001; bh=42xflh70pL
	bdt7tWpaCRD/A7wbEfGF66LPHJUXTwcZw=; b=Br6KSJuRT8N+F8imjN/qCUfrcS
	KBhmEY/oo0dSLhPjs91oj08ud+/MVaOVbyYjLVih8hEBNKtSqM38hPkWmFmO1FsP
	enrXot93WDVBsGLNON1g1zuXlgrNsl/3YEr19gwrvdT0WQ9dTN1HyTN/V2wASVTS
	l9vE9NTNJLla5euRAbUqJixOumXv7AD844AyHBP511XjpWhgVFo6c5G5HOCta4zt
	xlC/WoiOdXN7EHoh3ZTm1pjGnMO5w1MbqDEI20NCumRGgzc4PtOs6qUVW8urus1h
	vyK4VLT1tVQUNVn6oxNIpsxjA66gW4dQEdBkZ9NX121taaJthvZeSSROCpAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738835601; x=1738922001; bh=42xflh70pLbdt7tWpaCRD/A7wbEfGF66LPH
	JUXTwcZw=; b=Yy3Cj9+PnjhzjYHISMpYvcKi4AuOuf0ixKLXkKSRwxAYCLT2Txj
	jE0TW23dwp6d9wkEAfAEOSUD0pOuquF3risrJWhkXv4kHjOQmcAF21k0CpnRn6ES
	hHzCAVjkYlq/gSudFz6M3/90xNs/c6wKz8rlug3NzHVc8VdB/jvr+akoVIFHrCCf
	EYg7GJA1EJKCQ6eoepSXi99H0X9mIBoKuepqVhq0NyApVvFqdRm409/ELftskJEo
	r8wK77AMdIjv8pkU2OGpYbPgJ/wUBj+rE9oK7lzcB/HfnsYEc0O+k4zPOsfFKjm5
	Y7USEgXioGpf0tJ0OpzosdvKTZTwhxO2YxQ==
X-ME-Sender: <xms:kYakZ8zUP8z-XV_eWu4j3sRfOdCx0jiPSRObA8WeKZzxHFM8KfEGBw>
    <xme:kYakZwT_Yqzep8dGsJXO1FFmUbcRdQ2wwtegeNg3p08rVLs2k9NH4Fx-oZ-mmD7ul
    As0PUHHNRA4ex8KAg>
X-ME-Received: <xmr:kYakZ-WEVN41mxnykRDAJJkAv0Vym_C7VTqjsK5Fr7quyPlOmeJCn0Hit_dcrw5lT1o4Cy5H5YV1NU7mSVDrfLFF728Xmo5P-Y41gZQQ-Zfv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhuvghlrdhpoh
    hrrdgrtggrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kYakZ6i_YfeSRXzL6BzP4bg4JRm9-7hSfXwb3e1ShY5GfKWNRyjmiQ>
    <xmx:kYakZ-BO88Gph2NYXkcNFJKNrwB7BG5ummnBef-f9xEIkjVERsoTWQ>
    <xmx:kYakZ7Jx3KQUmxygsL8JlZwASDbUHVJEIoS_k2DCjohMNB9TBTz2UA>
    <xmx:kYakZ1Dmt97t8AJjneIr7ukbbhP91hrnoGimqgsNwVrmiOn3bWSlKA>
    <xmx:kYakZx_vQTwEWjyDf3ZqglOfiHOdjcDsFgt4KqE60KaELHfv6dacYUNx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 04:53:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3aa0a9f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 09:53:18 +0000 (UTC)
Date: Thu, 6 Feb 2025 10:53:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Manuel =?utf-8?B?UXVpw7FvbmVz?= <manuel.por.aca@gmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Usability issue: "Your branch is up to date"
Message-ID: <Z6SGjSik-rRsAGUU@pks.im>
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
 <xmqqh65b2ci3.fsf@gitster.g>
 <xmqq34guzi0f.fsf@gitster.g>
 <CAPpV+Oaq3d3oNE-V3pnpQRNrGCoZr52uY91QtWYxcu1tgG_QXg@mail.gmail.com>
 <xmqqseottxld.fsf@gitster.g>
 <Z6MLOA3mJGbPFBae@pks.im>
 <xmqqikponsk6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikponsk6.fsf@gitster.g>

On Wed, Feb 05, 2025 at 10:40:41AM -0800, Junio C Hamano wrote:
> If the user, on the other hand, is interested in keeping track of
> all these thousands of refs, "git fetch" would have to ask and
> receive advertisement for all these thousands of refs anyway, and
> at that point, recording the no-op update would be a very small
> part of the problem, I suspect.  Besides, we have reftable that
> would make this kind of problem easier to solve, no? ;-)

Yeah, I was pondering whether to bring up reftables or not :) But
indeed, with them it would be way more efficient, at least assuming that
we write everything in a single transaction and not via multiple
transactions. Which we generally don't in git-fetch(1) unless the user
asks for `--atomic` because we allow for a subset of the updates to
fail. Consequently, even with reftables we'd end up writing N separate
updates, where N is the number of advertised refs.

This is a known problem that we actually plan to fix. Karthik is working
on support for "partial" transactions, where it is allowed that a subset
of ref updates fails without impacting other refs where the update would
succeed. With this in place we could then refactor git-fetch(1) to write
the update with a single transaction, only, even in the non-atomic case.

Patrick
