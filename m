Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F5AC6FA8E
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiITI3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiITI2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:28:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE76A4BF
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:26:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e18so1324456wmq.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date;
        bh=3wZvvZAD5oUiJUpoaDJMqPhdoZrRLq9vo+kCgYvAuMU=;
        b=UBuVbxiL6+L3DoBkOkihlvORcS+VnCUex3noXqallUx2JDibxEAFwVEwyGPoYM1mpr
         8YJgiycXbceiOv8K9uU72sweyllY2ZozAj5MDGAFUXAce3zznyfnlplnDxULdxe4zsSc
         b9rO73nkyXe8nZlBbPfLc7RXQtHc8u/OYzmF+pBpVwuJS3i0KRAziqdU13Hy34j1C0Cy
         6ykwlNpOL3r6zKY/dXrIwS42O7yIkAmXDf6nKDTdS+wk5Ivd8L6OZFYnrZ0uGxNoygMz
         T69HRKMGdtta9klemzrCldTOQooSR9w/QCZzurd1KPCNiyuzPK8suTIOACyABw7uzjQ1
         yOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3wZvvZAD5oUiJUpoaDJMqPhdoZrRLq9vo+kCgYvAuMU=;
        b=kDBQo29ifFYOgv7XfGr+nrI9gtjsLixTABHpPkuvcSaeMeRNiqRoHLVX36RbkRlNud
         +YYj9AYmzg4fYwn5wWNW0AgMovAVbriOHqb9h/YlbrSOf4H18DCgFoBazSh0RqeqN83u
         0nTU5tpClnJZpAMo1Cu5w8LnSkaIExxsxvXR2QyGYvrmzvm5Sya3XbmZrdOKc1DoyO46
         6FvSNliNLNW7uFLa6ay4RwaU3CQeHb44UGT3nBZbCWf5tf3x780EJC6rsx3g2I+JIEE4
         h8Ac6RcsjQcTlNvEkTdjopROSM3qS2xvfS7M3RAdAOBigqdpgWzPO1Wpmc6+o+dpCn2V
         US+g==
X-Gm-Message-State: ACrzQf3Wwpnc9bgk/pfwkBTQQL3goNQkaJQi0tU4ac3XSYmvB6yUorDH
        7e3j385bHabIG7C3gOX4g1JnH17mfyVmsA==
X-Google-Smtp-Source: AMsMyM6ZJIpao6Zon4fO1P9yEmwiPbEl0M9dofxypkaJ41i8jz5voccNCFxMW5PoExQS4BqbL1hXOQ==
X-Received: by 2002:a05:600c:5028:b0:3a8:4349:153c with SMTP id n40-20020a05600c502800b003a84349153cmr1428606wmr.130.1663662388924;
        Tue, 20 Sep 2022 01:26:28 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c2cb600b003b4868eb71bsm18423635wmc.25.2022.09.20.01.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:26:28 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8909c02d-3fd0-a0bb-ebc2-0a640febce53@dunelm.org.uk>
Date:   Tue, 20 Sep 2022 09:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
To:     Johannes Altmanninger <aclopte@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
References: <xmqqleqfcoz3.fsf@gitster.g>
 <20220920031140.1220220-1-aclopte@gmail.com>
Content-Language: en-US
In-Reply-To: <20220920031140.1220220-1-aclopte@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 20/09/2022 04:11, Johannes Altmanninger wrote:
> Commit 68d5d03bc4 (rebase: teach --autosquash to match on sha1 in
> addition to message, 2010-11-04) taught autosquash to recognize
> subjects like "fixup! 7a235b" where 7a235b is an OID-prefix. It
> actually did more than advertised: 7a235b can be an arbitrary
> commit-ish (as long as it's not trailed by spaces).
> 
> Accidental(?) use of this secret feature revealed a bug where we
> would silently drop a fixup commit. The bug can also be triggered
> when using an OID-prefix but that's unlikely in practice.
> 
> Given a commit with subject "fixup! main" that is the tip of the
> branch "main". When computing the fixup target for this commit, we
> find the commit itself. This is wrong because, by definition, a fixup
> target must be an earlier commit in the todo list. We wrongly find
> the current commit because we added it to the todo list prematurely.
> Avoid these fixup-cycles by only adding the current commit after we
> have finished finding its target.

Thanks for working on this, the fix for the fixup self reference looks 
good. It's unfortunate that the implementation is not stricter when 
parsing "fixup! <oid>" but it is more or less consistent with the shell 
version which used "git rev-parse $subject"[1]. We should think about 
being stricter but this fix avoids on of the worst pitfalls of our lax 
parsing.

Best Wishes

Phillip

[1] With regard to the oid vs subject prefix issue, I think the shell 
version chose to fixup the first commit that matched either the oid or 
the subject. At least the C version is consistent in preferring an oid 
match over a subject prefix match even if I wish it was the other way round.

> Reported-by: Erik Cervin Edin <erik@cervined.in>
> Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> ---
>   sequencer.c                  |  4 ++--
>   t/t3415-rebase-autosquash.sh | 26 ++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+), 2 deletions(-)
> 
> Changes to v1.
> - Remove wrong assumptions from commit message. The commit message should
>    be clearer now (though I didn't spend too much time on it).
> - Drop one test because it's not related to the fix (and doesn't test anything
>    I care about) and modify the other test so it requires the fix to pass.
> 
> 1:  cb2ee0e003 ! 1:  410ca51936 sequencer: avoid dropping fixup commit that targets self via commit-ish
>      @@ Commit message
>           sequencer: avoid dropping fixup commit that targets self via commit-ish
>       
>           Commit 68d5d03bc4 (rebase: teach --autosquash to match on sha1 in
>      -    addition to message, 2010-11-04) made --autosquash apply a commit
>      -    with subject "fixup! 012345" to the first commit in the todo list
>      -    whose OID starts with 012345. So far so good.
>      +    addition to message, 2010-11-04) taught autosquash to recognize
>      +    subjects like "fixup! 7a235b" where 7a235b is an OID-prefix. It
>      +    actually did more than advertised: 7a235b can be an arbitrary
>      +    commit-ish (as long as it's not trailed by spaces).
>       
>      -    More recently, c44a4c650c (rebase -i: rearrange fixup/squash lines
>      -    using the rebase--helper, 2017-07-14) reimplemented this logic in C
>      -    and introduced two behavior changes.
>      -    First, OID matches are given precedence over subject prefix
>      -    matches.  Second, instead of prefix-matching OIDs, we use
>      -    lookup_commit_reference_by_name().  This means that if 012345 is a
>      -    branch name, we will apply the fixup commit to the tip of that branch
>      -    (if that is present in the todo list).
>      +    Accidental(?) use of this secret feature revealed a bug where we
>      +    would silently drop a fixup commit. The bug can also be triggered
>      +    when using an OID-prefix but that's unlikely in practice.
>       
>      -    Both behavior changes might be motivated by performance concerns
>      -    (since the commit message mentions performance).  Looking through
>      -    the todo list to find a commit that matches the given prefix can be
>      -    more expensive than looking up an OID.  The runtime of the former is
>      -    of O(n*m) where n is the size of the todo list and m is the length
>      -    of a commit subject. However, if this is really a problem, we could
>      -    easily make it O(m) by constructing a trie (prefix tree).
>      -
>      -    Demonstrate both behavior changes by adding two test cases for
>      -    "fixup! foo" where foo is a commit-ish that is not an OID-prefix.
>      -    Arguably, this feature is very weird.  If no one uses it we should
>      -    consider removing it.
>      -
>      -    Regardless, there is one bad edge case to fix.  Let refspec "foo" point
>      -    to a commit with the subject "fixup! foo". Since rebase --autosquash
>      -    finds the fixup target via lookup_commit_reference_by_name(), the
>      -    fixup target is the fixup commit itself. Obviously this can't work.
>      -    We proceed with the broken invariant and drop the fixup commit
>      -    entirely.
>      -
>      -    The self-fixup was only allowed because the fixup commit was already
>      -    added to the preliminary todo list, which it shouldn't be.  Rather,
>      -    we should first compute the fixup target and only then add the fixup
>      -    commit to the todo list. Make it so, avoiding this error by design,
>      -    and add a third test for this case.
>      +    Given a commit with subject "fixup! main" that is the tip of the
>      +    branch "main". When computing the fixup target for this commit, we
>      +    find the commit itself. This is wrong because, by definition, a fixup
>      +    target must be an earlier commit in the todo list. We wrongly find
>      +    the current commit because we added it to the todo list prematurely.
>      +    Avoid these fixup-cycles by only adding the current commit after we
>      +    have finished finding its target.
>       
>           Reported-by: Erik Cervin Edin <erik@cervined.in>
>      -    Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
>      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>       
>        ## sequencer.c ##
>       @@ sequencer.c: int todo_list_rearrange_squash(struct todo_list *todo_list)
>      @@ t/t3415-rebase-autosquash.sh: test_expect_success 'auto squash that matches long
>       +test_expect_success 'auto squash that matches regex' '
>       +	git reset --hard base &&
>       +	git commit --allow-empty -m "hay needle hay" &&
>      -+	git commit --allow-empty -m "fixup! :/[n]eedle" &&
>      ++	git commit --allow-empty -m "fixup! :/needle" &&
>       +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
>      -+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
>      ++	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
>       +	cat <<-EOF >expect &&
>       +	pick HASH hay needle hay # empty
>      -+	fixup HASH fixup! :/[n]eedle # empty
>      -+	EOF
>      -+	test_cmp expect actual
>      -+'
>      -+
>      -+test_expect_success 'auto squash of fixup commit that matches branch name' '
>      -+	git reset --hard base &&
>      -+	git commit --allow-empty -m "wip commit (just a prefix match so overshadowed by branch)" &&
>      -+	git commit --allow-empty -m "tip of wip" &&
>      -+	git branch wip &&
>      -+	git commit --allow-empty -m "unrelated commit" &&
>      -+	git commit --allow-empty -m "fixup! wip" &&
>      -+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^^^ &&
>      -+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
>      -+	cat <<-EOF >expect &&
>      -+	pick HASH wip commit (just a prefix match so overshadowed by branch) # empty
>      -+	pick HASH tip of wip # empty
>      -+	fixup HASH fixup! wip # empty
>      -+	pick HASH unrelated commit # empty
>      ++	fixup HASH fixup! :/needle # empty
>       +	EOF
>       +	test_cmp expect actual
>       +'
>      @@ t/t3415-rebase-autosquash.sh: test_expect_success 'auto squash that matches long
>       +	git commit --allow-empty -m "fixup! self-cycle" &&
>       +	git branch self-cycle &&
>       +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
>      -+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
>      ++	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
>       +	cat <<-EOF >expect &&
>       +	pick HASH second commit
>       +	pick HASH fixup! self-cycle # empty
> 
> 
> diff --git a/sequencer.c b/sequencer.c
> index 484ca9aa50..777200a6dc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6287,8 +6287,6 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   			return error(_("the script was already rearranged."));
>   		}
>   
> -		*commit_todo_item_at(&commit_todo, item->commit) = item;
> -
>   		parse_commit(item->commit);
>   		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
>   		find_commit_subject(commit_buffer, &subject);
> @@ -6355,6 +6353,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   					strhash(entry->subject));
>   			hashmap_put(&subject2item, &entry->entry);
>   		}
> +
> +		*commit_todo_item_at(&commit_todo, item->commit) = item;
>   	}
>   
>   	if (rearranged) {
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 78c27496d6..98af865268 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -232,6 +232,32 @@ test_expect_success 'auto squash that matches longer sha1' '
>   	test_line_count = 1 actual
>   '
>   
> +test_expect_success 'auto squash that matches regex' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m "hay needle hay" &&
> +	git commit --allow-empty -m "fixup! :/needle" &&
> +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
> +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
> +	cat <<-EOF >expect &&
> +	pick HASH hay needle hay # empty
> +	fixup HASH fixup! :/needle # empty
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'auto squash of fixup commit that matches branch name which points back to fixup commit' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m "fixup! self-cycle" &&
> +	git branch self-cycle &&
> +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
> +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
> +	cat <<-EOF >expect &&
> +	pick HASH second commit
> +	pick HASH fixup! self-cycle # empty
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_auto_commit_flags () {
>   	git reset --hard base &&
>   	echo 1 >file1 &&
