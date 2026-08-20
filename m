Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6938E8A1
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208406; cv=none; b=DldRzCUqUN33esj3tXuf1Vj8BBCJNweL7sZ351OY41dh7rjooPLjsbIsC3FSEGlOiAoW/jZuYGzXiOAFZ0wQzSyPI81uZWD+uoP9QvArACAZR/7R1YZRDqqiYDbBfMwPqpTmMnzbyKSv6aLgOkL+Eq+l2ULK4EwZjf/gY7QSg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208406; c=relaxed/simple;
	bh=cDimqHHy5hbFDfdEZ7+BGy26mCZ4XirPSY0KtSjxPcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+ibde9eGhiEdEhYQNQ82a9XbGoVdyTr26k4hN5XDoMLynIb8A8HSI6WXGZ32rWHzSq9hjctMAzfdpfE9iGPC5JdN46b2kcYmfBZaLBp7PZG5di5FGxfziAdRD9jYpDbfDo7bJ7YNvrHR1iB4RzmRzzM2A3pZRPptKHfh02IVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YlRAWguA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUBo3BQP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YlRAWguA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUBo3BQP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD8231400100;
	Thu, 20 Aug 2026 02:46:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 20 Aug 2026 02:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787208403; x=1787294803; bh=UEr9GHNIJx
	F86nrWCXAbIMnHWVB/Jy0QC1En6J1577Q=; b=YlRAWguAABYlBRNjtCnkGdG8z3
	fonGuvqgihmFq0RkJka44x0TO3LY9XbgtumFlAaq50PZqoyMvKeslXihdA4cVV1A
	ykaelKXWlBqvpX6VSxYwmXIIXv4zzg7CQE46QIIG98OAWzaX+RAM79tbfUweLnX2
	j68FuSy35rSuVilAY2PlLW0Xnw5ApMGDWyMbil62fcIjwy5J5+NKbm7JLDjPssim
	wtu8ZXbIULPrCr4wdQwTNmYYJFcuNzgvakH52mFV38GUpKiY6jrZpqh00NBU5CH5
	UgwPTp/1sXGin2LOkTveY+YYR1mqz9x4arEKTVm8PVXFGG4mt6TrOd69vegA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787208403; x=1787294803; bh=UEr9GHNIJxF86nrWCXAbIMnHWVB/Jy0QC1E
	n6J1577Q=; b=MUBo3BQPMhG5VCONAGj/w66BScS9gHvXk65xWhVsPJs4p3c3pUc
	v+lSHaspwi1utF/iCpJWjArmvgfU4GVv3aF8Gzi0IVK5RlOW//CpFGLma0nGcWif
	M2BRhB4zfDnX5Ec+dl1YCNYyCBZygXyysO7g13uVTSoIrpBJqfGcd+SEoHH7MWwU
	mA0ZKlxascTLFK837L90XJUstckNKn4xAS1GWZRWtEnky0TdCSOgX8FBCvLDJm/R
	2ztDfl/iNTdaPjASxUIRBtp4W8w7dfqO/IZ5tDdbOedtcXL43xok8Hq2jlPRfAG3
	4Iiw8p3aWZOWTONseQleARKVnh/3lNHLbJg==
X-ME-Sender: <xms:06KGalSuenlLC_G8ns7vjOGlKCQAA1qAfNt-LAqdMs0hOpBgUvU_oA>
    <xme:06KGamOpHTGLkKiNWlhDPTb9TNktvoBnpYCEDTbbabhabGrHpVdz9YGbcC4GPm60k
    jcFk1XUjDX0llRCY2Hu1M9b-JY8OftU7tT8suiDiHncTvz9DLpStqw>
X-ME-Received: <xmr:06KGaoMZksUd1vYZglyGflw4LSn_St2EbZHpAK7nr49Kw5zHuU_sWiE0WibVASYzJCH8U6R38VegTshPaq5zsaw3rp2nokvsTZiOW3RNsg>
X-ME-Proxy-Cause: dmFkZTGeoSTTY28wrp63u3iaeJPkVnv1Q2mi7KQ7HuCwTRUDO5dmKQdYa0OwDCk+abhfIh
    CIEg53Y8a1D+SeKTVnNtGh3DJwmfUZhTlbZjo0cPLmkI2XU3bVxJvOFCFNO3SLhNQq7RpC
    3pMgWTCKkm7Kg+7HURXqP0DpuzYb1acTq/mu2T7kZCtKT1TFZ4wKarOVTLWPb7XMdRCPNv
    no1YSwwj73MS//FvPKBzLAwZpZL/P1zwAgDCctNlYmCi8y0m2QQElduKfLfUlmm064XIXX
    vftha3pZZNslTmVRwftukMpi/M8QBG7n6NMF01PuEFoAFp24aLsQ2IbB2uoI3CWmeQyfPB
    sQ+GZlyC7fJzj3FbJHtyClhavjJb1faxN3VYjWFLWeBf8dbpnhtEzVuFPaQvDzQet5Kmmq
    FY/f1+mFbXzuO6ZTJl8o/Xuqd8YsCKMzCN4ax7UW6oy1pzBGu8AhONtwrKCaLCE/jUxHNH
    dCxCzz6oSG1KtKCgmXkxSEAQmTQjQA9eneGUD0awpnruUukDohB58iL0s4la17b2ukTgzS
    z3poS62C5n4WuT6x7fhB9TN6MvdakhQVhd1HIqK2mE3b3aKG3zrm8AoTVsVpH6exaYs4Xz
    SvBslEJiqvXwKpXWLQUA3+fnq2AB1vnhH1KekkhzglOsXJi609cPRSPsMIGg
X-ME-Proxy: <xmx:06KGamsSr2lAWfTZy858toP1DivZBJDUO7uVJrEhSKu4-PnOb_VCxA>
    <xmx:06KGaiV1HHk6zkMQReGxLSZIV2Y846SSxVS-_HUs_crCegkgE3NFYg>
    <xmx:06KGauufCkFWZ0wmGG_XXB1W8bBLGoF_kZo_YnwwuyC7PAYsmeGBMw>
    <xmx:06KGauVCquGGF1az2pBxJQUbJSnQIHs8IJV6R_Zg5dgIhxkSR23NQg>
    <xmx:06KGamPNNAT1CedZgYSQJFgIQlGpImTTnEiX1A75CIlS8SsRh4CY-eJ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 02:46:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44d68ff4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 06:46:42 +0000 (UTC)
Date: Thu, 20 Aug 2026 08:46:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 9/9] odb/transaction: add transaction interface to
 write packfiles
Message-ID: <aoaiz7M1oGboydY4@pks.im>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
 <20260819215311.3880274-10-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819215311.3880274-10-jltobler@gmail.com>

On Wed, Aug 19, 2026 at 04:53:11PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index db63587f6d..265c5f7a3c 100644
> --- a/object-file.c
> +++ b/object-file.c
[snip]
> +static unsigned int get_unpack_limit(struct repository *repo,
> +				     enum odb_transaction_flags flags)
> +{
> +	unsigned int limit = 0;
> +
> +	if (flags & ODB_TRANSACTION_RECEIVE) {
> +		limit = 100;
> +		repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
> +		repo_config_get_uint(repo, "receive.unpacklimit", &limit);
> +	}
> +
> +	return limit;
> +}

Okay, instead of assuming that we're running in git-receive-pack(1) we
now pass this information along via the flags so that we can pick the
correct limit for the given operation. That's somewhat pointless right
now as no other operations use this infra yet, but the upside is that it
makes it obvious for how to extend the mechanism going forward.

Also, we no longer cache the value and the logic to derive it has become
a lot simpler. Good.

Patrick
