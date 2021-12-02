Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0109EC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 16:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355401AbhLBQP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhLBQPY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 11:15:24 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F2C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 08:12:02 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id p37so56778514uae.8
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZDXteof7aviIbpzAYKhXFCgN2Ap3FMW0aU31q6dM1ok=;
        b=n6PwMTFKmY66psOp0VwRPJGktc87gKSADem7yD3yKPTFOJ/WF2ey5lYm/hdM2IA1gM
         eSWERIs174mkwhGVEgnri4v9edZQI3pNZjL2U+kD8NXY4CJU2nDRtzh6dIcxGXYDGV4t
         tXVd5P4iNJKfb8ruWPbvt9Z4R5PaIKMOKPBi+qHJa4fhQBhphuw2kW79rbCtq8oxQK0E
         TotDlty/x6Jz5i4NlMEGbkZ1YQZ83RM0tzg8lpGnRk1p/3k2eIp7tGPV5bmQpMKw+auL
         nDNjrSGYqDurKDU8IlFgfDpcPw+sgNcai6aQh18AX9lWayrs2rOlvTla7YY2kJcCAlXH
         s4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZDXteof7aviIbpzAYKhXFCgN2Ap3FMW0aU31q6dM1ok=;
        b=neTGPBEca+BS6BztAnSr43u2aYXwI3gHaErFnsuR/t5RKHNSxZ32RMtpVMQPFwAj0M
         1v/XSzFU2OdKSeTWnAFdLA4zI3SxYbk5otKWQ0ayuEi/sApvjPPg1I2jZq+h3wNM6V1G
         EP7XmYB+K7auWaOa4r32P4xuodOOU1LxEB4cq3rUa+MIjf7Q+TqyO1+MMhdnsUL8CbxO
         8EZ+OHAsKsolEp6wMt/6AJ0ZvNOlsG/taRsNaqPzgJWXL5p/Sj7d3ukcR3BhXZoIEhho
         dbRdqdrpJrNBD12pI7rYZfeHRy+O+RIEY8BCY2l+y3bOCo1w1AJj8Hicc9k5220Smq3s
         uP2w==
X-Gm-Message-State: AOAM531ReQ3VfPdynLLwu5GKieRYf3fRJK2cGSs4DtedloaD4JeUDLtI
        2yK0QN2SUfY0Hz/5x/6S5GxNVuEJdjokLlNnvfshOeFqhqM=
X-Google-Smtp-Source: ABdhPJxLbRz/ebdakL5j5/0Jl3Q2P8NcOv+jkrPVNY0kqpPs5Rzaq+ixBKjylA1tvo3LfCWXlOiXFu0gKRzBUtFDSnE=
X-Received: by 2002:ab0:3c9f:: with SMTP id a31mr16638430uax.134.1638461521284;
 Thu, 02 Dec 2021 08:12:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com> <211129.86czmjgtfd.gmgdl@evledraar.gmail.com>
 <CAFQ2z_OioNmOP+_VvP71DTDqkaVLZg01yx5QVNo+mVGXxsUJ9Q@mail.gmail.com> <211130.86r1ayedhn.gmgdl@evledraar.gmail.com>
In-Reply-To: <211130.86r1ayedhn.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 2 Dec 2021 17:11:49 +0100
Message-ID: <CAFQ2z_MwL2=c1DZV3jvUau35ArseqxkvjTQo0DjYhJobE_zxtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Inspect reflog data programmatically in more tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 12:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I was aiming more for the lack of premature optimization there,
> i.e. instead of byte-twiddling things by injecting \0s we could just
> have char */size_t offsets (as noted elsewhere), which would also nicely
> allow binary storage formats, if those formats happen to have an
> embedded string. Is that true of reftable?

reftable zlib compresses the reflog, so you can't mmap strings from the sto=
rage.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
