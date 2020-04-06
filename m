Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F00C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 08:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65427206C3
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 08:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1MjQu4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDFIsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:48:21 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36536 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgDFIsV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 04:48:21 -0400
Received: by mail-lf1-f46.google.com with SMTP id w145so11111309lff.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xHf8vyfIwJggRR7yGnrF9qHu0i1cPvXRUao/DwQ9rCA=;
        b=f1MjQu4VhbVdWKkBbHa1HA1vbfJha8Pl/C/XX+GthDSimdmqLT0f1/X6OTudvmITtE
         BeVF3rBRNAA8pRwrgDDcULkcUuuixkC0MgDvag/MzqWNhnM6aTch5YMfaOscvOfnp42Z
         w1obvXzxZF0SWAxqVODSa0NppfBKMdC/05vdXd86u+tesvGFpyJV9516lei3PI5hkfW1
         lcW2FA12FkWxFGWJJ4AgXsxXpYfnBFRrotTnG39QeaK8+iwltyZVElNF0OxvHF7DKyGo
         2swZRBd8UMcWSQjzpT11/L5lW5xGL5QeV4ZCncpBKllS/oM/GgSmj4sUrs4djX3ek6Qz
         aK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xHf8vyfIwJggRR7yGnrF9qHu0i1cPvXRUao/DwQ9rCA=;
        b=E+BM/cmOVLOML7ood0esZC7WbQthy98oBVcJN8DwcFTWKM7bMq21m37GE1Cv7hPzAy
         RZrXdrYuFwIQmJ2sXseo1XKNBebC7+9AubmS8ypce73MUbk9ylt6u2i1ISxgGkFJuSxs
         BA36ldHH1Qnu7+dt2niTPQDyz8tcOPJ8xRfQvGnAR/yX6c/r+Zg1NHVgvi+Fst7kDetL
         9gtRnbD8ZCPoI8HHOvaXwgFeh4qyWE5stcI4eAX7rnLjgomjaA7EIbkxM9p27nPtaots
         2BRqI4XV95l2SqZEZ3Xvwv+vu5CISqM/MVDPhm9xUApvFJW78S9tMjekaChD5umrh4EK
         VIWQ==
X-Gm-Message-State: AGi0Pubz8pr6P5lvApwylugZiZJrlWZ0OhWS5Hn8KNLd4HbHom6k5MHa
        vRf3FfaLQDbb9Y6DNUCqEDbtMWvv4RaIDxpmBpTPZQ==
X-Google-Smtp-Source: APiQypKZcCyWuhGinJotVeW9ASKr7bHz1bxZ01ml5y/yRPtzZbMQC/Nojyj85wP390noXns5IQi+6/Rzgp3V8yMr/2M=
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr12650973lfd.109.1586162897315;
 Mon, 06 Apr 2020 01:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Sgv42V+xfoJVoFpPkWREXT0yuKZDeMDEGa3y8NDVU-4D1iYA@mail.gmail.com>
In-Reply-To: <CA+Sgv42V+xfoJVoFpPkWREXT0yuKZDeMDEGa3y8NDVU-4D1iYA@mail.gmail.com>
From:   =?UTF-8?B?VG9tw6HFoSBQcm9jaMOhemth?= <tomas.prochazka5d@gmail.com>
Date:   Mon, 6 Apr 2020 10:48:06 +0200
Message-ID: <CA+Sgv42bOAaRBX99EpgpnSkGXFCWFpED7hwdwkWmPSOKuL1VBg@mail.gmail.com>
Subject: Fwd: Q: use '-C' flag with 'git config --global'
To:     git@vger.kernel.org
Cc:     tomas.volf@showmax.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm running into issue that if I run `git -C <pwd/to/showmax/project>
config --global user.email` I don't get expected email.
Expected: tomas.prochazka@showmax.com
Got: tomas.prochazka5d@gmail.com

My config contains a little catch:

~/.gitconfig
```
[user]
       name =3D Tom=C3=A1=C5=A1 Proch=C3=A1zka
       email =3D tomas.prochazka5d@gmail.com

[includeIf "gitdir:~/Workspace/Showmax/"]
   path =3D ~/Workspace/Showmax/.gitconfig
```
~/Workspace/Showmax/.gitconfig
```
[user]
    name =3D Tom=C3=A1=C5=A1 Proch=C3=A1zka
    email =3D tomas.prochazka@showmax.com
```

I get correct email setting if I run command without `--global` flag.
But What I understand from the [`git-config`
docs](https://git-scm.com/docs/git-config#_description) if no flag is
passed the values are read from system, global and local.

If I run commands one by one, No returns the ~correct~ expected email:

~ $ git -C <pwd/to/showmax/project> config --system user.email
~ $ git -C <pwd/to/showmax/project> config --global user.email
tomas.prochazka5d@gmail.com
~ $ git -C <pwd/to/showmax/project> config --local user.email

Am I missing something?
Thanks for the answer.

Regards
Tom=C3=A1=C5=A1 Proch=C3=A1zka
