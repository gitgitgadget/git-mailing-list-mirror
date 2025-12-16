Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E833A6E6
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873539; cv=none; b=sT40CCwTQbL5dQok1zaHc8N6mdSv4/9HpqQU8w7cyfIPsQJ14RT/Ys1EHs6BFP9OvWf0Pvnf7HIiTBSfXxccnhDH2+zoOEaJWsf1sbPn8RNxCaeE20lc4S20i29lKrMAf08cE92uYJ/Wif1rm81E/rVUSNBKMUc1CYj7l7XTrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873539; c=relaxed/simple;
	bh=yoC8OTpTRz+tne3eOxhbu/Z855TN5x3t7UCNXM7+9Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+3YaAuQxOuIGmmWNMoQI33BCGe+yFNAMu/e894GzmRCZBhslyd8RbNvSbXMrdr0ioQMrzfqiwbqotjKA+ehhjL1QbVjWlAd1ubhYMzBD6oS4vbZCl/Uo8gtN1RvIGAGQ++zs+8TDUkaKTelPm1Yg4uAV/asze08xTWf9YL3JPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lI4xjr7l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okGzYndi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lI4xjr7l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okGzYndi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 169F77A01E3;
	Tue, 16 Dec 2025 03:25:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 16 Dec 2025 03:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765873534; x=1765959934; bh=Y27s+j2iPR
	YyytjYs7MP+j8H+F1xyoHIx2XIUVnj9sk=; b=lI4xjr7lqTsZnaTTFNomwdl2tk
	lyWpKuXUVT5o1giXeBJNL0d8sopnBN5k1eVBNsdKMhtZEgxmHSy5Z85Ylwy6FHOB
	15L9FIwE6YqzeDI5+T/mYjX9N8b04wRnthciCfSQNTrn9I6wGlrWUYBHXsnHrsD1
	aP+xe7CUIE3IfTDYfchhAIX3KDpAzCYc8gjj3IKVzW17LgEQIdGaWeOJIyBzVOoR
	aG7AE9FrGaXLdKCXwFVYA57WluJAy6HYHRjGpW44ud1iUv/XK725xQDkFaVz+k49
	QWtEtncRMnOXefzlvKGndpuYQtkZ8nPn+Nh9mtD9e0BgUFo86ht70xrS2zvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765873534; x=1765959934; bh=Y27s+j2iPRYyytjYs7MP+j8H+F1xyoHIx2X
	IUVnj9sk=; b=okGzYndiAZ48Oy1PdZNliDlbD2pJtODbO2A9KzPW1A2uWGbUr7F
	IbW7/jEJ5zQDy7DnHgUBy6/FdgtdfaAGoOmyzJM4S239GWIfz1BGJxS3MXpQKfg2
	WJs5L6gJASzqj04v9VFGN2MPw/HvOb3VQuLye319mVSTnmp5VAe1QkGiQ1vsw6zm
	4Al3vMkz7SGG6d5b4LlSqjKiwGQTdp9udJxG2L2ERXGC133e7ICdfqw9DZMHMpAb
	TDchJrXOSyhr0q1QoXeX5PbpW95ZRF4oemQMJ2bXqysb7Zf2N4gFXntm39sRf4pl
	ZFYZp41UeHri9fsZPwcyFxx1qxqpYK6KlIw==
X-ME-Sender: <xms:fhdBaQbCvrsuTbXsn4jwx_PHdsul1X8BN3kgVIxOHfR-1w0EDWwmmA>
    <xme:fhdBaS344xUz34tHfxuZlz6v-A9XYYLEULkCYWz0wkT8yWH1JUo1TUOeVC6WRpFjy
    M7qYcImF7B2fytDMQDCli8ra3uQbKbeZhyOeSVuRDZ3zGLTmN9Uzg>
X-ME-Received: <xmr:fhdBaYUhAycrV5Y1Bs--2yk9c25Y5I5ePwxo_xzhZDvRYZBeChngu1-2CS4mcpOinktI3x9OYciq1T1Ck0GddlmhI198QfJQ-1ZXLyE_VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:fhdBaUVH2ZFo7NOQI2sUPNDmsKEjxi0yQ0iK2fP_YSWjBdGNmgzl8Q>
    <xmx:fhdBaffRiEO_Fta_nHNfze0i034Lx4JBBDE5imYiOCk6qU5FAsCo9g>
    <xmx:fhdBaVXRKno9knCLLkH2o3TbqproellEEjDjuKnpDFCpOL7zbOcoPQ>
    <xmx:fhdBaQeJfJoRUZaqLuhHsawYvT73LP77HgsuPVNnzp5dhvsbh0hnbA>
    <xmx:fhdBaa28W2FQXfFfGJj8mf7MpKY34JoP5PVvLXlV6UwkPduv0u97NNF8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:25:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea6fb593 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:25:34 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:25:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 7/7] builtin/repo: add object disk size info to
 structure table
Message-ID: <aUEXeuCkMDWSfwHi@pks.im>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
 <20251215205639.2700270-8-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215205639.2700270-8-jltobler@gmail.com>

On Mon, Dec 15, 2025 at 02:56:39PM -0600, Justin Tobler wrote:
> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index dd17caad05..64db191234 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -5,8 +5,18 @@ test_description='test git repo structure'
>  . ./test-lib.sh
>  
>  object_type_disk_usage() {
> -	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
> -		--filter-provided-objects
> +	disk_usage_opt="--disk-usage"
> +
> +	if [ "$2" = "true" ]; then
> +		disk_usage_opt="--disk-usage=human"
> +	fi
> +
> +	if [ "$1" = "all" ]; then
> +		git rev-list --all --objects $disk_usage_opt
> +	else
> +		git rev-list --all --objects $disk_usage_opt \
> +			--filter=object:type=$1 --filter-provided-objects
> +	fi
>  }
>  
>  test_expect_success 'empty repository' '

We don't use `if [ ... ]` in our codebase, and we typically have the
`then` on the next line:

    if test "$2" = "true"
    then
        ...
    fi

    if test "$1" = "all"
    then
        ...
    else
        ...
    fi

> @@ -79,6 +94,11 @@ test_expect_success SHA1 'repository with references and objects' '
>  		|     * Trees          |  15.81 MiB |
>  		|     * Blobs          |  11.68 KiB |
>  		|     * Tags           |    132 B   |
> +		|   * Disk size        | $(object_type_disk_usage all true) |
> +		|     * Commits        | $(object_type_disk_usage commit true) |
> +		|     * Trees          | $(object_type_disk_usage tree true) |
> +		|     * Blobs          |  $(object_type_disk_usage blob true) |
> +		|     * Tags           |    $(object_type_disk_usage tag) B   |
>  		EOF

Curious, but why is the last one special here?

Patrick
