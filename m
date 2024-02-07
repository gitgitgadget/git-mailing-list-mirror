Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3C823B9
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325954; cv=none; b=UGt0VZXVHNqIe2O40cfAwbhtz6OR0J+dIrdZqQGqRG7/CG7OG+r/LobiI9VqIYQGFwMBXYDgWVmAw+tZiX4vLhUvO8Vtme5mRMPpjbl7jGnr+u8eRC38KL4qlLzkAKfx4Td2nlXsM0yjDmyUQ3xE9Xhf6tRoRMlrYUdzN8nzl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325954; c=relaxed/simple;
	bh=m8X+7z1c4DMjN0kwPOqe8zcbYdV9BcGRcM7xJtFq42o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u9AAwptLGkJMXKnxoWeA39pw7gtbwb75yL1IG+WPTKoQRl4eQf9tFm86MnX+MbGTKX6lxKpmGD0sAN21h85KdIU4g55tHdsdRai6PCrWI0ylXcsNGNld2D/PH/dMI4NHjsaIRvwJcz4N6auQad8sg+igzlWZEiWoHepNRUWP/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pKk52Nhc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pKk52Nhc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 106291DDF6D;
	Wed,  7 Feb 2024 12:12:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m8X+7z1c4DMjN0kwPOqe8zcbYdV9BcGRcM7xJt
	Fq42o=; b=pKk52NhcsXnT9NpS+zMFte1Qa1wSEYRJfQ/jRZHfgenejwQ5ftzkIo
	Jt+gb9ajVq0y8wuHBsVraajbh9B3Wg/QWWg8xuW0uyhGg4pZWGcWnBT4DfxKL4T/
	6fTjMNIyUOAud7/X0O8dc219/M3WE/T7v0YnYW+JiYo7PExEhXaU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 073341DDF6C;
	Wed,  7 Feb 2024 12:12:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67D4C1DDF6B;
	Wed,  7 Feb 2024 12:12:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] show-ref --verify: accept pseudorefs
In-Reply-To: <4dedc5704c3af6ab4ec8cc7503dc826480775b8e.1707324277.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Wed, 07 Feb 2024 16:44:35
	+0000")
References: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
	<4dedc5704c3af6ab4ec8cc7503dc826480775b8e.1707324277.git.gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 09:12:29 -0800
Message-ID: <xmqq5xz0b3lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 136C2D48-C5DC-11EE-9FCD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... when CHERRY_PICK_HEAD exists. By calling refname_is_safe() instead
> of comparing the refname to "HEAD" we can accept all one-level refs that
> contain only uppercase ascii letters and underscores.

Geez.  We have at least three implementations to determine if a ref
is a valid name?

> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 79955c2856e..1c15421e600 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -172,7 +172,7 @@ static int cmd_show_ref__verify(const struct show_one_options *show_one_opts,
>  	while (*refs) {
>  		struct object_id oid;
>  
> -		if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD")) &&
> +		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&

I think the helper you picked is the most sensible one, modulo a few
nits.

 - We would want to teach refname_is_safe() to honor is_pseudoref()
   from Karthik's series to make rules more consistent.

 - The refname_is_safe() helper is not just about the stuff at the
   root level.  While starts_with("refs/") is overly lenient, it
   rejects nonsense like "refs/../trash".  We would want to lose
   "starts_with() ||" part of the condition from here.

These are minor non-blocking nits that we should keep in mind only
for longer term maintenance, #leftoverbits after the dust settles.

Will queue.

Thanks.
