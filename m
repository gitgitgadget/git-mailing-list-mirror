Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F0C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 00:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876A9223C7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 00:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcsSgBQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgKDAzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 19:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgKDAzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 19:55:48 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B2C040203
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 16:55:48 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id u202so4147642vkb.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AVFkNipwUkDdKh4MAIedRC6sNyQEafDStQXej5bQxr4=;
        b=TcsSgBQjtwoZi6YazEAXuaUWAxgKzdCG0BRDs29NwgDcYFdot5Au8fuGiQYnYDNqRn
         7vBiS3zYCLbfPK7RQ6sF1asO1UMAfD5sl7NIDDDwU2XyUwnyp3Sfr+vtm/BxvQjfHmUV
         OqpFhGllTS4kP1dXbhUbsgxIckq3ppNmbFT5C7bwlx10X3GyUqIHnbT2mBRz+Be8dXJF
         Z2wjVBw5eJ2M/FF9XtY/JRy5xjsQ+Wvoi2JONIUEwseRMoZyiAyko+n/Y7tX2ayzAwPx
         aGmU4IS5SwnoidKmaJtVXaHLbClLL079WW2nKWIqry5S+3QLxHr175IFdrkRLyXyb+v/
         Owyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AVFkNipwUkDdKh4MAIedRC6sNyQEafDStQXej5bQxr4=;
        b=CmcBchjHtxMYhNE0p+8U4pwWh2PyIdDcJv3xewwwyFCTk4ngxyjqpu3lj0ogpoaU9w
         0wd1pfXs4VphGekwLiaAfF5qaUcUhmyYDWWMFyK1GaUB3hgRNmR1mouJUO/P9zoUJQH0
         Viz/IqP1ARIhqUZSif96KC9Nur6BXf2PBe+18LcrsK9PnlRlHIrl0DWXc07T4p9eqe7V
         KxlR9YUEiKntD9Rlretgt2t9+bYAoR9ghYfffZO709RlLP4LIehe6L63h5Lu9awD0hh7
         s5e//f6m3Vp8ok+RIsFgn5X9PTo5L3c3Y1DLPYrAfNVpwTzGTWspwd002MA0RP7F8iwQ
         /9iw==
X-Gm-Message-State: AOAM531kiWXB4avcQ5pF11ixKbFcNWpFzNbt7GrJf5JmI6N2gVI/fnZH
        172iA6cppe0HAmSZjEu5yAs2BnQXVM733GBDC1SbE7lY+hM=
X-Google-Smtp-Source: ABdhPJzswC2uIrRG2hEGeSeNJ5SmyIGRyGSubZA/Tet9yGJ2QLgtfmfg14cG1Dza9vW2RP8bswze3U1/AWdsJtKtEyo=
X-Received: by 2002:a1f:bd58:: with SMTP id n85mr6512107vkf.0.1604451347201;
 Tue, 03 Nov 2020 16:55:47 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?TcOhcmlvIEd1aW1hcsOjZXM=?= 
        <mario.luis.guimaraes@gmail.com>
Date:   Wed, 4 Nov 2020 00:55:36 +0000
Message-ID: <CAF7CYk51BC0KcsBb0KjKWAj17AMU2c9Y6Y81ddwX6oOAFYhT8w@mail.gmail.com>
Subject: Bug with --abbrev option in git log?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git community,

please see next what I believe to be a bug with the  --abbrev option in git=
 log.
If this is not a bug, can someone explain why Git is giving this output?

Thanks
M=C3=A1rio Guimar=C3=A3es

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

In the Git repository run this command:

git log --raw -r -c --abbrev=3D6 --pretty=3Doneline -n1
a7144d4bc5ab58f306a1e5c73b27196fb999a63d

What did you expect to happen? (Expected behavior)

I was expecting to get this line in the output

::100644 100644 100644 639a41 111378 05ba1d MM Documentation/git-rebase.txt

What happened instead? (Actual behavior)

I got the following line instead

::100644 100644 100644 639a41 111378 05ba1d3 MM Documentation/git-rebase.tx=
t

What's different between what you expected and what actually happened?

Since `--abbrev` is set to 6 the expected hash is `05ba1d` not `05ba1d3`.

Anything else you want to add:

If --abbrev is set to N then the size of all hashes should be the
first N hex digits.

The problem with `--abbrev` is more evident with values below 7. Try with 1=
, 2,
3, 4, and 5, to see for yourself.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Mon Aug 31 22:12:52
PDT 2020; root:xnu-6153.141.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.21)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
