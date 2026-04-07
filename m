Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682829E11D
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588857; cv=none; b=rI7DF+4Vu2sfuwFtyuLmvF6CK5aRKUlNm2kwJbE0TpPGo5tXh2RbaPYRL8H52hsfKF8sM7p4vydCy7usJLGuwZ28qygmBYA/KRaf/TacOzZGPts+IPDm8H9V9ig2YBGcZfu2k8s8XP4C68zcl3UfaV3LbtZlHTd1PoB48xMV7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588857; c=relaxed/simple;
	bh=Wabypph3MpLbTcdoeHnG99MqB1ijo3AwYIhX2ZJXj/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KrexivKu0Y7VSF1sVFMlWstY4cePFxUUhUF5WXODQLn5VCJdQs3FtSRpjo32Z0JCt6hd/oddxhhow7qnL2yXrjaf3zwRJAcCw71d84OX7nUpCGH+gm+j4PFk7Ayw1KMZrbEd6yc4lOUVtPyZwYbJFQ1PnCZJWquuB+alyvJhFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Olqg5ZoD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXV6Rfpm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Olqg5ZoD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXV6Rfpm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84184140014F;
	Tue,  7 Apr 2026 15:07:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 15:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775588854; x=1775675254; bh=DTazri9OY9
	Wc9hdYoL7a1c3NmRU7s9rkQ3TgvfUoy8c=; b=Olqg5ZoDI6eQQ/3Lq17Q9XAMkn
	WV0+m8bhNcCVm5TNfzBs1qxh4JSRSytKxxPi5/pW699Bzx92TqPs00LNSyH/7Sj9
	Q0R2FF5eJDX/Gdb56ZKaOTIjnV/dPeYVUMYWICMb4NYeK++7qKjPrw3JktHbrnrR
	a1GNiv3XYKlbWxgxYdcD3q8rhqVnk6Nmjh2az/b5iyXaZswC6eWFTq4rj57uieLz
	iXuExoAYy2wSCml/uwq7gOXiz4LmhhbZzan9qdndNI7RLqwDg5V2H+zbms8SSnPH
	O+4BuKeA4zlEkEymuv4xWVkTbULJ72VNj/8l5F986278NHTKh3GE/ViXx4yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775588854; x=1775675254; bh=DTazri9OY9Wc9hdYoL7a1c3NmRU7s9rkQ3T
	gvfUoy8c=; b=MXV6RfpmjIOS8N08zwTte2IAbTeLeWlhfCr9F8wzs5wWnyKuG+8
	7k+EEZef2gqYd/ac4plJ9ToZplsYsbZcNoTD2y8/XCLSV75YHtaUiD3gR9WQpv6A
	Rmr5z5XiPXIW9X0yfX3Tp8i9/xgdIytHUtmeQzdU1hvLuXy0rxhDYTBxfAszeBLp
	MIysHyKetuZ35EAd0gyP9bofi2rMt1kgUpk2dLFEgVf6QTmPdSauntA+UjbZIfrc
	l9jq//d3fpQc7Cv0vFsRzv1NerGWr2DQiKHEf5pAKKCU8tvpIeke0VqxVEiRHl+i
	2TmxRu7qbA0uaKJRsfOxCkzdpoJP6H9ooZg==
X-ME-Sender: <xms:9lXVafJtz2LJs0nE3_Le4jjHV8CQtgUgy2xKvp4_Y0RahGa190UJ2w>
    <xme:9lXVaW19op1z2Ikjat_45hfyptvKja95XgOlkDCZjdK5s6GkAkrM0wMHG0O0kG0XU
    -MzY59sdzmL6YxvXA724v4LljYaaWdvGl-mdehcJPyqOSxUFF5BXw>
X-ME-Received: <xmr:9lXVaRiwHoq4RE4oKNqvBZmo6A1OKJi4iey8_a0-mm22yBUslxkK7UMX-vcSJ4Z2g8fUa0NOciwWmPSu4QTO-6s5edaGZ68jgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehprghulhesphgruhhlthgrrhhjrghnrdgtoh
    hmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9lXVafX5U2sMYE4w38CXP1sZq-FHhGYVQ3OECI5VQEQtT_5sHTuiUw>
    <xmx:9lXVaYVapW8SBQ0IK-cId10U6KUBEPgyP_hJuMo5NgCqnf3c_u6Xhg>
    <xmx:9lXVaXgnh3DcTm9IR6hRppHgSgRaS9QQ_1yAFnr8ZrF-0ShLnVZBEA>
    <xmx:9lXVabYUqteJIEk7fRTK5H6diWuykMcZwhxML6WZ8MoPqPOENQEQZQ>
    <xmx:9lXVaSUE5YOb1b5s4VKgXtDQByTx7zmpDCXqcGKjjdPTE9tNbVBcRVEd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 15:07:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v13 01/13] t9210: disable GIT_TEST_SPLIT_INDEX for
 scalar clone tests
In-Reply-To: <28c5aca413dc0966df62a3d04f8ed76bdd9a5bf1.1775498098.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Mon, 06 Apr 2026 17:54:46
	+0000")
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<28c5aca413dc0966df62a3d04f8ed76bdd9a5bf1.1775498098.git.gitgitgadget@gmail.com>
Date: Tue, 07 Apr 2026 12:07:31 -0700
Message-ID: <xmqqika24mj0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> index.skipHash (Scalar default) and split-index are incompatible:
> the shared index gets a null OID when skipHash skips computing the
> hash, and the null OID causes the shared index to not be loaded on
> re-read.  This triggers a BUG assertion in fsmonitor when the
> fsmonitor_dirty bitmap references more entries than the (now empty)
> index has.
>
> Disable GIT_TEST_SPLIT_INDEX in the scalar clone tests that hit
> this, matching the existing workaround in test 16.
>
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  t/t9210-scalar.sh | 6 ++++++
>  1 file changed, 6 insertions(+)

The same treatment is needed for t9211, I suspect.

--- >8 ---
#!/bin/sh

export OPENSSL_SHA1_UNSAFE=YesPlease
export GIT_TEST_SPLIT_INDEX=yes
export GIT_TEST_FULL_IN_PACK_ARRAY=true
export GIT_TEST_OE_SIZE=10
export GIT_TEST_OE_DELTA_SIZE=5
export GIT_TEST_COMMIT_GRAPH=1
export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
export GIT_TEST_MULTI_PACK_INDEX=1
export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
export GIT_TEST_NO_WRITE_REV_INDEX=1
export GIT_TEST_CHECKOUT_WORKERS=2
export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1

make && cd t && sh t9211-*.sh
--- 8< ---
