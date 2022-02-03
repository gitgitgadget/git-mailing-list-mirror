Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3873C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352999AbiBCSK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiBCSK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:10:56 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F197C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:10:56 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id 60so6740197uae.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yswOX3ouJ1hykZ9zBJCrGzrUVpGdsEdgCdMvjG0FRwk=;
        b=cHESiLTQMovgpYutFbDwFLXidsX4I4p2Q1qLKHy+SZQGO8SLHbs20adaz9gyTefXFi
         KNm/Q6XUPnhcZS4BRp95g7Trn2zO0GmGj3rdUCFFck941BXaoBic6sqKva8ZKfvKTT7Y
         tzs00fYuKCDL7FzTm5T5TXhM4RrfUhyEPE0dzRqhBVRnULinT7IpHh27gQm0ybi5AmNa
         G3YrC+0PMp39uGXQRwbvDyVXM/36qD8nJwP5p6LijnI8F3Jn39saLBTsnJ+yadZYgaNU
         4BDbJHgCObQDzm/gyJJOjpMbYL0+/mX6CBk6+5fgU5Y24V300MzzF/N0zauONS0sBeyY
         ldpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yswOX3ouJ1hykZ9zBJCrGzrUVpGdsEdgCdMvjG0FRwk=;
        b=kWNCALMc/I5CW3W26zVmE1F1RVVDx7kNSou5Y2piyqdUa4Ka1lvXXhOwGNJPDRjogn
         cE9fAMQ7qvz+7Uawn5sZJnmEDsxMowdWPES1qzrUiWklcvEXvqHUmUtT3nCU4aITPvGB
         bLwnh1Ft5EljzlTBovtWDBVX7VA7na28eMEHUdGSUjK7s1aSzkC0F+IJjtFuPSAMReCA
         IiGZsD3BAYqakcQdDRqVkwxVoHfRGDJtOBh49NRBZ+7xe3WgdkLkdVbqV+CB0JOHYqmc
         wy5cM8D3Dm5kJ7EZignPG1CQiPTAYioKi/DFFXUwRrBnwR8v5kW1n8Cn761QpKB4utug
         UYYQ==
X-Gm-Message-State: AOAM530bQM8iQnSSbW+GS699623o0qqkC+1NnEp1AWdc2vs0OWwKT0ph
        pTfUn39rMbBz1PEw2PEcF7xzZPPawE4lhcv+ZOhgZw==
X-Google-Smtp-Source: ABdhPJzdFecB2ItqoFpUnyr9Mi65YREwLjSauW/xx4aia938f3MrHD5NX8fXZ7eXhJr/Rq4+mssNn9/Wrx4Z3pY1kiQ=
X-Received: by 2002:ab0:6946:: with SMTP id c6mr14189682uas.134.1643911855157;
 Thu, 03 Feb 2022 10:10:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
 <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
 <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
 <xmqqa6facn9i.fsf@gitster.g> <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
 <xmqqsft2b5jl.fsf@gitster.g> <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
 <220203.867dab6dmp.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.867dab6dmp.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Feb 2022 19:10:43 +0100
Message-ID: <CAFQ2z_MkZBtjViTsDNuKLYUXzFXJM6sPLOvXdiRAZrs84pggUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, lucamilanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 6:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> >> Yes.  It is exactly the point of the question I asked.  If it is
> >> simple and easy to add such a new type that is ignored/skipped by
> >> existing clients, then we can go that route.  If it is simple and
> >> easy to add a new bit per ref that existing clients would not barf,
> >> we can use that as an alternative implementation strategy.
> >
> > I'm not sure that there are any JGit clients: I committed reftable
> > support at the end of 2019. Before that time, we were running it
> > internally at Google, but only ref storage, and without the posix
> > part. Reflogs were never stored in refable, and I actually found a
> > couple of bugs in Shawn's Java code.
> >
> > Gerrit has increasingly started using Git as a database, and the
> > packed/loose system is just not a very good database, so that
> > motivates the work reftable in general. But the folks who run Gerrit
> > on a POSIX filesystem want to be sure that isn't a fringe feature, so
> > they only want to start using it once Git itself supports it. So there
> > is a chicken & egg problem.
> >
> > It's sad that we have to introduce an existence bit to make things
> > work, but overall it is probably easier for me to do than trying to
> > make sense of sequencer.c and how it uses refs/stash@{0}.
> >
> > Technically, the only obstacle I see is that we'd need to treat an
> > existence entry especially for the purpose of compaction/gc: we can
> > discard older entries, but we shouldn't discard the existence bit, no
> > matter how old it is.
>
> Ah, that's very informative. I had been assuming (or misremembered) that
> reftable was already seeing production use at Google. Perhaps I
> remembering the now-dead Google Code (or whatever it was called). Maybe
> not.

We use the format (the JGit code) at Google, but we only use it to
store refs, that is, the refname =3D> {SHA1, symref, tag} mapping. We
currently don't store reflog data in reftable, and the bugs I found
were just in the reflog parts.

We store the tables in bigtable (among others), so the part that does
the POSIX file locking is new (basically, everything in
reftable/stack.c and its equivalent in JGit).

So we are locked into the format to some degree.

For the existence bit, I think I could simply record a $zeroid =3D>
$zeroid ref update in ref log and treat that specially.

> In any case, not being locked into the format as specified is very
> nice. So is it basically seeing no (production) use anywhere as far as
> you know? Whether that's in production at Google, or some third parties
> via JGit-something (maybe as editor libraries?).

I think our friends at Gerritforge have been experimenting with it,
but not in a production setting, AFAIK. Luca might confirm.

> Taking a bit of a step back.
>
> I do think that generally speaking parts of this series are putting the
> cart before the horse in seemingly trying to get the test suite clean
> before we have the integration in-tree.
>
> Not everything you have here, but some of it.
>
> I know I'm the one who started encouraging you to work towards getting
> the test mode passing, but I think that while it's good to mark some
> obviously file-only tests beforehand, anything where we have different
> behavior under reftable should really come after.

(I can't parse your last sentence)

> Of course that will mean we'll have some interim period where our test
> suite is a dumpster fire under GIT_TEST_REFTABLE=3Dtrue, and I think

It's actually not that bad. By my last count, there were 38 files with
test failures.

> that's fine, as long as we work towards getting it passing, and as long
> as the non-stability of the nascent backend is very prominently
> advertised in the interim.
>
> I.e. I think *the* issue with the original series you had in this regard
> was that git-init.txt (or whatever it was) basically just discussed
> enabling reftable matter-of-factly, when we were still failing
> tens/hundreds of tests, which is just setting up a big bear trap for
> users to step into.

I read that comment, and I removed that long ago. Right now the only
way to get a reftable is to say GIT_TEST_REFTABLE=3D1 on init.

> But if we just changed those docs a bit to note "!!WARNING WARNING!!
> EXPERIMENTAL AND UNSTABLE !!WARNING WARNING!!" or whatever we could
> merge the API integration parts sooner than later, even with a lot of
> known-broken tests.
>
> We could then whitelist the broken parts, and work on narrowing that set
> down. Similar what the SANITIZE=3Dleak mode is currently doing for memory
> leaks.
>
> I think that would make things a lot easier when reviewing submissions
> like these, in that we have reftable/* in-tree already, but with the
> "real" integration we could check how files/reftable backends behave,
> add the diverging behavior to tests etc.
>
> What do you think?

Sounds more fun than the current model :-)

The latest version of the code is here:
https://github.com/hanwen/git/tree/merged-seen-20220117

What do you need besides the "RFC: reftable backend" commit?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
