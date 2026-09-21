Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078935C6BE
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996659; cv=none; b=kysi7IyPS1mCTjsu1IDcD066WB7h3f+bsWbARJh1JW4Y5MrrdXK85uJZWrh7wRG3dzIk+W7M5lR9fhlg41acElS4fHKesPhjrrV9bKBNeZ+sWpxGlnBLyqufW/WbnsKbmm3xneI8mQaOSqxy5HxoTHpbH8lUieftMbKLb+B6ujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996659; c=relaxed/simple;
	bh=s/HvsEIZ5Tpx32SdFdRaDUjwoslLba4F8BjJkvyq5Kg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PaT5c2dcszZbIPpiTr9DuV/y08L7nh989aSQaLHFJotdJhaTMUjwaiHnbrzs7awWMH06OegKlWSYrCfGqa5FIcUEngjqapLvq1cfC1Dfa5COaIL1WNsNXjsRYYbnLGYhlNJQrgjhYgkKwuH67Uz+wzgMxcoSmvETGvh7hzKJkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggH7Zzly; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggH7Zzly"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso1133769a12.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789996656; x=1790601456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4nH4hVYQms0ygg1RRUIrlPpDSVkuV4Pd4q+v5MyNjU=;
        b=ggH7ZzlySqpW3X4S+OU33bl+EOcEwNIz1SxaQThU7K0/kmuRSmX9ANSFYUCKCMsgbO
         PFcdB/twNoGas2TkZWMACvn7YQDalHhJUXzVK46iodwHE3rU0rnI4I1+84YwR5QF1JHl
         DBJ86BRfl3/SF6YZymzhBMWX9fPRHodRst1z8ubGtncO8Gr+0qX8lRQtsW0GTnZeLBmt
         5U25x2ol5umafAyucUZIospGPuEZyNjDuFfL8h0mnfF2ct83DeiYB+LAWfGGp8AGiWx8
         Y04ielNbP7BouYlHkMJ8uwqUWUWBfBKAHUtyndewtef2IwQtIwlXDf0rQZjVA2AZvfsb
         3+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996656; x=1790601456;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4nH4hVYQms0ygg1RRUIrlPpDSVkuV4Pd4q+v5MyNjU=;
        b=BraPezU3Fnl3So6Mu6JrZezTv3Yt5FsxUFiR3GpH7yRY0WL7jQNOGwqPA4sagmUXXz
         x78mcSXAG9KfJVob9x8J9D4A0Yj6XEzWMw280qOm592uBrSX5ns2cLQbCwgd7cDDrHQX
         0CowVN2qRcqauwOSXjk7OHe48iVZzqsDgudwKivqSNAgvFYeHH1zB15dj+uvEzYsbNVe
         tDt5V6HaLEDfhe2XEEijT7cFVebRjjtsGx4XBBopkBIlgjGdkO/Q6g0HqLpB/vhZo/I2
         glv3R0uPPWLOE6aQ3IoRLOc/091L9wVmzoioEB5mDZyD8nb/jHLCaz+8oaSW3FPYUgo8
         9FWg==
X-Forwarded-Encrypted: i=1; AKwUvBxDGHzK5dhIRqeVmJcJegyuoQ0zQe+UPiypE1k7IgZjOm+iCAVwi5yP9kDnusrKAm3wUQs=@vger.kernel.org
X-Gm-Message-State: AFuF++kN+4h7OjOlzMFPDZawxmtaO3bjqZA29eejwi7KmVdO8+iiHJbu
	pz9AJvAJcOEmKWPQx7JhlnlmCV9XgS8MVRSlS5nwQLlmGc1o8/MdulfZ
X-Gm-Gg: AYBFou3QKd2qyeqdZ/U1qW2jXFZnuFJGVhKsY5OFHJkJEA1o4EgSjT3y4s1RcYW0qxi
	ZzSzjTnqoM8MVmB37gY14pxqNa+C6S5167fpDGIWv5tcmbebB0bg25BMbv9YYk9HaLFmwamXvsO
	w4DIJKa6eiaIJIrIvCSeyBoM4p1d7Aw5UMM7TWvAJ3gt1lDJPXqCWnBNsW3+u7PAi3qVdnH7yGD
	nNAcrXc9t5689l2x9YdRe5/+ItJxyfM+VRtdetAeYHNZWUGMsL4HUpiLP1Sc7Id+4L6vRUHeEFq
	04VJbA0EtJkJQWhznH/gLIU/0gHBvy2I64V8BxBeswuX3nLHb6+tnGYFsRrqSdmP0JSKlwai80Z
	ta0bhGMxcybcssDyb0q2qsXZWl83iJRfx2PyugtUQUqtqwSdnDm55wy2eQ1mpVwrqhrBNQP1Bfb
	jsBmFnMVWBxJFbVdAOiop4geAlh98MO674PvBL9dyK8VMDWmGaNf+DXu/6YJxKoKCB/elZ0HPYL
	neDIf/tVxBv8SXtfHpjO13p7BEd9mGg3R+F8o0mo4XWqvTN/iklATkeDt6t4o5a
X-Received: by 2002:aa7:dd49:0:b0:6a7:e752:2c34 with SMTP id 4fb4d7f45d1cf-6aa36dba292mr8761823a12.7.1789996655263;
        Mon, 21 Sep 2026 06:17:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e3051esm4431796a12.29.2026.09.21.06.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:17:34 -0700 (PDT)
Message-ID: <2551b801-4cb3-4880-ac01-7d14a188ddd4@gmail.com>
Date: Mon, 21 Sep 2026 14:17:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] builtin/stash: merge index in-core
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>,
 Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>,
 Adam Johnson <me@adamj.eu>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <782fe91251111fbb28359574d860e4a6d2e45fc0.1789853192.git.ben.knoble@gmail.com>
Content-Language: en-US
In-Reply-To: <782fe91251111fbb28359574d860e4a6d2e45fc0.1789853192.git.ben.knoble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 19/09/2026 22:26, D. Ben Knoble wrote:
> "git stash apply --index" does a 2-step dance to report index conflicts
> before carrying out the main unstash: first, attempt to merge the index
> (and remember the name of the resulting tree). If that succeeds, reset
> the index and carry on unstashing the working tree, then use the
> remembered index tree to unstash the index.
> 
> The "merge the index" step is performed on the actual index by a
> combination of git-diff-tree(1) and git-apply(1), which incurs an extra
> cost to git-reset(1) to cleanup. This also introduces an autostash bug
> when stash.index is true: "git reset" eventually wants to
> remove_merge_branch_state(), which calls save_autostash() due to
> a03b55530a (merge: teach --autostash option, 2020-04-07). This can
> happen from a "git merge --autostash", which itself calls
> save_autostash(). Operating on the file-system in this way is not
> re-entrant, so we end up trying to lock a now-deleted MERGE_AUTOSTASH
> ref [1]. This bug has lurked for a while, but it would have been
> impossible to trigger without the availability of stash.index to force
> the autostash apply into index mode.
> 
> [1]: https://lore.kernel.org/git/CALO-guvbk2TcrVwzdNQ3yRpzHr0HHZ3h1wite0Xp0sUyAT4otA@mail.gmail.com/
> 
> Fortunately, we can achieve 2 goals at once: avoid round-tripping to the
> file-system (and invoking expensive subprocesses) by performing the
> merge in-core. Since the results are never seen, we don't need to set
> the usual branch and ancestor labels.

When the merge succeeds without conflicts we use the result so it is 
seen. It would be clearer to say that "If there are conflicts we discard 
the result so ...". The rest of the commit message explains the problem 
nicely.

> We *could* swap just the git-reset(1) subprocess with our internal
> reset_tree() and refresh_index(), which would fix the bug. We'd much
> prefer to clean up these vestiges of the shell-based git-stash, though.

Definitely

>   builtin/stash.c  | 76 +++++++++---------------------------------------

Nice diffstat!

> @@ -669,29 +625,25 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
>   		    oideq(&c_tree, &info->i_tree)) {
>   			has_index = 0;
>   		} else {
> -			struct strbuf out = STRBUF_INIT;
> +			struct merge_result result = { 0 };
>   
> -			if (diff_tree_binary(&out, &info->w_commit)) {
> -				strbuf_release(&out);
> -				return error(_("could not generate diff %s^!."),
> -					     oid_to_hex(&info->w_commit));
> -			}
> +			init_basic_merge_options(&o, the_repository);

This means we potentially use different diff algorithms when merging the 
index and when merging the work tree, let's use the _ui variant here 
instead.

>   
> -			ret = apply_cached(&out);
> -			strbuf_release(&out);
> -			if (ret)
> +			o.verbosity = 0;

Looking at the code in merge-ort.c it appears the verbosity option was 
used by the recursive strategy but isn't used anymore so I think we 
could drop this.

> +
> +			head = lookup_tree(o.repo, &c_tree);
> +			merge = lookup_tree(o.repo, &info->i_tree);
> +			merge_base = lookup_tree(o.repo, &info->b_tree);
> +
> +			merge_incore_nonrecursive(&o, head, merge, merge_base,
> +						  &result);
> +
> +			if (!result.clean)
>   				return error(_("conflicts in index. "
>   					       "Try without --index."));
>   
> -			discard_index(the_repository->index);
> -			repo_read_index(the_repository);
> -			if (write_index_as_tree(&index_tree, the_repository->index,
> -						repo_get_index_file(the_repository), 0, NULL))
> -				return error(_("could not save index tree"));
> -
> -			reset_head();
> -			discard_index(the_repository->index);
> -			repo_read_index(the_repository);
> +			oidcpy(&index_tree, &result.tree->object.oid);
> +			clear_merge_options(&o);

Looking at replay.c:replay_revisions() I think this should be

merge_finalize(&opts, &result);

>   		}
>   	}
>   
> diff --git a/merge-ort.c b/merge-ort.c
> index c410a5d353..f69a49d48a 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -5035,8 +5035,6 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
>   	trace2_region_enter("merge", "sanity checks", opt->repo);
>   	assert(opt->repo);
>   
> -	assert(opt->branch1 && opt->branch2);

This, and the hunk below, make me nervous. Normally assertions like this 
exist because the pointers are unconditionally dereferenced later on. 
Looking at merge_3way() it asserts opt->ancestor is non-NULL and 
dereferences all three labels. t3903 does not appear to have test 
coverage for the index merge failing (if it did I think we'd see a 
SIGSEV), we should probably add a test that checks the command fails 
leaving the index and work tree untouched, and verifies the message on 
stderr.

Lets set some simple, fixed, ancestor and branch names in 
do_apply_stash() above.

>   	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
>   	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
>   	assert(opt->rename_limit >= -1);
> @@ -5409,7 +5407,6 @@ void merge_incore_nonrecursive(struct merge_options *opt,
>   	trace2_region_enter("merge", "incore_nonrecursive", opt->repo);
>   
>   	trace2_region_enter("merge", "merge_start", opt->repo);
> -	assert(opt->ancestor != NULL);
>   	merge_check_renames_reusable(opt, result, merge_base, side1, side2);
>   	merge_start(opt, result);
>   	/*

> +test_expect_success 'fast-forward merge with --autostash, stash.index' '
> +	git reset --hard c0 &&
> +	git stash clear &&
> +	echo staged >>z && git add z &&
> +	git -c stash.index=true merge --autostash c1 2>err &&
> +	test_grep "Applied autostash." err &&
> +	test_stdout_line_count = 0 git stash list
> +'

We check the autostash is applied and is not saved - good

Thanks for working on this, it is really good to get rid of those 
subprocesses.

Phillip

>   test_expect_success 'failed fast-forward merge with --autostash' '
>   	git reset --hard c0 &&
>   	git merge-file file file.orig file.5 &&

