Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0832595
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033967; cv=none; b=bSzSAJHyPK+Y9/AwgPUq41ZlOyS9BhJ4RQ+E/5jvCnOXP5DyfSNMpampuw27uJ7uYBBXAu20zrOyXOHYeDEDf9B8rbt9f6ZpHYXvfEmNpYZtLfSDCW896Gpw5gDfrhqqbRIWS0RT0UHh5CcgHwIIIznmR8Sb4oCTyYFaQ/zalFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033967; c=relaxed/simple;
	bh=va1z3xUxG+pczTfWn6/Jd73fWtgOC/yqlqAGJYqrOa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QZzNXf9RtQ0bkctWXneJnj2MQ7nSs/8vl5DbrjGAC4F91y8qmA9hMbwv1rzPEXzWjCJu0ybhSvjsUEZRQNgJ0spa18m1dJu1etU6nWI66jKLijMOHUdzIVmp0Nxey/xMz/TO3d3RtLSUdjJDQEFG5LC53k21ga088S2AUMfafzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iws1IhR8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iws1IhR8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3394b892691so962353f8f.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 13:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708033963; x=1708638763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3GWi+kOv8h1GCHHXRWNaTMbMvHnl9NYWnHuGVHVNQU=;
        b=Iws1IhR8p+ZU7uHWEJU670eHmrHkNzXvD16m44dX8qaPf/GGcGAQJHCXvwEDpJS0dv
         WqkT/1bcxk5NO3B0Sulr1sAhaGIap1uGhLFy8cM4WY0Eok9JrHnueVS8JXXGDED5QO9D
         9k8pDKZCNYzo3H85IbDdMat88LxWvniMiRJN79Bud8b0wuRXn0u0SvZqiVNJTnlBCzta
         B02yae7i1ct8Y1AQalQmpy4hZgJphWQbrbwHDJJ4GAX2osox6A+QVVctQ0hCcQ/YRpIq
         s3B+ZcCvbGGRRjpx/3Ph+9GKLJ2iBksMYd5ISjBjG+JhDwZaSDgQ2kLIDLqHezHb7gvQ
         UWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033963; x=1708638763;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3GWi+kOv8h1GCHHXRWNaTMbMvHnl9NYWnHuGVHVNQU=;
        b=gja6oKBCqdTD/drymsY7zWqSEvvh99GyWD6zGjh3xub5z53YlA3uO2JNl6/whWM4hw
         LWSUbvp8m+Z/zs5LExTKdWjCgzDztA8eYdOIFhJIPJBQxR3nC51vD6sem/tHCxEarKt7
         o95G1Tq5fd9WHU/mUgZddINKshg5NGWPtSTUT2T0Im7cYSNGhbQmQcteV+BS1KpHguVo
         yujwyGrv9G1If7Q/qfSWL1OBbeG/E4lcNSI3XYhmDCCUE+dAoHRSEwbOZbXDy+SEav5b
         ss9kCFh6XpMHRKeE37NNU8yQZn/cMsUeHs2kFOAq8UcvRPCL/AmQFfgIHo0XxqC+3Ce3
         ERig==
X-Forwarded-Encrypted: i=1; AJvYcCVkukOlD6Mwm1p5QOBT6vE5VCA97iSaCo4jyQB85vZ8A474AUPuAq1JSEA92gjdfKNFNO/MTP3asLFLGk/nQBLnFpGr
X-Gm-Message-State: AOJu0YxXRanJOf2KA9xaEoclJexGUd5DP83uZqBkVdh5iZKRgNhok9t2
	xz8uYtf3UMH6gQuUlwhxjqNN0MPgIyL4uE4zfUbfHYDYb0ay9C4d
X-Google-Smtp-Source: AGHT+IGufogjarDaqb8c1O+XlAUJogSgp/Q3FgCq6y0GlQanyJVakci+QYD1/ow3IPiLQ63Pi8O4XA==
X-Received: by 2002:adf:a458:0:b0:33d:1bc3:83c4 with SMTP id e24-20020adfa458000000b0033d1bc383c4mr15988wra.12.1708033963353;
        Thu, 15 Feb 2024 13:52:43 -0800 (PST)
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id o11-20020adfcf0b000000b0033b4dae972asm308467wrj.37.2024.02.15.13.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 13:52:42 -0800 (PST)
Message-ID: <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
Date: Thu, 15 Feb 2024 22:52:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
To: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15-feb-2024 19:42:32, Dragan Simic wrote:

> Move the descriptions of the <oldbranch> and <newbranch> arguments to the
> descriptions of the branch rename and copy operations, where they naturally
> belong.

Thank you Dragan for working on this.

Let me chime in just to say that maybe another terms could be considered
here;  like: "<branchname>" and "<newbranchname>" (maybe too long...) or
so.

I have no problem with the current terms, but "<branchname>" can be a
sensible choice here as it is already being used for other commands
where, and this may help overall, the consideration: "if ommited, the
current branch is considered" also applies.

> Also, improve the descriptions of these two branch operations and,
> for completeness, describe the outcomes of forced operations.
> 
> Describing the arguments together with their respective operations, instead
> of describing them separately in a rather unfortunate attempt to squeeze more
> meaning out of fewer words, flows much better and makes the git-branch(1)
> man page significantly more usable.
> 
> The subsequent improvements shall continue this approach by either dissolving
> as many sentences from the "Description" section into the "Options" section,
> or by having those sentences converted into some kind of more readable and
> better flowing prose, as already discussed and outlined. [1][2]
> 
> [1] https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/T/#u
> [2] https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/T/#u
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Notes:
>     This patch was originally named "branch: clarify <oldbranch> and <newbranch>
>     terms further", submitted and discussed in another thread, [3] but the nature
>     of the patch has changed, causing the patch subject to be adjusted to match.
>     
>     Consequently, this is effectively version 2 of the patch, which includes
>     detailed feedback from Kyle and Junio, who suggested moving/adding the
>     argument descriptions to their respective commands.  This resulted in more
>     significant changes to the contents of the git-branch(1) man page, in an
>     attempt to make it more readable.
>     
>     [3] https://lore.kernel.org/git/e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org/T/#u
> 
>  Documentation/git-branch.txt | 44 +++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 0b0844293235..370ea43c0380 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -72,16 +72,6 @@ the remote-tracking branch. This behavior may be changed via the global
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
> @@ -128,18 +118,28 @@ Note that 'git branch -f <branchname> [<start-point>]', even with '-f',
>  refuses to change an existing branch `<branchname>` that is checked out
>  in another worktree linked to the same repository.
>  
> --m::
> ---move::
> -	Move/rename a branch, together with its config and reflog.
> +-m [<oldbranch>] <newbranch>::
> +--move [<oldbranch>] <newbranch>::
> +	Rename an existing branch <oldbranch>, which if not specified defaults
> +	to the current branch, to <newbranch>.  The configuration variables
> +	for the <oldbranch> branch and its reflog are also renamed appropriately
> +	to be used with <newbranch>.  Renaming fails if branch <newbranch>
> +	already exists, but you can use `-M` or `--move --force` to overwrite
> +	the files in existing branch <newbranch> while renaming.
>  
> --M::
> +-M [<oldbranch>] <newbranch>::
>  	Shortcut for `--move --force`.
>  
> --c::
> ---copy::
> -	Copy a branch, together with its config and reflog.
> +-c [<oldbranch>] <newbranch>::
> +--copy [<oldbranch>] <newbranch>::
> +	Copy an existing branch <oldbranch>, which if not specified defaults
> +	to the current branch, to <newbranch>.  The configuration variables
> +	for the <oldbranch> branch and its reflog are also copied appropriately
> +	to be used with <newbranch>.  Copying fails if branch <newbranch>
> +	already exists, but you can use `-C` or `--copy --force` to overwrite
> +	the files in existing branch <newbranch> while copying.
>  
> --C::
> +-C [<oldbranch>] <newbranch>::
>  	Shortcut for `--copy --force`.
>  
>  --color[=<when>]::
> @@ -311,14 +311,6 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
>  	given as a branch name, a commit-id, or a tag.  If this
>  	option is omitted, the current HEAD will be used instead.
>  
> -<oldbranch>::
> -	The name of an existing branch.  If this option is omitted,
> -	the name of the current branch will be used instead.
> -
> -<newbranch>::
> -	The new name for an existing branch. The same restrictions as for
> -	<branchname> apply.
> -
>  --sort=<key>::
>  	Sort based on the key given. Prefix `-` to sort in descending
>  	order of the value. You may use the --sort=<key> option
