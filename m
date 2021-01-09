Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A62C433E6
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C11723A31
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 15:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAIPKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbhAIPKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 10:10:30 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEFFC061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 07:09:50 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u203so12416090ybb.2
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9iU5612tQ5/tYjMFx7gz0ETFLet39avz0W9agvoEwnE=;
        b=uywTE1Dhb0rpZMxg3IqdguBTKbKPdd0caajdD3YZKQ9pRBZiP4ORvdmcJFQ4o8lfHM
         CIjZbh/mcPemhGgSiHzqjc8sBevFkbw+OPAwGCF6RycTaoRyWAffV633ilPR89kZDRV4
         mG4WAg0+mBla87fNt6TLVx7jyKkUL3UFWYCF81SCQR9IFJunAvfPdIG7Q8Z1KxQjuXTX
         Gq36kOOnIZKbGr4nhBhKIy1Nwap9vBGEEHv41UVB08uAIGqLSqV6BmjKi/GjpCs0rLYp
         i0SB0aW+ND9JME4fcNMoD1y0Vph1JZdIsxk2+9KDZbSwn1eekp+IEpH+93hkvYiA1QEQ
         l8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9iU5612tQ5/tYjMFx7gz0ETFLet39avz0W9agvoEwnE=;
        b=ZEI23+Ka6YhdVbb59eT52wNTxrbVws9w8LyUCXXIr1aGhWMtEM7mfVnzMJdbxwxhrP
         IlU84pUXxQSIA89ITweKlEYe1RWNnpas61x5fSt9blBFyy8OPFDAQGGxrXanjmkHhPU3
         mbRy2qxo7Ipooqz61nnleJiPgI5zunwG1DEYWIrnmjYckUYbvULQpYj5YPDkZ4xce67n
         UBaZgGFzfEL7RnEl+VBh1cBK+1Z8S9QtV0dukeQ6Ozq1+9G9uC06sPx30eFxnwJWZTHb
         f/Amozkrg8Tk8EAoZZoZEr/oChfNYaQXBTadKLPOWrDHL5bMdLXsnHm68LAkwzfg8xGM
         sbMQ==
X-Gm-Message-State: AOAM532eJOSPtaYqSKJSIB2G7C9ZU8QYdaff/JE1pIUvmdLXFaIe5Kn7
        4vlzRc+VIZ5lcBWUhVXPnFw1T/BwidUH4GwuPhw=
X-Google-Smtp-Source: ABdhPJyBs4RWvV1P3dfwwqc+IpDAWxWcnLl5yhdrCze9JG2lpJmX59oRTUM+1l1Ra33OaKMdeXbvdFf2tz6WyXBderA=
X-Received: by 2002:a25:3ac3:: with SMTP id h186mr11929086yba.155.1610204989855;
 Sat, 09 Jan 2021 07:09:49 -0800 (PST)
MIME-Version: 1.0
References: <X/cqrTgilKAW9P9G@danh.dev> <20210108144514.24805-2-worldhello.net@gmail.com>
 <xmqqv9c6g8r4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9c6g8r4.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 9 Jan 2021 23:09:38 +0800
Message-ID: <CANYiYbGR0ByQ4p9oqPvZCq=GFRpbFsHZETz-UwGc_amf1QmXYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] bundle: lost objects when removing duplicate pendings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:11=E5=86=99=E9=81=93=EF=BC=9A
> > +# Display the pack data contained in the bundle file, bypassing the
> > +# header that contains the signature, prerequisites and references.
> > +convert_bundle_to_pack () {
> > +     while read x && test -n "$x"
> > +     do
> > +             :;
> > +     done
> > +     cat
> > +}
>
> This looks somewhat familiar.  Perhaps extract out necessary helpers
> including this one into t/test-bundle-lib or something similar in a
> preparatory step before this patch?

Will add a new helper "t/test-bundle-functions.sh". But as how to
include this helper, there are several solutions, which is better?

1. For those scripts which use  these shared functions include this helper =
like:

        . ./test-lib.sh
        # current directory changed, so add path prefix
        .  "$TEST_DIRECTORY"/test-bundle-functions.sh

2. Include "test-bundle-functions.sh" in "test-lib.sh" like this:

        . "$TEST_DIRECTORY/test-lib-functions.sh"
        . "$TEST_DIRECTORY/test-bundle-functions.sh"

3. Create a "t/test-lib.d/" directory, add add
=E2=80=9Ctest-bundle-functions.sh=E2=80=9D inside "t/test-lib.d/" as an ext=
ension,
just like chriscool introduced in sharness project.

----8<-----
 # test_perf subshells can have them too
 . "$TEST_DIRECTORY/test-lib-functions.sh"

+if test -d "$TEST_DIRECTORY/test-lib.d"
+then
+       for file in "$TEST_DIRECTORY/test-lib.d/"*.sh
+       do
+               # Ensure glob was not an empty match:
+               test -e "${file}" || break
+
+               if test -n "$debug"
+               then
+                       echo >&5 "test-lib: loading extensions from ${file}=
"
+               fi
+               . "${file}"
+               if test $? !=3D 0
+               then
+                       echo >&5 "test-lib: Error loading ${file}. Aborting=
."
+                       exit 1
+               fi
+       done
+fi
+
----->8-----
