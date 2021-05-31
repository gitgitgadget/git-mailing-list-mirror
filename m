Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39454C47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D85861364
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhEaOoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhEaOmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 10:42:07 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A18EC061247
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:54:33 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id x1so6639366uau.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZBySRu1+CzwybVx8KiR0vAHkvkPkf6QOo8Yqwt8fqwU=;
        b=UbyDolBFywT9KFCvHAQ1xVEYZo4tZZn159CL85SdEmGPLY5UuHH1URMtMsF0ol1g07
         dW0w8Z2Q0wDi4ke2HjmwMHKfPFYyW7kycQT2zU6mLhbGKLFikJWhd/L4AW35/i+Pxcm9
         37naD7SUubu74IabuerBpxsVnBCK18VMpYdz/QtxViS2+YAJyabyYW0hmdOK8OYCbW6g
         i2gP00YRnvpTlU6LfymRt2Z6zqdDjfS912KzBvEkzC4mox8I0W2wsEkm87/V+Ky1FJgo
         GmyXmFVtexZcNEpzW2EXaldWVD79uVt5WYlpQvFt361m3Sx+Bxf4DCCRYmlrCMg1UnVM
         FVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZBySRu1+CzwybVx8KiR0vAHkvkPkf6QOo8Yqwt8fqwU=;
        b=ti0kif6xzf/zkj2PvCbu5tZovWl0L6H+3dUXrUv9hmCKtLQQhQeqpHyDb5qQelDPLd
         9VNLM0jMsMl1v0g0nv2qohI1TSydOLgBymzVzhYoJqxJxC7zmrubikEPWSEbYxniyxUa
         /nI459UHcks2FHkY8ySz+c/6FPbal+u7Kpeyeb3UZ9zWpWOCq6S5NzFJu/aVIta7hkmq
         F+XccGdEpjlbMZOVt3CViwA/HY0U8eqhrVGR+h3d5SgCBcTdlck5+8bJUIbtzSSFLG3y
         8eTB0Yy7yH0CUanc6QpgMHoZsonkVvqXteJ018QLSUMp+4AQLAxbao2EIPEhKBnr1blM
         CyKw==
X-Gm-Message-State: AOAM531Ll8JvaRXK9XET0uyfCgECQVqaZnmzCzWK8EF6l6MedPSuRkNN
        BrAt4UzclOmkammani46Qzu5jQi/spWRH1KAjyZITg==
X-Google-Smtp-Source: ABdhPJxtXpOPTgf8Jj4zTf1XNJPn23Dep9QUdMNI8jA53u6wkgqz71QOsrrdchZTmsus4k7DXS3m0paWv2vZLCkl9tQ=
X-Received: by 2002:a1f:36c1:: with SMTP id d184mr12880175vka.19.1622469272555;
 Mon, 31 May 2021 06:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <8ad4a35cda706b1bfcd8ddcf1b1c2e1d8f692c70.1619519903.git.gitgitgadget@gmail.com>
 <87a6opqwc9.fsf@evledraar.gmail.com>
In-Reply-To: <87a6opqwc9.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 15:54:21 +0200
Message-ID: <CAFQ2z_Prqp3f4rXTrijB7z6xFYA7y-M4yRzZ46ARCSzRNkATpw@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] t4202: split testcase for invalid HEAD symref
 and HEAD hash
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> When splitting up tests like:
>
>     git init xyz &&
>     [do with xyz]
>
> Let's do:
>
>     # test 1
>     test_when_finished "rm -rf xyz" &&

Done.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
