Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E94C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909E261166
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 15:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhJEP4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhJEP4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 11:56:16 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521E7C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 08:54:26 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 188so24343082vsv.0
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dLYv3IwuJTZBLxlii9Z3uYy+EKyYrJ+5TqkKtHHyUzU=;
        b=StGNQDQw5J+VdZmfD6djKQ49Dgdr72XA/Ni15dYqqa0CUWjETwPD9+Iw2zQDlqu9/j
         KLlrwAjivYQ99rs1zbC9PbUq7mk2GfwXz9LLv6ooSCnPAd86TXl7Zo8DIZwyy6kn4x20
         DHO80O1CyBgl5M7/zk2Q+WVOFi2+Vngv5QgBcjTPg6NcmcRaghLNKr0agzUQSvcp5ILu
         EVSsM2hQzZxcq7/u7Wx6eplsZXc9IFuWE/Vg3E39UyWElp2UYk+FNEhXS9NFHj6cffjW
         pPsKYJtLQ2Trn1TgPFJ6LzMbIihVozA847nrnx55zeyTOaVS5IOyRmEGQjnK6sghzof1
         jrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dLYv3IwuJTZBLxlii9Z3uYy+EKyYrJ+5TqkKtHHyUzU=;
        b=mn1KYeV4AakOi9wS7eGcBRl6aE/rXxWhph532/9v4BZEU0nxL2aJuDpRPH94xNJ34a
         8RGqzgDWdnaI2X8VfLwsceA/1JULpMr5cifr+ykypZNeCJKRoFoDeZ8D2mdFM6p+2N3j
         +0gXglFmqa8YPAjjdiLFRXaQBqN3tC/4aM7dxaDzFUkh8gqCSbgXRQ28iFBeI9+3ESDr
         i8P7CHnVGSMRkHHYFYxWJhlgrnKLSYlzKIY29S64YdmOxZNeFdy2T9bpng3AOxWSW10X
         iaJfEQIUBVItL3RiRC6IpSsDYySbdG7O7Axhn1wmC1ck3Fy1adT+7P5InMPUgy62Yxd+
         Ykuw==
X-Gm-Message-State: AOAM532K6VfItPaKIXFkjvMcywO7Uj3gDLBrUt4tKGR2AMUZ7pSCmGsz
        wOdoolm5Feo75BlC0ME65O6X6tY1Ukkm4IhJlKQoYA==
X-Google-Smtp-Source: ABdhPJz8f9N8onmBze2As0fbMkRrlmhi4aoUK8se1ncHW8bA5DODTSUXIwOa6WZ+ZGH36TaxSm8wMpUdMlrWLzfpRVE=
X-Received: by 2002:a05:6102:3666:: with SMTP id bg6mr19281036vsb.11.1633449265292;
 Tue, 05 Oct 2021 08:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com> <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 5 Oct 2021 17:54:14 +0200
Message-ID: <CAFQ2z_PAs3fG1h31KWVXJ=02t1i9UvWPuD4tCK-ZWfewkPQJEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Gets rid of "if reflog exists, append to it
 regardless of config settings"
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 3:37 PM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> <As discussed in
> CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=3Dfg@mail.gmail.com
>
> v3:
>
>  * fix show-branch
>  * add some more context to commit messages
>  * change calling convention for log_ref_setup; could fold into predecess=
or
>    if needed too.

Hi Junio,

I had the impression that I addressed all outstanding comments (but
not sure). Are you waiting for me to do something before this can go
into 'seen' ?

There is a merge conflict against master, so I'll send a v4 shortly.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
