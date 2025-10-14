Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DA1F63F9
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473934; cv=none; b=O/YD3Rp6o7MOZqQWywf+pqLB7PVetC2+MNe165n+Cc1Lf2I8k7L2ClH4S7hYOsydIEwSfkpTK0r29mgNToXF7qGxhVsPavNB0osj9xawhDxuhTIj0ALSRbbfUqdnsLV+fsItbCCx9pkn8/yJLueIokY+xhS2tZDUZb62nPRgz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473934; c=relaxed/simple;
	bh=Ori8Q4uK5soyFTjh00OGLHWoEeedOHttTYWBLqMrcGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOE6s2hTiQUauaMXrKBmLthrmj7ZBEoAjotY2pSaLdwEpsL1937ksSLAT3+98/C2V9tUvavmFlvmkVcsvd6Gknq6epZTKWBUUsi8syh8Fyn98QXzNUJqxO0ZKzvRE33jllVhMTV47g/FBqneP/z+ya6PnxAIAEAWhFEG3FAr6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LeIihljB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rD4RuJc8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LeIihljB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rD4RuJc8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E3747A00CD;
	Tue, 14 Oct 2025 16:32:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 16:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760473931; x=1760560331; bh=dpHGUyt1Pt
	olIvmtN6RmgLNqJeR0mbTloURtwrqpqnE=; b=LeIihljBjjGm34Q7kXKRKpHkOK
	jtReOk65pFTfrMl2Gqjpvn3o+o9Pgzy+8j5Voma7BdI1sYD9HzrZY29zsjK2kRwn
	bdmsHwgigghyxGtoTNmK0X/HiQv1vD2QcN1MFkX9M9M+PR61w1bN/F1YC369WNjX
	982F3rj9zpppMCj/OeZuqTA93jEqvsI8HE/57xk+oRsSE5xZMoIZTG8l/RD5teu4
	hhc9zUclgpRMJ2i7OkRyrGRuzLj8i9fUx5dZbRZ6uJ0Ys6/RrpmwmOjSlhyI814P
	8OZTZFIR0yuczOXy1jxihfNWw7J2QeK4uwaIL7CEIp2hdHPAtavTzpsIosfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760473931; x=1760560331; bh=dpHGUyt1PtolIvmtN6RmgLNqJeR0mbTloUR
	twrqpqnE=; b=rD4RuJc8b8b2E7OLX5ovR3Csw2o2C5XgEDJ4Dm7fOHsOj2dOj71
	EqcYelBxSNS0XGB7pAznRrb4U1jtUx2z6JMaKawDx6jNtLXUwTvYxNarW3UZc42X
	YAtIGiIdGWunrxAzJ10iyPcC8zMcfoG9SmmnV2Y2XS69DaqwM0vFdVUATVzAJE7v
	sxIKOOagf02bRYD1ADHMd4qoz+w6ZARYrAnsDqmDfYTmM718H5+Rm7fmGupMpJjV
	TQATi7IbrQ3q/UmspC25p4lu/+WZyEoKmhCNQMaK/Odyzp0+U4PaTrviV3csoXVX
	iy2IKy6ZQaHamOukfkfvNP9Txud0eIoeN0Q==
X-ME-Sender: <xms:SrPuaKQv36FOzqCXOOjFF0f-qXHKVjxwrIH9nOxbadAg4rxEvud46w>
    <xme:SrPuaHOY1kU6Hxq23Qc6N7byPfWigoe9om6d1NFq6hlub0PlxsvTGb6HACNRcLszy
    7P2mbwFrMiroPxLvZLfGXX20TiB35lROnkC0JWhO97-NrN-Mm0i2g>
X-ME-Received: <xmr:SrPuaFND2AE6ZRd-j1U40bd1TSgWLcGkWJys2czZ_KPBDQhK06SsnwhnxJU1lfJB_OD-w2uaiD9FT5_L9Ozpg4jTT5VUAKsN_ANR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehl
    ohhhmhgrnhhnrdhshhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SrPuaPu_3wiYVURAvU_l_u66nHyIPg5BWyWxT9UhQOohwDseAuV0LQ>
    <xmx:SrPuaHW7hd0rAZYzM3cC72sxZ_6EWdndO96g5ZuqpYFsvAc7LfC2QQ>
    <xmx:SrPuaPtvycjlUb_OD93ZzZLWJHk35OBiZ8CP85c-xKAdgZA55npZDQ>
    <xmx:SrPuaLU5l8vrmmL0dL0m12e0PQVRUy33gGn5RBaUk2jikFelSIgNOw>
    <xmx:S7PuaBYmk29aJ-mo68QMYLf-sjbvUPZcbcDRATunaXfd0vHIEDWn73GK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 16:32:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] setup: refactor `ensure_safe_repository()` testing
 priorities
In-Reply-To: <20251013094152.23597-4-git@lohmann.sh> (Michael Lohmann's
	message of "Mon, 13 Oct 2025 11:41:44 +0200")
References: <20251013094152.23597-1-git@lohmann.sh>
	<20251013094152.23597-4-git@lohmann.sh>
Date: Tue, 14 Oct 2025 13:32:09 -0700
Message-ID: <xmqqy0pdw7g6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Lohmann <git@lohmann.sh> writes:

> The implicit ownership test takes precedence over the explicit
> allow-listing of a path by "safe.directory" config. Sort by "priority"
> (explicitness). This also allows to more easily integrate additional
> checks.
>
> Make the explicit safe.directory check take precedence over owner check.

I do not think the above argument makes much sense, with the code
with or without this patch.

It would be a very different story if the explicit specification
allowed users to configure a set of directories to be rejected, in
which case a user can mark a directory as unsafe even the
ownership-based rules would allow it, and explicit rules may have
higher "priority".

But that is not what safe_directory_cb() does.

In other words, there is no "priority" among the rules considered by
ensure_safe_repository() helper.  At least, with the shape of the
helper function at this step in the series, all rules are equally
capable of declaring a directory "safe".

If you are in later steps (I haven't read them) introducing ways to
say "this and that directories are explicitly forbidden", perhaps
reordering like this should be done at that point.

Alternatively, you can leave the change here in the middle of the
series, but explain the rationale differently, e.g.,

    With the current code, this change does not make any difference
    because there is no explicit rule that lets you reject a
    directory that the ownership-based rule may accept.  In a later
    step in this series, however, we will introduce a mechanism to
    allow such an explicit rule, at which point the order of checks,
    i.e. seeing the explicit rule reject a directory and failing the
    operation before consulting the ownership-based rule, will start
    to matter.  As a preliminary change, reorder the existing
    checks.

or something like that, perhaps.

> Signed-off-by: Michael Lohmann <git@lohmann.sh>
> ---
>  setup.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 69f6d1b36c..41a12a85ab 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1307,12 +1307,6 @@ static int ensure_safe_repository(const char *gitfile,
>  {
>  	struct safe_directory_data data = { 0 };
>  
> -	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
> -	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
> -	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&
> -	    (!gitdir || is_path_owned_by_current_user(gitdir, report)))
> -		return 1;
> -
>  	/*
>  	 * normalize the data.path for comparison with normalized paths
>  	 * that come from the configuration file.  The path is unsafe
> @@ -1330,7 +1324,16 @@ static int ensure_safe_repository(const char *gitfile,
>  	git_protected_config(safe_directory_cb, &data);
>  
>  	free(data.path);
> -	return data.is_safe;
> +	if (data.is_safe)
> +		return 1;
> +
> +	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
> +	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
> +	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&
> +	    (!gitdir || is_path_owned_by_current_user(gitdir, report)))
> +		return 1;
> +
> +	return 0;
>  }
>  
>  void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
