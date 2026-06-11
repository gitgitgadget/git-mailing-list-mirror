Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99814401492
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183165; cv=none; b=Xi0MEC3cyJAtufdv+J3rgSseJVyFylIZP2Y0b5tCTAElPBj1FU+0HDM5VsAR3wX/vfvPElad4n4rQIVYPLxh2jvkXrUszlN1Od3Sw4PMTO1NlThMY1CA0OA/u/Ku9Ln4GZKWfZbfUKCQ0S8nqpswxwmOd5vOXN3H97air0PVwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183165; c=relaxed/simple;
	bh=GxJznGGXoPIY2c6Hc+2TtXp9NVszcH1At64QvDGgoag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMGiGwg4V1X5qSi0lfjchWirFwCDrBd2ajZ/kreEjMWReHePZRV+O8OsrpKfrGh1dLE6TmGDTCuV9gYZmjqP/DZrpMcJ551+tj4miq3J+lV9prvTa+UlYyda1BrUu5DvsKkYLzmBe4xMTkc8D+3ohovmRcvszoTcJrNtjklvCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQ76XwC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dE6vvdoP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQ76XwC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dE6vvdoP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B5A92EC0084;
	Thu, 11 Jun 2026 09:06:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 09:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781183162; x=1781269562; bh=CZI40rML38
	Khf2ZzDTPTzDs/2rk4MFGNtnxuQiBBs5M=; b=EQ76XwC3U5ykfMVVGbyqtT80SN
	k8NdC042LcDxbrTqcWyw5s4VoVHJWfoz2Ghzd7KE6eevM/kLYDRpMSrvh4y2YtJF
	CFzhl7Lfzf+MuoPuU1xpYt01Ku5p3KD44xPjyvbTDgxppG27WOCOtbsZxCoICNlf
	y8ucIt2HWqtA/gEv20VF0SLXyUkg8u4TZyB2V8h1AsCW121H++iyULu7YNM2Hgv3
	50MDjiXA7YdAWdb1tEGrg89KVVNYmFRj20ks2tidzOj+ItJBkT6b4D4V76ad6+Mn
	idGgPh94JVlapigoCG39nOGMwqhVHR5a1wmbWsjk6dMfRT+7ZPjVaU4fsSrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781183162; x=1781269562; bh=CZI40rML38Khf2ZzDTPTzDs/2rk4MFGNtnx
	uQiBBs5M=; b=dE6vvdoP/n4tHO4k/ojnrPezF/62cWIuKk6Sil3QLi5cQuViL21
	6nqvgQ84hcaiKz2KPxhiAGJyG8cDNkPSSK1Mc51GJvtrFbvsgob2kzexRQHgwJ3A
	kEZ90o0OwYo00APTKOLZJiexcT5GDvh6bUvdbpqxsjyEL6edFGfuQNdCJh9bxtIw
	zMeSNyJh3UXintUe0A/aSn098/WkL+CMXw3YySBkdvTZ6ImYUSvGl8IpQ7vpGVNq
	euC5Bpq2o8EOD1OfxgMgDPA4bYLRUEB9OWXykN5cB8zMQ4ypHSA28XolipsutEng
	oOq3j99v9l6C1rDIM03M7EHZD2V71tcCzxg==
X-ME-Sender: <xms:urIqaubhMisDl-nlKv5KB-6Gksnz_GTJxH1ClK85a0eOumOHehue7w>
    <xme:urIqanZyOqjE66g-Vu3sMBVVebzgXMpyFCKYUNKiL_Ck5cqPFDQ7SOpRWvb0Cm8Ds
    sQwjtNUlxWDmdOEfjYsNuXDRBC54KwFWdBX_bRbXA7w_wCuej-UYQ>
X-ME-Received: <xmr:urIqamm2yTDbSfZS6bU5E5LSTpGM050n2yaMCjig4PKj9a7zY47q_qG6ktX9iqOZGPaJ4irn6PV2A3YPxjmB6DmOr8Zc44nHxtJJZDlh3fQX>
X-ME-Proxy-Cause: dmFkZTFt48nZYsdAHR+8nj0cPvpNyPmed1kwxQiSK6GdxFnJdTR2Xa6bTWQ58KZ9Ln9v89
    0G2BtVAonyTbfJIvAp/jEEwIr9HjcFPm760vl+FcFCAkY8MuU1/+OlscZxuCzTZiB6v5PJ
    LvrSzJDUO+lT+9kZcwpwDttWg44H5GMXwnj6Vr6dcO8Q7Bc6L3CQKyc0Bq8+WerTS5s9o+
    H5n0O9CIXTw0+uBhQs9C9iAzozdGcF/oUUn6S+xd4sKkcAA7Zvs5mDVNMFGhBne3U80kfh
    jHdjqeWjhTvqaKSMj8yU+fmprE6ibLTNgPp1pTHqqB6maikYrI2sycZcUByMGvVY4k5vgd
    1cgRcOfKrsdgocePs5WkE0jwopARpWrYi/NGPVrej8QWuYAkC+TjUGcQl4dP2SNFF0WmPG
    199DeICuoqT9K/nhE/tnGOBYWZqVHT2wudnxrz8HSpJ/St7IPCc4mw+BG4AI3QVzN1eYlV
    LxEEd/7zFn6gTn+AqNgsXnjEKoB3/wk5phEjHgWrBhCznl7jT3lXXO0p7Hq419QmnFS5ds
    8JWACyX17QM3XYzccbwyJfFB9m8ut9+V5ntYNd0frcyD0XJEWv9UOWpHYkW3IpX1vMpq+c
    AbHTYryGIRRoayH3ZsnXXHIWk+UKFoeDp+va3dPZ89WNYDJTvLcRoMh8/Ipg
X-ME-Proxy: <xmx:urIqarxJa16TDboKFnG8DuRCBaT6Mzyx0o65d2vnrEUMIgvfohe44w>
    <xmx:urIqasPKA4POnbz0PvOXznemsFl7NvyIQPsyrrBWum-DX2zg7MGQvA>
    <xmx:urIqanRyJNRfGVwcwuFxser_7PsP5oGR8WjQ-Wtu56hPAar4p5YZvA>
    <xmx:urIqaiam3QhXRGVyMmIv1cZiaePuwa3uuRDZNq2-9UVA4n4B3RG9rQ>
    <xmx:urIqahzbjAL7XlpzoLRcvnRsOhQ97_VJWJsmmh7b5X06Fc6vreVNSTlg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:06:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 316c5de5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:05:59 +0000 (UTC)
Date: Thu, 11 Jun 2026 15:05:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] update-ref: add --rename option
Message-ID: <aiqytJD-rcEirhgE@pks.im>
References: <xmqqv7brz9ba.fsf@gitster.g>
 <20260610212800.2892146-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610212800.2892146-1-gitster@pobox.com>

On Wed, Jun 10, 2026 at 02:28:00PM -0700, Junio C Hamano wrote:
> Add a "--rename" option to "git update-ref" with the syntax:
> 
>  $ git update-ref --rename <old-refname> <new-refname>
> 
> It renames <old-refname> together with its reflog to <new-refname>
> (even when used on a local branch ref, the current value and the
> reflog of the ref are the only things that are renamed).  As the
> command is a low-level plumbing command, attempts to rename branches
> are not warned, but we document it to draw attention of unsuspecting
> users and protect them from burning themselves.

This sentence reads a tiny bit awkward now and is probably an artifact
of the change between v1 and v2.

> Because the "--stdin" mode wants to operate on its refs in a
> reference transaction, and the API function refs_rename_ref() does
> not work well as part of a transaction, it is currently not possible
> to add a corresponding "rename" verb to the "--stdin" mode before
> the underlying API learns to rename refs atomically inside a
> transaction.  It hence is left for a future refactoring.

Fair. I thought at times about extending reference transactions to also
fully support renames, but I never had a good use case where it would
really matter.

>  * The initial draft I sent had a warning when the command is used
>    to rename local branches, but that is unusual for plumbing
>    commands that should do one thing it is designed for consistently
>    well without being chatty.  This version only has words of warning
>    in the documentation.

Good, I just wanted to complain about that warning. I think it's good to
just accept this as-is. I really doubt that folks would go out of their
way to use git-update-ref(1) if all they want was to rename their
branch.

One thing that I'm missing from the commit message: what's the
motivation for this new mode?

> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> index 37a5019a8b..0c27efaa52 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -39,6 +40,14 @@ the result of following the symbolic pointers.
>  With `-d`, it deletes the named <ref> after verifying that it
>  still contains <old-oid>.
>  
> +With `--rename`, it renames <old-refname> together with its reflog to
> +<new-refname>.  The command fails if <old-refname> does not exist, or
> +if <new-refname> already exists.  Because `git update-ref` does not
> +update active worktree `HEAD` symbolic references or `.git/config`
> +tracking settings when you rename a local branch in the `refs/heads/`
> +hierarchy, think twice before using this command to rename a local
> +branch (use `git branch -m` instead).

I'd rephrase this slightly to first document behaviour and then draw the
conclusion that it shouldn't be used in many cases separately. For
example:

    This command does not update any symbolic references pointing to
    the renamed reference, and neither does it update `.git/config`
    tracking settings. It is thus not recommended to use it for renaming
    local branches. Use `git branch -m` instead.

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 2d68c40ecb..65ee8af08c 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -787,7 +789,7 @@ int cmd_update_ref(int argc,
>  	}
>  
>  	if (read_stdin) {
> -		if (delete || argc > 0)
> +		if (delete || rename || argc > 0)
>  			usage_with_options(git_update_ref_usage, options);
>  		if (end_null)
>  			line_termination = '\0';

Okay, so here we make it mutually exclusive with "--delete".

> @@ -800,6 +802,32 @@ int cmd_update_ref(int argc,
>  	if (end_null)
>  		usage_with_options(git_update_ref_usage, options);
>  
> +	if (rename) {
> +		const char *oldref, *newref;
> +
> +		if (delete || argc != 2)
> +			usage_with_options(git_update_ref_usage, options);

And here with "-d". Good.

> +		if (!refs_ref_exists(get_main_ref_store(the_repository), oldref))
> +			die("no ref named '%s'", oldref);
> +
> +		if (refs_ref_exists(get_main_ref_store(the_repository), newref))
> +			die("ref '%s' already exists", newref);
> +
> +		if (refs_rename_ref(get_main_ref_store(the_repository),
> +				    oldref, newref, msg))
> +			die("rename failed");
> +		return 0;
> +	}

Hm. I think we're not using "--deref" / "--no-deref" at all, but we
document this flag as accepted in the synopsis.

Thanks!

Patrick
