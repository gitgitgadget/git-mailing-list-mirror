Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF333993
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763341628; cv=none; b=O62bS0stnZQCNC7NiurHrPkxQXTZgkUughfM5Mswch2+gQ29XqVxqdWQ+pGVrbz+nRMOUPczauvPKPqq+PNP6kH+6IasVBIpqIASPYlbGfhFiMYbR0jQOeQujgG45PTO70bgQAPDey9AeJaRHbW8XN0258mu2wBLXa147uIHAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763341628; c=relaxed/simple;
	bh=X39zdcvTSawsXYFDj2gC7E7Unby24j527C+f/kx6xRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/DrYu6sjkcHhih5OExHnBDvPo0lvLqb/9Tc7pbgf9ZQM2pFurEp684F0tISb86H5PH8TtnQZi60KNQJ7rullSmDD2VDA1o4CwcdrBJdlog5FQNUMdgN69qVFTtP8LoBdY2fnUAsNPdGSd82HqEBDW3DAX5V5Ju1tYsrTaRA+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WRdab/32; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+qDRZYh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WRdab/32";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+qDRZYh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07DDA7A0125;
	Sun, 16 Nov 2025 20:07:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 20:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763341624;
	 x=1763428024; bh=eCZGehxgpE3qnPJwy+PYENOHfkdfZQTctIGXwULeJ24=; b=
	WRdab/32yayD1hRneJ01tGZTD1XsaxPaPHxwapb1pr3WzUU89tLbTLDhyU8/qjYq
	U6IJpgIFgGb87D2cIZg7hMSQA/Hy2B4gSqptobDDeFfnUKArQncF8QeYoBUKb7Wl
	wohp2ZCrVTEGRwdIsZmDKIfPW+GQ1m5x8zy12AD996dly3i8i+TMAu8BXZMPImrO
	wQ2BfQGY5ia1Li7hi/0GYSXjHUmgUZFWj1qiBiqYv96xHsG7qfov+mZxq1PPHuD6
	FbiiBQCqrZegljSDXzMVzkjOj0BT2HV8sT0+MyT0O+tZ57HibOklXk2Pbu/fWLdI
	lZFRiVXINacgBfJohWWCbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763341624; x=
	1763428024; bh=eCZGehxgpE3qnPJwy+PYENOHfkdfZQTctIGXwULeJ24=; b=e
	+qDRZYh0hhm7NZYV884kwG3BWP9giVMechVm0RHqmvQVc+LaPwZ4Q2aQLDjZHHGp
	Jxomk+tKhD+ASUs2nAdftdhUQtX0o/R8vfN4ObautzdwNoEnELJw931J1eKJFXI+
	Y3Ej3lni9zuuV0QHwiL4LxS09YgUC665OhjWvjxeoTRCcImwErbPgZ8SZIOSaKkC
	o5PE9JoDozAS6HNo1OiZAGSQw5K9/kb5O92QXwkd8mzAEeP9jeWIcTBFv9XfVhXh
	ToBEb/OzTocEWTLtyBC6JmasR2N2YH4qXfZ5YfYyzf9Y+zAuqdPK5JGvCMaKi/9d
	cTX1/w97sO2dOPumUh7XA==
X-ME-Sender: <xms:OHUaaeERQjaW8ll1DGQrv4hRq2qj9dCxjDZMTsW2Em4FSCOiQIC0-A>
    <xme:OHUaaWOpyipegb88EvFErbE-NGKcEBNvE6tzyRuWljBNOfyalKMwQOq7I3VqdXHYr
    hTvtGu3zBVdP3JvcYIdnjoBkSKyXhvTgPK0v4hWn4q3sR4zigE29Q>
X-ME-Received: <xmr:OHUaaQekz_AhlXolZIGL58NFxBm-g-4AnY8zNNwIEXWuk4mPa2dKMCzGpwaqBx1UP3j8Fv9N_KHs7qpPfRrJRdOcCU_ITJw0miZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OHUaaTtL3ON4CEa1vi-wstJJ5JDJKkKyYjclqSEcCHe4G3KJMa9LHA>
    <xmx:OHUaaRnH3KlwbFl9z-U9Ljk9gcura-R0gO1Zd0rLRW-2MiY7A-PDVw>
    <xmx:OHUaaVyV6erI0MD7nxHc4XXv_aHqIzFj1W8PqNDig6zoj3BICf9bQw>
    <xmx:OHUaaTOIrrD6MbQvcR-myyZ531mRSWagj9Bca4TRgjJRkdv-HJ7KcQ>
    <xmx:OHUaaWWSIQOSfucu2YCDDae-GEYk3QEA9vA1UjElTnyA0fmFQ1sfn6B1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 20:07:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: commit: link to git-status(1) on all format options
In-Reply-To: <c4349a03724.1763129061.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 14 Nov 2025
	15:04:47 +0100")
References: <c4349a03724.1763129061.git.code@khaugsbakk.name>
Date: Sun, 16 Nov 2025 17:07:03 -0800
Message-ID: <xmqqa50lbh6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> `--branch` and `--long` refer to git-status(1) options but they don’t tell us
> what `short-format` and `long-format` are, respectively. And `--null`
> mentions “status” but does not link to the command.
>
> Refer to git-config(1) on `--branch` like `--short` does.
>
> `long-format` is the git-status(1) output. So we can just say that
> directly.
>
> Replace “status” with a `linkgit` on `--null`.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

This got no raction so far, but given that "commit --dry-run" and
"status" share quite a lot of the internals, referring from one to
the other often makes sense.

Will mark for 'next'.

Thanks.

>
> Notes (series):
>     § Cc
>     
>     Cc Peff based on:
>     
>     • f3f47a1e (status: add --long output format option, 2012-10-18) did not
>       • Did not link to git-config(1)
>     link to git-config(1) even though the previous
>     • 7c9f7038 (commit: support alternate status formats, 2009-09-05)
>       • This older commit did
>     
>     I was going to mention these when I was only changing `--long` but the
>     scope expanded to the other two options.
>
>  Documentation/git-commit.adoc | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
> index ae988a883b5..30121b3c861 100644
> --- a/Documentation/git-commit.adoc
> +++ b/Documentation/git-commit.adoc
> @@ -144,24 +144,26 @@ See linkgit:git-rebase[1] for details.
>  `--short`::
>  	When doing a dry-run, give the output in the short-format. See
>  	linkgit:git-status[1] for details. Implies `--dry-run`.
>  
>  `--branch`::
> -	Show the branch and tracking info even in short-format.
> +	Show the branch and tracking info even in short-format. See
> +	linkgit:git-status[1] for details.
>  
>  `--porcelain`::
>  	When doing a dry-run, give the output in a porcelain-ready
>  	format. See linkgit:git-status[1] for details. Implies
>  	`--dry-run`.
>  
>  `--long`::
> -	When doing a dry-run, give the output in the long-format.
> -	Implies `--dry-run`.
> +	When doing a dry-run, give the output in the long-format. This
> +	is the default output of linkgit:git-status[1]. Implies
> +	`--dry-run`.
>  
>  `-z`::
>  `--null`::
> -	When showing `short` or `porcelain` status output, print the
> +	When showing `short` or `porcelain` linkgit:git-status[1] output, print the
>  	filename verbatim and terminate the entries with _NUL_, instead of _LF_.
>  	If no format is given, implies the `--porcelain` output format.
>  	Without the `-z` option, filenames with "unusual" characters are
>  	quoted as explained for the configuration variable `core.quotePath`
>  	(see linkgit:git-config[1]).
