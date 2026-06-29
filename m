Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFA389107
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714419; cv=none; b=iWgdGc0pUlg9BDOkDMzzB38TjqPWo49wreq55Z9OglFdzFdB+jPKBGdB+1BsxESsrODb6sePxX+EOoheM/UdRqlKvzKGB1c4ryAz/TpmhE4HWzsYpXILExpNMOooS5OBNhG0qdjTlwNS35AehWGMhzk3tNl4WRtWHcTCQ6RZDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714419; c=relaxed/simple;
	bh=ryaQ0w1PJMvw8A/r3mvHQus2/Xsy8+jKFJ2vOFeDWHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEieeZXdYtjsVWB2CIc3amjF58u/hpN8ZTMSac4sK7Wo2/BvveVvYeekxgDEDcy3PRjkJT7SPsmQItgFo6l5lUUuPev3BZYqrqh7YF4RnMkYiIh8/w2Uc3PQPcATH4jiwBrfNab9k3+pWfdeXnLZn5ObnK+TH4s4P/6z0svnbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oaXC5Xsp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LcY0bIzZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oaXC5Xsp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LcY0bIzZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EE3C81D0007F;
	Mon, 29 Jun 2026 02:26:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 02:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782714417; x=1782800817; bh=XImu3OrGx9
	RgPhwuHmUYdor+DwYy9bYVQa3GhzlGbxg=; b=oaXC5XspLNwRfOJh2s07xuuI2t
	baDn8OPuYFOTdS9jC7319XRkPprMiVZAhwrmxq62E5vdB0koOqA73GFUlX3x+xnx
	UngZoLbgHTdIBVrGJR3NjfLAmIAlAC/jXn1rLxHMEnlPqukAGUJYSJgW8VLvWI6K
	vBtzrLGusW90OdwTpTbf0OgF3fPQRT+f/A3TW5Kg6GNmU/JTg3lR78Roy+cTstUQ
	Htf/2vfQx2hViHbt4gnlfSFxqoPdwKcYT0dM2qMVuptFMWYPfwtBiuGUFg8pbuIO
	77vwvVUOQv/fSYf47/p4gamDiwmmeGPzkTG+sD85paoTKv7ukLTb06mcBxFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782714417; x=1782800817; bh=XImu3OrGx9RgPhwuHmUYdor+DwYy9bYVQa3
	GhzlGbxg=; b=LcY0bIzZLkgKtWs3RTfzFDNLe06eqkODiPG6DlEt9JmimH6OgNJ
	F5URSCOssV9H7SXI7nIU4P08hcdHlYyCIYMOi6A+RCx6JKGLGAsf5r1dfW9jNaKV
	BZ1OgB+qoaX8lveZl0HQ4YUYBqQV9x7ynKwhEPVRr9I9k3EE1xkUGM/D0XvlvM/L
	/pK5BZfEc1pAVr4Y/+7whqDkfo15AUOdTYqo6u/htN2MMmjXHRPXhGq13diimh5o
	mO/r5L7RJtzCrnsHYsjCSgtC3q7jyrHDoFYmHwh1Y7Mbv1NxmQNY3pqgSPJ3aOkp
	EV6LE68RNCnwgtfCak7ox8QKbkT6mZ1tQQw==
X-ME-Sender: <xms:MRBCajqiZ2XmcJcg5__L8lU37GZohcCk-MLosv0khmkUbPGU4IOItA>
    <xme:MRBCarc8ePvVPpFCqPtwzvyMWoXwTVgW2x3vryZg2fPPOfpLX12b4xPVuxNMEeA2s
    AazD99JVUJjEKFL4kE7elo1dC61sxan6RtBXttaxaDj-m9vArI_qw>
X-ME-Received: <xmr:MRBCaqp5s3AnzSTvEIKTobSvgezetXPDexaJoDOzlpg4oik9xQjSch6E9Mf-FU2veX64QEHzOlhA1lA71shINw6wMBpR0HqpCkk8rEciPuGO>
X-ME-Proxy-Cause: dmFkZTGfczjwMc6N5xHRq44FYRnWuKBaASWRnRN7WPhTVkdvNpbBZVvCZ5JaiKvf4NlMnR
    7eeK7uWLvEdchXEUhfp5da+rzBsnuDZg2x8Jl4QsQvtjIUm6YE+vvV5BlavS0PFJ3+NeET
    Z57RyIulBOdIz9FIcnN3StdRP9067tYn2Fyh7Z1Lc42REI/n7GzZMtuhMhrg95t9UKxAoZ
    dxBur0y4tBM7CFoptGWyz1FrlbmhNduWTHui5A8j0LnsjsLEgjKyXHI9DedAjOLcNl8l95
    0f0kjUyUkBy17pNVlUVxry73SA36hao1Ew154wTdqipq3J5Q7cOXAfB0qAYyttAP2QYbIZ
    5VvKKWMiaY1VkMTKYGatOLvMDr/a3b1HMMbqZSetdiJguH1rLntr5ipt/afJVYGj3CbUc0
    i1dTsI+oShfdOXvan7zH9b1xZ3Khny48szztikfepVojv+p4Wpd/RkCO6zbXTxFdfkzp8K
    0IvoHKdrpYtRYFhgeVYU3J18UyHLP5P7ROrKeYNsCM0pxMHyoYjYKt2oCy67aqa5iHFaMa
    GeenDH9wJ0JWxJvx9FdzyI8uOZeZy5PSesgpuswkUW6WOoMdSlXzZeHCyBJtePgfM3AutA
    1jbjep+iNzJAYKtTXbrsRitfK+AO8sVQNnO0otUVBbUDRx7tU+4Y/n0GSNxQ
X-ME-Proxy: <xmx:MRBCakHXBx-hLJ-W6ajkCEVfGMCMSkfgt83kBTCsC1hyasDG-hsyvg>
    <xmx:MRBCaisgkpdBkawLAd4sHmW7WuUyQ-u9UxSyPHL9HmvCh_eJUSR5Kw>
    <xmx:MRBCauU6795gsVB4sOwNDNQl1qNZslk-CQ8pIBR1CDb0SCpggBS7Xg>
    <xmx:MRBCamFk9F6cbst32koOYh2cbCNEnEC5Kn9Wmdp8kY0ZwQybn4WO9g>
    <xmx:MRBCaoWfbWmVa5wEBXeBxV6Q3CcyFryAOxLq1ElSUC8V6XvO-0eHOUIO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:26:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 393212be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 06:26:55 +0000 (UTC)
Date: Mon, 29 Jun 2026 08:26:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
Message-ID: <akIQLM6xZTHBudWT@pks.im>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>

On Fri, Jun 26, 2026 at 09:52:57AM +0100, Phillip Wood wrote:
> Hi Harald
> 
> On 24/06/2026 22:54, Harald Nordgren via GitGitGadget wrote:
> > Adds git history squash <revision-range> to fold a range of commits.
> 
> It would be helpful to give a bit more detail here about the command so that
> the reader has an overview of what is actually being implemented.
> 
>  - what does it do with fixup!, squash! and amend! commits? Can it use
>    the message from amend! commits to reword the commit?
>  - can the user reword the commit message?

Good things to document/discuss.

>  - what happens if a merge commit inside the range has a parent outside
>    the range?

Yeah, I agree that we should punt on merge commits for now. They are a
can of worms, and I'm not sure that we should just squash them. I would
at least like the user to ask a flag that tells us that it's fine
squashing those.

>  - what happens to branches that point to commits inside the range?

Yeah, this should be documented indeed.

> I had a quick play and found that it accepts ranges that containing a single
> commit (e.g. @^!) where there is nothing to squash. It also accepts ranges
> that are not ancestors of HEAD (e.g. checkout master and run "git history
> squash --dry-run origin/seen^2^!") without printing an error message. Only
> accepting a single argument is quite limiting as one cannot say
> 
> 	git history squash ^:/base :/tip

Note that it is intentional that you can rewrite branches that are not
currently checked out, and the other subcommands work the same. So I'd
argue this should also be the case for "squash".

Patrick
