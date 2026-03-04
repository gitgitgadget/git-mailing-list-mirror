Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39A3845BF
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658156; cv=none; b=dLtLJ8XX7ZJxfCWvc5Jx9m3lwiaFfSP6JaVdQvJXe7PGpP+7sa8aBXQv1BOp6SrkieNh7LGllqC8cGl52h45JaeFUiX9vl/SiXE59bqpR5MDKVanl9Z51SYPz9Nh5KYMWxkCgJfDVgcPSW/4RyZI0/j42fYUU2/udcuClL6B+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658156; c=relaxed/simple;
	bh=54NSvh29m7wiLgCJJiMk1V98rvyRdSWos/Na35echTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PfyAy2Hu+qroxiza/ndWKIWvRE5wiIpYaT659t4dubOQpisUrwjt3AXmfgfOyF06qfZfAlJeIp9vukaKQX3C+lIeukwB8VgQNF7npk4iJUcm1vHLi+ycA7iSaCbstKmrOBxJxohZZM1K8twMi6g4rZxJWsVhRd5rrFXJec/o6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XExOYooy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4DncaDfe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XExOYooy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4DncaDfe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 208701D00052;
	Wed,  4 Mar 2026 16:02:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Mar 2026 16:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772658152; x=1772744552; bh=A4s8c2ViL6
	Z/H8H8HMa4mXy+5oJGFCAbA6hizSP22RI=; b=XExOYooynUFUwT1uA5P8Tbi+Oc
	JEFqUtnZKyfhFxAPnxpV31S5gQ6S3E+GLr50hlvI0TKZ+lYd0mHr1D0Efg6mO4Nj
	Uoo0VhbGdO5j1FBn00HJtski6WoVWxrc2hueV9W2Q+pxgoGdO8Y0/WlDLO/q+kMB
	dZuXVLhoE1YDEi16SIf9WWUvZ3eyUbkSwAzVuZMPEnSSfYz8bMC/tHCTc3DzrCtt
	9xtQ65/0yAFvaGMVhsHGc7I9vKxPlys1kBk83D+6PMJrj1nuY45e0YXUJhTfA/7v
	jfUUul0c9u/XhJe6gp9eWEN7wGG31hQmsM3uW80FGt2RICZ8tzog935GzMsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772658152; x=1772744552; bh=A4s8c2ViL6Z/H8H8HMa4mXy+5oJGFCAbA6h
	izSP22RI=; b=4DncaDfevtSge+NVf9QXdyRASZQtQyjgFwkdS6f2j/MMUFJdoRV
	ghirjuX7BjqfCprQTlvCkWLPb+azOvuNevhOr0WPD94NN/tKwe0QXC++QYOhPutX
	pNEhIUFjA8LIcR/2NfiV4m5jiWOMvh07LVOJb5JXiLqNmnM+TBbMCvPSqjfmLSAe
	hK/WmUIUF1+ReT7IQqPIACkZv1X2sBYxVB60Ywd5iLI1oqc/WKwUHigVlmH7xtEw
	wjtGhaS6apgnTREOkwJ5ZQLXYtADpw/OAs0C/Herzi2+uaGjOXgykx3w9sU9mFlR
	+3GwZPSRqlrUHmFxdMiDfC5ufNROyqecL4Q==
X-ME-Sender: <xms:6J2oaSCKe5QMUSHKGxAP5GzK_3hnRjc_ZJsd1Z54vX53Z0vHg6wO9w>
    <xme:6J2oaQPRo0Pddk7dqhAt2EO4HtzFMrdabmulqJEIJnKVWi_kbEooEGueqlh7kKeed
    048n7FDhvwyZtg2d2ofJA74X7nD8t3RFy3v_mtRLz-lOsCjPW4BTec>
X-ME-Received: <xmr:6J2oafYKEIwd23r7JMs2tF047s_4cQWdVP0NS4YwNN30EwpHrB7OUbwtg8jEymJIIk_iUTsFEKQTZPG_feoleRfi-PO_bHGpNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmrghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehmmhhonhhtrghl
    sghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:6J2oaXseY1_xmCXdU-uSK77PvHyoEpaHmk0zWrd7XEHkyh1SqLX19w>
    <xmx:6J2oaZNLcNRCIjARuRz6ctqX-gNYCUPYl4lLyU-YdhnAhgQJu0GJOA>
    <xmx:6J2oaW5eagw9E3VcMjzVETeVhRZAXO8ywDPA1q3oe_F8DsYPadkZBw>
    <xmx:6J2oaXR_kVkXvvscGNFJVN6cFYeyn9DEcD1ZpE9O0WODCilfcA01Nw>
    <xmx:6J2oaXkFwo70H-htlA4aDP7WpgGU4gCH4YWz5Hc7XxkdmKvpNtp3-4xS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 16:02:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Matthew Hughes <matthewhughes934@gmail.com>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 2/2] log: reject pickaxe options when combined with -L
In-Reply-To: <81cb521401210bfbcd05f8201f75e93bccfba712.1772652091.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Wed, 04 Mar 2026
	19:21:31 +0000")
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
	<pull.2061.v2.git.1772652091.gitgitgadget@gmail.com>
	<81cb521401210bfbcd05f8201f75e93bccfba712.1772652091.git.gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 13:02:31 -0800
Message-ID: <xmqq4imv71g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> The previous commit fixed a crash when -G, -S, or --find-object was
> used together with -L and rename detection.  However, these options
> still have no effect on -L output: line-log uses its own
> commit-filtering logic in line_log_filter() and never consults the
> pickaxe machinery.  Rather than silently ignoring these options, reject
> the combination with a clear error message.
>
> This replaces the known-breakage tests from the previous commit with
> tests that verify the rejection for all three options.  A future series
> could teach line-log to honor these options and remove this restriction.
>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>  builtin/log.c       |  4 ++++
>  t/t4211-line-log.sh | 52 ++++++++-------------------------------------
>  2 files changed, 13 insertions(+), 43 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 5c9a8ef363..44e2399d59 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -317,6 +317,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	if (rev->line_level_traverse && rev->prune_data.nr)
>  		die(_("-L<range>:<file> cannot be used with pathspec"));
>  
> +	if (rev->line_level_traverse &&
> +	    (rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
> +		die(_("-L does not yet support -G, -S, or --find-object"));

I do not think "-L" meant to work well with these features to begin
with, and I've never used -L with any other options (-L does not
even work with --stat), so I personally do not mind this change.

But if this is in place, would we still need [1/2]?
