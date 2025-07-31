Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D79A2D
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753920267; cv=none; b=Juoaf8yM/0SArkRLn3tgYh2gUTHvCi3D9P3oBFaGeiejZAcAKyWeQNheFv2z7wfLly1t/Mk7ysm4eOob5dZ8yocBVsShRC1sVQKO8DjgX5wOP2MEzP/hcMsxgqrjThHWyxd9Fby5BuoyIcsEj7T4lk+t4nilgnMtQkPsP7TrfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753920267; c=relaxed/simple;
	bh=R/JM21zUOxofU6J3laOO6Ml/1u1vJY18GG9izHAlAXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V/7qaza6utUQyJHmueZn/YXksBV6Mr2tRtXgBRfDsMNE+fyZMBHrwusC8a05W7IY8R1NZ1UinH9znmfTpOTktidSL1pBgg7Oo0RbLIHQIgfd91N8UNDYB2hieegryJH2b6IBw89y0HIihte2EmUw4df26lCViFcM5uJF2bWaLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vs2R7Db2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bez/Jpka; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vs2R7Db2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bez/Jpka"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B67F5EC11E1;
	Wed, 30 Jul 2025 20:04:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 20:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753920263; x=1754006663; bh=AnMJDmG+Tf
	hqrUzTAAzQbjPUii3ugN/d+5ofhE9rnk4=; b=Vs2R7Db2lBL6e4/NQGY9c8JSzT
	pBBCcwq+k3+1mvJQRu7YF0yqy/ccbcDlgxUwWzSFEWW6l3E+fhaelByrvqgmeDAu
	K+N9SDMDbUuzfQdW0KRk792K6F/pbVEnEDLWajt3miN3/RinUOQjovqI0C6BNVLM
	cqxuwa+PUsUO31wm1ZhGeGExd7sD69KRgYQDYiu0Bc9Fq8YBec0xrBsp5z/5Fjpw
	0AbZezqzufqQKouszMuLS9c1dEbHvCOUUKQ+IJ98pypzNlJzagkTtZDHpPPAohck
	xgod+KKUq3RVubdaWFemvnxlJJzafakV0/T5xzMKCe4OZ9DTbMplDFQPYE6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753920263; x=1754006663; bh=AnMJDmG+TfhqrUzTAAzQbjPUii3ugN/d+5o
	fhE9rnk4=; b=bez/JpkaimIfdmE71juPZmDNq+VYkmZkkAT6R+L98ZweRXKciZ9
	qjpEy/gXUL4j/hMLcN3H/nM4MBOZGQopp6UDxTQHN3PnQ2T9nWO4eDKQSfCFXMso
	119EGCN5ePnc0wlMaYJiOLUb10Yv25sv6t1mr5oUTFxny+D9waRtiSq2b+AI5KO4
	MCU+K7MYkxdIQQpI+7X9waOBi+SZ4J8EbZdC8/EyAy/QTO3KoB3n1sALu8yqnryH
	D7SZQFAh5u1aRmWDxQW30XdyJppuc8i437BJvZe0XAKltxMpKb5o4U+r9udV0M5e
	fjn7elIIDgei5v3WUvQs2TvVFTlTv1aj/Zg==
X-ME-Sender: <xms:B7OKaNsU2F4oD48SJC_pzQN717neMTCVF7KPwRT9xR0K8HUfvypEFQ>
    <xme:B7OKaEB_5ZNSxsIcLho_I3JSBZwtRQrzEM78ByFitns-MDcwMw41v3O44dXFBylV2
    9rvQjyl0n0dnxd7Og>
X-ME-Received: <xmr:B7OKaHMcuoZM_AhZiAyebK8iuhfOwwIupwWk1Ll3BhWUNTNzIZ46Ekmk6K2RKrPZ6SfZGkVkaXKy7T2FYI9DcjfY4x3pIQcqgy5wnAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelleefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjiehtsehk
    uggsghdrohhrghdprhgtphhtthhopehmlhgvvhgvuggrhhhlsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:B7OKaFxDhs7_0HWszk0y6HMpM7ephXPww1yFEinzb0bnFKgC3WmhLw>
    <xmx:B7OKaPW1zML2xJGv-q2Rx91ZrsAsjEtzNwoiQ3SabgXcMOBKPwjJpg>
    <xmx:B7OKaPPyWYRw8MblQocYU-PqiSeFaZkMTZqzuzH3UZMcrkT8Ofjs_Q>
    <xmx:B7OKaJC-_2ryNCzkTNeElSVoRpISmRfAhrNzRHP_WfYqEqFeAFLaHg>
    <xmx:B7OKaGhSw4lbDeMgqKfCMC6wukYiRVL9vgjGwCpvyLGNZ1TRBnvPjL5R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 20:04:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Arenas <carenas@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Mark Levedahl
 <mlevedahl@gmail.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in macOS
In-Reply-To: <CAPUEspiP+Xoz_W-X4QrStAFS1BqSF4pws7d6dxaf6m0OeLtM_w@mail.gmail.com>
	(Carlo Arenas's message of "Wed, 30 Jul 2025 13:51:49 -0700")
References: <20250730164052.15371-1-carenas@gmail.com>
	<xmqqtt2tl9yw.fsf@gitster.g>
	<CAPUEspiP+Xoz_W-X4QrStAFS1BqSF4pws7d6dxaf6m0OeLtM_w@mail.gmail.com>
Date: Wed, 30 Jul 2025 17:04:21 -0700
Message-ID: <xmqqseidted6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlo Arenas <carenas@gmail.com> writes:

> Not sure I understand the question, but "upgrading" is not the problem.

What I read from your description tells us that "upgrading" Tcl/Tk
beyond the version that is given as part of "Framework" *is* a huge
problem for end-users.  That was exactly what I was trying to find
out.

Thanks.
