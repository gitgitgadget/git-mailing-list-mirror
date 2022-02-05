Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D92C433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 00:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355169AbiBEAy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiBEAy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 19:54:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8DC06109E
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 16:54:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id eg42so782006edb.7
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+Dnp8KQcJsQLi7yyrbXxHX07q0vlQPBa0w4cERBnvM=;
        b=bGxXkfW/U7WbHUIsd0YgSVa23MLwcMFQXfSCNQ7eYjI+bk99A+L925obY55KJdmHIZ
         39eCL+MBeOG5rnAvw3DUblsw1E+kign7lGnKjs5GsONfdfJ/eo8Uli7cKsZdVdc38iK4
         ks5rN2Ub8fu8LLagxauyChnRxmtQwsBD+SKc5XAEjMUkWXkfrDCUN9K2mo0wZXoO0vWB
         h2hDW1dR8v4yitaJXmpumaomhvu6+Qs+H2oCLvejqcQzg5mEr+IDjfM6I3z1XfZtTqCS
         +G1toaMILhQ8kxc680Gr0fUBKIiqPw5/2sRnJU7UWKQLqqimUJ1CyLwtcRoLA08VT1qu
         VPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+Dnp8KQcJsQLi7yyrbXxHX07q0vlQPBa0w4cERBnvM=;
        b=p+cMvmEODsAFOYLgT1DpwI29XQUwO4DFVVgmjNoBMk1A3MLKE7PYvP/OpBt4A7LnlX
         83x5Dkp5xcxH869ZDAJo84gzwTmxANhbmk8L5sOsHffyrR4dNBtKurIpDR9ugIq2+UDq
         AY51EJXd4SdlPypw6vWDAsP6SlYLreEJkstGkwQLvf2v7XwasqGWK0h+qwq6WVcnrPOG
         gJt5sb58Pvy1EKfa8PyK4wiXLkBpqjC/XRRBxCC7gjluyZJEjoRddasy/3uQTLLA2jwp
         rRZwHT4wg4mLrMbTOfNJoko74R0Ao2/vA/Jmf8X+S93neqILnyOHvoyb6lHgZSIPriOz
         0tdA==
X-Gm-Message-State: AOAM530PKPvomh+yUnCDJ09PnI7eHha6E1jpa5yb7+FjAOXyC24KxiEd
        d6dlOoodwar0cLN6JB9ztQCFYoRaUjqA0iTnEP1jw3RJ05Q=
X-Google-Smtp-Source: ABdhPJymBzjTBZx2aebtyUDRYf2mV2ktjyTPhLioh9KWsdmC0K+V2S5heKx6BpS9qsKLns1yP0s/Z+zvlf8uSLVjbS4=
X-Received: by 2002:a05:6402:424a:: with SMTP id g10mr1879101edb.309.1644022494811;
 Fri, 04 Feb 2022 16:54:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Feb 2022 16:54:43 -0800
Message-ID: <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 4, 2022 at 3:10 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sat, 29 Jan 2022, Elijah Newren wrote:
>
> > On Sat, Jan 29, 2022 at 12:23 AM Johannes Sixt <j6t@kdbg.org> wrote:
> > >
> > > Just a heckling from the peanut gallery...
> > >
> > > Am 29.01.22 um 07:08 schrieb Elijah Newren:
> > > > On Fri, Jan 28, 2022 at 8:55 AM Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > >> Meaning: Even if stage 3 is missing from the first conflict and stage 1 is
> > > >> missing from the second conflict, in the output we would see stages 1, 2,
> > > >> 2, 3, i.e. a duplicate stage 2, signifying that we're talking about two
> > > >> different conflicts.
> > > >
> > > > I don't understand why you're fixating on the stage here.  Why would
> > > > you want to group all the stage 2s together, count them up, and then
> > > > determine there are N conflicting files because there are N stage 2's?
> > >
> > > Looks like you are misunderstanding Dscho's point: When you have two
> > > conflicts, the first with stages 1 and 2, the second with stages 2 and
> > > 3, then the 2s occur lumped together when the 4 lines are printed in a
> > > row, and that is the cue to the parser where the new conflict begins.
> > > Dscho did not mean that all N 2s of should be listed together.
> >
> > Ah, so...I didn't understand his misunderstanding?  Using stages as a
> > cue to the parser where the new conflict begins is broken; you should
> > instead check for when the filename listed on a line does not match
> > the filename on the previous line.
>
> But that would break down in case of rename/rename conflicts, right?
>
> > In particular, if one conflict has stages 1 and 2, and the next conflict
> > has only stage 3, then looking at stages only might cause you to
> > accidentally lump unrelated conflicts together.
>
> Precisely. That's why I would love to have a way to deviate from the
> output of `ls-files -u`'s format, and have a reliable way to indicate
> stages that belong to the same merge conflict.

Ah, attempting to somehow identify and present logical separate
conflicts?  That could be awesome, but I'm not sure it's technically
possible.  It certainly isn't with today's merge-ort.

Let me ask some questions first...

If I understand you correctly then in the event of a rename/rename,
i.e. foo->bar & foo->baz, then you want foo's, bar's, & baz's stages
all listed together.  Right?  And in some way that you can identify
them as related?

If we do so, how do we mark the beginning and the end of what you call
"the same merge conflict"?  If you say it's always 3 stages (with the
possibility of all-zero modes/oids), then what about the rename/rename
case above modified so that the side that did foo->baz also added a
different 'bar'?  That'd be 4 non-zero modes/oids, all of them
relevant.  Or what if the side that did foo->bar also renamed
something else to 'baz', giving us even more non-zero stages for these
three paths?  Perhaps you consider these different conflicts and want
them listed separately -- if so, where does one conflict begin and
another start and which stages are parts of which conflict?

If you are attempting to somehow present the stuff that "belongs to
the same merge conflict" are you also trying to identify what kind of
merge conflict it is?  If so, do you want each type of merge conflict
listed?  For example, let's switch from the example above of logically
disjoint paths coming together to result in more than 3 stages, and
instead pick an example with a single logical path with less than
three stages.  And now let's say that path has multiple conflicts
associated with it; let's use an example with 3: rename/delete +
modify/delete + directory/file (one side renames foo->bar while
modifying the contents, the other side deletes foo and adds the
directory 'bar/').  In this case, there is a target file 'bar' that
has two non-zero modes/oids in the ls-files-u output.  If all three
types of conflicts need to be listed, does each need to be listed with
the two non-zero modes/oids (and perhaps one zero mode/oid), resulting
in six listings for 'bar'?  Or would the duplication be confusing
enough that we instead decide to list some merge conflicts with no
stages associated with them?

Thinking about both sets of questions in the last two paragraphs from
a higher level -- should we focus on and group the higher order stages
by the individual conflicts that happen, or should we group them by
the paths that they happen to (which is what `ls-files -u` happens to
do), or should we not bother grouping them and instead duplicate the
higher order stages for each logical conflict it is part of?

As an alternative to duplicating higher order stages, do we sometimes
decide to "lump" separate conflicts together and treat them as one
conflict?  If so, what are the rules on how we decide to lump
conflicts and when not to?  Is there a bright line boundary?  And can
it be done without sucking in arbitrarily more stages for a single
conflict?


Some testcases that might be useful while considering the above
questions: take a look at the "rad", "rrdd", and "mod6" tests of
t6422.  How many "same merge conflicts" are there for each of those,
and what's the boundary between them?  And can you give the answer in
the form of rules that generically handle all cases, rather than just
answering these three specific cases?


I've thought about this problem long and hard before (in part because
of some conversations I had with Edward Thompson about libgit2 and
merging at Git Merge 2020).  It wasn't at all clear to me that libgit2
had considered anything beyond simple rename cases.  The only rules I
ever figured out that made sense to me was "group the stages by target
filename rather than by logical conflict" (so we get `ls -files -u`
populated) and print a meant-for-human message for each logical
conflict (found in the <Informational Messages> section for
merge-tree), and make NO attempt to connect stages by conflict type.

I'm sure that's not what you wanted to hear, and maybe doesn't even
play nicely with your design.  But short of ignoring the edge and
corner cases, I don't see how to solve that problem.  If you do just
want to ignore edge and corner cases, then just ignore the
rename/rename case you brought up in the first place and just use
`ls-files -u`-type output as-is within your design.  If you don't want
to ignore edge cases and want something that works with a specific
design that somehow groups conflicted file stages by conflict type,
then we're going to have to dig into all these questions above and do
some big replumbing within merge-ort.
