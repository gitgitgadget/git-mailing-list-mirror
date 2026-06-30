Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859D2D3ECF
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809156; cv=none; b=Q9zCkxeL6+RQ229njBVFkuX6Zq4K+HUDoCBPf9Z6opQ4YvdIxrT1RiFLfp3IMdL2tr+q3PlW6vlsDo4us8cdbSFdddqVXnGZ8+RsyiIp5hxCANgb1Y0UZ9eOyqpHnbVfaMMMTFwNy47bW+AQQZ1EZdsyTHISnA2y028anu7KgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809156; c=relaxed/simple;
	bh=yrKUmrbikU2bRF+rDm8xka0tMbz+kjiMaaglySAelbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzhYRubIQLF2xVoF7j6WstmshvBOBLJC8Jtvrrcmy4iidzs0Qjb/wkGIGRWC9omkw/ijr28RsMBaVDdOyByPT5FCydmu9RW2J5O0w+8yamEbCrRXAcI2MD3sTLiTapEa+r7764nBOtCRqFcK6p2GHLZK82+4yGPHNf3M/cqx2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CVXSDDbH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EaO3APiU; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CVXSDDbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EaO3APiU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A65737A0119;
	Tue, 30 Jun 2026 04:45:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 30 Jun 2026 04:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782809154; x=1782895554; bh=246u01nGFB
	R1cbaxmryOy+rzfgrsyYySfip4vbXTEy4=; b=CVXSDDbHkf5Sz7+jgxXJ6ffmZ3
	hsUqrFdUe1rgIvirmhOzAhMiai6fGde8U6CIZERxqqUiB4ocnFgwXWHv/W9kHkfG
	d4RN/8oXJmPJMsSZdkWrAFnDFRKoEcG7WyIfZlKJBX+3VLVifqvBX7+aDJndWfuB
	ktnB1QX9Ypfo1ra8W7Smj0Thk68qWuN8K1gj3P2JcfiE000/2tp/96/aBTfZU03l
	Aoyscy15UZia8TEtYpdZcmsPANx+cqG1U8TC/xL0cNyrDouIkvAMAOhIDTqD2Tth
	w/xElOnCE24nZyI2HIgFphUmZ1x9CtZUu6HbhzfW70G9ulr0BvZYer8zrofQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782809154; x=1782895554; bh=246u01nGFBR1cbaxmryOy+rzfgrsyYySfip
	4vbXTEy4=; b=EaO3APiUr01nXMfzVpXd2WJStcmnsqwl0E/QYsZDmLqIObq3Qad
	u05DUzBoWDKxXa0IZm7XqBR+BCF7B10Yym+ioMYG9xMhem4c/nrSMT3AzJPtVRF+
	DeulyGGJvPZ9fhKsk5sNEQ6eQ7hjLzTzuxah0c4KQPdJAj9aZlMMLSlunoMxcg2W
	tdOBlijTBZbVpK3pET/tvCyTVjsS90rZ8jXvKSzRTFFCguO45Jh7C3T5/xN8XoNd
	H3zYdElf9HlUmEublfP7tvOMgK/jfabjyYQ7c5ABVsV6tnWKULlVixcjPnjliPj6
	593D3qbjRUDyUdOlCShMh37gtX/kkgmj5Iw==
X-ME-Sender: <xms:QoJDaqJvhXw_1sJsU1Wc4fN8mmNVRPv7AyIAi2BOfya5vGiUwiQPTw>
    <xme:QoJDaoKzByVell6UzfPnohFH6HFcNMIIonAHNBz5mxQOW0zORpjjmkUzeJwTpSQPJ
    yXBWOT8SHZFi-SPbpOx43rZZdCw8M3Jor8vI28rEXZxRuoY7JSlBsc>
X-ME-Received: <xmr:QoJDaoUwrxuPDbKhPrfZpuXdd3PVJoj7n4BnilaXhD6sSs1ybtyVJ8hAPUsZ6QdbHREIbe40nO6f5tBAzxdhEtuwQ0r4ljTq7Sh1nHlgTYnZ-g>
X-ME-Proxy-Cause: dmFkZTGXVjTiBxhvLoGm/aD7M74JeR35eBBGvl3kih7NYOpQvXK9YFHluALxYtP9s0/Uy5
    hO131dSxJIzbEZYZZHLt4IAjM+mHBfG3yzGzgp4JSUvPSATO0ZipiswdITgxD79rcO9vgf
    uHA+LBTgbvCXOiTG6KzkxmFAHcHlWkMHNm+aE9cjnGBtNLxpUeVRwGBJnZVsf6H7g0yeuS
    Rvk0Qu58PMfIAuuaT0rYGQJhLBUN1u/MGyWFbaCbgRXB1+4e4w35VwoIRjwnwe+sASGiW4
    mBZrh8cuIU+OMODre6nnxSg/m1074pHkX73lyzN8Jzh0T9e7fydSqc+OF9FzFl4Zb3RBf1
    GfTjeCycZKUMF4m9JEteYczL1h2vYAksE/RuM0rHBHyUYbsowHfSk2aA3R2msYDIXmZLce
    m7eKBznSYFIO5/db/9mKC7vjQ/dzVKPQDvS5q2Tr9LyXd+kl0Mm52jlrmz1CaPhFwKU6eu
    lHjWgNyOUluKuwSOfYzDMXTzYjt1DPjCmr1XGuwDS0sx8Zes3cYC4dPgEZnRphbwy4ZDw4
    o6QGd3yrIzeQOP7jJ3HBt/MlGz9zSz6oRtMzGTYFUUwZT4tixhQZKY/Ob1ORCPmP/5OAfx
    mQQtUQZJElM5OcNzh6C4S8Lh8SrKaS5/CMFiXL3rG5fkzxQs0GLEkzcOGfCw
X-ME-Proxy: <xmx:QoJDaqhvpWdBCZpXh8xUWpl54JvQn05Jle4ZOxXvkGI5MIGkeFRetA>
    <xmx:QoJDaj_4Z0zQgJ1sU9uIDgOZdqU9uKTPjVBLGH6huYKEmrJEd7hNNQ>
    <xmx:QoJDakA4-QoREb-k-qZl3_6ywa8LYvH34plNsPuAsN9XDu0IgigV2A>
    <xmx:QoJDagImO8tq8b28fiQeOSE-gZPr_xNrU9JhKkrcYkyA_2mB1wYBfQ>
    <xmx:QoJDar4UY_wtRKRNvo-Vd1qQmU1dm_XGTso71juz9DU2zMkur5zESAfx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 04:45:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21ccfe68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 08:45:52 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:45:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
Message-ID: <akOCPk55yi3lerL-@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-3-jltobler@gmail.com>
 <aju-7Z-ecJG_ORow@pks.im>
 <akK1roQJknYstX0u@denethor>
 <akLBFaTfBEq8vHUr@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akLBFaTfBEq8vHUr@denethor>

On Mon, Jun 29, 2026 at 02:04:08PM -0500, Justin Tobler wrote:
> On 26/06/29 01:58PM, Justin Tobler wrote:
> > On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> > > On Tue, Jun 23, 2026 at 11:19:16PM -0500, Justin Tobler wrote:
> > > > @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
> > > >  	 * added at the time they call odb_transaction_files_begin.
> > > >  	 */
> > > >  	if (!transaction || transaction->objdir)
> > > > -		return;
> > > > +		return 0;
> > > >  
> > > >  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> > > > -	if (transaction->objdir)
> > > > -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> > > > +	if (!transaction->objdir)
> > > > +		return -1;
> > > 
> > > Huh. So previously we just didn't handle this error at all and just
> > > continued to tag along? Did that result in anything sensible or was this
> > > just YOLOing it?
> > 
> > Good question. Previously if there was an error, we wouldn't end up
> > creating any tmpdir and would instead continue to use the primary ODB to
> > write objects in. This change would make it a hard error if we fail to
> > create the temp dir. This matches the behavior that git-receive-pack(1)
> > expects, but I didn't consider that the existing callers could
> > transparently handle there being no temp dir.
> > 
> > I suspect we may want existing ODB transaction users to continue being
> > resilient in the same manner. In the next version, I'll maintain the
> > same behavior.
> 
> I think I got a bit ahead of myself. The existing callers of
> odb_transaction_files_prepare() still continue to ignore this error. So
> the behavior already does remain the same here.

Oh, well, okay. I think this behaviour is plain bad -- if the caller
wants to have a transaction, then we should bail in case we cannot
create one. But this doesn't need to be fixed in this patch series.

Patrick
