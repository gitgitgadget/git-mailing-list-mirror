Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F861FFE
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393131; cv=none; b=jdMjB7hmQo2ceVAdcHV3QmNZ7SlxvWmcpC+xyogkVdd+WyhSMfBY99SrybpCXd6J0w9N7P7BYshaspWE3bXC6/F9jHM3Ta4W8Eivnf8UEfYugHbXbkHaQi7VL/ezInuogOrm5mO8+OxElRLV3USvkmoox3MFLBTLyX0FJ78MBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393131; c=relaxed/simple;
	bh=wMcMEaIO0vDQTJ2pJRGzt2hNbIjYu/B5X/3jhtHoZxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I8XEo/NVeIKwIpUEBIQCi8gSHLQ5QMFXlMtAFEGwPRyEHt0IPQ1pctfNP+Vb8MMLmYWljxg48ZLgIgqjEDfPNuO4WmzdYXyxK2ANaM4kIBCMTr8cZWQPpf71S3ZfdkDuyJbLz4Nk5obVa0164+6PW6bYMcXiMjvBDYjNx5SlDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Taif6yfB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XioamYwe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Taif6yfB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XioamYwe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D58341D0009A;
	Mon, 13 Oct 2025 18:05:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 13 Oct 2025 18:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760393127; x=1760479527; bh=RY82ffKdRG
	FgekiaztDqLJZnSXeh4/FhDw1Y4XHct7c=; b=Taif6yfBNAV25Cc2g0KrjGI0au
	a4vf3M+8XsL75+fF3Pg+dxCwklABtk27fbuXKn71kAYXgYz2wDYTDUR+1lBzafnF
	3LPG1R4xa1rQOxEUz1LOsvD9Axbm0KHou4cAtHdRNt/tvUCOjuhm0bjsMOuQ4LAQ
	jKsCI6UbkQFEHFSc9RARZav1s04VmIwQbpyRfObjczyTPrvqzFW1vKQkKVxXoyNU
	AeZKQIMXv7Fa0HXGJYmtG8kZt4w4x24RlhSZpG/a6wHb2QpesGWlEc9AhkriMd30
	ILoS1bD+6mzpwhxhc9D4ZfU1o5Mq9GrZ5NHqTMnCYXagdq0AEP5a0a3UJiQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760393127; x=1760479527; bh=RY82ffKdRGFgekiaztDqLJZnSXeh4/FhDw1
	Y4XHct7c=; b=XioamYweb/2/rx/WdJq36wybCvUn66QiqdmT27IjaqVgEcm+v19
	zbj7uoNtx5Sy4BeqX4b3HC/NogsFcUtVPtEIFsowjpklXNFhBz6sWVOFcOpmkExe
	j8T3ubX4PfMrj2iQJWCcMQB6OZ+jqJ8pzShL9VS4fZaHipO46ukbmHvmOqeDXaMr
	SeTKc6dt+LrEX/WhdSVTrxZUH/FlBiiqPXww50luvPUCY117lvgYOjkt/k8I/aUv
	1oz0h/tlOZGb52m6rUxVmmgN1wK226IfcJipvIaQj+gWINBL6XQUX0OV0lI5+XkS
	qmErmaCU0d8I5MNLW4YA+yCMpYu6i3Wpjvg==
X-ME-Sender: <xms:pnftaDqkxRVo8OIE39cgbpVBVm8iyIdEPMLTmktdBHxqQJSlgPto5g>
    <xme:pnftaIAdYA-A_afg-SaIUnexGGOhsc1lrOylvMbul5ksdhxIIP1IcYbN5sUN1plXT
    mjAgiq7hxFY97R-jsWik77tWy0OhBa999EaB-5uaeP_jKo3s-Ra-QM>
X-ME-Received: <xmr:pnftaGUvNMW8jxIg-r2bh1RxT6VdasSybYesWaFdtD0Nq2RZmN6SjUNhPAwJy77WdLP5RJzyXF3R9b7XXZppCAWpcSSMCebDWVA3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:pnftaCAQUDwdN-GHZFKX3YDIdfLVq0ecoWCfS6EKeGJdVkv288iFJQ>
    <xmx:pnftaLeiPs5W2HD-EAgm4zrnOSLHLbTuQgEVi_1vpIsQ5_ZGiXgguw>
    <xmx:pnftaBolOv1MWdYY1_RfbZc9ynqpvcq3IzHK2Wb12tuGH4uj1mx3ag>
    <xmx:pnftaESY8i-W_nOGtQX3hlrjaD-vT_6J03CkTqbCFm3SfpML9J029g>
    <xmx:p3ftaCn0xvtlqV2V27zeL946yP-lnxmYvAwVTqP1Sdp7ddm0_3VnLPu_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 18:05:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 2/3] replay: make atomic ref updates the default
 behavior
In-Reply-To: <20251013183311.33329-3-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Tue, 14 Oct 2025 00:03:10 +0530")
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
	<20251013183311.33329-1-siddharthasthana31@gmail.com>
	<20251013183311.33329-3-siddharthasthana31@gmail.com>
Date: Mon, 13 Oct 2025 15:05:24 -0700
Message-ID: <xmqqms5uzcd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> For users needing the traditional pipeline workflow, add a new
> `--update-refs=<mode>` option that preserves the original behavior:
>
>   git replay --update-refs=print --onto main topic1..topic2 | git update-ref --stdin
>
> The mode can be:
>   * `yes` (default): Update refs directly using an atomic transaction
>   * `print`: Output update-ref commands for pipeline use

Is it only me who still finds this awkward?  A question "update?"
that gets answered "yes" is quite understandable, but it is not
immediately obvious what it means to answer "print" to the same
question.  When the user gives the latter mode as the answer to the
question, the question being answered is not really "do you want to
update refs?" at all.

The question the command wants the user to answer is more like "what
action do you want to see performed on the refs?", isn't it?  The
user would answer to the question with "please update them" to get
the default mode, while "please print them" may be the answer the
user would give to get the useful-for-dry-run-and-development mode.

Perhaps phrase it more like "--ref-action=(update|print)"?  I dunno.

>  --advance <branch>::
>  	Starting point at which to create the new commits; must be a
>  	branch name.
>  +
> -When `--advance` is specified, the update-ref command(s) in the output
> -will update the branch passed as an argument to `--advance` to point at
> -the new commits (in other words, this mimics a cherry-pick operation).
> +When `--advance` is specified, the branch passed as an argument will be
> +updated to point at the new commits (or an update command will be printed
> +if `--update-refs=print` is used). This mimics a cherry-pick operation.

I do not find it clear what the reference to cherry-pick is trying
to convey.  It is like cherry-picking <something> while the <branch>
is checked out (hence the branch advances as the result of acquiring
these commits from <something>)?  Let me see if I understood you by
attempting to rephrase.

    The history is replayed on top of the <branch> and <branch> is
    updated to point at the tip of resulting history.

But what's the significance of saying so?  Did you want to contrast
it with "rebase --onto <branch>", i.e. merely specifying the
starting point without <branch> itself moving as the result?  If so,
it is probably a notable distinction worth pointing out, but just
saying "mimics a cherry-pick operation" alone is probably not enough
to get the intended audience understand what you wanted to tell
them.

    Side note.  I casually wrote "is updated to point" but with the
    option not to update (but show the way to update refs), we'd
    probably need to find a good phrase to express "where the
    command _wants_ to see the refs pointing at as the result",
    without referring to who/how the refs are made to point at these
    points.

> -To simply rebase `mybranch` onto `target`:
> +To simply rebase `mybranch` onto `target` (default behavior):

"the default"?

> diff --git a/builtin/replay.c b/builtin/replay.c
> index b64fc72063..457225363e 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -284,6 +284,26 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  	return create_commit(repo, result->tree, pickme, replayed_base);
>  }
>  
> +static int handle_ref_update(const char *mode,
> +			     struct ref_transaction *transaction,
> +			     const char *refname,
> +			     const struct object_id *new_oid,
> +			     const struct object_id *old_oid,
> +			     struct strbuf *err)
> +{
> +	if (!strcmp(mode, "print")) {
> +		printf("update %s %s %s\n",
> +		       refname,
> +		       oid_to_hex(new_oid),
> +		       oid_to_hex(old_oid));
> +		return 0;
> +	}
> +
> +	/* mode == "yes" - update refs directly */
> +	return ref_transaction_update(transaction, refname, new_oid, old_oid,
> +				      NULL, NULL, 0, "git replay", err);
> +}

Hmph, would it be easier to follow if the above is symmetric, i.e.,

	if (...) {
		what happens in the "print" mode
	} else {
		what happens in the "update ourselves" mode
	}

I wonder?

In any case, do not pass mode as "const char *" around in the call
chain.  Instead, reduce it down to an enum or integer (with CPP
macro) at the earliest possible place after you saw the command line
option.  That would allow you to even do

	switch (ref_action) {
	case PRINT_INSN:
		printf("update ...");
		return 0;
	case UPDATE_OURSELVES:
		return ref_transaction_update(...);
	default:
		BUG("Bad ref_action %d", ref_action);
	}

to future-proof for the third option.

> +		OPT_STRING(0, "update-refs", &update_refs_mode,
> +			   N_("mode"),
> +			   N_("control ref update behavior (yes|print)")),
>  		OPT_END()
>  	};

This one is fine, but then immediately after parse_options()
returns, do something like

	if (!strcmp(update_refs_mode, "print"))
		ref_action = PRINT_INSN;
	else if (!strcmp(update_refs_mode, "yes"))
		ref_action = UPDATE_OURSELVES;
	else
		die(_("unknown option --update-ref='%s'"),
		    update_refs_mode);

so that you do not have to keep strcmp() with "print", which risks
you to mistype "prnit" and no compiler would protect against that.

