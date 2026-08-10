Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2F30D3E9
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369397; cv=none; b=eIauArHUUN5FgfRR+OW+B0x0HW2QcaBCZN8gia1DXqu9dmMFZ9Gh7Zd63wfigN8DvSlmQoVXzV6NLP0hONzrciOvPUNAC4nt4dy4dMKmJGty5qFvjvq1Iyvh7BcYdkpu9eJBzgSxvlGBqIgPLUGjMzr3ekZN5oFRgZHvjl3Gi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369397; c=relaxed/simple;
	bh=azIJOcSrihJz2bhNEXgJhcyBx27j4Lb4lAI1VZ+3SWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS52W8b06YQVMbLXLpAWGwG2k+osCDk591rIbdTZwBSeuhEDqWUDHwM+IbLlZhRuN1Phxz+TI2JLpVCE6ywT0qp2NrSNNYSIvcQAuG67Uog5MEYkPhtFuPeuwk+1x4fNoeDcvLeoiNkLNj1GR6eVQzLx2pb6bxU2/C5iY0r1eFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cYKJVzeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jr8ggVTq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cYKJVzeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jr8ggVTq"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5683314000DB;
	Mon, 10 Aug 2026 09:43:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 10 Aug 2026 09:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786369395;
	 x=1786455795; bh=pXt4cAGlGrUI/F7Jjt9rC+IaeihfbpR3taLQFZoUJnQ=; b=
	cYKJVzeHITRiQN8/9lOhJkO4ZEUhqh/6xVSz3iRIXPnC8rVttyT1pj4lri3DDYMJ
	ff3h+79d4hv/5cJ8nUnCDWnTxCwIs7iZpA0/xyYzvB9lNc4yTb5zMcOiK/vzyNcB
	0ias8uongpE9nDk4oOXYwEIFo0o+DR7TXaFSGgmP+HvAM9MbFlAZnUAAA15knH9f
	1R9FjqC+mPhtK6XvNPoT/Gqh6ZaAGR9PnsDknyHidWXytfic4hyo1aWu0HNY3Mc6
	wMzgOztyr9rVXlLBNgyslzi32RERZzI5CEdrxEdwIMN9gsUhLujAJDOyq9d4XEuE
	RnoxHqLVxnQxOO53pYftCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786369395; x=
	1786455795; bh=pXt4cAGlGrUI/F7Jjt9rC+IaeihfbpR3taLQFZoUJnQ=; b=j
	r8ggVTqiPSzOWaQEoQAIRrlA68fpOAwDtmq5mqwIg9aZkVZUGL/UsS9hpa+Aj03v
	2s3lL0GFxIkue587PQuayrDEdRpj+IvDNick9ivJ414F3wmcOLV8qh5vB/yqLCQE
	oC+FotDOVjPQsxk+TwpvaTmNPMxjR1PGpdTUckQhzkUljEegJb4Ee6SUaT1IgDFV
	hQ2/709dyA6H/U7iqVy8LtxIPko52dget4tLucQqigJVm6FFXwzc3CHuxSX6WRAW
	3NWeZo/IeYBkt+ax5U6eyFmYb2aBDCVURncFHG+XoZBdRpbTNDiqOudFIQsdp28y
	Pdk7+F15vMES6cFLmjoxg==
X-ME-Sender: <xms:ctV5anGJ2BOhon6LExAfwhedrrf3fBJ67D-aF681kJe5skrd5X6M2g>
    <xme:ctV5aqWqbYmtUmBRdCWouXQFUiN5bZB3hXEAVVyZIJT6u-JcmyULTqWpgQlOwSadU
    GEY5wWqptg2pGjKHnB08mA6I-V2Pn57qDoYYAfwXzl0rVoPJ-f1cA>
X-ME-Received: <xmr:ctV5amzcZqUqVhiPzEpCsfJZrmtOAhe5cSYpN82A24UXI4Ndp1s818VtgRf19mIagYJS_x_xy-Iub8zZNTmY4JMw4gtRISnfYMgE6LZNGQ>
X-ME-Proxy-Cause: dmFkZTFSze+Kzirl9Xjy6H4v/Mbqa56JAf+24R7eepGKDQ1iO2eD5krQUcYTRpCUEqnzEw
    Pt7RmrTC1EvxDWXo/4KXXGRg+MD5G0XfP/Tt8gfb0ZRRkNv+ynCC7cIeHd99L3hiSbPa9E
    XIH+GRs2fPYRl6NK8cLsHqk1TSvXwx4N1rJ4ETsh8w00v05tAiqGFw67dqFppu+hzUFdCd
    SU/s8PYOwIubw6FCgoofhqBWe4NMfn0HWS/XbvIXgUpAcFMc/xL34ff1gLAX0W3hpmrnyi
    pMLHttykfMo1/tXFfGCeFbLNcZRJHp7ajxKCohnMgc8V1Gdtb8QDEy3gorxhMadEI+unDQ
    ntAceu4qgE58OzGwvQefshb4EAywX9YYqDR6nnclBNkywmRXAVaqISrvkNOR/Ntx8u8rZe
    nh0id3gDI9btqxhM7SZvRovvYgcK3yQK5MLCBNvh/CsfNOWFhzCziAnCV8O1sIK70dkUkQ
    gEnEBh7GIgcfK4CYzXU3tLByGj9pL4WvHlisdGMV72OABHCZ5iap0/5dGEmvIeAZQReFp+
    iMOFQl32H8auo5VRe8qVl41vZvQVhiBh3pfSXOldZO1XAj/oiHUl6hatU/reH6IGHtO7Hc
    E+mo+1rgGQwqon6zkOToSMMPx5BnfWsTKOXpynTpqP9nNFyD7igyXxwPtXJg
X-ME-Proxy: <xmx:ctV5agMrP9p-l2_l0S09IzeRFQorbf7fLxnxr_ebViFk5WVW0DKElA>
    <xmx:ctV5av5_FNi5CuVjCTGsBNMfzS20Aeu7-THDyCBfYB7j9Kp1HabWRw>
    <xmx:ctV5apOeeEuwrJ5oG5JgtBFOtJIprvZhBUOuLgKNxBKIJ3J1en3Ayw>
    <xmx:ctV5allJ7AWOLPNa4n1bjv5zhK9MlPQiY8rt8IoGlDTlh-BaYOmSDQ>
    <xmx:c9V5akqfkIcYTPzJUvPIx0K-D6UZDycTxGjQ8eW1rkUxK3FBhSqu56Wj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 09:43:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3e41bf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 13:43:12 +0000 (UTC)
Date: Mon, 10 Aug 2026 15:43:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "commit graph is likely corrupt" on git rebase
Message-ID: <annVbVIKtPZJ7xG7@pks.im>
References: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com>

Hi Florian.

On Fri, Jul 31, 2026 at 10:05:20AM +0100, Florian Schmidt wrote:
> Hiya,
> 
> Hitting an issue during git rebase. I am starting to suspect git is possibly
> getting confused between main and submodule repos. I noticed this with a
> self-compiled git 2.54, but I compiled git v2.55 just now, and seem to hit
> the same issue still. Full bisect at the end of the message.

Did you by any chance also test the "master" branch? There's been some
fixes to the commit graph that weren't released as part of Git 2.55 yet,
so chance are those could fix the issue for you.

> The first-order issue, trying to rebase a work/foo branch which is tracking
> origin/master.  There's only one commit difference, a commit that changes
> two submodule pointers:

Do you by any chance have a minimal reproducer? That'd help us
tremendously to reproduce and then fix the issue if it wasn't already
fixed on "master".

Thanks!

Patrick
