Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE125C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiK1OMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiK1OMd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:12:33 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAE1766A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:12:29 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so6975497otl.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voXnFUZK1tf+FiAqtPrMvt2lsnkMpHtPAfEvPha+Qmo=;
        b=qi5LZ4siuwW7Pw7vM2lgG4kRQH5IRGML5zvH6E2jSyGDl8VcXTtoMXPpU8aDtdPCNc
         5mnfWDhxDgE28VBB0a6yaLEfhqU/uABdoD0AMLP6wNkhfztIVO/mjqCevgn/+/YB3qi4
         2YiL7n5zkDVRF1e/cUHICDZuFioc0WvaXA6eyO/h8Aaw63PFjr4kjQ3xhnz1LOf6ez1r
         laS+xdQ2Z+zg+7WoC1im/R+VzfsbxZJ2pS+Mu/hVKzgEsgT8tuiOQP2BpUlwmV7w0nX0
         9cmuZ69vtjtZVH1+SuyeCy8pDFQckfnT36W2hkz8zsDb/qTIXtKxlf6kZwdZtzira3H1
         8M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voXnFUZK1tf+FiAqtPrMvt2lsnkMpHtPAfEvPha+Qmo=;
        b=VKb7iMYUaLebkRy+K4cnMtMc/lGJLnYOYJsY753Gm8z+GRPM2RwFlM5VbnW4ARa8ew
         RT/RkPHh5jkrC0NqNfj8yWzJVV32FCbYUjz4yA0ST16dp/0RR6k7HQ5IRW9kOwq1uZYu
         ynp4qMK3r0yS1Ntr+t3VcYxiOtK7TiNClMA86VY3GrX1sTw4zIz40D9MQIwKXyZmNJrb
         YIicpVdfvQUBmBbrS55zH4QDYSeYcxXmX5TSCnA8AFa4SfH/p0ziwzjIKNZVuQApi/Wv
         1MeKjcdazlbTZeaLwcc+kuVh9SWL1oownCLnNIPlTzzlFFU5ikaq6lKKf7gpyox5AtDR
         driQ==
X-Gm-Message-State: ANoB5pmQwUt/blM9n3J/qd5+4cgaSUTG9cshdMguHu5ibP9jZqA5CR0L
        Rzs8EdZAxGaRqvVJT1aEZWgtTdpOf3b2GYTCzsc=
X-Google-Smtp-Source: AA0mqf7dawzfUvGz3ZT2GTPDhp4CHFV+f0wtGjWWTE5vWqRgcrYSo1YYiO+cX+UId0Q4LaHILc7t2b+JljDRrgAtE6o=
X-Received: by 2002:a05:6830:134f:b0:66c:68e7:d673 with SMTP id
 r15-20020a056830134f00b0066c68e7d673mr16126629otq.31.1669644748326; Mon, 28
 Nov 2022 06:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221128130323.8914-2-worldhello.net@gmail.com> <221128.86edtnky39.gmgdl@evledraar.gmail.com>
In-Reply-To: <221128.86edtnky39.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 22:12:16 +0800
Message-ID: <CANYiYbHxgktZ27C0tPReS4m-esU9PD4jRacO08tmnrgyrq+jOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t1301: fix wrong template dir for git-init
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 9:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Nov 28 2022, Jiang Xin wrote:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > The template dir prepared in test case "forced modes" is not used as
> > expected because a wrong template dir is provided to "git init". This i=
s
> > because the $CWD for "git-init" command is a sibling directory alongsid=
e
> > the template directory. Change it to the right template directory and
> > add a protection test using "test_path_is_file".
> >
> > The wrong template directory was introduced by mistake in commit
> > e1df7fe43f (init: make --template path relative to $CWD, 2019-05-10).
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> >  t/t1301-shared-repo.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> > index 93a2f91f8a..7578e75d77 100755
> > --- a/t/t1301-shared-repo.sh
> > +++ b/t/t1301-shared-repo.sh
> > @@ -140,7 +140,8 @@ test_expect_success POSIXPERM 'forced modes' '
> >       (
> >               cd new &&
> >               umask 002 &&
> > -             git init --shared=3D0660 --template=3Dtemplates &&
> > +             git init --shared=3D0660 --template=3D../templates &&
> > +             test_path_is_file .git/hooks/post-update &&
> >               >frotz &&
> >               git add frotz &&
> >               git commit -a -m initial &&
>
> This fix looks fishy to me. The code you're changing looks like it was
> buggy, but this looks like it's sweeping under the rug the fact that
> "templates" never did anything at this point.
>
> So I'm not saying you should squash this in, but if you do so you'll see
> that we only ever used this later.
>
>         diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
>         index d4315b5ef5a..106ccc5704e 100755
>         --- a/t/t1301-shared-repo.sh
>         +++ b/t/t1301-shared-repo.sh
>         @@ -129,15 +129,12 @@ test_expect_success POSIXPERM 'git reflog e=
xpire honors core.sharedRepository' '
>          '
>
>          test_expect_success POSIXPERM 'forced modes' '
>         -       mkdir -p templates/hooks &&
>         -       echo update-server-info >templates/hooks/post-update &&
>         -       chmod +x templates/hooks/post-update &&

The "post-update" is used in this test case. A wrong template dir
leads to an empty hooks dir in "new/", that cause the test at the
end of this test case passed by accident.

        # post-update hook must be 0770
        test -z "$(sed -n -e "/post-update/{
                /^-rwxrwx---/d
                p
        }" actual)" &&

--
Jiang Xin
