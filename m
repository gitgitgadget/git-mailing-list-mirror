Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92E1C303A
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391668; cv=none; b=SLHb/YnMaIaLZ+L63y2jBv+YQgsojbN6HHZie6poia2WprL/4fqI9vBmAVPzG8IQ8kHhor5xwJImgHyzWLU44VFU6be/WLrqi5M6lTl3U75/tcqeyDO0O0KmUuwmTaV/YkcZEQRJ1BPzpDZyclcdGYdSxuB75EUltMWfV+2qlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391668; c=relaxed/simple;
	bh=3YiF9+c7fPCKzTDj7xzU+6k65QZEYZkz8eIHt5F+fZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYFunwQGdDJrBnVqAc18K27onNTkcpthwnAaZ/rflRBWTBS5zsunvJL+BhC4Mwec1+ZahKyVienOliIdvxdDfL7G6ic5rYu/eq6TmHEFqnRObuY1KucFKWEFNvYsH/o9g1S1N/tv855NA+T+enCa4f3tKE+JLSdmkrNigculIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cq/WciR/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amc12MyB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cq/WciR/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amc12MyB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 19E1811400A4;
	Tue, 12 Nov 2024 01:07:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 01:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731391664; x=1731478064; bh=bp6k1ykxyT
	ta1dW3GKIDk35uraliYILkogQCDTYjjts=; b=cq/WciR/3cY9k2+s1nB2sN+Xvc
	AKkd6D5aA+L9i2UenbB1VYFgUwD+7lhiOliIwH7KIH8FmK3b9sEBc09pwLhvJ7rz
	v6xOVkUhtE/tLuMAvc3OkMTkAEl8nrHvCpppLhIoqWTJ/ep/cvnATSaReR61kC6K
	P1I5eQyrW7y8rgBQjZEhUbJ8nrOt0pTAGX/qJHMlKPaYZXJYFBqfh9YLhTJKgFQ/
	b23c1UwqOYhfNAsVfW4OWxofPb+BTxvahgS3Qo+zKpttlHtQc0lsxdNJeKmGxhf3
	VQYF4jP1CSMXrl8XvW3zWslN7kGkGTAwPZVwBMG0xpfVp7IHvkM4O1YkgUeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731391664; x=1731478064; bh=bp6k1ykxyTta1dW3GKIDk35uraliYILkogQ
	CDTYjjts=; b=amc12MyBWuybJ7ysxQ/eyyUvSeCo2Wl57QfgfHVuqUNr8FjjuwF
	zIgSaeLLML8UWSSoH3iKE6VQKT4DLTLh9RequbfqiaTtzFDzWuPhmgReSclrkaT1
	izEQndfZxXa0p/88fWukwOEb7P9Ir+JLIUCRwWi+W0VwiaWEpgvK4jOSpCxqu+ZF
	0ojhhjL+TxiO/bxUMyACh7p8od/TrNsYe72u4uloUgx1VdoaDbKQ4f3SlxnEq+tr
	QlJeCeRuCqnSBlFTGpxRpqTwPMPtx43SAA5ZJRV2FoldNPMI2AU5ma/7GpiN/c8s
	DYGEeJR9PTbvoznJrjAyrFKYgmFmq9U2j9Q==
X-ME-Sender: <xms:sPAyZ1CbsDriB8TLKaij2xLm7ZSWjTKOh6XETsQCaYVROdAcjJr84Q>
    <xme:sPAyZzgdcn7zHAWBUP0rksPDUQQAgyD_TMXwJQM5r_vRchVIMCGTp2oWMGF-zOXss
    somXLpYGaQ5uQ5tTg>
X-ME-Received: <xmr:sPAyZwkZ19MlcOp6pnOr1I5yoPNDFAzxWLVu67Hgia1xcKs_hz1awAzyyyb__XtZBuwOi4CbCWKl7QRciSpayyLYnCT1zvZ2f_0v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sPAyZ_wqQ5qy-TSCgGlripDYQxzYl5AvcsD_FM9VXMHxIdOhynT_Cg>
    <xmx:sPAyZ6R5y2ug3c5Jxv5jCA-NWsKOs5nfN3mQdBaLL0YuszhqC-yMYQ>
    <xmx:sPAyZya_ApEKC4qH2jrVTOXO5-mbKz0kqliHiXno8Pu5pvd5h_esXA>
    <xmx:sPAyZ7QYjdNzgW5jsnI7UDhnFPD80fV3AowRiHmx_s4salC0e_QS_A>
    <xmx:sPAyZ4ejOYYPXd2DU81IYIXc0OsiKLmz5K_7dFE7Qh6j1Lf2ZOKfFKq7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 01:07:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/8] refs/reftable: encapsulate reftable stack
In-Reply-To: <ac01c06c4177d1b07678972115648d125c2bdc66.1730792627.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 5 Nov 2024 10:11:59 +0100")
References: <cover.1730732881.git.ps@pks.im> <cover.1730792627.git.ps@pks.im>
	<ac01c06c4177d1b07678972115648d125c2bdc66.1730792627.git.ps@pks.im>
Date: Tue, 12 Nov 2024 15:07:43 +0900
Message-ID: <xmqqcyj16l3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static void reftable_backend_release(struct reftable_backend *be)
> +{
> +	reftable_stack_destroy(be->stack);
> +	be->stack = NULL;
> +}

OK, this turned out to be the required reading for the remainder of
the patch ;-).  Everything else was pretty much a mechanical
replacement from reftable_stack to reftable_backend, but to get rid
of the latter, we need to do this _release() thing where we used to
do the _destroy on a bare reftable_stack instance.

Looking good and understandable.
