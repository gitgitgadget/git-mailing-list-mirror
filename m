Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF731E852
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784953021; cv=none; b=cVwrOqpqwZ+FeUigwV9hYu/V3YRlAoU0XK2wlAOvj66FhZ3E6PWjdtoVDg3uqrNyab+W/gMDXInXA256F5pBwOBRFJrMMohWVIGKt3K7YfdLIgeXQz/cKYlTkvJaFwCsZQzyPgARViNY9y6Dc7CyGzIMHdP8hFWOmb/fhy06kMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784953021; c=relaxed/simple;
	bh=avjW29tbnCyDZ2DGf/QDnrW4NahUwQ9/MOddXD2lLEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qDGS9StahjMmavfkfmLdGcEd5Pr/u2t9oOqXtw2alKgVpcVP6+zTfZ8FPIRGL83H1H5jhL77C7wB0OVVsRwJPqBDOolCurWPeDH9ok37veJE4sBHL5iiMS4uiZR199Z+fc1GKKKJ1AgIk4lQJAePpZK/MH+P3MODNtiJoTUweOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M+HnmQBh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQ3zxuBu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+HnmQBh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQ3zxuBu"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DACD4EC02E5;
	Sat, 25 Jul 2026 00:16:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 25 Jul 2026 00:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784953009; x=1785039409; bh=XoFF+knuLn
	ZlgUpz/6HkqaEgq6juN6sIx42q1Sp8whw=; b=M+HnmQBhDHXDHo3kG9tjr0XHb/
	4Re+AHyUJaOXzZ7BnVkNmF4rzPjcewq8T/5TlD20S/2iXLTJI36JZ+24EadC2LIw
	rwQV6soJPplNzPVgl3FUMdu94KLXNdLf3nggtdyZrqbboVStaVXX5vb8InjiL5BE
	cutQXzXzTwf/3XgBPyikpfxkNSZI7v8ZarFyErDxM9NsAdX+83KFUHcFIEJYs4uC
	kcOwcTIIXqeC6UrDPV8ksDG4EB2avW0SRpmxOdWQXpcZ6q+Wx7bLGWk/0UfrA6Q6
	3pAbQYW9ZqzdHy6NZQjBDNyLTD7iP3QUlvScleHODy9JNM6MFJxoHp1mO9hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784953009; x=1785039409; bh=XoFF+knuLnZlgUpz/6HkqaEgq6juN6sIx42
	q1Sp8whw=; b=jQ3zxuBud8JoBuegG+jskrY9keDiMRsQXV3XHlZTWyFXEbHnuW2
	Sd9AxeFD/SSIsb36Fm/l81Yumflkypi2jlwVj0tzg3va1m+NvlXrMDE6j1R/kuy1
	6LAJkDD2GAkkW7myybuWoKBZQpKduMNGOxEwF4byy34W6Ne4uwza1RC9bD8rySXc
	XsSZobG4rjIE8yUMlHGePXuS/MNYmWakegt/jZOFg2Y/P9tnzERWtDpF0LgInJ2Q
	A3Pi5V/gCkzxLePPl4PW73Tm2Tv76pzTsN7nrt59kmu40dtt00XOdzwFMvz+suuB
	0AejdFg64FUybWywUiuAoHa71Z65ig11P+w==
X-ME-Sender: <xms:sThkavmjtFuuyIRo5RRnxQfvnLlgqKxnV8XWGV_JILyFneJ4kiaSmw>
    <xme:sThkalGLlW2-BJI1pzzHFzawwJI6FuwLgZxmcaqaMBJavnEDbFgsDbgV8GuSrPapp
    pAzUiEASHuIYvi5SK18mjz9Q6LEHS4qy1oyVOhVISCy2BuW25mGzg>
X-ME-Received: <xmr:sThkan7zxpsjJST3T2SkQfHYUASiAnXTf_CUgmfY2Rky2L76e_ullBaP_l1UXKDl6RU--2xOJmqLz12kuXnJXInv-OxGXsFMAg>
X-ME-Proxy-Cause: dmFkZTFJb11Mf5MdnVcaDv9iJp4F9gYvu/ksSaT9u3FUodBHP2Xeamk0rTS8sTy+ylBLfa
    f1IDCHPy8Xt3GzRt2k1InibI4RxjC+JNRHtJ1XYimv95lMKCzs6BbFcjcPpzht+K7CLlfg
    q0bOQFjhA5dSd+EC4ZBWbjI92+Axad1SmWWbbhLSoTCi38JwmLvnYepr1yMGsxmw9ZBAvK
    26eKlKvNpdf1Ym8JsIAiqAPhKTo9Lgpzkcqd2EJejcrUzRMsgGrqWnHL5mTqJdH8TMkQ99
    uDDO0MXC6x51MH4XbHKO0fDSuOS+B2r7zqA8UWzZNMg6Swh5/ve+ZMBhCRbZT8XlgDBPqh
    rsrf5XbB6ikbS++Okw4iOay/gLBHafheh3s2FDYgzDMeaZcjnhMo/KK2bLyIZvA82Eei+D
    XcpVdzYNM44pUQelzHJPYFwYymf0Sr+GyXskTHLiA8xhozLnc48wGEOEie28VeZiRvzZ22
    /Ym4w5C9y9xosgmm7koDEfg4sQaOejiP73IyE5Jhinfs6PUZsqCbqnxlDgiLx9jNJSl9fv
    t2xdKYgaXvyouj/BRq7/OvR1MUSStbXPAUznPIHTux9xIrwej+9cllDv7PcXvf9ydO0vUg
    GMMIaVqtTUk7Nx1BKlzPj4oj/RRwAdqAcKrpOclQ+igZBcY0r2NmHMI6zJzw
X-ME-Proxy: <xmx:sThkatlOUF2_w-TlLdc3EuTC1RnLLhAUeWl3xBEL4CpsWSna65egjQ>
    <xmx:sThkaspcyQe1al2DmZPPvDlCHutbD_GIi-bPi8u0J8FQFxC2kkoZhQ>
    <xmx:sThkastdn0KZWJclDbhPfuQsVgBwmRYrKETY2aliA7dcJKZNUyvRjg>
    <xmx:sThkahGtHYHaNk3OrsDGhLQETHYp90Hs8ek6g2-k-106Jeq2aICUBg>
    <xmx:sThkavS5WJ4SA7VAIqvpGaXNtlkT7MBUWmlhQn5oAVJmpOekl4tPyw2E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jul 2026 00:16:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v22 1/7] branch: add --forked filter for --list mode
In-Reply-To: <90aa528bef242851ca95794f06a9e9311b83a05d.1784921375.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 24 Jul 2026
	19:29:29 +0000")
References: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
	<pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
	<90aa528bef242851ca95794f06a9e9311b83a05d.1784921375.git.gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 21:16:47 -0700
Message-ID: <xmqq33x73dqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index 284796c49b..cbdac1a19a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2744,6 +2744,72 @@ static int filter_exclude_match(struct ref_filter *filter, const char *refname)
>  	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
>  }
>  
> +static const char *short_upstream_name(const char *full_ref)
> +{
> +	const char *short_name = full_ref;
> +	(void)(skip_prefix(short_name, "refs/heads/", &short_name) ||
> +	       skip_prefix(short_name, "refs/remotes/", &short_name));
> +	return short_name;
> +}

It is a bit tricky to read the above, which is equivalent to this

	if (!skip_prefix(short_name, "refs/heads/", &short_name))
		skip_prefix(short_name, "refs/remotes/", &short_name);
	return short_name;

which is written in a more dumb way.

Unless we are going to add more "if the string does not begin with
this prefix, try this other one" to the cascade, the dumb "try
stripping local branch prefix, if not, try the remote-tracking
branch prefix" way might be easier to understand.

> +/*
> + * Match the configured upstream of a branch against the registered
> + * --forked patterns. Exact patterns are compared against the full
> + * upstream refname so they are unambiguous; glob patterns are matched
> + * against the abbreviated upstream so that a glob such as origin/...
> + * works as typed.
> + */
> +static int filter_forked_match(struct ref_filter *filter, const char *refname)
> +{
> +	const char *short_name;
> +	struct branch *branch;
> +	const char *upstream;
> +	int i;
> +
> +	if (!skip_prefix(refname, "refs/heads/", &short_name))
> +		return 0;
> +	branch = branch_get(short_name);
> +	if (!branch)
> +		return 0;
> +	upstream = branch_get_upstream(branch, NULL);
> +	if (!upstream)
> +		return 0;
> +
> +	for (i = 0; i < filter->forked.nr; i++) {

The 'filter->forked' member is added by this patch and of type
'struct strvec', filter->forked.nr is of type 'size_t'.  And 'i',
which is of type 'int', is compared with it.

> diff --git a/ref-filter.h b/ref-filter.h
> index 120221b47f..9361296e2a 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -67,6 +67,7 @@ struct ref_filter {
>  	const char **name_patterns;
>  	const char *start_after;
>  	struct strvec exclude;
> +	struct strvec forked;
>  	struct oid_array points_at;
>  	struct commit_list *with_commit;
>  	struct commit_list *no_commit;
