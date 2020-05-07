Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F30C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711C22083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/b0s51q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgEGKLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGKLR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 06:11:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78594C061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 03:11:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g12so6129718wmh.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oFI0wvyX9TCY1nHHIlBzptCLZ5P4Go9+kdceCw4At6M=;
        b=p/b0s51qQIo639QCGOVTMbhJ10n57NErx3ADH+lFqwlZO+hQioK/3pMyDWWpolpvJa
         YvjV5tjV8KtpkoayRApm8YrvsrQyghpQSxR33bQL31x2CbM+XAXtPJ5I1Kj+nYTBGkEx
         SzUDvs6zQqcUEcfl2xLQ9xBxfW9XnFUarGdu0lcqP/FGAVq4XSVnqfXb9pqBN+SN1JSu
         HpoNfrbSduX00z0YbBSyxuxYhOE9I6gZDkUdO45x2R0f79rzF2zfYQFH36KhMkxaGbJl
         satcelD9RaC1lALFE6LEx7XPD9iiGcD4R1t8LIDM3eqCjp17NOK9n9dDuATVnztR5kUi
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oFI0wvyX9TCY1nHHIlBzptCLZ5P4Go9+kdceCw4At6M=;
        b=pKwBTIUnCIxgn51hlcBCuJbcJfdlfMicHkFJjsJiC+r9tUmudaphFZwf914Z9rh72b
         F2UhnGj61n4ckziTnDcQ8lBM5nOJPYqGHv+26qtQh37ULcqH/pefshZPRpr+DmJAo1C3
         VCnYr5T7m7H/c92r0sJV882wdRTJImNUYO69xV81r5upXr+m7FkKhhvds623ECWwTsgS
         I0MPw5DJxB7jgNg8yzMMcC96o+gW4Zz08qsTQKbW+gmD8bAU+4Eg0LczHwbc9U/W0+3M
         5HGHzmd/Yn/6jlh/TeYtc9gfw5Jv1riVO/5PrcTjqRlOjfM0jzyEc/WfN+q7jL+Q1DYf
         CI0Q==
X-Gm-Message-State: AGi0PuZnprCf5Im+Opj0SnnPmLHTqkCYBqCdYBXuhCFB3Pww9RwJvhjL
        ME2M04xM1LrPuA6tNyGtbDJU+YxhJd2N3I9ju77ydg==
X-Google-Smtp-Source: APiQypL91VoKSyBQBVe/YnDWT+S7nldb9hHImSk6W9WEzrYrztdCrWn8AFwN4rX5IcIV6eHWOBkjj35KEtghdC1Igrc=
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr509985wmc.63.1588846274688;
 Thu, 07 May 2020 03:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com>
 <CAFQ2z_PP9Ld+GDctV-v2CDKFamF6zKdJZ_-jhahj_fcm3wy4Hw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005012316350.18039@tvgsbejvaqbjf.bet> <20200503095500.GF170902@coredump.intra.peff.net>
 <xmqq1ro1j6qk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1ro1j6qk.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 7 May 2020 12:11:02 +0200
Message-ID: <CAFQ2z_Pf7u0k-PvMG8J-kWMdRXhamm5JgHZiUM6Ffu-2zGGubQ@mail.gmail.com>
Subject: Re: Git Test Coverage Report (April 30, 2020)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 3, 2020 at 6:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I agree, and I think it's not just a question of review, but of
> > maintenance going forward.
> > ...
> > ... I'd
> > be even more afraid to see similar issues in something as critical as
> > ref storage.
>
> Thanks for saying these.  I have nothing to add.

I have sent an updated patch to fix the header issue you pointed out.

I'm discussing options on how to move forward with Jonathan Nieder.
Once we have sorted those out, we'll send out an email, hopefully
early next week.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
