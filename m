Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029E30214B
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587774; cv=none; b=Eqp8L1BxrH5Z5bDfQjrMsjXvI/YwJACFFbuRcpholcVRYZWwOKsjZx1O/3aIaXoNAp4Hsy6gi9iIQR8AqnzNB1lAF2YQ8wTPwyOH3BEu1/2sLAy4RSKEVnrKmBB9wsbgFeYj5USOFnLQCmkLqM5woirpExT5oXWP0uhtrBqamXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587774; c=relaxed/simple;
	bh=XEXtsvu/P0llx6PNG0cBfl/IieOqilON601dCnsnhKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O01Wi54xz0UhdULyA1HyXBYUVY6b2elm9dNZ49Ns1mA86GnuNUPoF67yZdkzpIdGGXefGGvsjvqGUphSph7vXwELk48+xYQjOHqEzK2cxeU2SHcX+imE/a/cBrQmxOfznLoylxgvaj29jpoD5XZydk/qs7E9418JgkOVlsfJ5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fb430uAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVagnIw2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fb430uAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVagnIw2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 55AC2EC0128;
	Fri, 16 Jan 2026 13:22:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 16 Jan 2026 13:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768587771; x=1768674171; bh=pGU0Q2Cp9B
	MjmKLQLd/O8MuHI3SxDE2BwZOu/x4TJiQ=; b=fb430uAb2EHtMKfTuz3NDU7+PS
	ZS5xdlEb8zBIT3DO9Ae6WcJ0lBwHHTfKri+jCisP1n5tpFtcYolQobYywdUDrmBy
	Jr5gFW7sjcxXjdJDKTe+cgs2S31sY/wnRO7hsV2EFtbQcTcUH2kLmm3o+aGbDqG7
	5UyQdhmSDB2YWSBcWyBmtnydrOI360eEkM2YDulENgmdpuWC8TVrNEj3xatuwfF5
	g8Qz6oIp8rJvFVSnElAXujNzypMvPpdhOprAG2RlnnPjl+jYpBM5MGzx/SYNL9Qi
	Or9qrddkgMVfrG81sJ8oUHFUSBgXsiEu6huSqchV0B9OHKqOk6fh4wU3gn9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768587771; x=1768674171; bh=pGU0Q2Cp9BMjmKLQLd/O8MuHI3SxDE2BwZO
	u/x4TJiQ=; b=IVagnIw2InGBJppWzghHzbAMEXSk6aXMM+oaFH4iYV7tJDYB+07
	7WvLtnmVzhiRz7QUJbMWwwBrRRyHNgmzoKCRjide3CW6N2tZNrka6DqATepaDNs/
	KES2jOiub1V6w5caW9SdPPKK/ciUFZI2lL23OyPJIFkxFcBRthoyc6ptHnJv/gM8
	+Na3zfB6KGG6exLNR9GL4IOFXwvO1KRkCJ6feP5nb3lrfU4kegrwsxVtMsKgFzSO
	rjTBnNWy3gVRNyooHFDe4FNoosNJuMQ/F/N86BBi4z73apsAh4EXmPExSuQhZJwf
	rXEFItLIpA7LWVGOF8BOZKkk+4tMkofYXzg==
X-ME-Sender: <xms:-oFqaeX9OW48zlEjsOS107p2G6KhhWQQbHMCUx8Uk_o43-X1gacbXg>
    <xme:-oFqaeQZWqVN1SUt5u7deS_grawPjLZELqXo7PZuUeRvn0fZyOcNVjtksDv_dDXBD
    vAbWMt1pOFLu5DvQkrHknxQSYEguULchg8IbTZG7FpfBgZaf3Pb7g>
X-ME-Received: <xmr:-oFqacM4kzmJCK0bkSH8YIsk6YGlhub5R_9cJDsDSXAn70F5pVYMI3x1MLSAYEIKilzQPf2qqpxxG982c5IOXig6-GawJOHEx2I3bkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-oFqacTMXxpuES8yODK3Kw-oVcTG8txWA0mf39WvOxwQBjiaAYxwwA>
    <xmx:-oFqaagW6G_ui6z02LZz5_ga5q-OyKkRnqIUe0GsvxQ3UU-rKyd4kg>
    <xmx:-oFqaV-0PEzxn19MKvXrYW0fPeysf_RyCbpyhKrhZ_JHknH3N-Y7Qg>
    <xmx:-oFqaRGdgrePuTnUjT4e-uBxSpqN2yeFYySgkgEu6eS_eJe744MXNg>
    <xmx:-4FqaewBmUXnJKJ1JrRqYuafs0LrJgYBOt7wCEhGBFLWQBfxP1VHvXJb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 13:22:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v3 3/4] last-modified: remove double error message
In-Reply-To: <20260116-toon-last-modified-tree-v3-3-e6ade4dc35ab@iotcl.com>
	(Toon Claes's message of "Fri, 16 Jan 2026 14:08:39 +0100")
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
	<20260116-toon-last-modified-tree-v3-3-e6ade4dc35ab@iotcl.com>
Date: Fri, 16 Jan 2026 10:22:49 -0800
Message-ID: <xmqqldhx8lja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> When the user passes two revisions, they get the following output:
>
>     $ git last-modified HEAD HEAD~
>     error: last-modified can only operate on one revision at a time
>     error: unable to setup last-modified
>
> The error message about "unable to setup" is not very informative,
> remove it.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/last-modified.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 06e3f79aec..0df85be318 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -495,7 +495,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>  	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
>  
>  	if (populate_paths_from_revs(lm) < 0)
> -		return error(_("unable to setup last-modified"));
> +		return -1;

It makes perfect sense to keep the more detailed error that
immediately leads to a more correct action and take out the more
generic "we failed" one.  Nice.
