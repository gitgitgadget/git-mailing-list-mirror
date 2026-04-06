Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07086314A9E
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775503641; cv=none; b=Nf7XDpDB78I5W9dy418tY4cYv+1Pq6loySisg4BjRxX1yYR7g7rlhGxuZA+IG3eqxGRKDkM4MU6PNTYdIeKR3q/QP36GTDmEYSFeO0+6Xs3RCoQpn1Fj78+0Gscbuc/RBLoF6JIfEqMF7S3o5cwRlsf8bITzV1Ep6oNGcoraZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775503641; c=relaxed/simple;
	bh=3rvB5f/pbeEOAq5I6W1d7+rAo2tKqghX02lZk86kzfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENeLpkyooSHtWg7o+bogfskbPsuGAsNGxfHuLRXeQZvIT6D198Qw/c4DcfvfUKGgznkcrYN2Za06OSoo6R6plRkyT3u3WssV8UF+ow87HYgwITxLWPUOdxJ279c8kRdAna4ixVKw84qx6H5wvTzZ0KL62tFt/ct0nY1zmApRjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dfFHC8uZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JA59ngZC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dfFHC8uZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JA59ngZC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 35BAEEC0450;
	Mon,  6 Apr 2026 15:27:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 06 Apr 2026 15:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775503639; x=1775590039; bh=24Q/nqtlFk
	H6N/cK1k1LxMrS9RamG/hbeNu31SfX19Y=; b=dfFHC8uZpFLRP09N3I9jbcyunV
	FAj1hy3wTzaCZ0W23+LO1/aNVUCK8PXfXTyesyelzWolQPC5+HkUjtMxDW/xKxzP
	J9FO8vnpBA5Qoxwb/Ezktk1/dmqdyCZ1C4RQ2/hjxmfSg0o3q9gcRObRAssbDxXD
	2tm5akl4AwbZ8l4xSgy2xut1s4LILy1eZKWSflSV883v/6CTTPTj66A8DSJo64Nx
	hcQvRADYeEhYwPQrqR/+Vk0l+xAGwHZ/3obbA5ZGtWgrIv895rUw3d9mbdTseAPs
	VWQrplVX5jlsx6SI/StTGyq6TYq7ZgJbPZbyyHHfuXcUwIJaHwNz/B2DIlnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775503639; x=1775590039; bh=24Q/nqtlFkH6N/cK1k1LxMrS9RamG/hbeNu
	31SfX19Y=; b=JA59ngZCAXGFbC4INTYb3t7diUWKzJ+mOrLBP89pr8gdw7S0umk
	WSYHM9GcfX3m5dIRRvSaoQEHogfGmM7/LNVaagN5W00NU6JzuMq7VvRC8n61dacQ
	aBDXibhkYd+S66Hs0Xvuci5hIvrP2tuHH/5f/I1ev4YVW+N/gFWBIy9tfXd7HFyu
	ZhxuwRlFhnrDZ2KF4grl04/7al/D7kAMM6Cbqw4DWiEBPWyQ560pasm0qA6Eqz8k
	8sL7xREWkCApLPbacYbYRIMyxCuwAEn60uhett89zqRVP/PwVU3OlvDUsViirGM/
	HulnoKxUoYge0vR5s8j3D8UMAuqNrulkjMQ==
X-ME-Sender: <xms:FwnUaf7439j0jz1OflMmOVYLQSK3mDu3e_cAvQCLWZC01wHsYxRULQ>
    <xme:FwnUab74Z8Jcw7lt3VHJv7icTFtTtwPjHp0YxTEQyiIzSyv_euvFMAPZDA09DI8eQ
    lJ4aNlTJA7X5nww0ScBCTV9gQomOEUPNOWAmAs91d0QDp8tgizibQ>
X-ME-Received: <xmr:FwnUabeq0bDbzauYyhK5wXDgX35uZZ7kTvMRtsDLvRajB87nFEkFjA-MIZDJjV997l9mpsyXxTuYo59yrDQmomK-Slw6fe4ULQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegruhgshihomhhorhhisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FwnUafAnepTie_AIXua_4SVX1NIDZ6WLLzsAghwNELP67L5pev-gaQ>
    <xmx:FwnUae_WZZYxUvBN6EJn2SVikbir_ptYIqLUybbv8VUo7UAoiJSm9Q>
    <xmx:FwnUaaKLYT30e7Sw-AnoOKOlZqI1Dxs51wBGBmaLYBrS0BhHFrwqSw>
    <xmx:FwnUaXgTP4MTliSeA5NfWkR40XI2_oSebIBGJZZUfckdEJsNyWfTkA>
    <xmx:FwnUaa-7GTdVjGexbU7EE7Z0GtR_yrevNLiDLGVxk_j61tje50_KC7aD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 15:27:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "aubrey via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  aubrey <aubyomori@gmail.com>
Subject: Re: [PATCH] parse-options.c: display subcommands properly in
 check_typos
In-Reply-To: <pull.2084.git.1775500706920.gitgitgadget@gmail.com> (aubrey via
	GitGitGadget's message of "Mon, 06 Apr 2026 18:38:26 +0000")
References: <pull.2084.git.1775500706920.gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 12:27:17 -0700
Message-ID: <xmqqy0izanze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"aubrey via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: aubymori <aubyomori@gmail.com>
>
> Before this, mistyping a subcommand with one dash (e.g. `git stash -list`)
> would display a message telling the user to try it with two dashes.
> Since subcommands are parsed with no dashes, this is incorrect and simply
> results in the help message for that command being shown.
>
> This commit changes check_typos to check the command type and display a
> proper message for subcommands.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

So, "Before this, " is unneeded, "This commit changes" should be
more like

    Make check_typoes() check the command type and show a proper
    message for subcommands.

Also it would want a new test to cover this case somewhere.  I am
not sure where, though perhaps a new test in t0040 with update to
t/helper/test-parse-options.c or something like that.

This is a tangent, but I was hoping that "git stash lost" or "git
remote got-url origin" would get their misspelt subcommand names
corrected with this fix, but that is not what this patch alone can
do, because all calls to check_typos() in parse_options_step() are
gated with (*arg == '-') and cannot kick in for these two examples.
parse_options_step() instead routes such input to parse_nodash_opt()
and there is no such typo correction there.

It is not so surprising that nobody has complained about this, as I
understand that the condition to trigger this is rather narrow.  You
have to give a single '-' (not two, only one) before a subcommand
that usually is spelled without any dash in front in order to
trigger it?

Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2084%2Faubymori%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2084/aubymori/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2084
>
>  parse-options.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index a676da86f5..2c4530bb8c 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -633,7 +633,10 @@ static void check_typos(const char *arg, const struct option *options)
>  		if (!options->long_name)
>  			continue;
>  		if (starts_with(options->long_name, arg)) {
> -			error(_("did you mean `--%s` (with two dashes)?"), arg);
> +			if (options->type == OPTION_SUBCOMMAND)
> +				error(_("did you mean `%s` (with no dash)?"), arg);
> +			else
> +				error(_("did you mean `--%s` (with two dashes)?"), arg);
>  			exit(129);
>  		}
>  	}
>
> base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
