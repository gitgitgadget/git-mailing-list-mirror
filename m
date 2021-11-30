Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114EFC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 10:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhK3KJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 05:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhK3KJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 05:09:40 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B8EC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 02:06:21 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id q74so50930265ybq.11
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lnmvf8mwPjszUFSVpKtFEXVvZkeNdD/ZRAvbWU637eU=;
        b=NfvIuHgpAFkuHoLjDgj+/Zd4/7+W0ls58ssfByjQMhRD8X1Eegx+oxEOeozXoU27nF
         pISXP9ZpoWULr43nrwVCzsbuQlm8zJAKxM52LvFuOm48Ej/YUTwM1k8OxtPwuHqis6lF
         ivj3s1rwLQnKZsD0mxlvDbS8Y/hi/verwlZO4L96X/+gC1P3uDFEOOiTt3Ap9xWUVC0d
         zmFSdAyjnT74vC9hrXbBXVD1RvlxkEuSxAN7cmhrJ94psEZl2hIAia3hlq27i6TMEx0A
         2F7FjOOLZ2Id6Tr+CNA2rDNSAxlQ7fpmr9tyB9lSpM9o3olmkRguMZKkHERMCL3Cp7lo
         R00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lnmvf8mwPjszUFSVpKtFEXVvZkeNdD/ZRAvbWU637eU=;
        b=ZQi4ELJ9zg5m13EzMvfckRkG+O8HwsBSmDeZVUxFxLNJlytuSWrtfVZiDhcdXHcxhR
         LOyMURkVWPeevpSYOK6OVZuOxuLyJpT7wp3CiHfUcpNHEtW2lLQGQxXDQo7KSoWf4krt
         6Oh1L9jgYUCa6ii9934X6mlGzJbDZyalMtZKUPdXoOhPxrapR2wxeBglp0764C8XbJQN
         Nrf8kRcyswuSwkyYLWcAGICncjxQbzsrPB/w7KxRDCojWzZXWxMhESE06LytG5jcrnW1
         GNAmAQ5nLHZ691VOFgebfq0l1yk46VRsD6hVKvIOB+HuvqtALtSmOorAMoqRts8HfRoA
         rNfg==
X-Gm-Message-State: AOAM530ow2Qi9sCtSUHNclMhzCrc964jZR6QzttySUMW5lxip2Wh33Pg
        3bbKaq++WaBNliKFt9mm9W6j/2BxZFv02QfFu7Y=
X-Google-Smtp-Source: ABdhPJx8DyRz+mY8oMaiP6DiT5WFIoOlaPHr6qX9Ug6nKdD5F8CnHk5KBpIyTHacBq7b4iHnMchW0Ev8x9JZhgecKWY=
X-Received: by 2002:a25:d70e:: with SMTP id o14mr39871703ybg.427.1638266781028;
 Tue, 30 Nov 2021 02:06:21 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet> <YYlqpuzv+bmZaFzz@nand.local>
 <211109.861r3qdpt8.gmgdl@evledraar.gmail.com>
In-Reply-To: <211109.861r3qdpt8.gmgdl@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 30 Nov 2021 11:06:09 +0100
Message-ID: <CAP8UFD1LgfZ0MT9=cMvxCcox++_MBBhWG9Twf42cMiXL42AdpQ@mail.gmail.com>
Subject: Re: [Summit topic] Server-side merge/rebase: needs and wants?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 9, 2021 at 1:18 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Mon, Nov 08 2021, Taylor Blau wrote:
>
> > I was discussing this with Elijah today in IRC. I thought that I sent
> > the following message to the list, but somehow dropped it from the CC
> > list, and only sent it to Elijah and Johannes.
> >
> > Here it is in its entirety, this time copying the list.
> >
> > n Thu, Oct 21, 2021 at 01:56:06PM +0200, Johannes Schindelin wrote:
> >>  5.  The challenge is not necessarily the technical challenges, but th=
e UX for
> >>      server tools that live =E2=80=9Cabove=E2=80=9D the git executable=
.
> >>
> >>      1. What kind of output is needed? Machine-readable error messages=
?
> >>
> >>      2. What Git objects must be created: a tree? A commit?
> >>
> >>      3. How to handle, report, and store conflicts? Index is not typic=
ally
> >>         available on the server.
> >
> > I looked a little bit more into what GitHub would need in order to make
> > the switch. For background, we currently perform merges and rebases
> > using libgit2 as the backend, for the obvious reason which is that in a
> > pre-ORT world we could not write an intermediate result without having
> > an index around.
> >
> > (As a fun aside, we used to expand our bare copy of a repository into a
> > temporary working directory, perform the merge there, and then delete
> > the directory. We definitely don't do that anymore ;)).
> >
> > It looks like our current libgit2 usage more-or-less returns an
> > (object_id, list<file>) tuple, where:
> >
> >   - a non-NULL object_id is the result of a successful (i.e.,
> >     conflict-free) merge; specifically the oid of the resulting root
> >     tree
> >
> >   - a NULL object_id and a non-empty list of files indicates that the
> >     merge could not be completed without manual conflict resolution, an=
d
> >     the list of files indicates where the conflicts were
> >
> > When we try to process a conflicted merge, we display the list of files
> > where conflicts were present in the web UI. We do have a UI to resolve
> > conflicts, but we populate the contents of that UI by telling libgit2 t=
o
> > perform the same merge on *just that file*, and writing out the file
> > with its conflict markers as the result (and sending that result out to
> > a web editor).
> >
> > So I think an ORT-powered server-side merge would have to be able to:
> >
> >   - write out the contents of a merge (with a tree, not a commit), and
> >     indicate whether or not that merge was successful with an exit code
> >
> >   - write out the list of files that had conflicts upon failure
> >
> > Given my limited knowledge of the ORT implementation, it seems like
> > writing out the conflicts themselves would be pretty easy. But GitHub
> > probably wouldn't use it, or at least not immediately, since we rely
> > heavily on being able to recreate the conflicts file-by-file as they ar=
e
> > needed.
> >
> > Anyway, I happened to be looking into all of this during the summit, bu=
t
> > never wrote any of it down. So I figured that this might be helpful in
> > case folks are interested in pursuing this further. If so, let me know
> > if there are any other questions about what GitHub might want on the
> > backend, and I'll try to answer as best I can.
>
> That's very informative, thanks.

Yeah, thanks!

> Not that "ort" won't me much better at this,

I think the optimizations in "ort" could still be useful. Wouldn't it
be nice if rename detection was optimized for example?

> but FWIW git-merge-tree
> sort of gets most of the way-ish to what you're describing already in
> terms of a command interface.

Yeah, but if the engine is not up to date, I am not sure it's worth it
to reuse it just for the current very limited command interface.

> I.e. I'm not the first or last to have (not for anything serious)
> implement a dry-run bare-repo merge with something like:
>
>     git merge-tree origin/master git-for-windows/main origin/seen >diff
>     # Better regex needed, but basically this
>     grep "^\+<<<<<<< \.our$" diff && conflict=3Dt
>
> So with some parsing of that command output you can get a diff with one
> side or the other applied.

Yeah, it looks like it would be easy to add options like --ours,
--theirs, etc, to get only the part we are interested in. And we
already easily see if the merge conflicted or not from the current
output, as it seems to output:

"0 mode sha1 filename"

in case of a successful merge, and:

"1 mode sha1 filename"
"2 mode sha1 filename"
"3 mode sha1 filename"

in case of conflicts.

> From there it's a matter of applying the patch, and from there you'd get
> blobs/trees. which is painful from just having a diff & no index, so
> it's a common use-case of libgit2 for just such basic usage.
>
> But to the extent that we were talking about plumbing interfaces
> wouldn't basically a git-merge-tree on steroids (or extension thereof)
> do, i.e.:
>
>  * Ask it to merge X heads, returns whether it worked or not
>  * ... and can return a diff with conflict markers like this
>  * ... for just some <pathspec>
>  * ... maybe with the conflict already "resolved" one way or the other?
>  * ... optionally, after some markers write one/both sides, spew out the
>    relevant tree/blob OIDs
>  * ... which again, could be limited by the <pathspec> above.
>
> I'm thinking of something that basically works like git for-each-ref --fo=
rmat=3D"". So:
>
>     git merge-tree --format=3D"..." <heads> -- <pathspec>
>
> Where that <format> can be custom \0-delimited (or whatever) sections of
> payload that could have whatever combination of the above you'd need. I
> think git-for-each-ref is probably the best example we've got of a
> plumbing interface in this category, i.e. being able to extract
> arbitrary payloads via format specifiers & "path" (well, ref)
> limitation.

The current synopsis is:

git merge-tree <base-tree> <branch1> <branch2>

which is quite different from what you are proposing.

Given that it seems worth it to use a different underlying engine
(actually the "ort" one) than the current one, I think that it might
be better to start from scratch with a new command using the "ort"
engine.

> Elijah probably has much better ideas already, I'm just spitballing.

Yeah, I'd be interested in knowing Elijah's opinion on this. Although
maybe I misunderstood, but I thought that Elijah had plans to send
patches related to this to the list after v2.34.

> But if something like that worked it would be mostly a matter of
> stealing code from for-each-ref and the like, and then the <handwaiving>
> mapping that to ORT callbacks somehow.

Yeah, but what would be left from the original git merge-tree then?

Wouldn't it make more sense to start with a new command that has
roughly the same features as git merge-tree and a similar interface
(though maybe not quite the same as we could anticipate some future
extensions and maybe learn a bit from other commands), but uses "ort".
Then we could grow it as we want, without being burdened by the git
merge-tree legacy, in the same way as "ort" was developed without
being burdened by the recursive merge legacy?

> And then it could even learn a --batch mode, which with those formats
> could allow calling it without paying the price for command
> re-invocation, something like the update-ref/proposed cat-file interface
> discussed in another thread at [1].

Yeah, sure.
