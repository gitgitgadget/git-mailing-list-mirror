Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79EC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348294AbiEJRcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348390AbiEJRbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:31:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0963758E4F
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:27:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id js14so13081937qvb.12
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baller-tv.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fDNc3icDKkYADa98PS4UHtyIcaM9KkmzSe94h69uOXY=;
        b=HvZSsWMWkRlK0JMZNbYXoMJqpxg6f7cKBjdHgx8IMy4x/plWkaRDA0K8IGw2P0+n39
         hHzj1tot3jMnC435TscjNOGwo3yqdnlhUByYOxhF8mgoPFvsednsSESMViJnuuzTEpt1
         O2gbMaf8myC8E4fYD+B9eJrcaGgZzyEJDz5I3AO5I20Ih2OLOhuSAwAcYJaIO729VUsJ
         gs8VgRj9YS9nqM56a4g4uoiXARzIxB8vNYxjZsOEBTL3NWJtRITx76kZ97hgZCscVqIC
         2oBQDZtdOVEvEUnFUE+uO1tTFUtXgavpCtrslLQjl/fDNS4rJYcXOOijkgyjqxgQ59aQ
         s2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fDNc3icDKkYADa98PS4UHtyIcaM9KkmzSe94h69uOXY=;
        b=UAn0HLR1UFjINhQioNoE7Ruw3avC4CWAB6EqJk0mEwMy6jUgDlXtv4MEMXc/sfek2C
         RZGNyPJkzNHuEgOzzcI7IkVNJuSqH/wtdzl2Ts/hlUHJOMpnvV/r954pLgqvPUJYdTwF
         tnMM+AAz4qH/XuQTuTj9q5Q49u0VH+7RsuBSxkiQGdQZg42e6YGJwB/Fi71w67rnl8rc
         ep9pJBFGRspNjC3sagWByL4UPYg+lJ6x9ImMHUJ6TqkosHkT9LEyUeJhZ8kle1OK/FS+
         UtjeJYeJm4UnyR/L4XZvOiUwX7ZJGYtVekdR/BiFhXs7QPkRf/Z2ZqF88GPjKn7DfjAa
         OB0Q==
X-Gm-Message-State: AOAM533l9urzueTdFrD/p1bdjlWZ7ceATRlia8z3KwjDrI2tKdGWEGwi
        bFVY3ajho8LnZbtcg8NWGsk2FB4Xon5DcnveskC3uXYr5d/CIg==
X-Google-Smtp-Source: ABdhPJxu2FyLpNiKXHaipRyJ2JeoYRhO1UffgKEamAMxXkWQfC45jw2yqTMg+s9UhUvDmPh0zoC3p04gwuk3WiDbTj4=
X-Received: by 2002:a05:6214:ace:b0:45a:ecd3:df44 with SMTP id
 g14-20020a0562140ace00b0045aecd3df44mr17191923qvi.76.1652203627166; Tue, 10
 May 2022 10:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
 <xmqq4k1x8gqj.fsf@gitster.g> <01e601d86492$43bb70b0$cb325210$@pdinc.us>
In-Reply-To: <01e601d86492$43bb70b0$cb325210$@pdinc.us>
From:   Addison Klinke <addison@baller.tv>
Date:   Tue, 10 May 2022 11:26:56 -0600
Message-ID: <CAE9CXujPzu3_95pBDVRXKFU_z40j9Y7v5_1y3c+WnFpz1_oY4w@mail.gmail.com>
Subject: Re: [FR] supporting submodules with alternate version control systems
 (new contributor)
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Addison Klinke <agk38@case.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick replies

> Junio Hamano: When you bind an external repository (be it stored in Git o=
r
somebody else's system) as a submodule, each commit in the
superproject records which exact commit in the submodule is used
with the rest of the superproject tree.

This should be fine then - at least the data versioning tools I'm
familiar with can all specify their current commit and checkout by
commit hash. Does it matter how the hashes are structured/stored
internally? For example, I believe Dolt keeps them in a MySQL table
that connects to Noms under the hood.

 > Junio Hamano: not judging "if it is realistic" at this point

What would be the best approach for answering this portion?

> Jason Pyeron: The submodule "type" could create an object (hashed and sto=
red) that contains the needed "translation" details

That sounds like an interesting idea. Since I'd like to offload the
burden of maintaining these translation files to the 3rd party
developers, it would be nice if they got copied to a standard location
(i.e. ~/.gitmodules/translations/tool_x) during the 3rd party install.
Then when a submodule is added with "type =3D tool_x", git checks that
the appropriate translation file is available, and if so, copies it
into the parent repository.

On Tue, May 10, 2022 at 11:20 AM Jason Pyeron <jpyeron@pdinc.us> wrote:
>
> > -----Original Message-----
> > From: Junio C Hamano
> > Sent: Tuesday, May 10, 2022 1:01 PM
> > To: Addison Klinke <addison@baller.tv>
> >
> > Addison Klinke <addison@baller.tv> writes:
> >
> > > Is something along these lines feasible?
> >
> > Offhand, I only think of one thing that could make it fundamentally
> > infeasible.
> >
> > When you bind an external repository (be it stored in Git or
> > somebody else's system) as a submodule, each commit in the
> > superproject records which exact commit in the submodule is used
> > with the rest of the superproject tree.  And that is done by
> > recording the object name of the commit in the submodule.
> >
> > What it means for the foreign system that wants to "plug into" a
> > superproject in Git as a submodule?  It is required to do two
> > things:
> >
> >  * At the time "git commit" is run at the superproject level, the
> >    foreign system has to be able to say "the version I have to be
> >    used in the context of this superproject commit is X", with X
> >    that somehow can be stored in the superproject's tree object
> >    (which is sized 20-byte for SHA-1 repositories; in SHA-256
> >    repositories, it is a bit wider).
> >
> >  * At the time "git chekcout" is run at the superproject level, the
> >    superproject will learn the above X (i.e. the version of the
> >    submodule that goes with the version of the superproject being
> >    checked out).  The foreign system has to be able to perform a
> >    "checkout" given that X.
> >
> > If a foreign system cannot do the above two, then it fundamentally
> > would be incapable of participating in such a "superproject and
> > submodule" relationship.
>
> The submodule "type" could create an object (hashed and stored) that cont=
ains the needed "translation" details. The object would be hashed using SHA=
1 or SHA256 depending on the git config. The format of the object's content=
s would be defined by the submodule's "code".
>
>
> --
> Jason Pyeron  | Architect
> PD Inc        | Certified SBA 8(a)
> 10 w 24th St  | Certified SBA HUBZone
> Baltimore, MD | CAGE Code: 1WVR6
>
> .mil: jason.j.pyeron.ctr@mail.mil
> .com: jpyeron@pdinc.us
> tel : 202-741-9397
>
>
>
