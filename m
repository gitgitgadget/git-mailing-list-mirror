Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9771DF26E
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348113; cv=none; b=ZXyB6KE+UvxooArO6U2/hHNE1rD/bcwAwlsuenaDQH4qVjZLjSJOHIcTP7hhdSbbZSiOnWyL+3rtcdgGiP/BFLzgRuAyrkG/NUE87hiI1YwWgDc7Y1hUrYYGbc8xAwb85phv1MoxMEMMFKs6Rws66YOK/NUhzhibeIr6v0+yL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348113; c=relaxed/simple;
	bh=7H7MCY+bECOY7xoFLqdjyAeEC9dC0U7u8o55Hhkwk40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckQhvTcR14yOI6ZBzT2c5aMJHFurA9FzRsAenbaR73VCfx/8FjjPPdMzANDrJv5WDdA6x++k6+WuOTNqVpfj1oYvOwplrv02b1/5SThSYTxpAzWxgbp0usrToRvOM+HfK5H29UeRHAcL03bUigFN2ShzFhDVYR+MQopQaFiTyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T29WyOfg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lCoh7dLM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T29WyOfg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lCoh7dLM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37AFC7A011F;
	Wed, 10 Dec 2025 01:28:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Dec 2025 01:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765348110; x=1765434510; bh=7z+GJ7Ob66
	sxJEFGbwx5iFSghFppf/MzaCJD1FRZN8Q=; b=T29WyOfggGYxfEQFcJ520fgSqO
	CaVcc1A2kGvTrmxOcuJi6/urYt5/m/CRtqGpVGsPN1wiDwi/4Kxfl9wMeLS9PRzi
	NdGajC0RA2q1AdULjas7RrWoPOZMq7nvPcQCIA5a86sEw6wYf3wGxBoPuu+FDKpF
	khJuhFcXqtH1kZ6uEq0xDJf6HoJA3bWXc0e7CKf8EL4rWhItHVGHHqEngGv49kFr
	KvLjdS40d3zd3XcfWFWiLRpWPoJo0wwDD463lOcJ1guRofE2r7llv9r+Ppwq2b6r
	S/jLvknlYZTQoisaba/pMOWtfo4401ULvfFMwgYLdQgb506UXzpk/nfahw1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765348110; x=1765434510; bh=7z+GJ7Ob66sxJEFGbwx5iFSghFppf/MzaCJ
	D1FRZN8Q=; b=lCoh7dLMtlbHLg5HNJKp24aiLcjk4rAGUSuC30uds6bIVtEoEok
	s325US1Flke3iRimIKIu6/RbM/2pTazddeU/3pFgt5Kd1qsm1GPNU9VrrHGkR+KV
	v97pGRotnRi93rCEbS8B47k9RmmXI5sWWbxdY7IKSzABIUKrm6+ZA0haPlB9nQQ7
	5uYxeWYzLr8/GdBNWHN/nOvg/Vtpo+ZB4v8k0T5CejlpCQeUcK4HqNLtF3u2mYcZ
	KCHtyDtXbPmm8aLmMiAWg5UbR56j/6qNYcDMMxF81WVQp4BY/5mcRSh4lNpmLFML
	c59WTdjf1AlQuRjicurFaa3KEuWHqySb4Pw==
X-ME-Sender: <xms:DhM5aS0lkwv5_IvFell6QnkuQaQBTXz6V3fGSTj2C6Cq83WvxF5mNA>
    <xme:DhM5abHhHEUKqGkXSV9A3FmQc1boGPFnefH0K_30l6ELpEdLKb3msFFC2tOO6WK3A
    Ll2LZh2npElMBvD0n0ALo2xqR4ncZOvvfcrTcGdMw5FAgZgFA-NOA>
X-ME-Received: <xmr:DhM5aYgUhiH3X5azOqczWLWGoJlqwfGkGZk4j92obqZDwcE8ysujg3ovCGrBcxaVOI7Gqmp6MVzJLqRRxWxn2t8RGOCvfUAZxig3ioMqv5sa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DhM5ae82w8HLynaLvbWvIA-ILqD4Rfh-qyPoVyUaOReyXGFM78hGdQ>
    <xmx:DhM5aXqbk7Nd-tFHq-1-AZ6OGZ8hAqM9yvEcKaVCWvIA5m7ABDGorw>
    <xmx:DhM5aV-6mNHhNvrulY8CJMPoR0n-dJNG73vNrcfolfPkx-vnZBQ3ZA>
    <xmx:DhM5aTVnoYLHv_2PU8EAsUNGD_KtlyyaN6kPprJSBAbSWNiYq6qg3w>
    <xmx:DhM5afnqi-RWWU55jiUQnvJW5MTYyAwvrWpzcooKiy3D93dih9EWsb7Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 01:28:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92321d48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 06:28:29 +0000 (UTC)
Date: Wed, 10 Dec 2025 07:28:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
Message-ID: <aTkTCplQuSX_Y3oG@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-6-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209225820.2861276-6-jltobler@gmail.com>

On Tue, Dec 09, 2025 at 04:58:19PM -0600, Justin Tobler wrote:
> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 0ae96e6bbf..a98c651f1d 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -35,6 +35,37 @@ test_expect_success 'empty repository' '
>  		git repo structure >out 2>err &&
>  
>  		test_cmp expect out &&
> +		test_line_count = 0 err &&
> +
> +		cat >expect <<-\EOF &&
> +		references.branches.count=0
> +		references.tags.count=0
> +		references.remotes.count=0
> +		references.others.count=0
> +		objects.commits.count=0
> +		objects.trees.count=0
> +		objects.blobs.count=0
> +		objects.tags.count=0
> +		objects.commits.inflated=0
> +		objects.trees.inflated=0
> +		objects.blobs.inflated=0
> +		objects.tags.inflated=0
> +		objects.commits.disk=0
> +		objects.trees.disk=0
> +		objects.blobs.disk=0
> +		objects.tags.disk=0
> +		EOF

Do we maybe want to adapt the keys to be "inflated_size" and
"disk_size"?

> @@ -106,16 +137,12 @@ test_expect_success SHA1 'keyvalue and nul format' '
>  		objects.tags.inflated=132
>  		EOF
>  
> -		git repo structure --format=keyvalue >out 2>err &&
> +		git repo structure --format=keyvalue >out.raw 2>err &&
>  
> -		test_cmp expect out &&
> -		test_line_count = 0 err &&
> +		# Strip object disk usage from output due to platform variance.
> +		grep -v "objects\..*\.disk=" out.raw >out &&
>  
> -		# Replace key and value delimiters for nul format.
> -		tr "\n=" "\0\n" <expect >expect_nul &&
> -		git repo structure --format=nul >out 2>err &&
> -
> -		test_cmp expect_nul out &&
> +		test_cmp expect out &&
>  		test_line_count = 0 err
>  	)
>  '

We could test disk sizes here test if we use git-rev-list(1) to compute
disk size by type:

    git rev-list --disk-usage HEAD --objects --filter=object:type=blob
    git rev-list --disk-usage HEAD --objects --filter=object:type=commit
    git rev-list --disk-usage HEAD --objects --filter=object:type=tag
    git rev-list --disk-usage HEAD --objects --filter=object:type=tree

The `--disk-usage` option also supports `--disk-usage=human`, which we
can use in the next commit to verify that our computations are the same
across git-rev-list(1) and git-repo(1).

Patrick
