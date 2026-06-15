Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE512F7F0F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516805; cv=none; b=d2vvAcS0iGE+eB3yV8/dp0I0yIDhKOWCJkErECmwHkIPvwnLIF01E3YBjw2s13Zw3mr0M+eY9g+fLfXNou1fPCV1lwvrkU8saiIjaa5nXNekgeI7p0hnf3i6VuWUm2tSSO7YB/qpuseniGz6EFPn6XJSvcXIZ/DfBIBal1v14pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516805; c=relaxed/simple;
	bh=P7PhW3fFaX5Mgx+PC9WW3H7d9QN2+W6vAZfA9A8+FSo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L9+1QuKX5MF4AjPztRZ1p82Fh6GPIBmNuj/R5J0aWBan3qMb7okB5VUtxvSnUgZ6hLC3ktU6VqFompKS9nzmYac7uqAfxayPa4ac+TVAhV6r8EfjSUzhZzyDuArJsENaK8XKdvAA0v9oI7Ub6ycHXQ7LDEUTDuz5S0XG03Xfdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+IuUFMq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+IuUFMq"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso4753159a12.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516803; x=1782121603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENchf5Q/Juyg3+DTL1XsmhhmoXA6w2VeQNeyd8Oehbc=;
        b=Q+IuUFMq9eLWzUpvMxfQj9Yr1bij/5sfd+LvnY8Q8drKNMcp1JSczLsq5hQtrxxOr/
         Z1DeYvqqV0rLC5itfuZXKY3NOeNF13wNkURYQiGGJCOxRk7Z2ncbel0hCxsZ4w9OFX9H
         z2S1014ochMaR9ZeCc+73If5hZIBFtEyR8xxLNZgUUF3XvNc6mWEUgEiPUUi/PV8MmfM
         gopx88Ka0ukQtb5JNJLw5bQq2V2Zf5plbqahOGedhLu7rVaEK7ww0wFLO8QQEvw05YdX
         oqmAdoO7eQYV5esJpHQN9ofdARGZ9j6E8RkRTDlLlM+H4xhy0YQzJi7ehbemsdZ9/mHu
         NouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516803; x=1782121603;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENchf5Q/Juyg3+DTL1XsmhhmoXA6w2VeQNeyd8Oehbc=;
        b=TT/jgIYuzIy3Fz0jwBsuQMk5Hlw/L4E5et+XPoC+OkJnGkt5jBxDwXBGgiBS3XoEt9
         yHCvGPjhFnTCD2msE1ui0y2daAi8lBX3sEvCl+Ow/BQj0faPGN4KNxiVmDQrewVIcfm+
         O97Z5jSoCIVbAZ5OwB4q8IucHz9YN+/KiKLAoCveb/9OeqIo9Suxu0QjRfEzB1AUb8L9
         2irQ8pkiR3kFVLV6Ye0aWFDWhVowkoszmS3g3jcbN6MV2s6z2lKZhIZUyNfTRPqTeafx
         +x9zy42KIdj0O4ese8Bf1V2W78NgL/8ltLWc6HusjQ1RTKtd4znvRd2b6mSmEyjAZQnp
         XD8w==
X-Forwarded-Encrypted: i=1; AFNElJ9ZIFgXL1c89fwIPJ+Zu8bDOZ0Bc4+Gj2ornidzmCh2G0I6sfKoHzNntdwNExGO9i+nP3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxwOauzXGdJW1rFgtr3gH4UV8HBBRshvqljztlNyxM4sV7Xgq
	ikQc9EDjoZrHuWeJnW8d/cF3zaKBB9G/ukhGVFsjeA8GnIw7O0YLb6t0
X-Gm-Gg: Acq92OFptb5nCOGUHnr6qsNrj4x6iyhpeZ/mb/BamjIYP69Sd6rikBUslqKpmz3R1Nr
	zwwtXj8oHBmocHDhvVGrYZl48q8XJQc4xn9IkaFxDwur3S0XxsmwOv9L8lp8AGb3KN5ux+Nq4Gn
	IcwzHnw6AA8Qhn687PggSS7AedStSVGUR+duaSRjw7gnloffanw2n95NVX8f2d3NzFLdB0QVJLP
	MOZm0TWrevMzYcmLzReq4ovgtscCmFX9S/W+6wTfcIhhYjxkYb1efXSamlrLgGQdDys5PxG8nF3
	aLG9ZjZyzoD+6hOzq4If7LO68ShlYofKsdkGauZob+wVB4eXWzhayh34IP1hF9UTmTAHkpi7ggl
	SbmIc67GRYE26rTZBe+CIjLhPXmyJcV32Fx1OWjC3IzynbbOG93JbJpIj2bZH8Ax/G18m23c/g6
	A89ZDzOfkN15XKGhoZFBZeBVhux09xL/7hD4c5HSMuGe/RRutDkrIRUfp9tkyppqOrUsvCEPBOC
	2dpab9G5h0=
X-Received: by 2002:a17:906:6185:b0:bfe:ed74:526 with SMTP id a640c23a62f3a-bfeed740593mr506926266b.53.1781516802264;
        Mon, 15 Jun 2026 02:46:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:786c:b99d:5866:4e92? ([2a0a:ef40:69a:b801:786c:b99d:5866:4e92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5103710sm433065466b.22.2026.06.15.02.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:46:41 -0700 (PDT)
Message-ID: <16bb2c32-224d-4c8a-a696-d0b9ca9d304c@gmail.com>
Date: Mon, 15 Jun 2026 10:46:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 1/6] branch: add --forked filter for --list mode
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <7383872f4b2f422ec36b11ab5fb31cce08e6106a.1780999917.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <7383872f4b2f422ec36b11ab5fb31cce08e6106a.1780999917.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/06/2026 11:11, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a --forked option to "git branch" list mode that lists only
> branches whose configured upstream matches <branch>. The argument
> can be a ref (e.g. "origin/main", "master") or a shell glob
> (e.g. "origin/*"), and may be repeated to widen the filter.
> 
> It is an ordinary list filter, so it combines with the others:
> 
>      git branch --merged origin/main --forked 'origin/*'
> 
> lists branches forked from origin that are already merged into
> origin/main, and --no-merged inverts the question.
> 
> This is the building block for --prune-merged, which deletes the
> listed branches once they have landed on their upstream.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/git-branch.adoc | 10 +++-
>   builtin/branch.c              | 18 ++++++-
>   ref-filter.c                  | 70 ++++++++++++++++++++++++++
>   ref-filter.h                  | 10 ++++
>   t/t3200-branch.sh             | 92 +++++++++++++++++++++++++++++++++++
>   5 files changed, 197 insertions(+), 3 deletions(-)

It's nice to see that moving the code into the ref-filter.c has reduced 
the overall number of additions by ~50 lines. The documentation and 
implementation look fine though I have a couple of thoughts:

  - Previous iterations supported "origin" as a short hand for the branch
    origin/HEAD points to. That was nice because it means we can use the
    same syntax for "git checkout -b" and "git branch --forked". It
    would probably be a good idea to support it.

  - We could probably be a bit smarter about the way we handle patterns
    by copying what dwim_ref() does to support things like
    remotes/origin/* but I don't think we need to do that now.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e7829c2c4b..4e7deddc04 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1717,4 +1717,96 @@ test_expect_success 'errors if given a bad branch name' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--forked: setup' '
> +	test_create_repo forked-upstream &&
> +	test_commit -C forked-upstream base &&
> +	git -C forked-upstream branch one base &&
> +	git -C forked-upstream branch two base &&
> +
> +	test_create_repo forked-other &&
> +	test_commit -C forked-other other-base &&
> +	git -C forked-other branch foreign other-base &&
> +
> +	git clone forked-upstream forked &&
> +	git -C forked remote add other ../forked-other &&

We can use "add -f" to fetch here rather than doing it separately.

> +	git -C forked fetch other &&
> +	git -C forked branch local-base &&
> +	git -C forked branch --track local-one origin/one &&
> +	git -C forked branch --track local-two origin/two &&
> +	git -C forked branch --track local-foreign other/foreign &&
> +	git -C forked branch detached &&

Normally we use "detached" to mean no branch, lets read on and see how 
this is used ...

> +	git -C forked branch --track local-trunk local-base
> +'
> +
> +test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
> +	git -C forked branch --forked origin/one --format="%(refname:short)" >actual &&

origin/one and origin/two point to the same commit, so this demonstrates 
that we're checking the branch names, not the topology which is good. 
All of the local branches point at their upstream which isn't very 
realistic - I wonder if we should add some local commits?

The tests all look sensible, but there is no coverage for combining 
--forked with branch names as in

     git branch --forked <arg> <branch>

Thanks

Phillip


> +	echo local-one >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked <glob> filters by wildmatch' '
> +	git -C forked branch --forked "origin/*" --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-one
> +	local-two
> +	main
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked <local-branch> matches branches with local upstream' '
> +	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
> +	echo local-trunk >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked can be repeated to widen the filter' '
> +	git -C forked branch --forked origin/one --forked other/foreign --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-foreign
> +	local-one
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked combines literal and glob arguments' '
> +	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-foreign
> +	local-trunk
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
> +	git -C forked branch --forked "*/*" --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-foreign
> +	local-one
> +	local-two
> +	main
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked composes with --no-merged' '
> +	test_when_finished "git -C forked checkout detached" &&
> +	git -C forked checkout local-one &&
> +	test_commit -C forked local-only &&
> +	git -C forked branch --forked "origin/*" --no-merged origin/one \
> +		--format="%(refname:short)" >actual &&
> +	echo local-one >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked rejects unknown branch/pattern' '
> +	test_must_fail git -C forked branch --forked nope 2>err &&
> +	test_grep "not a valid branch or pattern" err
> +'
> +
> +test_expect_success '--forked requires a value' '
> +	test_must_fail git -C forked branch --forked 2>err &&
> +	test_grep "requires a value" err
> +'
> +
>   test_done

