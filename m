Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9D81F42B
	for <e@80x24.org>; Wed, 12 Sep 2018 02:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeILHpG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 03:45:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41107 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILHpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 03:45:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so309208wrb.8
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W0+Ht41mDZgl9cuDwssUXSn2i4UohGTRkhv7Wbt3Gis=;
        b=qbzd/t8FN/fLrFOt+1BrNLwXdd3beRT5Hovzvu/BW+e0YEW1EyTSSMSOFJaJ8kU9zG
         gzRxKxWhHWCduElq+rqgI95X/uOutBvHgQ45CqpoFZfJdFcRSUKWiZM1cyWpGlIYS4tT
         K2cxuQQrJlrzkAADPXaJeokPuuIx25loUcV8t1J7SzB3wC8sNjzoYyRtVyPs8OPaV3Ri
         szmUctdAqWXzNJq0NHkxGHsGL+hyUPo6ILo6pUPhyiKYNIU5Qt0srY9w2B7Q/YhsYfC5
         n4CM1WA9bYEkA+1bYR6oPco6mq40lG+bKszv/LchxxJygFKGu9a3KnUwxL03dbgbPbu2
         5/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W0+Ht41mDZgl9cuDwssUXSn2i4UohGTRkhv7Wbt3Gis=;
        b=qFTW8DwMN6HKdFmp3NEtQiE8FlunS/X2PeGOKaGrNHGqZp/oAiUpKL+H1Yc8F3U0c4
         9vE2dFdOxiat/3rgMybzjrkzkPZeeIMe/FKGlqJFJHl2tGENpG5mr4tjXGjGVZZ/1h8J
         aNKYUS2/xwAYq024fKeau5yEyMQ0BuU8dfgep9eQhc+nC/+nSRAWPm0+wkGt86NqQOFr
         nI+LiPLC5MPecmpG0WuSnuYZqzi17niyaVYXWwRN5TmMA34Isy8tk3rJm7oVsKsJmBpN
         oLwb87pxVD+wCpX7yjD8czOU3OXMmIElJEKNLEgwrHEAvxBChFUZ6nM3Tff4jCX2VM0i
         v2Og==
X-Gm-Message-State: APzg51B6W3w8bxoG7TPrv07FGQ5ZD4gBUxM06QbeWSl3+D9cEWbEfKdE
        cJY+etwVTRVSffhkPfmsJXg=
X-Google-Smtp-Source: ANB0VdaHDGTlkWBMMuiHqSXSL0SBGBIgsWlYgBin02SH9zIKuSmjpO9kJxAtCC/ucGGTOsrhgcde+A==
X-Received: by 2002:a5d:4684:: with SMTP id u4-v6mr21752170wrq.76.1536720170840;
        Tue, 11 Sep 2018 19:42:50 -0700 (PDT)
Received: from localhost (x590c326e.dyn.telefonica.de. [89.12.50.110])
        by smtp.gmail.com with ESMTPSA id w18-v6sm47349548wrc.38.2018.09.11.19.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 19:42:49 -0700 (PDT)
Date:   Wed, 12 Sep 2018 04:42:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: 2.19.0 regression: leaving editor with empty commit message doesn't
 stop rebase [was: Re: [RFC PATCH v5 9/9] git-rebase: make
 --allow-empty-message the default]
Message-ID: <20180912024241.GA27036@localhost>
References: <20180625161300.26060-1-newren@gmail.com>
 <20180627072319.31356-1-newren@gmail.com>
 <20180627072319.31356-10-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627072319.31356-10-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Lately I noticed that occasionally I ended up with an empty commit
message after an interactive rebase.  However, since I didn't do
anything that I haven't already done countless times before, I thought
that one of my local patches touching the area where 'git commit'
calls launch_editor() got messed up.  Unfortunately, it turned out
that my patch is fine, and those empty commit messages are the
consequence of a regression in v2.19.0, which bisects down to this
patch.

To reproduce the issue, just start an interactive rebase, choose a
commit to reword, save, delete all the commit message, save, and BAM!
there is the commit with the empty message.


On Wed, Jun 27, 2018 at 12:23:19AM -0700, Elijah Newren wrote:
> rebase backends currently behave differently with empty commit messages,
> largely as a side-effect of the different underlying commands on which
> they are based.  am-based rebases apply commits with an empty commit
> message without stopping or requiring the user to specify an extra flag.
> (It is interesting to note that am-based rebases are the default rebase
> type, and no one has ever requested a --no-allow-empty-message flag to
> change this behavior.)  merge-based and interactive-based rebases (which
> are ultimately based on git-commit), will currently halt on any such
> commits and require the user to manually specify what to do with the
> commit and continue.
> 
> One possible rationale for the difference in behavior is that the purpose
> of an "am" based rebase is solely to transplant an existing history, while
> an "interactive" rebase is one whose purpose is to polish a series before
> making it publishable.  Thus, stopping and asking for confirmation for a
> possible problem is more appropriate in the latter case.  However, there
> are two problems with this rationale:
> 
>   1) merge-based rebases are also non-interactive and there are multiple
>      types of rebases that use the interactive machinery but are not
>      explicitly interactive (e.g. when either --rebase-merges or
>      --keep-empty are specified without --interactive).  These rebases are
>      also used solely to transplant an existing history, and thus also
>      should default to --allow-empty-message.
> 
>   2) this rationale only says that the user is more accepting of stopping
>      in the case of an explicitly interactive rebase, not that stopping
>      for this particular reason actually makes sense.  Exploring whether
>      it makes sense, requires backing up and analyzing the underlying
>      commands...
> 
> If git-commit did not error out on empty commits by default, accidental
> creation of commits with empty messages would be a very common occurrence
> (this check has caught me many times).  Further, nearly all such empty
> commit messages would be considered an accidental error (as evidenced by a
> huge amount of documentation across version control systems and in various
> blog posts explaining how important commit messages are).  A simple check
> for what would otherwise be a common error thus made a lot of sense, and
> git-commit gained an --allow-empty-message flag for special case
> overrides.  This has made commits with empty messages very rare.
> 
> There are two sources for commits with empty messages for rebase (and
> cherry-pick): (a) commits created in git where the user previously
> specified --allow-empty-message to git-commit, and (b) commits imported
> into git from other version control systems.  In case (a), the user has
> already explicitly specified that there is something special about this
> commit that makes them not want to specify a commit message; forcing them
> to re-specify with every cherry-pick or rebase seems more likely to be
> infuriating than helpful.  In case (b), the commit is highly unlikely to
> have been authored by the person who has imported the history and is doing
> the rebase or cherry-pick, and thus the user is unlikely to be the
> appropriate person to write a commit message for it.  Stopping and
> expecting the user to modify the commit before proceeding thus seems
> counter-productive.

I agree that this is an issue that should be addressed, and also agree
that it's reasonable to accept an empty commit message, if the
original commit already had an empty commit message.  (Though perhaps
not completely silently, but with a warning?  Dunno.)

However, this should only be the case for existing commit messages
that are taken verbatim, but never in the case when the user is asked
for a commit message.

> Further, note that while empty commit messages was a common error case for
> git-commit to deal with, it is a rare case for rebase (or cherry-pick).
> The fact that it is rare raises the question of why it would be worth
> checking and stopping on this particular condition and not others.  For
> example, why doesn't an interactive rebase automatically stop if the
> commit message's first line is 2000 columns long, or is missing a blank
> line after the first line, or has every line indented with five spaces, or
> any number of other myriad problems?

Because leaving the editor with an empty commit message is and has
always been the established way for aborting 'git commit' and thus
stopping whatever operation it was part of.

And because the instructions in the commit message template, which is
shown for 'reword' and 'squash', too, still say so:

  # Please enter the commit message for your changes. Lines starting
  # with '#' will be ignored, and an empty message aborts the commit.

> Finally, note that if a user doing an interactive rebase does have the
> necessary knowledge to add a message for any such commit and wants to do
> so, it is rather simple for them to change the appropriate line from
> 'pick' to 'reword'.  The fact that the subject is empty in the todo list
> that the user edits should even serve as a way to notify them.
> 
> As far as I can tell, the fact that merge-based and interactive-based
> rebases stop on commits with empty commit messages is solely a by-product
> of having been based on git-commit.  It went without notice for a long
> time precisely because such cases are rare.  The rareness of this
> situation made it difficult to reason about, so when folks did eventually
> notice this behavior, they assumed it was there for a good reason and just
> added an --allow-empty-message flag.  In my opinion, stopping on such
> messages not desirable in any of these cases, even the (explicitly)
> interactive case.

It is desired, and for a very good reason.

Let's suppose you start an interactive rebase, choose a commit to
squash, save the instruction sheet, rebase fires up your editor, and
then you notice that you mistakenly chose the wrong commit to squash.
What do you do, how do you abort?

Before this patch you could clear the commit message, exit the editor,
and then rebase would say "Aborting commit due to empty commit
message.", and you get to run 'git rebase --abort', and start over.

But with this patch?  I don't know...  Just saving the commit message
as is would let rebase continue and create a bunch of unnecessary
objects, and then you would have to use the reflog to return to the
pre-rebase state.


> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> 
> My commit messsage seems like one of those things that someone else will
> instantly see how to shrink to less than a quarter of its size while still
> retaining all essential reasoning.  I can't seem to find the simple way to
> state it, though.
> 
>  Documentation/git-rebase.txt  | 10 ----------
>  git-rebase.sh                 |  2 +-
>  t/t3404-rebase-interactive.sh |  7 ++++---
>  t/t3405-rebase-malformed.sh   | 11 +++--------
>  4 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index a67df4caba..9e136ee16e 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -563,16 +563,6 @@ BEHAVIORAL DIFFERENCES
>      The `--keep-empty` option exists for interactive rebases to allow
>      it to keep commits that started empty.
>  
> -  * empty commit messages:
> -
> -    am-based rebase will silently apply commits with empty commit
> -    messages.
> -
> -    merge-based and interactive-based rebases will by default halt
> -    on any such commits.  The `--allow-empty-message` option exists to
> -    allow interactive-based rebases to apply such commits without
> -    halting.
> -
>    * directory rename detection:
>  
>      merge-based and interactive-based rebases work fine with
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 18ac8226c4..031dbd2ec8 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -95,7 +95,7 @@ rebase_cousins=
>  preserve_merges=
>  autosquash=
>  keep_empty=
> -allow_empty_message=
> +allow_empty_message=--allow-empty-message
>  signoff=
>  test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
>  case "$(git config --bool commit.gpgsign)" in
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 352a52e59d..81ce9fe7f9 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -553,15 +553,16 @@ test_expect_success '--continue tries to commit, even for "edit"' '
>  '
>  
>  test_expect_success 'aborted --continue does not squash commits after "edit"' '
> +	test_when_finished "git rebase --abort" &&
>  	old=$(git rev-parse HEAD) &&
>  	test_tick &&
>  	set_fake_editor &&
>  	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>  	echo "edited again" > file7 &&
>  	git add file7 &&
> -	test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue &&
> -	test $old = $(git rev-parse HEAD) &&
> -	git rebase --abort
> +	echo all the things >>conflict &&
> +	test_must_fail git rebase --continue &&
> +	test $old = $(git rev-parse HEAD)
>  '
>  
>  test_expect_success 'auto-amend only edited commits after "edit"' '
> diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
> index cb7c6de84a..da94dddc86 100755
> --- a/t/t3405-rebase-malformed.sh
> +++ b/t/t3405-rebase-malformed.sh
> @@ -77,19 +77,14 @@ test_expect_success 'rebase commit with diff in message' '
>  '
>  
>  test_expect_success 'rebase -m commit with empty message' '
> -	test_must_fail git rebase -m master empty-message-merge &&
> -	git rebase --abort &&
> -	git rebase -m --allow-empty-message master empty-message-merge
> +	git rebase -m master empty-message-merge
>  '
>  
>  test_expect_success 'rebase -i commit with empty message' '
>  	git checkout diff-in-message &&
>  	set_fake_editor &&
> -	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
> -		git rebase -i HEAD^ &&
> -	git rebase --abort &&
> -	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
> -		git rebase -i --allow-empty-message HEAD^
> +	env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
> +		git rebase -i HEAD^
>  '
>  
>  test_done
> -- 
> 2.18.0.9.g431b2c36d5
> 
