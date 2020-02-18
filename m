Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7697AC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AA020658
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 09:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMUIaj5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgBRJZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:25:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54640 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgBRJZg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 04:25:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so1980734wmh.4
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 01:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=whXq1vWQsIJ5SYzoRx7AyojRhB0CogjeauR+o6SC2Lc=;
        b=vMUIaj5JIb5Y/wdnu5BVx46w+giByh45cLMEqylRf8dWbGKhwcFFmmvg8VWOeFr9HL
         m0n9AQzQ+FLwYU4VtPHQA+CT/aOraySWo5EJZxEMQJtapq5EJewoUcQ6R1pJ5j3PkloQ
         hG5fBFlJeDa8QTDXFWkBSL0fFhur7SGpsV0pmZ2tmS3IGkxat3dTkfz6RBoQIwvNOQO6
         qxHnW2QYDvUyLWo1rj1L1O5sbuQ2zu9yjGZ9+YK3g/EYUyhR6zoklgfdjExAVaZhOVxi
         eL4sSgNR+zRi+8pA3WigkGpH6xNA8BcHxZTgpCBQqb6Xvy8RacNPsjUzua3k6cpYE4lF
         FAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=whXq1vWQsIJ5SYzoRx7AyojRhB0CogjeauR+o6SC2Lc=;
        b=n73GL66o6Wu0wdCR7OllOq1mj4XAAbSYVgQPERHEle1eShQO/OWGGg73IVrd4Dyfsb
         EXAYWe7phIRRdS8D8F1z1NSXV+jERkcFtHfSLcmHfdhN5PujiH7cWOAxre1vmeKhknvj
         WtLNfMx6ArD7qf82EOmP+iS2jFP9cm6HVbr9FqO/NbZKSVLxxDKBLi1J6XSYC2GeRFUK
         L9D/bJBlXX2sVOulv3Ah8xAnb0HAEaqa49DXn5x1GSRHZmOOF1jMPriHrGTdUlymuohb
         H0e41ZXQ9W5bq0RaWj5re9lxmbOjPI/NMejnJXGYmRowSswerTEPAR+pt8211nh27OG4
         p7Mw==
X-Gm-Message-State: APjAAAXzwvrqBhcp6Tz1XeJPnI30A5yDTPW2+e6eWz2dFIkCcsyRE97E
        O6RgGen4apv/XBGOWqsIRLPkH0wW4YmnZ8RVjw5fOg==
X-Google-Smtp-Source: APXvYqw1cOKk4QAcLiynYX+fD101neC8KUfzkkLrqNuun642INZDfWbpYdDSKFEMWVNZSg1uaDrUu5GePDjf0ScUqTo=
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr1926804wmm.157.1582017933616;
 Tue, 18 Feb 2020 01:25:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com> <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net> <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
 <20200211000520.GA6454@camp.crustytoothpaste.net> <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
 <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com> <CAFQ2z_P-nK4OSb-CWwm2Fqh=kc3H4PsHu6K8Zxh_HRW9_-Z2yQ@mail.gmail.com>
 <20200211234000.GA6464@camp.crustytoothpaste.net>
In-Reply-To: <20200211234000.GA6464@camp.crustytoothpaste.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 18 Feb 2020 10:25:20 +0100
Message-ID: <CAFQ2z_OGU_X1Mu=kzd6tdDGtYGEXzTHz+AzrK+KAuQx7ZPZ8qg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 12:40 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-02-11 at 16:40:56, Han-Wen Nienhuys wrote:
> > I can see a future where we have a different format that allows for
> > more metadata so we can encode the hash size separately. But maybe
> > that can be for format v3 and up.
> >
> > Let's do format v2 =3D format v1 but with 32-byte hashes.
>
> The way we've preferred to do this in Git is to write a four-byte hash
> identifier into the file, but we have legacy concerns here, so I think
> switching to v2 for SHA-256 is fine.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



I've implemented this in the last version of the series.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
