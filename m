Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B61DF258
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685191; cv=none; b=oPbYnk1TDzTGMFmYHc2a7b9HcFFFupRwNrH2f6q8GjJNHhaGQ4LoFcJ7nt+RjRiE9UwKxyX/3jS97Vka3zRWjsFI95VyvEIpPaPQ5Yk6chnba1q4epWSVtl4kCPUXELXJ+V+DIlPh5Mx3ZQ67vZP5YQ/RUtmgQOuevip2VVo0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685191; c=relaxed/simple;
	bh=5riiKbzJizNNm9Jaju/tOg3OPryNjS2QDaxN+iO9lgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUK/LyDn4pbbhveiQh5gZFYXLjTEXahmlf1iBCw92JGFif8tkMY82wjH5AQkLnLz99yrITqqBCXoWR1WlWaAQfst41GLy5pEOTSVVOs4W84qFiVaiWXfB83+J/zlztwySNNHedscLcqzahG+4kT9mGAaTSCuL3Esik/xXQNhdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fQbifcyf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrlzA9Ua; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fQbifcyf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrlzA9Ua"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7D5E7A00E4;
	Fri,  8 Aug 2025 16:33:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 08 Aug 2025 16:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754685187; x=1754771587; bh=gy148WcEu1
	nyLKToF/y+R+5b6NbIGeBsdYl0cW/Bqrw=; b=fQbifcyfzlGw0RUp513DcRMtB5
	pyxFoLZgEcJP0qE+KDChbQ9D9aLRubWUkxa9DxLiTPPKL9uv4K7c3eEzrnbifU6L
	pSIxaMdQZ1ygErUA96gFnOiZgcc5dNrwnMKWf8FTuNdSEh8sjniwW7IDmZyKBI2H
	zV5phHT0opL/VvX4GdraAWbBxI4/xDvGAkpBwa/W5LnQ4h4Z6jwpEqGO/YOh8do5
	CEwgi1nRcnqvqXzbBEjU7mqB83jitiLhelHGzpmg+jD4TioJHzRgqSFfVC5tl9BA
	RcUAGi142OB+jLjIx+3VAM5bZMpK7CiMrA3eFaqawHtjxmyyp/TBch35I9Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754685187; x=1754771587; bh=gy148WcEu1nyLKToF/y+R+5b6NbIGeBsdYl
	0cW/Bqrw=; b=KrlzA9UaLPRP7b4+wi8XgFw9OWK3KE+Q4OcocuxoVqSeptoAE9g
	/Oduum5n0JIA4KvZPcKzSSxioTSlPtrphKbnCYKqXhVsV3EeFf3kp3Rb4sEPLCn/
	oBd12d/88VtE+Lg3dXi00carEu4ymLLqGYO06YzrweDvcuCWe0+fQiDZ9TPFwd93
	qkk/OgaT4m9sA52Rj4m7D/zjgY3SeAqPsTO/OD4fy8FoFKnewsjBLIjumfzcgXsl
	g+bJbyGdhlv07spRlCC9kc3FG8M8kz/5auh8XGSBOazN+O/4GwB7LcPcKgZ9EHBO
	TPvmTVDZ2uHRNAmyRowsdl9yIeCJcOvyQzg==
X-ME-Sender: <xms:A1-WaJmWUSoBZ6JhLvq_lx-b9I4zvoYkRfbYpPn4n5tSWS8alF7Hlg>
    <xme:A1-WaE8WqN_7B-rrJA-_sITaI6B7f2t9fBqvycMe6Oil4SPMazKa4ZdeH8RLcSRyP
    2hBx_R2KMvc-1R4AA>
X-ME-Received: <xmr:A1-WaHmDQ78uzfT1yDfgkPDwDe2Ii3AtbxH6hPYpETInwOMjStJRo4SjPQPxYEd6N5kgWGV5RN2cLeIeLVFn3onD-JpcJJCLmSFk_-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A1-WaB1xmJyUMVaFrFwhZS-xtoeRf_VfKQz_cA4SkUKUgLCPjfziIQ>
    <xmx:A1-WaCpFLn3PPOQwQNypn-pg46HYZcrIfSgIA9SX7xRFtUQmneZs1w>
    <xmx:A1-WaOc8r-ZK7P-IQmGXTqxIgISrXYVR7QG9liIaaCPf_CyUw1AtSw>
    <xmx:A1-WaBquic1xuwLgRU1xSA3MFVxdppobH5ffi7_2q71ZWMQvSb8uyg>
    <xmx:A1-WaDHYDCVz0iziqisBqUCnRygWG_jQ7FktBME_GbnYHRQqRXp13qWh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 16:33:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t6137-*.sh: fix test failure on cygwin
In-Reply-To: <5514f2fd-3307-42c8-97ac-bc2147a7ba41@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 8 Aug 2025 20:32:02 +0100")
References: <5514f2fd-3307-42c8-97ac-bc2147a7ba41@ramsayjones.plus.com>
Date: Fri, 08 Aug 2025 13:33:05 -0700
Message-ID: <xmqq8qjth7um.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> [Hmm, I have just noticed that the 'skip_all' message could drop the
> redundant 'skipping: ' at the beginning - oh well! ;) ]

Yeah, I see skip_all="# SKIP $skip_all" in test-lib.sh

Let me squash the following in, to further match the message we give
when the test environment fails a test prerequisite.

 t/t6137-pathspec-wildcards-literal.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/t/t6137-pathspec-wildcards-literal.sh w/t/t6137-pathspec-wildcards-literal.sh
index 17a03085ef..e582378181 100755
--- c/t/t6137-pathspec-wildcards-literal.sh
+++ w/t/t6137-pathspec-wildcards-literal.sh
@@ -4,7 +4,7 @@ test_description='test wildcards and literals with git add/commit (subshell styl
 . ./test-lib.sh
 
 test_have_prereq BSLASHPSPEC || {
-	skip_all='skipping: needs BSLASHPSPEC (backslashes in pathspecs)'
+	skip_all='missing BSLASHPSPEC (backslashes in pathspecs)'
 	test_done
 }
 



