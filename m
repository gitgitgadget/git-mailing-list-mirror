Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F2EC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiESOrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiESOrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 10:47:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF5A0D3F
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:47:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y7so8935905ejr.13
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/M0/TLFfePDz8Dk2StMw+L262DziJLTfZj1ktBTCneM=;
        b=jWBfpzWtzAqLvtmorpPuLIjlSGkSB+mSpRFs1k0RAMJOTd3uDRiA52S2J6Kd1Nj/Uy
         XIW56MRWnHsQs3GE9ihBohHClF22gXYgMDLjLbFUm2bkKq8no/RzDD+Bizv879u1roo8
         nAXQNRw0iu+n0xnp+rQuPpGHtiKBXNoWJHlcw0etyC0+qm+vKbvpCaLMggTk/8lBg4Fo
         QdCixWoljnno94FJXnFT493qbtlu8ycDfOvXroIDYicraviQDj2wIoE4IQ6TnlXsOgff
         hpeQXoL3utIR7BmISSMuYGV9zVQ1Hah3wtCzgS21APK4uHrT0tZY2Ha4fG7+m5VKK0pK
         8cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/M0/TLFfePDz8Dk2StMw+L262DziJLTfZj1ktBTCneM=;
        b=Rqfb0P1+1y6XTzqNxkFqjf5NlcnIdXbVqSNijWaLH7kS/LWf/HrP8wb4HlVNKPF4w0
         hVRnuQT4+evXosUfaqciq5oUWQuxmglAR0Vrnr3IJR+JSgOgEXj0+4bw2bmY2k7P3agt
         X6UXIE99CskepWUO2Ed6NUinDY8x88U7WwWSkpAg10gNHFtVInD/jpUeVN63G5U85dMf
         qhUytwfcZncf5n3bgEB0UzN+o5dkvi7HD6b2dk1W/4GZlag41mFpJ+3PJc6pnbEHkEhw
         o4Sz+NgOrgyqDkAybjxG9bs5TjcUxAMlakz/0Xz1j18pJNe0ayV8VSTjGi/hCr2Fgd0c
         5V7Q==
X-Gm-Message-State: AOAM533skRhNh3hp+zVIJwflzcecdulJSvXgtrRBIiR/6sD4+spzahzp
        RQTKDD5ZmijlLWOqcNDIclSZOm3oyKxfPptFA8w=
X-Google-Smtp-Source: ABdhPJzq2kEjRFT2VTDNtGkt7VKn5AEiEzzbBy0aevg9Em5o9dAgaTyXIHXlKQrRz7cDYqrjACyTvQIeq6oDN2iTbss=
X-Received: by 2002:a17:906:5783:b0:6fe:a263:f648 with SMTP id
 k3-20020a170906578300b006fea263f648mr659003ejq.493.1652971628679; Thu, 19 May
 2022 07:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
 <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
 <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
 <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
 <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
 <CABPp-BHmNBMypVDrE=gPMXoHT9uH-u4HJG1dAuY0tjSGrK0yPg@mail.gmail.com>
 <xmqqk0aqhia1.fsf@gitster.g> <CABPp-BGOGLUPOn20yWzCrBYCykiet0=5UfbkuGC78f-QoWVvYg@mail.gmail.com>
 <CAOLTT8TDomk9zUg49yrhpu1T776FKrnu7RGJ_bx9iaYKUEvvTg@mail.gmail.com>
In-Reply-To: <CAOLTT8TDomk9zUg49yrhpu1T776FKrnu7RGJ_bx9iaYKUEvvTg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 May 2022 07:46:56 -0700
Message-ID: <CABPp-BFrifAymOVNniXiKWv2tZpgxQwxmZAhhGE8eaeJVODNkA@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 6:15 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=94 13:16=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, May 12, 2022 at 8:39 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > >
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > > >     Merge with strategy octopus failed.
> > > >
> > > > Also, if we check `git status`:
> > > >
> > > >     $ git status
> > > >     On branch main
> > > >     Unmerged paths:
> > > >       (use "git restore --staged <file>..." to unstage)
> > > >       (use "git add <file>..." to mark resolution)
> > > >     both modified:   base
> > > >
> > > >     no changes added to commit (use "git add" and/or "git commit -a=
")
> > > >
> > > > And in git-merge-octopus.sh we see:
> > > >
> > > >     case "$OCTOPUS_FAILURE" in
> > > >     1)
> > > >     # We allow only last one to have a hand-resolvable
> > > >     # conflicts.  Last round failed and we still had
> > > >     # a head to merge.
> > > >     gettextln "Automated merge did not work."
> > > >     gettextln "Should not be doing an octopus."
> > > >     exit 2
> > > >     esac
> > > >
> > > > and in builtin/merge.c, we see:
> > > >
> > > >     /*
> > > >      * The backend exits with 1 when conflicts are
> > > >      * left to be resolved, with 2 when it does not
> > > >      * handle the given merge at all.
> > > >      */
> > > >
> > > > Which means git-merge-octopus.sh is claiming it can't handle this t=
ype
> > > > of merge, and some other merge strategy should be tried, and
> > > > implicitly that it didn't leave any conflicts to be resolved becaus=
e
> > > > it can't handle this merge.
> > >
> > > Correct.  Near the beginning of the loop you found the above
> > > comment, there is this code:
> > >
> > >         if (use_strategies_nr =3D=3D 1 ||
> > >             /*
> > >              * Stash away the local changes so that we can try more t=
han one.
> > >              */
> > >             save_state(&stash))
> > >                 oidclr(&stash);
> > >
> > >         for (i =3D 0; !merge_was_ok && i < use_strategies_nr; i++) {
> > >                 int ret, cnt;
> > >                 if (i) {
> > >                         printf(_("Rewinding the tree to pristine...\n=
"));
> > >                         restore_state(&head_commit->object.oid, &stas=
h);
> > >                 }
> >
> > Side-comment, which becomes important below: The save/restore code in
> > builtin/merge.c appears to be broken to me.  As noted in the code
> > above, stash will be set to null_oid() if save_state() returns
> > non-zero (which happens when "stash create" has no output, which
> > happens if there is _initially_ no state to save, i.e. if there are no
> > local changes before the merge started).  restore_state() is a no-op
> > whenever stash is the null_oid, meaning in that case it won't actually
> > rewind the tree to a pristine state to undo the changes of the
> > previous merge attempt.  So, if:
> >
> > * The user had no local changes before starting the merge
> > * Multiple merge strategies are applicable
> > * The first merge strategy makes index/working-tree changes, but
> > returns with exit status 2
> >
> > Then the restore_state() called before the second merge strategy will
> > do nothing, and the second merge strategy will be working on an index
> > and working tree with garbage leftover from the first merge strategy.
> > While this may have never been triggered (in what case do we have
> > multiple merge strategies that all return an exit status of 2?), I
> > suspect we want to fix this problem with something like this:
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index f178f5a3ee..7f3650fb09 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -378,11 +378,11 @@ static void restore_state(const struct object_id =
*head,
> >         struct strbuf sb =3D STRBUF_INIT;
> >         const char *args[] =3D { "stash", "apply", NULL, NULL };
> >
> > +       reset_hard(head, 1);
> > +
> >         if (is_null_oid(stash))
> >                 return;
> >
> > -       reset_hard(head, 1);
> > -
> >         args[2] =3D oid_to_hex(stash);
> >
> >         /*
> >
>
> It looks like this code can go back to the old state now?
>
> I think if we can handle it as special case when:
>
> 1. Use octopus merge without other strategies (no friend).
> 2. Merge failed, so we don't have the best strategy.
>
> Then we force restore the original state?

Yeah, I've got some patches ready; just didn't submit yet as I was
hoping to get time to update the in-core merge series.
https://github.com/gitgitgadget/git/pull/1231
