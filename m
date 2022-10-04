Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377CDC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 20:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJDUfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDUfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 16:35:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C4140BE
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 13:35:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s206so13642409pgs.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AMxsSVJi2bYgCbNGubObrrYX5ZkLByaqHJZmf2ebE7k=;
        b=TsrtniW57l8dR6qDhjSd7VJxmj+LDHy0kqr7myomfob1+1RGPFbgMW5c8yZ0YE/nZz
         xEbLLiZa2THNvQAKosQiZ4ueTqHwvSpgb29NkqWUhsID0I/mbneR5+VgoeWQS3uoVT3z
         w9EmS/2aeh/A2p4CYJMJ4NlAWCpkUhjD4xZIZIBzbr39Wg8JwG2XwwMYzP3gmh4LiU6a
         NBu8wUVyPDy9ya+XnfneWOT2fdcb8Ht2/wvytbhErgw2FEbSZnr4yuVXXQH8+qjc1sAn
         a/Pmjj9MK/0QxL1XdTJkE6Cn2yuNpQMFYcG5rxTS3msasPLRxFzqrLMpEf2HVGKHQMPK
         rGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AMxsSVJi2bYgCbNGubObrrYX5ZkLByaqHJZmf2ebE7k=;
        b=WI6yMe7NfuKbj7quSjeTd4BOx2vEohbC9a3im4ivRU2w+NaFOGAoPwq7uRW/ARhCxa
         L2gSqHGH/VpJB9eiJLhd5/t6i1vUtLM/7fbm9bznY5Yh/Vf/61K2hUuQQlXl/45tw6Ze
         lgNH0DDaDLLWmm6xv6XKxCU8rvdWETJdKxxqYcxd+Ohnw9xotc82kz4X8WzVmWqyCDe1
         tvs3Y/Ev5A06g+TLl8W9inMA4AAcUpn6mN1UTrb44CYIZYpKsdqb6rYAkIVWQT+BZG4A
         8a9PkZdRbpNHm1pWSc6SHwh5R+Ie2Tv9rOukYQL8B62j4QVcny9tkIPytAZah16z5j4/
         Hh5A==
X-Gm-Message-State: ACrzQf3UAGm1g0l1nz/1lLbB7AwJhmBofIInKWJUp4lIrTsUm9bl/bmO
        Vj8NpOjD1iJI8u697IGx/Bgd
X-Google-Smtp-Source: AMsMyM6qHwdCJYMx88bIW7yQFiDSopwkpbjZvXNpe41IqKgEYP98WdfjuSaxRgX6XhDa0tfZsDQp2w==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d52 with SMTP id l4-20020a056a0016c400b0053508900d52mr29430880pfc.9.1664915701720;
        Tue, 04 Oct 2022 13:35:01 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id q6-20020aa79606000000b0055fb19e27a8sm7276935pfg.121.2022.10.04.13.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 13:35:01 -0700 (PDT)
Message-ID: <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
Date:   Tue, 4 Oct 2022 13:34:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Bug report: `git restore --source --staged` deals poorly with
 sparse-checkout
Content-Language: en-US
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com>
 <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin!

Please make sure you respond in plaintext - it looks like your message didn't
make it to the mailing list. I've reformatted it to render nicely in this 
reply.

Martin von Zweigbergk wrote:
>> On Tue, Oct 4, 2022 at 9:34 AM Victoria Dye <vdye@github.com <mailto:vdye@github.com>> wrote:
>> 
>> Glen Choo wrote:
>>> Filing a `git bugreport` on behalf of a user at $DAYJOB. I'm also pretty
>>> surprised by this behavior, perhaps someone who knows more could shed
>>> some light?
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>>
>>>   git clone git@github.com:git/git.git . &&
>>>   git sparse-checkout set t &&
>>>   git restore --source v2.38.0-rc1 --staged Documentation &&
>>>   git status
>>> ...>
>>> What happened instead? (Actual behavior)
>>>
>>> I saw a staged modification (Documentation/cmd-list.perl) and the same
>>> file reported as deleted in the working copy. Specifically,
>>>
>>>   $ git status
>>>
>>>   On branch master
>>>   Your branch is up to date with 'origin/master'.
>>>
>>>   You are in a sparse checkout with 64% of tracked files present.
>>>
>>>   Changes to be committed:
>>>     (use "git restore --staged <file>..." to unstage)
>>>           modified:   Documentation/cmd-list.perl
>>>
>>>   Changes not staged for commit:
>>>     (use "git add/rm <file>..." to update what will be committed)
>>>     (use "git restore <file>..." to discard changes in working directory)
>>>           deleted:    Documentation/cmd-list.perl
>>>
>> 
>> Thanks for reporting this! There are a few confusing things going on with
>> 'restore' here.
>> 
>> First is that the out-of-cone was even restored in the first place.
>> 
> 
> I was actually happy that the out-of-cone paths were restored. I ran that
> command as an experiment while reading Elijah's doc because I was curious
> what would happen. The reason I think it should restore out-of-cone paths is
> so you can do `git restore --staged --source <some commit> && git commit -m
> "restore to old commit"` without caring about the sparse spec.

Conversely, that's behavior a user *wouldn't* want if they want to keep
their sparse cone intact (not to mention the performance impact of checking
out the entire worktree). I think it does more harm to those users than it
would benefit the ones that want to checkout out-of-cone files.

The use-case you're describing should be served by the
'--ignore-skip-worktree-bits' option (not the most intuitive name,
unfortunately). Luckily, there's an increasing desire to improve the naming
of sparse-related options, so the UX situation should improve in the future.

> 
>> Theoretically, 'restore' (like 'checkout') should be limited to pathspecs
>> inside the sparse-checkout patterns (per the documentation of
>> '--ignore-skip-worktree-bits'), but 'Documentation' does not match them.
>> Then, there's a difference between 'restore' and 'checkout' that doesn't
>> seem intentional; both remove the 'SKIP_WORKTREE' flag from the file, but
>> only 'checkout' creates the file on-disk (therefore avoiding the "deleted"
>> status).
> 
> Restoring only into the index (as I think `git restore --staged` is supposed
> to do) is weird. 

'git restore --staged' is intended to restore to both the worktree and index
(per 183fb44fd2 (restore: add --worktree and --staged, 2019-04-25)). The bug
you've identified is that it's not restoring to the worktree.

Assuming everything was working properly, users could still choose to
restore only to the index (using the '--no-worktree' option).

> Let's say we do a clean checkout of a commit with tree A
> (i.e. the root tree's hash is A). If we do `git sparse-checkout set
> non-existent`, the index and the working copy still logically contain state
> A, right? 

The index will, but the working tree will be empty because all index entries
not matching 'non-existent' will have SKIP_WORKTREE applied.

> If we now do `git restore --staged --source HEAD^` and that
> command doesn't remove the `SKIP_WORKTREE` flag on any paths, that logically
> means that we have modified the working copy, and I think `git
> sparse-checkout disable` would agree with me. 

If you aren't using '--ignore-skip-worktree-bits', the entries with
SKIP_WORKTREE shouldn't be touched in the first place. If you *do* specify
it, by virtue of restoring to the working tree, SKIP_WORKTREE must be
removed.

But suppose you're doing something like 'git restore --staged --no-worktree
--ignore-skip-worktree-bits --source HEAD^'. In that case:

- you are restoring to the index
- you are *not* restoring to the worktree
- you're restoring files with SKIP_WORKTREE applied

Right now, SKIP_WORKTREE is removed from the matched entries, but suppose
(per your comment) it wasn't. That wouldn't mean that we've "modified the
working copy"; the working tree is defined with respect to the index, and if
the index entry says "I don't care about the worktree", then there are no
differences to reflect. 

This raises an interesting question about the current behavior, though: if
you restore a SKIP_WORKTREE entry with '--staged' and '--no-worktree',
should we remove SKIP_WORKTREE? I'd lean towards "no", but I'm interested to
hear other contributors' thoughts.

> That's different from how `git
> restore --staged` without sparse-checkout would have worked (it would not
> have updated the working copy). So from that perspective, it might make
> sense to remove the `SKIP_WORKTREE` and add the old file contents back in
> the working (i.e. from state A in this example), and maybe that's why the
> commands do that? 

It's important to avoid restoring a file to the worktree when it has
SKIP_WORKTREE enabled. See af6a51875a (repo_read_index: clear SKIP_WORKTREE
bit from files present in worktree, 2022-01-14) and the corresponding
discussion in [1].

[1] https://lore.kernel.org/all/pull.1114.v2.git.1642175983.gitgitgadget@gmail.com/

> Actually, `git checkout HEAD^ .` would update both the
> index and the working copy to match
> HEAD^, so that shouldn't have to remove the `SKIP_WORKTREE`, maybe?
> 


