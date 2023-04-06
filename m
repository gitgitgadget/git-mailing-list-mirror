Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8997DC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjDFIwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDFIwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:52:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B7D4ED2
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:52:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-545e907790fso611179287b3.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680771173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2a3IJK83JDGlub+vAA9jV6XwHdaILC1+goD+lPWwUA=;
        b=j5oXIYCzwVUFlxoy59hB3MB2NSqjYW/EER5QfsC4s50rpHyxlUxzKqkHbueUkVL6Ss
         8twMWiN2OO+ff3+2DYGRCiQoefs5n43h6IzVxNqq8R/cOxivCHp8BYgYZgf0uod2VPpO
         UaNk/CIMZeiOt0IddRBwFTs+85wnFZQX05jDTPT0CkIzfZ+w+BNntYEo4pLXgrUGunkn
         aDbDQlZCX3LmA5HQOyGqM/c0UodO0xgf6HwaVqrEdO+0smkufbLx/UV8eeg99uT3QUOO
         Kjn9tayBEFbjzOMVnX6KlbQ6FofMQQE/hkWhXRxsQvrrZdjgMBT9EzxYHJsMo8UlNZ6+
         YOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680771173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2a3IJK83JDGlub+vAA9jV6XwHdaILC1+goD+lPWwUA=;
        b=qu2P6TWK1ki5gBTRUTXRkT4CtGwUym65LdZIpMGTkt0IAgbX17zoOdx0Ie6blsaQAt
         xTv3GMwrGbq4oyt7a6wqSHjRXWfO/DBWrMHQrx53xmsQY/oeedAJmmC+pr01GAlEoLzT
         SJzb0iXFPls7tGzxHHIULxIOdPQo8057HPQGLnSNp6Ij04L+UAsztcpypDas91NWn3gs
         N7ULhnUgARveLgnNFRusVxM5OkRrN0CKztPWk7OZTtJ6F9Xmd3G/1aDaoffWxdVa5+W7
         ldLc8FGU1nA6q3RCYs5jVSrZnaR1v8POyoZE3ArnBYkpKvYheITXT2uM9dW2D0VM8wwT
         tsJQ==
X-Gm-Message-State: AAQBX9d/lQYmgNX87uktjOyycbYM+WqR/4g/iuoeEae63h5jlwU7cXCt
        Y4HxMY+/ZNFYjHO6R0IA5K+KcjoYVwq9ySIZFkI=
X-Google-Smtp-Source: AKy350aIT0yDk2ReHlkO7v11buC33ZFBE5qtnpmLvNqlGqB5vmGFIHaoYEf9OvdhLbwN8jn+njQrz/LeZQUgxTpIKcY=
X-Received: by 2002:a81:b283:0:b0:549:2cc8:6e3e with SMTP id
 q125-20020a81b283000000b005492cc86e3emr5282437ywh.9.1680771172809; Thu, 06
 Apr 2023 01:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
 <CAMP44s15E0xJwXv8qGp8FqQvB_KaxS2TXenNZNH_VzvXpXv4Hw@mail.gmail.com>
 <owlyzg7mubui.fsf@fine.c.googlers.com> <CAMP44s128zFcMrK7URUK73ZmzETDRA5SNkWwoHgukZ9Q3f+5Qg@mail.gmail.com>
 <owlywn2qtj75.fsf@fine.c.googlers.com>
In-Reply-To: <owlywn2qtj75.fsf@fine.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 6 Apr 2023 03:52:41 -0500
Message-ID: <CAMP44s0_-DaXNMfvfQG8PUbKu9tbbdv4WCYuxY7y58Waoz=nkA@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: render literal *
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Emily Shaffer [ ]" <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 10:58=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > "We" probably don't want to change it, *I* do. Because in AsciiDoc
> > there's a difference between a listing block and a literal block, but
> > the Git documentation does a very poor job of being compatible with
> > AsciiDoc anyway.
>
> TIL. I'll be happy to apply the listing block -> literal block changes
> you suggested in a separate follow-up patch (probably looking at other
> docs we have as well, not just for MyFirstContribution.txt).
>
> > It doesn't even use the modern syntax.
>
> I am new to asciidoc; if you know any other examples of modernizations
> we can do, feel free to chime in. Thanks.

Unfortunately I cannot recommend you to do any modernizations, because
Git doesn't use modern AsciiDoc: it uses legacy asciiidoc.py.

If you still want to do some modernization, it would have to be
compatible with legacy asciidoc.py, so it would require testing in
both. I tried to explain the differences in [1], but that's not yet
accepted, so I don't know what a documentation writer is supposed to
do at this point.

There's too many considerations to think about before even attempting
to do `make doc`, so I don't know.

Cheers.

[1] https://lore.kernel.org/git/20230405125453.49674-2-felipe.contreras@gma=
il.com/

--=20
Felipe Contreras
