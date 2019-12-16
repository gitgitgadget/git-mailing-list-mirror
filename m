Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397ABC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED120684
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5BLexIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfLPNUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:20:15 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:43928 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfLPNUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 08:20:14 -0500
Received: by mail-io1-f42.google.com with SMTP id s2so6825120iog.10
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 05:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lvRYPiLVz4J7EUs7nhUHwncMO0UM7i2kL5wTQoVLylc=;
        b=O5BLexIUZ117TdF//Ni0tonNfD7/CVKkN8qkLEn+D5oLBrciXTtOoeYW9J9YU8Iogj
         7Zc7GY6JlSkbEt2s0Qr4ITSGWQIB6oYrDb5C5+LQH4Uo72y1267Z3HDilVpiv8xFLXh0
         9GYQ3/WqjMbulfin4JP2j2cnkMA1bEN+dNnqbgXzz3aTY/BOaJQ3dGRmRF9XxTztTtke
         n93h++ATHMoqas4WYh3f8+sAkDqeTXVnWFT6YQDf64E1Nfbh0Uenq7KVT2ri7jSvj/ol
         1O6nnfaTxJzHoDF9U8Lh8ZhEVKniBwqmYP+X9VbhoBY+/uZpXUwSgP+oePlI7Norihjv
         V/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lvRYPiLVz4J7EUs7nhUHwncMO0UM7i2kL5wTQoVLylc=;
        b=R1ZrXvmVyn9xxWhV8J1zkMmlOtlS6QeKG/bdHXJgB1F1dQ518d8aaLiDDQ2fn3T9fZ
         jqmdfBMUUHRcS8IB/6r08ildDXbqdjenVCec2FaSNWi+CGAZ/ldlfyMpXydL66vRuhDY
         QaSrZ8ZFa2PRdvbD9xMEvF2+gC1TSLQOUW4HPr+VNUXlx/I5ukcb8B5od1s3FQ7AdQNX
         Y7SBQAWtyo0aEcV0zpofuAdtzFVlM+cwVLZbCtIYKQYRvODG21vcAMr/8qXEfQVmHVTl
         JUvNwctniZjqf/05z0z9wFn3Ii/C3qExlwUq07d8XopVRO2SvtwRaUo1YqXIj5Rx2Wwd
         U+nA==
X-Gm-Message-State: APjAAAVY426NUwgeg0Vg93vhnCNEYT1Iab7mu98mYW3TxhKkSljb8Bvm
        JcXMdTmh6kKXuDveQ5vTYy2sr7hrzxqC7fdlo36aL8RV
X-Google-Smtp-Source: APXvYqxWHhhCbk4VsDzaCQJ51uRuy1ZDydTJdc8aEyt12NByDGxY0MFKy7+JPWZaHClvuZe1ElvEFz8dtMZTinuwzH4=
X-Received: by 2002:a5d:8e0c:: with SMTP id e12mr16441549iod.253.1576502413937;
 Mon, 16 Dec 2019 05:20:13 -0800 (PST)
MIME-Version: 1.0
References: <CA+0NiBEFssPJsQ8UV6vRNBxzUEsJddF4Q-=-xVq-xgNUtFbHUA@mail.gmail.com>
 <CA+0NiBGcYwu1Gyyv3AQEbfQCMiE0rrurzgkQzwsjHgi9cEj4wQ@mail.gmail.com> <CA+0NiBFU46YRBFEbngK+Rc0e4uE_nSqQkYak9a-_UoTaCCb1Jg@mail.gmail.com>
In-Reply-To: <CA+0NiBFU46YRBFEbngK+Rc0e4uE_nSqQkYak9a-_UoTaCCb1Jg@mail.gmail.com>
From:   Marce Romagnoli <marce.romagnoli@gmail.com>
Date:   Mon, 16 Dec 2019 14:19:38 +0100
Message-ID: <CA+0NiBEifgam1xVJw7F=mO_DtLgfqK9g7eHJMK5dt3yc1JpaAQ@mail.gmail.com>
Subject: Fwd: `git stash pop -q` is deleting files.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list,
this is my first time reporting (what I think is) a bug in git.

WHAT
`git stash pop -q` untracks stashed files and others.

WHICH VERSION
v2.24.1

HOW-TO REPRODUCE
- Create an empty repository
- Create 2 files, track them and commit.
- Change one of the files
- `git stash`
- `git stash pop -q`
-- Expected: The touched file is back in the index
-- Returned: All the files are no longer tracked.

We use this command on a pre-commit hook and we were scared for the
first time we realized all our files were deleted, anyway, it was easy
to go back.

Thanks for your time in advance.

Best,



Marcelo Romagnoli
