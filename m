Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F539212548
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925186; cv=none; b=h4/RjflMHjGeHKI7R7jLseg8zt3Gg+/Vc27FuHrTumBkbzKgBSGKA0q/rOt+ZmKROxDOPQO8rCbjCc0zz5Gts37wY/ABBH76Xorm2NV/J9Zhjmh9LL0fFI56++V3U209I8AYdvZD2LwfE/P+pgCXcBjvHjqUWNt7mJoxVCDSmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925186; c=relaxed/simple;
	bh=SocghEyoXjCGJHMs4i53w5rpQESt0K0z23xFDm5azNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XwW3fVzI+6J0NHc3acUTLFwb5HH1pa7KG8gOfHrPMREiErdoUOO9Op2psXnnv8908V/w7Hkwf+PyYS2F3i/c/NmZqdbKOCX5BwCUzKFAHnj/WOUrofmFvX5c65wnWQ2Q/snj4F2+rQdBceDvGuRY1RVEaTU6uqXyE9O94Ghrb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X5Wpl55W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJWXGCJv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X5Wpl55W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJWXGCJv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CDE87A005D;
	Mon, 15 Sep 2025 04:33:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 04:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757925183; x=1758011583; bh=0De9NM+MFo
	Ko/HcNlo29ZSof9a8qe44cSN8UMZk4mTc=; b=X5Wpl55WPKW3FIkKjnZPCBKfW3
	iHRLMkhteQsE9AwBz4T7F+5ht+XsBVyHg8HghlHNMQ7ILVpikbskavVn/66OyoHh
	mj+QHbZ6FPJx6OuxzZQnQXKiAhGRdW9V25dgXeLZ/Xa5NsZmHQLbKedxRFUEE/MU
	oSW3aJwZ6JfLRo5KMfHgUuexHlO96k5x2NcwACjcW+xt40Rna/rbB/9vieTP6U/j
	A7N+jHOgbWncL+mvnXmgpRrPbDoRyVaV1zkIBUZy3bNHu9td4mwS30se7Qp+Oblm
	eK583ftCvHuqnWT+dZVzO7clba0xeVkK5xyIaKxzCwRoeJmLr1DUuOVPeUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757925183; x=1758011583; bh=0De9NM+MFoKo/HcNlo29ZSof9a8qe44cSN8
	UMZk4mTc=; b=RJWXGCJvCa0IwQdiOYMFk3QK25TO7m5r4qt+RDnMFL8JufN2wjz
	g9JWw0Uy33BtnxM4lGsvQ+nYY464vEsUeXOrvYwUH6AMNMoO0Tub9ZV+mZOBsfz6
	sGu9NBiniKVAD7LqKViC01FDcZGdlzAeFuyDGwPsdKBNwnBGG72vtjO0BvmhGbyS
	ByFOddl7fcDZiDZQIbIiAqYH2SlqgKyrwqdxsvYCwYXcC6tjcM5Qw9yG8MOzja1V
	tEQXgG4GjNBtdJb8uoH11MluBjXRyfNoet2vugzF8HD/DyXS9VseNihP8llcCBXO
	awPs7mjVuz2/oiN4X9DDvsY8jkG8Endp07Q==
X-ME-Sender: <xms:P8_HaOAHCN2dcdPz0Hl56s-DOIIMebyuRWE_qD4lsw1odd_oaUWLIA>
    <xme:P8_HaDGo6ENX0fRDEfQEyVHwF9s0lrnmm0VE3Fjzl7-wpv220GtpQeGlW4uneuDWp
    vJ-euSShzhUm3lN8w>
X-ME-Received: <xmr:P8_HaOKwd1Urq4zTcJBy-PKf9T4JoNGqja83aVJGDaFUqV4GuwWrb1SBUeF6DlYcF3Z3KQyrXdIcpLLTXT9IevpOJefzbT5bg_6WzoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:P8_HaPmReqaWw2FnG6BTtmHQAPhsi4mSrO5w9gPZEvx0fihVlE3AjA>
    <xmx:P8_HaOQqeM_muKJ2n8UZRvxiGhHeS1FEEdxqQN5OlJ5Kd-Ztfi0fRg>
    <xmx:P8_HaJIuzhbeLT3U9XlttCSyp0kBhn1Q_t86XQUYo5ESy8BhEh4xDg>
    <xmx:P8_HaMDmZZkr3e2iQCt4vAhI_X0ZGxjCNYVYKV1u34NO8F7jQdUpZg>
    <xmx:P8_HaK7YtiZ7ViGfj77Z_mvC00nYqdaXNd8x4hhpqO8MwXC97NBpcCSS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:33:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] git: run alias subprocess according to the API
In-Reply-To: <ad7066022efe5344eb1972d1c489372d97b2d18a.1757842206.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 14 Sep 2025
	11:32:34 +0200")
References: <ad7066022efe5344eb1972d1c489372d97b2d18a.1757842206.git.code@khaugsbakk.name>
Date: Mon, 15 Sep 2025 01:33:01 -0700
Message-ID: <xmqqms6wi08y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> `run-command.h` tells us that this is how we should run git(1) commands.

Perhaps that comment needs to be updated at the same time?

>     The only other thing I found was in `upload-pack.c`.
>     
>         strvec_push(&pack_objects.args, "git");
>     
>     But that one is intentional; this is inside an else-block and the
>     if-block has `pack_objects.git_cmd = 1;`.  And attempts to refactor it
>     broke `t5544-pack-objects-hook.sh`.

Hmph, doesn't it indicate that it is wrong to use ".git_cmd = 1"
unconditionally, no?  I.e., the instruction you found might make it
sound as if the only difference is to spawn "git" directly or doing
it via the "shell", but because it is not, the result of your update
broke that test, right?

So, we want to tell programmers when to use it, with the comment
that says "most of the time, if you are spawning a "git" command,
use the .git_cmd = 1 mechanism, but if you are doing X or Y then,
spawn that "git" command just like any other programs spawned via
the shell, because of such and such reasons", no?



>  git.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index d020eef021c..f16a8fbb55d 100644
> --- a/git.c
> +++ b/git.c
> @@ -825,18 +825,18 @@ static int run_argv(struct strvec *args)
>  			 * process will log the actual verb when it runs.
>  			 */
>  			trace2_cmd_name("_run_git_alias_");
>  
>  			commit_pager_choice();
>  
> -			strvec_push(&cmd.args, "git");
>  			for (size_t i = 0; i < args->nr; i++)
>  				strvec_push(&cmd.args, args->v[i]);
>  
>  			trace_argv_printf(cmd.args.v, "trace: exec:");
>  
> +			cmd.git_cmd = 1;
>  			/*
>  			 * if we fail because the command is not found, it is
>  			 * OK to return. Otherwise, we just pass along the status code.
>  			 */
>  			cmd.silent_exec_failure = 1;
>  			cmd.clean_on_exit = 1;
>
> base-commit: ab427cd991100e94792fce124b0934135abdea4b
