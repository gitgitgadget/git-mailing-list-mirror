Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC03D2FFB
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027451; cv=none; b=JfKAJIpVZS0WeLFvi5yfZmHk9SoZ1EqVQAt/yQHU++DgVvWfvYLgY7yFJDLyJkrfw+/qfWbkHkvK9K7aJV3/tnsW7rclfEa1E5h9utz4jj+RhAHxb8wG8nD+sfk0Pz/bQyRkxI7D2YIpxnmsVgPQWS7eL3uPAuHZEOBvWHj67G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027451; c=relaxed/simple;
	bh=mzLdShdnspxZKSDG653XQtppgwf8RSC3hOtSRTb2iI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpfAn22ZhNcYraouWWS48u5W6SY7REfKHUargbtxIGmA7mrHIF6BYrlbweGnPTzfoB1vxuGQwgL8f1Va0uziSjwqMwWndAYGn5wxrI8l0Co1s93S5YJs2Tt/ozyWDP4ICCONGSabL/LpkI5DPlG0DIPllmMNMX67GZXJGnbNxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C2Sr23W6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ct8/T7q7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C2Sr23W6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ct8/T7q7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A9A61D0010B;
	Fri, 20 Mar 2026 13:24:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 13:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774027447; x=1774113847; bh=tWfyHiqCCd
	2bNazTVu+W3z/jMYGQwIpIlPA4RQL4OXM=; b=C2Sr23W6kXe0rzX2DTKNsQy6SE
	aXW7qoRFHtPP+nsfjfzie9lY/wj+id0AtBmw+3qA/z2qAdc95nAS+rENwT51zXfr
	HlU0wIJvMxQmKVA4TyyEINtemR0/73djS3QHXvECO68aXdU6UkxhzNjA9ZzBFPzz
	iiYPjkuT2+1qcfHB1maW8/nPHHqERTIQkkTtVCmlYDyxrEj5fUloRfa+tzFCcfuC
	RMPBs/cJ9kiFWYgoxttBdFCWRqO4Xynbbqq5bvMPK0q9SQA/TevrvGoILoSdxe8n
	mMESIPVmW03WMZGtWM7ByizOyYeTwgmh5rY0sErn9gEj9PYZsc4tpzzLpgkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774027447; x=1774113847; bh=tWfyHiqCCd2bNazTVu+W3z/jMYGQwIpIlPA
	4RQL4OXM=; b=Ct8/T7q7y19YXZn+Vse2ms9sK2ryrQgpZ0EDtdroDwPqIqX92SP
	DBMERpTa6+9xe4GzmRaBbLcbJ7y8mgoJnfSsAlK48LRw06aqRJ8uxHTbJ0yHStZn
	7Jmd5gpaTbfUMHRqze6mpEPfqyovf9+ko1pOUqpUU/iaMGPqR+8IlCS6ZT5L/Tgi
	/jHZaF40BTAkRWo+IFabxs+CaHU5CcDmA39GOvLjh2A5w2dc8HxQ4RK9KicwAvET
	qLBq6TTRIEkmopwRaolXDqsCpGJEL7wc+2SUB7zhlVBxobBZCEU05BfYff/LALqw
	oMgt1t5NTESm+XrH2sd5p591CBb47Wj41xQ==
X-ME-Sender: <xms:t4K9aQGh61g-xGoOTg6Uxnrd_ZtY4wlUuJJLGj6JVmVc2jk58SWwWA>
    <xme:t4K9ab5Tmgx3wksdanLYXmeRB6eS1PtB_n09oMvU7BRjxuAiwc3_jxNAIMtZDN17Q
    _3-rUuy79ibZhtqpDXgBxzJDxUvvtCkihBvKHgrxMZoEnUgLLHDWQ>
X-ME-Received: <xmr:t4K9adwwOIPR1IDQy1reWFUhBuY2CHSI4HQ8liKWOfquP6NE9UoOr8OzrCgN0GTZyWvMo4BVycKtDFjqbBzkkFTUlbJoRGVFjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:t4K9aSMrLzskzKVCTl3ucvC3xP-dfgCRxf3onSc4L8GTlhFbHrEZUQ>
    <xmx:t4K9abn_mjM_5eF1mTv474nfXLQeF9hxmejegYul5tQh9Bt3bBZfiw>
    <xmx:t4K9afTN7Hj8AdIQDUSJiVrekPTcFZ1JuOwHHCbU7iJBOWz1YOWCQg>
    <xmx:t4K9aSXl03s7bxEGLdLIMASvMIy89n39JUo_rplJoU6GppCxbcmULA>
    <xmx:t4K9aRwMaoJNOHHeHgVau7ebzHJEjX-JKd3EJlHYZrz6zF9yk6r-6V38>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 13:24:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 0/9] Run hooks in parallel
In-Reply-To: <20260320135311.331463-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Fri, 20 Mar 2026 15:53:02 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260320135311.331463-1-adrian.ratiu@collabora.com>
Date: Fri, 20 Mar 2026 10:24:06 -0700
Message-ID: <xmqqtsuae7nt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Range-diff v3 -> v4:
>  1:  6686d92867 =  1:  ec274c24e5 repository: fix repo_init() memleak due to missing _clear()

This one is not included in the set.  This cover letter identifies
itself as [0/9], but the range-diff implies it should have 10
patches.

Curious.

In the meantime, let me resurrect the corresponding patch from the
previous, trusting that range-diff deems them identical.

