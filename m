Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E59261388
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238447; cv=none; b=DK6SArR/PYBEM6Lj/37Yul8rSh9ka/9XF5FsFTgAnLoG8qgrbILDwnTtPZzfj01vP0yF37Ip+WR1LZ4PZ4iHvYkqv4KGofusDuhbdsb3aBeRTC8N7zxNiNO7/a71Rt98kyMqJ7IvOh61R6Tj3M9YsDUpvPqU9/M2iqPwkVymEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238447; c=relaxed/simple;
	bh=L/DYYH1uObkUubOKNo7br9fJGcWntEhSTA1AcaEeKp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeVgU2Uf618kzoHbYV/HvKP18pj3Kl0rhp4ctWIRplK0PNW/5CVbHMjOtQF6Wonnx8RtB6rO/UOHeGN/nFr9lKC5bFXBU0v9Et0AMYSSoqRamk5U+zFnVrNQ5VvF+L0Bt8MoiK+Eg+uulLU+Bumoh8N8M42kXYtUXc4LWHrMFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IADc0W3q; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IADc0W3q"
Received: (qmail 6859 invoked by uid 106); 1 Sep 2026 04:54:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L/DYYH1uObkUubOKNo7br9fJGcWntEhSTA1AcaEeKp4=; b=IADc0W3qBJp/Jb9KW9uCb2yMHtMDmX5GkYVV7ODh/PW0GYaCcYxSYsyAwNeYeuEESKOBzsDHgfRusDN/QojYuasu07gSb1mGiLv9GKCHa8K+V3ah8tDEf79xdrmIvBGm2S/TLvk8fddZ8LaQpw+PVA8l9l+bbKvpp+wOVxIz9s4v/nFohwEPzl1dROQIm9NC5tRpVr2qaH4qBtvOM8D4Fr0bFrchEF9LA3rUr62CJ1Q1x75bkKAZtQfyD+5X5M+PT12zrEVbrCi/zRmt6/zBCOxlw6DXciM1ZaEvYK3uokhfpGpc03bo9lCdjOVKjfW5pYjgKQnquFxYzjYlCuH5aQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 04:54:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33061 invoked by uid 111); 1 Sep 2026 04:54:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 00:54:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 00:54:03 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <20260901045403.GA1075462@coredump.intra.peff.net>
References: <cover.1787231825.git.ben.knoble@gmail.com>
 <cover.1788206466.git.ben.knoble@gmail.com>
 <0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>

On Mon, Aug 31, 2026 at 04:01:37PM -0400, D. Ben Knoble wrote:

> diff --git a/environment.c b/environment.c
> index 6676e6f5ae..c83cf44839 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +#ifndef NO_NSEC
> +	if (!strcmp(var, "core.usenanosec")) {
> +		cfg->use_nanosec = git_config_bool(var, value);
> +		return 0;
> +	}
> +#endif

This hunk made me wonder if we even need to do any build-time magic here
at all. If your platform doesn't support nanosecond stat entries, then
you're probably not going to ask for core.usenanosec in the first place.
But if you do, I think the code still works; we fake the entries as "0",
so they'd always yield a racy tie, just as if core.usenanosec was
disabled.

I guess you might be able to get into a funny state, though, if you
build two versions of Git, one with NO_NSEC and one without, on a system
that actually does support nanosecond timestamps. Because IIRC even if
we aren't _using_ the values, we still store them in the index. So an
index generated with the regular build would store the actual nanosec
stamps, which would then get a false comparison using the NO_NSEC
version.

That seems quite unlikely to happen in practice, and there is a certain
amount of "if it hurts, don't do that". But it's not like by dropping
this #ifndef we could get rid of NO_NSEC. So it would not simplify the
code overall, nor the number of build knobs that we expose to the user.
So it probably is reasonable to keep it.

I haven't been following the topic closely, but from my cursory read
everything else looked as I'd expect it to.

-Peff
