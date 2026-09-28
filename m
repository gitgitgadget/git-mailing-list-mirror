Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F89451992
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577843; cv=none; b=XWZgfzMOwlGrXDvpzOtJjJigTaM282/D6euQg6dfNVOmJPiZFujlupdJkeyndAQX5lCISEErorW69+6VLCCeizSlO6DSlw8C5G/fFuZXZQWPpGTuyatcitEO8cGvJ4UEC7k8MUih2LJMBa5eeuW8ZxDShaeRSebWgqVpcZzvqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577843; c=relaxed/simple;
	bh=GLwGnFAJNFYI1iVH9hYl2tnXnKCOCT/Mb42sW3ntQj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR8FpfP8Kpo9eZ85GWzRPGs0LWbLteG1TNpiaqOTk4vXuWP9ixDzjQYQA1kkhZLqQ8Gd788HXH+lDs1lh5LOGal1ifBdSAH26+86hwGx8gqdlAZgA4qmimlh/MOmZKXeC//0LaUCnh0W9gzGSUwdiKcz1jtyhm/W1CqHiw0KzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QBNIdB91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0CHS+P3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QBNIdB91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0CHS+P3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D1AC14000D0;
	Mon, 28 Sep 2026 02:44:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 02:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790577841; x=1790664241; bh=XGQmUuzka2
	B1gZ7WyZ75oGPUuZj/Np8nT14tQ13Rbh4=; b=QBNIdB91N/zdQ6nb9s8a1cBZUu
	h4nQHw/dEhYu35LHTD33bAYL6DLzgMsccADziUkl+fk7C10UhDkjiFD6x7lxdLxO
	r6x3j/35PWcqRz6GVybCofQU1HfMeDL8tJRLdv5U5vs4P+fMwSa9lUkOTmPTjKcq
	Vf1r02WD+SYK/y186eBTMmphxGwxAEgFVm8yDfIZ6k753lGnxLHc9Pg/NdRGnwoI
	pA6gstJ36kp7Jguv0yiGyvKKzgxwGm+4DAd8mUB56ktotabg5JBUYE+VokJ/jjbf
	Nn93NbfwDlG+LbbonXDflli8twSF0Qmh1At5SQjruSGdCgYPqhCkkT0xuESQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790577841; x=1790664241; bh=XGQmUuzka2B1gZ7WyZ75oGPUuZj/Np8nT14
	tQ13Rbh4=; b=E0CHS+P317Bx7fFIHM85cxTQaoWWqZE/6c3s17rrtYLhKrgHZMd
	KKGgcHxa2dg/xDqt8YDk90vbqnjxezyfop8c3zt4qvFqjQHV89BEruudSYRHgMOG
	Ay+hCNbh7ZLTE275vw8r5a2ZHU5OqJGofkrAyXCYNtoVrW5Kz00mojs+BzUM3Y+x
	Bzll+aZgDR3ic2rZ7WBLcArmdR6J28RqtP0Wai/LAh0WFwKvHcHHobpL+bpxDNq5
	8V0oEbvfUe4E1Lf8mMJ5njGGcAELSaWMToy82ZqUR8L4Ey3Kabqn3tVBXQ8FBzlQ
	auc6BuuW0jIYZMdZtgRKMfxAY1Lm7avxAbg==
X-ME-Sender: <xms:sQy6aqtIev9-vKe3D6G5Mmz5ZVnPlcoAqJNddscq2aE4-d9KjF7Ong>
    <xme:sQy6auiNZ3px2FgaE9Rd19v2S6NbbfvZbBegPf8hoXxex0LB93o1RNa7jcjC4IYNQ
    iZQ7rKMOa5dOjulVRqERxmW0aKX2PoPFkwFyzHW7V9sk9jpdzTveRs>
X-ME-Received: <xmr:sQy6ar-ZAr15f8cCiS4DM_XLUBW8fi5F_2pBDhEk1uMguJUyTigazw>
X-ME-Proxy-Cause: dmFkZTFR3+1v2QifEitkv0K92sCOOPfantQ+ra7WIOQKpeM9vW9IPS6BJohxfpF04lew+a
    C6WrjHdCyQrIMN5GJ4hKvYaplb8AajFIMY80DXZ9e/fDWBDIRXbVL57hl7JqISGHHjXPRh
    vtazlPsHPIK56cpLFPZrYL6ATRs7RtVm2rtY8ws20RMXKlbHhKK6RmRL17/rWKrCqGaiye
    wuqPxmbYr4DCmnRHleJ6k86PWjyfJCrWxlLT0fVwfpYvbra3WLWMrWKBvkg9bNkyC5o5vf
    H4m0z0352VMLY957TiYAT8ipMlt+nXGusfN2ALba4BdixXeqPAd6Gk0ej7wdzDKDQpY0qb
    yS8p81mhJKABSbVpZg1d3CTpeuvVNexPg+d+ql2ADs2PSWW5FZxqCCVmNhzALKXTkBQM9O
    deJsV8JA3vWgg3RM0+JEgABTAboLq+KyJVU++AGEzCzkIXfqufo5lYvxwNRdLKfKd6ZBI1
    /Stpr0caDR+QzB5c6pvN5W+Rhrd2lh3UsuKmfYzazryrGhPSaJ1lr1PT/rrSaNoCfBgTq+
    R7HUZVmSDe8iseiy+bn1JeJU3edY3e9ES/WCf/KM95y1D95s8IRpK62a1YcUET9ikCW2tV
    nkwThxh5s0OJuKo81vjWsxTOKSjiiAOAzygYnCrCoNILhCmqhM8OK42Ym3RA
X-ME-Proxy: <xmx:sQy6ahsuOqP3hDD9zUo_qv5wXbjByVJ5JvYAtJGkyF8wkZY2sq7SKw>
    <xmx:sQy6avpxVNiJAYESVql3AR09gTNVko2kkpg1Wj4wlAurSsWWYW6YZA>
    <xmx:sQy6alohi7knh-rwbNjrZM19hxlpykMc-8TY8fSEvLgKyxT5H--g6Q>
    <xmx:sQy6auZf700MUBLrAG5wxXlxjBIez1XyBTDi2UMnPMVPrS3OgOk1nQ>
    <xmx:sQy6auPhAZFqlIfwOT86K1Jk9wRrGpXDE51llI8W-c6W86-XYjFtzOn8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:44:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3cc7c73c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:43:58 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:43:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch
 deletion
Message-ID: <aroMrCUN44YdKA2h@pks.im>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
 <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
 <arUEhkuC448hUTCw@pks.im>
 <xmqq4ife4mzc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ife4mzc.fsf@gitster.g>

On Thu, Sep 24, 2026 at 09:45:27AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Sep 23, 2026 at 11:04:40PM +0200, Maciej Ciemborowicz wrote:
> >> refs_delete_refs() performs unconditional deletions, so callers cannot
> >> preserve old values that they have already resolved. Consequently,
> >> reference-transaction hooks see a null old OID.
> 
> I wasn't paying attention when I gave my reviews, but the above
> puzzles me.
> 
> "callers cannot preserve", meaning "after deletion the values cannot
> be read anymore"?  Of course, but then callers can read them
> beforehand and use the stored value when calling hooks later.
> 
> Patrick, do you understand these three lines above?  I don't, and I
> am asking you because below what you say mostly seems to make sense.

Yeah, I think it's less of a "cannot" but more of a "we do not". I
mentioned this in a later patch, but I think the proper fix for what the
author is after to have reference transactions always resolve the status
quo and provide old object IDs regardless of whether the user provided
one or not. If so we wouldn't have to change any of the interfaces at
all, and we make sure that the reftx hook always gets invoked with
proper old and new OIDs.

Patrick
