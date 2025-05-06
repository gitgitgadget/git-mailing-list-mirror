Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62EC284B59
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552583; cv=none; b=Ionyigip+GCxIls1T2Qcp4//+ds37+se65VrMAvKuyA9N8djuO8QCN703GpSvaBiuJaEV6yxdURceGKaAhE4Ojs4m3IJUkaWU7BPdnERQpJDAn+afUN9gXLeR/Uadsb2gWLC9Zqb8u6Q//XiNt7u2kNxhFL84qYaRzgRn4F2rOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552583; c=relaxed/simple;
	bh=tKa9pSgQ/p+oS2hSq62POMAY46NTzr5AtBrufA/2k6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCkXRcs2Ay1Qm7DBevcL89oanm2yRXKtsl+ivkbuhMGHD36gfy2zY7p8rMVzOGO29E9GAthiEkI+vZqNOlu3TMUyz6K0qtxq/D7/TfSKTbpsHGACXU49PdctTdl5dFQ0ZRPb6VqX35bASKPFG9SQtKKZgFPJgnqJI1R64z1gBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ohyN7DtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w7skdO64; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ohyN7DtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w7skdO64"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D49A01381518;
	Tue,  6 May 2025 13:29:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 13:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746552578; x=1746638978; bh=zP3l3deRay
	aPeEKUN4G3zWpn7rW3sz2YF5srY4l7m2E=; b=ohyN7DtWmZvEw1xDBBP6zLOxYj
	9Pmxq7OFOcckvjG9qkhy3k7VoCwGpYPr00cbDjHNIi9tVEyJZuhj3TJoC1vapcI0
	I2yYdFkVBoWQD1DnjXzqjptL+WYJExauQ7xaMiJzeUhDCWmMCnDoNuwTYcKNx2/y
	6ajtjZlMriyu3TmEc+sdBDPFGesIkYZSouqbe+Qd/zpOmSln9NMX9mXeq5Nts4zq
	0UzUBCvhrwiC3ywpPkPz1FOL3Ja0vLZmXW3i3sukYSrp1fgyY2nq//lkE/n5EdoP
	ZP+HD5RabL9Rc1VgjER72ov40iYeZC9kOti43hdBDJT+rKJbA3kJqD+A6chw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746552578; x=1746638978; bh=zP3l3deRayaPeEKUN4G3zWpn7rW3sz2YF5s
	rY4l7m2E=; b=w7skdO64eCEriI2VkKy5EYLvjEKwD4lMGIuwxVmpwIpZDs3CXQb
	HwwVRItA68La/jDyzsFLdFZzwKVrF/k0ce7iP5ZkkP8snI7iPN1jXZV5+H564ONH
	h7unAoDAMm2bhy6BYKKpV9X5wpRS1dwcX/6cqgDfdz9DO3TlEQ/EtcOFfQEQhsd3
	RMwEfRGQLfjTLBwmk49T8X7tjQdSem67CI6ixxfFJzi70QyPJEcPSfPacYPMLDBO
	A+XCq8BHYglQR4BVgYigHrJ3YRwD+IzFDOIyAkRMKVU0TPW1F52epnoXr4f47EPu
	8NNha0aTqoWMhwyHRQWA2jAggfZO+5ggpcA==
X-ME-Sender: <xms:AkcaaIeZQSHZ59s7eT0lDZ8Nl2M7PGZmHLpKSpVc21At_10nU7DC_g>
    <xme:AkcaaKPER_skTuamhpN9cE0Y4PvvKP9Gbft6dCkY27chstvLvM85oeFJCxmWfN2Z9
    67-qmDkQCREzYzmsQ>
X-ME-Received: <xmr:AkcaaJiD3Q9B9ZfPYa1mfdAAs-Q13JBrYr8wPSHNcc9j7Y3ngVwKPCq__ureWvLyTrL4h2PHucWOUUtD0uSofJgL1DJo7fsQY8Oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AkcaaN8Djyo1WI6pgNhyhp4pUxdCINgP-WDkCY8p82DK2gClyDY6Fg>
    <xmx:AkcaaEvENsyl2LJZlev9faHbFjhqIw9LF_oTEFBvhHndFCCjQBSJUQ>
    <xmx:AkcaaEGSt6dii2N2lNtAdoTAfvI63Z329wTc9c3EOU4tWWpMilNWWA>
    <xmx:AkcaaDM9GftoFQPQ8ITDI8VHRtU6EXjgNQV8xYBB6E2AwasYnTFmqw>
    <xmx:AkcaaFZS0CBF5bLz2BoYv8GOVYVchY3QnVB-Cu2jMWfmo3n-AUhD_sux>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 13:29:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH 1/3] add-patch: respect diff.context configuration
In-Reply-To: <8b91eef8120b8f92db953ec983fddce8a442abcc.1746436719.git.gitgitgadget@gmail.com>
	(Leon Michalak via GitGitGadget's message of "Mon, 05 May 2025
	09:18:37 +0000")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<8b91eef8120b8f92db953ec983fddce8a442abcc.1746436719.git.gitgitgadget@gmail.com>
Date: Tue, 06 May 2025 10:29:34 -0700
Message-ID: <xmqqzffpk5q9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Leon Michalak <leonmichalak6@gmail.com>
>
> This aims to teach relevant builtins (that take in `--patch`) to respect
> the user's diff.context and diff.interHunkContext file configurations.
>
> Since these are both UI options and `--patch` is designed for the end user,
> I believe this was previously just an inconsistency, which this patch hopes
> to address.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  "Various built-in commands that use add-patch
infrastructure do not honor diff.context and diff.interHunkContext
configuration variables."  Would be the first sentence to explain
the current situation.  Follow that sentence with an explanation why
it is a bad thing (i.e. it is possible that "do not honor" may be a
deliberate design decision---perhaps the implementation of "add -p"
is impossible if it has to honor diff.context that is set to 0; show
evidence that no such deliberate design decision was there when the
feature was introduced from the list archive, and say that not
honoring the configuration is an inconvenient inconsistency).

Such an explanation would be sufficient for readers to guess the
"solution", so stopping there should be fine.

Thanks.

> @@ -1014,10 +1019,13 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
>  	if (count > 0) {
>  		struct child_process cmd = CHILD_PROCESS_INIT;
>  
> -		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
> -			     oid_to_hex(!is_initial ? &oid :
> -					s->r->hash_algo->empty_tree),
> -			     "--", NULL);
> +		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);
> +		if (s->context != -1)
> +			strvec_pushf(&cmd.args, "--unified=%i", s->context);
> +		if (s->interhunkcontext != -1)
> +			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->interhunkcontext);
> +		strvec_pushl(&cmd.args, oid_to_hex(!is_initial ? &oid :
> +			     s->r->hash_algo->empty_tree), "--", NULL);

OK.

> +test_expect_success 'diff.context honored by "add"' '
> +	git add -p >output &&
> +	! grep firstline output &&

	test_grep ! firstline output

?

> +	git config diff.context 8 &&
> +	git add -p >output &&
> +	grep "^ firstline" output &&

Likewise.  

	test_grep "^firstline" output

?

> +	git config --unset diff.context

Not like this.  Either use test_when_finished to arrange that this
unset is run when you leave, or use test_config.

	test_expect_success title '
		test_config diff.context 8 &&
		do your tests
	'

will reset diff.conftext when the above piece is done.

	test_expect_success title '
		test_when_finished "git config unset diff.context" &&
		git config set diff.context 8 &&
		do your tests
	'

is an equivalent.
