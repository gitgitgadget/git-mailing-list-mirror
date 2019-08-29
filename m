Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915BF1F4B7
	for <e@80x24.org>; Thu, 29 Aug 2019 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH2SLK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 14:11:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34547 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfH2SLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 14:11:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so4425042wrn.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 11:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/deO8yyDwgtjG5l0swVJgp0GVhlmIl1NCnBuhHBSjik=;
        b=VwBLW7YqolFr3AXc3WrkCawFoAEaeoKWLSH6UjPQTknVh26CFk0McOjEKqWw8wkZ50
         BM2+PrFsEOm97g3Z/fRRlf9+yjQJfBxi5lwaSaNRLKTl2O2sOZ8mXwoBA5eNTmTzGSus
         ei0JmV0FKGQ9Qmzpbg4hDW9caDwaY7n3+bQZuE+kfOjFIGjqTE8XG8Xalf/FnXrRm+sy
         RImGOtp/SnT8t6kG65ymHxfJLZxeCZyguLlvHzsfrRUOsSyTRqcbCS76dUpiZXdNz0Pd
         aYSgi//7EwxtQ/gHQVVYJUGf/vYDTcvs9LfwuSysP+rFVZEkNev1cWEIedoFMyCuqLBv
         o4kg==
X-Gm-Message-State: APjAAAV+6HSCL9lT5IqROyMOv89KI8ynXKBqk6pA3M8U6wqdzYUPaPKB
        Cvf4pKmc+ZHz8t0+mTq9RP3EEVMMBMucr4mW8tM=
X-Google-Smtp-Source: APXvYqyptqHkk7WNTBvWMjPTwWj+5ltfbXzyBJbPXBSs3fFuztiYdwZizUJ0PBaMuL0M3vi7RfbX44qCZkfo64lE9fw=
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr9988982wrw.53.1567102267078;
 Thu, 29 Aug 2019 11:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190828002210.8862-1-newren@gmail.com> <20190829000657.26415-1-newren@gmail.com>
 <20190829000657.26415-4-newren@gmail.com>
In-Reply-To: <20190829000657.26415-4-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Aug 2019 14:10:55 -0400
Message-ID: <CAPig+cQ-E8J9WfH96GKt5j0gb0s0XL5jC3AKyvJK36rpAvucmw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Recommend git-filter-repo instead of git-filter-branch
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 8:07 PM Elijah Newren <newren@gmail.com> wrote:
> filter-branch suffers from a deluge of disguised dangers that disfigure
> history rewrites (i.e. deviate from the deliberate changes). [...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> @@ -16,6 +16,22 @@ SYNOPSIS
> +WARNING
> +-------
> +'git filter-branch' has a plethora of pitfalls that can produce non-obvious
> +manglings of the intended history rewrite (and can leave you with little
> +time to investigate such problems since it has such abysmal performance).
> +These safety and performance issues cannot be backward compatibly fixed and
> +as such, its use is not recommended.  Please use an alternative history
> +filtering tool such as https://github.com/newren/git-filter-repo/[git
> +filter-repo].  If you still need to use 'git filter-branch', please
> +carefully read <<SAFETY>> (and <<PERFORMANCE>>) to learn about the land
> +mines of filter-branch, and then vigilantly avoid as many of the hazards
> +listed there as reasonably possible.
> +
> +https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
> +the land mines of filter-branch]

This stray link looks like leftover gunk from the previous revision.

> +PERFORMANCE
> +-----------
> +
> +The performance of filter-branch is glacially slow; its design makes it

The rest of this document spells it git-filter-branch or 'git
filter-branch', not plain filter-branch.

> +* In editing files, git-filter-branch by design checks out each and
> +every commit as it existed in the original repo.  If your repo has 10\^5
> +files and 10\^5 commits, but each commit only modifies 5 files, then
> +git-filter-branch will make you do 10\^10 modifications, despite only
> +having (at most) 5*10^5 unique blobs.
> +
> +* If you try and cheat and try to make filter-branch only work on
> +files modified in a commit, then two things happen

s/filter-branch/git-&/

> +
> +  . you run into problems with deletions whenever the user is simply
> +    trying to rename files (because attempting to delete files that
> +    don't exist looks like a no-op; it takes some chicanery to remap
> +    deletes across file renames when the renames happen via arbitrary
> +    user-provided shell)
> +
> +  . even if you succeed at the map-deletes-for-renames chicanery, you
> +    still technically violate backward compatibility because users are
> +    allowed to filter files in ways that depend upon topology of commits
> +    instead of filtering solely based on file contents or names (though
> +    I have never seen any user ever do this).

Maybe avoid first-person:

    ... contents or names (though this has not been observed in
    the wild).

> +* filter-branch is written in shell, which is kind of slow.  Naturally,
> +it makes sense to want to rewrite that in some other language.  However,
> +filter-branch documentation states that several additional shell
> +functions are provided for users to call, e.g. 'map', 'skip_commit',
> +'git_commit_non_empty_tree'.  If filter-branch itself isn't a shell
> +script, then in order to make those shell functions available to the
> +users' shell snippets you have to prepend the shell definitions of these
> +functions to every one of the users' shell snippets and thus make these
> +special shell functions be parsed with each and every commit.
> +
> +* filter-branch provides a --setup option which is a shell snippet that
> +can be sourced to make shell functions and variables available to all
> +other filters.  If filter-branch is a shell script, it can simply eval
> +this shell snippet once at the beginning.  If you try to fix performance
> +by making filter-branch not be a shell script, then you have to prepend
> +the setup shell snippet to all other filters and parse it with every
> +single commit.

Even though they made sense in the context of the original email
message, these two bullet points may not belong in the man page since
someone reading the man page is doing so to learn about
git-filter-branch usage, not because he or she is thinking about
re-implementing it. It might make sense, however, to collapse these
points to some general statement about shell being slow and process
startup being costly.

Also, these bullet points and others below need a  s/filter-branch/git-&/.

> +* filter-branch writes lots of files to $workdir/../map/ to keep a

Should that path have three dots "..." instead of two ".."?

> +mapping of commits, which it uses pruning commits and remapping to
> +ancestors and the map() command more generally.  Other files like
> +$tempdir/backup-refs, $tempdir/raw-refs, $tempdir/heads,
> +$tempdir/tree-state are all created internally too.  It is possible
> +(though strongly discouraged) that users could have accessed any of
> +these directly.  Users even had a pointer to follow in the form of
> +Documentation that the 'map' command existed, which naturally uses the
> +$workdir/../map/* files.  So, even if you don't have to edit files, for
> +strict backward compatibility you need to still write a bunch of files
> +to disk somewhere and keep them updated for every commit.  You can claim
> +it was an implementation detail that users should not have depended
> +upon, but the truth is they've had a decade where they could so.  So, if
> +you want full compatibility, it has to be there.  Besides, the
> +regression tests depend on at least one of these details, specifying an
> +--index-filter that reaches down and grabs backup-refs from $tempdir,
> +and thus provides resourceful users who do google searches an example
> +that there are files there for them to read and grab and use.  (And if
> +you want to pass the existing regression tests, you have to at least put
> +the backup-refs file there even if it's irrelevant to your
> +implementation otherwise.)

As with the earlier comment, this bullet point is aimed at someone
thinking about re-implementing the command; it sounds out of place in
the "Performance" section of the man page. However, it does make sense
to mention all the files git-filter-branch creates since that can have
an impact on performance. So, perhaps this section can be collapsed so
it just talks about that.

> +All of that said, performance of filter-branch could be improved by
> +reimplementing it in a non-shell language and taking a couple small
> +liberties with backward compatibility (such as having it only run
> +filters on files changed within each commit).  filter-repo provides a
> +demo script named
> +https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely]
> +which does exactly that and which passes all the git-filter-branch
> +regression tests.  It's much faster than git-filter-branch, though it
> +suffers from all the same safety issues as git-filter-branch, and is
> +still glacially slow compared to
> +https://github.com/newren/git-filter-repo/[git filter-repo].

This paragraph could be collapsed to say merely that, for those with
existing tooling relying upon git-filter-branch, filter-repo's
"filter-lamely" provides a drop-in replacement with somewhat improved
performance and a few caveats.

Taking the above comments into consideration, here is a possible
rewrite of the final three bullet points and the closing paragraph:

    * filter-branch is written in shell, which is kind of slow, and it
      potentially can run many other commands which can slow down its
      operation significantly, especially on platforms for which
      process startup is costly.

    * filter-branch writes lots of files to $workdir/.../map/ to keep
      a mapping of commits, which it uses for pruning commits and
      remapping to ancestors and for the map() command more generally.
      Other files like $tempdir/backup-refs, $tempdir/raw-refs,
      $tempdir/heads, $tempdir/tree-state are created internally too.
      Such file creation can be costly in general, but especially on
      platforms with slow filesystems.

    The tool https://github.com/newren/git-filter-repo/[git
    filter-repo] is an alternative to git-filter-branch which does not
    suffer from these performance problems or the safety problems
    (mentioned below). For those with existing tooling which relies
    upon git-filter-branch, 'git repo-filter' also provides
    https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
    a drop-in git-filter-branch replacement (with a few caveats).

> +SAFETY
> +------
> +
> +* Non-ascii filenames (which are rare) can be silently removed despite

Perhaps drop "(which are rare)" to make this sound more formal and
less like an email message.

Comment below also are intended to make the prose sound a bit more formal.

> +being in a desired directory.  The desire to select paths to keep often
> +use pipelines like `git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.
> +ls-files will only quote filenames if needed so folks may not notice

s/ls-files/git-&/

> +that one of the files didn't match the regex, again until it's much too
> +late.  Yes, someone who knows about core.quotePath can avoid this
> +(unless they have other special characters like \t, \n, or "), and
> +people who use ls-files -z with something other than grep can avoid
> +this, but that doesn't mean they will.
> +
> +* It's far too easy to accidentally mix up old and new history.  It's
> +still possible with any tool, but filter-branch almost invites it.  If
> +we're lucky, the only downside is users getting frustrated that they

s/we're//

> +don't know how to shrink their repo and remove the old stuff.  If we're

s/we're//

> +unlucky, they merge old and new history and end up with multiple
> +"copies" of each commit, some of which have unwanted or sensitive files
> +and others which don't.  This comes about in multiple different ways:
> +
> +  ** the default to only doing a partial history rewrite ('--all' is not
> +     the default and over 80% of the examples in the manpage don't use
> +     it)

Maybe just shorten this to:

   ('--all is not the default, and few examples show it)

> +  ** the fact that there's no automatic post-run cleanup
> +
> +  ** the fact that --tag-name-filter (when used to rename tags) doesn't
> +     remove the old tags but just adds new ones with the new name (this
> +     manpage has documented this for a long time so it's presumably not
> +     a "bug" even though it feels like it)

Perhaps drop the final parenthetical comment.

> +  ** the fact that little educational information is provided to inform
> +     users of the ramifications of a rewrite and how to avoid mixing old
> +     and new history.  For example, this man page discusses how users
> +     need to understand that they need to rebase their changes for all
> +     their branches on top of new history (or delete and reclone), but
> +     that's only one of multiple concerns to consider.  See the
> +     "DISCUSSION" section of the git filter-repo manual page for more
> +     details.
> +
> +* Annotated tags can be accidentally converted to lightweight tags, due
> +to either of two issues:
> +
> +  . Someone can do a history rewrite, realize they messed up, restore
> +    from the backups in refs/original/, and then redo their
> +    filter-branch command.  (The backup in refs/original/ is not a real
> +    backup; it dereferences tags first.)
> +
> +  . Running filter-branch with either --tags or --all in your <rev-list
> +    options>.  In order to retain annotated tags as annotated, you must
> +    use --tag-name-filter (and must not have restored from
> +    refs/original/ in a previously botched rewrite).

Should these bullet points use "**" rather than "."?

> +* Any commit messages that specify an encoding will become corrupted
> +by the rewrite; filter-branch ignores the encoding, takes the original
> +bytes, and feeds it to commit-tree without telling it the proper
> +encoding.  (This happens whether or not --msg-filter is used, though I
> +suspect --msg-filter provides additional ways to really mess things
> +up).

Perhaps shorten simply to:

    (This happens whether or not --msg-filter is used.)

> +* If the user provides a --tag-name-filter that maps multiple tags to
> +the same name, no warning or error is provided; filter-branch simply
> +overwrites each tag in some undocumented pre-defined order resulting in
> +only one tag at the end.  If you try to "fix" this bug in filter-branch
> +and make it error out and warn the user instead, one of the
> +filter-branch regression tests will fail.  (So, if you are trying to
> +make a backward compatible reimplementation you have to add extra code
> +to detect collisions and make sure that only the lexicographically last
> +one is rewritten to avoid fast-import from seeing both since fast-import
> +will naturally do the sane thing and error out if told to write the same
> +tag more than once.)

Maybe drop everything from "If you try to 'fix'..." to the end of paragraph.

> +Also, the poor performance of filter-branch often leads to safety issues:
> +
> +* Coming up with the correct shell snippet to do the filtering you want
> +is sometimes difficult unless you're just doing a trivial modification
> +such as deleting a couple files.  People have often come to me for help,
> +so I should be practiced and an expert, but even for fairly simple cases
> +I still sometimes take over 10 minutes and several iterations to get
> +the right commands -- and that's assuming they are working on a tiny
> +repository.  Unfortunately, people often learn if the snippet is right
> +or wrong by trying it out, but the rightness or wrongness can vary
> +depending on special circumstances (spaces in filenames, non-ascii
> +filenames, funny author names or emails, invalid timezones, presence of
> +grafts or replace objects, etc.), meaning they may have to wait a long
> +time, hit an error, then restart.  The performance of filter-branch is
> +so bad that this cycle is painful, reducing the time available to
> +carefully re-check (to say nothing about what it does to the patience of
> +the person doing the rewrite even if they do technically have more time
> +available).  This problem is extra compounded because errors from broken
> +filters may not be shown for a long time and/or get lost in a sea of
> +output.  Even worse, broken filters often just result in silent
> +incorrect rewrites.

Drop the "People have often come to me..." sentence from this paragraph.
