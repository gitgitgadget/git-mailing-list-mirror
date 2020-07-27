Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9CBC433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2294920719
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 08:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7psEigg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgG0IvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0IvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 04:51:02 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64DC061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 01:51:02 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id d21so2348938vke.8
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vxTCuwxmSOlBl2RUh77QiIccRkMRqmrVguInQJ0iqu0=;
        b=I7psEiggY8eSN5YoAM2SzxZQTivrhqp39G/m3kBESxoEy4lTjkJqpDbpwYTCm2vsGU
         z8BDo90ezriIUKJrGzZGMag5sF7ZU0ItdW8+6+aPtGNiAvlG8ur/k7zjhjMjH4lcMhtq
         R7IZw+IL3c3oBjIDS5LgS/6GSp7I6krRutf4wLhEPrAXLNlvfJdN+bfUztBj7abf2e1r
         XwrLi3RaCqfmaWx+V0n4LCl6YYWvEslSncvaeQljsf58hcyH8vyk2Narg5fGGNcMzCmt
         i+rIaYefsqqYlUfD/AdxXRdtJMHqYzsQMxZEtupjETNusQtv7aZH+UCq+dfvlvsmpCB6
         yt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vxTCuwxmSOlBl2RUh77QiIccRkMRqmrVguInQJ0iqu0=;
        b=kxaY5TMm+jErpJc5uuGkCznj6FlyHqvPq54CFYPiPI2BHlEIKweLPkFITzmARN9Kly
         4psmKBe0XqIwhr4jLlO6oqtvaI7V/D1yvE2yMxcElCNABf2t73V5+VjbMnhHEOWhXQzH
         PLnFROmXagfWa9t8gmw8Mr5wlbpOzRFyfdWXf9uXTLXq1I53NZ7ey0Jr1owFBo11raxt
         jker83UyrfpxWhD5DbsDL2iA9wTQ4bjiB7tK7EF7ExQaV6QZ9zAyUPINR+VlotzX1N4d
         6+aIIwckfsVk4TWeej72tH8epmf+AKbAskQKdfIIPxwqi5kqs/Y/tmoOaxrquU1FhxH9
         dcaQ==
X-Gm-Message-State: AOAM530PcxkdlrUdvJYNsoKTay2oKt0OTYxdHMv5w+LKWGH4rQ+x12cz
        A4EDqUGf0BgTdwnEIzhvGGa/+GZVM/hTV3y0Kze/mr26BO8=
X-Google-Smtp-Source: ABdhPJyyTN9Mc+rCXrP6z+Q+h+YxFIp3fE2vgVFxZrmJBT5/vfnCstwNXBVKvBu4fZYQwRinJhzFyjvjp23XT84Dn7g=
X-Received: by 2002:a1f:3d47:: with SMTP id k68mr15685373vka.68.1595839861703;
 Mon, 27 Jul 2020 01:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
 <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 27 Jul 2020 10:50:50 +0200
Message-ID: <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 12:10 AM Junio C Hamano <gitster@pobox.com> wrote:
> I reviewed some codepaths that deal with FETCH_HEAD recently.
>
> As the file is quite different from all the other pseudo references
> in that it needs to store more than one object name and in that each
> ref in it needs more than just the object name, I doubt that it
> makes much sense to enhance the refs API so that its requirements
> can be covered.



I agree. Do we ever pretend that FETCH_HEAD is a ref today?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
