Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71121415F34
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828566; cv=none; b=ut4jKjC0oTEJYQkVi8B5BJDfb1Gm+n4JfzB1Yl4DySQ2/b+Cta6JiRN7SRsNUIbDz0dE3+FJX0NaOUvEY5MiNtjQYNhnZzg18PvACc0WfymieA9zo4cHflk4Ytn/WThJfbQ5PW8KkA0m/RLbA2ExR4K5hJ9Jy9bYgRMaK3HBJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828566; c=relaxed/simple;
	bh=3Q5oOaFsa4Lzs729XuH0PmyHYW3s95XEvVMHRgrBTtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ilaz/DRoHWGvM7FasxLftL/RKBa3dRiVDY9e4NaZRO2brbQgBfwQ9To0dBqXs2Cz9S7T1iiiOKFmzf/9me4IB5T09I25sYEOoVueuiXZt3e7/jbVl58d5Ai9QkWtrh+d1h2i7/5ItHs1QYjhJS7AqA0nDCQ7qlxG2nP0q37o9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SOEDdWBx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5DKboX6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SOEDdWBx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5DKboX6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC4017A0097;
	Thu, 23 Jul 2026 13:42:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 13:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784828562; x=1784914962; bh=/nu6MWZ6UR
	rlGAn7M5fPjmrN6UTjJzE95y+lwmTvL4Q=; b=SOEDdWBxtwOGxqmsiO9GS3Qfve
	KqW15UsTFymeCSrdN4X77+ilpbIBWI/BdpqWPGdaE8KwvduTy3zAtAUFhFeHZEAD
	39TRl5lAYJFMSQ+RE0ywz8g2wBOrcQiskCy9bJdhani+UzjCVCvV62LgHS7ul0bO
	4V9wFG1we0Sm4jZIQ7d8OcXmq011ADrY0XLqgqF+KI67e3b/DzNgdsg733wGwj0D
	6lTPxZlPU+gHPhboj6X8+qnU1pCW9D4O53ZieMzh2AoqhELZivZrrpe/0S+7nS/6
	WL+R13iINlTD3OKOuQeKxj4+g+lOOHDiPRgFK0u88LViJeDjabE8a9fhlayw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784828562; x=1784914962; bh=/nu6MWZ6URrlGAn7M5fPjmrN6UTjJzE95y+
	lwmTvL4Q=; b=S5DKboX6rpPtpPnhAdBOM8QcBRx3ShfrOWQSnGvIkEHzOz/qN+f
	e0WgFb3yEQYuPbEZwZvnXSUilvwu9C0PJapryZ8netMCeP+zGWewsIRONcpquJeu
	RHdxw//3LRKxuTUh96CRVGQ5wspEfMbg+aLzUI0wD39GCanz5BtSv1rmktTq6ySq
	Tk9gQRFOcHgNJa+0qhUckG6/2NmEckqTzDJJNr1tqznKSYQrOmguAqjsfNnmW5Lg
	78Ab12qsGiG5YM08UIkG49pX4btoGtptkbqPOa+tYm33FtZQRgJ3M6kz7YasqLy7
	78tw9e65LIGbGKXYzhoXr8hfQU8+kvHR8fw==
X-ME-Sender: <xms:klJiahliC1C_-T3TdOjAPTTYBAySF4MAoJf0Fa0LBnOetpupZp5X1Q>
    <xme:klJiajshNIcgQPO6izylB8u-6egsOrCyPXDW_--whs1HmGAWNOf5nYFAs0LAaT45C
    d6cKJTKTDxyCK8MfT5bY-LwUGDNuh8pel7TsPUJEixpDmnj8CDeHQ>
X-ME-Received: <xmr:klJiav-6g9YVc-ZZoiuKObdxAETMiOcjoLMLT6c26npOpudZ8EdNyRXoV9UnttQ1rFQPKOJjkHLeNLm_y1v1_duXrsA43xIY-Q>
X-ME-Proxy-Cause: dmFkZTE3oLWafwiKuSgkGTnV1YOH1JS40yanKdCs1RPga23ZIzfd2OpXzTK2JkXwuF8426
    0eNVBRsMmmlgQqasD51Ge+mDVXgPp8/9pq8T2lNkE/U6xwwZxsVHnhozkaRe4DaKtciqmo
    BPKSgPsI+tlVkfY+1FpFYu5ZgWDsgfkfzfCIj0X/5FO6ztrWRne6u/x8T7HJTZcTWSUb5D
    jCQXqG0NvQbng1MYEQHXOknMaNEweTqwTyNAew6mVYm2fl/YJNfwHTOSQewEpx4WgpHMxb
    KyzgzKgA+w6H/idGD0Ti0/C+ZSIZ6bkf1RNXAuHN5XQnZHwOMq7bUMlDscLZ/qeVVVx4U+
    XAtRMfPN0F8IhNFEnqACxfjabZjhSVgFtBoWXwXxm6Qxypz5qqA5tfq5bhwfaNQGWG+bCo
    wcM9n/HN8wINDJvOYtoUgp2ZF9XpuhKqE+10F1ETVRUaq8T6EOKU3+VUoaQ5hLxEBXGkT+
    wrcjHeq4nhz95yX0zBSwPalRdH0+nSkLrmNM/NNLKT9uO+00SH52riz1CS4+bRXhbBkiCx
    DZRUgscTxcWNS8wzav+IoXiy0MTJC7BDLSxoERzLTv3R6thLLYp4ENieNdWGRwPtITA0zL
    lx9AHDxyDsdxjrOJAvKYIjZBo1zGz8OrDXKiDEzfj270hmgQuqgmF/LhaVtg
X-ME-Proxy: <xmx:klJiatPizLoZbctdz8JR8muEqacminOSxUZ3xrqPteivpHqeeTlVGQ>
    <xmx:klJiatHin-awvmCxiWsZECVFrn04N74j837QE_-df-x_909tQCZzcQ>
    <xmx:klJiarSygzLlBs5jx0z4Xj_ZNLmTm_PoHfAXEyM8HJ0xY07fnSRUPg>
    <xmx:klJiaqsWygAMGZsvsB5t8fa3vyb7wW1Bsbw_NzduD_z6dkERAThDoQ>
    <xmx:klJiasfqILXywibBrrjD-qQtbCi8jFY5erk5xGORRLp1B2Q5Fhav5TFD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 13:42:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Lucas Zamboni
 Orioli <lucaszam0@gmail.com>
Subject: Re: [PATCH v2 2/2] mv: check for missing destination directory
 before renaming
In-Reply-To: <1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
	(Lucas Zamboni Orioli via GitGitGadget's message of "Thu, 23 Jul 2026
	13:13:10 +0000")
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 10:42:41 -0700
Message-ID: <xmqq8q71k3fy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This is a best-effort diagnostic rather than a guarantee: the
> destination directory can still disappear between the check and the
> rename(2). It fixes the common case and, unlike the syscall path,
> lets "git mv -n" report the failure.

If "can still disappear" is because we are not taking into account a
move that we are scheduled to make, then that is not very nice, but
as long as it is *not* our making (in other words, somebody else may
actively interferring with the mv we are trying to perform), I think
this is OK.  It is the best we can do.

> Add tests covering both the error path and the dry-run detection.
>
> Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
> ---
>  builtin/mv.c  | 21 +++++++++++++++++++++
>  t/t7001-mv.sh | 14 ++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 35e504484a..eb59fe0f31 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -444,6 +444,27 @@ dir_check:
>  			goto act_on_entry;
>  		}
>  
> +		/*
> +		* If we are going to move SRC to DST on disk, DST's leading
> +		* directories must already exist.
> +		*/
> +		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +				!(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
> +				char *dst_dir = xstrdup(dst);
> +				char *slash = strrchr(dst_dir, '/');
> +
> +				if (slash) {
> +						struct stat dir_st;
> +						*slash = '\0';
> +						if (lstat(dst_dir, &dir_st) < 0 && errno == ENOENT) {
> +								free(dst_dir);
> +								bad = _("destination directory does not exist");
> +								goto act_on_entry;
> +						}
> +				}
> +				free(dst_dir);
> +		}

Horrible.  Please fix this overly deep indentation.

> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 7cf4aa5ba1..2d8a98d8b0 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -114,6 +114,20 @@ test_expect_success 'clean up' '
>  	git reset --hard
>  '
>  
> +test_expect_success 'moving to non-existent destination parent directory' '
> +	git reset --hard &&
> +	mkdir -p from &&
> +	echo content >from/file &&
> +	git add from/file &&
> +	test_must_fail git mv from/file no-such-dir/file 2>actual &&
> +	test_grep "destination directory does not exist" actual
> +'
> +
> +test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
> +	test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
> +	test_grep "destination directory does not exist" actual
> +'
> +
>  test_expect_success 'moving to existing untracked target with trailing slash' '
>  	mkdir path1 &&
>  	git mv path0/ path1/ &&
