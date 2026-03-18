Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60C3ED10A
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859882; cv=none; b=cU3YRrLh8X2Q+GnAkwvQK2ail+P+aYFjQ/TRe8bRzpWVcd7GtwAW1gwFs/5iZyVauS4NPdAilcKhoZ8q5eyR+2eswL3KClIII+3fdonbXqYM4KJ5cX9QAhDXpiXeKOlEK0OxA1/byBIOBMUxFKqQm9M+X4N5y2C2duYFVkm1uXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859882; c=relaxed/simple;
	bh=rLhKeF2MzqXTUk5LqcA/RCek40bqxtEMovTEFgLlizk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PiQJmCf/MRJSozYRR3IN3D48f5UAXT/1x186eQrwEgZJD1jKCUJzLbsYtcMuyP31gkQYxd6Otl4xPsMnXrOEnJ2u7MCmMmb4a5LrFrI4xz0X78bjPRaEtb2ghfgOx+5mE0Yms4/3fCYN4NzJNQtfjM2lEef9JNiO/w38Y9SYcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BhtwJO3B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uWiL3n/N; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BhtwJO3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWiL3n/N"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 732297A011C;
	Wed, 18 Mar 2026 14:51:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 18 Mar 2026 14:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773859879; x=1773946279; bh=6JtweXJbdl
	mpI4IaLgtkAI24bdSzFmXNHwKLFSO3zJw=; b=BhtwJO3BI7ctQ/i1vjsooPIowx
	fC2IW9X4tBmR2Ai2DZlArDsmNupujlheHQM5xKb1aKZsp2vgfmGP+DRVBb806wUI
	N59A/3VfrLtxoc1xC1NGgzGFdRSv13c50jNmUQneUygRyv4csqZspFAef3X4nzw7
	nv3eRRpzc9Ns1AQvpEtxOUgluPu5ib+NaOukjU7kRlYcnFH9hm450ITDjOSAx5IJ
	dVaJ8oxvw3RPECQCyqR5JKvuULGUTRiuVSaBnPnGaBHHRyxb0i6fMwrbLrVidpym
	xmtXSwqKia1jKDybgjbQlYyRwVhDos3X4asYyB8iYtpWovqZU8bFWCrpSbFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773859879; x=1773946279; bh=6JtweXJbdlmpI4IaLgtkAI24bdSzFmXNHwK
	LFSO3zJw=; b=uWiL3n/Nxz0NqUD0ZmR/RyX4EpdVu7sxIQaI6KRoDsfxyolwONT
	zmm1iBa7nYDVy3h6jLUKg9uQmcoXTEVgeuxdJXiAtqp7rga6IF9FRGS7H9jGjrFJ
	eFwmlZZmP6dJU3TirGeTmG9glLy9G/sDO/wRJS9D954oIUdM0MfxZykm+t51iyPT
	AuQBRLcNtGsnZq7zy7UUViSp2ckDequkGPqcrTYE3/XF/C7II3dTBugtMh0NQO09
	yeMlaVTLedomkExXKyooOqjOsKaw7cdGUmi9hkp1xKzmoc8+ZWyCG4SVQIFzlzTU
	RKiAAABq4+y2+II0evNPxfvuVqtIPpUB0rQ==
X-ME-Sender: <xms:J_S6aSRX4J_pNSlbzKNgO8cKceqE8_IRA-LrxyNMR0WWLDQPe63yow>
    <xme:J_S6aewyLpFqqf23vMvKgUgxSP4_Nbuft84L0hODbQpifF3ziRlLm4ulF9YWmjgrD
    eSJWt2_05wxIdOq2WLoBY1BZhxo4dm_wbcVvVki5Yqftz74krz8>
X-ME-Received: <xmr:J_S6aU3E5VlCOdKkSs5moNL3r5LVGw4FfEuQbSIvZcPhH8Rt2uxMywHpVL5Rpm00WP2iiBtgzNfSiEjj-jCI21uA4vFYTcIb9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgguihhthigrsghnfidtjeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J_S6ac7QTUs3FFqAOYVfLL1qohLr9hLcOysLc_8AyaU0Jg3FMxkryw>
    <xmx:J_S6aXUx5MiqXi9Ln2ibZ-pG38jj7icaVZPfw2BF1ngCmivt1EGXtA>
    <xmx:J_S6abB6CuqPEr3m9PQuXWF22UbCKO7yTz8Rfdn9BZs9XmGk0_grRw>
    <xmx:J_S6aW5w21JSP9_mtr4vb28WOKkU050NcKpM420UO1408EfSonY92Q>
    <xmx:J_S6acVsX_WRkWA883B81663hS92_CrlzIYtL_iTBh9vVKFLxKRu1h0L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 14:51:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "QUANTUM via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  QUANTUM <adityabnw07@gmail.com>
Subject: Re: [PATCH] t2107: modernize path existence check
In-Reply-To: <pull.2071.git.1773857555312.gitgitgadget@gmail.com> (QUANTUM via
	GitGitGadget's message of "Wed, 18 Mar 2026 18:12:35 +0000")
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
Date: Wed, 18 Mar 2026 11:51:17 -0700
Message-ID: <xmqq7br9q8d6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"QUANTUM via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aditya <adityabnw07@gmail.com>
>
> Replace '! test -f' with 'test_path_is_missing' for better
> debugging information when the assertion fails.

OK.

> Found using: git grep "test -[efd]" t/t????-*.sh

People seem to add the above to their test-path helper patches, but
unless the coverage of the work is fairly thorough and you want to
say "all the similar issues should be found with this command and I
addressed all of them", I do not see much point saying how you found
one of them and addressed it.

>
> Signed-off-by: Aditya <adityabnw07@gmail.com>
> ---
>     [GSoC] t2107: modernize path existence check
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2071%2FQuantumDev-CERN%2Fgsoc-microproject-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2071/QuantumDev-CERN/gsoc-microproject-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2071
>
>  t/t2107-update-index-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> index cc72ead79f..3bffe5da8a 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -86,7 +86,7 @@ test_expect_success '.lock files cleaned up' '
>  	# the_index.cache_changed is zero, rollback_lock_file fails
>  	git update-index --refresh --verbose >out &&
>  	test_must_be_empty out &&
> -	! test -f .git/index.lock
> +	test_path_is_missing .git/index.lock
>  	)
>  '
>  
>
> base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
