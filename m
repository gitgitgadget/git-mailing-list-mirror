Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C701362
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736301914; cv=none; b=hIXnHCzmjq8El3/6DlfmSQcak+Hhz97hU3drzJaNnJ72EDNlGcBknSq7Tzz5/yVvTFVT3KNjnsDSaqIbJASy0Zq7a9U2Cbnh/c2hfWkMKC/hQ9us0pnjqbmFaQE3+mPdwTdwE+N1riiLTPi1DGDQfIp1plJD14TI07I3CUlQD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736301914; c=relaxed/simple;
	bh=TgV4X3nJliC17b+/wC9mZ+Ug+CrsdOVFQBgYVMvvhoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcCcnVQwGfzQqR2wcIMdEgSmAA7EDSSQ6ZTrPiQ+WuQa3nPpKeWdu1mDnXTebBJbo+m0mN4K7+eZwUei1q8dZaAvn5DY4SnhmQFxnmZT3TTRunrOrYqr155NcRvUhLEtmfotVQmFzOvoXxaKNaO5QUIxFL3zq6XtWWLzNSsZyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sqc5u2w3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrs86PDQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sqc5u2w3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrs86PDQ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 93B3713801AB;
	Tue,  7 Jan 2025 21:05:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jan 2025 21:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736301910; x=1736388310; bh=ijx/ItAjBu
	yFtW9aK/TN5i20/3obRc8X3lK9CrxR6jw=; b=sqc5u2w3UO8UJYz0bW389PdtU/
	79bWIkYx7UPYd3z5NhwFn1qQ4wUij8jXrud1OpiZBZ9ZM6mHMsyRBPLX1RYSknWE
	4j/mK+vsBGOYNW8Y7aLqfQyx9rEUY46kBLu0SouJSmnKX8KQov6D0+pgZw1cn1tw
	wl/WB6+tcbimcqsvh7g4m5q0BheGm/YbBtOgU95sByaHUtVyzgJtg5/hRpyRCe+9
	Jdv2mTMM+0uXrZMmeobipNiYTH4lKhO2qVI8NvRngc/Avpik+zizcX5iqvS9t6BF
	EHr3JO7gYPuD9Cuc1vbN85sj9yjHdc9WijmZVORopM7VA7aE+AwgOlYbz1kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736301910; x=1736388310; bh=ijx/ItAjBuyFtW9aK/TN5i20/3obRc8X3lK
	9CrxR6jw=; b=rrs86PDQnMzKbp/tWwu3Y+HA+bZfYnCUx7Tq+scsUmcOhe2s0EO
	DT1IranBldm/Aw7UM55HiPCz+Kp7On9sXLFo8EygDsUv/VBMogdgyCGfp4GLP0Rl
	O+5EgQcA3J+TDaBbRIoqr4o1DlyDrnlVl4vGBCeJcfB+M1fr9B5nr4bcTOewbMMZ
	CJ9uNgjT0wv2/ybELdFcOlbtGkNDm7/3WNPtWeeLxgUyc9aKoY/ctS05aQdjVhyf
	Is277bbMNKe+H9FEBsaee5nnb0PbIvpC3XfUJC/4N5sbibe+2lTshmKN9pyjH/Pt
	OWLfnRXYWoeBxbdS5LCC5+nTeTGscSV7y1w==
X-ME-Sender: <xms:Vt19ZwcZZrp5gMbeIiaIekL65dbgaWy7P7eEU-YLqrjph9JzA8U76w>
    <xme:Vt19ZyMOX4R_VLCwHOiJFowaDVj3eQFrRDKV4DVzGZhzttaxOe33ZJNTgJtfgmYMN
    J-tEYrcYBpKFfaaYw>
X-ME-Received: <xmr:Vt19ZxjP0Bws__8QaDKH04DkrlziUEwKUhIaWBw-gsj1MLtd9dQ0PB-gDoq1keJ4DBniqUNdJgOvi9jHFUNQFCdS_D42NEf37o4d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffefjeeiheduveeiffejieekhedufffgtedv
    hfevudeugeetkedtiefggeehgeetnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpvg
    igrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Vt19Z18p-91tJ_HTXe93mY5zBSovB4vo2BLIvXFcZsJ6Q_mQJyPlGg>
    <xmx:Vt19Z8u78-w99ofBbu5_sHx5NAqvZC7EJ_lbwY07nr0h8kAmT8o14A>
    <xmx:Vt19Z8HziYihIACX2lhHhXC_ZcnkdOql6QJ2BcFKMXHuv-m-z-2pQA>
    <xmx:Vt19Z7PARZr7N7dHXeip-wkb3xTQ3QSEldK9rtovCDO3hSwuLjdYCA>
    <xmx:Vt19Z-KSfZG7gMlNDVuvFCku1F6URY8P4NWD1Dz-ayhGUdXVFKw7IkxK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 21:05:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v4] credential-cache: respect request capabilities
In-Reply-To: <pull.1842.v4.git.1736212760709.gitgitgadget@gmail.com>
	(M. Hickford via GitGitGadget's message of "Tue, 07 Jan 2025 01:19:20
	+0000")
References: <pull.1842.v3.git.1736204756030.gitgitgadget@gmail.com>
	<pull.1842.v4.git.1736212760709.gitgitgadget@gmail.com>
Date: Tue, 07 Jan 2025 18:05:08 -0800
Message-ID: <xmqqttaaoyaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Previously, credential-cache populated authtype regardless of request.

OK, that may be a correct statement of the fact, but it does not
tell readers any of the following:

 - If it is a bad thing to populate authtype regardless of request,
   and if so why?

 - What is the (negative) consequence of doing so, if any?  What
   breaks because it populates authtype regardless of request?

 - What is the remedy?  Instead of unconditionally populating the
   authtype, how does the new code decide when to populate it and
   with what value?

 - Can there be downsides of fixing this?  Are there use cases where
   this unconditional population of authtype was relied upon?

 - Where did the bug come from and what is its fix?  We used to look
   at OP_HELPER to decide when to emit authtype, but the updated
   code checks OP_RESPONSE, which readers can see in the patch.

   It would be nice if the proposed log message helped them by
   briefly explaining their differences, for example.

which would help future "git log" readers what this fix was about.

Will queue for now, but the log message would want to be a bit more
helpful to the readers.

Thanks.

> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     credential-cache: respect request capabilities
>     
>     CC: sandals@crustytoothpaste.net
>     
>     Patch v4 fixes test
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1842%2Fhickford%2Fcache-capability-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1842/hickford/cache-capability-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1842
>
> Range-diff vs v3:
>
>  1:  e9851c5c4ac ! 1:  23942f9fa47 credential-cache: respect request capabilities
>      @@ t/lib-credential.sh: helper_test_authtype() {
>       +		protocol=https
>       +		host=git.example.com
>       +		--
>      -+		capability[]=authtype
>       +		protocol=https
>       +		host=git.example.com
>       +		username=askpass-username
>
>
>  builtin/credential-cache--daemon.c |  4 ++--
>  t/lib-credential.sh                | 15 +++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index bc22f5c6d24..e707618e743 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -142,9 +142,9 @@ static void serve_one_client(FILE *in, FILE *out)
>  				fprintf(out, "username=%s\n", e->item.username);
>  			if (e->item.password)
>  				fprintf(out, "password=%s\n", e->item.password);
> -			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.authtype)
> +			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.authtype)
>  				fprintf(out, "authtype=%s\n", e->item.authtype);
> -			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER) && e->item.credential)
> +			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONSE) && e->item.credential)
>  				fprintf(out, "credential=%s\n", e->item.credential);
>  			if (e->item.password_expiry_utc != TIME_MAX)
>  				fprintf(out, "password_expiry_utc=%"PRItime"\n",
> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 58b9c740605..cc6bf9aa5f3 100644
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -566,6 +566,21 @@ helper_test_authtype() {
>  		EOF
>  	'
>  
> +	test_expect_success "helper ($HELPER) gets authtype and credential only if request has authtype capability" '
> +		check fill $HELPER <<-\EOF
> +		protocol=https
> +		host=git.example.com
> +		--
> +		protocol=https
> +		host=git.example.com
> +		username=askpass-username
> +		password=askpass-password
> +		--
> +		askpass: Username for '\''https://git.example.com'\'':
> +		askpass: Password for '\''https://askpass-username@git.example.com'\'':
> +		EOF
> +	'
> +
>  	test_expect_success "helper ($HELPER) stores authtype and credential with username" '
>  		check approve $HELPER <<-\EOF
>  		capability[]=authtype
>
> base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
