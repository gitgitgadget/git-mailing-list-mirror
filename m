Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9A2D5935
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839442; cv=none; b=oDglq34MOrVvPrpHVDPD+Hpza7E7evAoPYutUVoqjHVPcXhPMrjql6IPS5VJ+UZmqitnY8QzhdKcoIszBK6L5T/VZJCAfwFf4rtUBMKiXBI/a+VrkyGTqR/2dYLWwpWZad6iDiV9GA5A+xjfiMUWdqNYN8B78rY5Sd8C/YTKMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839442; c=relaxed/simple;
	bh=yk3X3Oybrq+mn/+KNHqPdKIU12GJycBA57wWc2U+rsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CERozQYnj/SefJLAbbuW9DMfeOnVta54pnQBQG/DaNDcO75FV47RMQ9uacS1Rtc7juFskAjhmM+SMjw1dIvpYS0N6wdXV2+DYFEBOW5rGampjr5YU+y0YexJd39RT+PyiWH220iPiIRF5ZCSi/D2uhvJIN/WaTBpXV0PB6dMb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nq5OrsAr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qaQE4IJz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nq5OrsAr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qaQE4IJz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B0877A0085;
	Wed, 11 Feb 2026 14:50:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 14:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770839440; x=1770925840; bh=QlKawa+icA
	F364BwbLHo2KpaOHjNEMrF/NJn4RKuMg8=; b=nq5OrsAr+effawJr6uFmC9tlQE
	u7ix6OmhfOZZuJ1nB128MaYSKP3wOsNZjwBUeUQx3jxkGu/NUPlPsQRpvpfONRXO
	D187JbZgpuiiSjwFmyk+XvWNWNuFccJwcl0UQXaxxZHgL2kPyzThPM4LrcNIN0sW
	M95SD+/3inbxYQEjvkKzakLIE/aNIQlKD3FlFpKpRFLzAphV32FuvcU20MpgVEjF
	YVit3rgTZPdq03EtqXvhzbxpF23kAXAsoqVoJl1eOCWn/mUbpbBVj75xHxfiuP/L
	MNToocJHqYYvoFvJczY/RmeVpBLORvkJ0QMpMyq69TZ0fulHl46V58O8jwJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770839440; x=1770925840; bh=QlKawa+icAF364BwbLHo2KpaOHjNEMrF/NJ
	n4RKuMg8=; b=qaQE4IJzdmXIxnu+2qfwb2F/pqYCHO3PbKefMI5AW61dOS6DF2e
	F13jCsV22iDYGyvTxFu+l5qvt0vXD1MEyFOWoxBCR3XMYpbnSlK9/yO8Bg3ls1ch
	IlcDqN7efYaJYdIvA89A8vu6Py5VkwVb3DaH9VaqGjCkKXwjwi7B9KKfJysP5tVQ
	tvN9HJReUxiyARyVCgQ8LZLtT+r54x0PRf7UCqsnKEvHkCWiSfteJFbBg+vRIZUS
	jnrxl7l/4lg+mwKLI4gBEQ3x9NKnaqec4pD+BJF2btWzZsjyDHO6Tx8/m2ccHIuj
	LFY1fTzqcFHyHNK8c2UxYafBifJ0F21CtXQ==
X-ME-Sender: <xms:kN2MaWJ-CO3x_Fuk9CIg70_NCBfQqKuCGBVFkE_uyCWWaCuJQ61V2w>
    <xme:kN2MaVKcsG9ZRDAphxTRjlPQsmGSeahWXLWMM7Vhxk5skLYHyox7uR9pVvAi33hz7
    YvLHdF7Y8hegWViSwk_OvEuG8DptaidDRTKyoWn2_cqanxRZXN0>
X-ME-Received: <xmr:kN2MabtIJuD06eQnRBMSmqjY77AI-wfPbtgMMJg3Q-iJlJq6fTPMfNodOChSm2OL5Flpfq0EGb0BuosdUUYSSVYPMiXWgD9rYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhgrnhgurhgrkhhrsehpmhdrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:kN2MaaQHKeUJ-F-4YmkJNeUSQqQRd2KIPbVZGvUo85iL379BKzwmqg>
    <xmx:kN2MaZPOxl-GtEtQpVc63eMPK6t5UZLxAplLqGiFakBoNciw_zMXsg>
    <xmx:kN2MaXZUWJ2xwV1nvUQRGqV8X9O9KEoKfcoJlAlsI0TylQ9JJcSCDw>
    <xmx:kN2MabwNMRMMPDhNTss_M6Eu3Izekc5-980yqlEH7yZQqqO1Xhiyhw>
    <xmx:kN2MaUsOfaw1X_FLFiqlEyBmayY_kiC58Lk-yD7UN2YpDLK46c5eVX07>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 14:50:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Kethi-Reddy <chandrakr@pm.me>
Subject: Re: [PATCH v2] add: support pre-add hook
In-Reply-To: <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com> (Chandra
	Kethi-Reddy via GitGitGadget's message of "Wed, 11 Feb 2026 15:05:12
	+0000")
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com>
	<pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com>
Date: Wed, 11 Feb 2026 11:50:38 -0800
Message-ID: <xmqqseb7rre9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 6192daeb03..c864ce272d 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [synopsis]
>  git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
>  	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
> -	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
> +	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize] [--no-verify]
>  	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>  	[--] [<pathspec>...]
>  
> @@ -42,6 +42,10 @@ use the `--force` option to add ignored files. If you specify the exact
>  filename of an ignored file, `git add` will fail with a list of ignored
>  files. Otherwise it will silently ignore the file.
>  
> +A pre-add hook can be run to inspect or reject the proposed index update
> +after `git add` computes staging and writes it to the index lockfile,
> +but before writing it to the final index. See linkgit:githooks[5].
>
> +`--no-verify`::
> +	Bypass the pre-add hook if it exists. See linkgit:githooks[5] for
> +	more information about hooks.

I'll leave it up to others to comment on and make concrete
suggestions for the formatting and markups, but the word pre-add the
users must use verbatim that is not marked up in any way would not
look good in the documentation.

Is it and will it always be only the pre-add hook that this option
will bypass, or if we ever add another hook that decides to interfere,
will that hook also be turned off with this option?  This reads like
the former, but the intent would be the latter, no?

I'll also leve it up to others (including the original author of the
patch) to propose a better wording here, as I am not good at naming
things ;-)


> +pre-add
> +~~~~~~~
> +
> +This hook is invoked by linkgit:git-add[1], and can be bypassed with the
> +`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
> +`--edit`, or `--dry-run`.
> +
> +It takes two parameters: the path to a copy of the index before this
> +invocation of `git add`, and the path to the lockfile containing the
> +proposed index after staging. It does not read from standard input.
> +If no index exists yet, the first parameter names a path that does not
> +exist and should be treated as an empty index. No special environment
> +variables are set. The hook is invoked after the index has been updated

What are "special environment variables"?  What happens, for
example, if the end user has an "special environment variable" set
and exported when running "git add"---are you unexporting them?
E.g., Does GIT_INDEX_FILE environment variable visible to the hook
when you do this ...

    $ GIT_INDEX_FILE=.git/alt-index git add .

... and if so, what value does it have?

In other words, is it worth spelling this "special environment
variables" thing out?

> +	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
> +		int fd_in, status;
> +		const char *index_file = repo_get_index_file(repo);
> +		char *template;
> +
> +		run_pre_add = 1;
> +		template = xstrfmt("%s.pre-add.XXXXXX", index_file);
> +		orig_index = xmks_tempfile(template);
> +		free(template);
> +
> +		fd_in = open(index_file, O_RDONLY);
> +		if (fd_in >= 0) {
> +			status = copy_fd(fd_in, get_tempfile_fd(orig_index));
> +			if (close(fd_in))
> +				die_errno(_("unable to close index for pre-add hook"));
> +			if (close_tempfile_gently(orig_index))
> +				die_errno(_("unable to close temporary index copy"));
> +			if (status < 0)
> +				die(_("failed to copy index for pre-add hook"));
> +		} else if (errno == ENOENT) {
> +			orig_index_path = xstrdup(get_tempfile_path(orig_index));
> +			if (delete_tempfile(&orig_index))
> +				die_errno(_("unable to remove temporary index copy"));
> +		} else {
> +			die_errno(_("unable to open index for pre-add hook"));
> +		}
> +	}

Do we really need to create a copy of the file?  I am just asking
without knowing the answer myself, but given that the general
architecture of file writing used in our codebase, which is to (1)
prepare a new temporary file, (2) write new contents to that
temporary file, and then finally (3) rename the temporary file to
the final location, I would expect that between the time the control
passes this point and the latter half of write_locked_index() calls
commit_locked_index(), the original index file would not be touched
by anybody, and can be readable by the hook.

> +	if (run_pre_add && !exit_status && repo->index->cache_changed) {
> +		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +
> +		if (write_locked_index(repo->index, &lock_file, 0))
> +			die(_("unable to write new index file"));

This mimics the pattern used in builtin/commit.c:prepare_index()
that populates the index file (the real one, when making a
non-partial commit, or the temporary one when making a partial
commit), closes it, and let us later commit or roll back depending
on what happens in between.  Looks sensible (but I have to admit
that I may have missed resource leakage etc., as I didn't seriously
look for such flaws).

Shouldn't the die() message mirror the wording used there, i.e.,
"unable to create temporary index" or something, or is this fine, as
it will become the new index file once the hook approves?  I dunno.

Thanks.

> +		strvec_push(&opt.args, orig_index ? get_tempfile_path(orig_index) :
> +					     orig_index_path);
> +		strvec_push(&opt.args, get_lock_file_path(&lock_file));
> +		if (run_hooks_opt(repo, "pre-add", &opt)) {
> +			rollback_lock_file(&lock_file); /* hook rejected */
> +			exit_status = 1;
> +		} else {
> +			if (commit_lock_file(&lock_file)) /* hook approved */
> +				die(_("unable to write new index file"));
> +		}
> +	} else {
> +		if (write_locked_index(repo->index, &lock_file,
> +				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> +			die(_("unable to write new index file"));
> +	}
