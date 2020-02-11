Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FEEC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477812086A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 14:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1/GzKRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgBKOUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:20:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37599 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgBKOUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 09:20:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so3789028wme.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jY75VS+1NfuIwTUDC7T+IrUekPdiiwDDvbb9QNoCpCQ=;
        b=E1/GzKRvCRLrrvtEbz5dNf4SWGQF9O0k0wqSMIROoxSOUApSfPW+ZZhMsqhmg/CGYo
         w/Sla/NlbSUGPve5hJtQSKrh+R3HzzEtpvIuRsBPDG1sSoJLXzlA4dynpyxWBHBsb8GQ
         aNKM7SoCzfRwppZJf0YxV6gv/Y9ftMyT86aHY6/ux4AU3AKQZUslmKW0WBcdci7uzo6R
         AQF2sGHyhJqwnmVfxkFtpt5QcJczHMSNRzcPFfyoaVkJ8xfam8X3tRnPR+8OfvT/lYT/
         b3MOqIxeTBLMLUjTR/HWEKLTt2cscZ6p8opvm/EgkN0DzESIhPU384WITj/ed5o7w7BY
         Ksag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=jY75VS+1NfuIwTUDC7T+IrUekPdiiwDDvbb9QNoCpCQ=;
        b=f/IGMtkQRUleIJYRrI/7hfBrWopYbPT1RMqWLlAp0tyklq8gHl6Vo89mtl74y3wM3W
         XBlggS/NAbx3RhkhhSGUJ7AUegdHBftUB4HPJK64Qe4jEDCfIyGzH3hMQRczxlaglDG0
         tgsrqWoDI222i/z0GaPbK8H/LiGP/MoTSgo9P425ifctDoOFNO/LiHKMBktUfnrCfSou
         +vZVVICWKFsPBefS3ZeGu0pTzzdVSaaEEXZofDT1WdTBWCdZ7dl8EN0JY2/N8Xm0j1Ci
         WnK6b2QRajDZcXzWbwgCrcfPerEI01/DXtWZgnyRN88lx4qrTwF/TtFWHvNNCs8xy+kz
         ILAw==
X-Gm-Message-State: APjAAAViKt1ZgqA5snp6mpHXdQ8P0AVZ5FuHzb5mgrYHrHEuxqTRmyep
        4QEBxmEopoDBDQwIrHAJ7F0OCtQFT5IGmxLxqsKK1g==
X-Google-Smtp-Source: APXvYqw/AoK6/F5V5ZV1wzrpkproEN6TpJqDEtgiWn+yiqt0hu7yX1upVH7GmfYLRsbf8QG1YDJy7jQoCxYZjnyQGbo=
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr5844655wmf.63.1581430828522;
 Tue, 11 Feb 2020 06:20:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com> <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net> <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
 <20200211000520.GA6454@camp.crustytoothpaste.net>
In-Reply-To: <20200211000520.GA6454@camp.crustytoothpaste.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 11 Feb 2020 15:20:16 +0100
Message-ID: <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 1:05 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> > As this is within the library, the hash size should be injected
> > somewhere. I don't see huge problems here (the hash size could be part
> > of the 'struct write_options'), but until we have properly defined how
> > reftable will mark the on-disk files as SHA-256, it will only supports
> > SHA1. I intend to work set the file format in motion, once this SHA1
> > version is accepted into git-core.
>
> It's not required to mark the on-disk files.  A repository's storage is
> either entirely SHA-1 or entirely SHA-256, except for the translation
> tables.  The entire marking of the repository is in the config file, and
> everything in the .git directory is assumed to be in that format.

I disagree. I think it should be possible to determine if a file in
reftable format is well-formed or not. Since parsing requires knowing
the hash size, we have to encode it somewhere.

I've uploaded https://git.eclipse.org/r/c/157501/ that proposes a way
to encode the hash size. I  look forward to feedback.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
