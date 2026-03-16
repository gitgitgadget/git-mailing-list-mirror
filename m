Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7123390982
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680277; cv=none; b=llU7pIqQy/0SZwvsJcPX+Q6a6coJMMt7wTUCTtH9YlIYW4KVRcGFS3fVD/Z/3/J+1R55pVGcpXVb5wBlJzwpZNrkACa0pG9Y9/53AzsvNescuICpWUbJRq+DOCMbofJJbl5OYZ1OPxDOv41e8aLMaZNJnQt3+Tf18EhBvkZ0pC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680277; c=relaxed/simple;
	bh=D3FPmqMUqOotdoEsHMZQU492MiXxmmgy8UnZSuQtZNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVywotZ742zmn0YAZeHoFj68xfrv7anEtAX8pj/lo3RiLWgeH5LnVzYMPqgXLDYX1+jfWE6oahrfzDt1+LyDWsiUpfInyEY4mEhpnIyPWuUD9RWkJRGWY9LhD2tVvyAWJo2PFI+9F9xW8KF+RBegisF/zV6WBvPZqlPqgCqS5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHu3IXs9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHu3IXs9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso44528015e9.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680274; x=1774285074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UP4kBRW9G0+vx2PQYS5rwxgUKAgFVXRacShLpJiCh20=;
        b=ZHu3IXs9PTrpv2gckr+x/i8KKz+ju9JtpLdyaAjoDKlf6Imw+/AnK3/QR9L1YLkN0P
         0uRWym5aD88HQOFt0d22pMpvSZAEAADdUSn6y6cVO22Ww8V+1nvRpwm1ZLuMEmwIAUqH
         O0Y+Ddt6PaVVpLA7z1lBe6nYqsr35/DrDnSt6bRC5VsMBKutmzgozY8vxc4wvPYfnfjf
         hTeAXmtkINGaljMLV6WgcVcqO1PjyhvFV+E3FdHvGLqfRM2vD0t9GQmBGxqNxQ2f5IJY
         QiQ4yGjW0OucJamvO99QlfL7az17VdyYBxmqIPv9I6JxSzuqovxxZOn6372cY3ZmKDBC
         5OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680274; x=1774285074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP4kBRW9G0+vx2PQYS5rwxgUKAgFVXRacShLpJiCh20=;
        b=iW7URBR99p4zxyqF2vGMz64WjFJQ1Pa1f/aA5O0Wgz71kNMYA+3UP6BtFubtySQYQC
         QuflAP6k7QUQREtIFnxXcgcu+6cvXM4a+l2sZiSksoyxZ+sHDjKsRLUdJE5gmL3JlZYW
         Qv4hdYtt4ivEqo9MBV2NEDKL3BhBdDAYYdpvbbb/pXMxDnkgU2KU1zxvtcibVzfV/m0E
         wggC2f19iJWh1UPEzR5ecLwapXU8ZGLvfx5McHbQzQwn3Hww8B7VcLcWB1gSiF6tTi6O
         GPudZ/Ggit9moDvh6lYmFWjDzjLMq1haURVhh9b0EG3MkdzF8+ErlxzWjphSsQuy/Yi/
         4eWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv1SuajBfcFvbXQzUOLIjKrOurcNDqF2Tb0jcGZYJTuZPEUYgQXulHWH3Ev46JgqnZWtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIkhpGdjj9R0xIofG4dnaLI5FKN31Datocd3rUxW+JwGrubJJ
	NjEXphB8+mAESgsEiySUcIH/oM83Z+JyuchxrZddvqOFl8tg1zo1TAFN
X-Gm-Gg: ATEYQzyR2mL6bAyrMR7MKYAXEJsCUmGs5Z5WKSjf6cDPXvTmyfCoVSOhrHbxHLhlcW9
	4xIGwtbM7vAuxZe6T+EfXU3b1arDppA5SMk2Cy8z/WqPucSKxzti9KNskZrCB3/vL5nMe5f+1Xz
	QQ5hxLAtIgRbG3qmb+ZK8P2S0sUXXsxaK2guROzhf3EXYuUgu1+CUnLCkW0J4d5sQWpOsgXFHXZ
	tp6qK2FPpSO118XHxzDlJDZIaY0IYx1UmVYaqpBi2ObznNMN4bN98NmaF/DvRHl1AmvsnoWQ0IY
	L3ng6QSuX2T2evfMvN3d0Ai6eqqWfWyAwUPhRkWrfHxbZLwHdJck3UI/D2iXh4h31c+GEhH2Jc7
	b/rYhWX007+vcByRcBmgbSJ2Krf9itDT23FP51yKHK1ipLEx50iji84x3iK1ex3j+NSW90Ke8HL
	jpwL7T/C5Ctn4tKT0TTelXtZkbpey1egKej/C8iWjBsfLz1Qp+kb3Rfbn2dsb081N3Envlj8Rmb
	0KGww==
X-Received: by 2002:a05:600c:4f54:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-485566faaa3mr236329265e9.21.1773680273851;
        Mon, 16 Mar 2026 09:57:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563f619csm157801635e9.1.2026.03.16.09.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:57:53 -0700 (PDT)
Message-ID: <f18f9bb4-4c30-4972-a034-a74b81a3e1e6@gmail.com>
Date: Mon, 16 Mar 2026 16:57:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] replay: add --revert mode to reverse commit
 changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de,
 toon@iotcl.com
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-3-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260313054035.26605-3-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddharth

On 13/03/2026 05:40, Siddharth Asthana wrote:
> Add a `--revert <branch>` mode to git replay that undoes the changes
> introduced by the specified commits. Like --onto and --advance, --revert
> is a standalone mode: it takes a branch argument and updates that branch
> with the newly created revert commits.
> 
> At GitLab, we need this in Gitaly for reverting commits directly on bare
> repositories without requiring a working tree checkout.
> 
> The approach is the same as sequencer.c's do_pick_commit() -- cherry-pick
> and revert are just the same three-way merge with swapped arguments:
> 
>    - Cherry-pick: merge(ancestor=parent, ours=current, theirs=commit)
>    - Revert: merge(ancestor=commit, ours=current, theirs=parent)
> 
> We swap the base and pickme trees passed to merge_incore_nonrecursive()
> to reverse the diff direction.
> 
> Reverts are processed newest-first (matching git revert behavior) to
> reduce conflicts by peeling off changes from the top. Each revert
> builds on the result of the previous one via the last_commit fallback
> in the main replay loop, rather than relying on the parent-mapping
> used for cherry-pick.
> 
> Revert commit messages follow the usual git revert conventions: prefixed
> with "Revert" (or "Reapply" when reverting a revert), and including
> "This reverts commit <hash>.". The author is set to the current user
> rather than preserving the original author, matching git revert behavior.

This addresses all my comments on the previous version. I've one minor 
comment below but I'm not sure its worth a re-roll on its own.

>   
>   test_expect_success 'cannot advance target ... ordering would be ill-defined' '
> -	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
> +	cat >expect <<-\EOF &&
> +	fatal: '"'"'--advance'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined

This quoting is a bit strange - we'd normally drop the '\' form '\EOF' 
above use ${SQ} instead. git grep shows there are 220 instances of ${SQ} 
vs 31 instances of '"'"' in the test suite.

Thanks

Phillip


> +	EOF
>   	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
>   	test_cmp expect actual
>   '
> @@ -398,4 +399,105 @@ test_expect_success 'invalid replay.refAction value' '
>   	test_grep "invalid.*replay.refAction.*value" error
>   '
>   
> +test_expect_success 'argument to --revert must be a reference' '
> +	echo "fatal: argument to --revert must be a reference" >expect &&
> +	oid=$(git rev-parse main) &&
> +	test_must_fail git replay --revert=$oid topic1..topic2 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'cannot revert with multiple sources' '
> +	cat >expect <<-\EOF &&
> +	fatal: '"'"'--revert'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
> +	EOF
> +	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'using replay --revert to revert commits' '
> +	# Reuse existing topic4 branch (has commits I and J on top of main)
> +	START=$(git rev-parse topic4) &&
> +	test_when_finished "git branch -f topic4 $START" &&
> +
> +	# Revert commits I and J
> +	git replay --revert topic4 topic4~2..topic4 &&
> +
> +	# Verify the revert commits were created (newest-first ordering
> +	# means J is reverted first, then I on top)
> +	git log --format=%s -4 topic4 >actual &&
> +	cat >expect <<-\EOF &&
> +	Revert "I"
> +	Revert "J"
> +	J
> +	I
> +	EOF
> +	test_cmp expect actual &&
> +
> +	# Verify commit message format includes hash (tip is Revert "I")
> +	test_commit_message topic4 <<-EOF &&
> +	Revert "I"
> +
> +	This reverts commit $(git rev-parse I).
> +	EOF
> +
> +	# Verify reflog message
> +	git reflog topic4 -1 --format=%gs >reflog-msg &&
> +	echo "replay --revert topic4" >expect-reflog &&
> +	test_cmp expect-reflog reflog-msg
> +'
> +
> +test_expect_success 'using replay --revert in bare repo' '
> +	# Reuse existing topic4 in bare repo
> +	START=$(git -C bare rev-parse topic4) &&
> +	test_when_finished "git -C bare update-ref refs/heads/topic4 $START" &&
> +
> +	# Revert commit J in bare repo
> +	git -C bare replay --revert topic4 topic4~1..topic4 &&
> +
> +	# Verify revert was created
> +	git -C bare log -1 --format=%s topic4 >actual &&
> +	echo "Revert \"J\"" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'revert of revert uses Reapply' '
> +	# Use topic4 and first revert J, then revert the revert
> +	START=$(git rev-parse topic4) &&
> +	test_when_finished "git branch -f topic4 $START" &&
> +
> +	# First revert J
> +	git replay --revert topic4 topic4~1..topic4 &&
> +	REVERT_J=$(git rev-parse topic4) &&
> +
> +	# Now revert the revert - should become Reapply
> +	git replay --revert topic4 topic4~1..topic4 &&
> +
> +	# Verify Reapply prefix and message format
> +	test_commit_message topic4 <<-EOF
> +	Reapply "J"
> +
> +	This reverts commit $REVERT_J.
> +	EOF
> +'
> +
> +test_expect_success 'git replay --revert with conflict' '
> +	# conflict branch has C.conflict which conflicts with topic1s C
> +	test_expect_code 1 git replay --revert conflict B..topic1
> +'
> +
> +test_expect_success 'git replay --revert incompatible with --contained' '
> +	test_must_fail git replay --revert topic4 --contained topic4~1..topic4 2>error &&
> +	test_grep "requires --onto" error
> +'
> +
> +test_expect_success 'git replay --revert incompatible with --onto' '
> +	test_must_fail git replay --revert topic4 --onto main topic4~1..topic4 2>error &&
> +	test_grep "cannot be used together" error
> +'
> +
> +test_expect_success 'git replay --revert incompatible with --advance' '
> +	test_must_fail git replay --revert topic4 --advance main topic4~1..topic4 2>error &&
> +	test_grep "cannot be used together" error
> +'
> +
>   test_done

