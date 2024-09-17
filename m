Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DB14F9F3
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565255; cv=none; b=gsGJrMFb9GbF1juxN0aXbW/0jX7CGHv41ATezlKrPFSZAct2TY3Ty+4VCfBdUjoVphyIXih8u8h6AoKsXvfmA4HkzZNYlxJR65AllpaEEWT+Gs2bVHUnOmFjG7/6JKE+7C8NV8I56heO9hedg7abxiMJ/6wKy3xzs1M1PUKA3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565255; c=relaxed/simple;
	bh=CRbdLFFBkceJimltSIM52LDEB7JxnEDxZcShKvBHIfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTurIqMUxTyNG2P0hRCRDmABMXmQ9DV5W0c10/rxdWV1JheV5aL/yjTn1REz6PK6i0dK0OOA3DVna2sNiGaSp/bceJRbFLbzSmxOzWz/TYP9O9adrvLUBnAKH+gori+cG+vcBQvtEHTfQyYqcSdKJek253nVIu1Gm6Xuhjw/2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tBvGtwNA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CTlrizrw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tBvGtwNA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CTlrizrw"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B274213803CE;
	Tue, 17 Sep 2024 05:27:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Sep 2024 05:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726565252; x=1726651652; bh=ortbMSDc5y
	Hyu0iGDY5qgXUIdGrMkXYhTTZQiUYYbP4=; b=tBvGtwNAa8F53f5mZgCbuBk+Jq
	Ty2JjcLAlviyxo4IH3bYB7fYK/5pd8XElmObmVSLj+NyB5rE7L3cELc7t5Fy2S/X
	9vqq9QFnqS/hfwfi15mCYGRT9p9CCcRCtFl9gBUwDo3ZtxKmjawnhc0GhjQhzlAW
	H3X3DV1iBgWNFpepjrILAd9ZHOjcOrDr89tsJxtynQel7u7Qp/7FNZA7THKQEClh
	s0HabLQAxO1J2FqzoepUQTcvP+4BpMHy24AQt4L2nJhjCBkTDN6qe4y237lsfyET
	JrPs36r/w0EjzSwkBF/R5wKQmMW4F+3x3OdzhdSXYdC/sBvLvzbPfbLZKZ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726565252; x=1726651652; bh=ortbMSDc5yHyu0iGDY5qgXUIdGrM
	kXYhTTZQiUYYbP4=; b=CTlrizrw3qLqOKlp983Kle8p3lL/PVDJmyyyQ7V/CU8A
	nKeRcJYq67groz2qSIt+jSiwPkhqSpVISSdl4EZhUhjN55p1iIipm/aCmbNLJ3Z1
	FAFlvqsZo84w7ECynuwKgWW0QznZvGYfIKP/fKF3hOnJeax3oLnXTpvMoQhUEgjw
	mFgveseYWYrYuKsMmccpvU1Sgc7TIluykkUgc+0N0hqSGoHqMCtyvHwZb+Z+2rRi
	aRkGT9HVlg5DMYX8IdBo88VciUns6x6JpG4QF3n0QWsTSHVnaF+/xK/JW1+/icPQ
	jKddF4sSrMqJZHD/vrkIXBfese85f+EK8uuxsHSa3g==
X-ME-Sender: <xms:hEvpZsijProAJRJVQtTk1mKJiu9oxlEWRJ427bzEyH_-wFvUdR4OZw>
    <xme:hEvpZlCIJ0gOm_iWEWHRV4CkiF6bZL2hWpVSWdzpluRP3hY0upCcMAoUX_f-ZB3ui
    0XZuNMXrlNwnZ2isg>
X-ME-Received: <xmr:hEvpZkFCbT6ugFpxLBFgS5lEq3iRIV95fbaS98Tn6rsYk50GdqTg23buUDsf7hVNzH5RC7Pu5ROpwrER5ifazensq-3b0Zf0IWXw4zohrxzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:hEvpZtQH23RnXlShXUL1MEzV4G5_wXio8XPcPV8wxQug_0xKkbUQcQ>
    <xmx:hEvpZpyR_tWICo0gSL_XgL0W8_4Lg4ZGllNEg9v6iLn_-fhvQbiI9Q>
    <xmx:hEvpZr7D7NhGj5L-CUu5w3r6XF5AgibhbFpArkI8EFOo5YWcMh7r9w>
    <xmx:hEvpZmydcb6d0bF6_j27k-syGPspbyORFOp2R2T4bECN8adrtCfqSg>
    <xmx:hEvpZh-jNjbk8ISe85_XuQ-2I7kbLZ-iEk9COdJ_4NXPMxGC3OrE2Cw8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 05:27:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c424d28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 09:27:10 +0000 (UTC)
Date: Tue, 17 Sep 2024 11:27:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #05; Fri, 13)
Message-ID: <ZulLfjtfuyDkeQJg@pks.im>
References: <xmqqwmjerqvl.fsf@gitster.g>
 <ZuiJjQCZ23DznwJo@nand.local>
 <ZukiD4-GP-rcUWnS@pks.im>
 <Zuk7Fvo+a/e6UObo@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zuk7Fvo+a/e6UObo@nand.local>

On Tue, Sep 17, 2024 at 04:17:26AM -0400, Taylor Blau wrote:
> On Tue, Sep 17, 2024 at 08:30:45AM +0200, Patrick Steinhardt wrote:
> > There was also the open question of whether we want to rename the new
> > `_fast` hash functions to `_unsafe` to make it stand out more that they
> > are indeed not safe for cryptographic uses.
> 
> I am fine to rename it to unsafe_, etc. But the more that I think about
> this collision in loose object files, the less I think that it matters
> in practice.
> 
> We would only hit it when trying to write a loose object and racing with
> another writer which is trying to write that same object as loose using
> different compression settings, which seems awfully rare.
> 
> Perhaps there is some use-case or scenario that I am missing, but this
> seems like a very rare case to disable a check that is otherwise useful.

What I don't understand: why don't we just decompress the objects to
compare their contents? It shouldn't be a huge hit on performance as we
basically don't expect the code to ever trigger. And it shouldn't be a
lot of code either, so I don't see much of a reason to not do this the
correct way.

Patrick
