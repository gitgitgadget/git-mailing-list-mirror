Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4124C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 00:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347365AbiALAl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 19:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347316AbiALAlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 19:41:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D2C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 16:41:21 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q25so3255755edb.2
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 16:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sfb7pBEu6bm6CUbuVv5Y2yI/9EZEOxxvqA5SNEsgq94=;
        b=YURj1tyoBfTh//KI7GQCWTKXsyxywp6Kx3H77mM8Y7mMn/JjwausmNimhMrxQMvNmC
         qipYLc35OKvVKIOohbqTuEv5Adh38JfKMQeUsHUWzeZl3x/Rw5geTP5tnPtuc0vBgzEA
         LdyiLPvuEOM7aDRQXJEnM6Wyt1/DZ9Yl0+ZnvhPt4D7AqZJV/WM/nJyLw08Q1tn7MKqF
         BxUliScn/zz3Vnh93BH59Ng3bXngDFYiURR/7/pCO5kBeywBGUkmQDHaARC2n8ynIVVT
         Rzw28zzEEdkkcyHn9o/l/h92e3Y0QpM9soxBE+Jt3Py0BSZsxdnJ4nuC/lPMctvxT2SN
         e7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sfb7pBEu6bm6CUbuVv5Y2yI/9EZEOxxvqA5SNEsgq94=;
        b=eT4t7UcpqRXgmd5aaN1fSOvYFrl87IXB0ag3qAGmxHt1OKx0QQuvngG5l1zQHoibtJ
         lLdei3UG44DR0Nzi2DIPrLTYhi4an84n6Pdw6FfXskxuEZTHm9UjVrsmBhoDsXNFSzIK
         3Agc/wvlo1SuziNgxMebv4AcgmojzNdIThNAFjnUMZ7mHng9slQ9yPa/vGc20O7KKI6R
         IbHbE9UMu4a6cae6sHZY3/9a9D/oaUhUtc8SZ/JXxXMILjaQ8MMm6k29g8WG0yz+X/xS
         08SZLSFWuqAzf3LVeIniwu9VgJdS9BFr0htwGtzt5eAoCXkQi+dXncD5ab9tRJAD+tHw
         t/wQ==
X-Gm-Message-State: AOAM530MY721zTgYNewyi17MNXQ8XrecJNadgKRidwd/EvRNTbSN08vm
        DFfb3Tb+Cq2Zv05b5V5RZ/ZKvc7Q3jr8NLFiaxw=
X-Google-Smtp-Source: ABdhPJxiwKkkJN7CUtNkCJVR7HfyiAwX7S9u+deTQFHvsQmHMs09S2p1lE/a4VKp9cyKFnRnGD6R9zqYmVf6y0Erk0g=
X-Received: by 2002:a50:da48:: with SMTP id a8mr6498898edk.146.1641948079476;
 Tue, 11 Jan 2022 16:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201111448140.1081@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201111448140.1081@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Jan 2022 16:41:07 -0800
Message-ID: <CABPp-BGdbh=HM7jA+_RTwSWVcMr_qvEY7RoNXooeBT2NB4Ubzw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Jan 11, 2022 at 2:30 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 10 Jan 2022, Elijah Newren wrote:
>
> > On Mon, Jan 10, 2022 at 5:49 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Fri, 7 Jan 2022, Elijah Newren wrote:
> > >
> > > > On Fri, Jan 7, 2022 at 9:58 AM Christian Couder
> > > > <christian.couder@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jan 5, 2022 at 5:54 PM Elijah Newren <newren@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> > > > > > <christian.couder@gmail.com> wrote:
> > > > >
> > ...
> > >
> > > I _bet_ it needs first and foremost the information "is this
> > > mergeable?".
> > >
> > > That is by far the most common question the code I saw had to answer,
> > > without any follow-up questions asked.
> > >
> > > An add-on question is then "which files/directories conflicted?". And
> > > there, it really only wanted the file names, along with the OIDs of
> > > the respective item in the base, the HEAD and the merge branch.
> >
> > This might be difficult to provide for some cases, e.g.
> > rename/rename(1to2), especially if that conflict gets entangled with any
> > others.  Users would also have difficulty gaining these even using the
> > command line `git merge` (with either recursive or ort) for these cases.
> >
> > Also, does this presume three OIDs?  What about the cases where there
> > are 4 or 6 for a given path?
> >
> > I'm a bit worried about the assumptions underlying this request, and
> > that it might not be satisfiable in general depending on what those
> > assumptions are.
>
> Well, that request is driven by the reality of a web UI.
>
> You cannot reasonably resolve just any merge conflict in a web UI. But you
> can easily resolve a trivial content conflict in, say, a README file,
> without opening a console window, cloning the repository, starting an
> editor, then saving the result after resolving the textual conflict,
> committing it, then trying to force-push to the original PR branch (if the
> contributor has given you permission to push).
>
> So what I am talking about here really is the case where no rename
> conflict happened, no directory/file conflict, no type change. Just the
> good ole' textual conflicts where the same lines were modified in
> divergent ways.

Sure, but we were talking about needs for `git merge-tree`.  You are
saying we need more information out of it (OIDs and modes) to fullfill
user requests.  That's totally reasonable.  But stating that you don't
care about certain types of conflicts or cases where renames happen
doesn't really help answer my question; while that's a restriction you
can put on your internal implementation, other users of `merge-tree`
doing the exact same type of thing (even involving a web UI) might
decide they also want to handle the other types of conflicts.  I don't
want merge-tree to have a design only capable of handling unrenamed
files, or only textual conflicts, since the new mode for merge-tree
was all about handling the complexity of a real merge.

> This means that we need the base, HEAD and MERGE OIDs here (and modes, you
> are absolutely correct).

Now you're back to requiring three again.  What about modify/delete
conflicts where there are only two available?

Your stated requirements either lack precision about what you really
want (e.g. "the OIDs and modes that would have appeared in the higher
order stages in the index for the given path") or aren't satisfiable.
I'm against providing anything that knowingly paints us into a corner.

...
> > > @@ -3972,7 +3973,17 @@ static void process_entries(struct merge_options *opt,
> > >                                           &dir_metadata);
> > >                 if (mi->clean)
> > >                         record_entry_for_tree(&dir_metadata, path, mi);
> > > -               else {
> > > +               else if (opt->pre_resolved_conflicts &&
> > > +                        (resolved_oid =
> > > +                         strmap_get(opt->pre_resolved_conflicts, path))) {
> >
> > You have a couple problematic assumptions here:
> >
> >   * What if the user's resolution required fixing a semantic conflict,
> > meaning they needed to modify a file that had no conflicts?  Your code
> > here would ignore those, because the clean case is handled above.
> >
> >   * What if the user's resolution required adding a totally new file
> > (either because a rename is handled as a separate add/delete, or they
> > just needed a new file)?  The loop above isn't over items in
> > pre_resolved_conflicts, it just assumes that items in
> > pre_resolved_conflicts are also in the plist.items being looped over.
>
> I can see how these assumptions may look ludicrous when coming from the
> command-line. But again, we are talking about the realities of a conflict
> resolution via a web UI.
>
> So I think that it is out of the question to address non-textual conflicts
> in this scenario. And then the assumptions make much more sense.

Waving your hands and saying it came from a web UI doesn't reduce my
worries or concerns at all.  I could easily imagine a web UI that
allows users to specify other modifications they want to make, even
limited to textual ones, to include in the merge.  What happens when
they modify some file that had otherwise merged cleanly (e.g. a file
that gains a new call to some function, which after the merge needs an
extra parameter passed to it)?  Your solution doesn't handle it; it'd
send that user-specified change to /dev/null.

To be fair, you mentioned below that this is just a proof of concept,
and that certainly reduces worries/concerns.  It's totally fine to
have such things.  Maybe you intend to keep this patch internal
indefinitely.  That's fine too.  My commentary is just feedback on if
we want merge-ort/merge-tree extended more in this kind of fashion
(and it might also serve as useful pointers on how to extend your
internal patch if you get requests to extend your web UI a bit to
handle more cases).  :-)

> > > +                       mi->clean = 1;
> > > +                       mi->is_null = 0;
> > > +                       memcpy(&mi->result.oid, resolved_oid,
> > > +                              sizeof(*resolved_oid));
> >
> > And here's another:
> >
> >   * What if the provided resolution was a deletion of the file in
> > question (especially after e.g. a modify/delete or rename/delete
> > conflict)?  Don't you need to have a special check for the zero_oid
> > here?
> >
> > And if I combine the things above:
> >
> >   * What if the user wants to remove a file and add a directory of
> > files in its place at some location in order to resolve things?
> > Granted, you didn't handle either deletes or new files above, but if
> > you did add both, then you might have this issue.  The code at this
> > point used some very carefully constructed logic and order of walking
> > items specifically to handle file/delete conflicts correctly.  I'm
> > worried that your conflict resolution stuff here might interact badly
> > with that.
> >
> > > +                       if (!mi->result.mode)
> > > +                               mi->result.mode = 0100644;
> >
> > How do you know it's not supposed to be 0100755?
>
> I don't ;-)
>
> This was a proof-of-concept, and I meant to look into this a bit further,
> trying to figure out from where I could get this information, but I never
> got to that.
>
> Now that I think about it, the best solution would probably be for the
> mode to be provided in addition to the blob OID, so that the caller has to
> decide.

+1.

...
> > directory/file are still handled by providing individual files, but
> > ordering traversal becomes really tricky.  The directory/file case
> > might even require the pre_resolved_conflicts to be pulled out of that
> > loop somehow.  It'd take some investigative work, or some deep
> > thought, or both.
>
> My idea for directory/file conflicts is to essentially teach the web UI to
> throw its hands in the air upon encountering them, and telling the user
> that it's not possible to resolve these types of conflicts via the UI.
>
> And since my principal driver here is the concrete need for such a
> server-side merge with conflict resolution, that's as far as I want to
> push `merge-tree`, too, and leave any more complicated resolution to a
> future date, or never, whichever comes first.

:-)

> > > A subsequent commit changed my hacky `merge-tree` hack to optionally
> > > accept NUL-terminated merge conflict resolutions in <path>/<OID> pairs via
> > > stdin (again, avoiding files to be written where we do not _need_ spend
> > > I/O unnecessarily).
> > >
> > > The biggest problem we faced at the Contributor Summit was that our
> > > discussion was not informed by the actual server-side needs. So I would
> > > like to reiterate my challenge to make that the driver. Let's not use any
> > > hypothetical scenario as the basis for the design of `git merge-tree`, but
> > > let's use the concrete requirements of actual server-side merges that are
> > > currently implemented using libgit2, when trying to figure out what
> > > functionality we need from `merge-tree`, and in what shape.
> > >
> > > Here is an initial list:
> > >
> > > - need to determine whether a merge will succeed, quickly
> > >
> > > - need the tree OID for a successful merge
> > >
> > > - need the list of items that conflict...
> >
> > I think my version is good up to here.
>
> Yes!

:-)

> The only thing I would change is to not even bother providing a tree
> object in case of conflicts. Either we provide it, and expect the user to
> somehow reconstruct the conflict types from there, or we simply don't say
> anything about the tree whose (transitive) file contents may or may not
> contain conflict markers (or not, think: binary files). Providing a tree
> object in case of a failed merge isn't helpful IMO.

You've got a false dichotomy here.  Providing a tree object does NOT
imply that we expect users to reconstruct a list of conflicted files
or the types of conflicts from that tree.  I pretty strongly argued
against that, in fact (see [*], , starting at "???" -- and yes, I mean
a literal triple question mark).

I also don't see why you are so bothered by the tree object being
printed.  I already pointed out that we can't easily avoid computing
the tree object without risking hurting performance more than you're
trying to help it (again, see [*]).

But beyond performance, by trying to require that the tree object not
be printed, you are trying to prevent users from getting information
that they simply cannot obtain any other way.  Even if `git
merge-tree` provided a list of up to three (stage, mode, oid) triplets
for each conflicted filename corresponding to what you'd find in the
index in the higher order stages (which sounds like a totally
reasonable request, by the way), you could not reconstruct the
information available in the tree for the same conflicted paths.
Sure, you could get "close", and for some uses, maybe that's good
enough, but most users I've ever seen prefer the file in the working
copy after a merge for trying to resolve conflicts over the (stage,
mode, oid) pairs found in the index.  And since file in the tree
potentially has some information not reconstructable from the index, I
don't see why we should avoid printing 41 characters to stdout to
allow the user to make use of it.  If it's not useful to you,
whatever, toss those 41 printed bytes.

[*] https://lore.kernel.org/git/CABPp-BHvXrP0sTTmuTYfACoJTCcm9+wk_f441nj4TstrmQdqMQ@mail.gmail.com/

> > >  , along with OIDs and modes, if the merge failed
> >
> > Could you clarify what you mean here by OIDs and modes?  For a given
> > path, are you just looking for a (pathname, OID, mode) tuple?  (In
> > which case, you'd get the OID of a file that potentially has embedded
> > conflict markers)
> >
> > Or are you looking for multiple OIDs and modes for each file?
>
> This. In case of a conflict, I am looking for (mode,OID) for the merge
> base (which _can_ be a virtual one in case of recursive merges) as well as
> for the two divergent revisions that were supposed to be merged.
>
> I do realize that other types of conflicts can occur, such as a
> rename/rename conflict, and we would need a way to represent these in the
> output, too. But in such an instance, where no clear (mode,OID) triplet
> can be provided that represents the merge conflicts for this file, the
> current web UI cannot offer a way to resolve the conflict, so I am a bit
> less interested in that scenario.

Okay, this is helping explain a bit better.

Out of curiosity, does this mean the web UI only can resolve cases
where all three modes & OIDs are present, and the files are text
rather than binary?  For example, does this mean the web UI cannot
handle cases like modify/delete or add/add?

> > If you are looking for multiple OIDs and modes for each file
> > (representing where the content came from on the different sides of
> > the merge), are you looking for:
> >   * the OID and mode of each file that played a part in the merge resolution
> > OR
> >   * just the OIDs and modes that would have been recorded in the index
> > had the merge been done by `git merge`?
>
> I think the latter was my idea.

Ah, perfect; that's something we can provide!

> But again, you made me think of rename/rename conflicts and friends, and
> we would need a way to represent those, too. Even if my current use case
> would need to only detect their presence in order to say "nope, can't
> resolve that on the web".

But now you're making me worry whether I can satisfy your requests
again, or at minimum, whether I need to do a lot more work in
merge-ort to answer them.  Do you need a representation other than the
list of (stage, mode, oid) triplets?

That might be hard to come by, especially for cases like mod6 of
t6422.  The code basically assumes there's going to be 0 or more
conflict types at each path (and yes, you can absolutely have more
than 1), but doesn't store these conflict types other than in terms of
outputting various "CONFLICT (type): <more info>" strings (though it
does keep the output messages in memory and associated with each file
before printing them at the end).  Further, while some conflict types
which could be considered to affect multiple paths (e.g. rename/rename
where both sides rename the same file differently), they are only
stored once relative to only one of the filenames to avoid printing
the same conflict notice three times. (For example, in the
rename/rename case, the conflict message is associated with the base
filename).

If you do only need the list of (stage, mode, oid) triplets, then that
can be provided for every file.  However, things like
rename/rename(1to2) will only provide a single (stage, mode, oid)
triplet for the oldfilename, and also only provide one triplet for the
new filename on side1, and also only provide one triplet for the new
filename on side2.  I don't know if it'll confuse users why they have
a conflict for a file with only a single triplet.

> > > And now that I wrote all this, I realize I should have sent it to the
> > > `merge-tree` thread, not the `merge-tree-ort` thread...
> >
> > My submission was RFC and you're providing C, so it's all good in my
> > book.  I'm reading both threads.  :-)
>
> :-)

I'm a little worried I might come across sounding a little picky since
I tend to dive into details and really fixate on them.  I apologize in
advance if it sounds that way at all; you provide lots of good points
to think about and I can't help but dive into the quirks surrounding
each.  I really appreciate all the awesome feedback and food for
thought.
