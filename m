Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF8FC7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 06:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjFBGue (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 02:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjFBGud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 02:50:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A01EB
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 23:50:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so2498780a12.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685688631; x=1688280631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUmRJ82FMzKUR9NxRFGFt+mNf7YCDvGjRrSj5JMemAA=;
        b=YIdysFFoxsEOByhjkqo+C4JJENJ5bCkqmzT4WUmS4edacx0ukRft4mvF4o5UWN0po+
         zEaJqhnp4xCAQe3sTK4Xno2zd9E4PwvN4f67TL9UMh1XTTFta4nNd2UYGoA64AkevIco
         x87HrjJc1wYPe8jIONvlfX35o4Hy3+ewyDmR3797SamtMMsoaEeiSAIlaMvRb6vJsfIW
         20hAiIFSgPgnM/sHLAPawuqpd/mLT/axJ7aDyVaOPq8s5c0RaIYFRISLEDfJLdCcvQDD
         MGtVGw0HU2sx6+J0xw2HOTs1CRWVpYgBFpsZGcCYKgNcSazIIAP22R/Qnli9qDfE7w/f
         o21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685688631; x=1688280631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUmRJ82FMzKUR9NxRFGFt+mNf7YCDvGjRrSj5JMemAA=;
        b=N/v3YDj4GPVqFMnpBF+eYpYqhWcEgAiop1qDddrnQucNM4uuuy2L79mUU7XrZgeZID
         nla/pM5JHK7IRmndXcxZxFKUK//2rMB5IjFl23qcgkR3/5UlpDBjfFi88Yl6WbsEb4zf
         2KV6UEE27j9sSSFWp7M7yxXqLNQn2pEwpWXw7vxVC0hV+/fbsZYxxT2P+q5gj4kFRpI9
         J+MKZ4v+j7OWpWzosiDVe4forzRE/Qp7HVWxeH8hrJIEK4kTq68RRh9eozcZipZmhNsy
         pyXNKm3BjZxrqLqq4HHBrKDHwVweDnqMG+Z6MY1dFa1j/Ksdc/ypZ6YkWk2qcmRhGPAs
         JAZQ==
X-Gm-Message-State: AC+VfDwFZJaepZIC9sbAJv46J7dwKs+R/xJprnk+1LlYR1fepuApcZTD
        Zu9KMM4Rz7tm9XrEu1jfA4uDwJFDKmqQO9nuVBg=
X-Google-Smtp-Source: ACHHUZ5L5NRoGC6riHhON2wMgZZE40ZHg9VBeYGVy2u3lSD9GPdTXF/P9QTxR1zY/OFWbrnSqaIyFgDinBZhtlJ7n64=
X-Received: by 2002:a05:6402:31e7:b0:514:a57c:b4ac with SMTP id
 dy7-20020a05640231e700b00514a57cb4acmr1404355edb.7.1685688630559; Thu, 01 Jun
 2023 23:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230529192209.17747-1-five231003@gmail.com> <20230602023105.17979-1-five231003@gmail.com>
 <20230602023105.17979-2-five231003@gmail.com>
In-Reply-To: <20230602023105.17979-2-five231003@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Jun 2023 08:50:18 +0200
Message-ID: <CAP8UFD2wcnNaihGv=SQ_77OLQ5PN3DG73rnh2F_C_j+BFTcCyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t/lib-gpg: introduce new prereq GPG2
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2023 at 4:31=E2=80=AFAM Kousik Sanagavarapu <five231003@gmai=
l.com> wrote:

> +test_lazy_prereq GPG2 '
> +       gpg_version=3D$(gpg --version 2>&1)
> +       test $? !=3D 127 || exit 1
> +
> +       case "$gpg_version" in
> +       "gpg (GnuPG) 0."* | "gpg (GnuPG) 1.*")

s/"gpg (GnuPG) 1.*"/"gpg (GnuPG) 1."*/

I am not sure if it changes anything, but for testing if we have v0
here and v1.0.6 in the "test_lazy_prereq PGP", we put the '*'
character outside the double quoted string.

> +               say "This test requires a GPG version >=3D v2.0.0"
> +               exit 1
> +               ;;
> +       *)
> +               (gpgconf --kill all || : ) &&
> +               gpg --homedir "${GNUPGHOME}" --import \
> +                       "$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
> +               gpg --homedir "${GNUPGHOME}" --import-ownertrust \
> +                       "$TEST_DIRECTORY"/lib-gpg/ownertrust &&
> +               gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null \
> +                       --sign -u committer@example.com
> +               ;;
> +       esac
> +'
