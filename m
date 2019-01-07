Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2EE1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 23:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfAGXNG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 18:13:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38996 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXNG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 18:13:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so2487588wmd.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 15:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Qjb7C4pdER7S6zQs16qikIuupRcdqWeszmsT2ga2Rgw=;
        b=LdfPMt2rPlwLiCwfKg8+vVF10PlSSXqgHLq3m3WXYc+v+MUJ5KQcwzewm6kVgnNkwO
         vzq4tQfHDgJQ1Z47sTEsc7nueimiSiN+u1lGqWQvjzmIeRyFVJq7gKTAVHRsDErrI4Kb
         mIsVQL/QpgsPfblefBAKqOsiVPVHZKVjgo0/prj9gJGmW3D6/lZYb+wwAUEkAzg2nB4k
         vOWKikVqB8FKr+WUxaguJmHxJdg2tJqYX0wNdwlGWGXnNbjpR7DOYlz2wtD2s1IdVgnd
         mSld5+kGXfWkNQVTZHSeyW77tyO1CJRr+6rAc0k3ZjqusrUoB3rMClOws7fW5njGWpJg
         SzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Qjb7C4pdER7S6zQs16qikIuupRcdqWeszmsT2ga2Rgw=;
        b=Cce23TguW8/ydykWZ1S0fIpyYOwwgwbfbu8JoRDR3DDTmPFiJDB9jc8QESZhEkqP+/
         tg6IRhtVn86u1PVHP/OHi5jDsh7uBoCZ/5rKbciimeRJZwQHhGZz9vD6BcajAVBJuqK6
         xqGDsClyXOM4e+27BTO1Zk6oYn98LE2ye6c3/3pyHeRYZCKklZl8WXCkXQrwlWPfL9DL
         QIKQ6gwWN607g4Sa/OIyH9D160FS2wvtWdfFq1iZWlg/Pqj6yrJRXi7dZ1p0chck4Bhk
         aB0IT3kIQmxaC81i014c/ZbpC2/+jN3jHSOygB4FURVWaQAb/zohzsb1ofWOcyQs7Z2X
         PcKw==
X-Gm-Message-State: AJcUukcE+2c19ll35bgzLNc/cinMdlxUaMHR03QFSjRrlEggjrv8mCMG
        p3X83WEda6ZCXI3trpUEx1I=
X-Google-Smtp-Source: ALg8bN6j8u5gdxlbKAU6BiKN0d738B0+VHDKDk6YG/K/nfG5Gkm5kUOphauPg65KHWzAx9pHFjeFsQ==
X-Received: by 2002:a1c:aad2:: with SMTP id t201mr9639297wme.148.1546902783403;
        Mon, 07 Jan 2019 15:13:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k3sm90432310wrm.7.2019.01.07.15.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 15:13:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
References: <20190107213013.231514-1-brho@google.com>
Date:   Mon, 07 Jan 2019 15:13:02 -0800
In-Reply-To: <20190107213013.231514-1-brho@google.com> (Barret Rhoden's
        message of "Mon, 7 Jan 2019 16:30:12 -0500")
Message-ID: <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> Commits that make formatting changes or renames are often not
> interesting when blaming a file.  This commit, similar to
> git-hyper-blame, allows one to specify certain revisions to ignore during
> the blame process.
>
> To ignore a revision, put its committish in a file specified by
> --ignore-file=<file> or use -i <rev>, which can be repeated.

If I read it correctly, this gives a very limited form of -S, in the
sense that anything this can do can be expressed by using -S but the
reverse is not true, but is designed to be easier to use, in the
sense that unlike -S, this does not have to describe the part of the
history you do not have to lie about.  The documentation should say
something about these pros-and-cons to help readers decide which
feature to use.

I somehow feel that this is rare enough that it should not squat on
short-and-sweet '-i'.  We would want to reserve it to something like
"--ignore-case", for example.

> The file .git-blame-ignore-revs is checked by default.

Giving the projects a way to easily help participants to share the
same distorted view of the history is a good idea, but I do not
think we should allow projects to do so to those who merely clone it
without their consent.  IOW, "by default" is a terrible idea.

Perhaps paying attention to blame.skipRevsFile configuration
variable that is set by the end user would be sufficient----the
project can ship .blame-skip-revs (or any random filename of their
choice) in-tree as tracked contents and tell its users that they can
optionally use it.

> It's useful to be alerted to the presence of an ignored commit in the
> history of a line.  Those lines will be marked with '*' in the
> non-porcelain output.  The '*' is attached to the line number to keep
> from breaking tools that rely on the whitespace between columns.

A policy decision like the above two shouldn't be hardcoded in the
feature like this, but should be done as a separate option.  By
default, these shouldn't be marked with '*', as the same tools you
said you are afraid of breaking would be expecting a word with only
digits and no asterisk in the column where line numbers appear and
will get broken by this change if done unconditionally.

In general, I find this patch trying to change too many things at
the same time, without sufficient justification.  Perhaps do these
different things as separate steps in a single series?

> A blame_entry attributed to an ignored commit will get passed to its
> parent.

Obviously, an interesting consideration is what happens when a merge
commit is skipped.  Is it sufficient to change this description to
"...will get passed to its parentS", or would the code do completely
nonsensical things without further tweaks (a possible simple tweak
could be to refuse skipping merges)?

> If an ignored commit changed a line, an ancestor that changed
> the line will get blamed.  However, if an ignored commit added lines, a
> commit changing a nearby line may get blamed.  If no commit is found,
> the original commit for the file will get blamed.

The above somehow does not read as describing a carefully designed
behaviour; rather, it sounds as if it is saying "the code does
whatever random things it happens to do".  For example, when there
is a newly added line how is "A" commit changing a nearby line
chosen (a line has lines before it and after it---they may be
touched by different commits, and before and after that skipped
commit, so there are multiple commits to choose from)?

> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index 16323eb80e31..e41375374892 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  [verse]
>  'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
>  	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
> +	    [-i <rev>] [--no-default-ignores] [--ignore-file=<file>]
>  	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
>  	    [--] <file>
>  
> @@ -84,6 +85,20 @@ include::blame-options.txt[]
>  	Ignore whitespace when comparing the parent's version and
>  	the child's to find where the lines came from.
>  
> +-i <rev>::
> +	Ignore revision when assigning blame.  Lines that were changed by an
> +	ignored commit will be marked with a `*` in the blame output.  Lines
> +	that were added by an ignored commit may be attributed commits making
> +	nearby changes or to the first commit touching the file.

It probably deserves to be told that this option can be given
multiple times and used cumulatively (unlike usual "last one wins"
rule).

> +--no-default-ignores::
> +	Do not automatically ignore revisions in the file
> +	`.git-blame-ignore-revs`.

This should not be "opt-out" like this.

> +--ignore-file=<file>::
> +	Ignore revisions listed in `file`, one revision per line.  Whitespace
> +	and comments beginning with `#` are ignored.

Should it be capable to take two or more ignore-files?  Or should we
use the usual "the last one wins" rule?

I think we should support blame.skipRevFile configuration variable
so that the users do not have to constantly give the option from the
command line.  And with that, there is no need to have a hardcoded
filename .git-blame-ignore-revs or anything like that.

If we are to use configuration variable, however, we'd need a way to
override its use from the command line, too.  Perhaps a sane
arrangement would be

    - if one or more --skip-revs-file=<file> are given from the
      command line, use all of them and ignore blame.skipRevsFile
      configuration variable.

    - if no --skip-revs-file=<file> is given from the command line,
      use blame.skipRevsFile configuration variable.

    - regardless of the above two, pay attention to --skip-rev=<rev>
      command line option(s).


Somehow the damage to blame.c codebase looks way too noisy for what
the code wants to do.  If all we want is to pretend in a history,
e.g.

    ---O---A---B---C---D

that commit B does not exist, i.e. use a distorted view of the
history

    ---O---A-------C---D

wouldn't it be sufficient to modify pass_blame(), i.e. the only the
caller of the pass_blame_to_parent(), where we find the parent
commits of "C" and dig the history to pass blame to "B", and have it
pretend as if "B" does not exist and pass blame directly to "A"?

Thanks.  I am personally not all that interested in this yet.
