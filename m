Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58C3DEFF0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696900; cv=none; b=Iieo2z4wR6a8ix8tnLWP03x3lUgiG8ixzJ10OBJ+CwUYb6QHcX3s/IBUU7LqXhDLtsyRiXX9Z+cTjJO/PbcaAbdL778GFAFDpSw3ditS221JkHJilLiN6k+/+/lfDGHJnIMrCLxSd+nTZTUd9KpMg3/UJR2HTF6xGGXJRfzGqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696900; c=relaxed/simple;
	bh=xtW9EGz3iAdMcN1nN/aI69l4klnwoUxJTeJ0Q3rPnzw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MFqkadGyw6PWBrKnY5CcGqfu+8IfdiVRqFwAblut+V/s8ZVgN4hpEeh/dU4bc6l9FNDolzviYz9Kn0x8F08sP3o2zpyTUxHUrG35+AOOwZoWYRp+CTOrbMdT0KW3LiRDuAtLhVNmj4QBIPfz+IO9sgni3j9k2KhcWeHiMNty2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6k5EYGF; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6k5EYGF"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so214952f8f.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696896; x=1791301696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mg9c8gDThDDgsKqg8rkWeJ+1gDzb7172RRqykntKT2A=;
        b=R6k5EYGFoxn5xyQitLUKaxzLrwoCOlExhEUOepPAID5uGNSL2HCoyYqTZIu3Bzv3sr
         zRgNIVGVUiAKL7RwDFPUe4EYZbQzyvNwv/bWyOGIyd/tXsAKMIwEe52PxQz/jSp0iWU0
         medbHQVbsjUt+w51F99fGybeH16DZl1qav6aGk0XQFIuRJ/z6uZlGj/SomJ9kgpAxn+W
         gH7T3CFQDSWhonJbuBZh0hxIfaDBa0ttjxputmhcAvL0snifyxh+lpN7YuvhFYnkGxrG
         z2/tIJW88eWmLiNSam58qf0P+IHytjpL4+KtlUZO3SWUwL3iieheVkywBlW+HX/M7giR
         3bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696896; x=1791301696;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mg9c8gDThDDgsKqg8rkWeJ+1gDzb7172RRqykntKT2A=;
        b=lDKLiygIT7Rrt1Ty9wyFDsC92izVfWZDKoel3nDNnRD81FTrJjUcyNDx2AxC8JwhIh
         C9Id9JG+znjNxzPIw1/0MpbYFPA4DmItXm3KpbSbMXoxEQKAa/JNclDtuwbrXOZ7yyWF
         FAlv/1Vim7tExsPj65z430sm1abHGt8PjbIF1PJqjhlOU4nTx2OjHv6Hmj3kwamg0wTM
         yQ4gXAd1Mrm6f3Hr4zhRiPsZuFkmO/rO7LTgEkRQCiOfKgO2jygk9uj4+i7i8+OhTXJp
         baR1S+eVkngpGukvZmDpOWqw4ybLmoD8vWEOruFtckcTiTovOKTFYA+KKHuvFMwPmpFW
         9Kxw==
X-Forwarded-Encrypted: i=1; AKwUvBzSmovgWGKczl+PPUEvBHEFLuI9gGSFqtZL6p5oAPLwTJdojgkG8UXpoU70+9ynNRheiXI=@vger.kernel.org
X-Gm-Message-State: AFuF++k98OgpA9DodfDzRvJMfF4RYI0hBfae+A98ZKyemUAKelhbNSGk
	xxnYRdYsZ4NccddCO+Y06oSbrkHrw6ItvDJx7IbmXm6SMtJnOI+Jryit
X-Gm-Gg: AYBFou2c4HYK6xNR1/3TYoih+jhmsC9dEHTJ7CxApYujIBgUCSzftem4EwHRb3SA1bx
	X1ItAwmxrrDn2i+rwQU0ur/mopkqfGbN6r7zuE8jySK3Beba6xBwxJ23AatkSwcKAojKkvV7csx
	KkGnMGXt50ArpoEPx40KaAnYQJnQKP9uTw5cmfcx3emPYPTEhK0GJbT+hAQQhMtJrNM0LRt1Hs0
	XZSzfB5D5guHXZo8dkaiZ0qw8qFN/2234jVlJ07edvcbTFm5PhQZ5ZmXSHRI3YR4ofPZBMzoj5S
	0w0E3SiR94DF22t0dtWH0PkMxGbylbsDNLDPECcB/c7Qc/exOeLyS5UPLDz5Zy/a7y4nHfDt6rl
	CYcWv31fPSJVb46JNIql2B98Db1lSLAdXqYZwMdZX8mG/AdCvev/MVPdWypGkHtv/QRb+Y1bDns
	fPPjYUKrEZOBLBo1Px7zLUJQYpul4aA97Evld4VwYTD+rh1Y3tUStGuqGfQsE29M+EkDoSLqMJo
	SexLkzGqwKQDLfBaiTHCmZq55YYZjoiVlvLy+sIGmc4WMr2d+BReeeE33aZpeHo
X-Received: by 2002:a05:600c:c3dc:10b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a00d75ac6bmr40938275e9.2.1790696896204;
        Tue, 29 Sep 2026 08:48:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af508cedfsm4753647f8f.30.2026.09.29.08.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 08:48:15 -0700 (PDT)
Message-ID: <d5ac59be-0688-4d60-871a-2ccebc91c58b@gmail.com>
Date: Tue, 29 Sep 2026 16:48:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] stash: clean up index-mode test merge
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790684309.git.ben.knoble@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1790684309.git.ben.knoble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 29/09/2026 13:18, D. Ben Knoble wrote:
> 
> Changes in v4:
> • Drop merge verbosity changes altogether. I was going to
>    save-and-restore, but when looking at the index-merge test case (more
>    below) closer, I noticed that "git apply --cached" reports conflicts
>    on stderr. That is, "git stash apply --index" would report conflicts,
>    and silencing the merge takes that away. So instead let's leave the
>    configured verbosity alone.
> • Only copy resulting index merge tree OID when successful
> • Fix interaction with t5520 (new patch 4/5)
> • Squash test from 3/5 into 5/5, since it requires actually merging
>    trees. I've elected to keep it a separate test for now (contrary to
>    Phillip's suggestion) since it's written and working. Adapting
>    existing tests requires quite a bit more digging into implicit context
>    assumptions ;)

I've left a comment on the new patch 4, but everything else in the 
range-diff looks ready to me.

Thanks

Phillip

> Changes in v3:
> 
> • Change conflict label for current index
> • Fix memory leak of merge_result
> • Fix order of trees to make the correct merge (cherry-pick)
>      • New test (3/5) to validate this
> • Fix test in 4/5 to assert more details of expected state
> 
> Changes in v2:
> 
> • Do give branch labels for the incore merge, although they are never
>    seen (and clarify commit message as a result, also keeping the
>    merge-ort asserts). Phillip was right: without those, we do segfault
>    on conflicts.
> • Use the ui merge options to keep the same diff algorithm.
> • Use merge_finalize instead of clear_merge_options, and reuse the
>    options between merge calls if they are already initialized.
> • Add a new 2/4 to simplify merge options initialization.
> • Add a new 3/4 with a test case for conflicted index merges.
> 
> v1: <cover.1789853192.git.ben.knoble@gmail.com>
> v2: <cover.1790168285.git.ben.knoble@gmail.com>
> v3: <cover.1790425008.git.ben.knoble@gmail.com>
> 
> [1/5] builtin/stash: remove unused header
> [2/5] stash: prepare merge options earlier
> [3/5] t3903: test failed "stash apply --index"
> [4/5] t5520: don't expire reflogs where it matters
> [5/5] builtin/stash: merge index in-core
> 
>   builtin/stash.c  | 91 ++++++++++++------------------------------------
>   t/t3903-stash.sh | 42 ++++++++++++++++++++++
>   t/t5520-pull.sh  |  6 ++++
>   t/t7600-merge.sh |  9 +++++
>   4 files changed, 79 insertions(+), 69 deletions(-)
> 
> Diff-intervalle contre v3 :
> 1:  6a165c4df4 = 1:  6a165c4df4 builtin/stash: remove unused header
> 2:  d9a9e18f3a ! 2:  35b64ae321 stash: prepare merge options earlier
>      @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
>        		return error(_("cannot apply a stash in the middle of a merge"));
>        
>       +	init_ui_merge_options(&o, the_repository);
>      ++
>      ++	if (quiet)
>      ++		o.verbosity = 0;
>       +
>        	if (index) {
>        		if (oideq(&info->b_tree, &info->i_tree) ||
>      @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
>        	o.branch1 = label_ours ? label_ours : "Updated upstream";
>        	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
>        	o.ancestor = label_base ? label_base : "Stash base";
>      +@@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefix,
>      + 	if (oideq(&info->b_tree, &c_tree))
>      + 		o.branch1 = "Version stash was based on";
>      +
>      +-	if (quiet)
>      +-		o.verbosity = 0;
>      +-
>      + 	if (o.verbosity >= 3)
>      + 		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
>      +
> 4:  d39e16905d ! 3:  7b0b317ce0 t3903: test failed "stash apply --index"
>      @@ Commit message
>       
>        ## t/t3903-stash.sh ##
>       @@ t/t3903-stash.sh: setup_stash() {
>      - 	test_cmp expect file
>      + 	test_cmp expect actual
>        '
>        
>       +test_expect_success 'stash apply --index leaves everything untouched on failure' '
> 3:  8b5ea5e6f4 ! 4:  2ac371d2dc t3903: test stash --index merges
>      @@
>        ## Metadata ##
>      -Author: D. Ben Knoble <ben.knoble@gmail.com>
>      +Author: Thomas Bachem <mail@thomasbachem.com>
>       
>        ## Commit message ##
>      -    t3903: test stash --index merges
>      +    t5520: don't expire reflogs where it matters
>       
>      -    A future commit will refactor index handling for applied stashes, and we
>      -    need to take care to get the order of trees right when merging. Add a
>      -    test that covers this case.
>      +    The "--rebase -f with rebased upstream" test computes its fork point
>      +    from the reflog of refs/remotes/me/copy, and the entry it needs is
>      +    the one that the fetch of the test before it wrote. Like every reflog
>      +    entry the suite writes after test_tick, it is dated 2005, so the
>      +    first "git reflog expire --all" after that fetch removes it. Pull
>      +    then finds no fork point and rebases onto the merge head with the
>      +    merge head as the upstream, and the rewound commits come back as a
>      +    conflict.
>       
>      -    Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      +    Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
>      +    default, 2026-02-24) auto maintenance runs that expiry once the reflog
>      +    of HEAD holds a hundred entries it would remove, the default of
>      +    maintenance.reflog-expire.auto. Which run crosses the threshold
>      +    depends on the entries and maintenance runs before it, so the script
>      +    passed by chance: a stash topic that no longer runs "git reset" from
>      +    "stash apply --index" and a rebase topic that runs auto maintenance
>      +    at the end of "git rebase" together move the expiry between the two
>      +    tests.
>       
>      - ## t/t3903-stash.sh ##
>      -@@ t/t3903-stash.sh: setup_stash() {
>      - 	test_cmp expect actual
>      - '
>      +    Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
>      +    matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
>      +    as well, which expires reflogs on its own, where turning off the auto
>      +    trigger of the reflog-expire task alone would not.
>      +
>      +    Reported-by: Junio C Hamano <gitster@pobox.com>
>      +    Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
>      +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      +    Assisted-by: Claude Fable 5.1
>      +    Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
>      +
>      + ## t/t5520-pull.sh ##
>      +@@ t/t5520-pull.sh: test_pull_autostash_fail () {
>      + }
>        
>      -+# the later "stash -k" test is not expecting us to muck with file so much, so
>      -+# reset when finished
>      -+test_expect_success 'stash apply --index merges the correct trees' '
>      -+	head=$(git rev-parse HEAD) &&
>      -+	test_when_finished "git reset --hard $head" &&
>      -+	test_write_lines A B C >file &&
>      -+	git commit -m setup file &&
>      -+	test_write_lines A B staged >file &&
>      -+	git add file &&
>      -+	test_write_lines A B unstaged >file &&
>      -+	git stash &&
>      -+	test_write_lines committed B C >file &&
>      -+	git commit -m to-be-merged file &&
>      -+	git stash pop --index &&
>      -+	git show :file >actual &&
>      -+	test_write_lines committed B staged >expect &&
>      -+	test_cmp expect actual &&
>      -+	test_write_lines committed B unstaged >expect &&
>      -+	test_cmp expect file
>      -+'
>      + test_expect_success setup '
>      ++	# Commit dates are hardcoded to 2005, and the reflog entries will have
>      ++	# a matching timestamp. Maintenance may thus immediately expire
>      ++	# reflogs if it was running.
>      ++	git config set gc.reflogExpire never &&
>      ++	git config set gc.reflogExpireUnreachable never &&
>       +
>      - test_expect_success 'stash -k' '
>      - 	echo bar3 >file &&
>      - 	echo bar4 >file2 &&
>      + 	echo file >file &&
>      + 	git add file &&
>      + 	git commit -a -m original
> 5:  fde7fb7988 ! 5:  e21b832a6e builtin/stash: merge index in-core
>      @@ Commit message
>           we don't see the usual branch and ancestor labels, but the merge
>           subroutines insist on their presence, so use something simple.
>       
>      +    We need to take care to get the order of trees right when merging. Add a
>      +    test that covers this case.
>      +
>           We *could* swap just the git-reset(1) subprocess with our internal
>           reset_tree() and refresh_index(), which would fix the bug. We'd much
>           prefer to clean up these vestiges of the shell-based git-stash, though.
>      @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
>       -			ret = apply_cached(&out);
>       -			strbuf_release(&out);
>       -			if (ret)
>      -+			o.verbosity = 0;
>      -+
>       +			head = lookup_tree(o.repo, &c_tree);
>       +			merge = lookup_tree(o.repo, &info->i_tree);
>       +			merge_base = lookup_tree(o.repo, &info->b_tree);
>      @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
>       +			merge_incore_nonrecursive(&o, merge_base, head, merge,
>       +						  &result);
>       +
>      -+			oidcpy(&index_tree, &result.tree->object.oid);
>      -+			merge_finalize(&o, &result);
>      -+
>      -+			if (!result.clean)
>      ++			if (!result.clean) {
>      ++				merge_finalize(&o, &result);
>        				return error(_("conflicts in index. "
>        					       "Try without --index."));
>       -
>      @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
>       -			reset_head();
>       -			discard_index(the_repository->index);
>       -			repo_read_index(the_repository);
>      ++			} else {
>      ++				oidcpy(&index_tree, &result.tree->object.oid);
>      ++				merge_finalize(&o, &result);
>      ++			}
>        		}
>        	}
>        
>       
>      + ## t/t3903-stash.sh ##
>      +@@ t/t3903-stash.sh: setup_stash() {
>      + 	test_cmp expect-index actual-index
>      + '
>      +
>      ++# the later "stash -k" test is not expecting us to muck with file so much, so
>      ++# reset when finished
>      ++test_expect_success 'stash apply --index merges the correct trees' '
>      ++	head=$(git rev-parse HEAD) &&
>      ++	test_when_finished "git reset --hard $head" &&
>      ++	test_write_lines A B C >file &&
>      ++	git commit -m setup file &&
>      ++	test_write_lines A B staged >file &&
>      ++	git add file &&
>      ++	test_write_lines A B unstaged >file &&
>      ++	git stash &&
>      ++	test_write_lines committed B C >file &&
>      ++	git commit -m to-be-merged file &&
>      ++	git stash pop --index &&
>      ++	git show :file >actual &&
>      ++	test_write_lines committed B staged >expect &&
>      ++	test_cmp expect actual &&
>      ++	test_write_lines committed B unstaged >expect &&
>      ++	test_cmp expect file
>      ++'
>      ++
>      + test_expect_success 'stash -k' '
>      + 	echo bar3 >file &&
>      + 	echo bar4 >file2 &&
>      +
>        ## t/t7600-merge.sh ##
>       @@ t/t7600-merge.sh: verify_no_mergehead () {
>        	test_cmp result.1-5 file
> 
> base-commit: d38352cd43ab9745686d697872408bc3249a153f

