Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024DF382374
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041269; cv=none; b=mZjPAFiJeo1j3JPpHFiclXAqDxmEwb/HKZ95mMHnDVCmEkSiW31XWWzc63w30tQTalBIvyEsLi+qselt7ExuMm5nL84goDNkyGeSc+Zye204mU8X2kvDkMJYRqPz7+oVj5mR0KyEPdliYPE/FVT1mOj3EpHveUyACOoK8yZQZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041269; c=relaxed/simple;
	bh=6SME/q1e4IMBXFniutFwdOG+6Wuv07RrKVGN5t6B48M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i5lYICEyUpdh+BOXs1oGs8bNiX1dylteyvk2L/qlq61wf3VlgLVchRVY3EiVUQgOW7pahSJMZ24SkELl5Sf+VN4gMbP6XX1B3Yk0s8Tiux01B+nog+AdmoEeS4vyn1pLdoYW+16Uuu/wfp+tDaMqTTMhkk1dSdxRMmNJbaKcK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bhILVzJb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bYbdjpa+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bhILVzJb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bYbdjpa+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CD141D0015E;
	Tue,  9 Jun 2026 17:41:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 17:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781041266; x=1781127666; bh=f3C8le9C0z
	cFXxHZSYLFuMZLeobipkjtZxdiZPMr9YA=; b=bhILVzJbiFYV/KCLyYRMU8UH63
	OEQ+6/Jv3z0Mj7rpD4WIO8GRYe/CGKKqIocn+hPlBSRdQXfEoCidVjsF5/h36AoW
	O0xj9Sz3v1O10VesyxRp6Yh17G/e5I48kgOXLz6YXPQMVmXbXpNSNp9IuvQGEZQh
	3E4ikObxouBp6qNYMB6f/TfvQrr/VPJRAuIAJkmJrVD/t19c/atojEZgBq7SJGLo
	qVmg1AdCXZMmNK/UB2BqxB6xjv3BYLBuKXZv1yBlE1EMUHcGdyE+7g4PbLMoE2ab
	8b/GclRE0g8sE+lucKOeFp1uhW7+P+0He0Y/6RCDu4KUJKwDDW+Rg+sfuyGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781041266; x=1781127666; bh=f3C8le9C0zcFXxHZSYLFuMZLeobipkjtZxd
	iZPMr9YA=; b=bYbdjpa+UsnAHuADsEevlH2j1tEcldTM8bztNcn5WBAIiFxaIfz
	mzQrOggx5aSde9Tbh5IY/pFlpiqvCVY2DlH0b5YcXZpzCmpAYATdKydZfpFExIov
	moj0nbUNcS9QxugVSorx2EiJCQacZBk5GARNPbmww+qwO/GOTvB5ZBD3D4ckByVk
	bCFBSylv4E+O2Y2Xe5hj32HyVojwx0YbLoc6JAwWTdcwjFnf+l2Qdf+RBEVwspcE
	gomg31o2SLu8pcW0oVrcxQazDPhYYDkK+Lo4PhvZ2JW1T3gW2gyAuEFdIAwYzi2/
	sAgK7HOf6QS9kGb5+vtqlFe0O4KHC9ugxAA==
X-ME-Sender: <xms:cYgoai0R2Aq3vJ5mI9K1w1oBrro1no3F61S6hlcMMLCK5878RowwWg>
    <xme:cYgoanXCt5cGysC8gM6MJgnG1tln7WGDXPgvGNTyPJFt_9cCd8K-AAI5tW1rGfebW
    eqIQGqG8cCN--gCI__QOGGgyZr7qQqAmj794SXVAxTJgumrV98J4A>
X-ME-Received: <xmr:cYgoatLFEldcmwIMTuIV6GtEPHQL9YgnlnTT8bc-kMoKCKbCQPcDYGtWPsU4YCBK7d6pMV8wc_4abLEv9Mc8EQxAx61HBC-FIHFM>
X-ME-Proxy-Cause: dmFkZTF4ngucu53CMwCh2bwDE4Y4p3AX0xzbYyS2zyb1Ayug1pje2IO+Mu0RvMB0ITVVNF
    5lPidL6qRVxP7+TIYtdgjLcaVrlKd7VLCLJ5g0CpWF6zve3rIKnC/JTb/8id3G3bSKWulL
    hfO59SBuiqO606CcF6AaAMGG2/g4hfcnLHfiAJpyjXfO8CXOvGo1PA0Av6t7UjQS0zD+sA
    DMQFA3OVOQvxZQlv7kP2auD2sCWWin4dLFK3z67TBVwk80oyAp+gX5DRXPhn9WaJd9wS6x
    RKZaYEOI97/5f3hdFZcXRZ2vo2i0bjoBWBEwyz7RtevDqQDOY0RenrCvafH7XmMJhi7nZA
    aP5r7A9hGOCPGYmzK8n46ju1inQd4s2zfBnNKkMwWCun34y44ZWCTtJPi931Al8A8YpeAS
    +jBKa9AhoqUp6H7wkvj0k4cul23KBATwpjg33sAZUq+LsooLD0rcsc9dKzalh8bazIQ62L
    mz00pjv58EnhpErTgTdKCkwvC/FXZu+wNGUG3zCZ+ZuGCW77Z/usLAo5IxbWXhPEh7DkDv
    yetMcbtedK9deq7uNQjLZpwJJVcd260NSAyY4ZseMuTIwkR5bMPXwV3I18sRssQa5s/oWp
    gO97i66ie4zTpX1OGHlVrbQk7905LBWqgJpZonKoKpCZaZD/DT0KSpXoCxfA
X-ME-Proxy: <xmx:cogoap1UAPlfUCzv1CoFO2gQ2FSXBZ-PStsMr19GH5ixpnx8DBzrSg>
    <xmx:cogoaj7pmb9QUqzI1ojpnjAYMJN2hakXxWb1C1ORJPUoVAQ0RBSdgQ>
    <xmx:cogoai9ji_eMcgHbJU6xIa7HhASt7p2bXuqvEfqekQ-x_a15NhsvKg>
    <xmx:cogoaqXQo0adzzSvrNd8-uKEB1aMa8GJx8doj6RMKwOkXiXHbIqJdw>
    <xmx:cogoajJIMVAAm0GKi14IANWqVXRFf6WtdXuEThPiaZHd_99pSg2qlEUy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 17:41:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH v2 0/2] unpack-trees: use explicit repository in trace2
 calls
In-Reply-To: <xmqqldf7y95a.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	31 Mar 2026 14:35:45 -0700")
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
	<pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
	<xmqqldf7y95a.fsf@gitster.g>
Date: Tue, 09 Jun 2026 14:41:04 -0700
Message-ID: <xmqqqzmfz91r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Jayesh Daga (2):
>>   unpack-trees: use repository from index instead of global
>>   unpack-trees: use repository from index instead of global
>
> That is unusual to have two commits with identical title and
> identical proposed log messages yet with different patch text.
>
> Do you perhaps want to squash them into a single commit?

After not hearing anything for full two months, I just decided to
squash these two patches into one, as the second one looked clearly
like "ooops, I screwed up and left one pice behind, so here is an
incremental update".  I'll mark the result for 'next'.

