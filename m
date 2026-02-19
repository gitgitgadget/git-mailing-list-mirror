Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E2344030
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514866; cv=none; b=aToLDDO7WRkYx5123yHeXDFHzP9IMBFpwDOK4ZEfufp+1Ymf7h5cF+/WzoAImyk02va7FMuKKb1CH8xVnMUNrc7EIPCDG7XvXY5rfkaIGY1NiR5YD0/frqFt+1q1JR8cHkNrQdRGsWo1rrA7xr8BQb/lpRI+syjpSVGJuI2acpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514866; c=relaxed/simple;
	bh=EbgpsTUpAJ/xDogZNZmtukktaOke855u7zgCU851A7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYRVukF2Abb9e87ZgnBvBLRWFN7p99znbVaGAT4mHdjQEOqsaJqD7WZbThXmIVQ1dlDMWSJ1qSkBGVE9UBHxyXL+lEeBle6F+LpsqO5VSrazIyXfPSofYJxng97xrXohkimVfC5SAn98zQFoSKKYiVe4YePG5PauVRaPXlYnH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IAgzUIcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hn0hs+Tk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IAgzUIcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hn0hs+Tk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D469614001CC;
	Thu, 19 Feb 2026 10:27:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 19 Feb 2026 10:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771514864; x=1771601264; bh=qMlCIPJ87w
	HfJ2FrW3rLVuINEFBmRPdB9mRXmBv85JQ=; b=IAgzUIcdSi2+j3FZOB1cWbSJvg
	hJOAh+mrGCPprfxS2LjRubJrihlCEG3mtMCNvS+ITkZkHsCDPOTSM/E/a0OqBdIo
	z0Z0law6fHQ8TWCOL2m6Zp+d171NygLHMr7fS2oggG9TrAsHN+BvUBhoMsUOtnps
	MjAiDHlDvPyRR+5gjkTSwg1hYLLCl1RduHQvRymJoFVGjm5O9rLTLu8H6pXOKqSR
	Dxk8OFd867tv67hW/IGa/tRwhdFjm+tqlEdmIiJ/mp0BTHxzdQTGGJQHiOm3jBsT
	hW2qGx2H6C2D8p0I6XyRgmFHr1NA6VtaKHgsih+mLSrAF8Otv5lLpLfajQEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771514864; x=1771601264; bh=qMlCIPJ87wHfJ2FrW3rLVuINEFBmRPdB9mR
	XmBv85JQ=; b=hn0hs+Tktm5fmyDKaoAzxBqSbsxk3r3FMTk8yVCritEs0I4WxR/
	dH6eg/Ogv1fkFR/v5alwNpriAOw68mrSk6JtnWiR9JODBj57lzoM63lVnO5uNCwd
	tHDWfCthB7NSEirIU+R2HOYcOA4C9zef+DZ65QM5Jo8ki8cR/mKoekwZ3I5bKRoD
	8fAohqZjgCDxCj/VqMQRDvIHdYnOlycAyAh6S9Eq86nzHKj4UWcZlk9jJ1vNFrd8
	fiZwTLg+NxMGbC2cyWPvfNNNWIcR/e57iYSnNjKXMe5deZxNtgf5XOK+E1U+RzBJ
	5+63OfpxCDNWecXma6zIzEbszLUehyMah2A==
X-ME-Sender: <xms:8CuXacDP55tkNSVCCijiji0ewbC6Ua1izbhKIAAnH2lRVCDjyWaj8A>
    <xme:8CuXaV_sK10FTxEluJ4IOQgyBnMcyFewc7-Vt6UGZlTX5oaFWqfCLvVfS3f6l-fVo
    yjUINOmYP-Is687J1rbJTf_v7hESPuw5nG_zsp0gQlE9qwwccJw>
X-ME-Received: <xmr:8CuXac8GI6CGIW4sAbsADhtHEhXk_GUOO58Ig0nq_bZaMbtobHNTWGDgAq6IDE07Aw5uGoVvCOqhnVDCFVH3hNKa4yzCu2uQU4VksgeAqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:8CuXacdjplgv2ZYH5f5nasUmyxzxCjQJ2uGk0Wdis-8g5PnpdjeQeA>
    <xmx:8CuXaVHBUjTdDsi89kDpifxd9fT7bGZdsw2AkK9UAVw8f4ddaiXRRQ>
    <xmx:8CuXaaeWKCAEwHNMi2RvITQ57qWKuNZOjAIEdzqDVrXmBpa3aS2-cg>
    <xmx:8CuXafE4aUrgLqDWvWfGlZFusp8gJYxas_qTfpjz84sXaoDM3-hExw>
    <xmx:8CuXaZYys4I05wCI-NJZ_URh-D6rbE6sL8lGosoX_H1Bq-0MpM1lteQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 10:27:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e385ac7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 15:27:43 +0000 (UTC)
Date: Thu, 19 Feb 2026 16:27:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge-ort: prevent the_repository from coming back
Message-ID: <aZcr7DiIteTS9udR@pks.im>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>

On Wed, Feb 18, 2026 at 09:15:14AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> There are two things preventing us from removing our usage of
> USE_THE_REPOSITORY_VARIABLE: one necessary use of the_repository in
> prefetch_for_content_merges(), and the use of DEFAULT_ABBREV.  We have
> removed all other uses of the_repository in merge-ort before (multiple
> times), but without removing that definition, they keep coming back.

Unfortunate, but I think it's okay to be pragmatic here.

> diff --git a/merge-ort.c b/merge-ort.c
> index 40a11dca73..ae19118550 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -53,6 +53,8 @@
>  #include "unpack-trees.h"
>  #include "xdiff-interface.h"
>  
> +#define the_repository DO_NOT_USE_THE_REPOSITORY

Do we want to have a comment here that explains why we do this dance?

Patrick
