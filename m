Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFC44369
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113548; cv=none; b=Ou+bWAAGkWMhSW/ZKQyRXuyCrSL2ILuZh8OZcXvvFw358EL+/1uB/daConCE/0zqfqU20QK/jeOzOE0exlrxdG09BGMYJK/NlkynFZhpiqah5sHZCC1bIxAP3BoM/gJDb3oc5dRSSSIESJmNMKc7pHI3NzFQZCo33MgG9wlQDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113548; c=relaxed/simple;
	bh=SMdWQ8pT4lr9FHonVGD6Q2poktpix+bXuv0QlrYpA/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQcIKdwpvYYl1EDKvGwP1ufAp/TqJXCJeScUrenVdoDlbgchwlJD6JFGlHacXYoh/z3q9fz8ga2Lt87SahjEhG2WnSQ8HUlqzF518R/YCBhfIbV7aS9MHPHgi4ggwuLWjvprS72lbG7xJE5Py3+oKVs4UJQ2v9mboXAAIrx4yNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hOKMz9o1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hOKMz9o1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 265B01E7A28;
	Fri, 16 Feb 2024 14:59:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SMdWQ8pT4lr9FHonVGD6Q2poktpix+bXuv0Qlr
	YpA/w=; b=hOKMz9o1tCOJhaoSqC345YALsOCRU9SUosk2z7sgDlVgfMAT4vwhvY
	/2ETEpXwR6gO6FuAxOAI9css2TDNVbejOH9SJuWPsnI2BVbl21HwIMnhjPfENBb2
	lmBg1nGXB2eNDH34kI/DtCtUVG2DIR5XJA099h5fPJpDjhpiUAzCc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E22C1E7A27;
	Fri, 16 Feb 2024 14:59:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 707001E7A25;
	Fri, 16 Feb 2024 14:59:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name,  rjusto@gmail.com,
  spectral@google.com
Subject: Re: [PATCH v2] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <6e1c3f2c5816f09aab561bc7dec2b7455d70aaec.1708087213.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Fri, 16 Feb 2024 13:44:19 +0100")
References: <6e1c3f2c5816f09aab561bc7dec2b7455d70aaec.1708087213.git.dsimic@manjaro.org>
Date: Fri, 16 Feb 2024 11:59:02 -0800
Message-ID: <xmqq1q9ci3jt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D60D7B74-CD05-11EE-8561-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Move the descriptions of the <oldbranch> and <newbranch> arguments to the
> descriptions of the branch rename and copy operations, where they naturally
> belong.  Also, improve the descriptions of these two branch operations and,
> for completeness, describe the outcomes of forced operations.
>
> Describing the arguments together with their respective operations, instead
> of describing them separately in a rather unfortunate attempt to squeeze more
> meaning out of fewer words, flows much better and makes the git-branch(1)
> man page significantly more usable.

The intention to remove non-option from the OPTIONS enumeration,
and to explain <new> and <old> used as arguments to -m and -c where
these options are described, are both very good (heh, after all,
they are parts of what I envisioned to be the way to go in the
longer term ;-).

>  overridden by using the `--track` and `--no-track` options, and
>  changed later using `git branch --set-upstream-to`.
>  
> -With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
> -If <oldbranch> had a corresponding reflog, it is renamed to match
> -<newbranch>, and a reflog entry is created to remember the branch
> -renaming. If <newbranch> exists, -M must be used to force the rename
> -to happen.
> -
> -The `-c` and `-C` options have the exact same semantics as `-m` and
> -`-M`, except instead of the branch being renamed, it will be copied to a
> -new name, along with its config and reflog.
> -
>  With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
>  specify more than one branch for deletion.  If the branch currently
>  has a reflog then the reflog will also be deleted.

But the halfway modification to the description section in this
patch is not an improvement.  It makes some options described there
while -m and -c are completely missing now, making the section
incomplete and coverage of the operating modes of the command
uneven.  

> +-m [<oldbranch>] <newbranch>::
> +--move [<oldbranch>] <newbranch>::
> +	Rename an existing branch `<oldbranch>` to `<newbranch>`;  if left
> +	unspecified, `<oldbranch>` defaults to the current branch.  The
> +	configuration variables for the `<oldbranch>` branch and its reflog
> +	are also renamed appropriately to be used with `<newbranch>`.  In
> +	addition, a reflog entry is created to remember the branch renaming.
> +	Renaming fails if branch `<newbranch>` already exists, but `-M`
> +	or `--move --force` can be used to overwrite the contents of the
> +	existing branch `<newbranch>` while renaming.

OK.  This is way more readable than the previous attempts we made.

The description of the single failure mode still worries me (see my
previous message on this).  Here is my attempt:

	When the command fails due to an existing '<newbranch>', you
	can use `-M` (or `--move --force`) to force overwriting it.

to hint that there may be other ways for the command to fail, and
hint that `-M` may not always resolve issues, but I do not know how
successful it is.  I could add

	Note that `-M <old> <new>` will not resolve an error if the
	reason why `-m` fails is to protect the other worktree that
	checks out (or otherwise uses) <old> and <new> points at a
	different commit.

but we do not necessarily want to appear to be exhaustive here, so,
I dunno.

> +-M [<oldbranch>] <newbranch>::
>  	Shortcut for `--move --force`.

OK.

> +--copy [<oldbranch>] <newbranch>::
> +	Copy an existing branch `<oldbranch>` to `<newbranch>`;  if left
> +	unspecified, `<oldbranch>` defaults to the current branch.  The
> +	configuration variables for the `<oldbranch>` branch and its reflog
> +	are also copied appropriately to be used with `<newbranch>`.
> +	Copying fails if branch `<newbranch>` already exists, but `-C`
> +	or `--copy --force` can be used to overwrite the contents of the
> +	existing branch `<newbranch>` while copying.

Exactly the same comment on "other failure modes" applies here.

> -<oldbranch>::
> -	The name of an existing branch.  If this option is omitted,
> -	the name of the current branch will be used instead.
> -
> -<newbranch>::
> -	The new name for an existing branch. The same restrictions as for
> -	<branchname> apply.
> -

Removals of these lines are very pleasing ;-).
