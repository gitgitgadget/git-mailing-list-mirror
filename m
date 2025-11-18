Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B2267B92
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489852; cv=none; b=CBWxbJDn+jmccH+BOdd/7p65W6NFkhstaR1um9YQ06ltjezPTuibNlBwtiZ6xOR80E8YMa0wd9w6eNpnYzdrHDE7RxvFCL6cMfi6CZeFC8cz9yt9QTEZ2IB/q6Saulm/NRYGllTciTEWH2wksHYU/aHM1E5q1m7DdUDwwnNoC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489852; c=relaxed/simple;
	bh=4d75l8kNE1JPU4p8cLh4n3iURtKags/JRAF1EasVoNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mldhLTFMqKAmh7kk9fMbYxmHJuDWCGCtwDuiBhtfEUGV1ko3Zq4ge1qyc1o84tLj9zD7Mezcn2FhYtQJ3SFGoeIArskLCb1fU1/I8Wmdjy2PsnMzmDpLo/J2oiXeVRyTde1BdthxJJy1ev9VbPRAgRB6+uXbYya+UY9vKtS3yO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AmQ1VV/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmGmJ4Q2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AmQ1VV/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmGmJ4Q2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B9F0FEC04E8;
	Tue, 18 Nov 2025 13:17:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 13:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763489849; x=1763576249; bh=KKDEw9r1hP
	DnnMf3g5lZrcbyypUqMMoXR+KUp5hdTX8=; b=AmQ1VV/1mq0vVpxwPhAuQpodUw
	5Dj6bAJYBPoybsdJ6PJyemf4sbJlmE2EVuvT+0OMmEWzQMQ/aGENbwqzhD15eJks
	lf0ZahB72zzTWl1AOlxFBU5XL/3m9w5Nvm6juUorLNXRwie3ctMcCWOzUWRQkkie
	WcUvHd5TfiJcp6IxA9Jc578wR1/pXF6TQgSTfz1H3+4imgU5hnd0Y1Fw0nBYhHBV
	uCd9QzliysSxbVFqhhUh/CGbx2pikkIsLiMZ9O4AoPg1KftO3mfw9GqRdM5rlbNG
	EC5NjnoZ3KWo+pKxwvtquXbCWsKaJfSfAswLe5emn5Ww5KqRe37PEWoIS2zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763489849; x=1763576249; bh=KKDEw9r1hPDnnMf3g5lZrcbyypUqMMoXR+K
	Up5hdTX8=; b=QmGmJ4Q2mI08ck6QqntCPTIHART9Ri9POZiMPt8BRhY+3roW44K
	6Y0DYGGv2YVKj5ebMU4PcQRgT9jfjgayS5aJcLbMftChBy9WG7hHVg6Gn7qW/dAL
	h6FAXOQvSpBovk4kjAVOvtPyeP/TX6eu3G0fFK+CrwzrGXm+DoVS6V8FcALYZQSO
	9Fc/ZLgnCmv9F5GNjGOV9eD16cRL/IsCzQxT7WCtO6BEgmNLpEJCfQdQq9EKT4e7
	An2i/sca7EwkwpvXnwICgeMgIZjeWe38N58T3d8xYqZfZYr7CLM62M8UcEwyGCfx
	gtCAEZBeT4UYFW/joJ8Ov2eVN1gqE56IOnQ==
X-ME-Sender: <xms:ObgcaSniHwLnTA0UjqMBg2Obkp-0R-2278nhZN2nydohfpTXmn6UMQ>
    <xme:ObgcaQ3ivvtFP8FmA7lfIyyo1qTPzPlGuoFjJSKYkdbYvf8Fs_EC_MDoKFjk1TJk3
    n3OyeacjHM9VE1fSnoQNTkMekvCJFWIEzeS4cc2edeiU1EzuV53>
X-ME-Received: <xmr:ObgcaVr7Q8ecyN3ZyG1NBeWZL0NWlhYAsay9fEz7hK-Gz1OKWjOj-fUkqDXTDbB_a3fs7B0eRp06oUbjZZNT6shLCgLnd_dxqI3i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgfhhunhhnihdvfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:ObgcaVfv3IcJiXIuTgxvDcydneiVweZmh9DygU6W2Yxi5F_lhKJYSA>
    <xmx:ObgcacpHjxvp5LmTNL2cvBvdjsvURbAUG7LTRE8dP3MzuWesXzx4iA>
    <xmx:ObgcaeFaTx-KE_Zio0Of58LS2MHkACrZoYb0zu9NjynyWOLrltBPnA>
    <xmx:ObgcaUvrxg18NiAQlLEGGsykXp6dEzPrpXicSDLFQ9YX1dFKoSupiQ>
    <xmx:ObgcaRIW19gIjx_b-3kT2d5v3Eq-dl59EXA2UEgvCd6QnYzY_uig6HS1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 13:17:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  AZero13 <gfunni234@gmail.com>
Subject: Re: [PATCH v2] win32: pthread_cond_wait should return a value
In-Reply-To: <pull.2103.v2.git.git.1763480546981.gitgitgadget@gmail.com>
	(AZero's message of "Tue, 18 Nov 2025 15:42:26 +0000")
References: <pull.2103.git.git.1763427599300.gitgitgadget@gmail.com>
	<pull.2103.v2.git.git.1763480546981.gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 10:17:27 -0800
Message-ID: <xmqqms4jdx3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2] win32: pthread_cond_wait should return a value

Is this mistitled?  The patch text talks about cond_init(), not cond_wait(),
which is the theme for the other patch around SleepConditionVariableCS().

> From: Greg Funni <gfunni234@gmail.com>
>
> This value is not checked, but it must return to match POSIX
>
> Signed-off-by: Greg Funni <gfunni234@gmail.com>
> ---
> ...
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index e2b5c4f64c..000604cdf6 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -34,7 +34,7 @@ typedef int pthread_mutexattr_t;
>  
>  #define pthread_cond_t CONDITION_VARIABLE
>  
> -#define pthread_cond_init(a,b) InitializeConditionVariable((a))
> +#define pthread_cond_init(a,b) return_0((InitializeConditionVariable((a)), 0))
>  #define pthread_cond_destroy(a) do {} while (0)
>  #define pthread_cond_wait(a,b) return_0(SleepConditionVariableCS((a), (b), INFINITE))
>  #define pthread_cond_signal WakeConditionVariable
>
> base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
