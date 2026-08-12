Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7937E5EF
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550883; cv=none; b=ppXFlINSZOACOAFBxCpRq5OcFFIU0YA9eWJFAJyN5z1EaB6grhjQeCNyXpH0tRgUBx3B+glZJia+8+mFVMvWSPIqfExQGJZ9JBroTL6cpU9VYefIFXgu2q+IrXWv6XbZkcWkluhCsipvuww2p5IWb639/bnxCJX2fhpMx8/R+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550883; c=relaxed/simple;
	bh=ua4iBTFBo8HXyaui69hd8s9TqDC7/CYL9TzKMrfdSEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NkVqt3xGmaBy6bvLSNq20a2P+CyeRTCKzg7c2dqFleoypldKEnyvwZxBKYs9+D2h/4/8Jgdw3HEh//V49z0Y0JI7PULfBwPGIjgDTchScGN0JVKVu07693IX44SZv0TQ/L6Ez8opghNXZDHeHWj4a/vAy6J5CZ5MQqNQnzRiLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kIeWiiKy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRSTI/CN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kIeWiiKy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRSTI/CN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14BCE140011B;
	Wed, 12 Aug 2026 12:08:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 12 Aug 2026 12:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786550881; x=1786637281; bh=M+H/T1/1Zz
	Bq8p/rBI/qZ5hd3einw/GEX85LdMDlSGU=; b=kIeWiiKyJRUvDqsI/8O7mxadAd
	VSZYfhXQiasrsyu7SWatpPrlPF3UuLPKKFvnSYPSI+TbNpzfOoKuphxPNTnbXxEk
	eI9p1J6wWnJ1syxcpJCIHYjn2jmHeb/sWqsq8p1UvX86BpmOxwO0zA+TUjSt5Fk6
	ozzejezdqfkCgGcGm3JgJNSd+ayhEp9E2dULT9BCmUfSrAvVBSWj3eN9ki++gGwz
	gjTopD/mv0gB9QRN6NFBI4xqy4GW9N5YveaqUjaggiAFZgdy6wntp7y3XDDNjQzN
	c8yiRgPaBxPvDbk65YKJPp4QAkvTvOCF2tP46BS5ZL29Z3GJT0Aqku6cfeYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786550881; x=1786637281; bh=M+H/T1/1ZzBq8p/rBI/qZ5hd3einw/GEX85
	LdMDlSGU=; b=PRSTI/CNzyt9Sul6WkKQi30KP4N59DQjr1WwR5i2gDiHklY9HUS
	jn1Lu77g+DFg2fKqwS0XWYtTJAISeKIf0wNkmJ6Ap+lV3+dyHp/SfVpzDnlnTK48
	NpXDQnh7FSyjnrsqUC+n37IhQX1irlBMSpy0v0qiHhGE06txhvJt9oq4XfaOBoWK
	5s6MTNr+CUQdUigcWuS3tsoKAFunjxzCX8+iKyVironEIsY6X+SOglxQ2LnyEtlJ
	ZxYj8IYnx3meQeSTyjKIufDLVzlfXQ/0bgadBDxV+utZ6Vd0cRTB0zsTFFjcdOxZ
	9ixAnpiTuQVUJ/icppjaZkoTWY04/tDc1MA==
X-ME-Sender: <xms:YJp8akkxqet_0DXRCNRUoMwVWIEQGwjtG2DOvZNpUlOjymoT-WGXXA>
    <xme:YJp8aq1SzHk5_tfTOn19dJuskYAq1y015CVAYpcsPjSXMBhaxrTox0khLKguNaNl3
    5skUBB2fZjuGE_U90FJcSVsN0_LYbAzF-SzeH_-VV2jwKexZACTeA>
X-ME-Received: <xmr:YJp8anqvrBk16j6kL43uQLFGMBjTF51uyiwEBg-H-Z0d_Bsqa9HqlsRUjZ6CYC0VQsgmO9UJ5SfITO_Nc0ZlOJ2MQOwgEB4ggw>
X-ME-Proxy-Cause: dmFkZTED7OhH15clFfNYKhkOllCvEjRW/jJzRG5VFlXYVdttfp+E2X4EmV0zSIR+nKOOI6
    Bvp/IZBUOkWojl4vX3snjpVZooDFiY4brA5Jllf4pUn6sDMU/7bwFqchWqxKvTgdrqp6/N
    R7+9eSyvJeQjzOgYH/M1Jy5GdkQK6GN87AnbXWt2nM69BhZFo4qn1ibp3u/AnM1FLEu5P9
    JlEmk0TCJuIt8kqnW+dxOo14KwaEPs7La1k7OCMdMrHJyh9KQr6MGrrarg+ejjKOVS+mdo
    62WFGO7SwJBbIYOA0Tbt/RcHD7D26ZlYVhOxCrawPJ6Oizj8f4EkK9UwLsc/BaNBlbkNY3
    Ro7RSPleKlj/RGwj8Fotxl4ua0A3ksdsB9JldlzdtvEPC+SJT6P4RwQ71RIViUVDBLlecM
    cgn9kovZ+SQJB6Lf2GvkPORvMMHHIBv9rXQcs7NFI53MoEMjXr8yUPFRg2sQj1EsYUVhrL
    GHXH8joPaAP456pK0+a+/tP7tXD+oGxud0dh584VSSzjy9hA/yCU8FJVz0Wh7oEpmzt+AI
    GsL/XMpzh+5heWUpx5VZIm5+wSCZPzX4bGhhcVnyhgHFtYVbzysY7Jj/QBY1CwRqB8VySz
    ejOw3vFHf3jEY4l+x5a/WYA6MXGNjzYqqGv24guD9sYvlMIMu+6hrHSIxRag
X-ME-Proxy: <xmx:YJp8avdgxn3Dqo7bww8msvIh12KOX446eiFyS2UGSfTBqjH4rMMRYg>
    <xmx:YJp8aupoigvMy6yWRgU2FUoiK9sV1Lo0OceUVLMhPU3r48lhquB5zw>
    <xmx:YJp8aoE1fzboD5R1mgEJzgXqtBSuKb9KZ4OVyicRybPwS0Kv9sv9ag>
    <xmx:YJp8amvBEjcn3_ODhynx6gDvhpk5wslkpY4PThyG0pMpRCwUat96dQ>
    <xmx:YZp8alC931_8p4bTj5kzd6aLausur1aGq_eFJcaRVGhPfi3Ko-Izoy7F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:08:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] sequencer: release the ODB before spawning git commit
In-Reply-To: <pull.2198.v2.git.1786528498689.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 12 Aug 2026 09:54:57
	+0000")
References: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
	<pull.2198.v2.git.1786528498689.gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 09:07:59 -0700
Message-ID: <xmqqqzk3xqxs.fsf@gitster.g>
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
> running, 2021-09-09): release the ODB file handles and memory mappings,
> so that auto-gc can repack (potentially deleting existing packfiles in
> the process); If the sequencer needs to access the ODB afterwards, it
> will gracefully (re-)open the ODB.
>
> Release the sequencer's ODB before spawning `git commit`. The regression
> test uses the legacy-delete trick introduced by 69ed0e35a754 (mingw:
> optionally use legacy (non-POSIX) delete semantics, 2026-05-07) to
> trigger the failure on modern Windows.
>
> Assisted-by: GPT-5.6 Sol
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     sequencer: release the ODB before spawning git commit
>     
>     This fixes https://github.com/git-for-windows/git/issues/6315

Thanks.  Let me mark the topic for 'next'.

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
