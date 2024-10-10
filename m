Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39301BC077
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596049; cv=none; b=V4khauLWE1TKFd4fDQTPX5G8iEKesTsn4vQqG1Gi0gzB3Jug9oj4DI+vsJvv2ywZ+sQqUA5KIJskGzIvcQ9RzoHfRjESu+bzZvN+3vNszpktHdUUbV73nwQODjzHA+y75y8TY5xkuQSo86aCssZJkeCtFB5hI6/twzbkeXI70sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596049; c=relaxed/simple;
	bh=jOufIG0mZzLdQSuJIt/iGvVT/rmq7oRYNqE8NiF2fvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZoZKJI26c6soKVWVuWqIQ23suEMIFi5CffJwHX9jzZ9V4WfOsBXxmHz+P9jJz9ESDjtucQQRAYaPDnF5LNs1osFAmucvubaVHI2nVIkj2Vf6cvG6pTf4yUCKNUGflr43vrNhhlYvw1EHqBrrY2NrDSS7Cy4+kuWq6NQW3/ba3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CEf3ZjUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aDpPRE8w; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CEf3ZjUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDpPRE8w"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E80D01140180;
	Thu, 10 Oct 2024 17:34:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 10 Oct 2024 17:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728596045; x=1728682445; bh=q4XWc4EEDI
	CeSKDNs0img/fN9HWHwnIqSEjgCfuB1Mw=; b=CEf3ZjUBtTUY8VcGutwTUWkg0G
	Cb8nWTPsI1a/3XbPqZ/73jc4BJECTzunBUgp2Z2u7TD5vR41rChIp/uzoAEhSfi3
	T5VfLdKDFYHbzLXHFblg4RROX/5vc4LOeNfvzYBzjDRRfROJNg4m6HbcnDN5wPZL
	QChU7tzo2laf9+oyC9/zDzy3+oR8cRYLeKtopbbxIpe3sOXAFTsVZSy4jUWB7QZW
	t3T9f2DP25xZg3+pxZT7+gI5PDuLodY2zdQR8caDNd02BRc7BmLvVthkAw7DwUEH
	ZNviqlJNMtn0R+3kjK0OsDaRZb0CLfqI/uViBi/kwppdG6NF0F88jlqgrqDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728596045; x=1728682445; bh=q4XWc4EEDICeSKDNs0img/fN9HWH
	wnIqSEjgCfuB1Mw=; b=aDpPRE8wTgeomDC3LSTh2Mhw9x3jMrkgcSF9IL0bztYp
	itCrY3h8UaVsSBo1cdyn7ZvNkass6RezwWy9O+qRxbbU4blchGCr7ELDomwfRLMI
	yWWAnyDlcKiAc5zBTZV/l497BFdKr2lsS6eOQ8mJByEhDjaqcSOa1fGCHGIB80uO
	BYCax5Qyl8pqnJnkQ6EczFZOzR5SFHZynYTZfbVIuCJmwSTwH+Yciq+wKtXKl9/d
	608L3gCym4YNcpYDcyGYUN13vmvd8uR+RCa9BxHB0NaChaURounU6Qbrehl3ZA3B
	cV2egIvbtP7KcsNfCSJXoGhN5znB2KKQO75cJaJ1jQ==
X-ME-Sender: <xms:TUgIZ7T1UOhCI-plkeAbnFuocyS6m9yab8VdmnMTOYkl9kJj0bZS4A>
    <xme:TUgIZ8xxHokuI61KdNnRMp6v7xGL6FX_yTnTFh5xHJdN-QP7QUe_l3M-vwEK0VD0X
    cxsZDn3mnOBpNuqUg>
X-ME-Received: <xmr:TUgIZw0UpIPqYie50V7waLc1Z6P_nw_anP13GcdtgOC1HjVJQ_mNzVksmIfEIAW3WONMYzMHMSFS3qKx22zNmOqtQKvuc5QoNOz1g34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    hffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujf
    grmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghr
    nhepgeeuheelveevleffkeeghedvhfevfeekuddujeehheegkeetueetueefgfduheefne
    cuffhomhgrihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughm
    ohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvghrihgtrdhsvghsthgvrhhhvghnnhesgieguddqughs
    vggtrdguvgdprhgtphhtthhopehjrghrlhhosgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TUgIZ7Cjv30ttZV4fKdyGP-xGohkT5eB9MdZfE0R6sqnVsxybqQ2xg>
    <xmx:TUgIZ0iWLHqyLX6naKwMF1dISzVUE5W7aa2NHMgmZozwLlwal6PcmQ>
    <xmx:TUgIZ_pIR482O4EnFokA1BKSpZK6QtGPuTwSJqHJm1lgdwDZWDMLdg>
    <xmx:TUgIZ_g_AJIAWpsSrJ3BoqKtrZpXbUiW9thtFQSG4TP9oAr2B_6U9g>
    <xmx:TUgIZ-bFxA5yGnk7bHlht8sTW3gSJo2uN_S4apeFed1Cww5ltgJj7w1k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 17:34:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  eric.sesterhenn@x41-dsec.de,  jarlob@gmail.com
Subject: Re: [PATCH 0/3] fuzz: port OSS-Fuzz tests back to Git
In-Reply-To: <cover.1728594659.git.steadmon@google.com> (Josh Steadmon's
	message of "Thu, 10 Oct 2024 14:11:52 -0700")
References: <cover.1728594659.git.steadmon@google.com>
Date: Thu, 10 Oct 2024 14:34:03 -0700
Message-ID: <xmqq4j5jk5h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> Git's fuzz tests are run continuously as part of OSS-Fuzz [1]. Several
> additional fuzz tests have been contributed directly to OSS-Fuzz;
> however, these tests are vulnerable to bitrot because they are not built
> during Git's CI runs, and thus breaking changes are much less likely to
> be noticed by Git contributors.
>
> OSS-Fuzz's recommended setup is for tests to live in the repository of
> the code they test and to be built along with other tests [1].
>
> Port some of these tests back to the Git project, so that they can be
> built and tested during our normal development workflow and CI, and as
> such avoid future bitrot.
>
> [1] https://google.github.io/oss-fuzz/advanced-topics/ideal-integration/

Thanks!  Very much appreciated.

> Eric Sesterhenn (3):
>   fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz
>   fuzz: port fuzz-parse-attr-line from OSS-Fuzz
>   fuzz: port fuzz-url-decode-mem from OSS-Fuzz
>
>  Makefile                                   |  3 ++
>  attr.c                                     | 38 +------------------
>  attr.h                                     | 43 ++++++++++++++++++++++
>  ci/run-build-and-minimal-fuzzers.sh        | 15 +++++++-
>  oss-fuzz/.gitignore                        |  3 ++
>  oss-fuzz/fuzz-credential-from-url-gently.c | 32 ++++++++++++++++
>  oss-fuzz/fuzz-parse-attr-line.c            | 39 ++++++++++++++++++++
>  oss-fuzz/fuzz-url-decode-mem.c             | 43 ++++++++++++++++++++++
>  8 files changed, 177 insertions(+), 39 deletions(-)
>  create mode 100644 oss-fuzz/fuzz-credential-from-url-gently.c
>  create mode 100644 oss-fuzz/fuzz-parse-attr-line.c
>  create mode 100644 oss-fuzz/fuzz-url-decode-mem.c
>
>
> base-commit: 159f2d50e75c17382c9f4eb7cbda671a6fa612d1
