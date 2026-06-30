Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908923EDE6C
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818928; cv=none; b=mLk+Kw+rOM2KzaXav4eQAiBbWdkaEEmOW6mqrC9xD/UqQYjM11Zo10uJX4MuOzJ3UnQc0Bv6UrBot0+YRhpr/1YXUy/srMeDby95RAnfp43YSqeFGWj7HTY0ASU56cQ0lto0upl0mD0/svCnwL5YlK7zbEBbEmNDNyvBPEM/WKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818928; c=relaxed/simple;
	bh=wbw5RKCbLb26ho0kKdE4B4zD86vnp7X6KRflPb+yjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF3NR+Lkg0TTCH+Tr0LjQUBoh7nNx4ei1Q8FztgL7ahhLIUFMzH9X15SlHpZKXrSxr/IKzdwekSSVzL/lcITENrV/F8mMd2+DvJSW9/wEPDWkKR/o0wOYBS861Z6KZui/LsQtA0g1ToKeHeJ+a/QuGEoAiM0KJelrewX0qAUvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OhmHzrRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kS6uMZw4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OhmHzrRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kS6uMZw4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E32087A00E5;
	Tue, 30 Jun 2026 07:28:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 07:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782818925; x=1782905325; bh=76HF4tdpUo
	dBN0b77q9xeLwtxffCgRY0X+xwxzAAdl0=; b=OhmHzrRuMb+irMn9aex9Wzo6mc
	ZFMYt8mKZh34/4U06ixNzbpsCMsC6qqAp72ytulZpHeTXAGgJx/MtkfnVaJUDJxU
	tkpnEkwTfLBKwHyUlmKajDJteg+TbLkMf3f/QHDzPXN8dnfUqcLkrAmNPONQVIqj
	KmKne6owWT6zdIiTUOBhTZ1eV10+6MY4enwIZwDXWdqvcHZP43331lRDaIqtFiH2
	kAhvX0LM7kx2Gny0gsTvATOFOA15hM/XP3pw+AhneIRQ7B7llc1fcWGiZwzqS8A1
	yIflx2msehtmBYRmQeBa1/FqhuMl06JrbM6+FRFI4OU+H84t+WaUXuLBXk8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782818925; x=1782905325; bh=76HF4tdpUodBN0b77q9xeLwtxffCgRY0X+x
	wxzAAdl0=; b=kS6uMZw44Pwnfk2/QSzNaaRjuuUpWwsadIywjm/7+bmuAIIrCGi
	/5mBO8ZJP9jZWc4NVd8s6MIAOpTKPGP6swSIeeojVtxZ69nSBgziud4rNs6ocM1w
	Ky+Vw91xwVfnnTp3QHi3B4Bbg7RHAnJKSkdLRqQPbyF7z7qsc1YZh8LY+sGSMsyB
	6P+3fKYh4Yf6fDTXma9EOzr8tiHkzYjDMLk5uy3/j9JTbJHqv2Mt72Gsb5AEhVd9
	l6IAM7ipi+R5aeLFXXXyb8n0CiVEhVa+V1YBRos0zCbWKwySLJhmKTa5THZBa31o
	xgJHr/A2p7MYF7jxrB6ANZmU1Hdfa+Yg0SQ==
X-ME-Sender: <xms:bahDajfrvTTPxjH43GElreINbRTVCePly6hgNUEnNfcpBgyh6VcvNA>
    <xme:bahDavMveHfBNkwv1e8Oj5e0CYpT_mOdjbia1wwFAlYBsoN-LkPokwlRKvA4Ei7Xx
    J1pjqK4lSqoTfjsZFwSoSST2MSsKdyt7RHhpj_leXs1Ib0sLUeAeA>
X-ME-Received: <xmr:bahDaqKyjfsacV8GRTsyAp5uBslSF7ZZIspsWn9Hs5Im5nOmRJuhf15xjG8hz22Qe0GcX3jnGsrj5VlVD3QvAJHjaM8D-uiWhx20b36TfRPCmw>
X-ME-Proxy-Cause: dmFkZTEP8gyq1rVzNUn/0HjzBgz/9Moq2/c6+W0mF9K0Ur2/hwLPheqCVQEu5fgPUN4FUv
    KL9FS2wCbLmGf3oA7V9vdLYWMhI2ns7FXSZcBmZKBSC57HkBMlLb3tLo3UyLnkeELt8E4U
    7Llf9equv2aBCztzVBoZccck+q6kuD5Zbp+HYjJXvwHnwYNLkEf7ffSaIaALO1PcneiGxm
    TVYdFmNxbtxftw6FevYNH0+s27rskKY6UD314Q3eHcZWTHlugfW/L2NOxqKFOUAggwBC8f
    oE+0u/5jMDTyE6Jah3UOv7BkNTE/wsSTDSV/6ccYOyAL1lRC+ISqV8SogYASQzydVjJGGc
    Biyrw3164LHZJf9/5AymRhSFKjfESBJEMeIXv2hmAYhvvIdIjK5xkFWD9JYhNyLrcEA+21
    IxqayKnjQMsCNxo/ADKVUIL00bzzNSWQy6jlJi17aCwI31+QuxX202gmprSKB9nPI8Zoe/
    4OHAJ6E9ZrWNCUQ7zufNncA2TjfHeNi+V7UPV54nrrakwEjFbc9vHIzAHzodmA2jmgxrKl
    BhuYtEttAaDKDzwYMlUjO2cVg1YspyzI3mnjwMRZCsoq8K2jHgSt9ELjMlQai1QARH8f4r
    MAeaGTjf4yR6WVwhVN8q67GukeXU+Zvi8QhDOArtc4Bp04OHaRD3cMP/iKXA
X-ME-Proxy: <xmx:bahDagHkBLumGzuGsBdu3QXizs6rrqIS8QTkOzkBWxDIEk_6trh0SQ>
    <xmx:bahDaiR4oP6uZOp4h24SCGDGHmRwvmHowRApCYhyNrladw93tHF76Q>
    <xmx:bahDasFqCy20FDuW18DfSM3Rj-k1fVZ644Sv9jmtnDgAiPxTRzLxrw>
    <xmx:bahDau-MRhPViRfVJNE9FEgiOCPRG7nwe7bjWO_2Xuk4vLC8nMg7eQ>
    <xmx:bahDaqOBxglHZnALTh43oYlw8u2TpSsebavh0ECLjwog_t1Wc7Qk2MAV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:28:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64997f8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:28:42 +0000 (UTC)
Date: Tue, 30 Jun 2026 13:28:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] odb: make backend-specific fields optional
Message-ID: <akOoY4LKve0-ys9_@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-2-8d1877b790ac@pks.im>
 <akKmwPGSAGEGKZjL@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKmwPGSAGEGKZjL@denethor>

On Mon, Jun 29, 2026 at 12:25:21PM -0500, Justin Tobler wrote:
> On 26/06/24 02:19PM, Patrick Steinhardt wrote:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 8726485f1f..adc626ce30 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -269,32 +301,20 @@ struct object_info {
> >  	 */
> >  	time_t *mtimep;
> >  
> > +	/*
> > +	 * Backend-specific information that tells the caller where exactly an
> > +	 * object was looked up from. This information should help disambiguate
> > +	 * object lookups in case the same object exists in multiple sources,
> > +	 * or multiple times in the same source.
> > +	 */
> > +	struct object_info_source *sourcep;
> 
> To me, the name `sourcep` makes me think a pointer to `struct
> odb_source`. This did confuse me slightly when initially reading, but
> I'm not sure it's worth it to be overly verbose here.

Yeah, good point. But as you say, I haven't been able to really come up
with a name that is not overly verbose. We could potentially rename the
structure itself to `odb_source_info` and then call the field itself
`source_infop`. Would that help?

Patrick
