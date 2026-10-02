Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581673F4DEE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969897; cv=none; b=L/7gkWJpR/NqUPuKIYEe+XCVCrZeOiepzR8//EU8AaU+q7WyMMmx9UmtFxo67tCtW/8Hw6HaW4QGiDO1Un1fiEUSYXHzFhhN5Hr5Unn/H572SKF/+otuBhYHvk3EFdyOqSmKhSGJpH1E5q3Zt9glie9VaAVAw4OTiEyntMSHRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969897; c=relaxed/simple;
	bh=LAGwiQpyQ0uufvHpY2/Pv08nEQlJ/95brR6qYhd+5Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFI940dPLsU4+z4t3Nj9CkXUvpGVccxUgHHTbCo9S2BnXb5G0iYaWMToUbAD0/YyjqRSfnecTe49D6H+qDXXasExI8zD45X3nmky9yhfJ4sAciwQjmZ2lYu18rFZQURkqzntcwOC+xqn5MMiwXVQ5LV36txacSOYOGbt/XmkMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BCwNuzvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIFj2k8R; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BCwNuzvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIFj2k8R"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 809977A0013
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:38:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 15:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790969890; x=1791056290; bh=Jtx2jK7WFr
	YpSaJt//jAoYEdohj+OIFU+RcAcYNQCF4=; b=BCwNuzvO6Q+l7n5+pakjRcPZJR
	HdWwsWZx97+P2qQGg+vuZCGWZOieAumaPB52hSp7doqpui3zLlPX6pUCYZ+d8CuQ
	tFT6YJj/tSMMB0b5j6sY+klpULOzPKV6UE2uDW2tN4A+WFgvZWOhppGumZiGe1Un
	j0Kq6IWba03x7xoWK/h8zrJiMCJK852+GL7aiYGo3By1nOcK7KF9vnFHbU2kClHO
	lZyZ2Yn6oza0pcoQUiSaxRDgG5b/cNruVo1RFV5P829JZmApvaKmUfX721RG1TQi
	oBw9Gtg3MJH17e9mPTLRdmmFCLEbTJPmvw09Td8iTfRaj1HCQtiNtuv0jg4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790969890; x=1791056290; bh=Jtx2jK7WFrYpSaJt//jAoYEdohj+OIFU+Rc
	AcYNQCF4=; b=EIFj2k8RgK3jJMjn8zDVysupoexDUo3i7RMwPVfh0wfqI2v4CNH
	vdV8Qgke/LlMckIvPHZwBudGjsK/kvvw+82PPgY46yC6YnvGJDLUjSe3BSjEX9cL
	Icgh2+I+V+bdx2aK4SYLk8HQmtuoRsbn28YzmJKWgdyU8L8bAMjke5BdrRhG8Tuu
	c6TOZAjFgZkBamGbQUwtDB5EYjAoSY2qFLiHmuJ72Buw+yky9+zlvxX2c7rLqvQb
	wMRre5X12+/8UcF4q8TG+eluOsxr3XduF+pG4jL1XyXglJgZVpK9r7YYMFa5hq+f
	qtoXFZdWYqa4dCcfwd3QxnIjYIFlGuMlKaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790969890; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QK2kzwns/a+rgS8DthtWg68FfsQde9sPNRGCLGVOX8niU6/
	vnz8wJ0rVp5mkwKx+TZEmzHH1kwtwb9/6IreiCXKYhUWdQ+xxz7IlLFvf372qRCf
	JJSFcQN+UTRRKQ8/8jDbs6v9MmrW6KcKQ1DRBJbZqSeZbfjckRuUdkWNXR7xIrRb
	DwE/EuWOXkPqKhN8v7PcgKOYhzfDDSFZTW/y1deYYyEytOJM97iZafbaLETrKg4y
	WZmE7tAjDLqdDr0FFRQ0L8d2kg+0KN19GZLgrFSpdc5h+JFem490G1vKAr9IJbIl
	f2oyVENxAdt+6hKyrhWTICJNX1cvTfUS+0tisTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dXnc2RadIvJO0izjNpL3m7WmeftceMAB4MQw2rt3vfU=:LAGwiQpyQ0uufvHpY2/Pv08nEQlJ/95brR6qYhd+5Gc=;
X-ME-Sender: <xms:IgjAarwUQgYvqRA-HgdZp3qYkHlgIPnhxTKzyR_CP6-FqxXTK_IAsQ>
    <xme:IgjAaqR8QpHUS4Pu8zqY02FUG1UZwMikrnNwUnDJOpp9Y6ok5tq-N62ToG0NlEvR2
    b9YJaA9Pu5GwFuEn70bF4RAmLVahZ9fXFEin5R3r9tNI21haSVrlpg>
X-ME-Received: <xmr:IgjAaqV3ZCJ6cYcmmz8tggN9WKUSsJrx_sIFIeF764OTdxhgbpDCWg>
X-ME-Proxy-Cause: dmFkZTFJSYOCpsCxvK7IzV4kdROG5lSCHXE/63m0l6J1UK7xo6ZhgVgqjVMjARGSpmeR83
    BddsnqqX27uHhKVxFgVC8oCoy43yvkCPUC+3yDzUyVSic2TX+LuP1p6r5/Loq6wmKLkfHD
    EY1jyeUh2hZBNL+xrML0d95ku5UL0+f+Q4VBZCNeBxgkFY++WLgiWxrshaXtIinCgBcKm8
    zkkGb7WAkD189VAeD4TV7QqmDG8yleBjl/ohVJcG2u2Dq5wEGcZsG0N+sdMTRs+fbP4CKD
    rANyr83voaakZlqjZRqtvPCDQPOVz+z86QEB5Yp3qRc+LjWTNnpJcStrrEb6fYxyoXUZlw
    mRm8C6Us1MOZApdt8KKqDonp7TtkywDZeUjsd4s+rOsd2GwKvHkIntN1YijMGn3AocOv0a
    Vrpb4dc/VkjLlinedUix7xIqlZGS8UV9jmSyyIA8hZIafKRK4JFJ3flt2vytfjQ1ixyxwL
    z6/ElFCQ/JORLXxgHPdLPx+0wyDVxbWP1JqGN+5fb1OvAHzeyfxWcBlzYmGDviie1ZLwsX
    kJP7qMHKXEL9ao0azll/xnh7p8YKaEOSAR/tVIS6RboZBKxOWYY5KgtNieZKVbHo4QXcrE
    zuPNkKHPqzA3ktl+tiaS3BAfCLq8R4ZTkIDH5AbAur1gIemdPyu+uL3Hxw8Q
X-ME-Proxy: <xmx:IgjAakY9gSOmfsWGMTRAdTfRkDu1RsXhbeSacbGtogzfJNCtcOEAnQ>
    <xmx:IgjAao0w3Ri-1x29agvQHjnIW4n05-WRJMv-E4aXSNQYCecNGWLn7Q>
    <xmx:IgjAauinXqZfY7xyAwGL3l8mVKV47vy5wsSCJ0Wd5fAWZq_TXhRizA>
    <xmx:IgjAakYB82JLgmh1tSBD771HWvv5ZKlsLPLlaatlz_UijpzLpyogvg>
    <xmx:IgjAah2-plGGwYY7qrFXMz6m7NO-2TMkcqdPdZTMBWj_L9lHgbx6iU8p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 15:38:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa6afb0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 19:38:08 +0000 (UTC)
Date: Fri, 2 Oct 2026 21:38:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, Guillaume Chauvel <guillaume.chauvel@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] packfile: move around `close_pack()`
Message-ID: <asAIH5JOfGMpJqEN@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
 <20261002-pks-packfile-stale-delta-base-cache-v1-1-7592a3e31ae0@pks.im>
 <DLUL2YDALTAV.15LO4AB7BDMLR@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLUL2YDALTAV.15LO4AB7BDMLR@fastmail.com>

On Fri, Oct 02, 2026 at 03:02:30PM -0400, Mark C. Chu-Carroll wrote:
> On Fri Oct 2, 2026 at 3:34 AM EDT, Patrick Steinhardt wrote:
> > In the next commit we'll want to access the delta base cache in
> > `close_pack()`. Move the function after the declaration of the cache to
> > prepare for this.
> 
> Maybe I'm just being clueless, but how does moving an unmodified function
> help with the subsequent change?

This is mostly done to avoid a forward declaration of the function that
would otherwise be necessary.

Patrick
