Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A7238C3A
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176903; cv=none; b=ieyR6P0w+pQ/fx7idKelCL3RcoMbDPkZnHVnRIuiBP3xLQerO37SrhVaWDn+Pv8ofvJctjhkoDfE9b5sbM03aTsWuka9F76IBxg9MFFkGZfSxK2Mhf3WExwHxZ9u+ss98nK50eRKHULRvjsO0eCM31QSnk/k5pcq/Ig6dyj/8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176903; c=relaxed/simple;
	bh=lsnK43kvd4uB75xZia+m8NRlGJ8lhH4pKiOeaWMoK3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuAcDXDnddTO93EFPlGGAxmTtFcY71QdUjZha7v7Vsw7F+ssqLY4hweeOhqNa4rNZToXPRQEHewnOmVFsb6X5ECMMExkjXAgssr3RURtET1aPXij+uULo1XvFAmb7JiF18YpJdMwkTJOisXWPO+eDiSIu2xNXkiK3LcSSsIki7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W84nD2VJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d59XIjpb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W84nD2VJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d59XIjpb"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C415E138050A;
	Fri,  2 May 2025 05:08:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 02 May 2025 05:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746176899; x=1746263299; bh=Evma3XHDWA
	/OkGpba7hbto6wiK2dX4A6iKQGEr9NMPU=; b=W84nD2VJb5Pi31eJoC178YXTXX
	/4lFHbYwnKpF9vvXyAVSIJt0C4mutPQJgZqDjuwZ7HJGoqFV97RxEg1O+qaNWi/Z
	HLWkcSLl134fJjvWSiSolmnuTUBvIn4ZHnbGYomZdnWs2cDmw4f7Qj1erlEPSNnH
	HwpXEvYSeEEnmR2HFOTEPed/5kCExQZ/6I8jWjPNJoF0bVx/i7l7xto8wMmCwamn
	E3b5Ci+I1SVHEiBrXooVUC5pcyLZ6ZOvd1ExkUFMOW1Ay4GzmwtgKA2NswD9sEiz
	TvrEE3MX20sw4SKrbsMPzy2vpmLbx67jwL1EkH1brPX+89ZbD04TDXb/7eeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746176899; x=1746263299; bh=Evma3XHDWA/OkGpba7hbto6wiK2dX4A6iKQ
	GEr9NMPU=; b=d59XIjpbnQfDI86bcDkrWfSC8D+gcI/dkNMxIghv9INjOMugi3J
	eY2f9Xt+aEEc77x2egikE6MreUnHpCMf6yvOl+ju3n/S1XcLnWzyOQhxVNEwWHC3
	zUmbWYsPdJpGblSTasJXSTl4mZq+82FtNqU4LmkOMtsSDgb5zfaHfhBwtuNzoZWX
	dddjZ2JBBWwvt2KJsT1XPGn9rUqSfmI15BoWcpYA8izetRs5y+gLIis0fYNFjBtY
	1PIUQcnpw4My2iG2liltIuqV05azfk8t004E5QRp9opdy5FGHwG3NcI9S4FF58nm
	krjLhAaKFBFm2nmd9EHxvSNrivDoezea6Tw==
X-ME-Sender: <xms:g4sUaHyL9XDGadGxel-4fcHSx3rQZFIFKWYQWDbjzx1QTsRi5j4v_Q>
    <xme:g4sUaPTnIxrYIURkuwwNIeCIA_VNaFpxAbTTAvuyvU0CUcE7auE34D1OPCSWP3ZHr
    iWo1Q4dG6r5MB5BIA>
X-ME-Received: <xmr:g4sUaBVT_8dJ_iJUJZtNGhJZoTT13Kqg3cbJKBREnwKzxK8o615t8TVTTiKrVYCCCRbZ1t1A-WD7ES719plnGMHipxjb4oTv6_dyPiC97w0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:g4sUaBiqmp6j7aNOhbPWejPiIgho1kDvvPANdRdKlylezei93V56TQ>
    <xmx:g4sUaJDAD1c2aAHWjrXiaHPHsfbD85l4kXpjHhGPGHpnP9r42bmoiQ>
    <xmx:g4sUaKL5XB6VJ2UeOLPfdD5kbiDqEjMbXyBhIsOFQQuVZcYZrDoHdA>
    <xmx:g4sUaIBn04WlDlp3T96hEWcq0l3tiRzmWUZf7FqkB6iXYfHfq6QCsg>
    <xmx:g4sUaLwTYqACAPtIpvyEvjDJqhtG6IR3oxKtUTZ2lzte7LMdQKVuzaO_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:08:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b55a514d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:08:18 +0000 (UTC)
Date: Fri, 2 May 2025 11:08:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] whatchanged: require --i-still-use-this
Message-ID: <aBSLgTlfwSc1u_bH@pks.im>
References: <20250501213452.370729-1-gitster@pobox.com>
 <20250501225958.2947677-1-gitster@pobox.com>
 <20250501225958.2947677-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501225958.2947677-3-gitster@pobox.com>

On Thu, May 01, 2025 at 03:59:58PM -0700, Junio C Hamano wrote:
> diff --git a/builtin/log.c b/builtin/log.c
> index 04a6ef97bc..0f98ac8a34 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -113,6 +113,13 @@ struct log_config {
>  	int fmt_patch_name_max;
>  	char *fmt_pretty;
>  	char *default_date_mode;
> +
> +	/*
> +	 * Note: git_log_config() does not touch this member and that
> +	 * is very deliberate.  This member is only to be used to
> +	 * resurrect whatchanged that is deprecated.
> +	 */
> +	int i_still_use_this;
>  };
>  
>  static void log_config_init(struct log_config *cfg)

I was briefly wondering why this variable wasn't just declared in
`cmd_whatchanged()`, but that's because parsing is of course done by
`cmd_log_init_finish()`. Nothing worth thinking about too much.

> @@ -656,6 +665,10 @@ int cmd_whatchanged(int argc,
>  	opt.def = "HEAD";
>  	opt.revarg_opt = REVARG_COMMITTISH;
>  	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
> +
> +	if (!cfg.i_still_use_this)
> +		you_still_use_that("git whatchanged");
> +
>  	if (!rev.diffopt.output_format)
>  		rev.diffopt.output_format = DIFF_FORMAT_RAW;
>  

I think it would help potential users of this command quite a bit if we
explicitly told them what the replacement is. So maybe we can extend
`you_still_use_that()` to accept an explanation?

Patrick
