Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E2C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 16:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjBAQJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjBAQJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 11:09:46 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4078E65EE8
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 08:09:45 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g7so1565451qto.11
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoH9NLSXV1jpbU+shXYjKkROGXRLVbGLe5DCKxUH8gU=;
        b=ENQ1nI2cgzwP6ta851IkBoxVCAa5gwJz9nrXDBP1sZ8vUXfVOTtVCQP/++SzLO0UvN
         mJaNRG3vnin6+hjCya/BMTV/BFvkjd1lPGgO2ROzoBrCvO4UVYQG9NZejp2aigIe5lXf
         G9ikUw2zsizY/X92mE0fIRyxS4NlCO9Bthr2T/7ieWBdtIwgZBigdiEDEhheXI5nAcat
         UK8wFabTmOuFuMJrMl5L2qa3D/F3EMxb0at7QpiVLyxfgpDUlWI+dJboIBmjENhMoCpa
         Q37Otf+Urv5Epfe0nlxjvrb/AhdvxgHJb74kxkyy4XFDrXCXn/CZSUcluSTJTkuzmlVM
         AqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoH9NLSXV1jpbU+shXYjKkROGXRLVbGLe5DCKxUH8gU=;
        b=BLMrlvQFMlFiV/U8UkB8MdPusPEvq9ahLT0a5sveEL1VnTjjid/xO2GFasmFb4xATl
         kGPuXb4P6AYYSpvsAGLtXIMM2yJ0zr7pQqS75FulzOySCaUhmVnzH6d4fbdTTtuls1fc
         pCMgLpdFXIlYXbgGjCY0x9ZJFVxyjnZsdrbUa5Z2sj8hOPE9+ugwCpyL+33BY0ElIPEM
         uQC6AS277+IltIm9rwVpwR3+V2EfHgtBOQ5HoZlT/7TJqP1+rohhQ17cRmOOOvsU1/c3
         ziLir6nBxzIgFM4u4ZgSetNpJG7a1L1uYSWSvRJ1tzviH2qwXi4A3rcHO8sGgC6V5ifl
         6oPw==
X-Gm-Message-State: AO0yUKWN7fnuADpzcTPyMYzO9Q0TqUR4yQDxzROU/D/lsDD9JNg4qQJz
        n8fvgPUhETR9QGAAzKMEJO0EzZH/pyDr5bqq88G4DmwzhAM=
X-Google-Smtp-Source: AK7set+AyfCVTTE7QE9kC5WBIJpoU+vdiGX7D2Y6ELUeMoxmf3j41S1C32LsKFUlOSRfL7iRey/a9aMqZmc5Z8B0E5g=
X-Received: by 2002:a05:622a:14d:b0:3b8:669d:4f2f with SMTP id
 v13-20020a05622a014d00b003b8669d4f2fmr344366qtw.364.1675267784312; Wed, 01
 Feb 2023 08:09:44 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
In-Reply-To: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 1 Feb 2023 17:09:33 +0100
Message-ID: <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Feb 2023 at 16:25, D. Ben Knoble <ben.knoble@gmail.com> wrote:
>
> I recently updated to git 2.39.1 and noticed today that `git diff
> --word-diff` fails for files with `diff=3Dscheme`. I was able to narrow
> the failure down to the inclusion of control characters \xc0, \xff,
> \x80, \xbf by https://github.com/git/git/blob/2fc9e9ca3c7505bc60069f11e7e=
f09b1aeeee473/userdiff.c#L17
> in the definition of the scheme diff pattern (really, all patterns).
>
> I suspect the commit referenced in the subject, given that it messes
> with regex handling on macOS.
>
> Relevant environment that I can think of:
> ```
> # locale
> LANG=3D"fr_FR.UTF-8"
> LC_COLLATE=3D"fr_FR.UTF-8"
> LC_CTYPE=3D"fr_FR.UTF-8"
> LC_MESSAGES=3D"fr_FR.UTF-8"
> LC_MONETARY=3D"fr_FR.UTF-8"
> LC_NUMERIC=3D"fr_FR.UTF-8"
> LC_TIME=3D"fr_FR.UTF-8"
> LC_ALL=3D"fr_FR.UTF-8"
> ```
>
> I'm on macOS 11.7.
>
> Failure (using Zsh to produce the characters; I think there's a Bash
> equivalent):
> ```
> # git diff --word-diff --word-diff-regex=3D$'[\xc0-\xff][\x80-\xbf]+'
> fatal=C2=AC=E2=80=A0: invalid regular expression: [=C2=BF-=CB=87][=C3=84-=
=C3=B8]+
> ```

FWIW that looks pretty weird to me, like the escapes in the charclass
were interpolated before being fed to the regex engine. Are you sure
you tested the right thing?

Yves


--
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
