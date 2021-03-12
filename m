Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF52AC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F4F64E45
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhCLLJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhCLLJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 06:09:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE6C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:09:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v11so1540922wro.7
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4iNDaR7X/Pde7klwZ+M2TeQ6gRCXrm/AKZFAgHFkdw0=;
        b=oiegJR52mNV2ivibxDqlt+2dFFXLnUpPlu5ibc50RUAUesKJLJUGVQY2zRCI+CKUFT
         tv3RJjS4bkk0R/+nzvHY3jUTEa+wfWz3itrsmSyXGbe80co5/XEGjMn7QLUciyIEFLGd
         MPlrZNQrYogHKNjti+Sjf4vzp4nhtsNB8n5nFyE2sC7ypULIhqCY5+UpCMf1lqsVmIbg
         Sx2hm7FewLi5o45xxyF91WUx0xaoAyk7Xp86/+op4l49TEGeR1+V6gC/hyh/lalzAkAP
         4p4REfxhgfy+SKitZiN5rBFPcEqjz3D/WI21OmQ/lzh64EfqB7Ifw+iIVuNyhc1rSVno
         0z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4iNDaR7X/Pde7klwZ+M2TeQ6gRCXrm/AKZFAgHFkdw0=;
        b=nleYsjPt7BXtV6V7lhACAaClSte/LR5mk19jnUr3jwlBuPjQdoo0uOvocAUQbzb/fJ
         N8e9cTb1oG4blzkw1Xb/ZrlQBShEw6on2umXnv7kOnmCLKc44BkgJgF3RMHNtncM0ALS
         6hjmYhVjD/nlwy1hSY92Ff2bLsdylBe4S4OCiHZ+iMC+U8aPEthKrBn5BTZnsXeWH/Vc
         DI6cqTsdBKuNVFwCZL5+mpiHKoRF/lytd/JFoCRqr7gUqw4Pz5JxaTgvfVnT8z93EFFW
         8E3XwxaqJS8qKMBxx9lciNCBXKO9tL774enOAL+CcrT1lZamODPdf6Rm22a4ZDQ8muCF
         v6Zg==
X-Gm-Message-State: AOAM533FCQphvAkCHTjFNwtCBKg9gMFM70XyBlrTj2GiTB6RrpysMj/3
        dwsAQng0HAJxlvO+JS3NrwvG32DD5pU=
X-Google-Smtp-Source: ABdhPJzG2YFF6KGZymXj3+ycWV1rPaEEPgV7RC6cAWZvsyqacAS+xCS2qaXul+u6VIF/ptegZjg6Tw==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr6614361wrv.10.1615547359263;
        Fri, 12 Mar 2021 03:09:19 -0800 (PST)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id a13sm5453672wrp.31.2021.03.12.03.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:09:18 -0800 (PST)
Subject: Re: [BUG] cmd given to "rebase -x cmd" cannot see the original HEAD?
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8s6tcuxc.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f6cdbe1b-eb5a-5822-0ca9-a78c38a2fe7a@gmail.com>
Date:   Fri, 12 Mar 2021 11:09:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s6tcuxc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 11/03/2021 20:11, Junio C Hamano wrote:
> I was trying to figure out why I am losing the amlog note that
> maps each commit on topics to the message ID after amending them
> with extra trailers (e.g. Reviewed-by).  I use a script that runs
> "git commit --amend" to do this and give it to "rebase -x".
> 
> It seems that when the command given to "rebase -x" is run, HEAD is
> already updated to a commit with tree and log message identical to
> the original, with updated committer information.  However, the
> note attached to the original commit is *not* copied to this
> intermediate HEAD that is shown to the external command.

Yes this is annoying I've sometimes wanted to edit the notes when the 
rebase is stopped for for 'edit' or 'break' commands

> Hence, even if I try to read the existing note from HEAD that is
> given to the script spawned via "rebase -x cmd" mechanism, the
> script cannot copy the note to the resulting commit after it adds
> extra trailers.  Also, there is no mechansim for the external
> command to learn where the original HEAD was.
> 
> I see a few possible avenues to fix this.
> 
> 1. Before "rebase -x" mechanism spawns an external command, make
>     sure that the "copy notes upon rewriting" logic has triggered, so
>     that the HEAD observable by the command has the notes from the
>     original.

That would be my preferred way to fix this, but we should also copy the 
notes before stopping for an 'edit' or 'break' and maybe 'reword' so 
that the notes are always available when a rebase stops for some reason 
other than conflict resolution.

>  It seems that the "copy notes" logic is only used at
>     the end, but it does not seem to take the possibility into
>     account that the external command might move HEAD to a different
>     commit (i.e. it starts from HEAD0, creates HEAD1 that is
>     different from HEAD0 only for committer info, hands HEAD1 to
>     external command that may move HEAD to HEAD2, but then copies the
>     note from HEAD0 to HEAD1 because it is unaware of HEAD2), so it
>     only annotates HEAD1 that is immediately lost (nothing other than
>     HEAD's reflog would be pointing at it). [*]

I think the root cause is that 'git commit --amend' does not update the 
list of rewritten commits when run during a rebase, which messes up the 
post-rewrite hooks (as you suspected) and note copying which is 
essentially a built-in post-rewrite hook. I've got a half finished 
solution but there are some corner cases that I've never got round to 
addressing. It would fix your problem but not the problem of making 
notes available to the user during the rebase.


Best Wishes

Phillip

> 2. Make sure the "copy notes" logic copies the notes taken from the
>     original HEAD to the HEAD _after_ "rebase -x" external command
>     returns.
> 
> The first approach would still make the external command responsible
> for copying notes from HEAD it sees (i.e. HEAD1) to the new commit
> it creates and points HEAD at (i.e. HEAD2).  It _could_ be used as a
> mechanism to allow the external command to modify/remove notes.
> 
> The second approach would forbid the external command from mucking
> with notes at all.  "rebase" would first remember the original HEAD
> (i.e. HEAD0), does its thing (i.e. creates HEAD1 and points HEAD at
> it, and then lets the external command create HEAD2 and point HEAD
> at it), and then figure out the latest HEAD and copy notes from the
> original HEAD.  It is simpler, works with scripts that uses things
> like "commit --amend" that do not copy notes, but less flexible.
> 
> Implementation-wise, it seems that the latter would require more
> significant surgery to do_pick_commit() codepath, but somebody more
> familiar with the sequencer codepath should research to find the
> best approach.
> 
> I suspect that "post-commit" hook that is run from try_to_commit()
> may have the same issue, here in sequencer.c
> 
> 1539:	run_commit_hook(0, r->index_file, "post-commit", NULL);
> 1540:	if (flags & AMEND_MSG)
> 1541:		commit_post_rewrite(r, current_head, oid);
> 
> where oid is not adjusted by re-reading what the post-commit hook
> did to our HEAD.
> 
> But the codepath to reach do_exec() (which is what spawns the
> external command for "rebase -x cmd") is quite away from any
> call to commit_post_rewrite(),
> 
> 
> 
> [footnote]
> 
> I have a 6-commit series with notes/amlog record on each commit, and
> running:
> 
> $ git rebase -x '
> 	git rev-parse HEAD
> 	git notes --ref=notes/amlog show HEAD || :
> ' master $(git rev-parse ab/read-tree)
> 
> yields the following:
> 
> Executing: git rev-parse HEAD; git notes --ref=notes/amlog show HEAD || :
> 669950d7def2e849cb1ee6e7b3a1beac5c45ce1c
> error: no note found for object 669950d7def2e849cb1ee6e7b3a1beac5c45ce1c.
> Executing: git rev-parse HEAD; git notes --ref=notes/amlog show HEAD || :
> 0545e0a567f96eff14dfb93b44aecf9683b44803
> error: no note found for object 0545e0a567f96eff14dfb93b44aecf9683b44803.
> Executing: git rev-parse HEAD; git notes --ref=notes/amlog show HEAD || :
> d9b4e77efe5e65952e05533ebf500b559408d436
> error: no note found for object d9b4e77efe5e65952e05533ebf500b559408d436.
> Executing: git rev-parse HEAD; git notes --ref=notes/amlog show HEAD || :
> 6d8735372c0c9b9d3793959157456cd445d025fa
> error: no note found for object 6d8735372c0c9b9d3793959157456cd445d025fa.
> Executing: git rev-parse HEAD; git notes --ref=notes/amlog show HEAD || :
> b86c1305258a11f42927f924498a94b3ffb19472
> error: no note found for object b86c1305258a11f42927f924498a94b3ffb19472.
> Executing: git rev-parse HEAD; git notes --ref=notes/amlog show HEAD || :
> 7da85bae9f11ab14d616bcade1fb2a7b434aa716
> error: no note found for object 7da85bae9f11ab14d616bcade1fb2a7b434aa716.
> Successfully rebased and updated detached HEAD.
> 
> We can see each commit on ab/read-tree has notes/amlog entry that
> records where it came from:
> 
> $ git log --notes=notes/amlog --oneline --reverse master..ab/read-tree
> 2e3e38a4ad ls-files tests: add meaningful --with-tree tests
> Notes (amlog):
>      Message-Id: <20210308022138.28166-2-avarab@gmail.com>
> 
> 2371fda438 tree.c API: move read_tree() into builtin/ls-files.c
> Notes (amlog):
>      Message-Id: <20210308022138.28166-3-avarab@gmail.com>
> 
> 32c718db53 ls-files: don't needlessly pass around stage variable
> Notes (amlog):
>      Message-Id: <20210308022138.28166-4-avarab@gmail.com>
> 
> 2ebabd63f7 ls-files: refactor away read_tree()
> Notes (amlog):
>      Message-Id: <20210308022138.28166-5-avarab@gmail.com>
> 
> e98fb6ddc7 tree.h API: remove support for starting at prefix != ""
> Notes (amlog):
>      Message-Id: <20210308022138.28166-6-avarab@gmail.com>
> 
> 8e88702431 tree.h API: remove "stage" parameter from read_tree_recursive()
> Notes (amlog):
>      Message-Id: <20210308022138.28166-7-avarab@gmail.com>
> 
> 
> In the above transcript, 669950d7def2e8 (the first commit that the
> "rebase -x" command saw) corresponds to 2e3e38a4ad (the first commit
> in the series), and we can see the only difference between them is
> the committer info.  As we already saw in the above, the original
> has a note that is not copied to the new one when "rebase -x"
> command runs.
> 
> $ git show --pretty=fuller 2e3e38a4ad >old
> $ git show --pretty=fuller 669950d7def2e8 >new
> $ diff -u old new
> --- old	2021-03-11 12:06:33.259434213 -0800
> +++ new	2021-03-11 12:06:33.259434213 -0800
> @@ -1,8 +1,8 @@
> -commit 2e3e38a4ad6d9d78381e90348289277acb4c6f8b
> +commit 669950d7def2e849cb1ee6e7b3a1beac5c45ce1c
>   Author:     Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>   AuthorDate: Mon Mar 8 03:21:33 2021 +0100
>   Commit:     Junio C Hamano <gitster@pobox.com>
> -CommitDate: Mon Mar 8 10:06:35 2021 -0800
> +CommitDate: Thu Mar 11 12:01:11 2021 -0800
>   
>       ls-files tests: add meaningful --with-tree tests
>       
> 
> HOWEVER, after that failed "rebase -x" session, the note is copied
> to these "intermediate" commits.  Using 7da85bae9f1 which is at the
> tip of the history fed to "rebase -x" external command, we can see:
> 
> $ git log --notes=notes/amlog --oneline --reverse master..7da85bae9f1
> 
> 669950d7de ls-files tests: add meaningful --with-tree tests
> Notes (amlog):
>      Message-Id: <20210308022138.28166-2-avarab@gmail.com>
> 
> 0545e0a567 tree.c API: move read_tree() into builtin/ls-files.c
> Notes (amlog):
>      Message-Id: <20210308022138.28166-3-avarab@gmail.com>
> 
> d9b4e77efe ls-files: don't needlessly pass around stage variable
> Notes (amlog):
>      Message-Id: <20210308022138.28166-4-avarab@gmail.com>
> 
> 6d8735372c ls-files: refactor away read_tree()
> Notes (amlog):
>      Message-Id: <20210308022138.28166-5-avarab@gmail.com>
> 
> b86c130525 tree.h API: remove support for starting at prefix != ""
> Notes (amlog):
>      Message-Id: <20210308022138.28166-6-avarab@gmail.com>
> 
> 7da85bae9f tree.h API: remove "stage" parameter from read_tree_recursive()
> Notes (amlog):
>      Message-Id: <20210308022138.28166-7-avarab@gmail.com>
> 
> 
> It is only that they seem to be added _after_ the external command
> finishes, which is not a very useful behaviour.
> 

