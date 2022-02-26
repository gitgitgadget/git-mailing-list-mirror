Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0538EC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 06:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiBZGyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 01:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiBZGyR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 01:54:17 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8C81A7D84
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:53:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p14so14809833ejf.11
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gI70R8hAQfDmY9SpOPaOcyBPLDQfTZUt7NSUQtWN/hI=;
        b=WOmMpO9Nyle0loWIZnYm8jhrGry2h2OW837T9kcSN1//TxC6SzaVED36o+HbSzDB23
         EM9HywNgxg2wVJIcRKpO6AOmvN8vVsvYR2A7PzWSwXBRBS5/3BPuHJ7BcHhOF03koGAR
         47emg5jo5KA6prvcG+yr7mkkfoRSzUBV7XbxeTx7KKEQzq1JypdxFMGOsjPIKpmWS14f
         a4+E1Xn1QxLly7jMO+xImQQ6xI/LsEr4rycTIhAqOn40VJDwAoxTH4FBg+RHfz/lgHBT
         bGB3uRWhFKLRBUikXg2Nct4okOVJ1jGqKqhv5GGegsOBWhxw54YDXh+XgQzDwtEXNnRj
         +kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gI70R8hAQfDmY9SpOPaOcyBPLDQfTZUt7NSUQtWN/hI=;
        b=KOB7TT8RfY9aKVwSGTh94EOfTtnbXqa36T0EDwlq3NZ/Vg3KTGDL9g/seJZ7MHLhnf
         RcpM7/KuN0VRtlrzrVh0jCqoka44wzYHpDGkS2wsTjPDJVOJdRAI93lKHNhsx6JTC6fw
         rXAP19/cKxzCqUNnTZEtV6tXfqu7H+2Tu9tmzSHnt6Jge0Zfv1He4n5lAkhAmk11PN43
         zX5Riw0tjRn2Ko52UAXEoivt5On5iplW/ZSS1W1nUklYtSQhxqxNX4mYGmwwJUg7nj6S
         5lNgHuT9+5/az/CLOmcNtvxD32jGFNBquEGnX/xepH8HadTQZVFplQ7JmBLEffYAliMD
         qgWw==
X-Gm-Message-State: AOAM5319Nxw4y1qcTkflKp2jmaF3DqshsUhwaDWWARV4Rp4ht6vh2Ut6
        pzgRB4ez7oj3lMCxg67CxkDV1XlMRaoWJYtvO2o=
X-Google-Smtp-Source: ABdhPJy/oYrfug9uAyrKj2y9x7twFb+z3YprJx12UcdIqpNBfXzcQOHIBDCeXPEZhvc3NOwKLKA8asaLdaoExr3nR10=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr8919265eje.328.1645858420518; Fri, 25
 Feb 2022 22:53:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 Feb 2022 22:53:28 -0800
Message-ID: <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
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

Hi Dscho,

On Fri, Feb 25, 2022 at 8:31 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 22 Feb 2022, Elijah Newren wrote:
>
> > Sidenote: Do you lump in binary merge conflicts with "non-semantic
> > merge conflicts"?  You would by your definition, but I'm not sure it
> > matches.
> >
> > I tend to call things either content-based conflicts or path-based
> > conflicts, where content-based usually means textual-based but also
> > includes merges of binaries.
>
> I like "content-based conflicts".
>
> And no, I had not even thought about binary merge conflicts yet...
>
> > On Mon, Feb 21, 2022 at 2:46 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Concretely: while I am not currently aware of any web UI that allows
> > > to resolve simple rename/rename conflicts, it is easily conceivable
> > > how to implement such a thing. When that happens, we will need to be
> > > able to teach the server-side code to discern between the cases that
> > > can be handled in the web UI (trivial merge conflicts, trivial
> > > rename/rename conflicts) as compared to scenarios where the conflicts
> > > are just too complex.
> >
> > Um, I'm really worried about attempting to make the conflict notices
> > machine parseable.  I don't like that idea at all, and I even tried to
> > rule that out already with my wording:
> > """
> > In all cases, the
> > <Informational messages> section has the necessary info, though it is
> > not designed to be machine parseable.
> > """
> > though maybe I should have been even more explicit.  The restrictions
> > that those messages be stable is too rigid, I think.  I also think
> > they're a poor way to communicate information to a higher level tool.
> > I would much rather us add some kind of additional return data
> > structures from merge ort and use them if we want extra info.
>
> Okay.
>
> I thought that we could keep the `CONFLICT (<type>)` constant enough to
> serve as such a machine-parseable thing.

That _probably_ is, but I thought you wanted to parse all N paths
embedded in the message after that part as well?

> And then presenting
> `<path>NUL<message>NUL` could have served my use case well...

Would it?  Wouldn't you need something more like

<number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-description>NUL<message>NUL
 ?

I mean, if rename/rename is what you want to handle, there are three
paths in that message.  And you need to know all three paths in order
to combine the relevant parts of the <Conflicted File Info> section
together.

(Also, while we're at it, I decided to throw a stable short-type
description string (e.g. "CONFLICT (rename/rename)") in there, which
will _probably_ be the first part of the message string but still
allow us to change the message string later if we want.)


Also, we'd want those parsing this information to keep in mind that:
  * Any given conflict can affect multiple paths
  * Any path can be part of multiple conflicts
  * (The above two items imply a potentially many-to-many relationship
between paths and conflicts)
  * Paths listed in these logical conflicts may not correspond to a
file in the index (they could be a directory, or file that was in a
previous version)
  * Some of these "logical conflicts" are not actually conflicts but
just notices (e.g. "auto-merging" or "submodule updated" or "WARNING"
or "<submodules are weird>" messages)

and we'd have to do some work to make sure the paths in the given
messages lined up with the files actually recorded in the index (e.g.
with distinct types we rename both files to avoid the collision, but
print the conflict notice for the original path rather than the new
paths)

[...]
> > But I'm going to reserve the right in merge-ort to modify, add, or
> > delete any of those messages passed to path_msg(), which might wreak
> > havoc on your attempts to parse those strings.  I think they're a bad
> > form for communicating information to a script or program, and trying
> > to transform them into such risks making them suboptimal at
> > communicating info to humans.  These messages should optimize the
> > latter, and if we want something for the former, it should probably be
> > a new independent bit of info.
>
> Makes sense.
>
> So we need something in addition to those messages.

Yes.  Does the proposal above sound like it'd cover your needs?  If
so, we'd probably need to go through all the callers to path_msg() and
either add an immediate call to another function immediately
afterwards that stores this additional information or somehow change
the path_msg() call itself to somehow take an additional arbitrary
list of arguments representing the paths and short-desc we want to
store somewhere.
