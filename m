Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4FE1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfAHQ1r (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:27:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39542 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbfAHQ1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:27:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so2126447pld.6
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOKqZP/bQn9QqQnfQIpYhWa5iu4bGaGRuIdU3shIBp8=;
        b=LuUQnbQwM4Cl5Bk70veY+0aJ6UkRfJ1Jq9QuNDb3qhVNeUznc30J68vVC/LimXfhzZ
         ZekEksW09jlb6cGDwFGjSX00/YNajYfaQEMnvZHkjEap0vCA6P2Ke5fawhsL1xNBuWaN
         +C441ZjIgojqbQskpMVbbRAo7YpbU5RKxyVKed4HFfX1OtmJhvqNZE10jwHHvyXVS+Zu
         Be5j07RBmoun+hJnXMdokLSpaObaKVrd+86XBrNwaS/j99HFZ6ypyU6iRLQIBmLk2utq
         DLFG9NAA2WlPtiCSclyU1x/OUS4TCxe21lN6hhgCxjChMRPAP+wg+8zGgvU/PZQelREo
         ERqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOKqZP/bQn9QqQnfQIpYhWa5iu4bGaGRuIdU3shIBp8=;
        b=d7xBvQcLpLqZ8qJttP3Ix/w4uUrqRbx8S8mcU+pBHMY0DOi3//ZWt8eC02VUxNyu6b
         cj7w8kn66kyfyBBHVCdImbolqbKOEmStYI+5EhdTs5kdBFu2/4NrsoaM+e10YS/uoWIy
         1fNI3URhzdsfVE8dJ+MpU3lXh0pbptnHc91Ypexa8J/mpP/VNF2gTfCNyMRzkX2lLA/a
         NDe18JPgwwUW3+E+1HU2KrELeGtRzWY1Z+knXzSOekwF3+jMrz2GizM6YnwMQ9L6Tba8
         B7+Uu77MejzQyQ03Cfsh1mZ48iGNnd7I03JXnu2J+0kMGIaon+R6x/rn7ibgcer041+Z
         reew==
X-Gm-Message-State: AJcUukeJUScPQqDXjIwDpyylvUQZJamz+EcD9oD4uy7eMAFtDBaZW0Uw
        F4Patws/yyizwSmTw8+slLSJ0A==
X-Google-Smtp-Source: ALg8bN4rNGdy13QrIEB/agDN5Un6iHniKyWkgRo2SnldnRs2APAoc82rylKoXOzfwFtu3RRghiFV4w==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr2333069plk.196.1546964866146;
        Tue, 08 Jan 2019 08:27:46 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id j70sm101403532pfc.43.2019.01.08.08.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 08:27:45 -0800 (PST)
Date:   Tue, 8 Jan 2019 11:27:42 -0500
From:   Barret Rhoden <brho@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
Message-ID: <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
In-Reply-To: <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-07 at 15:13 Junio C Hamano <gitster@pobox.com> wrote:
> If I read it correctly, this gives a very limited form of -S, in the
> sense that anything this can do can be expressed by using -S but the
> reverse is not true, but is designed to be easier to use, in the
> sense that unlike -S, this does not have to describe the part of the
> history you do not have to lie about.  The documentation should say
> something about these pros-and-cons to help readers decide which
> feature to use.

Yeah, -S lists the revs to use, this lists the revs to *not* use.  I'll
add a note.

> I somehow feel that this is rare enough that it should not squat on
> short-and-sweet '-i'.  We would want to reserve it to something like
> "--ignore-case", for example.

Can do.  I'll change the interface to your suggestion from down below.

> > The file .git-blame-ignore-revs is checked by default.  
> 
> Giving the projects a way to easily help participants to share the
> same distorted view of the history is a good idea, but I do not
> think we should allow projects to do so to those who merely clone it
> without their consent.  IOW, "by default" is a terrible idea.
> 
> Perhaps paying attention to blame.skipRevsFile configuration
> variable that is set by the end user would be sufficient----the
> project can ship .blame-skip-revs (or any random filename of their
> choice) in-tree as tracked contents and tell its users that they can
> optionally use it.

A blame config option works for me.  I'd like the users/cloners of a
repo to not need to do anything extravagant, but a one-time config
would be fine.

> > It's useful to be alerted to the presence of an ignored commit in the
> > history of a line.  Those lines will be marked with '*' in the
> > non-porcelain output.  The '*' is attached to the line number to keep
> > from breaking tools that rely on the whitespace between columns.  
> 
> A policy decision like the above two shouldn't be hardcoded in the
> feature like this, but should be done as a separate option.  By
> default, these shouldn't be marked with '*', as the same tools you
> said you are afraid of breaking would be expecting a word with only
> digits and no asterisk in the column where line numbers appear and
> will get broken by this change if done unconditionally.

Since users are already opting-in to the blame-ignore, do you also want
them to opt-in to the annotation?  I can make a separate config option
to turn on the annotation.  Any preference for how it is marked?

> In general, I find this patch trying to change too many things at
> the same time, without sufficient justification.  Perhaps do these
> different things as separate steps in a single series?
> 
> > A blame_entry attributed to an ignored commit will get passed to its
> > parent.  
> 
> Obviously, an interesting consideration is what happens when a merge
> commit is skipped.  Is it sufficient to change this description to
> "...will get passed to its parentS", or would the code do completely
> nonsensical things without further tweaks (a possible simple tweak
> could be to refuse skipping merges)?

If we skip a merge commit, it might pick the wrong parent.  For
example, this line was brought in via a merge:

$ ~/src/git/git-blame include/linux/mm.h | grep VM_SYNC
b6fb293f2497a (Jan Kara 2017-11-01 16:36:41 +0100  204) #define VM_SYNC

It's from merge: a3841f94c7ec ("Merge tag 'libnvdimm-for-4.15', and if
we ignore it:

$ ~/src/git/git-blame -i a3841f94c7ecb include/linux/mm.h | grep VM_SYNC
cc2383ec06be0 (Konstantin Khlebnikov 2012-10-08 16:28:37 -0700  204*) #define VM_SYNC

The wrong commit is blamed.

I can put a note in the doc about it and die if we're given a merge
commit.  Is there a convenient helper for detecting a merge, or can I
just check for multiple parents?  (something like commit->parents &&
commit->parents->next)
 
> > If an ignored commit changed a line, an ancestor that changed
> > the line will get blamed.  However, if an ignored commit added lines, a
> > commit changing a nearby line may get blamed.  If no commit is found,
> > the original commit for the file will get blamed.  
> 
> The above somehow does not read as describing a carefully designed
> behaviour; rather, it sounds as if it is saying "the code does
> whatever random things it happens to do".  For example, when there
> is a newly added line how is "A" commit changing a nearby line
> chosen (a line has lines before it and after it---they may be
> touched by different commits, and before and after that skipped
> commit, so there are multiple commits to choose from)?

This was more of a commentary about its behavior.  If you ignore a
commit that added lines, it'd be nice to get a hint of what might have
caused it, and picking a commit that affected an adjacent line seemed
fine.  But yeah, it's not doing anything crazy.

> > diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> > index 16323eb80e31..e41375374892 100644
> > --- a/Documentation/git-blame.txt
> > +++ b/Documentation/git-blame.txt
> > @@ -10,6 +10,7 @@ SYNOPSIS
> >  [verse]
> >  'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
> >  	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
> > +	    [-i <rev>] [--no-default-ignores] [--ignore-file=<file>]
> >  	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
> >  	    [--] <file>
> >  
> > @@ -84,6 +85,20 @@ include::blame-options.txt[]
> >  	Ignore whitespace when comparing the parent's version and
> >  	the child's to find where the lines came from.
> >  
> > +-i <rev>::
> > +	Ignore revision when assigning blame.  Lines that were changed by an
> > +	ignored commit will be marked with a `*` in the blame output.  Lines
> > +	that were added by an ignored commit may be attributed commits making
> > +	nearby changes or to the first commit touching the file.  
> 
> It probably deserves to be told that this option can be given
> multiple times and used cumulatively (unlike usual "last one wins"
> rule).
> 
> > +--no-default-ignores::
> > +	Do not automatically ignore revisions in the file
> > +	`.git-blame-ignore-revs`.  
> 
> This should not be "opt-out" like this.
> 
> > +--ignore-file=<file>::
> > +	Ignore revisions listed in `file`, one revision per line.  Whitespace
> > +	and comments beginning with `#` are ignored.  
> 
> Should it be capable to take two or more ignore-files?  Or should we
> use the usual "the last one wins" rule?
> 
> I think we should support blame.skipRevFile configuration variable
> so that the users do not have to constantly give the option from the
> command line.  And with that, there is no need to have a hardcoded
> filename .git-blame-ignore-revs or anything like that.
> 
> If we are to use configuration variable, however, we'd need a way to
> override its use from the command line, too.  Perhaps a sane
> arrangement would be
> 
>     - if one or more --skip-revs-file=<file> are given from the
>       command line, use all of them and ignore blame.skipRevsFile
>       configuration variable.
> 
>     - if no --skip-revs-file=<file> is given from the command line,
>       use blame.skipRevsFile configuration variable.
> 
>     - regardless of the above two, pay attention to --skip-rev=<rev>
>       command line option(s).

Sounds fine to me.

> Somehow the damage to blame.c codebase looks way too noisy for what
> the code wants to do.  If all we want is to pretend in a history,
> e.g.
> 
>     ---O---A---B---C---D
> 
> that commit B does not exist, i.e. use a distorted view of the
> history
> 
>     ---O---A-------C---D
> 
> wouldn't it be sufficient to modify pass_blame(), i.e. the only the
> caller of the pass_blame_to_parent(), where we find the parent
> commits of "C" and dig the history to pass blame to "B", and have it
> pretend as if "B" does not exist and pass blame directly to "A"?

I originally tried to skip 'B' in pass_blame() when B popped up as a
scapegoat.  That broke the offsets of the blame_entries in the
parent.  By running diff_hunks(), we get the opportunity to adjust the
offsets.  Also, when it comes to marking the blame_entries for marking
the output, we want to know the specific diffs and to break them up at
the boundaries of [tlno,same) in blame_chunk().

> Thanks.  I am personally not all that interested in this yet.

Thanks for taking a look.

Barret

