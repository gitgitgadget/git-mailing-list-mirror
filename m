Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D3C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjANIYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjANIYN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:24:13 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B95BA5
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:24:12 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1433ef3b61fso24627771fac.10
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDgNCEqMN85sXxC+7trbpwbTRDfDL2Zyf0f1AJIdNqQ=;
        b=A1zggI1VZwICvbxFW5DqM82eGvX6uEk6mQHA7MeRsv2Eo606FhjaCVXlsx7SHVOlfU
         xgvufg7kE9a3u75JO+xzHpQdxXmD1MvW0FWur45i9dWheNues4EuLv/6f3Pz434+inOf
         cZM9RCOdzexMVbsUw8O/mDmoA+5FWfOsZzfgNjBlJKpBplPFXOA7Xg8DGJ74fu0qp929
         NGJQ9HPzQJHh8DIqukwPNwjjtok14W8Rw4ZVeI88Wlyg/gMtDcfWOljI27C4ktNJaldk
         RDKpuuSdJhyR/yu5vJvqLwbA7LbR6lM7gDS1LGK6IGDuhLg6KbSipXXNTuxM1MtvomoM
         a+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDgNCEqMN85sXxC+7trbpwbTRDfDL2Zyf0f1AJIdNqQ=;
        b=JrF1+MBU34cD8qnbKL9dSRDzP32fB01xalvwGLs6+wOmQpLl0N8enHUBN9bW16sFod
         bH4OjPxX8V1MEE0Y6B7oUMyUJ8znBvR26sStsxFfkHx+ALG3hjVHBpdskk+GKOu8G1C4
         0zU00PcXi/dZ0aoDSqqUadgyKZswOsacXtrJR2CuMBJY8lj+giklSJESOlmSbF6QJmA3
         fPHNWjKZIiSz0uUUa7iVSq9P1aNg3EMlVgkZbwTXWNQw0n3YnPTxQCsUG5BhsSfLd+3n
         u1vzIlaf/Jk/Nd4QmvIwLRQ39i+F6WAm7juDL41gT4oVfdaJHvuBmgvoNbyPA2evuUQH
         5MpA==
X-Gm-Message-State: AFqh2krkOD9owcIYS3dlpDkpJIhvhBL3zgxRcd+alWOCtlTm5kJPryjt
        MZW1qPIXr0tIGmSdbJen1TDhwz9bXqFbtzWacXBdyyw6imc=
X-Google-Smtp-Source: AMrXdXuP8NCp34aOvzGBRWY3EjP6Pla1xaL8I74rNZ0B+RAAiKRONAjYl7d/Ox0cnWycfE0MeZbb7DXW63cv/Ix3oMc=
X-Received: by 2002:a05:6870:1c6:b0:15f:564:f796 with SMTP id
 n6-20020a05687001c600b0015f0564f796mr134551oad.270.1673684652154; Sat, 14 Jan
 2023 00:24:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673521102.git.karthik.188@gmail.com> <57f5957127ce3be2621445806f2f00857ac8b1aa.1673521102.git.karthik.188@gmail.com>
 <xmqq4jsu13id.fsf@gitster.g>
In-Reply-To: <xmqq4jsu13id.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 14 Jan 2023 09:23:45 +0100
Message-ID: <CAOLa=ZRZDKqPq8ChZtD48207GxnjvqKPPvAJaUVOW8oKrRtGMw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] attr: add flag `--source` to work with tree-ish
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > diff --git a/attr.h b/attr.h
> > index 3fb40cced0..f4a2bedd68 100644
> > --- a/attr.h
> > +++ b/attr.h
> > @@ -1,6 +1,8 @@
> >  #ifndef ATTR_H
> >  #define ATTR_H
> >
> > +#include "hash.h"
>
> You only want "struct object_id" declared.  Why include the whole
> file?

I see, I should have just used your patch, will add this and =C3=86var's
[0] suggestion and do a quick re-roll. Thanks!

[0]: https://lore.kernel.org/git/230112.86lem728ig.gmgdl@evledraar.gmail.co=
m/
