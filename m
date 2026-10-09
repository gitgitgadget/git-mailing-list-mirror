Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B43509F0F
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571182; cv=none; b=VBq4PD3vTNwJKyWpPLfu9bmNvsksGh9fg4UrTJueTlA2pho6+t8HNY6j7EIwv6ckvbrxVHMKh5CLKB6bA3qFxHdhQnLzKBdclifaI5cBg+mw35USnEI60m0fwtLKkd61C5IlV98oUZBZHj0mCV3pr2SKVFAJPal/b9NFIXrsv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571182; c=relaxed/simple;
	bh=QIxKDZ0FDmUtoBcVVyAaTbMNvtiEAcf8PnUmoHXGzuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FqWyZPHEbsg2btsKBUGU/dUV8EZwENVxNXeU4VtqLC1Ql4sqkyjcbCKSjejwO4BY6FcAcSrGTeYEv2f2SiAxgqJ2io05H3qmxaJZKuFWYIHnYHaqXbJ/GlKRsEu3Vnc/jwduoUjDeh/zjRdCvHAR623wmD3FkccfwvWyDbTwVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FC6AFeEZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqSBezt0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FC6AFeEZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqSBezt0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7AEA7A00FE
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:39:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 14:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791571176; x=1791657576; bh=zgnvyG9bel
	sJChiXgr79w/4SFoYvIdZ6FbQ4iczMaPI=; b=FC6AFeEZY1H3VOCdYUszbIIJ57
	p9E5CyqiE2GeOVIdr4qjVWPIgbULryvywzp7qLpnZzXeZjqVNP3e42uUIJJlI8HQ
	JYLHezfFc+Q1EzVs1hcyDn22RRPMJXrooZsovQenV+tD/zAIJpjThv4a0joxBmXS
	xEbVGCG2bulggH44TklJ3MjkuNuOOS8XUCo8E1HwKM1J7RkHIya8H/R0Kcu3UTZq
	g7bvwaEji2UHs/A1KCzaxX/TT6OOUrXJrlGQ5oKIDXSOe6Js5s7pnP/bmO1PWyoU
	fBeNjrChs2NnzjARdm78bRoQxINTFDZire4CrzE9vntvscIeR5nafSE3Hdrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791571176; x=1791657576; bh=zgnvyG9belsJChiXgr79w/4SFoYvIdZ6FbQ
	4iczMaPI=; b=OqSBezt0DGDr0+VR3X2apPj70RcrMCrob6MPu9xctIGUdrfN6Gg
	WSbzHVsQlqI9Ux3a+hAQZ5jH+Ls/NuSZvlE/urhFUYOhc1HX+f+hhIu2Gbkhxq3f
	j3V7q8u0W/wJ9kYNFaJKZaNVKuFSP2AVJ5IYZhqjWlVNqME6at97hvCn7tcaXV4Q
	Q58FSApVJYWH1dAT980L0BShctsX/PgEKH6orZYoJM3lafL4o5Hw9pHnV61ni1Pz
	+fFQ8YEC4zkYdHvnOqiIAeStp8HMlObUdVQNlSo+EQQYr9IeGYfwTXntfJnwN5uj
	zU+lmcGnlbo5yj78gBTDXbmPsBowoeIgmcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791571176; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UezkU5fsnNvcertOPAuIkGFGOow+mi1HlEDYQj5odVGOTAF
	A51wZbizCFwQpdO9pbjT/FBOJf5cGgCdT/cUkjBbeEmfC1T9fW9idv8VCptb+aDg
	5gQHrt4nnCx8kLRNLpQf0KjxqMRyEedCYiTZHrUG2OzbdeqXqc/owOQmHxL18tUL
	mgMMtXHIzY1qoy99b8mw2V5KVkrWizCNEMYPn6ELmr78Ci4UOMT65q9rfUY9ve3M
	PA79FUttIRH1BGXKPEP1qhwdGkS0QComtaA4OJ+AMPcm0lx/pZSf5viOd+TEr/vL
	AeiSHJbenOb9qMnai8A2ncFlLw+lKEdwv3uNq+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kwxlqg5dCoWD8w9C9cpysI4MMJjT12RCFyrSXOL/VuU=:QIxKDZ0FDmUtoBcVVyAaTbMNvtiEAcf8PnUmoHXGzuU=;
X-ME-Sender: <xms:6DTJanuNxDkwimTMhINWqaEv1GGxn-kbiUhU3t4R8jqVzpqY98A_Yw>
    <xme:6DTJasIAoj7ioegSCdX2hfTIYyNH5J71G1X3sTlMhnz1x4uKvoriwOonf__GE9unG
    tnGsd1Zu6EAxUQgnAZ4X8GTXjTUh7p5ZHSevlYvI7l7DOBKJaO8Mw>
X-ME-Received: <xmr:6DTJakn5Q2-F3XtecMYLE7ghu9McILMXX_UWhm1Zk97AiKnOGDsC7z8rYCTeO_szKOq17WdCuaOz3XbMI9bLar9ZNiHFa-i7gO1S>
X-ME-Proxy-Cause: dmFkZTGb/YNi1TLXINTD9LS/8MWyXV7XXS1XVGySlxZ9GWClzgswroPQU14SgrDGzDwJO7
    +qrKvhmeBB+AiscY33WZ7PSctTPW5IxTCW8eHFvqy8zUQNcr7gq1Ctx8geSgW4cnPc9DK1
    bIKTJehQJrU8fqX+9Qws0opt/foknMNeJnyZfRzoKyqGMPYOGCQ8khUorjEBmHe2iaHHz2
    tl485laUDXAAHUR0DKc5PZ+jnZwBNKNucB6p6e9rrcWgJHQkYt2JCoBR3esLmmPEnbD5go
    9IxRLF2NNSz5IzpvzJDVqNcxLAKaNS2RJ6kh+o6Xj+utccbcEKxvPVKLgsqD/xYzbmuzBI
    FtL77kB2FCX0tOCNFf2evyK49TdJt5SfUolf6MnkMmBI7ec8GTqTtghtrasK2DTrsJoCib
    gVNxtKxT4EbDvFHqR6cY/1JcZdkJ1yDAvEA5/cL1WME7tpHrfs+pSJoIK83e6ObtpFi6dp
    cZ6CDYB3sm5MLOXRBweQe5zJ2ys2O9uvm7cstFaUFMrA5UcaKukVP7B1ySmP/Rfqc7YaC7
    YEBpesSfKE0KTUe5TyWRSJIftdR0qsPY8rh1lUEVlA6Aq1pLtKAd6axAQSJbfrvEGFs3CR
    7GSyYR6kL0UBFK/M1owV1U8luEZFSN4/WWv1fbgAdtXflj9mSdFyCU7favZA
X-ME-Proxy: <xmx:6DTJatIpInOlgh1fkcl4wSTdiBP-WXYDHx5M9JpwEJS5xgEUj695Lw>
    <xmx:6DTJap5JLMcnHKxMJokzWVwqPLVCzsyvWI7SlGry5-sWTJILSRGLKg>
    <xmx:6DTJah1r1wh8kUzjEk2r_R6ulCJY197FbfIU_J6K_JQk1dEkZ813yQ>
    <xmx:6DTJavcfuUC2mg4rWM3fCY_JgtCAQT0CIzSDlrxrLlJE4ulWeSpHMQ>
    <xmx:6DTJakTfOMqb7R-sy3LKR9l3MI0rRVd7ZQ9-NYKyRI8tOfN-I7nQOf9e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:39:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v3] status: suggest `git merge --continue`, not `git
 commit`
In-Reply-To: <3e43682f-6dbf-49fc-91e4-2019f3c13f48@gmail.com> (Phillip Wood's
	message of "Fri, 9 Oct 2026 16:18:38 +0100")
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
	<pull.2249.v3.git.1791558823445.gitgitgadget@gmail.com>
	<3e43682f-6dbf-49fc-91e4-2019f3c13f48@gmail.com>
Date: Fri, 09 Oct 2026 11:39:34 -0700
Message-ID: <xmqqecdypvkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Julia
>
> On 09/10/2026 16:13, Julia Evans via GitGitGadget wrote:
>> From: Julia Evans <julia@jvns.ca>
>> 
>> During a merge conflict, we suggest using --continue to continue the
>> merge for rebase, revert, and cherry-pick.
>> 
>> Change the `git merge` advice to be consistent. 367ff69428
>> (merge: add '--continue' option as a synonym for 'git commit', 2016-12-14)
>> says that `git merge --continue` is intended to be a synonym for
>> `git commit`, and the `git merge` man page already suggests to use
>> `git merge --continue`.
>
> This version looks good to me, thanks for working on it
>
> Phillip

Will apply with your Acked-by: and mark the topic for 'next'.

Thanks.
