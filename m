Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86B241686
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932022; cv=none; b=ayaEYiTUhSAriGvV/wvRMi9/A9dUOYYEyj6CP8z4YqGFJN4BxgBw3lXUdy8MTp+XQxNY2zoIm2EjneuOjy3RYsB5eOhz0zKYglHEOZEYT+fGtO/h/GCwf5ecVHuQs5Y48aPo72AFfsGj8Q7wuvt9H8zWSFh19yttWdEDj6dNjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932022; c=relaxed/simple;
	bh=g0cKPqUXXYKJ0/9yYtmYVSoIwh1dLVUCybsIEdn46J0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aD53RrkQ0G/5v1TafM2bvuijUyFev8aTaNhmzX65SNRrsnLlna+uXJAGmi+d21YOkF1lM2mO+jpP70WM4DD5BfjZfpGje5B/pj8YKKZsH6n8kL8Fz3DBzzFfMJ9WUFIofnFSVxB1BFhWO6XsSYAnJPAl9GRKXHn9SPlEGaIFXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KQeFxPdd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZiKrNfHS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KQeFxPdd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZiKrNfHS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E6091D00104;
	Fri, 28 Aug 2026 11:46:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Aug 2026 11:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787932014; x=1788018414; bh=/pubb2qSU7
	gCI+cKeLVaO/NyhgrTlU31m/g+8zUGub0=; b=KQeFxPddH/Bj19/Eri0L5wnzj6
	ZuwJYsI+WZFYUrhcLRNOrGtJ5/2uAZglNi+Y63du9xzKZfGOtVVrrl1Vdf9yj71D
	oxNrEaUCIs5y+80+m/TKNVDlr9aogVfZBWfbSeXNvksx9AvSyUaa5o9aOmbR2rJs
	sYcq/SKt1JZT6/ZSyDjGv4g7ZPPi+/SG8cJRSwjH0erSwjYbvGMp279OM0WkKzpc
	DPQSJ4BbUvgFcAnx1rFkx3JI2vKe7nQg0wU0mLd9Nqv+sHYN3JQZOeowhXyJJ3Iu
	wTIQS6gBm4/s116uTjz8djjuQK1MOAqHNvnFeMhvbwhEWOchkB8u7cSD6aqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787932014; x=1788018414; bh=/pubb2qSU7gCI+cKeLVaO/NyhgrTlU31m/g
	+8zUGub0=; b=ZiKrNfHSVPZd99DKmgbAWNjgGhDUiwOTzGezfhe24lYEn2n7bD/
	xFVoT42Jzk0gGBapAUWb22ixALWQ5kIZClHMd1XB7AHJhaqogghVF6mNmNS25NxY
	7WVz6a5tgq7+aCJX5XhWqoAbogBGnMFG3Yai+pxy5bnGpI5fbdIDT8jNhsup2jbC
	N+TmWnISH9LDT1knUlZMlNwlmU56yFsj7e20vZSrM6d75c4FFVeivn66GnrDzyBh
	UPPXw0emhRuv7q2EEFk6NpMrqvXGX3PSJPRmXVXcDsxHkVJvTlyR3RHPnDoV6P4Y
	X2VZ9H+CP8BP18TGxDzIs5ripWlbguPWX4w==
X-ME-Sender: <xms:bq2RajU0ss6-78HsS2Om7g0lp6fE8E92L8jHOtRpSltXYYf4xBMxmw>
    <xme:bq2Raie_0E6iLAbxJ34NKwF_gq2oHr_kIrTUBnWXe7vSrOcNgTiVEnlXLgZhXBJye
    VpdjXfj_wkj35XV3zLLGu77GCu3L9-xIWS-1VtDldFEDrIdOuJUGj4>
X-ME-Received: <xmr:bq2RansApcdpo2QmYHlHF9l_MsbTdprJI9DEUMQao6U7DlFuGfYIKUKd7tqVozF73Tn_lymOWoiO0DJckkOnmEnvOc9qZUbPsg>
X-ME-Proxy-Cause: dmFkZTE/CYSe9ZzgjrAWiUqLH6HgclKkYzMrKMmPtwQyTQ48t394TQJAO5TKKNJq4AzwJQ
    K9CdVIg7YIbVnjXrLADMsOlfKslqIMNcTKNUmxXhLIS9rapFdAHUli69Ki8rylxIDx+Z4f
    L10bUr5Nt6Jikq7ZUF2+iz/MHwVqDep3WIwCuHVOqhfyzLahBTkpggcTX5x97HEhm6/cdk
    D5xb3GHqOlBsCGK7LgG4U0QQFQ1NgJHWiVah2yTlFLU4o/09TrNEYUZpXCIj68umkJPuBF
    lLkKb05OpcrdfAaOVnVmRdcugjc/4XV/DmL5DXlSCSfXHBzf/emtROg7+ggIJ3ZlwUemHN
    6GBv9PgEZWwHOITFSZ83vwY3fVQWtOfSCR9SiJjt45YQ5cKZAcmuT9N5NNgrSXp28h4gbl
    Q7vOfypl+WF5YGaybLP/bHlUJ5BMTMXR56RT/rplAvQIDZOg/t4YfKxgVR1mIAdXpA2HTe
    sEi6q+SxiGtg+N6FR24jQ3S5JZfK7YGghO1fXGICznDT4lksEKkLpDu831U3hgJ4hAnErB
    jOuWQbJ4XKVOqdoznKqWoh0KOKKhnn0l+Jyw2digm0Z3XXQnuD862ovy3pUgHdSxGW0eYB
    xVz6gZJFmHzWwm8LBv0DEBHNxtGY6mQ7FF8CG+u5MlpcYwM0MWP2gFdDOL1Q
X-ME-Proxy: <xmx:bq2Rap_gtOCV33voifyx4i6KR2jGBHFLCeRyE8-dDtCXEWbCs05nSg>
    <xmx:bq2Raq06fFjoqVfR3maUDxEilz9HDp8ZSmaTjr56fqCwf99e-ojqvw>
    <xmx:bq2RamDDFGtpSY5RatXLoAZD4RWdF6OpGWA1SgE1H2XvOxmKo4Ipzw>
    <xmx:bq2Raue3GPIeHLwdo6f43srsSR5Ok-SADFRl1iRbMhvA_yzndkRGLQ>
    <xmx:bq2RapOfd5h4OJLgbKCOJ8mQ9wUpg37Qle6p8QlC7WbCrg0P6h71Y__e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 11:46:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/5] commit: allow a partial commit when a rebase
 pick becomes empty
In-Reply-To: <e16930361978335a6718814cf5d56a8dd8b42f75.1787903085.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Fri, 28 Aug 2026
	07:44:42 +0000")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
	<e16930361978335a6718814cf5d56a8dd8b42f75.1787903085.git.gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 08:46:53 -0700
Message-ID: <xmqq33vy6ydu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> For years, we disallowed partial commits during merges or cherry-picks.
> In commit 430b75f7209c (commit: give correct advice for empty commit
> during a rebase, 2019-12-06) it was noted that the "cannot do a partial
> commit during a cherry-pick" message was also printed when rebasing a
> commit that became empty, and rather than drop the check in that case,
> that commit opted to make the message print the actual operation that
> was in progress.
>
> Since a commit that has become empty comes without conflicts, a new
> partial commit poses no problems; remove the error in that case.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/commit.c              | 2 --
>  t/t3404-rebase-interactive.sh | 5 ++---
>  2 files changed, 2 insertions(+), 5 deletions(-)

OK.  Looking good.

>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 569e31fb60..610820c99f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -520,8 +520,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  			die(_("cannot do a partial commit during a merge."));
>  		else if (is_from_cherry_pick(whence))
>  			die(_("cannot do a partial commit during a cherry-pick."));
> -		else if (is_from_rebase_empty(whence))
> -			die(_("cannot do a partial commit during a rebase."));
>  	}
>  
>  	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff11abb2f2..3588e16543 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1858,7 +1858,7 @@ test_expect_success 'post-commit hook is called' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'correct error message for partial commit after empty pick' '
> +test_expect_success 'partial commit is allowed when a rebase pick becomes empty' '
>  	test_when_finished "git rebase --abort" &&
>  	(
>  		set_fake_editor &&
> @@ -1867,8 +1867,7 @@ test_expect_success 'correct error message for partial commit after empty pick'
>  		test_must_fail git rebase -i A D
>  	) &&
>  	echo x >file1 &&
> -	test_must_fail git commit file1 2>err &&
> -	test_grep "cannot do a partial commit during a rebase." err
> +	git commit file1
>  '
>  
>  test_expect_success 'correct error message for commit --amend after empty pick' '
