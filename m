Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DE1E485
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121005; cv=none; b=eFoc12x4CIh1rypA9Ry/soF96rndJ67fr8hocLF6aFVI9XEb6RH3CTQ7k8NoJuKCstthVkhHlryzqwL8/+KMjhPRe8OBG5xq1rrVwhtkOHP2JKO6vyhXswZfPWkEgJXGhm+rpNw3viMi13qs1ky5d7z9h/DOnEegU2QaBu7SckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121005; c=relaxed/simple;
	bh=OIr4/kZTV383lFDdpx41XqLQupR6Rj/L0J+UuQDC5kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGJ4xLdXchsQr6gmyKTySueg8XWW9UhdhoIC0Jk20nb8/Vaea6NkZu20UgdrQFXW1fmLm351GUMwuHoSL1q8WKqDAkT+Ka2TKP6HHFIsB0KvOlRaIXPQA7RSZTm97CIheO9qJlzQW8H5P+P4wxA7zYLf0Gyu48EGDX7kvCAu86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t+tNfSDy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AdlFQEwU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t+tNfSDy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AdlFQEwU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAAAE11400EC;
	Fri, 17 Jan 2025 08:36:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 17 Jan 2025 08:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737121001; x=1737207401; bh=k6EYSh3iS5
	+Dn6KrvpRzjEEqtMsENjOIf1LcIuek1Ds=; b=t+tNfSDyS0u+1arD6M7eydbRxc
	nmmqJr5+7RRncG/mi17skMu33iFZC2NhBIVhv51cKIQ9j6ZJ38l+ASkXD645+sNb
	xEhePwFc0oRVBWUut+IS8i6wu+E2gA+WeBjQ8g2L1fQThYCE3k0BvfXjYBEquszu
	VWxDMMOIR9EHXwr48zvUbEBsuDQ8Q5wDbwKRB9Wxo2HaTekN0KsBksQgNT7AwA1y
	PUzKYVyXypz5OtkMuYr9zTEW2+NLCs/rcZ2Yi3u4klLTBCx/aO/IfkTi2IhSNoQY
	eFxjzL6uIfJwF0KnLweMso0KUMVmbPy+Q4gjJetfLzput/+doZV44hmXB3eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737121001; x=1737207401; bh=k6EYSh3iS5+Dn6KrvpRzjEEqtMsENjOIf1L
	cIuek1Ds=; b=AdlFQEwUN4jzz9Cff6IgcnrVYb9kHcVtxv2qHJVh/QQ0T2oDXqW
	fig23iyEZMTL7uhwsGyT6Gm+fjoRhBjdLJ/THK8l3As2fKb+9IjDdD/nH4zeEoqA
	vX2IWbE4X+eTTR97kTlN0kLye63WzCw2vlcg+rG96w1mHzt2S5jgfOLUfojCqGGJ
	niGi1JpLom4ARGww9JiSpx70s3DzFc6idfT+ydWanG6QpdXEkQ//NneTZgO4yD66
	phkg5cWaI/KvGx+gWHFuSn3i/nt8RAfmYY8SSsgdya+uC7/a7EQBND3FrSrZ2Krj
	skhVmtSaY86pmeCMVNJotio508HVG3+vvjA==
X-ME-Sender: <xms:6FyKZ3wi9L_8ujYiD7_yfMbJ8UM1wkauSVRFErXmqVbsJLmhWFIGvA>
    <xme:6FyKZ_QyNKw-aiSmf8nEGiFQB5NwP1aLQmi2OZFWijlyc0i7YNsWAZxMaE1h-PAIE
    iTISLRx4_WsxLw68A>
X-ME-Received: <xmr:6FyKZxVCUcBJBA2nqfSt7mBK0Rp73Ws5zr-iO4j_gPsdIa_zhoFBFKCJULWaZUunI0OLIpW_0qZVO-IeefOzenosPqU5VaH1kPy-iIyhdHP3m8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6FyKZxhtN0pEb0ti_vIHRm0RE66rOJDJkNSLIK9gCXFGNjoW6iG1ag>
    <xmx:6FyKZ5DHAASBdNNh_FS0xojIjSnu0LWP4vOD5WixZCBu5VNkqktbYQ>
    <xmx:6FyKZ6L0RsH9aumpIebjavlUMNK8CA5YHmtLWGC_WoOUWQ69LSDNwQ>
    <xmx:6FyKZ4BG9X6ZahbkIXIEPEbU1kCedbfbwuEmyjxs2CRlkNq3KnFP9A>
    <xmx:6VyKZ08l2bnXI792eoYW9_RHi9KNSDYi30kF2K3dMRwIqZu83OoUoxya>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 08:36:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a95d1cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 13:36:37 +0000 (UTC)
Date: Fri, 17 Jan 2025 14:36:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: t/unit-tests: convert unit-tests to use clar
Message-ID: <Z4pc5ItVQwTJNd--@pks.im>
References: <20250116161559.91038-1-kuforiji98@gmail.com>
 <20250117122926.101749-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117122926.101749-1-kuforiji98@gmail.com>

On Fri, Jan 17, 2025 at 01:29:22PM +0100, Seyi Kuforiji wrote:
> Hello,
> 
> This small patch series transitions the existing unit test files to the
> Clar testing framework. This change is part of our ongoing effort to
> standardize our testing approach and enhance maintainability.
> 
> changes in v3:
> - Some small fixes were made to the commit messages

Thanks, the series looks good to me now.

> Range-diff against v2:
> 1:  00bb4d2880 ! 1:  f9e163a181 t/unit-tests: handle dashes in test suite filenames
>     @@ Metadata
>       ## Commit message ##
>          t/unit-tests: handle dashes in test suite filenames
>      
>     -    The script is designed to extract function signatures that match a
>     -    specific pattern derived from the unit test file's name.
>     -    `generate-clar-decls.sh` does not pick up dashes in filenames, which
>     -    prevents the scripts from being run.
>     +    "generate-clar-decls.sh" script is designed to extract function
>     +    signatures that match a specific pattern derived from the unit test
>     +    file's name. The script does not know to massage file names with dashes,
>     +    which will make it search for functions that look like, for example,
>     +    `test_mem-pool_*`. Having dashes in function names is not allowed
>     +    though, so these patterns won't ever match a legal function name.
>      
>          Adapt script to translate dashes (`-`) in test suite filenames to
>          underscores (`_`) to correctly extract the function signatures and run
> -:  ---------- > 2:  f46438f53e t/unit-tests: convert mem-pool test to use clar test framework
> -:  ---------- > 3:  f5cabebd3a t/unit-tests: adapt priority queue test to use clar test framework
> -:  ---------- > 4:  5323873612 t/unit-tests: convert reftable tree test to use clar test framework

The range-diff is still not correct :P Now it seems like you only passed
the first commit of your v2 to it, instead of the tip of the v2 branch.

Patrick
