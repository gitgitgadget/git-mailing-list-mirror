Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E9C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C94D61409
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhDUJJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhDUJJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 05:09:53 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F6FC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:09:20 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id u200so6356980vku.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vUjpm6vx19Syz1quM6CPhFh5o6wzxL6ch2riqrsXz9o=;
        b=UKK4Fz4UWp6VTcY48Zsoa3ooIRP11zT9vLghIXMFJ2Z9jH2//IA/4W4xhwkdQHs0wk
         bM8zUbTCrlBeXhh/Zxgp12JMPVKeaqe7IQz9FoANpCjnKsofVcBtPiN2WYFpDXgadBJx
         KGCsdFtNqvD+x1f8pIb/JdU5iSQ/SOy+24zHHbX+H3rBfZ1nOAq+BJocvo5h8rBE9PeX
         EWjWtAnQYCRVwknqqDiaAc7y5hCgg7VEdQkldiQ5r5uRuHeXA2AuBA7CpkHo13HeTlii
         MgfhDFCgAJJdcIofFC1IUNsWXE+fBcsWOLgUbRlmKNsyRW9dxsOs8uwVAXCHfDCJ4lT0
         n+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vUjpm6vx19Syz1quM6CPhFh5o6wzxL6ch2riqrsXz9o=;
        b=I+j0xEMhlCu53wBm0oVGaUr2WCXy12jqJCIFTLS0Icu5527G+RKdabwuc8E/JULnLU
         /ONpVM9M+608PsPTK/dErqQ0ph2JN0rt7YVuSxdxs0uqUg8Rx7BCJAUupFdyHj5SpSg+
         svEE2ofC4UKUY3gue05au75B2BiNFGg8sStrQZk9PReDMTcyHJRnp2698wtDHC/doeYP
         YXVCWkeEtpiJtHzVRgvDIhO4Jl0IvRgVdYKdwsZ1TYxCueBPnJZdWu/CMGEIuRrZHq3/
         koowTugAxNilgciFuOwCElLAXcHve8nd70Uy/C2d4foN97FoOB/xcHBTgEEQtCLXv++2
         MqLg==
X-Gm-Message-State: AOAM533P/4TqqAKTjQo6qg2tPybo0wVIQBUZL9AaHXadST4D3ThB4eQv
        G1siRwUqAM7FW3qqaiVB0/aFgAYUSqOoN7tkWgeVKg==
X-Google-Smtp-Source: ABdhPJzX9RWYE19BnFZQEm/x3H/KhRfqTCwNr/qj8Z7QwIjany+b17VnqBG2IXVH5dRsjKNtsznacdJeH3W88sVHFUQ=
X-Received: by 2002:a1f:3105:: with SMTP id x5mr12221152vkx.8.1618996159424;
 Wed, 21 Apr 2021 02:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com>
In-Reply-To: <871rb45ftz.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 21 Apr 2021 11:09:07 +0200
Message-ID: <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  t/t1401-symbolic-ref.sh | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> >
> > diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> > index a4ebb0b65fec..fd5980d3fb40 100755
> > --- a/t/t1401-symbolic-ref.sh
> > +++ b/t/t1401-symbolic-ref.sh
> > @@ -7,18 +7,13 @@ test_description=3D'basic symbolic-ref tests'
> >  # the git repo, meaning that further tests will operate on
> >  # the surrounding git repo instead of the trash directory.
> >  reset_to_sane() {
> > -     echo ref: refs/heads/foo >.git/HEAD
> > +     git --git-dir .git symbolic-ref HEAD refs/heads/foo
>
> Isn't that "--git-dir .git" entirely redundant?

See the comment above the changed line: we don't want auto-detection
to clobber the surrounding git repo.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
