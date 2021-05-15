Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE57C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 14:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A6D613C4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 14:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhEOOyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhEOOyU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 10:54:20 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B26AC061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 07:53:07 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r5so2283865ilb.2
        for <git@vger.kernel.org>; Sat, 15 May 2021 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FZztWu5DlJOcJ5el70Mohfj5E9b/eukMxYcWGCn9Wu4=;
        b=bJ8gQx6c2xgBY4Y/u/MZXlpwJU7CF3QQAkjj6Clqocxa2b8aDZF9H5OtYCrg8D8P70
         IildRTot1QzoVSUt6O/5FaD45GqLXOcH37EpOf0MOkWez43P4JNp3C0Q9eGdohcmOPZ3
         3z58aUXvv1sw+ke64AQo05gCKKFgUDbJiGN5oUD9Z6X6J6h+Rta4eFdduFEaA3Oye6Kn
         OBO+Hs6gKAHnLAobovx8oX5j6HXlIwirX5JtM0RXTh/JSgXlXcq9j664K/NM6KhwDR3+
         cPLlRpmU2B+DMnk2Aiy5qwpORWO87BzUChszJmy/Mq7qRDWgXGMnOUHriDKL1S3pVheH
         BSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FZztWu5DlJOcJ5el70Mohfj5E9b/eukMxYcWGCn9Wu4=;
        b=a1N4BngzmqbhIPW4GS14kETYA11RFp4KhQl3LiEk1qx6oOz7xcfIW9ohtNNlpBhwZ5
         hsaV+I8WShqt2J3YVDBR02fQYN30yFQrKlb9PP/hfHsXPCyIjPx5TNSgq7THGol7Y3qi
         Ke8BbQyRl6CqSrNk4PPGHH4cI2/R5iFwJw9iqU3+fltzUInDhGads2uXnS933afJad4r
         Yj3HDOsgbXW+T9IhVLOXSCmgu1TP0GIknimEkyNqP+LUiUU6SzGnZhseMUOFByARqMQK
         N2+KpKuUiU/hbyrA83qvujKm6sykbUR16TrJkJI/FZysYfzzeif4bDQIj0I9Buy2SiNB
         5VIg==
X-Gm-Message-State: AOAM532cdlnXP0JrSzEKYN97v4xpxLm+lK9bSkrvPJajg0gtr9NgUGgw
        0ctd+vjAoZ+G8MNvDPqgSSBYADAYuCvFbGNh8dux/ZEBMnAoVA==
X-Google-Smtp-Source: ABdhPJySGk819Vpj32Ff3cIDaqBKgQR9IYtvwerUv4TLd0HRqZ/CMWDACVF7AF0xseRZvuXZ4Ec1FnOmX7UlXz17aX0=
X-Received: by 2002:a92:340a:: with SMTP id b10mr45203963ila.301.1621090385552;
 Sat, 15 May 2021 07:53:05 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 15 May 2021 22:52:49 +0800
Message-ID: <CAOLTT8QBOgcz+Q_ODnbGq5r5CzrSdX+=DMT0pJS6iPTcP0VRjA@mail.gmail.com>
Subject: [QUESTION] ref-filter: how to support atom like %an
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My current thinking is this:

First add a new member `short_name` in `struct valid_atom`,
Then we can share a valid_atom item for the long name of
an atom such as `%(authoremail)` and the short name of
the atom `%ae` (%aE is not considered at the time).
Something like:

[ATOM_AUTHOREMAIL] = { "ae", "authoremail", SOURCE_OBJ, FIELD_STR,
person_email_atom_parser },

Then we need to do some work on atoms parsing:
In the original design of `parse_ref_filter_atom()`, it relied on
searching for `%(` and `)` to find an atom. Now we have to
change the way of finding atoms: Currently I just replace
`find_next()` to find a single `%`. If there is `(` after `%`,
we can keep the original long name atoms parsing method,
otherwise we are dealing with the short name atom,
we need to pass the interval between the current `%`
and the next single `%` to `parse_ref_filter_atom()`.
Then we are in `parse_ref_filter_atom()`, we need to
consider these situations:

1. %(authoremail:trim)
2. %(authoremail)
3. %ae
4. %ae:trim
5. %aeabc:trim
6. %ae:trimabcd...

As we can see, the situation is starting to get complicated.
The more critical point is as in case 6: We cannot determine
the end of a short name atom because it does not have an
explicit `)` end.
In this way, many of the `*_atom_parser` functions in
`ref-filter.c` will not work, because most of them use `strcmp()`
to check the attribute of an atom. If we want to support the
short name `%ae`, that would require a large-scale rewrite.

Any good ideas, friends?

--
ZheNing Hu
