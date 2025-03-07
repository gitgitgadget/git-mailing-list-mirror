Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FF2505D4
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379132; cv=none; b=BeI6fP1INqx3x6DXyQGIP3WvG7Kv2+cax6NVakdIWTj7LXaoT7s7ZeJ4W2UrpTIwahE6svUk2XSRzJoYbMtYtO/fkD1Pl/nsrYxtulogqjK8fJkbVDIV11dlWqUve8mgbBx/Y9cD9tHGqJ1m6bDDZy7iPjdlxsVPzZWnz/QXlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379132; c=relaxed/simple;
	bh=enQkSe/QqEDk+ifoe0uWgFqi5DqR6cL0h6yBkxLdg/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F8GJCk/HJn0wfy6ZHxN2fKQbqKsPmX2ClmPPdPR3WX9IPAn1jUFLDNMdSZhY5aEL7L5OmmOQRbaeV/ob9iDhbKv+o6WkDD6UJskyMpaQf11/hMF1Gyht/tUr2DEZeD9X63de9359UNZf/s4PsJYb20qQUZD/wBS8o5Wmy3UvVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fy44fdB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4kdWX7In; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fy44fdB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4kdWX7In"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D18825400EE;
	Fri,  7 Mar 2025 15:25:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 07 Mar 2025 15:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741379129; x=1741465529; bh=g3yA2gDeAI
	rnPtpXVTDsaf6nfvs8RrzsRpVgvNDF6OI=; b=Fy44fdB5njgX1TLUxRSM6G1o9T
	3cPqyfsTmjQvBmCr9RYQbGb0a0dDqUp2hhiqAhidtEMboDlxMWracvEBjGUPwqTM
	l6paFflxtCnCpDfBHMonb/RaZOT9/5ZTBpd36XXIC5jCl9kQeuXy4LlYpEEThExF
	Yy0pKWsYLlvwmHurIqDZ/Dy04hQGjK79tV3PvLtqWtUSf51n3T/L6MRiQ4x/1NCE
	idpT8omLO1kXBJ0jv4GdIjm1H3USPavVnNK51z8wkQPwILP1W3GqzRycHyCU3CzK
	BScPTYgeF4xP/D9vfwk3k7qOFlogR2jplfy/7ryIUvOJGwPx71Qv67NeDnuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741379129; x=1741465529; bh=g3yA2gDeAIrnPtpXVTDsaf6nfvs8RrzsRpV
	gvNDF6OI=; b=4kdWX7InDQOjDfKcozZFs+eWSiLjTEsLAqwNWksCfZjWZnyonnV
	SxFcm2MQoYl/aHPNKBziJ0dixHjTjd5US9iNAJDIH4AHusWmspg1OPlvPGWlfXlY
	dxaLViWDx+/MKTtogBQe8+FDxhqv6w1zPHl2EUQHeXOCwJ0sOxIG8uhhl5Dd2OVu
	FBYVC612tZ6L6P5VeMIwGu6LbmJjzTc1BPdhKBQU0R4n/+uNa4KyC11AKG1Nhg3u
	2Yk3ZJLH8Li17HNAVqarR2dAlS2q6sg862N4jq6vSKObh1pRVsLG+coc7+gETSiz
	9xHYITAp5RjoaQSBLznSup71eBl6tFYTRdQ==
X-ME-Sender: <xms:OFbLZzDH_7RvvOAxJ-ypUzD0XFF_O3tmCnegRvB-E1Zc4WeMi-2xNQ>
    <xme:OFbLZ5gLE2bE1U5Nuj0oPhx672toosMJcuekGWAkbothr_gvEwB0ASR4rnnUr0L6l
    mzOwbwSW0_VkMXjmg>
X-ME-Received: <xmr:OFbLZ-nXBgpcfXZ6cibSvRI9E_S4iBg4Fz931hvLcqBURQPkIqxDSFEeHANnLdC9UfPWtnGC8Jcik9tEPs53DL_3g9OWDDblGf7_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:OFbLZ1ywlMhtI0xFzU-EGm1IXzJr9c2N9m8wzDb09qAaHT1zWEPH2w>
    <xmx:OFbLZ4SD1ZZsyvRKca17vfZhE_gRiIxW3ncyXym7tp1lOWXE6zsHqg>
    <xmx:OFbLZ4YzqEMF_QwFowWTY0zKWrysgLo-6yjxtRxpR6lwAwNumurlCQ>
    <xmx:OFbLZ5TlDRNF64ZAftCOeWZEU2wi5QDpW7RnYf65NfsTtHeY-2ecOQ>
    <xmx:OVbLZ-MSt4UA-hr4nJ7RHuC_aVP-hbcIamNpQpno2cTq4M0Vn-sVDTEa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 15:25:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/2] help: include git-zlib.h to print zlib version
In-Reply-To: <20250307-toon-zlib-git-version-v1-1-5e8069752bb9@iotcl.com>
	(Toon Claes's message of "Fri, 07 Mar 2025 15:18:07 +0100")
References: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
	<20250307-toon-zlib-git-version-v1-1-5e8069752bb9@iotcl.com>
Date: Fri, 07 Mar 2025 12:25:26 -0800
Message-ID: <xmqqbjucegg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> In 41f1a8435a (git-compat-util: move include of "compat/zlib.h" into
> "git-zlib.h", 2025-01-28) some code was refactored to enable easier
> linking against zlib-ng.
>
> This removed `zlib.h` being indirectly included in `help.c`. As this
> file uses `ZLIB_VERSION` to print the version number of zlib when
> running git-version(1) with `--build-options`, this resulted in a
> regression.
>
> Include `git-zlib.h` directly into `help.c` to print zlib version
> information. This brings back the zlib version in the output of
> `git version --build-options`.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  help.c | 1 +
>  1 file changed, 1 insertion(+)

OK, the user was merely "#ifdef ZLIB_VERSION", so this new inclusion
would not introduce a separate unintended breakage, I would think.

Makes sense.

Will queue.


> diff --git a/help.c b/help.c
> index 8d91afe851..707cd59b79 100644
> --- a/help.c
> +++ b/help.c
> @@ -2,6 +2,7 @@
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> +#include "git-zlib.h"
>  #include "config.h"
>  #include "builtin.h"
>  #include "exec-cmd.h"
