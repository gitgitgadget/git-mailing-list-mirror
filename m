Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA18C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 03:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiCADuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 22:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCADuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 22:50:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0C2182F
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 19:49:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f8so8147185edf.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 19:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sCUjjhu9lkQ6SZoV/vqGVT11h4aKdr6tI8Hh86xr1XA=;
        b=QcA31aQ0JEULkDqDZFIBopQmrd7z7F3QBALbHwBGevQXschVwFtTLVdeYdd4JPBWoR
         3ub+5IJiAE+65gRgGLRSoq1U8OCnmu7QeT8E7J/FQQymaQCN6gOWjXvfUBECPQ+u5z/s
         ifF6ojKgNuTA4QD/iBTH5bLhIOOTcjjph5SLwbU9AhPcAEwU5TjpXxQqMxj9cYdyM6zf
         AxGE3tEklyiZIo91vkFwho+qC+OwqcCY3onGyIM9PWZArxfLP/GkRjg1eSilYSnf0MM9
         YLYijuTPLO0sB0WsYeaQIIx0ef6GH7l++waZcD8ZUTSMLK1u2J9iMXui7Yc1rKI/lDzz
         kzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sCUjjhu9lkQ6SZoV/vqGVT11h4aKdr6tI8Hh86xr1XA=;
        b=Kqx5YXY836TBOBLxe5Chc9TIl7ydOya4F3h6jlW1pAeoBRkGcvqjrV8uf0BURxHrWi
         5J2ntcwx1wb50EoTzDnCJQhSODp6lX0WqeWyGHf/Y7acVSx7G0ctApz2h+lSOnMfsuMb
         VeiC3ipnlQRMc3jF2TQ8vUdP6lScCVmd3PEMrCzT2EnRWZefzlqXrEsBokDw6VChhWPk
         aTgSlWNawrAVLzGDHs4vNRBB3gsT+2yhCUBe811nEZAmowSvu1JS2EgEb8JmUoYmRqHA
         BRZNnV5M+hMRa6GD0+w1DAH9HKfMnGl51PYCWKxRERfEykP7hqS5UTMu+fKLxAA3CMLv
         ZPuA==
X-Gm-Message-State: AOAM533UdVcmukR/KkLHbo0OVPcbzGJZOEkkRjlTtWNfcJleFqFTxcAK
        V6AEa6i3o3vplXoVYmPAO1CHopXbSBVFJalDSM1KC2EmWsM=
X-Google-Smtp-Source: ABdhPJwyYC3pK3OTcwWOA7LcW4D5UyG79HcFsJvyU/50DCjXPC67K4pGNrFkxhX67A/UsQ2YTJW1C6TIdluNmg7fkuI=
X-Received: by 2002:a50:ee86:0:b0:410:9aa1:1a26 with SMTP id
 f6-20020a50ee86000000b004109aa11a26mr22801990edr.153.1646106571991; Mon, 28
 Feb 2022 19:49:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <220221.86y224b80b.gmgdl@evledraar.gmail.com>
 <CABPp-BFc=hcWz1BMW7fAR=Zp3fQ3vxvBtnSYESreYwef_v1K5g@mail.gmail.com> <220228.86sfs35ojn.gmgdl@evledraar.gmail.com>
In-Reply-To: <220228.86sfs35ojn.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Feb 2022 19:49:20 -0800
Message-ID: <CABPp-BG25_TutatgNmK6vgq3akxpYHQ8QBnz-65_F_3oCA1nJA@mail.gmail.com>
Subject: Re: machine-parsable git-merge-tree messages (was: [PATCH 08/12]
 merge-ort: provide a merge_get_conflicted_files() helper function)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 1:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Feb 22 2022, Elijah Newren wrote:
>
[...]
> > I don't see how this helps solve the problem Dscho was bringing up at
> > all.  Your reference to "the path" means you've missed his whole
> > complaint -- that with more complex conflicts (renames, directory/file
> > conflicts resolved via moving the file out of the way, mode conflicts
> > resolved by moving both files out of the way, etc) there are multiple
> > paths involved and he's trying to determine what those paths are.
> > He's particularly focusing on rename/rename cases where a single path
> > was renamed differently by the two sides of history (which results in
> > a conflict message only being associated with the path from the merge
> > base in order to avoid repeating the same message 2-3 times, but that
> > one message has three distinct paths embedded in the string).
> >
> > Also, the additional paths is not part of the API to path_msg; it's
> > merely embedded in a string.  (And, in case it bears repeating: as
> > mentioned elsewhere, we cannot assume there will only be one
> > path_msg() call per path, and we at least currently can't assume that
> > each path_msg() call is for a separate logical conflict; there might
> > be two for a single "conflict".)
> >
> > I agree that parsing these meant-for-human-consumption (and not
> > promised to be stable) messages is not a good way to go, but
> > pretending the current API has enough info to answer his questions
> > isn't right either.
>
> The intent here wasn't to present a complete solution, but to reply to
> the part of Johannes's E-Mail that e.g. mention "and I would be loathe
> to switch _all_ callers to do the quoting themselves.".
>
> I.e. it's a POC for passing this data further up the stack. The issue
> you mention with the renaming case could/should be handled by having
> whatever handles the vargs accept those N arguments, the POC doesn't
> handle it.
>
> But in any case, needing to convert "28 calls to [path_msg()]" doesn't
> seem like it's required.

The problem isn't that it's an incomplete solution, it's that AFAICT,
the user's stated problem is not aided at all by this POC.  Passing
existing data further up the stack cannot solve the problem if the
data being passed is insufficient for the problem at hand.

Perhaps you have some clever solution to get the extra information,
though?  Could you elaborate on how path_msg() could handle its
varargs differently to deduce which of those correspond to paths?  The
only way I can see how to do that, short of modifying all 28 callers
of path_msg() to pass those paths as additional information, is hacks
like parsing the (non-stable, not-meant-for-machine-parseability)
format string.

(Getting the paths would get us most of the way to a solution, though
it's still incomplete.  But it's the relevant bit under discussion
here.)

> But obviously we wouldn't want to use trace2 as a plumbing layer for
> message passing, but could format the same data in a similar way,
> especially in the context of a discussion about filenames with odd
> characters in them (some of which JSON is inherently incapable of
> encoding).
>
> >> I think that would be particularly useful in conjuction with the
> >> --format changes I was proposing for this (and hacked up a WIP patch
> >> for). You could just have a similar --format-messages or whatever.
> >>
> >> Then you could pick \0\0 as a delimiter for your "main" --format, and
> >> "\0" as the delimiter for your --format-messages, and thus be able to
> >> parse N-nested \0-delimited content.
> >
> > To be honest, the --format stuff is sounding a little bit like a
> > solution in search of a problem.
>
> Opinions on this obviously differ, and I'm not going to pick this as my
> particular hill to die on :)
>
> But I do think it's the other way around, in that hardcoded output
> formats are a problem requiring solutions.

I might be more convinced if folks tried to address how to output
things _after_ we had determined *what* things should be output.  If
we don't have sufficient information to solve what users want,
discussing how we format the information we do have cannot help solve
the actual problems.  It might be useful as an add-on later, but
discussing it first is putting the cart before the horse.
