Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A081F803
	for <e@80x24.org>; Wed,  9 Jan 2019 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfAIUsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 15:48:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34857 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfAIUse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 15:48:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so4221461pfi.2
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6nl1dV7vExAIuJWsSAeybKEz5KKf9TUVw7+F3JRr9o=;
        b=WP+QCHmY2n57ow1Fctu7eiAX5CDB++wHFmcuoV3PscVYbEw2WdLAsjo4yJ1VnVa/Zw
         oOXUvYdJ3I58lGt+cg/kYwQs/Lq50NElMubw8lf0oiY9fmYT743Kda18fMNBOvdD+HJx
         mONdVE+7ivENJTMcOc8CfNp7N6J/Jsims7kVm0SbPFiiWy6wpCziZbqj7Y20HR9Hdbtj
         DaoM4xiTz8XoUMjsc589ah/hU/7wHCfPIgJXCZByxh12FxQBcSe5aiWpVplt6BJdAudY
         nL6X9w0ox6THYDafec9XBf8rDVznBseIOAc1nZjMjD4U+H60qiaj01A5xxvW+VwZFrHJ
         5ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6nl1dV7vExAIuJWsSAeybKEz5KKf9TUVw7+F3JRr9o=;
        b=fY/MPXqDKWj46azvfTcSVUTHTIVNbCdDunsvdcc23aufsIEMGl8ZmLGkiHjNt8jr/c
         KGv/nZ5n8FdHWGXcwipBoqQHPiLlAGNvlBAYNrymO4BtYQjnadXgI+hKCTohLdxdJiw5
         zIKXIFiXE6L0T3mYks2APsRIeqe9xX5jNiVytBA3qYHZJmHWNknvYN96c92o0MY/9bUn
         PnIqFtbOyMMVY5PMIxYppKhu7y00IgUgo0C1eMuEPhknxiw/czFVKm9KrnAR0ei8NObe
         qlY/2A9AyIKZHbcMsarZsasoOejbbwoK+guRJtVbV5g4A1UhkS70dM4Mg+XJOB4Q+qvc
         aGmQ==
X-Gm-Message-State: AJcUukfLCwFDqAKr81clo4ujPM8MQNP+ejJFU4uIxWoAcg7KcGLwD33f
        6LBI2NWXzO/TqiCQGosKgubtVA==
X-Google-Smtp-Source: ALg8bN5kiIL0vBbXG99VviGW+rdttRuP6ruEknjcJ6WcpflyRoJ7uvo27Mz97byYORy/zGM25xLX5g==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr6654172pgs.73.1547066913345;
        Wed, 09 Jan 2019 12:48:33 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id x26sm108094195pfn.50.2019.01.09.12.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 12:48:32 -0800 (PST)
Date:   Wed, 9 Jan 2019 15:48:28 -0500
From:   Barret Rhoden <brho@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
Message-ID: <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com>
In-Reply-To: <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
        <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 2019-01-08 at 10:26 Junio C Hamano <gitster@pobox.com> wrote:
> >> Obviously, an interesting consideration is what happens when a merge
> >> commit is skipped.  Is it sufficient to change this description to
> >> "...will get passed to its parentS", or would the code do completely
> >> nonsensical things without further tweaks (a possible simple tweak
> >> could be to refuse skipping merges)?  
> >
> > If we skip a merge commit, it might pick the wrong parent.  
> 
> Actually after thinking about it a bit more, I no longer think a
> merge is so special.  In this topology (as usual, time flows from
> left to right), if you are skipping M,
> 
>         ---A---M---C---D
>               /
>          ----B
> 
> you'd simply pretend that the ancestry is like this and you'd be
> fine, no?
> 
> 
>         ---A-------C---D
>                   /
>          --------B
> 
> That is, when inspecting C, pass_blame() would enumerate its true
> parents, notice that M to be skipped, which would cause it to
> pretend as if C has M's parents instead of M itself as its parents.
> If M in the true history is the first parent of C, then M's first
> parent in the true history becomes C's first parent, M's second
> parent in the true history becomes C's second parent, etc. (if C
> were a merge in the true history, such a rewriting would make C an
> octopus in the distorted history)
> 
> > The wrong commit is blamed.  
> 
> So... I still suspect that it is merely a bug in your implementation
> and there is nothing inherent that forces us to avoid skipping a
> merge.

Probably!  =)  I tried a bunch of things initially, and might have had
things broken for other reasons.  One reason was not calling
parse_commit() at the right time.

I took another look and had first_scapegoat() scan the parent list, and
for any parent in the list, replace it with its own parent list.  e.g.
when removing 'A':

         ---X---A---B---C
               /
              Y 
              
(B's parent was A, A is the skipped commit, and A has parents X and Y)

becomes:

         ---X---B---C
               /
              Y

But just yanking skipped commits from the scapegoat list doesn't help,
since B gets blamed for the changes made by A, since the file B and
{X,Y} differ, specifically due to the changes A made.  

You'd think that would have worked, since it sounds similar to what -S
revs-file does, but it turns out I want different behavior than -S for
the ignore/skip.  With -S, you blame a nearby commit (at least based on
my testing - what is the desired behavior there?).  With ignore/skip, I
want to blame the last commit that modified the line.

For instance, commit X does this:

-foo(x,y);
+foo(x,y,z);

Then commit Y comes along to reformat it:

-foo(x,y,z);
+foo(x, y, z);

And the history / rev-list for the file looks like:

---O---A---X---B---C---D---Y---E---F

I want to ignore/skip Y and see X in the blame output.  

Sorry that I wasn't clear about that from the beginning; I can see how
one could have different expectations for what happens when a commit is
skipped.

> >> Somehow the damage to blame.c codebase looks way too noisy for what
> >> the code wants to do.  If all we want is to pretend in a history,
> >> e.g.
> >> 
> >>     ---O---A---B---C---D
> >> 
> >> that commit B does not exist, i.e. use a distorted view of the
> >> history
> >> 
> >>     ---O---A-------C---D
> >> 
> >> wouldn't it be sufficient to modify pass_blame(), i.e. the only the
> >> caller of the pass_blame_to_parent(), where we find the parent
> >> commits of "C" and dig the history to pass blame to "B", and have it
> >> pretend as if "B" does not exist and pass blame directly to "A"?  
> >
> > I originally tried to skip 'B' in pass_blame() when B popped up as a
> > scapegoat.  That broke the offsets of the blame_entries in the
> > parent.  
> 
> Why?  When inspecting C in order to exonerate it from as many lines
> as possible, we'd run "git diff $P C" for each parent of C, but in
> the distorted history (i.e. instead of using $P==B, we use $P==A).
> As long as the code reads from "git diff A C", I do not see why "the
> offsets in the parent" can be broken.  Care to elaborate a bit more?

When we run "git diff $P C" with $P == A, the diffs from B (the one we
want to remove) will pop up and be attributed to C.  This is what
happened when I tried the "yank B from the history" approach from
above.  If we ever diff over a skipped commit like that, we'll blame
the wrong one. (C, here).

The first thing I tried was to simply move the blame_entry list from C
to B to A without calling diff_hunks().  That's where the "file offsets
were broken," since e->s_lno should be adjusted when passing an entry
from the target blame_origin to its parent blame_origin.  An example of
this is in blame_chunk() when we hand every blame_entry before tlno to
the parent in the "e->s_lno < tlno" block.

Without diffing commit B, we can't propagate the blame_entries.  And
if we just diff A and C, we'll get the "wrong" commit.

The other reason to run the diffs was to identify and mark the
blame_entry that would have been blamed for the skipped commit.  That's
for the annotations during the output phase.  

If we don't track and taint the blame entries, you could just call
blame_chunk() from blame_chunk_cb() with tlno = same, which in essence
tells the blame code that "this diff belongs to the parent."  But that
loses the blame_entry boundaries, and is almost nearly as much of a
change to blame.c.

When it comes to skipping merges, my existing code couldn't do it, but
I found a way to make it work:

         ---A---M---C---D
               /
       ---X---B

Say the commit changing the line/blame_entry was X, and we try to skip
M.  'A' made no changes to the line.

If B is the first scapegoat, pass_blame_to_parent() will see no diff
between B and M for that line, and the blame will get passed to B, and
we're done.  This is the same both with my change and without.

However, if A is the first scapegoat, the line will have a diff, and
from the perspective of the ---A---M---C graph, it looks like M
introduced the change.  (In fact it did - it was via B though).  The
existing code would keep the blame on M and then check the next
scapegoat: B.  

With my change, it couldn't tell the difference between M introducing
a change that we wanted to skip and M having another parent that
introduced the change.  Both look like a diff from A..M.

I changed my version to handle that case.  In pass_blame(), if it fails
to find a scapegoat in the loop that calls pass_blame_to_parent(),
it'll make another loop through the scapegoats, where it will pass the
blame to the first scapegoat that has a diff.

This way, we get a first attempt to pass the blame for real (e.g. to
B), and then when we failed, we skip the commit.  In other words, we
only skip the commit when we need to.

With that change, from my earlier example:

This was wrong:
$ git-blame --skip-rev a3841f94c7ecb include/linux/mm.h | grep VM_SYNC
cc2383ec06be0 (Konstantin Khlebnikov 2012-10-08 16:28:37 -0700  204*) #define VM_SYNC

This is right:
$ git-blame --skip-rev a3841f94c7ecb include/linux/mm.h | grep VM_SYNC
b6fb293f2497a (Jan Kara              2017-11-01 16:36:41 +0100  204) #define VM_SYNC

Also note that in the 'right' case it didn't annotate it with the *.
That's because we didn't need to ignore the commit.  b6fb29 was the
correct one, and we didn't need to ignore M.

Anyway, thanks for reading and for the feedback.  I'll clean things up
and explain it better in another patchset.

Thanks,

Barret

