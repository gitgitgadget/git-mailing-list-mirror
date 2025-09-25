Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517433E7
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779213; cv=none; b=IUSqHLQk+WYDuApGPvvQmCyVoRh6kAZsqUd2x0mHJqJ2EBKNwEJBjk2gxHaESwzh23hqhSk2Pt1wINI7IXtT2ldULA7WYrbQBm2AKiXIIKV8HgKV4rG4352rTRL8PNg4FeeoNV/ylgxk6D+P9XUQ7yfxiIidw0yZknLGuv1TonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779213; c=relaxed/simple;
	bh=Rsia2/XVo2+3a+UO38rm+rM0OQVFm5v9KhhBFEiwNvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSy6Qmv68K1+fu2QDkn0WSH31mqhjTWrjuv2BAs3SZcne8afEpnWvWk3Wq0lH/v2aQyJpm+kgr/QnaQpNslRJ1QwJqSfSPycViHSamtKFvshmEw4jVL0Z4HU3TMZ5ZAhEcjtJwPeIcdQ32sF2YITkJMs16I/9zXeIbsINRPLU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H7dbmL2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIvccAxm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H7dbmL2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIvccAxm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73898140014C;
	Thu, 25 Sep 2025 01:46:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 01:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758779211; x=1758865611; bh=o5QuxQW+aH
	RItKwRYW9YvGaRoTDaMvJPv9yUciqGKSQ=; b=H7dbmL2HDdWScYl7NT7Y0wZ1hF
	l9cgySU606e+pLKFp8jETSOI1LcQ4pU+j9aOU83DaArdJJgMMxKrW5lCjPX8CRIc
	OzvzflSfMaQZ8RqVFP3de581Ft1qslb0jY+iTv3UAsKOpeKBzy9jWCx88cW3+1VF
	wcepwJI1tpXOFLI3dzWf0zoDVek42T95WRdZcV89NasETwHVWttJVb32SU7XQwCq
	VVmdbQ6UFEYRlZbfOd95J9+X482vXh7GLcAeB9uxz2vXE5Xl7LFA1DwjGm091H22
	ZAIYKCekBcA+z2uBtXndALQPn3nbuIE4kZaJpu5Qyys1luXY2V1XPIyt6Rug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758779211; x=1758865611; bh=o5QuxQW+aHRItKwRYW9YvGaRoTDaMvJPv9y
	UciqGKSQ=; b=fIvccAxmq2noQOWFWxUC3UfXT/Kv9QjVJqlH08R7o/wkW0LFvBO
	BQoG5kgkCF46SvBKVVxodLRN4frynUFiYUHm0lrD6MmMhzTz8avNx//shmRFiEI8
	ixghX23+l3l938ScQhZMZPuuPmjRljY0InAvtCHbKaoTBLXvDLTu8yBPwkQ2Rad7
	WVR825l1OR34I14Ivy2EeLitOyf6VCExnwhFoY2e60mFLt1jIamjNsukea9BCRYf
	4fAihTnTfiEgpMRh2+sm5/2Ora8YxzR9rS9ibrj1CgNx+MRgDxEG/e6Ixg8jdOsz
	ttxNlmMRz33mHv38SnowDpt9mSJ0ukqGw4A==
X-ME-Sender: <xms:S9fUaAG60X-OOAtvlID8NmrilNGeNDYrL8B5Igx66xRBjFNfcQPy-w>
    <xme:S9fUaAP_gUsfMs04uYwvQ_pNzxFvFsjQDHqGIbOl_zW_tIkjagaZPLnM-psgLUj25
    FY3RCUQSLH9LGJ6uGpuOFlxaCrUToJLEuP6ji1alTF6x2iOb4M>
X-ME-Received: <xmr:S9fUaCfZTEVzWLXGQTluorHPYxKKlFxx14vYZCuH6F7YNZoIAt9yqlwo8-vwv3qskn_IYIziaJlWmj1iZvBf6j1kplSAePqmbf5e7jM-j1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehvvghlohgtihhfhigvrhesvhgvlhhotghifhihvghrrdgtohhmpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehnihgtohestghrhihpthhonhgvtghtohhrrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S9fUaNupZhQJYa31cL6FzrJb40OsK_VaX1FXWDLRqgcWgBnr9LYH-A>
    <xmx:S9fUaDnRSqHUDNEYKPGDAsD8lzlSZh5QY1NUEpNVJjcFsuvrrkhjxA>
    <xmx:S9fUaPykXDefWvykRRyEqUXUgBap83Wpt3hM4dRjJW_5A6sEujFncw>
    <xmx:S9fUaFPvNcUNsL9Xo--U5f0OVS6KVzABE_mOSyg8r-4Qlp6Bjg02yQ>
    <xmx:S9fUaHKzD33fIIVIOT3uAX9_nDcjYJ07ICZo91iXGuH3scEFAjIWLFlU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 01:46:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4e284e8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 05:46:49 +0000 (UTC)
Date: Thu, 25 Sep 2025 07:46:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nico Williams <nico@cryptonector.com>,
	=?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>,
	git@vger.kernel.org
Subject: Re: 0-Based indexes for git log
Message-ID: <aNTXRRolcqn5sT6d@pks.im>
References: <xmqqh5wrn66m.fsf@gitster.g>
 <95F22D6A-38D9-4F4D-B71E-59320B86B4E8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95F22D6A-38D9-4F4D-B71E-59320B86B4E8@gmail.com>

On Wed, Sep 24, 2025 at 01:28:31PM -0400, Ben Knoble wrote:
> > * merge parent numbers are 2-based (sanity of this statement is
> >   already questionable).  If HEAD is a merge, HEAD~2 is the
> >   "(first) side branch that was merged", HEAD~3 is the "(second)
> >   side brnach that was merged (in an octopus merge), and so on.
> 
> HEAD^2, 3, etc., rather? :)

Probably. I also always regarded this as the nth parent, not the nth
merge parent. HEAD^1 returns the first parent even for non-merges,
HEAD^2 the second and so on. So I'd claim these are also 1-based.

Patrick
