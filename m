Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AB4266A8
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604003; cv=none; b=BtFrgn7r9AE5Ere983FElBCXr5cG2BdXLLgzgAvYtsmYkutNm8cG5oYkjQnv45U/7Dg9LMcwFV0FuTS5Nf10hV9VUNPXDngZziKSoVPa/dti+Rta4Hk5VPab1N0AT/UJCzOKo/4thWmFTmPg8YkAfG+hT9aLotZ/ExsPT70kgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604003; c=relaxed/simple;
	bh=+nJovrQqGnu2M+u1FSCvFoFRXhS6iP70+05j8lKZSDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EQqjT/Dfr2ZAzYNOUc6btrnHYLLlenZjWPkWl6sv0+Ii/jbg/50oyL/r6DOMGn8fImsAapVm6FZNF7LJgPCLdHLGnIAsg9dwKS03924VbOXYogBBPrbwywy0gUKycQMu4AFysXThmKWY7RyiTEFMiUo4MrqDcnFHVx+cvKhK1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDYoi4vb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDYoi4vb"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so7921718a12.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604000; x=1782208800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2oKYnTJzruAtSyA7sL8VRli3mWhIi1dkHrgD+CJdnI=;
        b=BDYoi4vbKtkr1qavzhXUNB59JLxb0EjjjNCgcg4cyWOAhpmY1CiUvgLHVMRdT/Spa3
         1kvi6a0AUh8R5A61C+J2plw8iEcbOWrSM8PL0iMAxiYBcxuZbtoHcXN4iViVbJtw/KzJ
         vSalcuEfJImqjyC/rZV/8vlhFodlJkXA4OoyiCUZm/qo6OyC1LitpkBF3je5/fF+LDzo
         HCN5p/JL0OoJTQTdxfb4Rh4dzCDOp4r9f+pP22iLrcz9ztXkKHn8I7dd1MdP3KHTURb5
         pa07f12XbpSR5LFjMqWtFDLfFAIqmOyAQcLu1HBXZI0E/64hTaCYjQOcDKBsGL891pOO
         UiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604000; x=1782208800;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2oKYnTJzruAtSyA7sL8VRli3mWhIi1dkHrgD+CJdnI=;
        b=Xk7ju3BMLuGKp9gAjY7RQbtV73JBGsmxuxH3ms2BNk+MdH058PqayjHXJpCxnpr1EQ
         6DUdG7QIIJTwLPN56U/5CA6HMVSprgKTxHmUc1jwhutH30SENQHXaLm6IOl0OQs5QPQu
         jlaks1FREAdC3wMayt/UyGOchzo9afsRdHGprNJl1N36iyTxXvtBdSX499tE3cYFTSLk
         1GHOJSLbv+fs3kOzAUgt0HRBjh5Dw97rTvX32uKIYXr2SLr7PU5wpWd/2w+3qbObrBwz
         PpGn0yRDLdSRy4IFAxPhkYQ1AUsPynaz7eEqujxqw4CJySWefX+klNOhHEhzSIgjzR/l
         dAcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iIplq+KvtxAwr6PvXWq1OBBBpVbQWkCqa2ZTwPzegG6Xt4CxcBKC9JYLYPj455sQE3us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfP7RdSpRN9JQOhpdgu576kjYip8NZFEvtKsmI+kUNaSaVWjn
	jxSbcNqJf0mntMn2Zu5GrSeNc3+kBh7/oKaKBr8yaajZAK1TptnLVSeF
X-Gm-Gg: Acq92OGaBIirx1EV1ZM4sGtGZ1vAIyLf7K7lvrcuN/+jZE+jswx9c5nGswCmHYZP9C1
	ZN3EPqBCd3bRS5FfXCmzbsXXflF9iTdxywR0TC1DK29exheuNOxfUHhNZ5ZfPjztpG47PIwHIIb
	1f//v02AHp2Vux4S0RpSj21pryKaZmK9HSPFJylSHXBuTbylF6xUkJmL/3xmV6BcNJPbaEtQBZs
	ikHeCVsZcX3S1BBK/1UgQR1dle0penRYNiQ+fXa5Se42hHG9FxIbuuC/hwpxEYejnoN9MPP10OB
	YLTJKty+8r7eCKQtwgebMcdjpfQaGL7y2MXH3vTX7zK+gOO+jy6ggJ5dFHFEE89YOZQe76mT3He
	8H1cEyOoIW/kIMnYPzCyuASNZe6UumwNv3bwXhN5QazGXoD+tyKbZ7yIwbXqmxMNJmD+cIc1mAE
	Vu0iS3gU5NinV0AfWpAaFDYDNoimqPskaPHuQ41rD6PzR8jSIA9Q4XqpmZMR2q2v31XcSMxrVhP
	JJ1QrIP2TY=
X-Received: by 2002:a05:6402:524d:b0:692:4759:ac53 with SMTP id 4fb4d7f45d1cf-693c69ffab8mr7332664a12.3.1781604000141;
        Tue, 16 Jun 2026 03:00:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937919b556sm4733462a12.4.2026.06.16.02.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 02:59:59 -0700 (PDT)
Message-ID: <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
Date: Tue, 16 Jun 2026 10:59:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood123@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/06/2026 11:11, Harald Nordgren via GitGitGadget wrote:

Carrying on where I left off yesterday ...

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 4e7deddc04..27ea1319bb 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1809,4 +1809,205 @@ test_expect_success '--forked requires a value' '
>   	test_grep "requires a value" err
>   '
>   
> +test_expect_success '--prune-merged: setup' '
> +	test_create_repo pm-upstream &&

The rest of this test would be easier to read if we did

	(
		cd pm-upstream &&
		...
	)

rather than prefixing every command with "-C pm-upstream"

> +	test_commit -C pm-upstream base &&
> +	git -C pm-upstream checkout -b next &&
> +	test_commit -C pm-upstream one-commit &&
> +	test_commit -C pm-upstream two-commit &&
> +	git -C pm-upstream branch one HEAD~ &&
> +	git -C pm-upstream branch two HEAD &&
> +	git -C pm-upstream branch wip main &&
> +	git -C pm-upstream checkout main &&
> +	test_create_repo pm-fork
> +'
> +
> +test_expect_success '--prune-merged deletes branches integrated into upstream' '
> +	test_when_finished "rm -rf pm-merged" &&
> +	git clone pm-upstream pm-merged &&
> +	git -C pm-merged remote add fork ../pm-fork &&
> +	test_config -C pm-merged remote.pushDefault fork &&
> +	test_config -C pm-merged push.default current &&

So we clone upstream and add fork as the default push remote. I find the 
pm- prefixes rather distracting. It would be clearer to me if we just 
called the repositories "upstream", "fork" and "repo"

> +	git -C pm-merged branch one one-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next one &&
> +	git -C pm-merged branch two two-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next two &&

Now we set up a couple of local branches with no local commits that 
track origin/next which seems a bit odd. Why don't we create local 
branches based one origin/next (and origin/main if we're using a 
wildcard below) with some local commits like a user would?

> +	git -C pm-merged branch --prune-merged "origin/*" &&

Here we delete all the branches whose upstream is on origin - which is 
all the branches that we've created so we're not really testing the 
safety features.

> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two

This verifies that the branches are deleted. It would be a good idea to 
check the output of command above to check --prune-merged prints what we 
expect it to and that it leaves branches with other upstreams.

> +test_expect_success '--prune-merged accepts a literal upstream' '
> +	test_when_finished "rm -rf pm-literal" &&
> +	git clone pm-upstream pm-literal &&

let's not litter the test directory with a hundred repositories - just 
call it "repo" and add remove it with test_when_finished in each test, 
or reuse it so we don't waste time cloning and setting up the config 
each time (that would mean not using test_config).

> +	git -C pm-literal remote add fork ../pm-fork &&
> +	test_config -C pm-literal remote.pushDefault fork &&
> +	test_config -C pm-literal push.default current &&
> +	git -C pm-literal branch one one-commit &&
> +	git -C pm-literal branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-literal branch --prune-merged origin/next &&
> +
> +	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one

Again we're not testing that nothing else is deleted.

> +'
> +
> +test_expect_success '--prune-merged unions multiple <branch> arguments' '
> +	test_when_finished "rm -rf pm-union" &&
> +	git clone pm-upstream pm-union &&
> +	git -C pm-union remote add fork ../pm-fork &&
> +	test_config -C pm-union remote.pushDefault fork &&
> +	test_config -C pm-union push.default current &&
> +	git -C pm-union branch one one-commit &&
> +	git -C pm-union branch --set-upstream-to=origin/next one &&
> +	git -C pm-union branch two base &&
> +	git -C pm-union branch --set-upstream-to=origin/main two &&
> +	git -C pm-union checkout --detach &&
> +
> +	git -C pm-union branch --prune-merged origin/next origin/main &&

This is more interesting - we don't need the test for a single literal 
upstream if we're doing this. Again we need to test the safety features. 
As these are integration tests you can do that at the same time as 
testing that some branches are removed - you don't need so many separate 
(expensive) tests.

> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged accepts a local upstream' '
> +	test_when_finished "rm -rf pm-local" &&
> +	git clone pm-upstream pm-local &&
> +	git -C pm-local remote add fork ../pm-fork &&
> +	test_config -C pm-local remote.pushDefault fork &&
> +	test_config -C pm-local push.default current &&
> +	git -C pm-local checkout -b trunk &&
> +	git -C pm-local branch one one-commit &&
> +	git -C pm-local branch --set-upstream-to=trunk one &&
> +	git -C pm-local merge --ff-only one-commit &&
> +
> +	git -C pm-local branch --prune-merged trunk &&

Can't we test a local upstream at the same time as a remote upstream and 
save a test case?

> +	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
> +	test_when_finished "rm -rf pm-unmerged" &&
> +	git clone pm-upstream pm-unmerged &&
> +	git -C pm-unmerged remote add fork ../pm-fork &&
> +	test_config -C pm-unmerged remote.pushDefault fork &&
> +	test_config -C pm-unmerged push.default current &&
> +	git -C pm-unmerged checkout -b wip origin/wip &&
> +	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
> +	test_commit -C pm-unmerged local-only &&
> +	git -C pm-unmerged checkout - &&
> +
> +	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
> +	test_grep "not fully merged" err &&
> +	test_grep ! "If you are sure you want to delete it" err &&

I'm always suspicious of test_grep when we know what the output should 
look like - it might be better to use test_cmp. This test does not check 
that we also delete branches that are merged when we see one that isn't.

I'm going to stop here - the tests I've read seem to me to be too much 
like unit tests checking one aspect of the implementation in isolation 
rather than checking that the whole feature works as expected.

Thanks

Phillip

> +	git -C pm-unmerged rev-parse --verify refs/heads/wip
> +'
> +
> +test_expect_success '--prune-merged is silent about not-merged-to-HEAD' '
> +	test_when_finished "rm -rf pm-nohead" &&
> +	git clone pm-upstream pm-nohead &&
> +	git -C pm-nohead remote add fork ../pm-fork &&
> +	test_config -C pm-nohead remote.pushDefault fork &&
> +	test_config -C pm-nohead push.default current &&
> +	git -C pm-nohead branch topic one-commit &&
> +	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
> +
> +	git -C pm-nohead branch --prune-merged "origin/*" 2>err &&
> +
> +	test_grep ! "not yet merged to HEAD" err &&
> +	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
> +'
> +
> +test_expect_success '--prune-merged skips branches whose upstream is gone' '
> +	test_when_finished "rm -rf pm-upstream-gone" &&
> +	git clone pm-upstream pm-upstream-gone &&
> +	git -C pm-upstream-gone remote add fork ../pm-fork &&
> +	test_config -C pm-upstream-gone remote.pushDefault fork &&
> +	test_config -C pm-upstream-gone push.default current &&
> +	git -C pm-upstream-gone branch one one-commit &&
> +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
> +	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
> +
> +	git -C pm-upstream-gone rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged never deletes the checked-out branch' '
> +	test_when_finished "rm -rf pm-head" &&
> +	git clone pm-upstream pm-head &&
> +	git -C pm-head remote add fork ../pm-fork &&
> +	test_config -C pm-head remote.pushDefault fork &&
> +	test_config -C pm-head push.default current &&
> +	git -C pm-head checkout -b one one-commit &&
> +	git -C pm-head branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-head branch --prune-merged "origin/*" &&
> +
> +	git -C pm-head rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged spares branches that push back to their upstream' '
> +	test_when_finished "rm -rf pm-push-eq" &&
> +	git clone pm-upstream pm-push-eq &&
> +	git -C pm-push-eq checkout --detach &&
> +
> +	git -C pm-push-eq branch --prune-merged "origin/*" &&
> +
> +	git -C pm-push-eq rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged spares a per-branch pushRemote==upstream remote' '
> +	test_when_finished "rm -rf pm-push-branch" &&
> +	git clone pm-upstream pm-push-branch &&
> +	git -C pm-push-branch remote add fork ../pm-fork &&
> +	test_config -C pm-push-branch remote.pushDefault fork &&
> +	test_config -C pm-push-branch push.default current &&
> +	test_config -C pm-push-branch branch.main.pushRemote origin &&
> +	git -C pm-push-branch checkout --detach &&
> +
> +	git -C pm-push-branch branch --prune-merged "origin/*" &&
> +
> +	git -C pm-push-branch rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged prunes when @{push} differs from @{upstream}' '
> +	test_when_finished "rm -rf pm-push-diff" &&
> +	git clone pm-upstream pm-push-diff &&
> +	git -C pm-push-diff remote add fork ../pm-fork &&
> +	test_config -C pm-push-diff remote.pushDefault fork &&
> +	test_config -C pm-push-diff push.default current &&
> +	git -C pm-push-diff branch topic one-commit &&
> +	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
> +	git -C pm-push-diff checkout --detach &&
> +
> +	git -C pm-push-diff branch --prune-merged "origin/*" &&
> +
> +	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
> +'
> +
> +test_expect_success '--prune-merged requires at least one <branch>' '
> +	test_must_fail git -C forked branch --prune-merged 2>err &&
> +	test_grep "requires at least one <branch>" err
> +'
> +
> +test_expect_success '--prune-merged takes positional <branch> arguments' '
> +	test_when_finished "rm -rf pm-positional" &&
> +	git clone pm-upstream pm-positional &&
> +	git -C pm-positional remote add fork ../pm-fork &&
> +	test_config -C pm-positional remote.pushDefault fork &&
> +	test_config -C pm-positional push.default current &&
> +	git -C pm-positional branch one one-commit &&
> +	git -C pm-positional branch --set-upstream-to=origin/next one &&
> +	git -C pm-positional branch two base &&
> +	git -C pm-positional branch --set-upstream-to=origin/main two &&
> +	git -C pm-positional checkout --detach &&
> +
> +	git -C pm-positional branch --prune-merged origin/next origin/main &&
> +
> +	test_must_fail git -C pm-positional rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
> +'
> +
>   test_done

