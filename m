Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF102D4805
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929965; cv=none; b=QboWQMN9SEfsYpi674b8lYMcNtiVdQASZB2jyVZ/zoRdSls1IXTD18Tqc1l8maqIWGcE3pbzw17KkcUBZEhVvEivAJtvMgXJEzA3ni82BoyOnu6++ozyJGQWZOhHbaJyo2NRMUgjUDgNPnOmcRS9Gynqpy4TIJ3ywLy2M5yi7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929965; c=relaxed/simple;
	bh=pSL0Y7W89ftfWe/SGVJJaj9N1dF58VgtMr3G8/13jwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pHf787SIrWctDvYamSMvSoeFgwILqqJSJ33+KhG72D3H6RQ/6HqHlq7pyU/3AaEURmZghZHlKhqa9oXJrXt3z1JEqGDPV6Pgj7qS6X5Y2/gAjo81vLcJZb44RID97Heqb58aMGc6rtbQQBQQFgiEvTAIeJFOQrYGOiJPIz9JBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A1SzuQF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ol+jsz+b; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1SzuQF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ol+jsz+b"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E549A7A012E;
	Thu, 12 Feb 2026 15:59:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Feb 2026 15:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770929962; x=1771016362; bh=YxpVcO6mWS
	/NFqKVvt8+sQ6Y6CKhaJ+oEb48fB5YikQ=; b=A1SzuQF0GxF776Sfdu0E9cdh5x
	ujwnAQHvWUrNFjHHdx3ruK0RgWJgilSjWNXrnLruBfDJm8iU2itFMixH2s1uujg8
	GI5LJFvwigOnPBEG9S0NmCz9LZXIGEYFfyUj6gGOq3/AiW3EUnfhYoG8fm2Rz76e
	t8LNjzLzH8TMEPGb5cMJFyOHXxZrt7f3Ae9cszaZWD2mxRiFtO+/4/o8BCJzoSSW
	cupRhTmZ0qx9p45crqOSsV4+IIuk1Sdmt0FyNSlnPq/OKM8QZTh54L61iXFuWYc9
	4q3hqrUxi9LmYZl5vSek9JxRv+8ezYLI3ooNOZsQSY3DUES+NpTJwOkEI8cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770929962; x=1771016362; bh=YxpVcO6mWS/NFqKVvt8+sQ6Y6CKhaJ+oEb4
	8fB5YikQ=; b=ol+jsz+bJIj6wnGLvMFfgTIPR8IV7Y9xd6Ciwhvj6V3R8yzW3Zc
	xptOvrS31gtY0Tm9tv6atgooL3rVuGmi8WeyM3+Agip1ppkNDr5TKXKE9mAKjCDV
	3GowqP1BMzfP28DiyQtBL38wG0jRmJ3R8e4TnyogqsOtDOiMpXaXy3oF7s0WGmhi
	loYasfJE/QXZvtwWJTYsqq7KOa0QmUejlsYJMKvQ+edwY1AXYqvercpTc7uV/N9h
	IbMKJ0CTN8YY/lfuCbktJBbX4ud3Ke51zZrjYlwfnuVZLizjuJxBeoMUGFl1C/N9
	0n5+QipeyMmu7vE6olrnQqJFwzUWX7otWjg==
X-ME-Sender: <xms:Kj-OaTZQMMXdSTps_I6gkBG6tbIXCmhIZqaqHUFh0FgLa7ZJUWAHzw>
    <xme:Kj-OaZ2iPNU5rETTw1AiR0ZQtL02UC1fjzgsYn-soGGNxw1pDPkArNAwN-KuRVbnD
    ApIg8QF66Dgt1neD8QBP6gxCRudO-gEIgz94ZHngI3nqf0tFAZRZgQ>
X-ME-Received: <xmr:Kj-OaTVTJIiN9gDFhf3-kEVnfcD-dGvoQiskxMFltLQWKrt11d-GAmNt-1KZv88AoX4rkfFC67GPPll8x24eqCjyCMhXyhQQ_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Kj-OaTWP3y06-yB-tLxPYI3SNJlBo3QI5wkciWhI_nd5k7wrEAPYNQ>
    <xmx:Kj-OaScTF8gAjzK8AUKwLRs2kTW6usKK1Qc4vaZIWgjhMfdZeB1mqA>
    <xmx:Kj-OacWyjXEi3HSSTIyaTaVBarQ92ahdXPQc3nPVKI_FZhpdgO5U8w>
    <xmx:Kj-OabclYbk_wO54O0oxaABgUnRuqh6n7XEEt-brEt5aIkZVwho1uQ>
    <xmx:Kj-OaR3T13XKf5z6l7gM3KKeqARkdxz28MnNQNYMqIim7MAXD6bAMuIZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 15:59:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] setup: fail if .git is not a file or directory
In-Reply-To: <20260212172405.48614-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Fri, 13 Feb 2026 01:24:05 +0800")
References: <20260211182122.35352-1-a3205153416@gmail.com>
	<20260212172405.48614-1-a3205153416@gmail.com>
Date: Thu, 12 Feb 2026 12:59:20 -0800
Message-ID: <xmqqtsvln0ev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

>  		if (!gitdirenv) {
>  			if (die_on_error ||
> -			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> +				error_code == READ_GITFILE_ERR_NOT_A_FILE) {

Why this indentation change?

> -				/* NEEDSWORK: fail if .git is not file nor dir */
> -				if (is_git_directory(dir->buf)) {
> +				if (is_git_directory(dir->buf)){

Why this change (which is style violation that lack necessary SP
between "){")?

>  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>  					gitdir_path = xstrdup(dir->buf);
> +				} else {
> +					/*
> +					 * It is neither a gitfile nor a git directory.
> +					 */
> +					struct stat st;
> +					if (!lstat(dir->buf, &st) &&
> +						!S_ISREG(st.st_mode) &&
> +						!S_ISDIR(st.st_mode)) {
> +						if (die_on_error)
> +							die(_("Invalid %s: not a regular file or directory"), dir->buf);
> +						else
> +							return GIT_DIR_INVALID_GITFILE;
> +					}
>  				}

Stepping back a bit, even though the NEEDSWORK comment is placed
here, I am not sure if this is the bast place to do much of the
necessary work.

When gitdirenv is NULL and die_on_error is set, we would have died
on any error other than STAT_FAILED (most often, this is because
there wasn't .git at the path in the first place) or NOT_A_FILE
(again, a happy case is that .git existed and it was a directory).
We would have already died in read_gitfile_error_die() in all other
cases.  But these two error cases are not necessarily entirely happy
and that is what the NEEDSWORK comment is about.

So, if we wanted to tighten the error checking to help users
diagnose problems in their filesystem, I wonder if it is a better
approach to refine the set of READ_GITFILE_ERR_* error codes:

 - STAT_ENOENT (new) is returned when stat failed and we got ENOENT,
   and it is not a fatal error.

 - STAT_FAILED becomes a fatal error in read_gitfile_error_die().

 - IS_A_DIR (new) is returned when stat succeeded and it is a
   directory.  It is not a fatal error.

 - NOT_A_FILE becomes a fatal error in read_gitfile_error_die().

Existing callers of the two functions, read_gitfile_gently() and
read_gitfile_error_die(), must be audited and adjusted
appropriately, but once it is done, it would become much simpler,
wouldn't it?

Thanks.
