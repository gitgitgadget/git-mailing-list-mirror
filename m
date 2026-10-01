Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF62EEE8A
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869728; cv=none; b=N/QGwtyf9AO3PCeYSTBa0mNqcMn9MoRN0kRhUUfDNqFubzMHAfH5yCjN7LX7vBS52DCKy8jsF6lKfXP99cZR1pGjL/as5PBr5acyR7ULpnnoVE4IAu+//rmYWHApNd4TE3z1jhT4y3uQ++MFQLQvnZMvBjrQguS51zRyX8QpXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869728; c=relaxed/simple;
	bh=JjoFJfsd8z/L2wu08+xnYZ1zjJAbGSR0P/LSp5kpQ4Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P91eGeO8MK95t6UQy4XZ2rwyumsQ4veW/6jm8l1QK4w5t1Vi0tQ0TOJNmdyEmZhH8Y7B2qQPytkA3Fz4tYF3hGVHbvtTtyKSJq7hiRa9uwIH/3BpUaHBwOqSQwlkkDQ0X30Ii4GBbLt1C+mvjQdEELq9U2rNjCOkiDcuFN2sVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B72MLk80; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B72MLk80"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so42038255e9.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869724; x=1791474524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQfb8X5/3h/Pfvp9esI6Jld1NJ9MHSuDHLu13Ao6ddo=;
        b=B72MLk80YIppKqND4s/ljKS5vNKDuZ1/Kc22J8J2vSFmJFY74HMC+sCxsnSYEdG1xI
         MB6dQY1aRfMwqKOS7Gqx0JSzpAxlj/+VzL71i8lG+DmoWSXTGrJ4ibD93wT3fSoqWVYZ
         V+LtRypHEyF27LzNniJRDcVDCPRReqZwc4NdIyg6zE03iCI/2tVHUzyIhGFLUH1Jodh7
         gIaZETUsxA5RS8HFc6p3312QAxA2JtjMWfXYXorB+IFH5xTjanTPs0cs0SjEQhr2fEQp
         PbsWR2vKZWtDgIXfQMQTYOaeH9tMXsbMULiTrph7NdgLRymT277zR0zsBijjwWsHPey3
         AFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869724; x=1791474524;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQfb8X5/3h/Pfvp9esI6Jld1NJ9MHSuDHLu13Ao6ddo=;
        b=LF9v6LRFzef4tErNZjhCt8m+JBgUKJcWINmlOy0OaIRAnazUR4CrtAQDiKBujRa9Sx
         22RB9ZxlppKb5gwClJuJO4UImo/kC6EK8xgNeIHGa8wDgAs5Dh0ZQEupRaD/5dEeXjHx
         ATE8tuHi61C/VMhMmC84kPBu7w4mLTgp3PvW9SXOwPwyxGfUydpVyLUAT+28+PfqxqFj
         BdK8NanVBvt5GG8WeP3ijYUjbyyUA5ySUTRVwb2/pijru+YK4aw/YJ0prJVoz1SbprIx
         imZTs7rWYM13I4gF6Po5HLpghL+O0RnWGLuRkEfNWZ3SHiHKT4U8byIwdkNDTRHWZU7t
         7KIg==
X-Forwarded-Encrypted: i=1; AKwUvBzCXcjaLm6+Csc4aOZqc+FrI02PqZOIxAoBQVnG+J+KQKyO2sqKZLEzb7yJ9EBxjHZEcTE=@vger.kernel.org
X-Gm-Message-State: AFuF++mRZBbVDqiQhwbayB55k8ljDZ/FizH/2+iuEkDrk/v7zH938/gw
	TpGAjakMdvtHJsN7GTGLGNLnwiGqTaYnBziWp8a1Tp8DLDykSc2KIR9e
X-Gm-Gg: AYBFou29IfC9Ob/iHY8ZJqcH5urx5XDNu+QkSwlTOyGy3DRks+LgK8SvIY8fxjoWV2J
	iPTmUE5eJT8WhQaMflRxAIbH2XO1IjCq23XD3+Wq+sGUO4ZaqW+NuZi7eQYu78yLB6bFCPTV2Cm
	Q+1UgFNU717n9htUtOJpYngoB/Ti+flx8bRJWj7qy9GV91eTAMT6k6I72+kQMLmkNa8MGl134Ki
	ftBsAr3+LiKUaOORtCkXdQFOt4fFfY1W6nDqCmffXSvgdx2EhEawZnJZ1ooljO+whMuqXAD2Hzl
	QCms0E3H64xAxPUY+bbptTPVUXJVXdDEWrvgGAxNkUNkluTiDcZiRu+xMXaTzX3SNso9gULKll5
	v3eTlkTwvjF0Nl7oqXMsu4q8jW7JvFpD99ApFYuTGnheCX4OVwJMq0Ns/hfdpXB7hlJM7CDu6N3
	BeGXEjotLqIg8oxvY3nKFWd6XsN9rrm7cYNIL1X0YXtdn1IQTX7QtHCqq8wzHumrZx92pogl+MC
	PIU+q/jxGtuTyxkvcJvc1zpBtbd9sL5UVfl2XZXL/SX989JJdCvoQ==
X-Received: by 2002:a05:600c:6d1:b0:4a0:1d3d:502d with SMTP id 5b1f17b1804b1-4a02755f856mr537085e9.10.1790869723523;
        Thu, 01 Oct 2026 08:48:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f97a0aesm70925175e9.3.2026.10.01.08.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 08:48:43 -0700 (PDT)
Message-ID: <667a68a1-641f-46c4-a718-8dd81d5c219f@gmail.com>
Date: Thu, 1 Oct 2026 16:48:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] t5520: don't expire reflogs where it matters
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
 <pull.2243.v3.git.1790843056949.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2243.v3.git.1790843056949.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

This looks good. Thanks for the patch and also your help finding where 
the difference in reflog entry count was coming from - before your mail, 
I did not realize that "git merge" stashed changes without "--autostash".

Phillip

On 01/10/2026 09:24, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> "git merge" saves any uncommitted changes with "git stash" before it
> tries a merge strategy. When the strategy does not handle the merge,
> it restores them with "git stash apply --index". If some of the
> changes are staged, that runs "git reset", which writes an entry to
> the reflog of HEAD. The tests that pull with autostash disabled run
> eight such merges, each with a new file staged.
> 
> An upcoming change makes "git stash apply --index" merge the index
> in-core, so it no longer runs "git reset" and those entries go away.
> Another makes the default "merge" backend of "git rebase" run auto
> maintenance when it finishes. Together, they change when auto
> maintenance expires the reflogs.
> 
> This means that unfortunately the reflogs are expired at the end of
> "git pull --rebase" in the "--rebase with rebased upstream" test. The
> "git pull --rebase -f" in the next test looks for the fork point in
> the reflog of refs/remotes/me/copy, but as the test suite dates every
> reflog entry to 2005, the expiry has emptied that reflog. Pull then
> finds no fork point, so the rebase also replays copy-orig, the commit
> "copy" was rewound from, and it conflicts.
> 
> Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
> expire reflogs where it matters, 2026-02-24) did for the rebase tests,
> so that the test no longer depends on where the expiry falls.
> 
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>      t5520: don't expire reflogs where it matters
>      
>      The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
>      bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
>      https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com/
>      
>      Changes since v2: only the commit message. I had the eight merges in the
>      wrong tests: they come from the pulls with autostash disabled, where
>      "git merge" stashes and restores the staged file itself. I also dropped
>      the clause about the hundred entries and took Phillip's opening for the
>      third paragraph, all from his review:
>      https://lore.kernel.org/git/8b81c508-ac67-498d-b78f-a4b5dab8c198@gmail.com/
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2243%2Fthomasbachem%2Ft5520-reflog-expire-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2243/thomasbachem/t5520-reflog-expire-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/2243
> 
> Range-diff vs v2:
> 
>   1:  6699f3782e ! 1:  be6c3f21c5 t5520: don't expire reflogs where it matters
>       @@ Commit message
>            tries a merge strategy. When the strategy does not handle the merge,
>            it restores them with "git stash apply --index". If some of the
>            changes are staged, that runs "git reset", which writes an entry to
>       -    the reflog of HEAD. The autostash tests in this script run eight such
>       -    merges.
>       +    the reflog of HEAD. The tests that pull with autostash disabled run
>       +    eight such merges, each with a new file staged.
>        
>            An upcoming change makes "git stash apply --index" merge the index
>            in-core, so it no longer runs "git reset" and those entries go away.
>            Another makes the default "merge" backend of "git rebase" run auto
>            maintenance when it finishes. Together, they change when auto
>       -    maintenance expires all reflogs, which it does once a hundred entries
>       -    in the reflog of HEAD are due to expire.
>       +    maintenance expires the reflogs.
>        
>       -    With both, the expiry comes at the end of the "git pull --rebase" in
>       -    the "--rebase with rebased upstream" test. The "git pull --rebase -f"
>       -    in the next test looks for the fork point in the reflog of
>       -    refs/remotes/me/copy, but as the test suite dates every reflog entry
>       -    to 2005, the expiry has emptied that reflog. Pull then finds no fork
>       -    point, so the rebase also replays copy-orig, the commit "copy" was
>       -    rewound from, and it conflicts.
>       +    This means that unfortunately the reflogs are expired at the end of
>       +    "git pull --rebase" in the "--rebase with rebased upstream" test. The
>       +    "git pull --rebase -f" in the next test looks for the fork point in
>       +    the reflog of refs/remotes/me/copy, but as the test suite dates every
>       +    reflog entry to 2005, the expiry has emptied that reflog. Pull then
>       +    finds no fork point, so the rebase also replays copy-orig, the commit
>       +    "copy" was rewound from, and it conflicts.
>        
>            Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
>            expire reflogs where it matters, 2026-02-24) did for the rebase tests,
> 
> 
>   t/t5520-pull.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 27f38ab3c8..bc818605a5 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -35,6 +35,12 @@ test_pull_autostash_fail () {
>   }
>   
>   test_expect_success setup '
> +	# Commit dates are hardcoded to 2005, and the reflog entries will have
> +	# a matching timestamp. Maintenance may thus immediately expire
> +	# reflogs if it was running.
> +	git config set gc.reflogExpire never &&
> +	git config set gc.reflogExpireUnreachable never &&
> +
>   	echo file >file &&
>   	git add file &&
>   	git commit -a -m original
> 
> base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3

