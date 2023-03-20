Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F4CC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjCTQ0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjCTQZx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B0C301AC
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:18:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h9so12742676ljq.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twx6/HNO6pawdlwLquYjrkqpRou21MjS9R2H689KiCU=;
        b=aNlvfdbpJid+3EJIDiXiCdtURd0Ptcm28/w4eQsOVsWZekcJgnnYqQCmKnnc9FH/YJ
         vx68GtNHedcYNiLjk/EqL64/5p0HT3BFdW4+whNtTAiXaO1Cfc6CRoZWxpc0Xpp/SEYe
         Fqr94vYqM/gtKaDxb/YwkXpm2uAvQQ3hXQFCSjk9z/TyHin15rT9o8/KeLPj7wB7KayC
         Z4Hv+VBamNadgCUV7HhhHdxCqxEhUWM4+IGn/4AXnihkK0u5BT7vH+/NjYo4chBJjkKm
         EFrEpgDfprUn0rREIraCNN+MqHEw5347Ay68MQnKus6DrdPh8TwdWXbH4EqEMnzsgMVP
         ejEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Twx6/HNO6pawdlwLquYjrkqpRou21MjS9R2H689KiCU=;
        b=F69HTjYW4py0hT6wo1j9xHIrZfEQu5l+R8cSbw3puRjlyGjgki3RaGwbx44M5bvtxj
         YIASJmHZXqFWQROBSitUBTUI6MopC3ALaMWp3xIty8z4X9xSxrz/T9pFA/AB8YWqNOfm
         EOmjJ9FoYJdKrll/HUAqRa2I1AdukizuqQt5GKj6A1+Dan7z1r6EQOmp9tom0Xh23R9o
         DiqfKS6VEX3w/nTkFf0Zw6y1oAskGRkPUoh8UQ39jIPLCd4yqrWn5i7OsjSq7OMYIDQj
         F9EPHyUpBb8s6EVkt3jUAF39xTk8rYKeXLLYagtGILTheeIn3s+auug6p+cdTdqTAKl6
         Q4RQ==
X-Gm-Message-State: AO0yUKWKtCcEir2Gw78kQlZndubdd4pv9h6TojvO3rr5k9hy0l6WpgZK
        mwOySJZgIGThc7m/zyBLN3cU0pUX9Z9ln9tfnCpsfqOJKFmdcw==
X-Google-Smtp-Source: AK7set8AD5QwGmKYTkBzm0/TktAKgNsjUnvDVBLfYaNHgf30RYtMAqRRJUt5Rp9LJlpijjuSyB3rbhqSQJ/61XavLLY=
X-Received: by 2002:a2e:9d54:0:b0:298:6f39:21de with SMTP id
 y20-20020a2e9d54000000b002986f3921demr39629ljj.3.1679329136280; Mon, 20 Mar
 2023 09:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com> <230320.86v8ivwvx3.gmgdl@evledraar.gmail.com>
In-Reply-To: <230320.86v8ivwvx3.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Mar 2023 09:18:44 -0700
Message-ID: <CABPp-BFZBWTG1VF6N8teVMYxoUdOeciKGwPq1g-G1K5--My5uQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] Header cleanups
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Mon, Mar 20, 2023 at 3:37=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
>
> On Sun, Mar 19 2023, Elijah Newren via GitGitGadget wrote:
>
> > This series picks up where en/header-cleanups leaves off and does more
> > header cleanups, trying to reduce the number of files depending on cach=
e.h.
> > (There are still more that could be done, but again, this is a good chu=
nk
> > for now.)
>
> > Elijah Newren (16):
> >   treewide: remove unnecessary cache.h inclusion from a few headers
> >   treewide: be explicit about dependence on gettext.h
> >   treewide: remove unnecessary inclusion of gettext.h
> >   treewide: remove unnecessary cache.h inclusion from several sources
>
> I couldn't seem to square what you were doing in 2/16 with what 4/16
> does, but I think the "issue" is that the commit message for 4/6 doesn't
> match at least one change it's making, i.e.:
>
>         By making those files explicitly include gettext.h, we can
>         already drop the include of cache.h in these files.
>
> But in fact compat/linux/procinfo.c at least (I didn't do more than skim
> the others) isn't like the rest, in that it doesn't need gettext.h at
> all.

Yeah, there were apparently pre-existing headers that did not need
cache.h, so my script to find the ones that "no longer need it" after
some changes identifies not only the ones that can be cleaned out due
to the gettext.h changes but the ones that could have been cleaned up
beforehand.  Maybe I should do a preliminary patch that removes
cache.h from some headers, then do the gettext changes, then this
patch becomes clearer.

Or I can tweak the commit message to just spell out we already had
some headers that didn't need cache.h, so this patch just combines
those cleanups.

> I also find the ordering hard to follow, but it's ultimately correct in
> the cases I looked at. E.g. for ref-filter.c your 1/16 does:
>
>         -#include "git-compat-util.h"
>         +#include "cache.h"
>
> Then 2/16 does:
>
>         +#include "gettext.h"
>
> So I wondered, wait a minute, didn't we just end up over-including
> cache.h because we needed gettext.h, which the later commit adds?
>
> But no, that's not the case, because as 1/16 notes ("on things from
> cache.h[...]") we need *other* things from cache.h, so this is
> ultimately correct.
>
> Still, given that, I for one would have found this easier to follow if
> commits like 2/16 came before the 1/16, i.e. let's first be explicit
> about e.g. gettext.h, and then change git-compat-util.h inclusions to
> cache.h, to clearly note in the progression that the two are distinct.
>
> But this is also fine with me if you don't agree, or can't be bothered
> to re-roll it.

In my mind, 1/16 probably belonged in en/header-cleanup that was
already merged to master and was an oversight that made other cleanups
I was trying to do harder.  The gettext stuff was new stuff I was
doing to make other things in this series easier, so I placed it right
after 1/16.

But, I can see your point of view, and I don't feel strongly about the
order of these patches.  I'm happy to switch them around.

> As a more general note on the direction here: I have some old WIP
> patches to do similar split-ups of cache.h, but in doing those I was
> trying to first identify cases where we had a function in cache.h that
> was used by the low tens of our ~500 *.c source files.
>
> E.g. advice.h is such a case[1], ditto wildmatch.h. Then we have case
> like ws.c[3], base85.c[4] and pager.c[5] where there's no corresponding
> header, but we should probably create one (which those WIP commits of
> mine do).

Here was my approach:
  * Identify a *single* file that I know that makes no sense to include cac=
he.h.
  * Try to figure out why and fix it...but also fix *all* other files
that have the same nonsensical dependencies throughout the entire
tree.
  * (And maybe also fix a few extra things you find along the way that
repeatedly turn up).

For my first series (en/header-cleanup which is now in master), I was
looking at diffcore-rename.c.  17 patches later it was clean.

For this series, I was looking at strbuf.c.  It would have been clean
at the end, but while waiting for my first series to merge to master,
you submitted your series which conflicts.  So I dropped some of the
changes, but submitted the rest.  (And the gettext.h changes
originally weren't at the beginning of my series, but then I noticed
they repeatedly were additional squashed-in changes that made things
harder for others to review, AND harder for me to figure out (see
below), so I went back and made the gettext changes into a preliminary
big cleanup.)

Your approach also makes sense, I've considered it before and still
have it in my backlog, but this series focused on making strbuf.c
clean and was already long enough, so I'm deferring those other
changes to later.

> Whereas this approach feels like the opposite of that, i.e. at the end
> of this series we're including gettext.h in more than 250 files.

The idea to "fix all other files with the same nonsensical
dependencies" was heavily impeded by gettext.h.  I had scripts to
optimistically change "cache.h" to "git-compat-util.h" and try to
compile.  For those that only gave warnings rather than errors, I
needed to wade through pages of gettext-related undeclared warnings,
to see the other dependencies in the file.  So, making gettext
dependencies explicit just made it vastly easier to do all the
subsequent cleanups.

> Stepping back a bit, I think our use of cache.h falls into a few broad
> categories:
>
>  A. Things to do with the index (we should probably create an index.h
>     for those).
>  B. Used almost everywhere, i.e. "cache.h" can be though of as "git.h",
>     or "common-utils.h" or whatever.
>  C. Things used almost nowhere, or only a handful of places,
>     e.g. wildmatch.h and others noted above.
>
> Part of this series is a frontal assault on the "B" part of that. I
> think if we're going to include gettext.h explicitly everywhere we're
> probably saying by extension that no such thing as a "common header"
> should exist.

There might be a way to have a common header that doesn't devolve into
a dumping ground of all dependencies the way cache.h has become, but I
think we'd need to be really careful.  I think git-compat-util.h would
obviously make sense to include in such a thing.  You might be able to
convince me that gettext.h should be in such a thing, but I'm not even
sure about that: we have more C files that do not use stuff from
gettext (321) than those that do (245).

I think cache.h is really far from what we want.  It has often tripped
me up in trying to understand the code, often results in needless
compile-everything loops when making simple changes, is an impediment
to any potential libifying or code-sharing exercise (I was hoping that
e.g. merge-ort could be shared with other projects instead of being
reinvented), and makes other interesting exploratory hacking harder
(e.g. I've toyed with the idea of speeding up merge-ort or other parts
of the code by rust-rewrites for self-educational purposes and
wondered why the code depended on so many things).

The focus of this series was not B; it was just "remove the cache.h
header from strbuf.c, and from any files that depend on cache.h for
the same dumb reasons".  However, even though it wasn't the focus of
my series, I would have to say that you are right that I don't believe
in having a dumping ground of "common" includes as I think it just
gets littered with things that aren't actually common.  I may well
submit future series explicitly assaulting part "B".

> Which I'd be fine with, I just personally never thought it was much of a
> practical problem, i.e. to have the gettext.h's in our tree included
> "everywhere", ditto "strbuf.h", and even "enum object_file" and other
> "mostly everyone wants these".
>
> Whereas it is rather annoying that we over-include things in cache.h, or
> even have cache.h include other headers, as often minor changes to
> related libraries result in a full re-build.

The time to rebuild the code is one concern, but wasn't even my primary con=
cern.

> But maybe "B" isn't sustainable at all, and I'm just fooling myself
> thinking we could have such a thing.
>
> A nice thing I hadn't considered is that after your topic e.g. removing
> the gettext.h inclusion from parse-options.h will compile *most* of git,
> but we'll fail e.g. in:
>
>         t/helper/test-parse-pathspec-file.c: In function =E2=80=98cmd__pa=
rse_pathspec_file=E2=80=99:
>         ./parse-options.h:209:40: error: implicit declaration of function=
 =E2=80=98N_=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>           209 |                                        N_("file"), (h) }
>
>
> So as we don't want gettext in t/helper/* it's nice to get *an* error
> about that.

I don't see why that's a "nice thing"; it doesn't even make sense to
me as being a useful thing to try.  parse-options.h has several macros
that explicitly call N_().  Even if the code compiled with that
proposed change (because no one used those particular macros), it'd be
a bad idea unless those macros were first deleted or modified to not
depend upon gettext.h.  Since the file clearly depends upon gettext.h,
I think it should explicitly include it.

(In general, I believe if you depend upon something, you should
explicitly include it.  I was convinced otherwise for
git-compat-util.h and header files[1], but I hold that as the only
exception until others have solid reasons for other headers being
special.  In fact, I'd like to change the coding guidelines to state
that you should directly include any headers you use, with the
exception of git-compat-util.h in other header files.  We're just too
far away from that right now for it to be realistic.)

[1] https://lore.kernel.org/git/CABPp-BHizCj2e454w3vtHrDNip3Rm-gUMT0oJiAsbk=
Avr_QvVA@mail.gmail.com/

> So, in the end I think I've convinced myself that even the "B" in that
> "A..C" is a bad idea.

Was this based only on the mistaken idea of removing gettext.h from
parse-options.h, or on other factors?
