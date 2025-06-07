Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1001CEACB
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338575; cv=none; b=dl8oZzkKn5JnBb+hf9ZrS0Yqy10YUn2nxST05ucGjGbJ7gtG38m784L69epPntbtyYxqusdoGWltnQ0+WqbIAnlMqQXYWSSP0j3ljDupqwSbjJm75Z+Ftmohad3GQHtSLzm07lAZpC1jvyNOuzzwL9JyCTs9PL+6EWTaa+IViss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338575; c=relaxed/simple;
	bh=XJS+ojTL1q0ABqsUE3gdD0HNxw0FQYkcb2SnIiv/QiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzn+3z8/0D4jNiYjn/QfVSmPgHoJBLacvtURqZ7IczZE6bAd6hTTxTPnX0SWf5+pIhQ0HJf7Rw8TE64o9lXpHGOu/QKWHtuRj7Ha0OGIBAY1QFNKcE7VGEjueupTEVwTTHsI6+x0rgePDRr/44mBltnqyk/IshOUMDUyv9PR8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CHzbK7JX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=emDcQACb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CHzbK7JX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emDcQACb"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6463A25400EC;
	Sat,  7 Jun 2025 19:22:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Jun 2025 19:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749338571; x=1749424971; bh=r8hi2d91a3
	1oXo9b/GMmSJ8780rKCG71f+lXagkRIyM=; b=CHzbK7JXSfIGqgDYzBnzoi0V0q
	MdTZWQ1i0Nwon/wEED2t8ZO2wyEyrNt6gPai+vYUzsSgpsw3Petsn5LOlqHGLfv8
	W+NsztGF5v3HCCzMg2Ew5JOMBEvS2C1aiTMZ3blbu3QCluUaXkvxVKnmH7PrwDrB
	JscofWgpBI+JlNA9sOcsJj3cNkOmlZsir5WxvPIWFjrC7QOBXh+ycTtYtZC0CjpX
	JTi1r8P7L1ZUucmDOBMhQtC+2tq80nKKfLNvmsUaROXJuyWvmq10as30kRhkUey7
	2rBJNteFsXiVUyNqQCV8LDUuY0MuM7n1K8YebTkvaRBEJcDtjsXyyvRDno/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749338571; x=1749424971; bh=r8hi2d91a31oXo9b/GMmSJ8780rKCG71f+l
	XagkRIyM=; b=emDcQACb6fSPt4+MrXrKkkQxBVAbbeaptkVkZUeAy32MM9wIj3t
	L7uBEN6TEQUE3TnXoJ+RXIekfeZ+9jzlPP+L3SA/1t1r6BIPgXpNGvgJuhuvOh4t
	2npGwmW5ayfsPTE32/H+wIOYsH8WJ+DlRrsOO85w+VVEGqq1ELbKas4hPI1M2tu2
	WlqsOUtSy+fIlK/VJuVNRk8hd4MGwGsGQgcqUygvf1iDtbqewdXorQeKdwjhOD04
	gX4kARy5UiOdSEOwbduLBQ6i5JaXYcW2N5xvmP/zkVFT85ixBuh4HUEyP/GFMiFC
	l/ZDzJ2I/ePJleTb/AH/ZactTb7uuJbsfEg==
X-ME-Sender: <xms:yslEaO4lAIXR64KKP2a8-sTGT1OpU7h_HoVJBEVBpEPXSWno27rohQ>
    <xme:yslEaH4WgmYY6nY5Xn6D33XB4zFX3lPLp8-UCnDDe393TtLiGE_NL1SvF0zmMbsU-
    qW19ldPmMVQZz-ghg>
X-ME-Received: <xmr:yslEaNcfIX285S6E097xeM4t2VUgwM5DD6_gf2A6b-pUSf-CPfku5Fz0zxnOVbfpwKzcRrnfS5NyvfFfPoMp0d32xj1VJlXYUHLPVOdZHj29IJKW2jGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdejudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghulhhlihhnghgv
    rhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejffeljedtgf
    ffleeuveeiuedvteekvedvgeefffdvkeetgfetfffhueekheeuleenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphhluhhgfigrshhhseguvggsihgrnhdroh
    hrghdprhgtphhtthhopeduuddtjeegfeejsegsuhhgshdruggvsghirghnrdhorhhgpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:yslEaLIkzRp5lKnVbxNALMKPxMg_wg6CW7ngsvRb8thBcD2O3YHX4w>
    <xmx:yslEaCJQrCRgpYMd3Lb3X3nVAFY_j8T74D3tsGPnoe5e6P1d4E6qVQ>
    <xmx:yslEaMxGm0mEdPSU01hOUWJZtNaTg_QddoOWszY0FzDDuwE7oQYw2Q>
    <xmx:yslEaGL-ZXdRWWoMXGb36Pf-J4j4HYLoB4IR0wwC8wvlF2vAjMeqqQ>
    <xmx:y8lEaIn1ZZf4uiz81pITnOfeZIC0zO0l0RQwG-QTVIcUCJ9hfS3pMHJG>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Jun 2025 19:22:50 -0400 (EDT)
Date: Sat, 7 Jun 2025 19:22:49 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Peter Michael Green <plugwash@debian.org>
Cc: 1107437@bugs.debian.org, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: git - passes wrong types to curl_easy_setopt
Message-ID: <aETJyXsVRS_sSej0@teonanacatl.net>
References: <07b6d5b3-7de5-db8c-5db0-c8c37dbf5364@debian.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b6d5b3-7de5-db8c-5db0-c8c37dbf5364@debian.org>

Peter Michael Green wrote:
> When building against curl 8.14 git creates a whole bunch of compiler
> warnings. We originally discovered this because of a package in Debian
> that was using an embedded code copy of git and building it with
> -Werror (see debian bug 1107412) but the issue is clearly visible
> when rebuilding the git package in current sid.

I believe this was fixed by a series Peff posted last week:

    <20250604205505.GA1510724@coredump.intra.peff.net>

c80760403b (Merge branch 'jk/curl-easy-setopt-typefix' into
js/curl-easy-setopt-typefix, 2025-06-05) is the merge commit
for the series:

    https://github.com/git/git/commit/c80760403b

It's on the master branch, so it should be included in
v2.50.0-rc2, scheduled for Monday.

-- 
Todd
