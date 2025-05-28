Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3646243969
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416469; cv=none; b=miGmB7/PNpdn6aa4bcjFEhvXJpR5qT+qyVcFZvjyJke8k4U2M5vgb0ng625gH3GkwyvN6leuAZngAkZfRlC7J4qxviXzaXph4wjebuYcMWyy//USkTdZe53F3kYboHYZGgVKr6Ryw3DJYT66fSoZqEHj4UD5tElNb5ysznG5Nb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416469; c=relaxed/simple;
	bh=KccHTOZG5TIwXmNpPv5tH9s4iCe6D1z0PxJTdlNRopk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlzA1+Pfdf4ioI2YxZgMpkMc7JO1n32oQVWH6fss8Cz8iD9nkh91096XezPnkOe/Kvzt/fFd8ltwsv2dz2B/MzNlunUY/QvaUq+xzAdUV9sBQ62inEIXApfe31Mn2ILegAzfI1Gk2ZDi0pZrCuSjkUrHCYz3ANS7QbHC33Fjuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XU0AUQzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cAk0grj/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XU0AUQzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cAk0grj/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86DC125400BB;
	Wed, 28 May 2025 03:14:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 May 2025 03:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748416466; x=1748502866; bh=7FkQCEIupt
	ahE4EXQEvYk4Pwfuj0fWxcCqAKZ7Ctp2A=; b=XU0AUQzZQZ0CUcDgUKhd5N8k4U
	JY1ataC3vRbMrIgNUWG4ny59Gf/2kyDKEgm5104+QjXzWLPNfcxzPwFyaTFp2tMx
	ntwNRcKqZYraOc+gKcYhPTwQK3UoRNSjH1ARSFLXvzDsG+CmR8V9WU9o8p4zrUUg
	F3lJNyZTBch49OANd1y0Iz1OhQlawci/EhCCgjKkxEXPutkbJxyqWUaXdSKPlmpf
	iMnVV+mRTd1eIgm0ut4wZEBQi32rTucJ3CxCj8YwyjTHiGDrh5VDVbJYk33oXFVI
	fw2hNJobFvbrZHur6Xj0sjv2gO/4v5AwQA1x2w855XxJGSYCXBcbKjIobNnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748416466; x=1748502866; bh=7FkQCEIuptahE4EXQEvYk4Pwfuj0fWxcCqA
	KZ7Ctp2A=; b=cAk0grj/Xp3Jsg797YuHcdMlzBkiGBpfiPeGvT2tMC61A9Q79RW
	/l8Jil1OSyIY7nRcDtGOCu50Qbv8eILD9Na/GbdWdcpq+d9zUsBDMwHqe3DmmfQ1
	1TsSWY5FBZqMfnE/WJyS8ESaxk2+/YF4+W1v6odP2AveBA5LcU1gYotO0QV/vVOU
	yySrDtd66ZPPiczPR6c7Y4wI/oA46AayxqcvJEEXVa2NwgtSp3fT/m1wGT88jgAC
	PjX3p1XWg/Ma/W2yA+X9fAQeLsRok5pqGtAwKe5up+omAcJIe9Ww4mXWYExlNsgP
	Hrp1q0SltmH2f+BYs/KYNSaJHVG/KpQSB1w==
X-ME-Sender: <xms:0rc2aE2FK7GCpdG7XTPAr98FA6PFPv_DW4KtnPdOKQ3RtTECu1sAlQ>
    <xme:0rc2aPELPXpewwebAh0HtJmpM4QJkGScARqtSEvpCIxaZstx82XmKfgt9N1LZF5eZ
    SfnJdkZJ8kcjJ1wcw>
X-ME-Received: <xmr:0rc2aM7zRNygoMSSAMEkPdoTRizyl7FzdC7w4NvtufJ-cclC9oyafsuPfDoo7uLfT5Qzl7ybfrgB-pcFLURaZNtGpDit4jYiDYQvQQ96d0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdeifeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhimhiffidtfedtieesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0rc2aN1OMmffjW-h9zSbULVAvE2oghFWgPAjQC2sxTWPjxQu-oVWKQ>
    <xmx:0rc2aHHmRbkeiLHaI8f0Lupoo2h6LdKRRqPCWY1wlPvrUAcAMDOYOw>
    <xmx:0rc2aG9A357ssL95kGzLKHAz0Yunvsezvun2qQEAhZJ6LLHHhe0PrQ>
    <xmx:0rc2aMm641NVGl_rva15DxMELVraLNvOhiebJ6dG5BJJJOnKn_MYZg>
    <xmx:0rc2aOsvBk7CgwrPOQ4R7no3QJzlMVF3Dm0kGuMG_M9h9NgFnK5BbEFM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 03:14:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de360e65 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 07:14:25 +0000 (UTC)
Date: Wed, 28 May 2025 09:14:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: oneee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, oneee <kimww0306@gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
Message-ID: <aDa30OJmvcfp1_mM@pks.im>
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>

On Mon, Apr 21, 2025 at 12:41:40PM +0000, oneee via GitGitGadget wrote:
> From: onee-only <kimww0306@gmail.com>
> 
> Changed the list markers from a mix of "(1)" and "(b)" to a
> consistent numeric format "(1)", "(2)" for clarity and consistency.

In Git we use imperative style for commit messages, as if requesting the
code to change. So something like this for example:

  We use a mix of "(1)" and "(b)" to refer to different cases when
  explaining sparsity patterns. Adapt these markers to use the numeric
  format for both clarity and consistency.

> Signed-off-by: onee-only <kimww0306@gmail.com>

We typically prefer your full name instead of using nicknames here. So
if you want to provide your full name, please do so.

> diff --git a/Documentation/technical/sparse-checkout.adoc b/Documentation/technical/sparse-checkout.adoc
> index dc2e763bbec..8202172b70b 100644
> --- a/Documentation/technical/sparse-checkout.adoc
> +++ b/Documentation/technical/sparse-checkout.adoc
> @@ -66,7 +66,7 @@ sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
>  	reasons: (1) users in cone mode specify directories rather than
>  	patterns (their directories are transformed into patterns, but
>  	users may think you are talking about non-cone mode if you use the
> -	word "patterns"), and (b) the sparse specification might
> +	word "patterns"), and (2) the sparse specification might
>  	transiently differ in the working tree or index from the sparsity
>  	patterns (see "Sparse specification vs. sparsity patterns").

The change itself looks like an obvious improvement to me, thanks!

Patrick
