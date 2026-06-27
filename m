Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B03A6411
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782567857; cv=none; b=r8onpKygIlDbjHTGs+q1AgNINE4psoYk3XSN02cn6oiNmvkS84Vp9ft+Y991P8D3YyV1gN7HrECzJVnVsm/B5ty833OZ1HLRFI/sM8y7losW2TnuK8T5AyEzd2Xwk4Xg7v/Q0Uuup78iIJfpsiM2OnerXtUVcLTBIoat+tXVyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782567857; c=relaxed/simple;
	bh=WQ6oNGahuuujQb9eF4A2PJnGcBfsOBKLqQP/3aXgUe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNpxWo/DwJUnohraBK5V1sS1/4TRtCnP98ZIbXlot9daEmm49/Bk8eMZ3MrRGJGzqbDvTT/wLzMEZB1gG9CWy7lVqrxE/eC/XXLx1JKmSVF70HgN3ImXwvZc8AJ8+Ec90Ei6RpVI9BfKJ9ZeCEusicWShTw5Nn2DmQBJLNnqAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMaNtNGp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMaNtNGp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-470174001a0so431613f8f.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782567854; x=1783172654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oX/gEMNhPZs1S7MOUc6yN7R/rvo0jIHyJuOkaHyoMls=;
        b=gMaNtNGpY/G/B+RnnxC3MS6CS1n2EPBOhRT/XGlzsaL6bN0h3tT/nAcOf/t0BrCaWx
         AcQBZhzrFlWWYDf03qJceXJRoOYqwi+fC4XheJlGZQY0sIsFGX26U2lXuo4bs6vyPaRi
         7dceBp9flKpa9T98CLo/fGs3ZUP8oiUj3gg8rQ6b9+3YJQcvxugzj3XC7jtv8ATReMQ7
         pQjOlB1dXcmHnwp16RkPKy35sKntgKqYVDj86LFluhfOsRw8wSPHg6edczDIWsZa1HGp
         eEPllz2uhjV1ZD3EJsxDRcABENyvilillhKGtDwHeVkxT01dlq3iz1bAMvotQnWqoOdQ
         Ob1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782567854; x=1783172654;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX/gEMNhPZs1S7MOUc6yN7R/rvo0jIHyJuOkaHyoMls=;
        b=r9Hgv/TxQ41bHVjRUgLmmhcHmR0z8pv5WiY4UGgfV8cs+sKkVhuqASUrjIf58yfXtG
         ZsmkDVaodtPWSk6b0o0O9/PqnL8sgyqwATZVAJDNSnj8QrlvirbAO/SE+EUDXLkBw6zj
         0n/xQrIi6Yrdo7ziZT2XDSzG6Oh2Tg3ZWOVRqfEX/5B2gxppOwg0whQ8hPBJmX4Bn9Jq
         xWavT2RSoIuXRGWOquvKvUGKgqvg7FxbfwMKoOcLuQmsQDKLkTM9Ewc5UIz4LPP2+joT
         ZUFlwLHEI/DicsZTt1Y/OdXBCbCIfcK7B+obyxgee2gZchntULujf8iRNWCF4SwPAca3
         P6MQ==
X-Gm-Message-State: AOJu0YyVToUr6YMsF/mYH5sWL8Pzh733I3QGDilTcs90MYCdenRuugly
	muz/5H02m3qux6h11MNJhU1vD5ntjmDH6YtjKZGulxW5y0zsCPrgU5oy
X-Gm-Gg: AfdE7clPKIXi/8nv/cdY1nI70NtMmJ9+T9kKCkT18Lz33kqERpnY6hdIIkKQP/4z0U2
	pGpC/X6arf8QaMN5Id9dcUCf3PK5Ujv8ZS4NR+DtWCcs7Xz0LcBrIQs9sTICf/HDtMF7ejZtj9q
	CPvy8LtnKJ/hVzOzbjuHzzM2EZdnoA7d76xwkkwjvKJi/OneoXyos5W8Gmooy6ekKEDsKs+hc/Q
	ykqBDcUr2OlOQbZjve+mGc3qMeCnI130piNkN5sjnDxrIoPFX2pSO8ypr6PhWyD77AJwY2ZXofZ
	co1xs+AP/lc1wRcWdHossZY4T4s6j/FtBEPsWwUR/uLKLYboTp0CQxV3GZ0eEvYou/tujikbZjk
	XOwjcmbQUzLCLZYL6286Aww4lcoZzsdJ3YcuKPUufgJg7/wKikKM37+Snp0F0abFKirYLeAnNq2
	enGKTAYHJPh+D943KTGc2kTPg+bbxwQsvGhj15lZhshcG30SHO86ZB4hMwpB1LNEzn6Bk=
X-Received: by 2002:adf:e010:0:20b0:46d:d90b:bbe1 with SMTP id ffacd0b85a97d-46dd90bbd41mr11427542f8f.14.1782567853740;
        Sat, 27 Jun 2026 06:44:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4721c88bfcasm2580279f8f.10.2026.06.27.06.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 06:44:12 -0700 (PDT)
Message-ID: <b5d70a0b-ef32-49c9-84ba-8a64b7809574@gmail.com>
Date: Sat, 27 Jun 2026 14:44:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] replay: offer an option to linearize the commit
 topology
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
 <20260626-toon-git-replay-drop-merges-v5-3-5e120738b9d0@iotcl.com>
 <xmqq5x358byf.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5x358byf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2026 18:10, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
>>   Documentation/git-replay.adoc |  8 ++++-
>>   builtin/replay.c              |  6 +++-
>>   replay.c                      | 50 ++++++++++++++++----------
>>   replay.h                      |  5 +++
>>   t/t3650-replay-basics.sh      | 84 ++++++++++++++++++++++++++++++++++++++++++-
>>   5 files changed, 132 insertions(+), 21 deletions(-)
> 
> "replay --linearize" behaves differently from the flattening rebase
> in a case where X and Y that forked from A are merged at Z, and we
> ask to flatten the history leading to Z, doesn't it?

That's a good point. rebase takes the list of commits given by "git 
rev-list --reverse --no-merges" and cherry-picks each on on top of the 
previous one. In contrast replay cherry-picks each commit on top of its 
rewritten parent so it does not flatten the topology.

Thanks

Phillip
>       A----X
>        \    \
>         Y----Z (tip)
> 
> A typical flattening rebase would rewrite X to X', Y to Y', while
> dropping Z, and would leave us a flattened history, like
> 
>       A---X'---Y' (updated tip, the order of X' and Y' may be swapped)
> 
> I may be misreading the logic, but doesn't "replay --linearize"
> instead produce
> 
>       A----X' (dangling)
>        \
>         Y' (tip -- Z is dropped and gets mapped)
> 
> and leave X' dangling (or Y'; the point is that only one of them
> will survive), never incorporating it in the resulting history?
> 
>> +		if (commit->parents && commit->parents->next) {
>> +			if (!opts->linearize)
>> +				die(_("replaying merge commits is not supported yet!"));
>> +			/*
>> +			 * Drop the merge commit: do not pick it, leave
>> +			 * `last_commit` unchanged, and fall through to the
>> +			 * rest of the loop. As a result:
>> +			 * - the merge commit is mapped to `last_commit` in
>> +			 *   `replayed_commits`, this will become the parent for
>> +			 *   the child commits.
>> +			 * - refs previously pointing to the merge commit are
>> +			 *   rewritten to point to the previous non-merge commit.
>> +			 */
>> +		} else {
>> +			/*
>> +			 * pick_regular_commit() looks up the parent of `commit` in
>> +			 * `replayed_commits` to determine the ancestor to replay onto.
>> +			 * The `default_base` parameter is used when no ancestor is found,
>> +			 * which happens for the first commit in the revision range.
>> +			 * When reverting, commits are replayed in reverse order, so the
>> +			 * lookup never succeeds, and we need to pass `last_commit`.
>> +			 */
>> +			struct commit *base = onto;
>> +			if (mode == REPLAY_MODE_REVERT)
>> +				base = last_commit;
>> +
>> +			last_commit = pick_regular_commit(revs->repo, commit, base,
>> +							  replayed_commits,
>> +							  &merge_opt, &result,
>> +							  mode, opts->empty);
>> +		}
>> +
>>   		if (!last_commit)
>>   			break;
> 
> Immediately after this hunk beyond the post-context are these lines.
> 
> 		/* Record commit -> last_commit mapping */
> 		put_mapped_commit(replayed_commits, commit, last_commit);
> 
> Let's imagine X gets processed first. X (and other commits on its
> branch) gets replayed, last_commit is set to X' (which is the
> rewritten X).  replayed_commits mapping holds X->X' mapping.
> 
> Then let's imagine the history leading to Y is replayed next.
> last_commit becomes Y', and Y->Y' mapping is stored in
> replayed_commits.
> 
> Finally, we see Z.  We are going to _drop_ it.  last_commit is left
> unchanged, pointing at Y'.  Then last_commit (i.e., Y') is used as
> the merge commit Z maps to (i.e., correctly dropping Z).
> 
> Any descendants of Z, if any, will be grafted as descendants of Y'.
> If X did not have any descendants other than Z in the rewritten part
> of the history, then X' (and commits leading to it) would be lost,
> no?
> 
> This "loss of the other branch" may be an inherent characteristic of
> this feature (i.e., I do not think it is necessarily a bug, and it
> may even be that the "bug" is in the way I am reading the patch),
> but then I wonder if the user may want to have control over which
> side branch should survive, perhaps?  It would probably need to be
> documented, and a test or two to cast this behaviour in stone.
> 
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index 3353bc4a4d..34c038eab9 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -52,8 +52,12 @@ test_expect_success 'setup' '
> 
> The pre-context here has
> 
> 	git switch --detach topic4 &&
> 	test_commit N &&
> 	test_commit O &&
> 	git switch -c topic-with-merge topic4 &&
> 
>>   	test_merge P O --no-ff &&
>>   	git switch main &&
> 
> The above does prepare topic-with-merge branch, but ...
> 
>> +test_expect_success 'replay to rebase merge commit with --linearize' '
>> +	git replay --ref-action=print --linearize \
>> +		--onto main I..topic-with-merge >result &&
> 
> ... this does not really exersize linearizing replay in a typical
> mergy history.  P merges O with --no-ff because otherwise there
> won't be a merge, since O is a descendant of the commit "test_merge
> P O" runs on (i.e., topic4 == topic-with-merge).
> 
>      topic4 --- N --- O
>            \           \
>             .-----------P
> 
> So, as long as O is replayed later than the parent of N (which is
> true), O' will be the surviving tip (corresponds to Y' that the
> dropped Z was mapped to in the earlier example), and nothing gets
> orphaned, I think.
> 
> Perhaps a test to try a real merge may look something like this.
> 
> diff --git c/t/t3650-replay-basics.sh w/t/t3650-replay-basics.sh
> index 34c038eab9..bb737f729a 100755
> --- c/t/t3650-replay-basics.sh
> +++ w/t/t3650-replay-basics.sh
> @@ -647,4 +647,37 @@ test_expect_success 'replay with --linearize to rebase multiple divergent branch
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'replay with --linearize of a divergent merge drops one branch' '
> +	git switch -c topic-divergent-base main &&
> +	test_commit base &&
> +	# Fork 1: base -> X
> +	git switch -c topic-divergent-x &&
> +	test_commit X &&
> +	# Fork 2: base -> Y
> +	git switch topic-divergent-base &&
> +	git switch -c topic-divergent-y &&
> +	test_commit Y &&
> +	# Merge them at Z
> +	git switch topic-divergent-x &&
> +	test_merge Z topic-divergent-y --no-ff &&
> +
> +	# History is now:
> +	#
> +	#       X - Z (topic-divergent-x)
> +	#      /   /
> +	#  base - Y
> +	#
> +
> +	git replay --ref-action=print --linearize \
> +		--onto main topic-divergent-base..topic-divergent-x >result &&
> +	test_line_count = 1 result &&
> +	tip=$(cut -f 3 -d " " result) &&
> +	# Get the commits replayed onto main
> +	git log --format=%s main..$tip >actual &&
> +	# We expect exactly one commit to be replayed (either X or Y)
> +	# because the other one is left dangling due to the merge being dropped.
> +	test_line_count = 1 actual &&
> +	test_grep "^[XY]$" actual
> +'
> +
>   test_done
> 

