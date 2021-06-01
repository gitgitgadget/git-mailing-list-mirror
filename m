Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F22C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548FA6138C
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhFAJZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAJZC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 05:25:02 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0EC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 02:23:21 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h11so12248357ili.9
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=36kHjN+z8mFXoCVHhY0k0+G+nQlKsPaJyDJADXVlkuo=;
        b=gBnq1F0LswWxHNj2PtGzS4Xbv0EyG7oLYmjx+ICMiRVFF5ubz2R18YNhQzPVqvqJR5
         gxXlEm6U9s8gWfScq6CCDGtHob8cfjQW0FZpTrAwLDMlK3pud3uIIsI7zc7uNzsdqEdt
         gzbAbbYtFbvLb7o+zObdOnYAwlUvpKUW5gnwfYrskzR/pf5vQlL06ZLJsVHUNmx8UIxG
         gVnXjZheo+N2fTNcKYAnxNF8dFKm0KrxTLwJN0G4aUjLAtueF/4WKDjdzLuDZkq5lREl
         rKROxi7xVLWDIblkdsnSaWy/yx0nTVKs92Xsjn8CU98oIE4ODSbwBsJqljb6IOuLOYN1
         fwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=36kHjN+z8mFXoCVHhY0k0+G+nQlKsPaJyDJADXVlkuo=;
        b=cD11IXLNKUslm9ZR4pheDhxkxUB2HLJJJl8xHOx8Ar6Bbd8IZoyHXJJD/2wX1Jx12H
         dvdzi90JXCw8r7QKxHAMl6ITVx1afgio3ghbtAJxM5rOVZo8eEqtO2Ay42+WAdYlIpzs
         TRxO/7d0gpW1AAEsbm0OF85v9t6qXKy3FpYdOyGM46eEcLeNSiS6JZ+vaSvTlNccxGqQ
         02rSArxjQyxY9tIojZiJE4YqSCm3hAwQNfnN6lbUEKsYg1TrWWwVbsSbnjZgL1JXQuos
         y1udmmNfxN+Nw/eLQJruz4F7qXVHtxUC/glOQJd+eVh+1LG24kacn22EUPryyP4abDS3
         rYvA==
X-Gm-Message-State: AOAM532hg8+gki3wwS4r5rH6y5hiuJwEHcY3jJJklFT93RCliHgs8tF2
        oOINDuNVFtQ+Qne67LahtObUfuWQijya08pXOFcpzg==
X-Google-Smtp-Source: ABdhPJxGitzV0ubJIpfKTQMB6VWJpZJIOTV0nmtnI9xEAbwkYQALA8QftVLSkbgOv2IYaTY5excfLyy/ewmKjubi2Tc=
X-Received: by 2002:a92:de49:: with SMTP id e9mr5998980ilr.56.1622539400881;
 Tue, 01 Jun 2021 02:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com> <f6ab40c4e6599540da38ae5af8e574dc65909e79.1622480197.git.gitgitgadget@gmail.com>
 <51a802ff-0789-4051-6d45-5b9c6e55ba8a@gmail.com>
In-Reply-To: <51a802ff-0789-4051-6d45-5b9c6e55ba8a@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Jun 2021 11:23:08 +0200
Message-ID: <CAFQ2z_O2t2cDvTs0aNqB+9FVSy51CKrJxxdvu9WGg1s6gZziHw@mail.gmail.com>
Subject: Re: [PATCH v3 07/22] t1413: use tar to save and restore entire .git directory
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 1, 2021 at 6:55 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 31/05/21 23.56, Han-Wen Nienhuys via GitGitGadget wrote:
> > diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
> > index bde05208ae6a..934688a1ee82 100755
> > --- a/t/t1413-reflog-detach.sh
> > +++ b/t/t1413-reflog-detach.sh
> > @@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >   . ./test-lib.sh
> >
> >   reset_state () {
> > -     git checkout main &&
> > -     cp saved_reflog .git/logs/HEAD
> > +     rm -rf .git && "$TAR" xf .git-saved.tar
> >   }
> >
>
> Why do you do rm -rf git directory then extract tar archive to reset?

I'm not sure I understand your question. Are you asking why we have to
do a reset, or why we'd use rm + tar? The rm + tar restores the former
state reliably, so we can be sure it is correct. It's also independent
of the storage format details.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
