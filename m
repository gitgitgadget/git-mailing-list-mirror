Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0538C0015E
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 05:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHCFgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 01:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHCFgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 01:36:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C91FED
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 22:36:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso7916651fa.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691040959; x=1691645759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEp8PJHjZezK8OOvCnnhAgpQBM5uvJyYYrXlCl9LG/8=;
        b=jPv51IlIqoOVvIXQOcxDZlv0d2wL+EsWzvnFca6cnMAKfGnvfkRKdDD5bBU4V3DGAB
         DtriJEpZj6Y69yBSIHzVlMH7/EU9yMWBnDLPcaQ+ZTBJ1PALAMvJztz0pQbjZcsUtsYz
         3QD/wSIPy1ygU88ggPDzdLiULkaB6Uboy7XD+2eW8NAgO0RrgQFSPjylOaAFg5C6MLeb
         07eQdhalIQ2fRDOEHNXTcYTR+S4kkscpqE/e/GoT+W630BenuPo8tsQ+PkH9cry9x04V
         bb8qr5iOWS6LR6LqWKvkjYyVoXzPu3jkyy/NEFyWM3mXcgEX8l6l+oiJHQS6uaNVPBnn
         Q4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691040959; x=1691645759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEp8PJHjZezK8OOvCnnhAgpQBM5uvJyYYrXlCl9LG/8=;
        b=Lyt6MvwU+sHJ3uKEX1dPjddCg11Hw5fZcTawfy2LMJ4Aonupsgawhzj7GJz/hnNBIV
         ZZXA4ILQUFB/zLADHKkh19NXNsqlJCjU0f2uJ1GmO7JqtZ7SA2IZ6K6LCQDzsedag8gE
         izOGFpcaemYwRXnqvEy+PT3Q8/VA25S8BXdn1rcnfjulyD+tJWHMBavUrq8EnLm89BR0
         ps2Wx/4e/+KyaYpwSi00J5zz8Qw1vrdswGOX61CKefv4alSjme7Get+V8Ugneme7Czs8
         RHJfsXAF8nJuSI3taZSBcnaeLEbaRXHY9V8W6eE8OFIDN02yRS2IphS2EyweeSpIp00V
         0qEw==
X-Gm-Message-State: ABy/qLYs8BfRFmWK5GH55Y7TUnoVmt78C0YcreVyR378wOhTWlfVzt9Q
        dNNtCvvyopMiBpeQ7ulOD8Xf6Vs1jml438mok8tJ+tGHrpM=
X-Google-Smtp-Source: APBJJlFanKYZaLhsVr85LpxtUtb83Jx1b5IZwMXYpO6uLxI7HpuIuPlFk7z2bUwZAjSJlCUZmoaPdIL82IqsLKOKJxs=
X-Received: by 2002:a2e:86c8:0:b0:2b9:cd79:8f94 with SMTP id
 n8-20020a2e86c8000000b002b9cd798f94mr6889982ljj.39.1691040958645; Wed, 02 Aug
 2023 22:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+sf2-+499Nfu00ciJeLwjRmBE7Bb-WZcZuCXY2-JXs88Pwz-w@mail.gmail.com>
In-Reply-To: <CA+sf2-+499Nfu00ciJeLwjRmBE7Bb-WZcZuCXY2-JXs88Pwz-w@mail.gmail.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Wed, 2 Aug 2023 22:35:46 -0700
Message-ID: <CAE1pOi1Zt8i_rVi6dCGVsshhPxa_kV7qQ7SMu6R4nsSiadq7xw@mail.gmail.com>
Subject: Re: .gitignore is not enough
To:     Aleem Zaki <aleemzaki@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think you might be looking for "git update-index --assume-unchanged
<file>"? See https://www.git-scm.com/docs/git-update-index for more
details.

This allows you to tell Git to ignore the changes you made to that
(tracked) file.

On Wed, Aug 2, 2023 at 10:16=E2=80=AFPM Aleem Zaki <aleemzaki@gmail.com> wr=
ote:
>
> There are files which one would like to pull from a remote branch but
> not have git register said person's changes on said files
>
> Let's have a file named:
> .gitpullfromremotebutdonotregistermylocalchanges
>
> Of course, we can think of a better name
>
> By register I mean detect, like when git status detects changes that
> are not staged for commit
>
> Use case:
>
> On GitHub, you clone a repo with a default config file (skeleton)
> You custom the config file with personal tokens and values
> If the config filename was in .gitpullfromremotebutdonotregistermylocalch=
anges
> Then the following don't have to be worried about:
> 1. The developer (the remote branch maintainer) doesn't have to not
> have a default config file (skeleton) because it was in .gitignore
> 2. Pushing your secrets
> --
> Anonymous
