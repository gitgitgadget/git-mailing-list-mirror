Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9F172BAE
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904133; cv=none; b=rc14EhXVljOyXzo/jXIqih4LMR/FBDNVO2AGyVQOBq7f2DBhRP6E0UQQ1CcV4dW8TTQePEJVBDtpkpdp5uTQzy2NM/tn2WI8LIybTrE/czWED+iZCJJoxlSp1wRkJjmDrAXXz/u+vB3kmoXw+Q89uzY908zqcUzWwdHFNsBH0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904133; c=relaxed/simple;
	bh=XjUDRajxCBxjhPUHmTmEfmyoGUMgrIuexspQWX88AWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=niJ+hxd5CHHhZ70I/gk51bLKjx7AawKuBUfQfenfYeB5eC6b1npfqhNSDAqZvmjAJ6dDND7FtA8ROkNt2PmqQwvyGaeYUoqXLTkO1HMmSBb4Tt0BFsGDCvD7Ik/Qp2QZC54ZaOEE8aJr4/kwa48R0UG499mN0KCxWhDHw1SS3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OofoA7QV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OofoA7QV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAC3C2905B;
	Mon,  9 Sep 2024 13:48:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XjUDRajxCBxjhPUHmTmEfmyoGUMgrIuexspQWX
	88AWE=; b=OofoA7QViZpKvEsaGmhfpXh+KXzbhnLnxaMVeqSUHBkXqJn4LAxp9r
	4F+wDH0ag2/NokIt5POG1u7KbX4/RpY2zX2NlcdwfEH+v3NMcCGrx+MEzHun52Pk
	jHQOnVrItdTO4eOuZ4FOmdRyHCDaZtgNw4OcMwXPEU3oTjSGrYrEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E0FC02905A;
	Mon,  9 Sep 2024 13:48:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57BE129058;
	Mon,  9 Sep 2024 13:48:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/4] git-repack: update usage to match docs
In-Reply-To: <eb0aa5f4e94647c12c595964ca1fe1c2020f0642.1725890211.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Mon, 09 Sep 2024
	13:56:48 +0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<eb0aa5f4e94647c12c595964ca1fe1c2020f0642.1725890211.git.gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 10:48:49 -0700
Message-ID: <xmqqa5ggsoou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C594BAC6-6ED3-11EF-A897-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
> index 28003f18c92..c4a15fd0cb8 100644
> --- a/t/t0450/txt-help-mismatches
> +++ b/t/t0450/txt-help-mismatches
> @@ -45,7 +45,6 @@ rebase
>  remote
>  remote-ext
>  remote-fd
> -repack
>  reset
>  restore
>  rev-parse

This is very much appreciated ;-)
