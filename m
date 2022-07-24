Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D4C433EF
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 05:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiGXFXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 01:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXFXX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 01:23:23 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F24115A17
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 22:23:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h18so6216252qvr.12
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SCU9uR/P/BjG69az+Ws0imHFJWATFlf9aAKSmx6GKGs=;
        b=fnY/VKV2sQBtEQnEZybcqrkS/4Y3GRi4bPTpLI3poiIR2C366wmRJ0UpXMWOZ1iBls
         9+viAeffaQDIvu8BHPmALmhuTXyPhRUkgP9sCdOXXSK3MEuS2yk8VaT9by+Uj9jX4R4A
         lZfYJjoYX4UnlWNDHguI/n9cUdxc14D+YKsTazSvJZgqMZlJEbkkEzUdyMFB+ZAYyiOi
         XycD2Dqls11gS2L7csslIiBA4ToIga+N/9RQTKQ6iZWaNtR1Yyx7ggKcff7AORIcd3Xk
         5qV+kqIGTYI/8PgGg4IKKm3rF4KfPeJ+hu6lII10cFEk2Bd4l/4ZpDEw2j30WnUQ0c39
         yILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SCU9uR/P/BjG69az+Ws0imHFJWATFlf9aAKSmx6GKGs=;
        b=2LS8uAkT2T14Vgec4UGipA80OjmkmbxJoxeQ46Y+9VBkHBcNFXDPWQg5cf20eZPLCx
         wBSyCo60TYo/YfD0LLa7HiQtLNFALDYfqCr9Pj04PxBxgUI5Y/Y5zJWI9FBdZ0CwQMae
         BO7vwerKz4Ahd3OlmeAu2NZzVUPdFH00nl57aYFAAKO5fohOgmMPQENH+MtqvG8GU3j1
         izpH4dplPqqn0qQ44O5LysscaPebNQW1byY0BP5bbHKZWHMDubBY7VLdYo2U14CQqgaf
         iw0Jq50zewvcpAwF4sRI3RqRdGQE5W3JrvH8mnb9lL04KwfeyGw97O3WcI3xGkc61z7S
         lDVw==
X-Gm-Message-State: AJIora+JXex/4qHNG2pV037f2mcF0NxowxtI80Iasz4plUBvq/uE6Om6
        MY+xPCYjC0Z5fqeDBuSBHziwzEO3eKz4GDzdv0c=
X-Google-Smtp-Source: AGRyM1v/2oVOaoFbxKZp/EFlxDGx98HiDG1TVf96FfRNVApKrYjgVPfPfp5YEkuh4KE4bBZoUcOEfUH2/OKvQJTMuv8=
X-Received: by 2002:a05:6214:21ec:b0:473:951b:5203 with SMTP id
 p12-20020a05621421ec00b00473951b5203mr5759393qvj.65.1658640201131; Sat, 23
 Jul 2022 22:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com> <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email> <20220722203642.GD17705@kitsune.suse.cz>
 <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com> <20220723070055.GE17705@kitsune.suse.cz>
In-Reply-To: <20220723070055.GE17705@kitsune.suse.cz>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jul 2022 22:23:09 -0700
Message-ID: <CABPp-BEYQOtr6EZmi4emKRKNVXS3071Ud90jiLycdGXGG+YqgQ@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2022 at 12:44 AM Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> On Fri, Jul 22, 2022 at 03:46:22PM -0700, Jacob Keller wrote:
> > On Fri, Jul 22, 2022 at 1:42 PM Michal Such=C3=A1nek <msuchanek@suse.de=
> wrote:
> > >
> > > On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
[...]
> > > > Part of the rename problem is that there can be many different rout=
es to
> > > > the same result, and often the route used isn't the one 'specified'=
 by
> > > > those who wish a complicated rename process to have happened 'their
> > > > way', plus people forget to record what they actually did. Attempti=
ng to
> > > > capture what happened still results major gaps in the record.
> > >
> > > Doesn't git have rebase?
> > >
> > > It is not required that the rename is captured perfectly every time s=
o
> > > long as it can be amended later.
> > >
> >
> > Rebase is typically reserved only to modify commits which are not yet
> > "permanent". Once a commit starts being referenced by many others it
> > becomes more and more difficult to rebase it. Any rebase effectively
> > creates a new commit.
> >
> > There are multiple threads discussing renames and handling them in git
> > in the past which are worth re-reading, including at least
> >
> > https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.os=
dl.org/
> >
> > A fuller analysis here too:
> > https://public-inbox.org/git/Pine.LNX.4.64.0510221251330.10477@g5.osdl.=
org/
> >
> > As mentioned above in this thread, depending on what context you are
> > using, a change to a commit could be many to many: i.e. a commit which
> > splits into 2, or 3 commits merging into one, or 3 commits splitting
> > apart and then becoming 2 commits. When that happens, what "change id"
> > do you use for each commit?
>
> Same as commit message and any trailers you might have - they are
> preserved, concatenated

Exactly how are they concatenated?  Is that a user operation, or
something a Git command does automatically?  Which commands and which
circumstances?  If users do it, what's the UI for them to discover
what the fields are, for them to discover whether such a thing might
be needed or beneficial, and the UI for them to change these fields?
This sounds like a massive UX/UI issue that I don't have a clue how to
tackle (assuming I wanted to).

> and can be regenerated.

"can be".  But generally won't be even when it should be, right?

Committer name/email/date basically don't even exist as far as many
Git users are concerned.  They aren't shown in the default log output
(which greatly saddens me), and even after attempting to educate users
for well over a decade now, I still routinely find developers who are
surprised that these things exist.

Given that committer name/email/date aren't shown with --pretty=3Dfull
but with the lame option name --pretty=3Dfuller, I can't see why it'd
make any sense to show Change-Ids in the log output by default.

But if it's not shown -- and by default -- then it doesn't exist for
many users.  And if it doesn't exist, users aren't going to fix it
when they need to.

(Even if it were shown by default, it's not clear to me that users
would know when to fix it, or how to fix it, or even care to fix it
and instead view it as a pedantic requirement being foisted on them.)

I think the "many-to-many issue" others have raised in this thread is
an important, big, and thorny problem.  I think it has the potential
to be a minefield of UX and a steady stream of bug reports.  And
seeing proponents of Change-Id just dismissing the issue makes me all
the more suspicious of the proposal in the first place.
