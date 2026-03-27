Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97FC2C0F78
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597809; cv=none; b=GCjNmqvfdCbbdl3aR2mquCMgPAwtKMCtGKic2WDGi3/Fct6ry4NQMiMoQVpTiUkx7PkmJXKehtizrnkm0SCoxXaaRG4qebv7fCGK60rp2pGUUduOjr8DBnohfJR92nodyobXIeTAEyApe+CU7k/S3bAUrmIhhvOgSpzMWokSezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597809; c=relaxed/simple;
	bh=0RjvN8gjRkoWIcm0fm7bxkctNkojaZ7chdoTnDNc3do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKlo1Y/3qg+2SHNzLqlfx721nWmoDrlvumswEJxVkYOS4EEbmdT+bExOZTHBZeLDrHyO7QqAQ5StOFLhmsx/m+XfOYaHUVX3TaLRlas50fHswbt/DcbmBtjXNHqWDBJuAWmorftLK7DTBqsNN49vzLVqomRNOwUTwgXkTvUOH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P4/8mE4S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y38jW4dY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P4/8mE4S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y38jW4dY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B45FFEC0266;
	Fri, 27 Mar 2026 03:50:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 03:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774597804; x=1774684204; bh=rnxye3X1dm
	OIXz76/WXGADJ2WLofZbfp68L1whSEjWc=; b=P4/8mE4SCh4d1IUNrh6VkE/WOS
	YOFMsDxjQO40l/KgGmmfaknP2J69GzaL7DFgRVLsCPsWzkraMjYa7a2pWIMRgLDv
	XtvkZhocTksBWkBN9fI1gt9qYh1rP5YSXr7nMAWhpp+PHD2+RUruMQGZWxELvPdc
	3D6LDn9UCOUGnxZ5Eb7iFnKG2UyssS3RJmNGWwN6eNMFt4LQ5KL2OMYhAEXvi83e
	sCTxiTt032gIF5J4bvV9FgDbcrW0HJOfs/oMDDC55F7qWNbcTuofO9+Lh3eqwveq
	QicM3YBl6d3DYUcAZdF9ybiUsMPHgjNxWge2Tb1M0OA4fcc2mR1KNwAh/+bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774597804; x=1774684204; bh=rnxye3X1dmOIXz76/WXGADJ2WLofZbfp68L
	1whSEjWc=; b=y38jW4dYzJ1ku4rRG/z5g9GgOYPexV8ZJMSWA8WSdd7nxwDzG6h
	2SIRWECTKORIujatJIYBZ6VMeLII2iKTJuhBKoY6xYa6JDQ2iTQDlLlJlfTBLTm2
	JiJB/J71dbrlt3Yl+h7KLimRVMD96xYCI8TLY9QRngpZnliHzvqq1Mf57EWyMfUZ
	1YLkHWLN/WaBvqBsdd+4vkhSdjyJaFB2q4hCOKmUFHNTFN7wdii3GibGCmol2S2N
	D9yrNYL2Xbs9rwCzOmOBIsEaFK1aC1Y/BT2RpoiuHlZ3HM0ugf5xtSL/Ya23KFHm
	rJQ56jRNYkTJhkFPRR0nzy7tywTsXjwW18Q==
X-ME-Sender: <xms:rDbGaclIQnD6BRsXoTbr3w8MUCsUp_8jPKxHJobYNAcQKd7Uollw3A>
    <xme:rDbGaR0zfZmsZ6s97pTPlyhQvf7X2bGz2Cesy3wyxa84Sxxskv_ABct1zroSJscRs
    3omLhZgG76sri3kO6psaescDPGupfleVYecfZ3hZPLt3zvPx0cljls>
X-ME-Received: <xmr:rDbGaYTHP0-yuM4PhsQnikQLTkL1i7DM0FKUHol5RaBnls9AKzBT7JoWE-cgKNBe1J2i8-KTfxiq2207rhNqnmcddYRPcAN00Brjjvc0pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgt
    mhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:rDbGaTvU8pgmCMK1QVX4IF_uhw0ZRbxx-9TLh4xnPGxoymsfMQK_kg>
    <xmx:rDbGadbcOwQgbDXhZVrfcBZErt3xwP7Us6oRVFqWd2amXbWfOFeHdg>
    <xmx:rDbGaYs2xVwjXRvSn1m8ymCVKCREM7h2HXBbjFuV1sJ_utvVHaxrzw>
    <xmx:rDbGafHNsVy39t0bIql0P4jruO7v7epwRCwm2_4aHugYMWNpSlkPag>
    <xmx:rDbGaVXoSrNnGuLLkq70Z-8Jfz-mNhy4sY13y__ZxDKZo1A45ei2M7xF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 03:50:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d24f7dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 07:50:00 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:49:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] refs: make branchname helpers repository aware
Message-ID: <acY2pZnCSEf5hcWZ@pks.im>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260325164833.1216577-2-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325164833.1216577-2-shreyanshpaliwalcmsmn@gmail.com>

On Wed, Mar 25, 2026 at 10:14:18PM +0530, Shreyansh Paliwal wrote:
> diff --git a/branch.h b/branch.h
> index 3dc6e2a0ff..3aa53eb243 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -111,7 +111,7 @@ const char *branch_checked_out(const char *refname);
>   * Return 1 if the named branch already exists; return 0 otherwise.
>   * Fill ref with the full refname for the branch.
>   */
> -int validate_branchname(const char *name, struct strbuf *ref);
> +int validate_branchname(const char *name, struct strbuf *ref, struct repository *repo);
>  
>  /*
>   * Check if a branch 'name' can be created as a new branch; die otherwise.
> @@ -119,7 +119,8 @@ int validate_branchname(const char *name, struct strbuf *ref);
>   * Return 1 if the named branch already exists; return 0 otherwise.
>   * Fill ref with the full refname for the branch.
>   */
> -int validate_new_branchname(const char *name, struct strbuf *ref, int force);
> +int validate_new_branchname(const char *name, struct strbuf *ref, int force,
> +			    struct repository *repo);
>  
>  /*
>   * Remove information about the merge state on the current

It's more customary in our code base to have the repository be the first
parameter. Other than that this patch looks good to me.

Patrick
