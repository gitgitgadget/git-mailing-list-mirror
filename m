Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC7C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 14:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiKBO3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiKBO31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 10:29:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FAA2B247
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 07:29:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id t10so1658067ljj.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3anSokcwKq14XpyM501sEPWXUIT4XLqeVuH9IkH1MWs=;
        b=kvEmvH+h5wF/0kWV+bC3dPKs38yyX+9Se2hfCp2CCfr7cTd5EFV+qUhHpG+FxSeGT9
         J6NZ6oia7BCklB69zUcUEQ1AMrM66DBueoxVE2R/wOinntNsA5gtHDtBrNdMrL1ajjJZ
         OHuJ3i7kpwEM0gBWoE8+ClM/xtJS7lga0BI1ZKvRQ+wwQ5Uc44Rtcevguig6yLDK1Mnr
         0g/k/+b8Esl0B7+StrJJHLHPkqbfqfx3IXOVCU1+RFKTU9uCb8G5DLUss4TTc059Swsd
         FQSso5NqugztVFWuk9Tuwe9h7lmzec6iM3E2rEntC9PEI7oK0YVkkQ2UtYv3ThltUk+1
         xgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3anSokcwKq14XpyM501sEPWXUIT4XLqeVuH9IkH1MWs=;
        b=UPX+rt2/CSYFIV4tk3LT/q4crn6MxaCth7+STvEAzzBXDwtxYjdAVSoQ+A61pO215W
         tjGshiY7KmL8ijru1LwCv4vj4sPNCc5MSLuDwx9G23FIXf46ubsiYwjtsT/QQ6vLc0Io
         itnhBpX92UMjpXScN3LaVhIIz5O9hrsXrq+PuVQoWPBQ0oo5HugCyBdCAa9PM+x5NY6/
         mSjZmteJqbvDv5gPoVT36ik43GAikkdnGdTHZUgpnf+fOEByInxgJN2IgkiT79HNEK09
         IMtIUUUduJGdp5NBi6srpC3N8JUPsUPpKw1I1b4JXRHQBqTzygVI5K78X4hg/DMykGcC
         3aYA==
X-Gm-Message-State: ACrzQf1uua09STMQUW7zn6uyhZQvI52rgE0VgkG7ZWqAPwNvC396NCBK
        69Ecpjvc5XzDV7yZx5fMt8EzasiaYal7VQaFHpwrQVI1o68pZ/xh2Kg=
X-Google-Smtp-Source: AMsMyM4LQr+CjzKs/Lg2WREIjkcyjFI9KcLvtZT4gZ3rnT6NUVVWoo3RPW03MHTbuexWmGT1wJGYGslBvkKVSxsfkbA=
X-Received: by 2002:a05:651c:2051:b0:277:6385:b6d9 with SMTP id
 t17-20020a05651c205100b002776385b6d9mr4231932ljo.285.1667399350411; Wed, 02
 Nov 2022 07:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <221101.86bkpq4jan.gmgdl@evledraar.gmail.com> <20221102141609.1603860-1-matheus.bernardino@usp.br>
In-Reply-To: <20221102141609.1603860-1-matheus.bernardino@usp.br>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Wed, 2 Nov 2022 11:28:59 -0300
Message-ID: <CAHd-oW5yBLfO-qTS9K57GjjYNUuu+zxon4xEEE6r7k4P8XERVw@mail.gmail.com>
Subject: Re: Consist timestamps within a checkout/clone
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, mark@xwax.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Oops, I accidentally sent this from my business account. I'm
quote-replying it now from my correct personal account just in case
the original falls under spam folders for "spoofing".]

On Wed, Nov 2, 2022 at 11:16 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> > On Mon, Oct 31 2022, Mark Hills wrote:
> >
> > > On Mon, 31 Oct 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > >
> > >>
> > >> On Mon, Oct 31 2022, Mark Hills wrote:
> > >>
> > >> > Our use case: we commit some compiled objects to the repo, where c=
ompiling
> > >> > is either slow or requires software which is not always available.
> > >> >
> > >> > Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS u=
pgrade)
> > >> > we are noticing a change in build behaviour.
> > >> >
> > >> > Now, after a "git clone" we find the Makefile intermittently attem=
pting
> > >> > (and failing) some builds that are not intended.
> > >> >
> > >> > Indeed, Make is acting reasonably as the source file is sometimes
> > >> > marginally newer than the destination (both checked out by Git), e=
xample
> > >> > below.
> > >> >
> > >> > I've never had to consider consistency timestamps within a Git che=
ckout
> > >> > until now.
> > >> >
> > >> > It's entirely possible there's _never_ a guarantee of consistency =
here.
> > >> >
> > >> > But then something has certainly changed in practice, as this faul=
t has
> > >> > gone from never happening to now every couple of days.
> > >> >
> > >> > Imaginging I can't be the first person to encounter this, I search=
ed for
> > >> > existing threads or docs, but overwhemingly the results were quest=
ion of
> > >> > Git tracking the timestamps (as part of the commit) which this is =
not;
> > >> > it's consistency within one checkout.
> > >> >
> > >> > $ git clone --depth 1 file:///path/to/repo.git
> > >> >
> > >> > $ stat winner.jpeg
> > >> >   File: winner.jpeg
> > >> >   Size: 258243          Blocks: 520        IO Block: 4096   regula=
r file
> > >> > Device: fd07h/64775d    Inode: 33696       Links: 1
> > >> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ lu=
thier)
> > >> > Access: 2022-10-31 16:05:17.756858496 +0000
> > >> > Modify: 2022-10-31 16:05:17.756858496 +0000
> > >> > Change: 2022-10-31 16:05:17.756858496 +0000
> > >> >  Birth: -
> > >> >
> > >> > $ stat winner.svg
> > >> >   File: winner.svg
> > >> >   Size: 52685           Blocks: 112        IO Block: 4096   regula=
r file
> > >> > Device: fd07h/64775d    Inode: 33697       Links: 1
> > >> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ lu=
thier)
> > >> > Access: 2022-10-31 16:05:17.766859030 +0000
> > >> > Modify: 2022-10-31 16:05:17.766859030 +0000
> > >> > Change: 2022-10-31 16:05:17.766859030 +0000
> > >> >  Birth: -
> > >> >
> > >> > Elsewhere in the repository, it's clear the timestamps are not con=
sistent:
> > >> >
> > >> > $ stat Makefile
> > >> >   File: Makefile
> > >> >   Size: 8369            Blocks: 24         IO Block: 4096   regula=
r file
> > >> > Device: fd07h/64775d    Inode: 33655       Links: 1
> > >> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ lu=
thier)
> > >> > Access: 2022-10-31 16:05:51.628660212 +0000
> > >> > Modify: 2022-10-31 16:05:17.746857963 +0000
> > >> > Change: 2022-10-31 16:05:17.746857963 +0000
> > >> >  Birth: -
> > >>
> > >> I think you're almost certainly running into the parallel checkout,
> > >> which is new in that revision range. Try tweaking checkout.workers a=
nd
> > >> checkout.thresholdForParallelism (see "man git-config").
>
> This does look like something you would see with parallel checkout, yes.
> But...
>
> > > Thanks, it will be interesting to try this and I'll report back.
> >
> > FWIW I was under the impression that we'd made it the default, so unles=
s
> > you opted-in it's probably not that.
>
> ... it indeed should be disabled by default. It seems Mark didn't
> manually enable parallel checkout, as the original message only mentions
> the git upgrade as a changing factor. And Alpine's git installation
> script for 2.32.4 [1] doesn't seem to change our defaults either.
>
> Perhaps, it just happens that 2.32.4 changed the checkout processing
> time slightly so that each entry is finished a bit slower (or the system
> was overloaded at that moment?). Anyways, the creation order (based on
> the mtimes) looks correct to me from a sequential-checkout point of
> view: first Makefile, than winner.jpeg, and finally winner.svg. That's
> the order in which these files would appear in the index, which is the
> order followed by sequential checkout.
>
> [1]: https://git.alpinelinux.org/aports/tree/main/git/APKBUILD?h=3D3.14-s=
table&id=3D0f3285f2cfcb8362460002c27e219fadbf18c885
