Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB44C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjFCBwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjFCBwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:52:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE0E47
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:52:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so33034051fa.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685757161; x=1688349161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9vsFuLOxtl4xHZKUnP8kllnAsw1/o6ca4RMJHH3Tho=;
        b=bTF+hrNTHsj5EJnLjA0x9SBZrGDTXAbwBsMYWT6Vl4Cw4+ur2mbI1bxB4uv3szdJNK
         /XXylJz7Q5iR/qPZPmk//nM9B2aM/5lYKPW0WoP7tbfBDfj8yApCKy8Wtg/Z3W/54CTp
         +V6n3oC+rsjsTxxxoGVf473vT4g/6fr1jbuanAI4inaP4dtxMPNCmKAPCDoAH0SwSCKN
         esQIubveNtyq1lMXh9EpoIPr8K3wg95vUJ1Jav4hf1t253MuEftYGkKJ3G/Qqhe9VfPr
         y7Vd3dhAoVszOt5iGfJIEJ+0qfbcYr0RSUde22ZTRpvPaZaN2Hpl9FzIuWfgEqueNPay
         hHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685757161; x=1688349161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9vsFuLOxtl4xHZKUnP8kllnAsw1/o6ca4RMJHH3Tho=;
        b=fXiQgONTccuWTB07lLjBSklT/APo9j8WKC1OzjBFjzjVncNiarTcBhyjR2AUOzKWJt
         f4JHwoxJ2Vz7JFb/BYIr7NDPFw5OhByCp3z6QOJrM8U3v++M9vEMFXpFmbRDdvyaaLbl
         M3WwqVBYcbRZf/qgNWPuHqK0aO+vGvt+oDoByY5dbF3jaQny71ksGyTzHxY0l0iWoOcD
         b8pnaCj3T8vrLEAzkRxnU7amtRrzEo686RQXhOtePoG3EK0Y/fP6kMeVFTinDAYTdG3m
         AeGVMVVMpAlr7RTgTA/T2kFmzxnQSn2Z4I8RyVe0T+K2W0aqsBEGwwzTnj5ad0adYlxC
         Pbnw==
X-Gm-Message-State: AC+VfDxqSexMGqT2OsSzbGr2XmChxn4v8Kny3VgaMZiuYfxMKci4PY/y
        LbEpzeQcz/uDcl8ScArQv/C0B6y5sujA3y2EpTE=
X-Google-Smtp-Source: ACHHUZ4AZTHP/LW63DlFCVeVRegWj6qUcEjx2KVMRGOJUbkC46wxbmd+IfnkrgTYDZv10as8zJ+nEs57s6FrxG1CaJ8=
X-Received: by 2002:a2e:7e04:0:b0:2ad:8380:770d with SMTP id
 z4-20020a2e7e04000000b002ad8380770dmr928791ljc.21.1685757160598; Fri, 02 Jun
 2023 18:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com> <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Jun 2023 18:52:28 -0700
Message-ID: <CABPp-BGSyWZyb2g=XsPffKEsJ5MbO+PkUfBbEboefdzG9Fm+cA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Create stronger guard rails on replace refs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jun 2, 2023 at 7:29=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
[...]
> Updates in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks for the careful review on v1!
>
>  * disable_replace_refs() now replaces "read_replace_refs =3D 0" in the e=
xact
>    same line to avoid possible behavior change.
>  * Stale comments, include headers, and commit messages are updated to
>    include the latest status.
>  * Patch 3 contains a test of the repo-scoped value using 'git grep'.

This version looks good to me; thanks for working on it!

(As a sidenote, it might be nice to call out Victoria's questions
about possibly moving stuff to environment.h[1], so that if others
have opinions on the matter they can comment on it.  I don't have one
at this time.)

[1] Last paragraph of
https://lore.kernel.org/git/49ea603b-ebbd-4a14-e0dd-07078e56de0a@github.com=
/
