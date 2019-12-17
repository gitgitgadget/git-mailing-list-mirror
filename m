Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A178C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D2721835
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 16:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5YqH9LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLQQ7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:59:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36482 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfLQQ7C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 11:59:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so5149028oic.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 08:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqKRMZJW3Ry1JYMGX/0BL+//O8rL35upFJX1CjYnOxE=;
        b=o5YqH9LOoa0y4HT0XlRIbP0/h3pp+b34oPa4S1nIe7BU0TWbg9C25T79bNcYI9OoRj
         BXyb4E+Nvp9oTxpzBrcYXb3CipYg1WYvnZSFDUXgHiWfLrp0wEDZOqVXNuT6aR2pGJph
         EZ5GlqsPE35QOejnDjvNJUyrZaPk15BLqZfDq80Jx60HcCon6GULIQ81MdGZvxKUDvaH
         SH4cp2hRIx1CeqGb3ICf3G+O4rM9d+cuQwL/Y/jE2RM/a+t7D58trwyWs9eh7Ka6+Dwy
         /l3OnvvfyviwTieqhBjY3RMwMiV3gKVMEEXHmhDftxV9VCvCS9PkqCC99hLNFb7wqcTB
         z2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqKRMZJW3Ry1JYMGX/0BL+//O8rL35upFJX1CjYnOxE=;
        b=WFXChO9LNP++GAxM4gjkaK6UqtYe/qdmr1gRmZhwZ98fB+NmzqMUmxzh4eTFSnATw4
         XC1xc+Bfjd5VSM87Rz0qFgIw0xsFeaQ4RNNYUuBa4b1RxDGfCfQZJ3ONcVBGIwo16TbZ
         hnJF1X4VKR4tRg+tM9dDQ4tJg6Om3ETLA+c2F/A2UHlx7kEmYWBbHLpQMq/aB7eSteUA
         Id9QQsYBcjzkhkiesDNhQXnn/by8+lNvhAZJb5YGYtXu/6JQkpfTAlwLkfJzKfonIswp
         lqEmeVwhgtCqckkxmCDH/DjcGyllCv2f98JZqR+u3ClVHU+Zc2Yh0kiOqV30vmiPo9z9
         FsHQ==
X-Gm-Message-State: APjAAAWqaKpzdxNykbH5ET73PcxGfQJsfgE9n1uBB4okurtsY4p/IdHp
        o2E+7hGMtAc068wi8RkZ+RFSUsBUzu7ms51IP61bKQ==
X-Google-Smtp-Source: APXvYqwU6DOrgTz3rJjKsAeIhMvT8raDjRUW3WOOCRas5/NJgM0Y3msJxvqzy7dvN6UmFoWBuLLLz8TSUm4yYTCXLJI=
X-Received: by 2002:aca:5588:: with SMTP id j130mr1982405oib.122.1576601940890;
 Tue, 17 Dec 2019 08:59:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet> <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
 <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet> <CABPp-BGFRMNAgeyTvDQ3F5nH36ERn+ndjrwaXuLUE-Uto_RBdQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912171209170.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912171209170.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 17 Dec 2019 08:58:49 -0800
Message-ID: <CABPp-BEkX9cH1=r3dJ4WLzcJKVcF-KpGUkshL34MMp3Xhhhpuw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Dec 17, 2019 at 3:16 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 16 Dec 2019, Elijah Newren wrote:
>
> > On Mon, Dec 16, 2019 at 4:04 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > On Mon, 16 Dec 2019, Elijah Newren wrote:
> > > > On Mon, Dec 16, 2019 at 5:51 AM Elijah Newren <newren@gmail.com> wrote:
> > > > >
> > > > > On Sun, Dec 15, 2019 at 2:29 AM Johannes Schindelin
> > > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > >
> > > > > > Hi Elijah,
> > > > > >
> > > > > > I have not had time to dive deeply into this, but I know that it _does_
> > > > > > cause a ton of segmentation faults in the `shears/pu` branch (where all of
> > > > > > Git for Windows' patches are rebased on top of `pu`):
> > > > >
> > > > > Weird.  If it's going to cause segmentation faults at all, it would
> > > > > certainly do it all over the place, but I tested the patches on the
> > > > > major platforms using your Azure Pipelines setup on git.git so it
> > > > > should be good on all the platforms.  Did your shears/pu branch make
> > > > > some other changes to the setup?
> > >
> > > Not really.
> > >
> > > >
> > > > Actually, it looks like I looked up the definition of dirent
> > > > previously and forgot by the time you emailed.  On linux, from
> > > > /usr/include/bits/dirent.h:
> > ...
> > > > and from compat/win32/dirent.h defines it as:
> > > >
> > > > struct dirent {
> > > >         unsigned char d_type;      /* file type to prevent lstat after
> > > > readdir */
> > > >         char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conversion) */
> > > > };
> > ...
> > >
> > > If you care to look at our very own `compat/win32/dirent.h`, you will see
> > > this:
> >
> > Interesting, we both brought up compat/win32/dirent.h and quoted from
> > it in our emails...
> >
> > > struct dirent {
> > >         unsigned char d_type; /* file type to prevent lstat after readdir */
> > >         char *d_name;         /* file name */
> > > };
> >
> > ...but the contents were different?  Looks like git-for-windows forked
> > compat/win32/dirent.h, possibly in a way that violates POSIX as
> > pointed out by Junio.
>
> Yep, I messed that up, sorry.
>
> > Any reason those changes weren't sent back upstream, by chance?  Feels
> > odd having a compat/win32/ directory that our downstream windows users
> > aren't actually using.  It also means the testing I'm getting from
> > gitgitgadget and your Azure setup (which all is really, really nice by
> > the way), is far less reassuring and helpful than I hoped.
>
> Yes. I was ready to submit the FSCache feature to the Git mailing list for
> review some 2.5 years ago when along came Ben Peart, finding ways to speed
> up FSCache even further. That is the reason why I held off, and I still
> have to condense the patches (which currently form a topology of 17 patch
> series!!!) into a nice small patch series that does not reflect the
> meandering history of the FSCache history, but instead presents one neat
> story.
>
> > > And looking at
> > > https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html, I
> > > do not see any guarantee of that `[256]` at all:
> > >
> > > The <dirent.h> header shall [...] define the structure dirent which shall
> > > include the following members:
> > >
> > > [XSI][Option Start]
> > > ino_t  d_ino       File serial number.
> > > [Option End]
> > > char   d_name[]    Filename string of entry.
> > >
> > > You will notice that not even `d_type` is guaranteed.
> >
> > Doh, yeah, I messed that up too.
> >
> > Anyway, as I mentioned to Junio, I'll resubmit after gutting the
> > series.  I'll still include a fix for the issue that a real world user
> > reported, but all the other ancillary bugs I found that have been
> > around for over a decade aren't important enough to merit a major
> > refactor, IMO.
>
> Hmm. I am really sorry that I nudged you to go down this route. Quite
> honestly, I'd rather add an ugly work-around that is Windows-only just so
> that you can fix those ancillary bugs.

You brought up issues; that's what you're supposed to do.  You
shouldn't feel bad about that.  Besides, the d_type one is real, and
means the patches at least need a
    #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
surrounding my explicit setting of d_type.  The problem wasn't what
you brought up or how you brought it up, it's massive fatigue on my
end from dir.c, from before even submitting this series[*].  I'm not
giving up on these changes or trying to discourage anyone else from
picking them up and extending them, I just don't want to touch them
right now and would rather put them on the shelf for a while.

Elijah


[*]  If you're really curious...I got involved in dir.c because of a
simple bug report nearly two years ago[1], and found myself working on
a foundation that was error-prone by design[2], with ambiguous or even
wrong documentation[3] about not just what the code does but the
intent.  Further, it was a place where not only is the correct fix
unclear, and not only is the "right" behavior unclear, but the cases
in question affect so few people that pinging the list periodically
over more than a year can't generate enough interest for anyone else
to hazard a guess as to what "correct" behavior is[4].  Stack on that
the fact that every time I touch this area, I think I'm really close
to having a fix, only to find I never, ever am.  There's always
one-more-thing before I can finally get back to something I really
wanted to work on instead.  Speaking of which, I've only managed to
work on my new merge strategy like once every 3-6 months for a small
amount of time each time.  Yes, part of that's my fault with
git-filter-repo (another case of perpetually thinking I'm close to
done), rebase changes, and whatnot.  But this series arose right when
I had my calendar nearly cleared so that I could work on the merge
strategy again (and of course the rebase bug report came in about the
same time too).  But at least git-filter-repo and rebase are generally
useful; dir.c at most generates "meh, this seems annoying" reports.
And I've already fixed all of those, the remaining fixes are stuff
that it appears I'm the only one to have reported, and I only reported
it because I was digging into the other "meh, seems annoying" reports.
I'm usually happy when I have a patch series ready to submit to git;
it means I think I'll make things better for others.  I didn't feel
that way with this series; I kind of wanted to just drop it entirely
and not even turn it in.  But I figured I should to at least document
my findings, so I pushed myself to submit and hoped no one would
respond.  Then this issue arose and when I mentioned in my
possibilities of fixing it that ripping the usage of dirent out would
be a lot of work and would probably cause me to give up and asked for
ideas, Junio responded that we should rip out dirent.  I think he's
right, and it's important the he defend code quality and point out the
right way to do things, it's just that I want out of this rabbit hole
right now.

[1] https://lore.kernel.org/git/20180405173446.32372-1-newren@gmail.com/
[2] https://lore.kernel.org/git/xmqqefjp6sko.fsf@gitster-ct.c.googlers.com/
[3] e.g. https://lore.kernel.org/git/20190905154735.29784-10-newren@gmail.com/
[4] https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
and links referenced therein
