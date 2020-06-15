Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4681FC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 03:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0454A20768
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 03:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRPVFubK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFODx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFODx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 23:53:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A3C061A0E
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 20:53:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i27so17368239ljb.12
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 20:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hm2Q7D07YEOBUl9sAP2VcT6175/+qnrVpXDMny0Sgo4=;
        b=aRPVFubK8TVAmuAo+Qk9OwP9SR4jhGVjAO8rvdPb5BduwBXUpeAMbkAHBITwyQJZGf
         oSTWRJ1mOVAUIFFTIHMj3anmV1idSetxT+7zQsRjUDsJ19ERWK7ezeTDbotp9tMu1CUp
         5tjJV9ayZqJgKZocigbkV83Dbm/HFHr4XGD10FygMXmewagMnYXbS6RIbDv+lyRyCpLg
         5PhAzRGYHBQDnik4TcnGOnDmfLIBUKKh8dUQwpDmnpCN+fvIsLv4+ojyJmyQWBom9ZGu
         y29uDcOs5eUkD1vKltZYx5f94xvSS4BFjXL0OpLGvIdH8BAhpYQKEBka49O/palf3Gia
         X6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hm2Q7D07YEOBUl9sAP2VcT6175/+qnrVpXDMny0Sgo4=;
        b=jY2xNzjWtTRJqt8+40oYkZwoc3KtDzzCUzdbjBg4LKWykrkh+Jn1wKtecBZePUyutK
         nT3mNOQ1NErzddeU/dN4w2/d8Rbn9fYP8MJy2cfVAJArlvFvrNahkr9L4TdgXPqQq3M0
         UMa13ncAFTYHyKDriUWbZiVLhtLbg95/u0VllPEGVVIpgD+mIxTwASZJbGO1DZcB5/QW
         kWtiiRzRuNbfvudgcgfhKCqzCCV0rNMCKfY8k9Jx06/jAI23Oi+fzJeiiukJzTPaRbSs
         +VTBJH6O7oh9hkrAKb1DUJ6/zQrltIH3pWa53uV+ScimdfLaMpsOOpj+zns6HcSGaSqB
         LZmg==
X-Gm-Message-State: AOAM530MO5uOEYRDmbsaikMo7E+oE/ciNlI7Fm63Bmoi1Vy6hE3W2bRR
        LNF7IIFHe6JG+fk1J6vaV32Y2P+LxbWyrbuD2bg=
X-Google-Smtp-Source: ABdhPJzpdt6h42BgUWpHeHOXd0KfOSwfYMPv8HBY83CpoF0/Zm7PbBE5tEnWMpMecV6dOKiObNH45/x26d07RknIyc4=
X-Received: by 2002:a2e:9c9:: with SMTP id 192mr11184066ljj.4.1592193201973;
 Sun, 14 Jun 2020 20:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
 <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com> <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
In-Reply-To: <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Mon, 15 Jun 2020 13:52:50 +1000
Message-ID: <CAH5451n7e39ZCM4iJ4Ry=g7QkVYwFL-a=9CTVOifp+rcvb5i_g@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Don Goodman-Wilson <don@goodman-wilson.com>
Cc:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        philipoakley@iee.email,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        newren@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[apologies to those cc'd, thought I had plaintext on but obviously not
so resending]

Hey, I got linked to this thread! Been following along since the
beginning but only engaged on twitter so far.

To put the important stuff first: I believe the historical usage of
the word is mostly irrelevant for understanding how a word is used
today, and more importantly when deciding if we should continue using
it.
For this specific issue, I think if it's possible to have no default
branch name (have the user name it when creating the repository) that
is the best option; if there has to be a default branch name then let
it be configurable and default to whatever the community wants to
default to (which to date seems to be 'main').

On the history of how 'master' came to be used as the git default
branch, and the history of how it has been used historically, there
are a few things (and please note I do think this is irrelevant in the
context of what the git default branch should be - this was originally
a deep dive simply because I was interested).

First up, there are definitely usages from around the time git was
created of the "Master and Slave" paradigm within the context of
source control management, for example [0].
It seems like CVS also used the "Master and Slave" terminology when
referencing repository management, but I haven't looked into that in
particular [1] (the main branch is called trunk though).

The thing is, there are also a lot of usages that use the "Master
Copy" paradigm, and when it comes to BitKeeper there are a lot more of
this kind of usage than the "Master and Slave" usage. Perhaps the most
authoritative I have found is the BitKeeper book, which says "shared
master repository, private per user working repositories" [13].

The GNOME mailing list thread that is used as a starting point for
this argument makes a lot of tenuous links, links I don't think hold
up when looking at the full context. I'll try and address a few parts
of this argument but again, this is just a bit of history I find
interesting rather than an important consideration for changing git
today.

Even if git borrowed 'master' from BitKeeper AND BitKeeper used it in
a "Master and Slave" fashion, that doesn't mean that the person
introducing it to git was using it in a "Master and Slave" fashion,
nor that everyone else in git used it in a "Master and Slave" fashion.
The best way to find that out would be to ask people who were there
(for when it was introduced) and people who use it today (for how it
has been used since then). Anecdotally, I have never seen anyone
associate the master branch in git with anything except a "Master
Copy" (or "Gold Master") EXCEPT when following that GNOME link [5].
I wasn't there at the time, so if anyone was would love to hear your input.

How likely is it that git borrowed the concept directly from
BitKeeper, as opposed to some CVS usage or simply general usage? The
first point made in the GNOME post is that 'master' was introduced
with a CVS helper script [2]. Here is the snippet:

>    src_branch =3D *ancestor ? ancestor : branch;
>    if (!strcmp(src_branch, "HEAD"))
>        src_branch =3D "master";

They then claim that this usage of master is

> Probably because BitKeeper uses "master" for its main branch"

It's just as likely that the 'master' usage was common in the industry
(for example, as stated in [0], which actually lends support for the
"Master and Slave" usage in the industry), but let's go with it being
copied from BitKeeper - what then was the usage in BitKeeper like?

The term 'master' is very common in the source and documentation of
BitKeeper, but repositories are not explicitly named in BitKeeper so
these usages are either referring to the machine the repository is on,
a conceptual name in a workflow, or some non-repository related
meaning.

For example @jpaulreed on twitter found a usage which is the "default
config value for... what to call the repository displayed by the
Bitkeeper HTTP server" [3]. You can see where it is used at [3.1].
(as an aside, a lot of that thread is showing usages of 'master
repository' in BitKeeper, as opposed to  "Master and Slave" usages,
which I think is due to me not being clear about the point I was
trying to make re "Master and Slave" vs "Master Copy").

The term 'slave' is somewhat common in BitKeepers source, though most
usages are in the Tcl/Tk gui code so not relevant to this discussion.
The ones that are relevant are talking about a slave machine (and the
repository on that machine)  as per [6], and a 'slave' comment in a
test [6.1] (again found by @jpaulreed [4]).

In this HOWTO.ask file the terms 'master repository' and 'slave
repository' are used quite a bit, but always in reference to the
repositories sitting on the master and slave machines in the example.
In other sections of this document, when talking about developers
modifying the code, the terms 'Master' and 'WorkArea' are used
instead. Indeed, as far as I can tell, all other usages of 'master' to
refer to a repository in the docs are used in this way or are
ambiguous about the usage.

Below I summarise all usages of 'master' in BitKeeper, apologies for
the verbosity but I found it hard to do this on twitter, so I am
listing them here (after my conclusion).

My conclusion?

Of all the usages of master in BitKeeper, the overwhelming majority of
them are of the "Master Copy" variant, consistent with how I and many
other people I have seen comment understand gits usage of the term
master.

To reiterate my point at the top - I believe this information is
irrelevant when deciding what git should do now, and my preference
would be to have no default at all.

Examples that use the word slave:
- a repository on a slave machine (note the master-copy usage is also
used here) [5]
- a slave comment in t.automerge [6]

Examples that are consistent with a "Master Copy" usage of the word
master, and not a "Master and Slave" usage are:
- in the airgap docs [7] there are two masters, and 'Work Spaces' to
modify the code in them
- notes on binpool reference local and remote masters [8]
- bk-Howto-bkd has example code for cloning master to '~/my-tree' [9]
- quickstart docs has similar example to bk-Howto-bkd and additionally
talks about a master and a clone [10]
- the bam-pull test talks about a master and clone [11]
- bk-csetprune uses main as a synonym for master, and additionally
talks about cloning into 'src' and 'docs' repositories (splitting a
master repo into two) [12]
- the BitKeeper book, which says "shared master repository, private
per user working repositories" [13]
- trigger-master and trigger-copy repositories in t.resolve [14]
- in t.bam-clean, a master repository and its copy and a 'clean' clone [15]
- in t.bam2, a master and its clones [16]
- in-bk-config-etc "the location from which source can be cloned" [17]
- in t.checksum, cloning from a master to a 'client' repository [18]
- in bk-bkd, pushing from 'myrepo' to the master [19]
- in t.nested-attach, names used are 'project', 'copy', and 'master' [20]
- tag-master and tag-copy in t.csetprune [21]
- release notes for 4.x talking about multiple parents - local master
and remote master [22]
- in t.bam, tests referring to 'servmaster', 'someclient', and
'servmaster.copy' [23]
- in bkmsg.doc create a master repository for a package, then clone
into 'my_workarea' [24]

Other repository usages that talk about a master but are not
explicitly "master copy" or repository usage:
- bk-bkscc uses top-level as a synonym for master when talking about
Makefiles, and also talks about Master repositories but doesn't really
talk about relationships between repositories at all [25]
- event-stack propagation talks about master repositories, and appears
to imply a master-copy usage, but it's not clear [26]
- the 'Master repository' as listed in the webserver, no reference to
clones/copies/slaves or anything else [27]
- test for the webserver configvar master [28]
- when discussing rcloning, discusses multiple 'masters' but doesn't
really reference non-master repos [29]

Git related usages of master:
- in bk-fast-export [30]
- git usages in bk-fast-import [31]
- git usages in doGitExport.sh [32]
- in git2bk [33]
- in t.git-exporter [34]
- seems to be git related in fast-export.c [35]
- in release notes for 7.3.1ce introducing bk fast-export --standalone mode=
 [36]

Other, non-repository usages:
- as discussed above, lots of Tcl/Tk gui code
- notes on DAEMON is a bit ambiguous, but no slave references or
implications [37]
- gnu patch talking about where the 'master source' for its code lives [38]
- crank.sh talking about a 'master template' [39]
- in bk-patch [40], gnu/patch/patch.man [41], and gnu/patch/pch.c
[42], references to an 'SC master' which are references to an SCSS
master
- release notes for 4.x referring to a 'master lease server'
(synonymous with authoritative) [43]
- in tomcrypt/DoxyFile references to "the master .chm file" [44]
- 'mastering' perl regular expressions [45]

Regards,

Andrew Ardill

[0] https://www.google.com/books/edition/Open_Sources_2_0/q9GnNrq3e5EC?hl=
=3Den&gbpv=3D1&pg=3DPA29
[1] https://twitter.com/hadessuk/status/1271487243950206978
[2] https://github.com/git/git/commit/3e91311ae750af9bf2e3517b1e701288ac306=
6b9
[3] https://twitter.com/jpaulreed/status/1272043692837072897
[3.1] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e=
46ab48e577807cbbaf4/src/bkd_http.c#L1264
[4] https://twitter.com/jpaulreed/status/1272042287732674560
[5] https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.ht=
ml

"master/slave" usages of master or slave
[6] https://github.com/bitkeeper-scm/bitkeeper/blob/master/doc/HOWTO.ask#L2=
23
[6.1] https://github.com/bitkeeper-scm/bitkeeper/blob/master/src/t/t.autome=
rge#L90

"master-copy" usages of master
[7] https://github.com/bitkeeper-scm/bitkeeper/blob/master/doc/airgap/airga=
p.gif
[8] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e46=
ab48e577807cbbaf4/src/Notes/BINPOOL.adoc
[9] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e46=
ab48e577807cbbaf4/man/man1/bk-Howto-bkd.1#L25
[10] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/doc/quickstart#L70
[11] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.bam-pull
[12] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-csetprune.1#L94
[13] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/doc/book.ol#L14
[14] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.resolve#L909
[15] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.bam-clean#L31
[16] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.bam2
[17] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-config-etc.1#L105
[18] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.checksum#L241
[19] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-bkd.1#L240
[20] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.nested-attach#L611
[21] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.csetprune
[22] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/RELEASE-NOTES-4.x#L917
[23] https://github.com/bitkeeper-scm/bitkeeper/blob/5695c0d0ecd062f13542c3=
cb04dd872466774fbf/src/t/t.bam#L360
[24] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/bkmsg.doc#L357

ambiguous usages of master
[25] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-bkscc.hide
[26]  https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e=
46ab48e577807cbbaf4/src/Notes/EVENT-STACK.adoc
[27]  https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e=
46ab48e577807cbbaf4/src/bkd_http.c#L1264
[28]  https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e=
46ab48e577807cbbaf4/src/t/t.config-defaults
[29] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/rclone.c#L158

git related usages of master
[30] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-fast-export.1
[31] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-fast-import.1
[32] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/doGitExport.sh#L17
[33] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/contrib/git2bk.l#L35
[34] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/t/t.git-exporter#L50
[35] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/fast-export.c
[36] https://github.com/bitkeeper-scm/bitkeeper/blob/5695c0d0ecd062f13542c3=
cb04dd872466774fbf/RELEASE-NOTES.md#bitkeeper-version-731ce-released-sep-29=
-2016

non-repository usages of master
[37] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/Notes/DAEMON.adoc
[38] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/gnu/patch/error.c
[39] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/crank.sh#L16
[40] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-patch.1#L207
[41] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/gnu/patch/patch.man
[42] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/gnu/patch/pch.c
[43] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/RELEASE-NOTES-4.x#L980
[44] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/src/tomcrypt/Doxyfile#L639
[45] https://github.com/bitkeeper-scm/bitkeeper/blob/616740d0daad99530951e4=
6ab48e577807cbbaf4/man/man1/bk-pcre.1#L146

Regards,

Andrew Ardill


On Mon, 15 Jun 2020 at 00:00, Don Goodman-Wilson <don@goodman-wilson.com> w=
rote:
>
> > MASTER IS NOT INHERENTLY RELATED TO MASTER-SLAVE RELATIONS.
>
> 1) There is a great deal of evidence that that claim is simply not true.
> https://twitter.com/tobie/status/1270290278029631489
> https://twitter.com/jpaulreed/status/1272064807345115137
>
> 2) It's beside the point. Many problematic words and phrases have
> perfectly benign origins, but take on new meanings in new contexts.
>
> I personally reject the kind of moral relativism that is being
> espoused here. In fact, I believe that there is such a thing as
> justice, and that we each have a responsibility to seek it out and
> create it in every corner of our activities, big and small. You can
> abdicate that responsibility, I can't force anyone to do otherwise nor
> would I want to. But history judges harshly those who would throw
> others aside. Of course there are more people in the world than just
> Americans. But there are also Americans, and in particular Black
> Americans. Precisely because git is the tool of choice for open source
> and so much other development work, I believe we have a responsibility
> to build a tool that reflects the values of _all_ that we want to
> welcome into these communities. If you would rather exclude Black
> Americans or others descended from generations of colonial slavery,
> that's your choice, but you need to own the fact that it is an
> inherently racist choice.
>
> Don Goodman-Wilson
>
> On Sun, Jun 14, 2020 at 2:20 PM S=C3=A9rgio Augusto Vianna
> <sergio.a.vianna@gmail.com> wrote:
> >
> > There's nothing to be resolved because there is no problem. If someone
> > reads "master" and gets triggered because all they can think of is
> > racism, that person needs therapy.
> >
