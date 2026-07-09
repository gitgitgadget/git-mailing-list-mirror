Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173739B486
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568181; cv=none; b=YW4l+AWewl1K/LNBj+pjIgq3EYIMPPvhbWJOEIhuMcv475FEEiuYU7q1yFOMYHVasexUB013y681R0OUo4S3MKlVDDAwQQSU6iEV2oQiRJ/ZLkoJkX0cgfKq7tmP/LLWlpY/JVqVBt1OBIDt57ufVFnwCvB7O648WSovmaQvgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568181; c=relaxed/simple;
	bh=bLx68/R795xKfIGoubVC6hb4MvCZeaO2L2CBUVsUkw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F1Zihtdbo97jBCxXxHGSj9fkeRFL76Nui+iGiffrRGo6p8eHrtKoDqapiHU+qqPZHG0O+0r6AuyPkFCab4gvXpapvd1xrur77J2jGL0ldN8xopd8VNQOa8Gdds95n84CB/ALfBZHWrvRco+iBvvtkQySdNNT6miROOJpfdnF6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f1JAIGut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ats+pKah; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1JAIGut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ats+pKah"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B68F01D00087;
	Wed,  8 Jul 2026 23:36:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 23:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783568179; x=1783654579; bh=3trsLwmZvt
	iGy/7s1HGg46qiTPei/CUjppGO8xLmgmo=; b=f1JAIGutEk0Fliy6XVDwCme2wb
	UtX4y2XYAdfU+Pdd4/Mc+0+qLcm0/HwcJmEfaNmcPIw0QyGWPFShW+vTioaItt1f
	OV1vsPAY57fS+4HCU5Wiy0JVAQEyZrYHlJtqwrMfOYMTW9kKwNnnJsQSj9LHXWHY
	Wc1asuAXp2sCpIAW0Kj24s1+ibSmK4ECpUIS02d7H+dhcqGWnNxEXMgFOzdhmbnE
	UYIec/flwEwEGhVkNDwKS/R3ueFdVszvsx31xViX/7jAQiCV7J82cJgc/lNYF4w/
	+6ZGpqpRGuabN/okRUhaOv7q7WVBtHn6K2PjSroENB1CiuQ3mui8RNNvDf9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783568179; x=1783654579; bh=3trsLwmZvtiGy/7s1HGg46qiTPei/CUjppG
	O8xLmgmo=; b=ats+pKahF4zAzxt3szlQlBxf20rJFV9Tnzz08HmcLiR8P3+wAKr
	T3F0F4LA7uDGt7sxRafTcNBcumHAYuRqJW5aIYCGbiqQEScrAnZ72uD6Mhn4zORn
	P3kRDnmpQTW1WkqzYyWdgfAQFO+/Y9J5xbfuz2/dk/7aS+b74JZoRKh5vIZFLE8L
	u3OzxcTAIjeh0cz3arHNyVJ9RT8gbLetzWz2rYDMBp1Qlv8gqiVDbaKJP6syiZR8
	/WryI9X7M4QmImMYHPOxEIkjI0RGOgrF41yVW1PHTCnO4YgPFR6NY/vNxG37fSkd
	GaHTIzFQyRzJogveAV/9J1cPm5F/XQ3yeYA==
X-ME-Sender: <xms:MxdPamMBUMXFynVOtXamwaooEgWsX6qOtmPb_QmGHMKkQZoDnwEVzg>
    <xme:MxdPar9JwmgB6piNjguHAhzfYmtmq1XlthFGvKrQYHFttkv3ii0G-ncZxLQfc6dX1
    E8g5PXnJwUw_ktthAIp4BRrpRiBFyW-oSydgjceAOV5TTpdr1y7Pg>
X-ME-Received: <xmr:MxdPaiQO-TQpd8DtFkPtx_Hvji1ooNQTRy3ig4QrmA_pqHxP7dKHbpB4z_vjxl_V8_MRv_gHTb1t4fI1Ud8MpyEDMT7r-OLCEOrM4J8>
X-ME-Proxy-Cause: dmFkZTELC10VNiyy/OsHUjg49fk/wtP+vft+W+B0C8luTWXy4bRT/N0rdJeWl7gLW4M+aG
    IZEjBOsh9FrRmI/TMv19IINcnqm4l2zX55qCVQozxcqk20nvSGxxqwrTpKQDdK5m6lz6mU
    P/T0e540j8PYS0mRmKksM+3uo4PGoIzLTmE1JVCQH/5bnUMys1/lHcIulxC8u4WXkiUN48
    PJ/f8WNo75ydDVeA0cyZqu3eSvSxhgUgv5dWA5nlijvYfp1wr89kGZxJFdQHuDz+jqQ50j
    9pbMtGtBLa1b9VgB2ggvkT7M2O82gpeilYsDlHBkedO/OZvkn4jykCEPWwBKl3e3VC1DBD
    VmIwY+LyqfgrckO2nzMHin87KfF8fWv5vdZ5Tp+jC0NJIWTKfbbd8NR32/yI712l7bWevT
    KPwjfyF4j2+zOmZK/I/fL7vHAM60sr6/Z2oMNh0wiXZISCcSlMzTKeYosAtfjMBg+H74Xf
    ghhjBNH+rG9VITnwV1dEixtWQVUd6p8Q7lHWY6WDLLv85dmI5ZRbZy1ctdrrD3CUuEZFIw
    TnFvqdDP9uipawDecauZbBM7482PewS/o+5g6+H+Imzu4Pn9sp+AN2eIcZk3gf5Pf4iPmV
    kRsjfcP5ZuN0jq3/DmDaHQGAPkkbLPI82hGmGy1b4xkFSDIBHE8bG8nImS8g
X-ME-Proxy: <xmx:MxdPallrD2s3ZLA6s7uC3Sxgs0KRDtoehGGcfWRgcpXpvY-EGSvRPA>
    <xmx:MxdPaqTgT0HidvLdNRB4dSIy2DJrHpa5Y6iVy-rlnhMFG1xs9t7ADA>
    <xmx:MxdParNLnDDLJbNL86T39hPfXtHDjLw71umN4HILJn5LPDxtuf6ZCQ>
    <xmx:MxdParUgfqlzG0DWvBj5ZD7ew81w8nPfREFxpQEYQF2FS4FKnZzUzQ>
    <xmx:MxdPalzJiW8UEtB3_oyy6CHKwclmTUKUpTlNU6D-gYXMT8Z50pGy8VOV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 23:36:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 08/11] odb/transaction: add transaction env interface
In-Reply-To: <20260708235925.3992097-9-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 8 Jul 2026 18:59:22 -0500")
References: <20260708041412.1157499-1-jltobler@gmail.com>
	<20260708235925.3992097-1-jltobler@gmail.com>
	<20260708235925.3992097-9-jltobler@gmail.com>
Date: Wed, 08 Jul 2026 20:36:17 -0700
Message-ID: <xmqqbjcgrg0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +static int odb_transaction_files_env(struct odb_transaction *base,
> +				     struct strvec *env)
> +{
> +	struct odb_transaction_files *transaction =
> +		container_of(base, struct odb_transaction_files, base);
> +
> +	odb_transaction_files_prepare(&transaction->base);

Can this fail?  The caller of us would not notice that something
went wrong, and ...

> +	strvec_pushv(env, tmp_objdir_env(transaction->objdir));

... happily ends up using transaction->objdir that may not be
appropriate for it to use if it fails, no?

> +	return 0;
> +}
