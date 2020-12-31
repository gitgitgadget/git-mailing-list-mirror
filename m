Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F6C433E6
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5C223E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 13:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgLaNgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 08:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaNgy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 08:36:54 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62157C061575
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 05:36:14 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id j140so10011911vsd.4
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gp73LU8xBsP/2NsZ0LLcNV1N3UetVYkh8OpN0mndo98=;
        b=W1ZMxRcrpOt8evjNuMefhwDya18IjYu1ZVYDGM+YiK9FT6t4JJZ7H201bNEotn6TqV
         lRr3YM+l+go++L+ASVjT85dw+uUS5CKYtKwsAeuRftzlMOPlBXxoJZLfmlLVbfcVQk9s
         QG54mS62yVobk0c2+xhUy33e7SPgFbc/cGKSN05UbbowxserYSvomqZNBrD3R562sMPg
         0YE3DNMNuYEgb7TnnxrVAAD7II5On/B56iqOb9VdBMDjsYes/r9fDjkecQgzIqQx17GB
         7tgSPoucxdW8Zts554k2q4uIPJj00Jt0Yja9gab32/aNc02VlIKcFafzxrTo/DIGtt+V
         NUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gp73LU8xBsP/2NsZ0LLcNV1N3UetVYkh8OpN0mndo98=;
        b=kizj86r+qEagFWHDk7k4oTxCpawUWpshZq2tReqx+T0o2i2Cf88K7XhhQI47Hqxmdc
         XgMMuEsrLL8keUxyfsbqCLev4ZiaBmJc9GK6NzQIyHja4QJ4KE1/Pv6s3XzR6YW+78pY
         Dd9l9yeGsU+3HIkZuBwwX7kB8d10oVoArtsVV/qs+Bm4Xf9VQttCLQ25uZ3NH8FBUk3j
         nTkY8thzFYkGvpPlJLx8+1WqxbFBJxAGq5WrCt1uD/DNS7ry2hMmsdyOxw4eCOs5mj6U
         W7M/CTjFxTZ+L20ei4NzEKIkKhMyePhG7RCDj4LHXgdw6WDA71BgBB3FkwlXdIAz3Ljv
         v9JQ==
X-Gm-Message-State: AOAM530PEcicj45ID9wO8r2dD9AdadhLBpJLXCwvFbxke87BWG6ZU74D
        a/8H0XhTqsBL6MAdJcMXln2vUUyL+Y5lCD5XFDs=
X-Google-Smtp-Source: ABdhPJyFyAamGmBtCfuD75eeEpVD81PnNJ5D30BClapp7ryv4RAdFsxRHMXt7M3W99q+O6b0ccB77OZCmCfmR7Y3FFM=
X-Received: by 2002:a67:8011:: with SMTP id b17mr38013036vsd.2.1609421773629;
 Thu, 31 Dec 2020 05:36:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609282997.git.martin.agren@gmail.com> <cover.1609415114.git.martin.agren@gmail.com>
 <0223aa36-7071-a37c-a188-c45a43d76b4f@gmail.com>
In-Reply-To: <0223aa36-7071-a37c-a188-c45a43d76b4f@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 31 Dec 2020 14:36:01 +0100
Message-ID: <CAN0heSrRpfP5XLHAvAkFnoydudwNJU4tGZr88DNwd9VAekrugg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rename "sha1-foo" files
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 31 Dec 2020 at 13:48, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/31/2020 6:56 AM, Martin =C3=85gren wrote:
> > "SHA-1" (capital letters). So this v2 is a bit bigger than v1, but not
> > by too much, I think. The range-diff is below.
>
> Makes sense. Thanks for being diligent!

> This range-diff looks sensible. I approve v2.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, Stolee!

Martin
