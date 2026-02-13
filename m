Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B36CA6B
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003294; cv=none; b=jz18ueAx/ciyv9fnqRYkMLS4Km4FEXP6zEnbx7AKtXgaWfM3m2sLyl1dwqC7CF59Iwz60XxMQE+5GG0l5ohgrFYvm43hVY40j+tEudNfpdpSJXt2rPLG2QSwBCZUcXRH0JUcyJiDnKwGH2kSHcjqXUNII54rjLB7CnjpMLSNops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003294; c=relaxed/simple;
	bh=Mk6DpLIY1WBcJlNKLH2aqAHR5bYyjBnr8mXKRkA5bNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0toC3TljDlg2pfAHW9c51M493I9NCuUaFTSNiwp2hdheQVsrtDAYJPZMhYRhJp6TH3SfRNPxRl6dcuv5zdOJ4mET7cHf7utg6fgoJkfctt3WY1Mmv29gLQkteUGFgqdaaGmiFtZ+nA3K2gYViqQD+H02jOy7mPCIbG3E7Hxf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YhuAZ+id; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYwHUJSy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YhuAZ+id";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYwHUJSy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 82F9A7A012F;
	Fri, 13 Feb 2026 12:21:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 13 Feb 2026 12:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771003292; x=1771089692; bh=kaYzFUppR6
	toIMC7GXtKLJzj1/QOxnJH/lBANxVsgwk=; b=YhuAZ+idYqejOMWPRv4IrVzERz
	bKLLs0Tatu/Th50xRkOk/FdbGgrSuXJ18Bmb6gqOxWd7yrIole7XE6r7FRJlmK2K
	8dDljwiotpvUQSvu73VXDGaL6SwQtZvXGFqgqKw5uon3j1Ac+/e10Fq9eRq3xVtV
	88na/+qMrlk4W8Vswa5rPc1w+1835yMYebaGolJBgY6d6C9MUNYmtRulA5igV2W6
	WUZmljyMC9AKMZNJqihrY0V71C295vc6lodHmZXtYagP6VfRGyIhST0UhiGtv1ba
	ikFMLm8sVn8+y0uiMRlYBqUrlnWctXEPUlqrPxtDAE9bK3TSx9ZGneciUkVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771003292; x=1771089692; bh=kaYzFUppR6toIMC7GXtKLJzj1/QOxnJH/lB
	ANxVsgwk=; b=LYwHUJSyFTYV5rsC3gmp3WND49zx8ekA/K6FfkoFZF5ScG76fcs
	BFSF0kVNwNenSv5TI4Pw+KvOf5piI/7oiYE7ZNvLfU+c/Fm/ujby09iOTJ+KLAbT
	bqIAXRLq4uwYD0Ooru8eNHuSPuXEZsTbtPMVarcoaGKdCXF/0USO0zPwNxsVE/67
	oxlsBWD/ckUsggY/qF8O9iR2Dallo9z4F65Exe4j+o58Zcp2IfoaG1IiLoHxtz8A
	L1lX3g6JcBYkNc8mAi1X55J2x/zMSHzjpPIeOX2gmqY9QDWZ7vDm/8PpUziLpHrV
	q2Qc5a8xO3L+BAxugZcZZnqvt25UKJtRoCA==
X-ME-Sender: <xms:nF2PaQSQ8A0Y3MRHAMVsCH41fJ_ZRNOp6uS9pjT4RzZeHaUy3cTjUQ>
    <xme:nF2PaUyqr6_2a6t7V7rPxfJd2bKLn4UFmMT-UcWSKU3LVt1Vih9zvhQM_veFzIsFE
    b5LyrfS-ZpDoK_Es82zSh8gZ7iRppYYRMq8sVAHAyM5vgCHNcWUOA>
X-ME-Received: <xmr:nF2PaS3YxfRq9_mhCA2QkuLdtN-VVklsJNZSMM7VeOrSWwrFIsGq0kbF3mVD91E8Weulx-IwoaKBEPOB9I0ULhgKBPn80uE6KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nF2PaS6HESE_HLRa5_Up7evIfCU1yFduIzjhhlPYDyA1Md0fBzLJhQ>
    <xmx:nF2PaVUYkwMMt18B6CMCU91BLagGcll6IfpYKtR_ku-Gh11ECRxtwA>
    <xmx:nF2PaRAIcCDKMFU49fV_kJmqCGiY35EAnopSMEpUPKXXP422jCm76w>
    <xmx:nF2PaU7inE2S9oeL51kjyQ_wwG215NTa0Z6R5sZmT81q9EQ3bXA8wA>
    <xmx:nF2PaaUYy6HPyoKx3rrF2j0HNjezOP-vLkFgCqzOR0NcGJa6WWd6IzMc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:21:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] Documentation/git-history: document default for
 "--update-refs="
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-5-756ac376e9e5@pks.im>
	(Patrick Steinhardt's message of "Fri, 13 Feb 2026 10:12:51 +0100")
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
	<20260213-b4-pks-history-dry-run-v2-5-756ac376e9e5@pks.im>
Date: Fri, 13 Feb 2026 09:21:30 -0800
Message-ID: <xmqqo6lsmued.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While we document the values that can be passed to the "--update-refs="
> option, we don't give the user any hint what the default behaviour is.
> Document it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 4dbe665ec4..cc019de697 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -70,7 +70,7 @@ OPTIONS
>  	Control which references will be updated by the command, if any. With
>  	`branches`, all local branches that point to commits which are
>  	descendants of the original commit will be rewritten. With `head`, only
> -	the current `HEAD` reference will be rewritten.
> +	the current `HEAD` reference will be rewritten. Defaults to `branches`.

Good to see the default clearly described.  Thanks.

