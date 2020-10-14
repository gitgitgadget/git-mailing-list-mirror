Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B90C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E922202
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syM9/ERl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgJNO2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgJNO23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 10:28:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463BC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 07:28:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h4so1863386pjk.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4P3gHvc5tNHiLutQxXmqPUsDu4OAR/CSIKRXbAXRCg8=;
        b=syM9/ERlWIcr8pMITxuUjoEr1Ty3pdpjJgTaOsc+OnqPhl7kuF7q5frksQ9vSB/QIH
         dsXG2Ns0idYmmFP05dfMoz1mwMWaPaafNy5f8g57u7vNPWirTP6TzSyY0ONf+KkAi+iz
         mZiBjTgNFwMwHaGGjTaV+E1wBR6Vn9qqG84NsQb5hCE3oGQRJxWKfAbCxJFNllFH+w0I
         WLuw9ULhiR2Q/mOLRGCZNnXZvrhXZfnnnemUHqIDUoNUsbI0eNZO9XpoEEQtmZgEibn0
         G89rVB0dBOf2Plm2xleWQLzSe5fT0AhDJuet158knKYRxnJYv0peoBlitIrLOI8t46SA
         dcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4P3gHvc5tNHiLutQxXmqPUsDu4OAR/CSIKRXbAXRCg8=;
        b=IQcdWaYaH15dHPKiSWzXOOS3Q4Ihp57DLy9H1CPtj1Pvzl40JKToy+XwW0jeJiX6oJ
         PlCp7Nd/TpbOZoGGr021Mp1QXc9FXLWvsBF/TeRr3woo9ObCw9A0ihyhwLs+kiDA2xQK
         e3aRpN6gKljLJkUpcnBHhWqi7AAKX+KpMPxgs6cF5UnSHvJhIOWt7jPwKsrUhIL6cfAg
         pc7Ata2fkKcKn/8DeXBVemXHZye5vElCIC2DIUvJ1ldxovgTtkuYFDqUT+kPfF6csAS4
         QtlMtKiiN8y8MJdcxI6Zi3RaPrx6kZ+HWh8TAfD7X4jRvqEf2C4+KSw+oXspTOr4tshT
         JQ1Q==
X-Gm-Message-State: AOAM530OLV0riV2yK39bQN1vVFqkJtXU5xn9ERWd7G8grXc0UzXuOC2z
        q98rX0igQbddVvY8b52bU8XOosoz2Ciq3D1Exkb6mg==
X-Google-Smtp-Source: ABdhPJzCPrduDFpk5iRTQIMAjIlRIMt9d0P2XVws2qcctje4U20MMB67QB+13AoXn7EnBuqlgHm57tc/7K0frFF3I+M=
X-Received: by 2002:a17:90a:430a:: with SMTP id q10mr3648637pjg.45.1602685709199;
 Wed, 14 Oct 2020 07:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-3-smcallis@google.com>
 <xmqq362hkew3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq362hkew3.fsf@gitster.c.googlers.com>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 08:28:12 -0600
Message-ID: <CAM4o00e1-5RqKXEVHk9u8JJQNtcKx_tNBpbyD_6B_+Wuw_bD4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Masaya Suzuki <masayasuzuki@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 3:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sean McAllister <smcallis@google.com> writes:
>
> >  test_expect_success 'partial clone using HTTP with redirect' '
> > -     _NONCE=`gen_nonce` && export _NONCE &&
> > +     _NONCE=$(gen_nonce) &&
> >       curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
> >       curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
> >       curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
> >       partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
>
> It also bothers me somewhat that we waste 40 seconds waiting to
> complete this test, most of the time just sleeping.
>
> Now, do we still need gen_nonce in the test library, now there is
> only one or two tests, both in a single test script?
>
> Thanks.

In the last patch of the series I actually knocked these down to 1
second because the delay was obnoxious, I agree.  I'll update it so
that it's done in this patch and I'll move gen_nonce.
I'll be a little bit delayed with v3 since my workstation decided to
explode last night :(
