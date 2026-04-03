Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937D394787
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238794; cv=none; b=coS0N4jhmmo0sQEY+Iq1KGATEVgjr7KkFPSZhgJEkz3p5n6hZWewcvcEdZ6guD4EhlAJDU8pg/s4LS/eIox0SelaxyHxZCULZfInQjzOLBlAxCU4NVTZ7IbmlKTElWVJvgqzl92zaQvhglXZCqYJxhRxblOvkOl3d9js6/qeLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238794; c=relaxed/simple;
	bh=F87gvseUFgK5Sw2HoPq/dByhetNJ6KQ2SP1hcShXWLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n67chOso7RMSdwtO0XBrqUwm3KktMZaSiyan4ibtUtoJOXd0pUnlea3/lDde35tbsVVeUrqVop3Kpwxp/Sq0sidsyRyQg3YuQCMJGOyarxa6E5jEg29uLBlbG6vyaFAADpFrX7gg5lSUMYtUtimMip0r0C/c5Q5Ee9a+DGjZJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LQXgtgwA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sbD8zqYQ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LQXgtgwA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sbD8zqYQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F5AD1D00038;
	Fri,  3 Apr 2026 13:53:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 03 Apr 2026 13:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775238792;
	 x=1775325192; bh=fFmw+0V3aP64pgGsaP/SlbWamZsphQvjhnhAaMFe3DQ=; b=
	LQXgtgwAVRnYJRNrwR+LmOVpS2cjL6VLNbgSmja3EMTKkuKODFE+9kralHY0/bmZ
	dryQv2Di8Z1Pr3A5O2EY3gtluU9BkPpkxmAV5nmc43srm++HLDoSAhZ4rkp0Zr4t
	bSKU4sxQUmOrUxreq4CTx/pANy1dWmn1HTbjEQDPHxRKw5ixKxOdNlqrZ7g9IMsU
	rZlJPCslTQBamlHDz4vE0iYkSODeKB3EaiMgbQpJgS4ornPS4rr0fv2S9LIhWjM1
	XDhLpDPOUCvJl2YG6pCAwsZuO9je1Nq+3BGEXVD9iRnpUevP3xefSHvgJdKUdMIU
	ltAgBLT9Fs9qQqdAgeGKWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775238792; x=
	1775325192; bh=fFmw+0V3aP64pgGsaP/SlbWamZsphQvjhnhAaMFe3DQ=; b=s
	bD8zqYQwPMsig5HDaHcxCR66gHsjFkt7iWQGE4oaXkpQfyTRkcxXZTdDdiqamfjw
	yTlYl2VH1Wqn/ROyQrScva4LMtw7Hgm+sXSTHyEdJhH2dbRC3OeACdOFZWuucxhT
	Yrqgm2qp1gXWBCZMzUM77A9G3AP5xrChNZi/2Zv5Cg1pnS3ZJcmlmiyNtUm75RXm
	fR7yejSyFh+3M7aTo27n7ISoOk2gRpaTCzcSy3+4bYR2btvpUMlMKdtWMw+FWY5/
	NnkwdlZGQZzBb1T/p1lLSd/9dB0UBZecwvxAN+OHGFxQn7fuJqPeBH0dief2lVEt
	dOsS9yDfZ0lNuyS4yiTPg==
X-ME-Sender: <xms:h_7PaU9j2V1hYGNR-7R_qYGbK-7lhMcwQjPfpFmwFsayg_lZF27Q6Q>
    <xme:h_7PaTsDy7ZZgBykdoorxEtDwuHR6khpDjqlWKuafFT8Rlx6bZnD-Gey61RfEGS4-
    CZHH6v4b8KorlBdaS4BdM_kCHWhIe4_s7bwwpOMqkTrGxEjDx6c>
X-ME-Received: <xmr:h_7PafBvpctJiIfcA5LKIJOscT3go5V0maLI10XiaWvxFL17R-RocHhLcb4aymsAUD38mKFXVV-XNGNxcfjSuqSzybKne_Zv1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohgvrhhgsehthhgrlhhhvghimhdrihhopdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:h_7PaTVXYoIhfJz2p9NxLjpq8lTUQSjZ2LhkWuEzpkOYwnk3cJqmcQ>
    <xmx:h_7PaVD1VeYQ-2sAzPYAm0jwHoWNg2VjgYaLboY5lAQs5tPpac596A>
    <xmx:h_7Pae-gVSGiwc38_oo240NosEQAE9ROXtzETojRcLIFQ72_N32s8A>
    <xmx:h_7PaUFTS0b171fZK_I4vsjTroitfqeiiHibbDE1kzxu6IAL3Yi_lA>
    <xmx:h_7PaXGyX7SfDfPKYourD-AbYNh3tmPqZCJd9LDEJt-u2D3UDgSWhJcC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 13:53:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Joerg Thalheim <joerg@thalheim.io>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] config: retry acquiring config.lock for 100ms
In-Reply-To: <20260403100135.3901610-1-joerg@thalheim.io> (Joerg Thalheim's
	message of "Fri, 3 Apr 2026 12:01:35 +0200")
References: <20260403100135.3901610-1-joerg@thalheim.io>
Date: Fri, 03 Apr 2026 10:53:10 -0700
Message-ID: <xmqqzf3klym1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Joerg Thalheim <joerg@thalheim.io> writes:

> From: Jörg Thalheim <joerg@thalheim.io>
>
> When multiple processes write to a config file concurrently, they
> contend on its ".lock" file, which is acquired via open(O_EXCL) with
> no retry. The losers fail immediately with "could not lock config
> file". Two processes writing unrelated keys (say, "branch.a.remote"
> and "branch.b.remote") have no semantic conflict, yet one of them
> fails for a purely mechanical reason.
>
> This bites in practice when running `git worktree add -b` concurrently
> against the same repository. Each invocation makes several writes to
> ".git/config" to set up branch tracking, and tooling that creates
> worktrees in parallel sees intermittent failures. Worse, `git worktree
> add` does not propagate the failed config write to its exit code: the
> worktree is created and the command exits 0, but tracking
> configuration is silently dropped.
>
> The lock is held only for the duration of rewriting a small file, so
> retrying for 100 ms papers over any realistic contention while still
> failing fast if a stale lock has been left behind by a crashed
> process. This mirrors what we already do for individual reference
> locks (4ff0f01cb7 (refs: retry acquiring reference locks for 100ms,
> 2017-08-21)).
>
> Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
> ---
>  config.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

OK.  This is consistent with the default used for a ref update with
files backend.  Various subsystems use their own value randomly
chosen out of thin air, it seems.  credential-store uses 1000ms, gc
uses 150ms to interact with launchctl, refs have their own per
backend, etc.

> diff --git a/config.c b/config.c
> index 156f2a24fa..f7aff8725d 100644
> --- a/config.c
> +++ b/config.c
> @@ -2903,6 +2903,14 @@ char *git_config_prepare_comment_string(const char *comment)
>  	return prepared;
>  }
>  
> +/*
> + * How long to retry acquiring config.lock when another process holds it.
> + * The lock is held only for the duration of rewriting a small file, so
> + * 100 ms covers any realistic contention while still failing fast if
> + * a stale lock has been left behind by a crashed process.
> + */
> +#define CONFIG_LOCK_TIMEOUT_MS 100
> +

Making this configurable would make a cute chicken-and-egg problem?

;-)  No, no need for that---just kidding.

Will queue.  Thanks.

> @@ -2986,7 +2994,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
>  	 * The lock serves a purpose in addition to locking: the new
>  	 * contents of .git/config will be written into it.
>  	 */
> -	fd = hold_lock_file_for_update(&lock, config_filename, 0);
> +	fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
> +					       CONFIG_LOCK_TIMEOUT_MS);
>  	if (fd < 0) {
>  		error_errno(_("could not lock config file %s"), config_filename);
>  		ret = CONFIG_NO_LOCK;
> @@ -3331,7 +3340,8 @@ static int repo_config_copy_or_rename_section_in_file(
>  	if (!config_filename)
>  		config_filename = filename_buf = repo_git_path(r, "config");
>  
> -	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
> +	out_fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
> +						   CONFIG_LOCK_TIMEOUT_MS);
>  	if (out_fd < 0) {
>  		ret = error(_("could not lock config file %s"), config_filename);
>  		goto out;
