Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA26AC54EED
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjAWPQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjAWPP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:58 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5826847
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:15:37 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c124so15127108ybb.13
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfUUiJS9ec7stqvYjNKijZLzWNEXwEXUNMsqolxO7KM=;
        b=jGN4oGw3YY6gHvfG+nhwJkXVv3Rt6lwVMdFkpM77AaC9A8j/4bVUn4ALO/gEBb6VUk
         RDg6PNvonFwLskVMJjzK6NWkIuIT6UtTmoVSK/rqzqrTOfc9/Z54dcRuIZmY9oiWcf6A
         XDsUIugyrUA8SulzITzKRHl27UMh60a6bXC7Sh2DhCLdxvcF11SV8zoO+I1AV3l00wFa
         1TaO7C8iiGa3MnX4V8yoD+uaTNI7mGZYBa+6UlCKOHcnW3hkVJdUT6sELUKYbO0ZbpB1
         uEaoI4KCClVSL7QWPI1WaM21vOdEacc3HwAUb7iZCOOUubcElW7RBzJKlCkhEpboJoHf
         7jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfUUiJS9ec7stqvYjNKijZLzWNEXwEXUNMsqolxO7KM=;
        b=dS2oDx2QuR2RjtMxARVcypAhaZLsNoHiSlUbdflHj4RxBc9XifWfDbPsETdc9Wl3BP
         1xpWOR25XcjNMdF8ngtFf0wyC3n54W6KptvDL9zerPfhouw3ESKHmJp7XKDaLurBNft4
         KWQ7XTiYUvycAUTgwSmPxz5kM8m9Z8kvoOnO7oU5+Zo6JWKl7pRMbYgBXVKxnbOlpmyK
         TfIIcuOMgQJOMf8KYqbiI63YJ/gHHKAUJsMOh/T0gh8oh7539fgOKzG06adrPDmguYx0
         Ucc0kfuhRAg3fc1vfcNR3XT/b98LQRgwx+O/udHJ94FjcqKjP6sNX/hQgWNQti41pDKY
         CvqA==
X-Gm-Message-State: AFqh2ko0cCuE2mxQ9EqMOox0vDksPdPmfBlytezfs/hQN+wDyMqUIHFv
        8edEIXLL5wQRGk0IxcT1DoVLE8QgZ/U6VY6aB0k=
X-Google-Smtp-Source: AMrXdXuWdBz6JbPl6PKoX7H392NRrJtEAiGklmXdLhAFzpOBUkdZ0D8LwBD3J8tOqlE8a2/pY+yKUBI9xRya9zrK7i8=
X-Received: by 2002:a25:606:0:b0:7b1:e4c5:fd37 with SMTP id
 6-20020a250606000000b007b1e4c5fd37mr1968676ybg.561.1674486936181; Mon, 23 Jan
 2023 07:15:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com> <cde4827da13a1391501057ee42655836f0ccd337.1674149666.git.gitgitgadget@gmail.com>
 <CABPp-BEC4PmQfYT=UhtbJ5QcXXMqwF1e-KvSVVDNjDy69bGH5w@mail.gmail.com>
In-Reply-To: <CABPp-BEC4PmQfYT=UhtbJ5QcXXMqwF1e-KvSVVDNjDy69bGH5w@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 23 Jan 2023 23:15:25 +0800
Message-ID: <CAOLTT8T1TCO+Tj8g4kb3QvqDXKnw3D5bLgd8k2Cg4zGb5PRM-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: fix sparse-checkout docs link
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 13:12=E5=86=99=E9=81=93=EF=BC=9A
>
> >  This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but =
we've
> >  been working on it.
> >
> > -0. Behavior A is not well supported in Git.  (Behavior B didn't used t=
o
> > -   be either, but was the easier of the two to implement.)
> > +Behavior A is not well supported in Git.  (Behavior B didn't used to
> > +be either, but was the easier of the two to implement.)
>
> Why did you remove the numbering on this, though?  If asciidoc doesn't
> like starting with 0 (the only guess I can think of for why you'd
> change this), shouldn't the series be renumbered starting at 1 rather
> than removing this from the list?
>

I see, I admitted that I treated "0." as some overview information and it
should also be considered as one item of the "Known bugs".

> >  1. am and apply:
> >
> > @@ -1052,7 +1066,8 @@ been working on it.
> >      https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr=
8JhyuuTMK1RDw@mail.gmail.com/
> >
> >
> > -=3D=3D=3D Reference Emails =3D=3D=3D
> > +Reference Emails
> > +----------------
> >
> >  Emails that detail various bugs we've had in sparse-checkout:
> >
> > --
> > gitgitgadget
