Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FD23C507
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424426; cv=none; b=jNPZJQJjW6LQarcAFXXaEjhBqV+lhmWLSyvfgWYRDFvsdA+4zPpNFHwGPMgmtESgOyng3XefCvlPWXIVWghfClKsyshqEfZuE5vfgz2SlZP+c/1pVQ7/T3ooHZ3lPHcTVt91mfAXmBjo3mg9eHmexDtbiIXczBo1BnJjyJMvA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424426; c=relaxed/simple;
	bh=RFsfLTfDchpXs70maa6zMtL0vKyqbwS+WB0QwFXFFeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZH/TbyS+eQPTq+4yC8psOayDAVQ+6ZvbmSi5F2z2cKIk1y9mniMyljFhx+RQTedtZkJB8K8db40i42khOUqHS/xD5iL8rWtNGIYXWEkUI59rTyZiKujdBbXNnJwIzKyuVrtwnce2GwjO/GogOYFZeMDwDtWXSAuotbtbLcf+i+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KnvWKztk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbQPybI1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KnvWKztk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbQPybI1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 351801D001DB;
	Thu, 28 Aug 2025 19:40:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 19:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756424423; x=1756510823; bh=rY3hYNZXjl
	FBOJc/QKFeVPNi9e02Su1pr70zb1NCFrw=; b=KnvWKztkEZE+k9UnaeZLFGvjMC
	wIKZ9NvG8CvsW+oRnIVq8aYSWMsfcjv2IdbSTjX2Lh1Y1DHFrTjTfgfLcxFoRZK9
	a1n6xMfvcmV30iBA28ACO03ObjNOb7SfXatC5B7EGSiOtcLToFaWNH3U51R4VCpA
	O/mifo2R+IeZ6lLGy8tiBu7aDkGrCJW7FSzZXkLe6OA9VkvlKgbVn8ENb1vuhwM/
	j8ghbYMCUp8JK/NaOsPPZoQ4iYghKAq7uftLqZQRaYSUpvCmY6R5aJnVtRsXB3MS
	fd0mbBSzirQ7xcQOHmsBZK4k6JhiGvGIfpoQuxod2EtHjnYCH/9iXlsIrWcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756424423; x=1756510823; bh=rY3hYNZXjlFBOJc/QKFeVPNi9e02Su1pr70
	zb1NCFrw=; b=FbQPybI1/qfU8lBrsz6KjuZmSM30Rf2+/Pv2weUrGgZtbgnq4Jv
	8DuyLTLjMQDxL1AeSfmnFHfhWuvSXgoBo8kBFlKh1YYwWtMQe6YvOknZKxP6lyID
	YsUHVk5fymCx0HMVafhS6Vlmq6gH+daKwKceUiEK7Beq/UPIn0Cfg3exAt4to43p
	TKyx0QmERMitcWTBwi/4blhvsT1WdESJ7j+BdiA94sl0OrnCeGUU+WbSCDU2+ayU
	pPIbNbV+bXt3x/BcaIujA5zwPWquHfR433pHx2H4g/cQ4lT/VbDFtLe95OmrzpBw
	dkXiZyJhJFX9X4v5MAn+O2NI78TWCTv2Row==
X-ME-Sender: <xms:5uiwaImRIjagXZj5COGiZq-V1YbwLqCNqSdqmqSA9v9P7Axbk_gYNA>
    <xme:5uiwaE_K2kiCPoVcv7mQOMoIOPmM_3qjQbHrYNbQT9K3sQqcf3ML3Fk9wf-kOkwxF
    dnDNSo24nHcI4ciaw>
X-ME-Received: <xmr:5uiwaFp3u51lUmHgnIfefxavCR4j5uZsRQHJx9dtz51mme0HCzGisYyhBccEVnT1-ZO3ozOb25y0k5viUN4qBktWiFtMqr7vQXoZJCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmohhnrghkohhvsehishhprhgrshdrrhhupdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegviigvkh
    hivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:5uiwaFn1Pf_DPAy7ca-4xYrERXo91DgNN_o423EBP62F7cO7cPJ3ew>
    <xmx:5uiwaEiuTKtyg__hJOV-Mt03Xz4Lf2YZKe7hibSxE97eBKt5KE1XCA>
    <xmx:5uiwaFc_XjfrYA0gIG64_fhgBCMFmLbCu0B5pv5oCX7Zpp24oT7xTA>
    <xmx:5uiwaMiRKvpF5BpewE1WFy0iwwCfOrfG8JBQp7AzILrGsVkzR1pkPA>
    <xmx:5-iwaC6uOfLqhrXVo7TomVYDZdJr3xsQRY7wwAharN9t4ix1zzxDBZC9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:40:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
In-Reply-To: <43459416-ced2-d551-40e3-6db594ca4520@ispras.ru> (Alexander
	Monakov's message of "Mon, 28 Jul 2025 23:25:07 +0300 (MSK)")
References: <20250728190520.10962-1-amonakov@ispras.ru>
	<xmqqa54oun5w.fsf@gitster.g>
	<43459416-ced2-d551-40e3-6db594ca4520@ispras.ru>
Date: Thu, 28 Aug 2025 16:40:21 -0700
Message-ID: <xmqqecsvqal6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Monakov <amonakov@ispras.ru> writes:

>> Using xxhash() was merely a sample code path for technology
>> demonstration, so the Rust adoption topic may want to pick a
>> different code path to do its thing.
>
> My interest here is just speeding up xdiff in C, is that a welcome topic?

It seems that the (side) discussion on the performance has
concluded, and Ezekiel's new iteration of the Rust thing moved to a
non-overlapping part of the system, so I do not see any reason to
keep this topic out of 'next'.

Is everybody OK for me to mark the topic for 'next' soonish?  Any
objections I overlooked?

Thanks.
