Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6491DC4BA1E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E2E206E6
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVFREmiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBZRym (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:54:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51560 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgBZRym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 12:54:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so219500wmi.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sqADA8o5cBfFIyqfoGStHPDJqBJpkAGPPbsyfHqmeFE=;
        b=WVFREmiXi5WGVaLXCDkjf8iuTWztC43ey8jKQKTQsmY/wCApoBPdHgPEuzp2zsQzD4
         ZfRvlbTUSvrAJk68Qm0zadKujPEyv3WfoBpSqmXA/6inwXOWaF1mA4N24YVzatO/IWgV
         HqCefbvA4bT7VizEMFR/Hm6vR1XJl7t3b2t2IKwVwbGPugoHOioqBvZQ9KvI6BIDQBPt
         DbfzV3o89/ytwUnq3i7/Lus7NZoSw+jCtvDYxuzVtYnHrbWg2+MhdVm6Z7R0TJ2a8RZB
         iMUVa9tU6Iz2BeNJTHNHlZkswqmf5ZD0WP+c6SN8FA4PObEMOvPsVKqNad8VAFjHuAs4
         1vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sqADA8o5cBfFIyqfoGStHPDJqBJpkAGPPbsyfHqmeFE=;
        b=T1JOplQJUjN88TBe6a+wSDO6TVwVLSPhaQidokIL8ETXUAAy2az/Aa5x58HdFqs9Hx
         YodsbMB+0ZNeze7ZVIsTB0ehsqQlTLL9FmhTI9QJOH2oCBQCdkzyjewTwYt+y90oHNbR
         ER+7DQfGRwa6cXX+Va4VWlkZryPhyj2D3fXFH70gFurzeMfotF/uCZSXJQrG5mjXsPzb
         qt1aigGECo3TRx+GmyM3+q3q3v/0fdtXATj3d9dx9w4u1fcpz2ynsxusQndiJZLbZIGr
         c27H+lD0meSh1SOO9Fie0uOpJCZUzXiIMyZDNxGQcAJ+TFf7pR7ZWCfN5OTqvVNGad43
         NRhA==
X-Gm-Message-State: APjAAAUVzkSHpPsD5WoiIst+swrKyX5MhTakZNnZniHpVHRj4zXvQsnV
        iDekG+fmh01q0BqgVgMkf2v+bbIGdoqgNWuAI7KUSw==
X-Google-Smtp-Source: APXvYqxHLXMVqE0kqFFzxTt/zNyoEhP62pRoNBjwTDqGhYKo2Kgh9qTbeaInRTKLTeRv/Vv/dDwDO2hYpZ8YUiBt+uM=
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr18910wmm.157.1582739679618;
 Wed, 26 Feb 2020 09:54:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com> <20200221064026.GA11129@google.com>
 <CAFQ2z_NQn9O3kFmHk8Cr31FY66ToU4bUdE=asHUfN++zBG+SPw@mail.gmail.com> <20200226174117.GA103006@google.com>
In-Reply-To: <20200226174117.GA103006@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 26 Feb 2020 18:54:28 +0100
Message-ID: <CAFQ2z_P036Dr+m96k7KzT0korrBXCtj7HpyZV3TNEWbz6OG0Rg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 6:41 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> (+Josh Steadmon, fuzz testing specialist)
> Han-Wen Nienhuys wrote:
>
> > You have convinced me that we should go with the 4-byte identifier.
> >
> > How about setting version=3D2 and extending the header by 4 bytes (whic=
h hold
> > the 4-byte identifier). The footer would also be increased in size.
>
> SGTM.
>
> > BTW, could we document that a reftable consisting of just a footer is a
> > valid table too?
>
> Yes, SGTM as well.
>
> Do you have sample reftables collected somewhere that you use for
> testing?  Asking since that would help us set up some fuzz tests. :)

No, but the library is standalone, so writing fuzz tests should be
easy. The C code is essentially a copy of the Go code, so you could
start fuzzing there. I believe it is really easy to setup fuzzing in
Go, and we could generate a corpus starting there.

On a related note,  I should write interoperation tests that pass
tables back and forth between, JGit, C and Go, but I'm currently
focusing on getting the code ready for git-core.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
