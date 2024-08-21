Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E51885A7
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223630; cv=none; b=q0T1rXOMRUKB8Xwpzby12FYoINkXLQqUb67G2IIfGE8kYF88sKpmGjWDol9+sNwCrVdIqFKLzf8EI8FpiwyzW7v7kx2cxs6m2UhrlxypLeDiLeHZFvuI1/zNNW9mxUgjlpQ0cxJWphYz6s+5F3jEn9bVAlZ7Kv+uXdFZ9iAkkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223630; c=relaxed/simple;
	bh=AYSAlhc2lYTDX0nBsLanTbCtm8qXA9ZO/PpL4jTDNnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZfeWJx5og4npIw0OgGNl+XQXNpFRc9P4vSDmfhsa89iLVRAauhOo9pUrzuqwV0zMsqwNT5W/ccnEW7U4E7QTeOHboFDW6qe+YmOdztcpXd59ahq3o/riPGoud30GBU53iA8kgnO3GKUXAbpNouhVRVQ/32CO1hCP3c+JVoNyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gnie3Kez; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3MSfLef; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gnie3Kez";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3MSfLef"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B88141151C10;
	Wed, 21 Aug 2024 03:00:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Aug 2024 03:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724223627; x=1724310027; bh=J4vYvoqbOr
	S9xAp+BJfyBJY9sYDq8cBJ172Nzm34Ryc=; b=gnie3KezrOnSC9W2TOhDkOJAEf
	l7cVCKI3R5tP+vuurYE5a3ij2GHgvAgEgS43d41r91XW55RGcKEZvobCqhiLCrKs
	fM+0t/GcFe/qBrGSZNoaZO++oIp3+oeqhcCgA/vUjyq3XQl94m+Zu3165qgckTO6
	4XMb79vgdbGFLAeKrp0HRM+jUvzu5HDV3CMy4kpY+W7eIf1tGpCxZGef7vzGoyrb
	/aP9EmKHsYy8hDnV0zmjkJarn8XxY3eXauSSGRUMzaqkXnGiY4p0fWxAbPVWT8lf
	80POwKQVOpAx9oY5D4qXhGRFRmJKYxZKmSoVJh5P+8Q5hhBl80X0ELtCtwkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724223627; x=1724310027; bh=J4vYvoqbOrS9xAp+BJfyBJY9sYDq
	8cBJ172Nzm34Ryc=; b=A3MSfLefR2lsWHWxpHARuW7p7ydBRcP1qKFJVrz0KNk8
	yR038rS5uCei3zRtgD84tc0KjX0ibfxeOlSrVkONdiAolwyw991dJdzNwO6L6UAR
	7Y1jkHFnyHZdkz5F5dFAK/l2iW2j0uZ5QIfVrg/vS3rhHLl3vbSQNEIx/PwHaXmp
	uEG887Ji3OVbxtvFbm+8oFp26g0yuVLuWRf9JWj9U237aAZ717e3IoWJ/XfoqOYK
	WCW0a/aByPMb47ZnkZ9dwo9e8/XycQJ/ch6NEhHHYrYT345cQJDxlazHrvUM9pEZ
	wyfOHtjbadgEWFKSKCl8OOp/2C8Nt9j5Vk+l+5ATow==
X-ME-Sender: <xms:i5DFZm4X74LSFw9E_EM4oCLOJQsR8Rb8Aqon2VNo5ktLMf01cHCkcw>
    <xme:i5DFZv7pN9SH3Q64-LLi_GF9-fH5vc_t57vZXniAGIHcDbJ83cKoOR84CVYlh6pv5
    lysNwidd3kVfzvyJw>
X-ME-Received: <xmr:i5DFZlctkYneC6HizvT3XrhvbSJsvQTvpznOpQLF-2DOGCfOGj5zjXzer1-vQao2InaM3l8ApcAI8KXD5QFqw9sYWQ5sUmgXXMX7jau_-7oTmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddujedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    gvmhgvugdrrghkvghfrddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i5DFZjLko4ShNrE60RhZp9mLXN5oHDFL2Ss2bxrz_Zvdc4-uwhOSEg>
    <xmx:i5DFZqLZKK9vzUNw9KxUQ3cuQ62VvX-R_rfEDagKaho0AMQgejHBew>
    <xmx:i5DFZkzSKuYNG8H4VdrbtncvCAM_0M3CyAIBDSm-My7wFO8s-vlWYQ>
    <xmx:i5DFZuJj2bEUIU8b48kGSXyLrp59X-uVPE9PnyISZ-hepMre5Gjjng>
    <xmx:i5DFZm21xsKms5UKGYEiR2fy2xTIPHoMTvPwPdvhnPr9BflN84Dp2oH1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 03:00:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ecd1df6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Aug 2024 06:59:53 +0000 (UTC)
Date: Wed, 21 Aug 2024 09:00:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: ahmed akef via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ahmed akef <aemed.akef.1@gmail.com>
Subject: Re: [PATCH] docs: explain the order of output in cat-file batch
 operations
Message-ID: <ZsWQgYclF4ahQPrQ@tanuki>
References: <pull.1761.git.git.1724070410906.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1761.git.git.1724070410906.gitgitgadget@gmail.com>

On Mon, Aug 19, 2024 at 12:26:50PM +0000, ahmed akef via GitGitGadget wrote:
> From: ahmed akef <aemed.akef.1@gmail.com>
> 
> the order of the output is not described explicitly so someone can make
> complex code to parse it instead of just depending on the order

We aim to write full sentences in commit messages. That is, they start
with an upper-case letter and should end with some form of punctuation.
It's also not immediately clear what "the output" refers to without
referring to the subject. And last but not least, it could use some
explanation that this all refers to the `--batch` mode, only.

I would have probably written something like this:

  The batched mode of git-cat-file(1) reads multiple objects from stdin
  and prints their respective contents to stdout. The order in which
  those objects are printed is not documented and may not be immediately
  obvious to the user. Document it.

This explains the context, proceeds to the problem and then says how we
address the problem.

> Signed-off-by: ahmed akef <aemed.akef.1@gmail.com>
> ---
>     explain the order of output in cat-file batch operations since it is not
>     explicit
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1761%2Fahmedakef%2Fexplain-the-order-of-output-in-cat-file-batch-operations-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1761/ahmedakef/explain-the-order-of-output-in-cat-file-batch-operations-v1
> Pull-Request: https://github.com/git/git/pull/1761
> 
>  Documentation/git-cat-file.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index bd95a6c10a7..f1e0b4a7219 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -270,8 +270,8 @@ BATCH OUTPUT
>  ------------
>  
>  If `--batch` or `--batch-check` is given, `cat-file` will read objects
> -from stdin, one per line, and print information about them. By default,
> -the whole line is considered as an object, as if it were fed to
> +from stdin, one per line, and print information about them sequentially in the same order.
> +By default, the whole line is considered as an object, as if it were fed to

These lines are now overly long. We should likely wrap them at 72
characters.

I'd likely also replace "sequentially in the same order" with "in the
same order as they have been read from stdin", which feels a bit more
explicit to me.

Thanks!

Patrick
