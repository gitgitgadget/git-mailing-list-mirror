Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C02DC4332F
	for <git@archiver.kernel.org>; Thu, 19 May 2022 13:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiESNPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiESNPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 09:15:33 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B6C8BDA
        for <git@vger.kernel.org>; Thu, 19 May 2022 06:15:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j4so3597219ilo.12
        for <git@vger.kernel.org>; Thu, 19 May 2022 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vh1VD8QJGVVqemKifPSBOargOCyO9wngswOo8lH7BPs=;
        b=CuKKDAXwtyHFjTNrbul3vh5Jbg+Ry5KZNIfNMnYQdNtSiwsuojzXQALxgrfC89rIAV
         B3rCguB26J99AGzZFYNehXFGd1LBo8DBQPOfW3tAGrvlQvBYuHQII6HPR3IlHV7w369r
         Ht2cJ9mN4pBVyqyz8wn7hevGJsFCHV4g7XIxdRmFu/Iaj61KaAbrIR3W9Qhdi6Xx1ugS
         Isbngh9aW8uMiS8cEesEXlqajTpDd1f8DLJU7+0IYHTTDWnAP2b0+MgYN0pWea/Kn3BR
         rLLk3E14fO/jhDBSnUtNjwlPwFnzbA92T2ZaPnuWR9OQIZOpW5LKL0AjA/p7JDkhehxW
         O3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vh1VD8QJGVVqemKifPSBOargOCyO9wngswOo8lH7BPs=;
        b=QmtxbNDpCZOYwglDowePTF8j7RZQ7ssWVLNa4rpE8Q87uVVFaDcwHHXeFr6+8mtz75
         ysm7BJbRbKgTDWRQ7+ZGXghPTg47Buu3gTGSBgAw4l5+vRohQwbpSV1fFq9NHl8ELx8r
         paq9N6dLnoQliVBMpscZG6OGkbngParim97FYQ40xj/fLmS+f7DU0qMWFyWIXYqCz+PX
         Mh2pmKrbGpzIn2JP2nIoKH3RN6PvWYJjrLdszPlXMyjNKF5uL4hlURChduvFdGB0XaRj
         8B5qQ93jYNZEGS7VRJJykRQ2f2S15c9R9xqTQ1aTck52YPlv56yy1Ox/mwxvoQOouAzS
         sZxA==
X-Gm-Message-State: AOAM531zvETqrJz7dzISXDJRqllTukNko83+UVCrpuoCpCtyWDSN2a4u
        3ZrSTyliHffN9SMrjesNHetCzN0mhLdgWry2/DQ=
X-Google-Smtp-Source: ABdhPJxNW0TjzJMA+e6KeD14gG2h9/w3DaGZ6Z2uFjO1HsD2olWCW9yJ8vfOmnG2/o9jviTQNX77+GyP2oEE1J9+dMU=
X-Received: by 2002:a05:6e02:1bcd:b0:2d0:ec65:5b90 with SMTP id
 x13-20020a056e021bcd00b002d0ec655b90mr2859511ilv.254.1652966130902; Thu, 19
 May 2022 06:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
 <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
 <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
 <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
 <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
 <CABPp-BHmNBMypVDrE=gPMXoHT9uH-u4HJG1dAuY0tjSGrK0yPg@mail.gmail.com>
 <xmqqk0aqhia1.fsf@gitster.g> <CABPp-BGOGLUPOn20yWzCrBYCykiet0=5UfbkuGC78f-QoWVvYg@mail.gmail.com>
In-Reply-To: <CABPp-BGOGLUPOn20yWzCrBYCykiet0=5UfbkuGC78f-QoWVvYg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 19 May 2022 21:15:19 +0800
Message-ID: <CAOLTT8TDomk9zUg49yrhpu1T776FKrnu7RGJ_bx9iaYKUEvvTg@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=94 13:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, May 12, 2022 at 8:39 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > >     Merge with strategy octopus failed.
> > >
> > > Also, if we check `git status`:
> > >
> > >     $ git status
> > >     On branch main
> > >     Unmerged paths:
> > >       (use "git restore --staged <file>..." to unstage)
> > >       (use "git add <file>..." to mark resolution)
> > >     both modified:   base
> > >
> > >     no changes added to commit (use "git add" and/or "git commit -a")
> > >
> > > And in git-merge-octopus.sh we see:
> > >
> > >     case "$OCTOPUS_FAILURE" in
> > >     1)
> > >     # We allow only last one to have a hand-resolvable
> > >     # conflicts.  Last round failed and we still had
> > >     # a head to merge.
> > >     gettextln "Automated merge did not work."
> > >     gettextln "Should not be doing an octopus."
> > >     exit 2
> > >     esac
> > >
> > > and in builtin/merge.c, we see:
> > >
> > >     /*
> > >      * The backend exits with 1 when conflicts are
> > >      * left to be resolved, with 2 when it does not
> > >      * handle the given merge at all.
> > >      */
> > >
> > > Which means git-merge-octopus.sh is claiming it can't handle this typ=
e
> > > of merge, and some other merge strategy should be tried, and
> > > implicitly that it didn't leave any conflicts to be resolved because
> > > it can't handle this merge.
> >
> > Correct.  Near the beginning of the loop you found the above
> > comment, there is this code:
> >
> >         if (use_strategies_nr =3D=3D 1 ||
> >             /*
> >              * Stash away the local changes so that we can try more tha=
n one.
> >              */
> >             save_state(&stash))
> >                 oidclr(&stash);
> >
> >         for (i =3D 0; !merge_was_ok && i < use_strategies_nr; i++) {
> >                 int ret, cnt;
> >                 if (i) {
> >                         printf(_("Rewinding the tree to pristine...\n")=
);
> >                         restore_state(&head_commit->object.oid, &stash)=
;
> >                 }
>
> Side-comment, which becomes important below: The save/restore code in
> builtin/merge.c appears to be broken to me.  As noted in the code
> above, stash will be set to null_oid() if save_state() returns
> non-zero (which happens when "stash create" has no output, which
> happens if there is _initially_ no state to save, i.e. if there are no
> local changes before the merge started).  restore_state() is a no-op
> whenever stash is the null_oid, meaning in that case it won't actually
> rewind the tree to a pristine state to undo the changes of the
> previous merge attempt.  So, if:
>
> * The user had no local changes before starting the merge
> * Multiple merge strategies are applicable
> * The first merge strategy makes index/working-tree changes, but
> returns with exit status 2
>
> Then the restore_state() called before the second merge strategy will
> do nothing, and the second merge strategy will be working on an index
> and working tree with garbage leftover from the first merge strategy.
> While this may have never been triggered (in what case do we have
> multiple merge strategies that all return an exit status of 2?), I
> suspect we want to fix this problem with something like this:
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index f178f5a3ee..7f3650fb09 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -378,11 +378,11 @@ static void restore_state(const struct object_id *h=
ead,
>         struct strbuf sb =3D STRBUF_INIT;
>         const char *args[] =3D { "stash", "apply", NULL, NULL };
>
> +       reset_hard(head, 1);
> +
>         if (is_null_oid(stash))
>                 return;
>
> -       reset_hard(head, 1);
> -
>         args[2] =3D oid_to_hex(stash);
>
>         /*
>

It looks like this code can go back to the old state now?

I think if we can handle it as special case when:

1. Use octopus merge without other strategies (no friend).
2. Merge failed, so we don't have the best strategy.

Then we force restore the original state?
