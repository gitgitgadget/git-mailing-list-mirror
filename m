Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58853EEAC2
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079110; cv=none; b=hUftqJ1eToLpED9c6lo6/luS3qIpfQgD2zItvtDUIVZT3Y88lX/HwiuiFzVvS+7rN2oJtcW1AA22JQwxnkY97iqYwgu3zWskwgH34Rwmo/qnEU4D875dIbTTjhLKcDC5B8kUQVsLnlmNEDjNjA5xjHF1XEXljQ3tDOMiQ+neSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079110; c=relaxed/simple;
	bh=2SnqYCkJNRn9N1bjFYe0VBovRvGzIb/DPUCMDvX1JUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uRwLnRxVFZ6veyggLwkS4eyc+nYqOlBQBGEP7s0t1HdY9eOrTuFl2085ckCBdAsagvWpM8inxDE0BUIsvez95se76cYjLo/+tlrLUtlM0CgCXQqhwT624PfEtezxGcao+uOFCC/H7ZtmYKXAOHTiKnWkqwIx2OzBPTRpD2E+H2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b8csJ5OI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMBxp75t; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b8csJ5OI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMBxp75t"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B5E89EC0184;
	Tue, 18 Aug 2026 14:51:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 18 Aug 2026 14:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787079107; x=1787165507; bh=3/4jg3LK7W
	jxregRMTSS64Uxqmz4jx0sx1Iy+dhMwBs=; b=b8csJ5OI8J6kw+ArWA75nnAS3P
	iIQ9JPW8WWRtxVuE8rSFbglrWfcCpPaYJ0HOE0pctheWnBIa76vk66+Su0U835s0
	d4NH9rWQEJplyAxuvhI12EbyEBWtg0uHnyFYZ5I4/EXCHXGCOSoswddmqOU+ZE0e
	c5jNoqT5nL8u8UgnSJaMP1BfFeVtLGEYVCWYRj0J/I17x1RMxoCfaJx1IN3AzBTY
	VoOIu9cDj50jzY/FIkWeM1l8PVZnemBieQvdzD1DCNPx8XUMBYWpLUmsBSrg9crJ
	cnlY1uUiS8x7/fyxYDRdapFAUoHrk4PMpNC+688eAg/+5jW/jUrSvUEr/qkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787079107; x=1787165507; bh=3/4jg3LK7WjxregRMTSS64Uxqmz4jx0sx1I
	y+dhMwBs=; b=AMBxp75tA4oiKsbUGEr+WuzRdx43dcfPXX6HisUgkCZt8in5VYw
	qq+C33Zp7/jKz0HnYUFWXfMa900mdb5V1BGR13fBHMSyQVvDG5OIUvQHX0qoMdrx
	iSHOkyrjghFKSj+CRdg4GMXrkiRPyYHOIJrtBWVStR6MrIkYHe4jR+AQr9lhg+JJ
	xVLVrputWre+pxZnO6cfTGxYFuEUm5kfC4BZUuuT5x8IJR2lqbP0leED6/HDOWS7
	zMJ77+Pmo/l6PUBjkAqUvjJcYt77N7QAbrakp2t2IAa4ZMIZm7M8pCEX3V4mPUQU
	s3nJijktdOQc5xUW1LNUP6zjYkgoPCjM+bA==
X-ME-Sender: <xms:w6mEaukLJEgdbHDJb361EG2MLTMmVjSeiGv82yVtpnLx3u5Lqwd6nA>
    <xme:w6mEaoFspiEYd8NHnoWcrcNNI0fdl-j_CbEgGqdvsa0a8AeJ9eLX8YWpdspWkaT8x
    A2CjReIDj9tRiTrnAJuZ1WUWIhBuEJ_qAZSCT41uoyPRG9JB-OR>
X-ME-Received: <xmr:w6mEau70h6mep8nust8I49mNHbcWN9dxpVwxb57X0djcwycMDYaxv73IjQ184q7Kb04HhN8QfuN8IdeoEFrDA6Zfk5Q4ghznhA>
X-ME-Proxy-Cause: dmFkZTFm+FuGmZqSQXWT88cL1mqR0cExRDl4o5JRZn9jb3gHioyQJZLLJY8pQU26nzsAjS
    d/rvWphONpApbI+guH0h/dtzbyc1TP1rPOkQI/EIPq/bOO130T13M5jlhxm2j3q+5kdA0C
    5CCbjQWiZxxGm1ZdjUiG/1mclbzTSWzjUwrNuzMoWpfKMNpcLOxkl1hpzkpeIxmU5bA36l
    dLo/D/qJUqQH83AQH0jOosTT+Y0UbqoNBvX8c50IP5dPtreeR2sEttDR5MyYSucnIAA8Ct
    qBffp/FipktKSSKkdTMewgj13pzLOqbMMvVBllD9sf6uRvntEz6mvm6mJhpXIy9etfA3FW
    AZfddrCs5e84+9mOzEIA/p6zpj2nDZ03doO/tQfdO+0j7LNzSWJILRvVEHFaIIDiwRSpay
    joG70EnaMSOanTDti8Q4XrSoMEOQPIspk+83uYQb7QjI6KdRX+rVnByN9v7fvBuymWEVFs
    AOcftszrL4mFvR7P9mdcLdIXpEhfXZb0cyKHd1G24AdOn7WUg9+UUNNhRZjWH9gZwgII1f
    xH8yBfgiq0i5PEsrtPvFbl5hl+QuUHJN7VaQPKuV/yBdO/rY0g69vBjBZmRhkgp3nhzQhQ
    wFJn6a2SZVcWFGz436xtN8bIBWTN1OitZUkIfleSEyvtBIEn5JcfFm3UZEQA
X-ME-Proxy: <xmx:w6mEaomLCBO6FX41e9INA7Zm1TfWOmcSYWUbCjW6JqZ46aOUDP5kcA>
    <xmx:w6mEarpTAYAtQwVeYksKMuGL-MMxs1kXi6IZARhRg1VpysAg02KaNw>
    <xmx:w6mEavshj38OR-qaAfn1J39MCo3qwsYlFmztP7XcICHToMdcjWNKig>
    <xmx:w6mEaoFVt1kyR8Ml6wq98A1qU0E4Q7ZC8p-bZJZwJvK6B4rx6QC1bA>
    <xmx:w6mEaqQYTpWDXUR7yvHNN2STnfAe_Ak2lljOvY4fdu0lOND4XyJ3iu8z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 14:51:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Todd Zullinger <tmz@pobox.com>,  Tian Yuchen
 <cat@malon.dev>,  Patrick Steinhardt <ps@pks.im>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Tue, 18 Aug 2026 10:59:47 -0400")
References: <cover.1786103607.git.ben.knoble@gmail.com>
	<cover.1787065125.git.ben.knoble@gmail.com>
	<48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
Date: Tue, 18 Aug 2026 11:51:46 -0700
Message-ID: <xmqqh5krxnwd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> diff --git a/environment.c b/environment.c
> index 6676e6f5ae..c7f6b801f4 100644
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

What this hunk tells us: At build time, you could choose to ignore
core.usenanosec configuration variable, preventing cfg->use_nanosec
from getting flipped to true by the configured value.

> @@ -769,6 +776,9 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->ignore_case = 0;
>  	cfg->trust_executable_bit = 1;
>  	cfg->has_symlinks = platform_has_symlinks();
> +#ifndef NO_NSEC
> +	cfg->use_nanosec = 0;
> +#endif

I think we want to unconditionally initialize it to 0, unless the
definition of the .use_nanosec member itself in the structure is
conditional on NO_NSEC.  And ...

>  
>  	/* section "sparse" config values */
>  	cfg->sparse_expect_files_outside_of_patterns = 0;
> diff --git a/environment.h b/environment.h
> index e7ec5b0437..a35534afe5 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -139,6 +139,7 @@ struct repo_config_values {
>  	int ignore_case;
>  	int trust_executable_bit;
>  	int has_symlinks;
> +	int use_nanosec;

... that is not the case.  

Which means that git_default_core_config() does keep the initial
value of the member without getting affected by the configuration,
but it does not necessarily be keeping "false".  It may be keeping
the uninitialized state instead ;-).

> diff --git a/read-cache.c b/read-cache.c
> index 6c449f393d..31888f77ee 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -353,12 +353,18 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
>  static int is_racy_stat(const struct index_state *istate,
>  			const struct stat_data *sd)
>  {
> +#ifndef NO_NSEC
> +	int use_nsec = repo_config_values(istate->repo)->use_nanosec;
> +#endif
> +
>  	return (istate->timestamp.sec &&
> -#ifdef USE_NSEC
> -		 /* nanosecond timestamped files can also be racy! */
> -		(istate->timestamp.sec < sd->sd_mtime.sec ||
> -		 (istate->timestamp.sec == sd->sd_mtime.sec &&
> -		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
> +#ifndef NO_NSEC
> +		/* nanosecond timestamped files can also be racy! */
> +		use_nsec
> +		? (istate->timestamp.sec < sd->sd_mtime.sec ||
> +		   (istate->timestamp.sec == sd->sd_mtime.sec &&
> +		    istate->timestamp.nsec <= sd->sd_mtime.nsec))
> +		: istate->timestamp.sec <= sd->sd_mtime.sec
>  #else
>  		istate->timestamp.sec <= sd->sd_mtime.sec
>  #endif

Ugly.  How about getting rid of the latter #ifndef/#else/#endif and
instead keeping the "if use_nsec, pay attention to nsec, otherwise
only the seconds part" ternary?  As to the early part, as you can
arrange cfg's '.use_nanosec' to always hold a sensible value, the
function can become

        return (istate->timestamp.sec &&
                (repo_config_values(istate->repo)->use_nanosec
                 ? (istate->timestamp.sec < sd->sd_mtime.sec ||
                   (istate->timestamp.sec == sd->sd_mtime.sec &&
                    istate->timestamp.nsec <= sd->sd_mtime.nsec))
                 : istate->timestamp.sec <= sd->sd_mtime.sec));

I think.

The code you presented here for is_racy_stat() sprinkled with
#ifndef/#else/#endif would be sensible if repo_config_values struct
defined the '.use_nanosec' member conditionally.  But that is not
what is happening here.
