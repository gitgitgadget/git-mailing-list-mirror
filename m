Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A10C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 07:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCXHwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCXHww (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 03:52:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A41DBA5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 00:52:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w25so773409qtc.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679644369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QLIjjHGt5n9NnWcmzKRiKvc3DVxW2veVO1dVOXfTj4=;
        b=fhh3jb0RcKmxH0rygWrnqbi2bQWCtPyYPewAMO022N4hmajssnVhdkZadMznsYQUP9
         g0Q/ikZPR3pqytD8Xz8XrwpivDRJiOZ/2v6S2KaMLPxC3Ia/kNc5aCfAH1XyzLWH/STx
         NgOSJas89clldYavNyg0ttIJMNXaP6WeeqGGvhUe9MzwJYhNboLGOuiwKv3hNJankf7c
         4L4EjVC5AArK/cs9WZzMyyKRJE+Q95NUkefAOwMRRCTeZJScWwVv2KI7itwOqzLxnmu2
         EJTkd2+5ypDo4lJMOBMO5X7dNfZyvtoziXlxDeRDo+77PiE9S5DNUVo28SOWx8fW0HCa
         eU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679644369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QLIjjHGt5n9NnWcmzKRiKvc3DVxW2veVO1dVOXfTj4=;
        b=00jBPGbHMqz0rmaJfjOYWR7WiFt0csNcl28YXloy9spzV2+Fwv/7SFXCSFS2ZDsq59
         xUIq2eqe79/CKaKSKgj+TLtVSJQ2dGWVvlDgVmkeg/2g2TSF1HH9tNPOaTskLYegekOg
         BonWv3jWy98iBxGiEe450eZ4jDk2QjhU9ogPTjDGevcdNHuU+j6mmss1VS3wleBTtMO1
         VkCzQzfdQUWzww61FEoCJQ8pG9fZiQFG68aBHMp6j8RfGmUyETZrtcUYWcTJeGZpDiD1
         JDmBlH0fvP3fFge6hZpzdM8m5fZuEqbV1KoEMN1YJRfhgsS5kmA/PcsreHofkXtytpqL
         j7fA==
X-Gm-Message-State: AO0yUKUwcD02ieh3ltxnlz1qP5Xx4ZacgHac8jm8UaWIuPKrNZZHilil
        p4NV8exLC5KnEzpyD9NqX//IRI6o6X3RpWAgo0tsUWzE6Aw=
X-Google-Smtp-Source: AKy350bn7ZS/mDeZ2kC5OeJwllP/Ih9sKeDOmQJ3rVL4jQ6NvoTqn65JPCucWpUVFChOypax1b+Wt8nPccOMgarjrg4=
X-Received: by 2002:ac8:5905:0:b0:3c0:3c09:a4a4 with SMTP id
 5-20020ac85905000000b003c03c09a4a4mr862127qty.0.1679644368692; Fri, 24 Mar
 2023 00:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
 <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
 <20230320170158.GA2614670@coredump.intra.peff.net> <CAHp75VeMoXZdr++6BiOMhOnSqm5rPe+t0bNzpLJsCuGp8NU=wA@mail.gmail.com>
 <CAMP44s2hEudOpOcyXzZQNYtQSHXOd4NiPBboH=90RHEgF_Lamg@mail.gmail.com>
In-Reply-To: <CAMP44s2hEudOpOcyXzZQNYtQSHXOd4NiPBboH=90RHEgF_Lamg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Mar 2023 09:52:12 +0200
Message-ID: <CAHp75VfSdth4B-oW8JCt4kBkehu6+B9ueQAJL1g99Ev3RiMKoQ@mail.gmail.com>
Subject: Re: git rebase issue
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 10:38=E2=80=AFPM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Mon, Mar 20, 2023 at 12:11=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 20, 2023 at 7:02=E2=80=AFPM Jeff King <peff@peff.net> wrote=
:
>
> > > Adding its author to the cc, who may be able to say more. But my
> > > understanding is that this was probably fixing a bug (though I don't
> > > know all the implications of having a branch checked out in multiple
> > > worktrees).
> >
> > Note, in my case it's "checked" in the BARE repository, which means
> > it's actually not.
> > This case shouldn't be an impediment or racy AFAIU.
>
> In that case I agree it should work, but when I tried to reproduce the
> issue the bare repository is ignored, only worktrees are considered.
>
> Are you sure the branch isn't checked out in other worktree(s)?

Yes. Since the commit was in v2.26 already, and I have noticed the
issue only recently, there are a few possibilities:
1) Debian is to slow to update a Git (doesn't sound like the case);
2) New version of the Git does something in the configuration files
that unveils the issue;
3) Something else I've been missing?

As for 2) I have found a new config.worktree which I tried to remove,
nothing changed. Also I disabled extended worktree configuration in
the main (~/.gitconfig) one. Didn't help either.

I have a bare repo with a Linux kernel and two worktrees. The HEAD in
the bare points out to one of the branches which I try to rebase.

BARE:xxx (as shown by Git prompt helper in the Bash)

`git rebase -X ours --onto "vN+1" "vN" xxx` fails.


--=20
With Best Regards,
Andy Shevchenko
