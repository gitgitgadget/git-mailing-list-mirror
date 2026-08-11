Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26D36A37F
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472537; cv=none; b=kcCUxCQ88djNZ1qSOaDZcpmhOw8PVWMluIPOUJsc9rCmQE/TZFKdtSVxfJovXxzymc4AKqZ+b89DTtpgqOR3Uh+3lYl3wiCcG8GeuKSloi/ot8dBM1ZLPMNQljwZUEen/wZmC4goO2XeF5MgyZzg6LCoQqPAwy3kQKs4jOHxD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472537; c=relaxed/simple;
	bh=886aeiljgwA/PATU8XucJIFTclm6wFrFVxKHTRGFtsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3tqncCHTx47kH1neMgegnCIZc5r5KmMi4W2Uu7IJ+3W4qHc+Ythr6db15JWoBCurJWA1BCcwyJOW5z9R/h+EEHDsHFd2F/q86agOagpSuQ/LQDpkw3d1SpK+ukQSajE3ra6dN5zW76WpJsGHwQ1uscxkU2ja/+jOnb6s7SprmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m5VX6x+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFQd1jtc; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m5VX6x+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFQd1jtc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 15B3AEC026B;
	Tue, 11 Aug 2026 14:22:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 14:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786472535; x=1786558935; bh=7sjPpU3Mwt
	nM7+w2BAmrgaljkPqUmAX5SWDk11gNedE=; b=m5VX6x+LWjwC0dDIJP1QvyevcG
	+3gc7ROkfyBrD2NZx8rEVTOlOViZiLDNceWu/wcrHYNOI9Ep6Mcv0GhraF5hHZKY
	hROIF7F8PU7suZJxuJ4e1aNzD6hVyZsBs1Y5FdtNKvAxPjIrxlGTPe5bDPRhP7a+
	jnWAVt0oHMaxOZC3qQZPirAQh2nMXDMCd0/D1xqP9xd5jgvFfWbce8zz2KfLzGzK
	MRXaTwD/DhQFlvSwng/SKmYP4I1k/M8oyVR5gzvWLGT0mtEex4CGFnlkScts4Pb8
	oLgOsXjibVfIfMl6qeE/fa51f9tpbAcKiE42jiPlabtliGIqEPHu6mc+hmbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786472535; x=1786558935; bh=7sjPpU3MwtnM7+w2BAmrgaljkPqUmAX5SWD
	k11gNedE=; b=lFQd1jtc6tOYbanwLuZhRRxQ0rej0R4NZRCPKbqyzLnWRPg4Y/a
	j611bb7Uq3OMfVRTScAu/vOPuxcKx4f+msOQ6+6FSNKMMeZY79b/g0kZPmbOQgRV
	4yd9KG7lva30T8APbJbHGRhxCLH6o/hST2Xkd6rb25KdmmMFRiD2oQ6mWM0UT+9T
	mqzQX1CaspGQ78Rh1V+tkbqnnarmTJ1lpVcm6NIu2WjFLyetuN44q1M3OXdoZQu0
	d8pIyZCQp2wJUa/5gP6QJvJYgHsn7YLX364xm9zd+A60FvJBPiIuqA+amqU4zll+
	kKqJRqE1OwecW3uAuEzKi6cQ+5sJPO84ozw==
X-ME-Sender: <xms:Vmh7aohNhFW9Mzn_fFvXb1CZrbqKqeIR1Z-vNSN0FuMlF3LwrfUcaA>
    <xme:Vmh7aoDzixNngPJU0HLTJWhmvF-bDi2312NLgbh0A7oGnfQIugtmCizXXiwiuzaDI
    x-d8hUsm6NoS2sC7kyTyHhS3Lb5NKCQZEAswE2VT0mF1C7H13EGjw>
X-ME-Received: <xmr:Vmh7alG7RfdpV7jhxCbqwfHQAKv4PFNFhuLCvgtLwOiYAeTC9QFr0gC2Vi52E058GomyMsVxfDFEZkH_HZNqN1u_uCkT1sjfPw>
X-ME-Proxy-Cause: dmFkZTFN9eReNemMvO0QE3Z3AgokIuIVMihzLqjJbxGb5ODZ4JDjtQTaXT6yfXs5wRt5hR
    KtUszFMqC7YoosKrKarn7H/yHVtLSbyvI+wE1tobWg45F7bjdJP5GywcYI3zkhueKsWcm5
    S52DhH9surVHfFjA/M+jyhNeyK0uYSkaQLRHgDlRzkvAiARKNSMrtxR7md2yPNyBzuqFI0
    1q5STPh1IzS3olN6e9miECXgdmfCxqxVOe2C+43lY6yFXYvqBOjFwTx/wPjZTSQLxT+GxN
    vaYhhhcneA7ZKuzj4lCmVEweUe13NUwhJwt2aoD7yyb/vnF1YnnQm0je1zNRtTcG+XCdab
    FrYzVrfhQ2x5STi49FepsN1BxnGALDwDgFb6U5TOO07GFiN+UP0ojOIFOp/9H4varyDqlG
    FBAGZJXAsMk/lJT9j+N8CPjElxlzaMRRcJdAT/efGyrzsSyZcQOY0HDjDNM2U12wZ7co9j
    2rJ6O5+Uc7jB5o4StybZ6BW7dzYrzl2bYu0caOd3710RzRk2EaIxzA91D4ocvAdCt93D74
    1G46t1+KhqjwQI+hZpCkc7LgX3ALROHhWIyLVZ0ldr36+hoF/YnRA3qy0K2EAQ6//DYa1F
    AlbsNSzsDCQzY1v2rdm33Bc1tlm3I2KaetGWO6gOTQ/mVy3XzaCRvImb1wEg
X-ME-Proxy: <xmx:V2h7aoKVx7RgLxaI75uQHib2xDge8tcOhM36HDeC1TCFRwGnoMn_oQ>
    <xmx:V2h7ahmqZobiHjB84wN6rsWeIItxmXPLGl1eY1NnkGASIVxzfQUudw>
    <xmx:V2h7aoQwK0IhxHHUvVbCsi2oR8NYETInX5uEku8ggVfKq_rGvyNoQg>
    <xmx:V2h7arJTlbP5b8kfNwo8zh7WUTIJhkfEa2UaWVSNx_avKsW1edCO0A>
    <xmx:V2h7aqcv56kIiJClpKuABpct4Y3x9co9r3jiy8a_DEutWV5gujkhfEUh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 14:22:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] sequencer: release the ODB before spawning git commit
In-Reply-To: <pull.2198.git.1786388689444.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 10 Aug 2026 19:04:48
	+0000")
References: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 11:22:13 -0700
Message-ID: <xmqqo6f81pre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As of 4557f1add261 (rebase--helper: add a builtin helper for interactive
> rebases, 2017-02-09), continuing an interactive rebase uses the builtin
> sequencer, which spawns `git commit`.
>
> The child may trigger auto-maintenance, which may need to replace files
> for which the sequencer still holds resources. See
> https://github.com/git-for-windows/git/issues/6315: on Windows, this
> produces unlink retry prompts that cannot succeed while the sequencer
> waits for the child.
>
> Resources such as file handles or memory mappings must be released
> before spawning a command that may run auto-maintenance, as established
> by 28d04e1ec197 (run-command: offer to close the object store before
> running, 2021-09-09).

The sequencer is holding some resources, presumably because it needs
them to continue, and yet auto-maintenance wants to remove them?
Whether or not we face a Windows-specific limitation when removing
them, it is concerning to imagine what would happen if
auto-maintenance were allowed to do so and the sequencer then
resumed its work, only to find that the resources needed for its
operation were gone.

I think what the proposed commit log message lacks after 'must be
released' is 'and after auto-maintenance finishes and we regain
control, we will automatically reacquire these resources in a
refreshed state to proceed'.  Such an explanation would allay the
unease I expressed in the previous paragraph.

Perhaps issues/6315 talks about what exactly are held, but not
spelling it out in the log message is not helping readers.

> Release the sequencer's ODB before spawning `git commit`.

Makes sense.

> The regression
> test uses the legacy-delete trick introduced by 69ed0e35a754 (mingw:
> optionally use legacy (non-POSIX) delete semantics, 2026-05-07) to
> trigger the failure on modern Windows.

> diff --git a/sequencer.c b/sequencer.c
> index 57855b0066..83952d96e3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1127,6 +1127,7 @@ static int run_git_commit(const char *defmsg,
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  
>  	cmd.git_cmd = 1;
> +	cmd.odb_to_close = the_repository->objects;
>  
>  	if (is_rebase_i(opts) &&
>  	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 58b3bb0c27..8f81c80fd4 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -65,6 +65,24 @@ test_expect_success 'setup' '
>  	test_commit P fileP
>  '
>  
> +test_expect_success MINGW 'rebase releases object database before committing' '
> +	test_when_finished "rm -f .git/hooks/post-commit repacked packs" &&
> +	git switch -C repack-rewrite primary &&
> +	git repack -ad &&
> +	write_script .git/hooks/post-commit <<-\EOF &&
> +	git repack -ad &&
> +	>repacked
> +	EOF
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="reword 1" GIT_TEST_LEGACY_DELETE=1 \
> +			git -c core.commitGraph=false rebase -i HEAD^
> +	) &&
> +	test_path_is_file repacked &&
> +	ls .git/objects/pack/*.pack >packs &&
> +	test_line_count = 1 packs
> +'
> +
>  # "exec" commands are run with the user shell by default, but this may
>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>  # to create a file. Unsetting SHELL avoids such non-portable behavior
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
