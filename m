Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8E17A300
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518283; cv=none; b=fpNnA4RSzM0AGnwOZwXdymC6RwOx6N2FtKYbCvDqMgYD5Of9GEHCuFFqGEc4P9wfMfqVIuuzs1XNTNcbzmU/z6DPXzNIpSD36lB3bdpbYEEjyFLm4fKqQK/dnxFBDqfpopNiTirZsXlM5ivsd4m20S0ynRe843bNefFxLJM8Rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518283; c=relaxed/simple;
	bh=RCN4dWgwVGL6I0SdQynrGyi7nDpRXWJ4PZl/q1Uann8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/9oieuifaui+YfW0xpwmSRueSbRu17FOjHjGRpGXrNsUiMg/ZTF9ghghpT9QJ8rng9EKc27Aevm6mPq2VXV5+LmUoSyoJ4/KuSYH0Di1Cty2yqCeGY3/Z4g1bQGEHZFNNMCy5hALBv72t80PSZeoL2PKfstAB5a+s3LGRUGCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F5PNRz+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rRPwnbFl; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F5PNRz+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rRPwnbFl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B60B71D002B7;
	Tue,  3 Mar 2026 01:11:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Mar 2026 01:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772518280;
	 x=1772604680; bh=L9l9uiLQF1KNZ4NF71KabnBABq+dCa3mKHgk111sc3Y=; b=
	F5PNRz+tNVM6if0YTmYTvBbLal4BFrNlMCskPiQCRwOLRj3nfF6gR8WJoyrujbuR
	Dc8Gi8ReFGZoG95fpFH5ZJZZrjTnMPPUsMtZqf8k+4VjBKQLx1MmNlIczGRQarFC
	qHCY4nGT4uVRvUP8illHE2Y/lJBuTD9cNczbReCP5+HUGRA+dFwsPHTwk8SYYsB/
	oX/YypzXRAjuJ8uFg24MuE4n2nCx45TYANqbduQxisdjmCc4TCp8COErNXIf8jCe
	7LiMhvXhjVKNHvTHogqJoG5h5NNnca3tW6aSapH6Q3t05yKlgb0uRQX80hyAAcS/
	K9uaydeG2pCTC/5hj3KacQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772518280; x=
	1772604680; bh=L9l9uiLQF1KNZ4NF71KabnBABq+dCa3mKHgk111sc3Y=; b=r
	RPwnbFlEUhPA1xS6lEuE61zLm6rBc/LMZkr41LDdStygJK5Soh5sJr7s0q65DnrW
	TgG+rYdHquK+n66XmmhxgkOvjuN11ZDPfQ1mAi63uLgumT5FkVLpYQd6chwkG4V9
	bUOKQ506K6/Kn/oKZA5ZpMDZ0SGR/voZOCFG6muhomQabLclr5u+HFXrIskrCOmz
	T4cYkbhz5kDOgBN/zohWxdt2tSDo2zL3cr0PQoG+80dA5qXOtR/7dkbEigXwIG1z
	V9PCV7/9cIKHr/AO830IJKp4KZPMTkLLEjfgpcMGTmCt1rLIMJfcI/ufqXxYihDp
	ioNUGDRyjw6aaAVtwCQlA==
X-ME-Sender: <xms:iHumaQohYH2TWCmqIvCrkzyba9sytTOo11puKhmVn0ra7-qpWkBWXQ>
    <xme:iHumadjzAfy32vpjYXriAGWo-6MRmeqF7H7lgliJp7Wfj9T7LUpvPDV552kmjtS5w
    ECOq6MEUmxexJ9DPWL6wdK4dMgW5eGiaYFoa9pX93FeGugqP_eYcg>
X-ME-Received: <xmr:iHumadh1G8yIpArfqbOiHaQdJN-VthwCXyaavLvoOshlfI8Wjmnr0JXmzl_RmfiJlDUMDdZ4xMtEKauNcDLZgNj1lfVUHu7doDKeL1PnRWQx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:iHumaThnUgxC9BK41bppbz3ObDSMCsuy9qDDz_QLHFnslVI8MOdlaQ>
    <xmx:iHumadL_hzSJ0kqxXTWqVJMootp0JrpiwihaKsg-AhC5gesvTZXkuQ>
    <xmx:iHumaSHyUoP7gEQM7zRqdxexit6q0a25WQzjzIqf7vv4-0K6sgCweg>
    <xmx:iHumaRQGgJrcciNw98y1arZ0mCyRbX2HJI3M1Ev6TpsaLyP8J2uNzA>
    <xmx:iHumaTfvnWrkB__2CYCJRe8cDM2nd-8zq7kxNk5kir-AZINxc1q21SBJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 01:11:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd8c4036 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 06:11:17 +0000 (UTC)
Date: Tue, 3 Mar 2026 07:11:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] builtin/receive-pack: avoid spinning no-op sideband
 async threads
Message-ID: <aaZ7eXtUSWSS_igX@pks.im>
References: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
 <20260302191704.1814567-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302191704.1814567-2-adrian.ratiu@collabora.com>

On Mon, Mar 02, 2026 at 09:17:04PM +0200, Adrian Ratiu wrote:
> Exit early if the hooks do not exist, to avoid spinning up/down
> sideband async threads which no-op.
> 
> It is important to call the hook_exists() API provided by hook.[ch]
> because it covers both config-defined hooks and the "traditional"
> hooks from the hookdir. find_hook() only covers the hookdir hooks.

Just out of curiosity: will `find_hook()` eventually be removed? I saw
that we still use it for the "proc-receive" hook in git-receive-pack(1)
for example, which feels a bit fishy to me.

In any case, if this is an oversight then this can be handled in a
subsequent patch series, if you ask me.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 139a227e71..6376c191c7 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -934,6 +934,9 @@ static int run_receive_hook(struct command *commands,
>  	int saved_stderr = -1;
>  	int ret;
>  
> +	if (!hook_exists(the_repository, hook_name))
> +		return 0;
> +
>  	/* if there are no valid commands, don't invoke the hook at all. */
>  	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
>  		iter = iter->next;

That fix is delightfully simple -- I was fearing for a deeper issue. I
can confirm that this restores original performance:

  Benchmark 1: receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9~)
    Time (mean ± σ):     177.4 ms ±   3.0 ms    [User: 92.0 ms, System: 84.2 ms]
    Range (min … max):   172.1 ms … 182.6 ms    15 runs

  Benchmark 2: receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9)
    Time (mean ± σ):     485.0 ms ±   7.1 ms    [User: 180.0 ms, System: 375.0 ms]
    Range (min … max):   466.9 ms … 491.0 ms    10 runs

  Benchmark 3: receive: many refs (refformat = reftable, refcount = 10000, revision = 005f3fbe07a20dd5f7dea57f6f46cd797387e56a)
    Time (mean ± σ):     178.1 ms ±   2.4 ms    [User: 91.8 ms, System: 85.1 ms]
    Range (min … max):   172.2 ms … 181.3 ms    15 runs

  Summary
    receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9~) ran
      1.00 ± 0.02 times faster than receive: many refs (refformat = reftable, refcount = 10000, revision = 005f3fbe07a20dd5f7dea57f6f46cd797387e56a)
      2.73 ± 0.06 times faster than receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9)

And Bencher has already picked up those changes, too, and graphs have
dropped back to previous levels. Awesome.

Thanks a lot for the quick turnaround!

Patrick
