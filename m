Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46F345CAE
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110952; cv=none; b=nzZ8FNXm5cQMSJnOeLB+PyiEEFvD21FQwrh8oAOcehHPOO9LijnwTy0D0/mfwGcmpShK25TNGRC6u4rdZRNlPPsnuvA6/g7eMrzpkl2i651qiEssTk3bZOh0WVUV5DC4BveCltTJ6xwckpTVk0kRbjONiXIyvjGpxDFrEuuBmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110952; c=relaxed/simple;
	bh=eKpjTLLNQre7xhpIFpKMu2LgW2RqEFliSCKeMcCIcW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+awRb4J99Fhg/PfjE+KoCR4vP5y1NGjGXH0C0M9q2PiupRVW9T/Ll+TPKp/yvrP5e2pdI1kIMqFEPNZ9z9QuTxAtjezQ5ilelCKlV18k0R2YQLViWSwh9v6NHyVw2Detv1deTCe8Lp7pN+/NC6iXxSffoyARQQKbbXbb+Vu4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OQH/q35F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZDfOJjZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OQH/q35F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZDfOJjZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 513BA1400077;
	Wed, 10 Jun 2026 13:02:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 10 Jun 2026 13:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781110949; x=1781197349; bh=z49e8D1sMI
	C3w7wqH9FJRD52po09vM+iD8bXzpfGyko=; b=OQH/q35Fqt6B8PUVs9DTPR/c54
	5tuA+hrpVCyquKO1c7syoY2vRJhft4T1Pbwf2RFIRNBPsYMV6OF2yZYg1DbJAOb+
	utSOCjckthwQUR8ZdhYNUPNMV9KsMNH4Ki4d0tChGOpPyjer/5H6c2tK8AaWwfqa
	TK8NL8t86uPJUbVy9sV3+ThflkReRys2YKQfUSwfSaC2f4nkReFoSpjsgV6NTgSh
	LXh1plxDnSdA2Yp5wnK9MAy4bir3YLT5RxgjfdJl4jbXyFO0PNuCP7dCFj8OkqVv
	QveU8FrLcQSmgWys3XX1XGye7FWtm271rA8uJKCdaokZvpx5jPqnRdTdAiIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781110949; x=1781197349; bh=z49e8D1sMIC3w7wqH9FJRD52po09vM+iD8b
	XzpfGyko=; b=PZDfOJjZCnOdJStl1J15prMgy3sE6PmWfmSYQkMoEeusY8rj/PM
	N28Dfcw9gENnbTWHxLmqeYH8xkXhBFKbb5TbKENOxWLzKLHdovnUyju8/ZTz9lNO
	5RIDSK/ft+PbM7R+uxL8Wb4zYIcL/WeA5GLB32DrEs7Z0wyjDfeknIaVvfbGRG6l
	2NIkJmplte7JdRFdIqVsdqopCTW5BfUUfJIM5xTsJVkfaMEabjkcbMd8HazxDsyI
	HhhgW3wloMLHR+OShNBG1acmdI4MmFxjtloYbLsGpFi1znwP17Rf4nbvFfpl7BGm
	azD9dZ48dLqwLY0D/yRvcZjV6l5T+GzDY+Q==
X-ME-Sender: <xms:pJgpajESmD7_YIoXTSLlKL6FtVNIE4xzLM2EVyQtNSlLDixny_VsNQ>
    <xme:pJgpanWFcu2L2hlH7HWS6DwD8p7eWQFAFa8dm5y67tILBCpbavFf2USALK7BQ8K5Y
    5BdSEe1uwKowbWQiEoYrjhiMa_7xpDCwTpd6h-7JbUumA3JhAkgSg>
X-ME-Received: <xmr:pJgpaqL-b-kracIqKzQR5WjTaLqlyTd4d51yRPx1Hx92ahwRLI9avWtZEtlyI1ISkfKG0PlvI-uLgMqLMI6qMwSxck0QjEjLdIew>
X-ME-Proxy-Cause: dmFkZTFSiwfnUhmOhBwJRNKwYlheXQT8fOsFOQ3AUD/gLATmWcSEY7h86ILxSOSSHVdG0h
    RWG6ksIhEH+y1UIZP3zpRpwxAuNW45PUWBIwsuI43A51u01eZEVq3U6eMHyy6HI8Y7VugS
    Vysjm+7HPpAErKmAu+dRNIiec7VvJYYYoesx/JYPY+zEejdxscjoZ/JFiok7jgW5hvpfZg
    11KvhNfyw6J3hHltIPTZolnpf4Ih0PUZAauxqY7i8XnO4zZM4Y5eWqPqPN4t8VfiNKyVPu
    nD82FCTT1t8INWlDFeN07Du7ECCOv4srY549QsusCuvOQ1RhBdh5PX4gSBnxK5Lkd3CHoW
    r8pcXjGmpv4w99gvTlgsZlep9XjHYrgCzz84jrROkJC/Xzyfy7t7GOtHYCcMF5wa/rK11t
    f1D8dvNv1dDFJ5YXYvGoNNTc+um7GXwhviEYq3yVTQ3aTL2IhF6dbYymkDcsj/1K0GEWu+
    /zpMFwoGXoKpQuWM+MY6Us2GIyeN+XoCjiG5l+vna6ex0BVRS5kLo9ojTXeYWVyisqETV8
    eus+iueD03BFq/KqwCWpUjPcvcyDxT5YnkMgt2AA2SplJrM9/IDlJNN7mh3cPVVs/BcQ5I
    28XLIQecaxukWomU+3WW54Hiq4SZMKQVhibeZG4X4d6a3ycg3QVjuYr6FXSQ
X-ME-Proxy: <xmx:pJgpav8E7RXzUTvS3gsVDsK2Izi1wkOjvQ5PbL-uL1cGSBHFczWh7g>
    <xmx:pJgpalJwvbI57tLBWA5JiRUzWzJmvdBC-MhughXmVV7J7xeDZ20ANw>
    <xmx:pJgpasnMwEOYTtkCPhdqC-iGpZX-z1EK3EyTOLuhY2Ihg5ped5Bb3A>
    <xmx:pJgpahPbSrDqtClm693SZukTqO2K2VhHnx_m1_nztNtbhC5ONA1sCg>
    <xmx:pZgpaudpaBXF5L6z-1_5MNo0g225nVV1O0fptRvR0suVpK2_VE3a5O5U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 13:02:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <20260610-toon-git-replay-drop-merges-v2-3-5714a71c6d83@iotcl.com>
	(Toon Claes's message of "Wed, 10 Jun 2026 16:49:14 +0200")
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
	<20260610-toon-git-replay-drop-merges-v2-3-5714a71c6d83@iotcl.com>
Date: Wed, 10 Jun 2026 10:02:27 -0700
Message-ID: <xmqqjys6wcpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> One of the stated goals of git-replay(1) is to allow implementing the
> git-rebase(1) functionality on the server side.
>
> The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
> was given. This mode drops merge commits instead of replaying them, and
> linearizes the commit history into a sequence of the
> regular (single-parent) commits.
>
> Add option `--linearize` to git-replay(1) to do the same.
>
> Co-authored-by: Toon Claes <toon@iotcl.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-replay.adoc |  5 +++++
>  builtin/replay.c              |  4 ++++
>  replay.c                      | 30 +++++++++++++++++++++++-------
>  replay.h                      |  5 +++++
>  t/t3650-replay-basics.sh      | 26 ++++++++++++++++++++++++++
>  5 files changed, 63 insertions(+), 7 deletions(-)
>
> @@ -430,12 +435,23 @@ int replay_revisions(struct rev_info *revs,
>  	while ((commit = get_revision(revs))) {
>  		const struct name_decoration *decoration;
>  
> -		if (commit->parents && commit->parents->next)
> -			die(_("replaying merge commits is not supported yet!"));
> +		if (commit->parents && commit->parents->next) {
> +			if (!opts->linearize)
> +				die(_("replaying merge commits is not supported yet!"));
> +			/*
> +			 * When linearizing, a merge commit itself is not picked,
> +			 * but refs that point to it might need updating.
> +			 */

In the review response during the previous iteration, I commented
that (1) the original excluded only merges, but (2) your version
excluded both merges and the root commits the same way.  Your
response was:

    The way it was written in v1 was maybe a bit too smart and hard to
    follow. I agree with your suggestion and will adopt this (with some
    tweaks) in the next version.

which I took as saying "it may be confusing, but it correctly
expresses what we want to do", meaning "yes, roots and merges should
be handled the same way".  But the above no longer treats roots the
same way as merges.  I think that is intended, but just wanted to
double check.

> diff --git a/replay.h b/replay.h
> index 1851a07705..07e6fdcca3 100644
> --- a/replay.h
> +++ b/replay.h
> @@ -62,6 +62,11 @@ struct replay_revisions_options {
>  	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
>  	 */
>  	enum replay_empty_commit_action empty;
> +
> +	/*
> +	 * Whether to linearize the commits (i.e. drop merge commits).
> +	 */
> +	int linearize;
>  };

OK.

> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 3353bc4a4d..64e0731188 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -565,4 +565,30 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
>  	test_grep "cannot be used with multiple revision ranges" err
>  '
>  
> +test_expect_success 'replay merge commit fails' '
> +	echo "fatal: replaying merge commits is not supported yet!" >expect &&
> +	test_must_fail git replay --ref-action=print --onto main I..P 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'replay to rebase merge commit with --linearize' '
> +	git replay --ref-action=print --linearize --onto main I..topic-with-merge >result &&
> +
> +	test_line_count = 1 result &&
> +
> +	git log --format=%s $(cut -f 3 -d " " result) >actual &&
> +	test_write_lines O N J M L B A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'replay to rebase merge commit with --linearize down to root commit' '
> +	git replay --ref-action=print --linearize --onto main A..topic-with-merge >result &&

As with other test pieces, this "git replay" command line is overly
long and hides the important bit which is that the range being
replayed is *not* actually down to the root, which is A (it excludes
A).  Intended?

> +
> +	test_line_count = 1 result &&
> +
> +	git log --format=%s $(cut -f 3 -d " " result) >actual &&
> +	test_write_lines O N J I M L B A >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done

Thanks.
