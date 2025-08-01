Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63B139D
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754026082; cv=none; b=T4Ck48Rbi1XVjjsqeWst5K1bs0NJu/aggJTuuWaJEJRi2zQt2+WrIYNw0nRJONLWr563Mz5nX5T6z8p5VVtjDrorLNGB1jdP7wslRcoto2BSvEJluwl+2d4Z+rng9atlDqpClizzE6tvZcnDKRDdtYubHd9sQW2gLeKRb8/uzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754026082; c=relaxed/simple;
	bh=Ew+sqWEJ/8h5IidelaCc17OS3rbXSWRSj8cwLf9rArw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txdLzY84agwL/DE7jGV6/piIlfKJt4W9OGai1PYX0O/hydoLtlzxI/cBE2cDGihU4cXdfFCge72ImGktS0F0pHXx/7epUBPoCGm/DBz1MlL2mJreViHEZZzrDvgm/GUqJEhL30QmoyV4EEQvUFhvZefQmjb3L099UoZeFmCax2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FdTWuUvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1dqlZUx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FdTWuUvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1dqlZUx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 77A291D0058D;
	Fri,  1 Aug 2025 01:27:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 01:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754026079;
	 x=1754112479; bh=Q93UBgU4NdYHX7hjCAWtvxl2jHooDcCUS6RsMGTI/K4=; b=
	FdTWuUvjvR/L4tVexSU8tD5Bg2B7idxY3voNRQE1gJmo7cS9YQa8seBEWMUv20Ly
	T7U3JElERqNzr0KbbjwageekC6yFfOhqfv7vmpjLUk6Pd32rm4fC3ZTIzy2uJgJX
	SHp7TkVr2Bpya6GANCRGO8qRdIEoZuzVqC3RY6TcViYnaOekcqRGh4CQ/TEWzGJN
	yFzEr4RyGJm2goUAF+smqPKQTVNCU8Rnab5klfw9ayuKgXP6n7OyQzQuDLS/ZqDR
	a//60KAe2oSkk8nMlNeCoz+EFfrl+LgrSaKpq8eiLrX/oCUNEzprVdrgIqkwYYfg
	/pnAg2Y6FpKcNzqRVdKEtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754026079; x=
	1754112479; bh=Q93UBgU4NdYHX7hjCAWtvxl2jHooDcCUS6RsMGTI/K4=; b=M
	1dqlZUxq2JaTuBaKwlMnI8B7n+jBzi1HlsWEIn6i8MagBt3zqL/d5Vn5riXYWg/U
	mZei+ZFTpZe5boN1+5pzXJzWVyyjl7SR69qkNKamA86m05iPnaavCKG7PVk6gGRE
	iM2pzwjvZS1LXxzKoujBosuDDqEpWV21dc3qTUjMfMAlsq8/pKae2ln+DQDEsTwj
	PPhg1wU2QxtUk9TtXFhUI6gaBL08ab4glrMsmoFVU2eT27bss404p5fgFNm5XsjA
	WXe0ouQ7YXqL1MF7y7lYV4dm7SA92LEABplhkhWuB90m5wuHukedTI3h8CU72SZa
	i3nJXGCeVr80HywmPIumg==
X-ME-Sender: <xms:X1CMaGckJ9adOyjWRX0oZqE4hnanA8V2AmnbruBDE68XV-db3SnRCg>
    <xme:X1CMaAYAnG68hSnApyBHgfPfAg6cXi0Ubh_oU7F-2gUYhaSwPsb0lm9qdUEJkwRFN
    I65mibjhTf29_xzDA>
X-ME-Received: <xmr:X1CMaJWv06EX94V46dpvyRQbjRpk6o9dWlf7iBKiDA3xF5EPZbzSru-xrro2EBqur-r16VMTfqTeyUt-EMYx1QXe2ssVYaVv_UbXttVPR1zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduteehffeguedtfeevgfethefhgeevfffftdevieffjeelueetkeetueejgeekveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtih
    hnsehmrghrthhinhdrshht
X-ME-Proxy: <xmx:X1CMaCgeBBT4cRcg-AX60fDycupjUMFek2kDXoPknRdn_qHiOCOWNw>
    <xmx:X1CMaHWyUFNcf5710zvPmlgv9McjWbfThYP7n4DVZQv0_3gNH-RzEA>
    <xmx:X1CMaJPMIc9b7AKWyphId7YnUpTv1eMBUP2kHSpZPCNfALsiiF3dIA>
    <xmx:X1CMaDYkhlIZDepBaqnJvvAtbfQJ88GSzZHYDUJ_5PrEKehe2vluZg>
    <xmx:X1CMaIaStzgKIqfjS8ypy9pXKct7U-k0ajwDXtHYdjTYpelqWsT4ARkT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 01:27:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb3b06e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 05:27:56 +0000 (UTC)
Date: Fri, 1 Aug 2025 07:27:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] meson: Check whether git is new enough to support
 ls-files --deduplicate
Message-ID: <aIxQWSrnMOuEmfHo@pks.im>
References: <20250731121533.178747-1-martin@martin.st>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731121533.178747-1-martin@martin.st>

On Thu, Jul 31, 2025 at 03:15:30PM +0300, Martin Storsjö wrote:
> This fixes Meson errors like this:

Our commit messages are described so that we first describe the error
and then we describe how this is fixed, and typically they are written
in such a way that they can be read without requiring you to also read
the subject line.

So something like:

    When using the Meson build system with an old-enough Git version
    that does not yet know the `git ls-files --deduplicate` option one
    can observe the following error:

        ../meson.build:697:19: ERROR: Command `/usr/bin/git -C /home/martin/code/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*' ':!xdiff'` failed with status 129.

    The failing command is used to find all header files in our code
    base, which is required for static analysis.

    Static analysis is an entirely optional feature that distributors
    typically don't care, and about we already know to skip running the
    command when we are not in a Git repository. But we do not handle
    the above failure gracefully, even though we could.

    Fix this by detecting whether the Git version is new enough to
    support the `--deduplicate` option. Unfortunately, Meson only
    supports the external_program.version() method since Meson 0.62. So
    with older versions of Meson, we have to just assume that it exists
    (or maybe assume that it doesn't).

>     ../meson.build:697:19: ERROR: Command `/usr/bin/git -C /home/martin/code/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*' ':!xdiff'` failed with status 129.
> 
> Unfortunately, Meson only supports the external_program.version()
> method since Meson 0.62. So with older versions of Meson, we have
> to just assume that it exists (or maybe assume that it doesn't).
> 
> Signed-off-by: Martin Storsjö <martin@martin.st>
> ---
>  meson.build | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 9bc1826cb6..717365baec 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -693,7 +693,14 @@ third_party_excludes = [
>  ]
>  
>  headers_to_check = []
> -if git.found() and fs.exists(meson.project_source_root() / '.git')
> +if meson.version().version_compare('>=0.62')
> +  new_enough_git = git.found() and git.version().version_compare('>=2.31')
> +else
> +  # On Meson 0.61, we can't check git.version(), so we just have to
> +  # assume that the found git is new enough.
> +  new_enough_git = git.found()

I'd rather call this `git_supports_file_deduplication`. It's a bit of a
mouthful, but `new_enough_git` raises the question of what it is new
enough for.

> +endif
> +if new_enough_git and fs.exists(meson.project_source_root() / '.git')
>    foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()

I wonder whether we could avoid the whole version check machinery and
just change this command to `check: false`. If so we accept in case the
command fails, which we can check by calling `.returncode()`.

Thanks!

Patrick
