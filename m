Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AF3E63AA
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946953; cv=none; b=f3F8XC+4g/HePwjTeq6UeQ7aBqO3fP56mSXzzIl2KNC8PXUod0YOnV0SSpt4soT6acJJSdI4wnhRos8lLh3ScSPNqeDqdjN7INdAP53aHvsRpi0JykaFEJCftPtnNHph90ccNlb6c+JCQ+6RwuFy1c815Rlj4N0pjb5Xwuro3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946953; c=relaxed/simple;
	bh=Kc6MP63y/BvGm2Q124zJCVEqsk0WsL8AeYTnB9cCDl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JJWbTZLhdnOoURm/B7IKGRVuo+oZBSv7Rx2KUknMwdeOORrrUwFMREXnExi7f3KXhwdLvMoOKziIYfPYx+cALflofA8zN4jAvjTwBc6o7oOHp4Yp3V7Z6WjID3N72gXo6ZF3b/jNstNjUsEZSu5YxF252gWsoc8g1XkfLy3p4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ndoPDFmS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jivyvmp4; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ndoPDFmS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jivyvmp4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E6DF61D000D7;
	Mon,  8 Jun 2026 15:29:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 15:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780946949; x=1781033349; bh=liMOvs/eXT
	NXMRLmtX5ObCyinCDWD7QOvTa3Qkw3rxs=; b=ndoPDFmSDr6AiLVXm8V6x99w0W
	jxm2lda7UzxmqaUk74e8FBn0akgaRkJe6mIl0bGlNDchoGMhYtYvJlT58cFxsXCF
	LxVP0uxx+312WSz1HMFOx5cxXIfSxZMEs1mVYuOjCFVXaJchTFL0MpJOny4OJ0Ju
	xWzKpeqZSL4Gp50iEaqkm6ydkFzYUYABU3a38ndJOscLIKCrS0zcR6FFESZFLBpi
	d6dr3WVV5sgikBcnDts5Q0Gb5nxG8cIQrtpaPv5++YTgA39VGO7aWoCu05JRHTYv
	NY+X+1ORAJLxQsdEmkrZP17rk4Yrtpfc5z90LzhBhzc6J1BeQdgbnLAiA+6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780946949; x=1781033349; bh=liMOvs/eXTNXMRLmtX5ObCyinCDWD7QOvTa
	3Qkw3rxs=; b=Jivyvmp45GIca9XvsdriV4MnRnqhNYHsPn9DDZEgeLW7wgkREoa
	iAyeqN0e7lz0qrGOPYv09wiaLZJMUzVOUb1mN5RbLmyh4YagmZ4DnROCyLTD04M/
	FTztKUPuqjKaIZFhhL4XbUf9myUGh7LZmtMVMQBMJC0/QelZ89fcFVvlGBkBaOGS
	T7y/yaStvyf34lHT4L/Xbn/KOSY7uIgyugv7r9YXb1FOyiisega/JVQqmnb0uKZK
	Jj7Jc3TwlvVolbFX9L3emLXKADwQh8Sb7rjwZkqqIxsofSbbUNxU7xgLXNDT/qK0
	k8vQ0GeLJNgPRpZNP4o3HC15eLRwNM/N/Qg==
X-ME-Sender: <xms:BRgnapW_5UvK2-czZcKlAu_OSn07Oa1wMib3ZTV_QilIJriid-whsQ>
    <xme:BRgnagkxffEulYbSRCZReKSIwI2pmaTa8grM7oaBn6zw3z7vgvPdt922K82r-2BF-
    j3iN8Q85ISf8xU0SgPSbCm3MIEEcnwdC6mrWW27EEidw_OLysym-g8>
X-ME-Received: <xmr:BRgnaqYEkrwDZl7PoYVDoMgRvSHyozLS8eey3IsAIZLobGjxbOis5nb1KOk9c5q4xjHxTnBO_PfOa_bZ2thhUe8PqfwxMr3LG9BF>
X-ME-Proxy-Cause: dmFkZTFzfjnxbyFliBcTjE4Ue2Ku4vZwRA4+RtG/BbJVf5aCUNtx9JFVoHKU7OEJQmm/oQ
    TtZWT25X0yd/zCGfDJAl/kEMI9pMU5s4X2Kr5/vwt78k8m1Di5BTp8lIjN56DzmCzfkLXR
    1HPw66s8nz3ZIauw/rXJd2IXYQNPzV6fN+9PdQxvMA3Egc+OUUZaWAD0HANS0Iklp7i8kg
    6abXGK4/sO6nKkyqsvCeCj9rVgeoukvZEkKm4xytd2wMN1oSU7J2Jspp3UalvItLsyGxPc
    zjn5HKbL84kaM+FVX/vxpBcggH9E2Ev4XU1j7BIMaMhLBEbShZVE8DqQdZRe5hpK3S00Zs
    qQ1r2ClifGtfe31APDPO6SQwlH+dLkoNo1GlTLmdKu6pi+GfRFm2YdOmSAiWfIroWvsvBK
    VGnoDxYZLKwdMY6Em9TxL8tIZkuCanKRaNk3dGXgO0PtyRukelMEhb3htmAGw2V95ZODBv
    +ueyrEDuIq+dG7eg08aqfoD7GTow5pZ8tswJwFsHoexDpD8NHbcF7ANlRTlS+1OdAlFnhB
    /PkTfugR15FJPIJLbuUPn4m0ldnhYBqPdtNjhQmqDHRMfF7M49E9KYS320k9vKdwZ4kZWn
    WT1jB7d21/DfM7nBAmEDyr0lap4mpx0avaTk5dGmHqPEalYHfVp1LgZZ234Q
X-ME-Proxy: <xmx:BRgnarMsgZDYOEWdp-s7MXNxhaflbT_zPDdkCET-93qPcXRMftBeuQ>
    <xmx:BRgnavYPbrFxuMUHNl23BiGN11sq1R75dojXBDg9YmfEhNo0axhoUQ>
    <xmx:BRgnap0dksdww-dIangSyC8rjN78A-CG48hhKpG1rCygoT9znAVP-w>
    <xmx:BRgnale9eDrM7i9A4uiJxCcczbrIrArTPDJaTbrb36Z_TZO677egsg>
    <xmx:BRgnaqs7pWNanY1vOSbCl4_-2p2aXGIfrpnOVyUINRkMUyMowFMa6cvb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 15:29:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <20260608-toon-git-replay-drop-merges-v1-3-e3ee71fce7b4@iotcl.com>
	(Toon Claes's message of "Mon, 08 Jun 2026 20:37:21 +0200")
References: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
	<20260608-toon-git-replay-drop-merges-v1-3-e3ee71fce7b4@iotcl.com>
Date: Mon, 08 Jun 2026 12:29:07 -0700
Message-ID: <xmqqtsrcvnjw.fsf@gitster.g>
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
> linearized the commit history into a sequence of the
> regular (single-parent) commits.

"linearized" -> "linearizes"?

>
> Add option `--linearize` to git-replay(1) do the same.

"do the same" -> "to do the same"?

> Co-authored-by: Toon Claes <toon@iotcl.com>

There is no sign-off by any of the authors?

> @@ -430,12 +435,20 @@ int replay_revisions(struct rev_info *revs,
>  	while ((commit = get_revision(revs))) {
>  		const struct name_decoration *decoration;
>  
> -		if (commit->parents && commit->parents->next)
> +		if (opts->linearize && (!commit->parents || commit->parents->next))
> +			; /* map current commit to the same as the previous commit */

This uses the same treatment on either root commits or merge
commits?  If this were a mistake and this wants to handle merges but
not roots, shouldn't it be more like

		if (opts->linearize && (commit->parents && commit->parents->next))
			; /* map the merge to the previous */

> +		else if (commit->parents && commit->parents->next)
>  			die(_("replaying merge commits is not supported yet!"));

And because the next one is also about merges, perhaps the early
part of this if/else if cascade can be written

		if (commit->parents && commit->parents->next) {
			/* We have a merge */
			if (!opts->linearize)
				die(_("can't replay a merge (yet)"));
			; /* map current to the previous */
		} else {
			...

wouldn't it?

If the "map current to prev" is applicable to root, any root are
mapped to the last_commit in the above, and if we saw a root as the
first thing in the loop, last_commit is NULL, we do not do anything
here, and after the if/else if/else cascade, we see last_commit is
NULL and break out of the loop.

> +		else {
> +			struct commit *to_pick = reverse ? last_commit : onto;
> +			last_commit =
> +				pick_regular_commit(revs->repo, commit,
> +						    replayed_commits, to_pick,
> +						    &merge_opt, &result,
> +						    opts->linearize ? last_commit : NULL,
> +						    reverse, opts->empty);
> +		}
>  
> -		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
> -						  reverse ? last_commit : onto,
> -						  &merge_opt, &result, reverse, opts->empty);
>  		if (!last_commit)
>  			break;

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
>  
>  /* This struct is used as an out-parameter by `replay_revisions()`. */
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 3353bc4a4d..c781a3bb1b 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -565,4 +565,26 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
>  	test_grep "cannot be used with multiple revision ranges" err
>  '
>  
> +test_expect_success 'linearize the commit topology' '
> +	test_tick &&
> +	N=$(git commit-tree -m N -p L -p I L:) &&
> +	N=$(git commit-tree -m N-child -p $N L:) &&
> +	git update-ref refs/heads/N $N &&
> +
> +	git replay --ref-action=print --linearize \
> +		--onto A B..refs/heads/N >out &&
> +
> +	test_line_count = 1 out &&
> +	read N1 N2 N3 N4 <out &&
> +
> +	cat >expect <<-EOF &&
> +	* N-child
> +	* I
> +	* L
> +	o A
> +	EOF
> +	git log --format=%s --graph --boundary A...$N3 >actual &&
> +	test_cmp expect actual
> +'

Perhaps we would want to have a test that replays all the way down
to the root commit?
