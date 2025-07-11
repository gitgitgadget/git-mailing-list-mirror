Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BE21A453
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269148; cv=none; b=lPWwUQ2iqgoKK1oX8vSF82Xcq4GE40NmMA1KfaEjRvt+VdD2/k5aMwvOVXoP3+ms8kM311wk3gt4uKxRLWHY3OSLibj83o+1swGJz79IlcI2paYRfSzrtJ61dQAn4m2VUgg1z6Zoqh80idDDpXWZszZ+FHXNcVcO1QLYaPw17m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269148; c=relaxed/simple;
	bh=twQRpOZElwX6snh/iHeCpiiJl7zJ5HzrUYE7xnIjnHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftpa/g5T+QLvEPRUXbJcyHoqnPIlWKYpdFkJJU0h+sPWyp89xML32/R8YHHLDPNKUI3OU2r8d1WRvRV1QRwoMu6iia4meYH8gLek/phyFeZPL/brCEizWwcgnO6QsGvaCwOgt66Imr4DLC6Bkc9AzUw/V8epjxmApk8amuqIyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tg9Ktxmu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPgV1dK1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tg9Ktxmu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPgV1dK1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A7231D00258;
	Fri, 11 Jul 2025 17:25:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 11 Jul 2025 17:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752269143;
	 x=1752355543; bh=/QlF7sV9McSLyCAX2MIHJ10N3VU1hznO3ggg4apF9Pg=; b=
	Tg9Ktxmuye/GEKxJ2Pdtfrw/PbyRvZgGuMgCO+b0E2uxVvv9R3CoIGaWjo4unsG8
	7GZr2OYNaGRkfkZGHTU43N7acz+REVzq2C/jALHIOjTaRg5J1cnn6N4xkgWMSODm
	BYG+PLGwgugUjyoLFlbznk+PbohOLbtZdaSoyCZdGOAohCdsMp5yjQbC/Ml7In5M
	640114sahI4qyzPZjm9dOH0RjGkh+Stv0WoaGfvzqCY9iyuhoZycyQYyMfUkrR+5
	BJF82zwVh7ZthIhWVCs86ecIok+KnPJ57f7Dj1AxZupnWBxyWfZuLfyj1jn9fN1p
	Fd+GKEm8Y7NflBS1rUs3lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752269143; x=
	1752355543; bh=/QlF7sV9McSLyCAX2MIHJ10N3VU1hznO3ggg4apF9Pg=; b=V
	PgV1dK14Xhb33qSlY9TG9ne+Q7fqErX6sds62pW68FvZ2xnI4jfQ5NznA9O72kf2
	U1ZMZFgC6Tl7oUHZOTbAsGbI5GEvPDjiJ0KCQkGB4onD3HZ3G8iCtRFvAqDaMWic
	YetFjz1d19nHXG9edXcclw4jLhgKHlU3yy0Zb9riiK2rPHIWfNsJojXNHad+NhUF
	7bCKAeJCvl/pX6wtMIS1oRUV5FEAOzCCjpgBAkHTOayO8deH4UEOjzLyvmF2VkCt
	piXsF/UEc9A+xkZqs0sQ737ZEubMpCiGlBbyCBWt2ugJImJ+1hxwsu2ByfOzbNq+
	2ITf41Re76F/bWtl95TTw==
X-ME-Sender: <xms:V4FxaI87Bo79zNTBV49rqyp7wF3vG-x8iGBJGdyexULHYgRVNspZdw>
    <xme:V4FxaLTj52nSLExLF_L1IUJsPBuuy0OLazqK1TXCkWCtD0VfRlyJdW0rzJpy00whh
    WFibxYhZYRTHWPUTg>
X-ME-Received: <xmr:V4FxaKm5X0kHtEd14NFdvyAMmHlK-XOE3qLJLWbFlU_JX2kT3cnvemk8oRI_AU_Z4dukBqGlBkbRJYhpds3-vGZgQxV86CbJso_xgP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehohihsthif
    rgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V4FxaLQYnaG1pLm4dWneYfbZiVwh_KfmDuEv8N_tDYM78VNiqV5ADg>
    <xmx:V4FxaIOKmyDtJBvKep2JNAe1MohFCmNTHM9TuQJ8YgMTSDieGLfqWw>
    <xmx:V4FxaEW_WnOu_qbS2WTaSj4eBEJ81NLeRxYJHsg2jzPF7aBf4Fl8AQ>
    <xmx:V4FxaPdUROp1cW2aACRXZlmkQ9oZyVx4P0i870737d6zIrBqIFAabw>
    <xmx:V4FxaLM0r9WytTrM5OxEH-mevLfEvkdoxNe7PJDS6NYj60XQkbZnNk0W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 17:25:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2] rebase: write script before initializing state
In-Reply-To: <20250711203615.9982-1-oystwa@gmail.com> (=?utf-8?Q?=22=C3=98?=
 =?utf-8?Q?ystein?= Walle"'s
	message of "Fri, 11 Jul 2025 22:36:15 +0200")
References: <xmqqfrf6qkyy.fsf@gitster.g>
	<20250711203615.9982-1-oystwa@gmail.com>
Date: Fri, 11 Jul 2025 14:25:41 -0700
Message-ID: <xmqqple6zaga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Øystein Walle <oystwa@gmail.com> writes:

> If rebase.instructionFormat is invalid the repository is left in a
> strange state when the interactive rebase fails. `git status` outputs
> both the same as it would have in the normal case *and* something
> related to the interactive rebase:
>
>     $ git -c rebase.instructionFormat=blah rebase -i
>     fatal: invalid --pretty format: blah
>     $ git status
>     On branch master
>     Your branch is ahead of 'upstream/master' by 1 commit.
>       (use "git push" to publish your local commits)
>
>     git-rebase-todo is missing.
>     No commands done.
>     No commands remaining.
>     You are currently editing a commit while rebasing branch 'master' on '8db3019401'.
>       (use "git commit --amend" to amend the current commit)
>       (use "git rebase --continue" once you are satisfied with your changes)
>
> get_commit_format() calls die() on failure so we cannot handle the error
> gracefully. By attempting to write the rebase script before initializing
> the state this bad state can be avoided.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> So sorry for the delay. I saw that the signoff was missing, then saw
> Phillip's review, decided to think about it and then life happened in
> the mean time...

No need to be sorry.  Life happens, indeed.

> This patch is identical to the first one except it has the missing
> signoff and a few typos in the commit message corrected. Phillip's
> suggestions are noted and appreciated but unfortunately I am unable to
> work on the at the moment. And I do think my patch is at least an
> improvement albeit perhaps less thorough than it could have been.

Well, as long as we are making a step in the right direction, such a
partial improvement gives us a better foundation for somebody else
to further build on.  It does not look like that this patch would
make it harder to later give us a more thorough solution.

Thanks for working on the topic.

>  builtin/rebase.c             | 42 ++++++++++++++++++------------------
>  t/t3415-rebase-autosquash.sh | 10 +++++++++
>  2 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 2e8c4ee678..8139816417 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -293,15 +293,6 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>  				&revisions, &shortrevisions))
>  		goto cleanup;
>  
> -	if (init_basic_state(&replay,
> -			     opts->head_name ? opts->head_name : "detached HEAD",
> -			     opts->onto, &opts->orig_head->object.oid))
> -		goto cleanup;
> -
> -	if (!opts->upstream && opts->squash_onto)
> -		write_file(path_squash_onto(), "%s\n",
> -			   oid_to_hex(opts->squash_onto));
> -
>  	strvec_pushl(&make_script_args, "", revisions, NULL);
>  	if (opts->restrict_revision)
>  		strvec_pushf(&make_script_args, "^%s",
> @@ -310,21 +301,30 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>  	ret = sequencer_make_script(the_repository, &todo_list.buf,
>  				    make_script_args.nr, make_script_args.v,
>  				    flags);
> -
> -	if (ret)
> +	if (ret) {
>  		error(_("could not generate todo list"));
> -	else {
> -		discard_index(the_repository->index);
> -		if (todo_list_parse_insn_buffer(the_repository, &replay,
> -						todo_list.buf.buf, &todo_list))
> -			BUG("unusable todo list");
> -
> -		ret = complete_action(the_repository, &replay, flags,
> -			shortrevisions, opts->onto_name, opts->onto,
> -			&opts->orig_head->object.oid, &opts->exec,
> -			opts->autosquash, opts->update_refs, &todo_list);
> +		goto cleanup;
>  	}
>  
> +	if (init_basic_state(&replay,
> +			     opts->head_name ? opts->head_name : "detached HEAD",
> +			     opts->onto, &opts->orig_head->object.oid))
> +		goto cleanup;
> +
> +	if (!opts->upstream && opts->squash_onto)
> +		write_file(path_squash_onto(), "%s\n",
> +			   oid_to_hex(opts->squash_onto));
> +
> +	discard_index(the_repository->index);
> +	if (todo_list_parse_insn_buffer(the_repository, &replay,
> +					todo_list.buf.buf, &todo_list))
> +		BUG("unusable todo list");
> +
> +	ret = complete_action(the_repository, &replay, flags,
> +		shortrevisions, opts->onto_name, opts->onto,
> +		&opts->orig_head->object.oid, &opts->exec,
> +		opts->autosquash, opts->update_refs, &todo_list);
> +
>  cleanup:
>  	replay_opts_release(&replay);
>  	free(revisions);
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 26b42a526a..5d093e3a7a 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -394,6 +394,16 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
>  	)
>  '
>  
> +test_expect_success 'autosquash with invalid custom instructionFormat' '
> +	git reset --hard base &&
> +	test_commit invalid-instructionFormat-test &&
> +	(
> +		test_must_fail git -c rebase.instructionFormat=blah \
> +			rebase --autosquash  --force-rebase -i HEAD^ &&
> +		test_path_is_missing .git/rebase-merge
> +	)
> +'
> +
>  set_backup_editor () {
>  	write_script backup-editor.sh <<-\EOF
>  	cp "$1" .git/backup-"$(basename "$1")"
