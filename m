Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF4C43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F97661452
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbhDWHyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbhDWHyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:54:02 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF17C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:53:25 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q143so5754010vka.13
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m7WTIlbAuoJ8Comu6589bKxVJVGah1OGnJhh0CfGeUg=;
        b=urg2HhF6QQnbG+MEgPWd5/X1odj4mePm2TnEd2YbiAaQQebClWwJZgoCQ5E6zVKobB
         4lqyjAIAXcvYarq8XwDC5ZmoRuYbbc+ecSZ6ics0WCeNOGZr0p8o1VYPy2UcKTra93FU
         bBMBITwbn76yck0eOuqBpbKfNaxGhV8fuvkbz5gtKDsnqftZDEmEdWe1OlXIAFCzh+0T
         auU87WSzxG1gLqRSqLpyTMri+P3TAjobuySo1NsnhOaqxH6BRTyIq2Si7BIh6/gefkzF
         WWQ/ieJFrqQVqexLVjdVB09F1mH9Y7h0+Gb7Yd4H3UW0YubGyRgtRpOmc2MBCLkvQelU
         kkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m7WTIlbAuoJ8Comu6589bKxVJVGah1OGnJhh0CfGeUg=;
        b=QjLY6nH4TkVRXjxzz0sLyEKNOGwjXiYgqTlqu8C//Au/F4QOh4UMGwkx6GuEpup0ik
         XW46eAjiUt4Lt3triuwjSn558lme0ZKfQHf59xAR8cwtxnA5eahjKNnYED7zdHyKKSmc
         P5i6OcL7uiCbbjB4mb5WOrZxQXK81GsbIh27t9Q0ql6NbaKZ04mLNy4gjNARta2aZOGP
         kUL/LDpqlJMk3Qw/DeKfuJW0bKUT4061ca1w72TEs2SXycvgd5ldEvHOoiUkQMTyF11I
         ZbDRXtFNq5wwCNeZaZhfLAt0K4yH8W3y8pWiNTRGX1kla2snNdiW2Kx535cdFfULUXke
         WgaQ==
X-Gm-Message-State: AOAM531T5np3g41H5LaVProDYz6NHo9FiK1II8NY+V33ybfXDsIbKzRA
        pFNZrdw5cllN4zsRRIGjiLuj9YC978ZD9Dvb3gYGbA==
X-Google-Smtp-Source: ABdhPJzpniIgZQ+HblBORNFhnnE01mwZ6lI5u2/5OjuFyGQXpsPwlp8chGaePejottpP16k9GDao+7IBSOXg1N1c1wU=
X-Received: by 2002:a1f:3105:: with SMTP id x5mr1941169vkx.8.1619164404531;
 Fri, 23 Apr 2021 00:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
 <871rb45ftz.fsf@evledraar.gmail.com> <CAFQ2z_MMAM6jZ0+zRi+8fyS69Qw4fKQSsXgQW2zW7tcMdmN=QQ@mail.gmail.com>
 <20210422045953.GC2947267@szeder.dev> <CAFQ2z_Md=LAkJzohf3E5ogWGQHzxN_ik=yHAGmxm7bg-yT6-Zw@mail.gmail.com>
 <20210423051255.GD2947267@szeder.dev> <CAFQ2z_NgFC-7zENyD7HkEgvS6Dtc4qYqPRFL3m1LsbXnrFkPsA@mail.gmail.com>
In-Reply-To: <CAFQ2z_NgFC-7zENyD7HkEgvS6Dtc4qYqPRFL3m1LsbXnrFkPsA@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 23 Apr 2021 09:53:12 +0200
Message-ID: <CAFQ2z_N9_eXtuGcXSj1bwP5sy+t1fn8Q=X1na0jK9OpzDz2UAA@mail.gmail.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 9:47 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>
> On Fri, Apr 23, 2021 at 7:12 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> > > I see it as the test writer's job to clean up to the extent that
> > > git-symbolic-ref can reset to a sane state.
> >
> > No, it's the job of whoever updates the cleanup routine to make sure
> > that the updated cleanup routine still works just as well as it did in
> > the past.
>
> Sorry, I don't mean to shirk my responsibility. What I mean is: is
> there a way to signal "This test is fubar. Stop further execution of
> test shell script".

Or, more generally: if a cleanup routine fails, what is the point of
continuing to run the test script? If that happens, the test directory
is an indeterminate state, so the outcome of follow-on test-functions
is indeterminate as well.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
