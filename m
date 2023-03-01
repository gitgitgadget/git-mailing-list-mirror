Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9644C64EC7
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 09:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCAJOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 04:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCAJN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 04:13:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB522FCE5
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 01:13:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ck15so51263787edb.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 01:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677662010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1+DEBOfQ/a09/hPOfRkq42BRFl0kC3YIRebiYhiUTM=;
        b=erR8ZE+cdnJX+fuULNRPB0Nfs2epyxDmyWU/E+U+yr5i8gENDUaGjmESKEjq6uSM0B
         B16g3RrxMxP6wHl+Uni5pcj3HE08lbnZVcPMsBUrLCVU61SiZU54WdyfxB8tOuVLJBBW
         gj7tCJ8cEP3C9l+ruTEAWhtJnTsudePGPdEPpfMNuPfBsEYMdI1Oq3fUkYnZ3TA2GCsC
         NkZGrM5cjWizMyxsqM/w4VXXMMcwHddcDfOmMBgXl5hgtNFMX5YNZv+Ajb5VKVErupQl
         YutwMtkHFctV0I8zrjpmkEzdbUKmzkDbSzXVraGA83CFk5hcRbm+6+4wavWUru4dQV5W
         59EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677662010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1+DEBOfQ/a09/hPOfRkq42BRFl0kC3YIRebiYhiUTM=;
        b=C3QM8Iu8+hw8HFj8RDFeB+lAY5/QJj0TUN0fZ6C6ytO32Zh/r7PgtYPmX8wxAWfEPi
         +qcCcjZrFTkVImjqvvB2S8p9s5PSAuYefgqfQa2fTR6Cz0BZEq2zlO3nJWZCPOXHSlb8
         pOEtkAf0haqNxMVc1TIZIRhdQU8zkBC1sdlRI0Ss1mTHdgHy6LLkFG3RPk0vyXnm4fcx
         mZeHpDS65lkQUXdD6SuXGmZ1EWSlJMQ5mSfja0qbiDB9b9DkZ+f5gDjvGbOEMtthEHc+
         Cu+WDjWHttCXYI4S9fa2hDdrwpuoi8IXr2E1AHq9PhHm3ElIYOnQVsC4Z4/dSP1DCwbW
         biPw==
X-Gm-Message-State: AO0yUKXAI8+o6DM3A9x2eLW1LQtiCj4Gz1R4FsZ4Ve+bXIfQ7R9mC/LF
        vGW7LcXHRht+9GU0OwvkQytcVOufBG7IempY7UTb8Q5mDBE=
X-Google-Smtp-Source: AK7set8xYwMmxj68XLDvyqdz3MwcNpH1zgWXDtwODIK2ckLuLzPN13VG+gnVXXmhMBB6d++grIl1KfcgmBxodYEMH4Y=
X-Received: by 2002:a17:906:4dc2:b0:8b2:23fb:dfd8 with SMTP id
 f2-20020a1709064dc200b008b223fbdfd8mr2872465ejw.12.1677662010373; Wed, 01 Mar
 2023 01:13:30 -0800 (PST)
MIME-Version: 1.0
References: <CACoz=-x6kVGMq1oCq8-5k2Hb82DCqi94_EmX6w4_9uGXnwBLaQ@mail.gmail.com>
 <Y/5SyNUbVfKFMxsf@nand.local> <Y/5yj8uAEM3Pz7T7@coredump.intra.peff.net>
In-Reply-To: <Y/5yj8uAEM3Pz7T7@coredump.intra.peff.net>
From:   Danny Smit <danny.smit.0@gmail.com>
Date:   Wed, 1 Mar 2023 10:13:18 +0100
Message-ID: <CACoz=-zOhoe=gQ_0Jr=rbdBvh=tQhLQ=Hfmb4Z=ZePpsaWcTHw@mail.gmail.com>
Subject: Re: gitattributesLarge: .gitattributes too large to parse
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2023 at 10:30=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 28, 2023 at 02:15:20PM -0500, Taylor Blau wrote:
> > You can suppress this message with:
> >
> >    $ git config fsck.gitattributesLarge ignore

Thanks, that is useful to know.

> >
> > It's interesting that you can cause `fsck` to produce an error in the
> > bare repository but not in the non-bare one. Do you have
> > `fsck.gitattributesLarge` set to anything in the non-bare repository?
> > Are the affected objects in the `fsck.skipList`?

The configuration in the non-bare repository is almost clean, except
for the remotes and branch, it only contains the following:

$ git config -l --local
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue

and:

$ git config -l
color.ui=3Dtrue
core.autocrlf=3Dinput
core.bare=3Dfalse
core.filemode=3Dtrue
core.logallrefupdates=3Dtrue
core.repositoryformatversion=3D0
fsck.gitattributeslarge=3Dignore
pull.rebase=3Dtrue
push.autosetupremote=3Dtrue
status.showuntrackedfiles=3Dnormal

So there is nothing in `fsck.skipList`.

> > Looking at 27ab4784d5, the comment there says:
> >
> >     if (!buf || size > ATTR_MAX_FILE_SIZE) {
> >       /*
> >        * A missing buffer here is a sign that the caller found the
> >        * blob too gigantic to load into memory. Let's just consider
> >        * that an error.
> >        */
> >       return report(options, oid, OBJ_BLOB,
> >                     FSCK_MSG_GITATTRIBUTES_LARGE,
> >                     ".gitattributes too large to parse");
> >     }
> >
> > ...so it's possible that the caller indeed found the blob too large to
> > load into memory, which would cause us to emit the ".gitattributes too
> > large to parse" fsck error without a .gitattributes file that actually
> > exceeds 100 MiB in size.
>
> I think that "!buf" case would also trigger if the size exceeded
> core.bigFileThreshold. It might be worth checking for that, too.

As shown above `core.bigFileThreshold` unset is in the local git configurat=
ion.

However, I just found the following configuration in the `config` file
in the  bare repository, where the `core.bigFileThreshold` is defined
with a value of 1m. That seems likely to be the cause:

    [core]
            repositoryformatversion =3D 0
            filemode =3D true
            bare =3D true
            bigFileThreshold =3D 1m
            logallrefupdates =3D true
            autocrlf =3D false
            eol =3D lf
            symlinks =3D true
    [gc]
            autodetach =3D false
            auto =3D 0

After changing the value here, the error is gone.

Thanks for your help!
Danny
