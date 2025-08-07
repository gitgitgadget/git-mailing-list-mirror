Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF622A813
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550279; cv=none; b=bjcOMe6dVbp2SHkFidB0DxCFSVKvDLFNeqxq1ai2kCTTmCjGhsrsxBgtE2SDCPqX7eRi/Snz3OE29r6F9QFY1D6pBUs0Acpr8183J/pm0np6LlXQfsqd7WWGFk1A6rg0B8kkNSO6bxeuUPqzIDflImb3S4QZK6KHyyBHdPvwH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550279; c=relaxed/simple;
	bh=ey95W1jRnlr41W1N3uJ/1pKCRp6RUKYt6xqcgJT4S+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAHtQCDqr/pM+9bwFfoUh1YqWHq011kwdE1LD+n5TMEBbi+kJiengDDVm+BU5f0g3z8+PodslHSGvxqa+AZdxxSAZdpTIvPa9vbxzZggti/x5vZVUFtMx9HdWGWeclYaIiiKt+JllbUj24WMGvwJ/37U8+eyDgLFRPJUL9J16RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VUy78Rr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuWRrcEh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VUy78Rr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuWRrcEh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0983140023D;
	Thu,  7 Aug 2025 03:04:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 03:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754550276; x=1754636676; bh=SJNw2jemkG
	WV+adbB/1PhJkHRQGUXRKux5wuxXxsM8s=; b=VUy78Rr8cguCR4BkvUYWQ5F+b3
	8Tm+hllLGvkS5fS65Y0favWLaE7Y5/8W6rImteW9un4k6erdmWljZc9WeHiVSdUo
	GxXsqBW4VELbKJysj6+1fPYEl4371w77DD8p4aUUQbCOAzmE3byEBDs1pyryQSIF
	wMKBi8D4+hXBDjfoD9nD4AKdNmd6GB3/F45vu4RlxRvM0wajr7nlT2xq9t4v90PF
	GVWZ6IoPhHO/X85o3wZFkd3ciZNrTSK99IwUyp1G299W4y2lB/P8BzbvsC8k1Z+n
	3qIJpCsE9aMId7iR/MThvx+o0zzu2zhghiIhO+JH+AQVpJHmRL1GHdi0lgTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754550276; x=1754636676; bh=SJNw2jemkGWV+adbB/1PhJkHRQGUXRKux5w
	uxXxsM8s=; b=KuWRrcEhbOT3ph6iE5gLw4qDkB7xAoefEG/KqYTEY0CP3K5r8J/
	525ssA85Z9gyFysUXd/ML8UzjfurVhpFvGDJHMsBqiPsA+Z4MFm7otDTP9QhdyO+
	8G1+6Lpia6SGRi3fiJDF/MnhcPhHNSR6X9pAi6LJUBDb6cRGVqBHtz0upt3cIGp8
	dJbRaf6/U3yc9yxwQVyScN2qBYp+GYCDbyhDivm+K+WX51JKAorgsE/x2bxTCmsI
	c3MSxVpFN8L6pE/ARF/jiqKjZ6lwTuET3gaiFFpp1YSDPHAYNUgkwPx6GeCW0eb2
	xiAx3oHF5jDuyDxywJcwR2CndTZICLcDxmQ==
X-ME-Sender: <xms:BFCUaF03sKYagolk8nGBDgOfJe0GO-46SR9pv_NS_YginvKxmOMSLQ>
    <xme:BFCUaGoua2jyy1W6zCvkDvD4ftVUtZ_BzU07Sti17pqTWGx1Sa51aifGufYtaA5nn
    uhHWiWDCdauX8XJ_g>
X-ME-Received: <xmr:BFCUaCcNLlB-CCf23k82yFK9lrjDpft1v9TVP_OWxHAcihbSuwmxk-qovvixxfGS0qaY7TTJZiEbB3PfnxTMMa1oAkpfo9n2C58WdfUSbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehoshifrghlugdrsg
    huugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:BFCUaFrZoSJvti4ft6BF2FoZp3F1lfy-m27RBIUUn_7tcm6f-lNzzA>
    <xmx:BFCUaDG1vuE4NXG2E158-vp9yT5wrL_4J7Tqg4YsNsNsOFcXVSP3hQ>
    <xmx:BFCUaFs_FIQ2V_RKciUvAtBba8raZVRM2-yXt7aRJVBMoLpIicVzEA>
    <xmx:BFCUaFWim9rIdBZ3cHO0gpUJhgoh1wkgXNxg-1iSM6UfuZim-AjPlg>
    <xmx:BFCUaGm7ReHvxSLPLbWvg642nN4a4O5kxzRE5lcPnRe5fk-bWbHTjiwn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 03:04:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9833969 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 07:04:34 +0000 (UTC)
Date: Thu, 7 Aug 2025 09:04:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJRP_muuzCAy3mzF@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
 <aJB5uKFdGybf-IbN@ugly>
 <aJCW7aYqJB20LDNg@pks.im>
 <xmqq5xf35429.fsf@gitster.g>
 <aJEppnTkY+66IEza@nand.local>
 <aJL06Nlee6CR-KK0@pks.im>
 <xmqq4iukwj83.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4iukwj83.fsf@gitster.g>

On Wed, Aug 06, 2025 at 08:41:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> I wrote these counters in 312cff5207 (bloom: split 'get_bloom_filter()'
> >> in two, 2020-09-16) and 59f0d5073f (bloom: encode out-of-bounds filters
> >> as non-empty, 2020-09-17), and I don't see a compelling reason that
> >> these should be unsigned.
> >
> > I think that is going backwards though: the question to ask is why
> > should these be signed if they cannot ever be negative?
> 
> Earlier I gave an example of allowing for a "not yet counted"
> sentinel value for a variable or a structure member.  Another
> example may be for a function that counts that also needs to signal
> an error, and as usual in any C programs, the natural way to do so
> for any function whose "normal" return values are non-negative
> integers is to signal errors with a negative value.
> 
> Note that a structure member or a variable that does not need such a
> "not yet counted" sentinel value (e.g., it may have a separate
> "counted already" member associated with it, or the nature of the
> thing it counts does not have such "not yet counted" state), and it
> is possible for such a variable to live happily with a function that
> can signal an error.
> 
> It means the variable that receives the counted result from such a
> function may be able to use only half a range of values as its type
> implies, if that helper function is the only source of information
> that is assigned to it, though.
> 
> If the counter in question never needs to store such a sentinel
> value itself, then I am OK for it to be unsigned, and that is
> exactly why I said "not always a valid excuse".  But if the counter
> variable or structure member has to work with functions that need to
> return sentinel values (like platform natural int that can use the
> usual "negative is an error, non-negative is a normal result"), it
> may have less chance to trigger the -Wsign-compare irritation, if
> you made it also signed.

Yup, fully agreed, and this is a good reason why it should be signed. In
the case at hand though we never use such sentinel values, and I think
making that explicit by using an unsigned type is a good thing as it
tells the reader that "Yup, no sentinels involved, it's a plain counter
from 0 to $NUM_ENTRIES".

Patrick
