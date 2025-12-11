Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC60272803
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430605; cv=none; b=VzvB3s+3Jf8zrw4mv+lBC9D+wzzZivDAA+5uKYn8CUI6T9xK5gOjx77U9w3ZJT/THWLAbcBdjSPGKGLm8qp1tjbT7gzdUBdpEEG6eRWZmmH7bQmwVq95nGAfu7pwzdfw7cpQK5XvF3iaA5L0BLy+fwWfSqDqz0cXSGvHgl7PjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430605; c=relaxed/simple;
	bh=TdS5Czqv3u893iPRPGNWIgkyKB2K+a+j9UtuU4h5X8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLBjRaoffzl3mhF7zuNx+ng6Z+e5N3MFd/juE6ZNmTkTK5kosYkUohd6Xesms1zi7/0H57ce6/4bbkrU2C1kaRmDEQA9xNa67TKUope33H6NM9HFPPmucqZSaAD71Gc6qAPEPSG/hqmVwmmWzn+aNL5LgFdJ+Zm88UsUo6wWzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jOojOqLQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vepg7mQs; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jOojOqLQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vepg7mQs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D7047A0091;
	Thu, 11 Dec 2025 00:23:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 11 Dec 2025 00:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765430602; x=1765517002; bh=0NNcibbLMM
	djAdrcSYXz/65CeahJcAZbP7CLhj/i2iQ=; b=jOojOqLQ1w6s+Ui1SKBErJ+yxD
	WqBkN95m+/J2wYrXcxFqW8O3k+CEYhlYPWGYakSb0GImjFwQHxdcye7qggfSMz4U
	aEPDNI3qCu0DsfxwlZFWtmdtiAtGPwDH/ftgmxDsdGRlKBQDnYOCws0kkk0KgM++
	Wf1RLJTOa819OxWuXlu0Kib3StxKUpVxo6JCX9FAPy3fs3vGJgjVnk5slHw02Rqf
	mekFZ8juudGbQk6nFV7rOo9ohWmDdirYfiULsLjdAfgF2khARdmcsJZwFJEQ6RNT
	coVpvNdp3r+5zA6YfDIj25jEtwgNp1wTr0U44bSQls4XRil1FnbAPWV8RhZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765430602; x=1765517002; bh=0NNcibbLMMdjAdrcSYXz/65CeahJcAZbP7C
	Lhj/i2iQ=; b=vepg7mQsWJ+tMhDty/Sk8J0DKVQHR7Fb9Pyw8jFQtSvX4qlzBSx
	Zf4YlW1NvL9WJwnf2VjVV2QEQP7n273x9kAjRjkXl7qLFbMOTAuwn1rTpUqjA+OY
	GveBgvBdM4N6UMbpTpHYPsKpirWV2wGvvR7G5GDP9cZ43tExvY7uDbzATDbTPxBr
	GEvOn6UrGDhptZI8xavAQgLKXawo2tZpmHhmLSrGwYhbl5T4MORZB+fflB4Xl3EX
	i9TCnF+qciCedDbHlkQCHLyXgV48y3WAEyd2CwvIn/uniJGwCs3yZ6cjMfOPXdfc
	AyDPd42xquD8nv+6AGSPgSEEPqE4OTHH/hQ==
X-ME-Sender: <xms:SlU6acdB7130VdjjC-naMcGk5R_THmM-Z_jWm8UIPOY2S4YqITzt1Q>
    <xme:SlU6aVGymESS5JDQSNSyi7VcLgWs66ITqOusGXnmM5Tf6G7LE5TVZugLaB0PJd1ex
    ke20pL-bbzkzeWjLSbIfVZVi1ZxrLwpJ8DEVWrnlNjlDYjk8Z5D5w>
X-ME-Received: <xmr:SlU6aV1F96hXQE2nHcNv4EY7Zqa9wo1uH9igipFx8SzoQy477Ma1UF8KSvLKTgCrdSXRRploSZ6P7YvS9f5Nh98m9_xqadK1HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SlU6adlA9zYJPrlWYOjt_ik6rijo1ZHICW14jju8KrESc1LCPt-EWg>
    <xmx:SlU6aV9Pq7ZrJBHIGjacm8KkRNrheaGQGJbkOxCz4sRMhRI_3V8Idg>
    <xmx:SlU6aSp_0EHncnmrxyzfvH_SROkMWC5uYDRxP08zwO8v058GH0ajHg>
    <xmx:SlU6aeko91SL_LNEmpcp1aXEiHapFV2dZ96eK1qc085tg57D4q5enw>
    <xmx:SlU6aU3M5LybjARV9IKAyUlbEgPMz-hU8LQhou7sK24coAZ3tNC7AoqK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 00:23:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v2 3/3] repo: add -z as an alias for --format=nul to
 git-repo-structure
In-Reply-To: <20251204210843.79411-4-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 4 Dec 2025 17:10:12 -0300")
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
	<20251204210843.79411-1-lucasseikioshiro@gmail.com>
	<20251204210843.79411-4-lucasseikioshiro@gmail.com>
Date: Thu, 11 Dec 2025 14:23:20 +0900
Message-ID: <xmqqh5txfv7b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 36a71a144e..df7d4ea524 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -101,6 +101,13 @@ test_expect_success 'keyvalue and nul format' '
>  		tr "\n=" "\0\n" <expect >expect_nul &&
>  		git repo structure --format=nul >out 2>err &&
> +		test_cmp expect_nul out &&
> +		test_line_count = 0 err &&

Not limited to this step, but I have a couple of comments.

 * Instead of munging the expected file so that it contains a NUL,
   and compare the actual output with it, munge the NUL terminated
   outout to make it text and compare with the expected file in text
   format.  This matters when tests start to fail as test_cmp will
   show the "diff" output when it fails, and comparing NUL
   terminated files, which are "binary" in the eyes of the "diff"
   utility.

 * I see your -z output is "<key> LF <value> NUL", but was there a
   particular reason why "<key> NUL <value> NUL" was not chosen?
   Unless there is a compelling reason not to, it would be a lot
   more future-proof to use NUL for both, primarily because it would
   allow future developers to include arbitrary non-NUL bytes in the
   <key> part in the future (and we wouldn't know what end-user
   controlled substring they may want to add).

> +
> +		# "-z", as a synonym to "--format=nul", participates in the
> +		# usual "last one wins" rule.
> +		git repo structure --format=table -z >out 2>err &&
> +
>  		test_cmp expect_nul out &&
>  		test_line_count = 0 err
>  	)
