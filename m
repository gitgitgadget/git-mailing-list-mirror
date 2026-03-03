Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504C370D63
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555962; cv=none; b=ganpUg+UgP1EEqNDqAwKC8hXOYkg/YT9GP6RutASgga5z0WCqaZ01QzEBHz3duyM1ENJtz8/Ci+4gk2O5DcBDb7hYbl2J6yYh8lV631TePDodZ8a11geu27R8+7oWxeFaJr5Jd4iQR1+gEdDPjeZiTuIXbXuwaD5vmwtoJWcUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555962; c=relaxed/simple;
	bh=cnE/PNFd4qdEUUjbhEbodio5Mj9IidA8Lp49Bcybjv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gumzx8iOSlFq6yUv3qUihYjWiVHpw/Km6nHvkB2lhxX+sjqB6mRyiUtXm7FaWA6isUFWVWZ58A3op+DLW4s51rJNHvC0r9j8zSffDpfCV8Lz+bBajrOuhPw8Ys7uBsJYgzefQaTkcwnkJ1B8cdhK94xsa6Pa8ps1F2JPCaEnc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fzGIZNzM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zZD7z7s6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fzGIZNzM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zZD7z7s6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C06DEC0571;
	Tue,  3 Mar 2026 11:39:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 03 Mar 2026 11:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772555960; x=1772642360; bh=6Z/cM+29Xa
	2VHR/vFvsaUZjYVmDEQiYrDqMyynJScBw=; b=fzGIZNzME9wgijAcAl809s2dB+
	lNpDmDDcY2J6lJHafrwqBAecC0hBko4EhAGKRcj0PjvqFNQIBeV9DvKQrZymZzTq
	sTZczPssnOW/O/XyYxyRA2K7Ttr/oUwIiTIjQinfTdpUIt52KI8/dEtyCa7HqC3z
	ZksGA7voMnLgV1ovmaJ4jn9kTc5wLPoHc66KC7l1xR/IShUzeoIvfKexjWilDF2h
	hVMGYDSd2H1ft8jYE+EL8C2AnXoo3kA3CNvhNsL3JjZWeJhdzMO+7movsCKExIrA
	DS7/8ac7z3spkhvJ5aV3s6y1Ry1PRgBCAqwCw6jtoTgKcSmB5rb3y963s59Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772555960; x=1772642360; bh=6Z/cM+29Xa2VHR/vFvsaUZjYVmDEQiYrDqM
	yynJScBw=; b=zZD7z7s6MWkFc8jh4a4A2iBVCZmjaqFkECdkgbFkv2uoxZU09BY
	YF2CgXaUXSQB/otwtP6NbxSGH8OJmjR60ZtHXkNfn5f0Ep1jibjOEnXDvREgnvZA
	GGsrZeSoTmMcZYAmdcLrYF5Mxy8+8BELhTSJgWQKocu75cHYvb9KSTiT6oCHqzGc
	bgxu/1nOMAehjgcCI2L6tlqx+txl2yCTx6xcpj42TVF+f3RnQ5WpfJWFAVXrwaWa
	ls9towqyjDuPAGWQfywtdOeVqCc/pdLs4m+K8KX13Suqu4AXyfj1kWAi6mKfMpUH
	oNTiZJ0N9+04AMUo+6dJSAuQPgDUgGOtrMg==
X-ME-Sender: <xms:uA6nafS6lHbQzvuyMKbz75rUgbE_3b4ah7XtsgVxShn-_7nJ1Tb7cA>
    <xme:uA6naYPJDMCDpTiJ6JWSJI8pD7-3KfEu8eUJgiTVncjzAtUkJ3gUIxfUmxVLaf2ij
    K0EAkCxypp7YVNTtEJxW1u0CPXzpiIJTvTb_hJz9m9shbTQxMEvCQ>
X-ME-Received: <xmr:uA6naSOHv9XeMUiCOcddadnoncy4x9HRqx52SiB4n0WVfxIR6KbBvZj8IWxXVPZRKiTABQMgoLLJF3K2XpI2g6s9vf2DgNTnxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedutdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtd
    dtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uA6naYt_BO2S34saQ0YgfB2Ykn0FsgZOb2XXL4Penb3nzZxTACrgGA>
    <xmx:uA6nacWrBn5Z_HrpGlqKRNU_Q0KIN6cCFYbc55_iM89cVKQe7CoC3A>
    <xmx:uA6naQuiV-GT_FiV4klKn7OpcX5LP7wbpi4-CE6RZR8bo-ewKOgQEA>
    <xmx:uA6naYXq3AeF_7ZM9UL71aPl5HzGaXZkHtkHNDJl4-Li-cOm8rTUtw>
    <xmx:uA6naYNVIXUuERxivnb-t1VRAc6yIuCu17Y2im13qRQWt8cexic2Gk_F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 11:39:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] path: remove redundant function calls
In-Reply-To: <20260302142138.712273-4-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Mon, 2 Mar 2026 19:51:38 +0530")
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
	<20260302142138.712273-4-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 03 Mar 2026 08:39:18 -0800
Message-ID: <xmqqwlzseukp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> We fetch the exact same setting up to four times.
> We fix this by evaluating it once, storing it in a local variable,
> and referencing that variable.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  path.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

The function body is guarded with "we initialize this just once and
return the value stored in a structure member", so 3 among four of
these calls incur only cost for a no-op call/return, but using a
temporary variable on this caller's side makes it clear that we are
not expecting any recomputation in the callee.

> diff --git a/path.c b/path.c
> index 56be5e1726..5cd38b2a16 100644
> --- a/path.c
> +++ b/path.c
> @@ -741,18 +741,18 @@ int calc_shared_perm(struct repository *repo,
>  		     int mode)
>  {
>  	int tweak;
> -
> -	if (repo_settings_get_shared_repository(repo) < 0)
> -		tweak = -repo_settings_get_shared_repository(repo);
> +	int shared_repo = repo_settings_get_shared_repository(repo);
> +	if (shared_repo < 0)
> +		tweak = -shared_repo;
>  	else
> -		tweak = repo_settings_get_shared_repository(repo);
> +		tweak = shared_repo;
>  
>  	if (!(mode & S_IWUSR))
>  		tweak &= ~0222;
>  	if (mode & S_IXUSR)
>  		/* Copy read bits to execute bits */
>  		tweak |= (tweak & 0444) >> 2;
> -	if (repo_settings_get_shared_repository(repo) < 0)
> +	if (shared_repo < 0)
>  		mode = (mode & ~0777) | tweak;
>  	else
>  		mode |= tweak;
