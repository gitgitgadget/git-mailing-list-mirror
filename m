Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0CFC6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 23:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCPXs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 19:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCPXs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 19:48:27 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4336D4DBC2
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:48:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5418d54d77bso62739927b3.12
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679010505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYQASsGTGnHvIohvEhutcrZziivmQSWahkWSHXXrCXk=;
        b=Nz8XGFMP045ulDE/BKlSIrmAN7OElovrSglPyiDYytwwGLjqfM2/zs+yPfnKdaSqjS
         4uzNe68TpUu3VIJ9QcapspbO27ttJ+rwnUMjJ1twxD4daI1k9yPj3qBB8l1ftb+Ia7L4
         /wxpYevC8NptLvZiW2rbI5wLWTG4jNUmzsLFtJM/XhGgxpyxom1tVy/CZS3hymF4V6EA
         cTDAu2kYORehgD8b7f80qieSlTQV5igFcDW7qhgdWRddhGYFYnUtW5RJIcXaFqkFyCNc
         BNjZ3Y+nO3+R2M0twZ1DWbAKB8KSsyd6XiHmfVWCnFq/xV2/ibmvXKV+zuza5HB8CzqZ
         sQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYQASsGTGnHvIohvEhutcrZziivmQSWahkWSHXXrCXk=;
        b=dMxiyVXLMoWALaleNeLkMuo/YeKPWStVD++nAxZrctie5xj/Tdplc6lS2qv/q6FnU8
         i4ZKe6ii+NXgvteN57Hv1rBk/D2pv2kjIAUw1ubpdm+qxCXzNPfh4XmPrGY9msQJpri8
         jiqmc9XbMxh8LeudP4PXRJNfOSch6bq9f8v6RmOJwkQQ4wYtKszi8xUnr6PFd0CycrpE
         iKrw6fr3daTvRuc2ybWAbol/ZqVMacWsUg1a3pnXg8kAQu94LAi7Prsh76FP3bQRdQft
         eiJbYmKhSros2bm3yFNwpTO9qXMYsw0RgFK7F0DfYizzAKn4/qscKEzMXPOeB06xdOl8
         UiyA==
X-Gm-Message-State: AO0yUKUsWnUh7fAm8+zpXFc6GcWur4gXSNXyMAQbTiaGLq8c8FH1uzms
        Aclw2CUStOdu7/ASafWYbXDPKpRb0e7giSdOxA8=
X-Google-Smtp-Source: AK7set8KL7aH55vXcsvgHj7g8cdnVmCM/Oc8guG9SkMRsOHy3odlZWF3JdhWJbtZqbubRvrInDPVS69AAYmMae0YiS4=
X-Received: by 2002:a81:af46:0:b0:541:693f:cdd1 with SMTP id
 x6-20020a81af46000000b00541693fcdd1mr3339718ywj.9.1679010505426; Thu, 16 Mar
 2023 16:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
 <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMP44s3hH0Gw71UAm10Os=6YJ4RAoAJxC3exN_jekMy6-JRsVg@mail.gmail.com> <kl6lttykuxfu.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lttykuxfu.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 16 Mar 2023 17:48:13 -0600
Message-ID: <CAMP44s04zfDjXRpof5ZBTbTLD5aq5_rQc_74ipDv1N-d-dhtKw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2023 at 4:46=E2=80=AFPM Glen Choo <chooglen@google.com> wro=
te:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> --[no-]rebase-merges [--rebase-merges-mode=3D(rebase-cousins|no-rebase=
-cousins)]
> >>
> >> I don't think there would be any confusion.
> >> [...]
> >> (Having --rebase-merges-mode
> >> be a no-op without --rebase-merges is probably even more confusing to
> >> users, plus this would break backwards compatibility, so I don't think
> >> this is a good idea at all.)
> >
> > I don't find it confusing. And how would it break backwards
> > compatibility if --rebase-merges-mode doesn't exist now?
>
> I meant that for the above example to work, we would need to have
> `--[no-]rebase-merges` as a boolean that says whether we rebase merges at
> all, and `--rebase-merges-mode=3D[whatever]` would tell us what mode to
> use _if_ we were rebasing merges.

No, we don't need --no-rebase-merges for --rebase-merges-mode to work.
It would be nice, but not necessary.

> This means that
> `--rebase-merges=3Dnot-a-boolean` would become invalid.

No, it would not become invalid, that's yet another decision to make.
`--rebase-merges=3Dmode` could become synonymous with `--rebase-merges
--rebase-merges-mode=3Dmode`. A shortcut.

Because it's redundant it could be deprecated in the future, but not
necessarily invalid.

> We were in this position before, actually, with `git log -p -m`. The
> conclusion on a recent series [1] is that having such a no-op flag was
> probably a mistake (and unfortunately, one that is extremely hard to fix
> due to backwards compatibility requirements),

No, `git log -m` was a mistake *only* if -p isn't turned on as well,
which is an interface wart that could be fixed today.

> so introducing more no-op flags is probably a bad idea :)

Whether --rebase-merges-mode turns on --rebase-merges by default is a
decision that could be made in the future. Just like `git log -m`
turning on `-p` by default is a decision that could be made in the
future (and probably should).

---

Either way: introducing a new option cannot possibly break backwards
compatibility.

Cheers.

--=20
Felipe Contreras
