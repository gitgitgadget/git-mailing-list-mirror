Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4B7C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 07:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797EF61450
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 07:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhGAHWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhGAHWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 03:22:14 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F7C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 00:19:44 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id y25so3265544vsj.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bboILvmf5Re+k6rZtXdSi1UtZegwcUmlCBWgY0bHmjw=;
        b=rmD3z2SDpXxafmkC6OBKmHIwMvsnDG6Z7T0UrwHS2iayMhghDOQajRWBOtbaIyBlot
         YCKtsL1mykQV+7JEskzP3bNQMCiiZ9C56/hRLZCJ+b71RZJNtryKTc42EcEYWbm5KQk6
         wmi8bdEZ9q5Edf2Xn7+RdE0Wi+efnAmS9hG4YgdNFPfSNDQD9DETZfBvqqd24KKpkBmD
         PZtvMMrZTRrUn5Xa9sh8RFt2B4slSxR/trqCgfgDWDhaV7lW7lWfMlF1mkf4CSqTkV9X
         eOYXXvM0Dg7HfDMjI4pACGZObKAQsHh+FXOLXldU1iN4l0ce5IuPS6PUyvnMXcPjznrF
         htow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bboILvmf5Re+k6rZtXdSi1UtZegwcUmlCBWgY0bHmjw=;
        b=i58bANmvjVt8pVwqXFDnZ630ug5RkEmQFRkOgbYuJfFxZpF+FrfTOr0r2Dmux5QB5V
         2jttirz0dkdkfjDsP6PXqQAqF7md3OjHV/RVx7xOeV2eDiCBntXuIg4aqoOK1QOvCatj
         9iNVF/mw5z7EfhWq+iQUFk1/oWEI+hLtkITC1uRsY8UiZxu5+Xj4c6rqyV/gk9Ntd5Km
         zhj8r7LjyJZts983yU0NMKoHVm3rOSEQvEGyHvnTWU1Xx80rjqWoCzYbPKWZhtbh/s6s
         raRgyoR5dQ8VHKt5rLoNt9dX5jCijYIx4S2+epb3D9kPQ9YfEilFFUgzsP8a8kWUmy+2
         FGjA==
X-Gm-Message-State: AOAM531DPr6iwLKm1A8I73hwa54kYvpvSU4zRaAE8qG+MFoXiNUAv8so
        RO5fne5lAC4n+qLXCQQw676CJtlb20tMEBAWdi1ZsL5dr7w=
X-Google-Smtp-Source: ABdhPJwaR2eiWAEkWLwHbgXFZ4qmuqjxEl8m7xN21e4AmbXdxaEqXbMnzxMCSu5q1pbSI/0cBEjCjrrU7jw+kXmhV8g=
X-Received: by 2002:a05:6102:949:: with SMTP id a9mr35788155vsi.54.1625123983596;
 Thu, 01 Jul 2021 00:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4kdft122.fsf@gitster.g> <CAFQ2z_PYJMzOBcN+KoQSfdD-eYtZVzrArL0Dh-YW-q3R8hgm2w@mail.gmail.com>
In-Reply-To: <CAFQ2z_PYJMzOBcN+KoQSfdD-eYtZVzrArL0Dh-YW-q3R8hgm2w@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 1 Jul 2021 09:19:32 +0200
Message-ID: <CAFQ2z_Opw4dZmH7Xc4tRzMvD-op-Reh3C7sM31VoNM5eAHaiLA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(now in plain text)

On Thu, Jul 1, 2021 at 9:17 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>>  Futz with the way 'errno' is relied on in the refs API to carry the
>>  failure modes up the callchain.
>>
>>  Will merge to 'next'?

Is there anything I can do to address the '?' here?

I am happy to do a review for a similar sized chunk of other code for
someone else in exchange for review of this.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
