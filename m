Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D3DC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C372A2076A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EC20bRY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZAhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:37:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45413 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgCZAhc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 20:37:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id t17so3900539qtn.12
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S9IZclsWLZMnGEUrKs4qZMTW9nfvF7wjMauw+lOnH+s=;
        b=EC20bRY+9emYsFyXMvjqnBYrTR2RSdWrce1CA5FDUT5A/78FWwukVdzFnQsOEIjVdO
         cdvoosLyR+bWIa7BiX6avq4Cfv6biKh6u1TH0ARYr36gSNPZyPEXi9G5nSE2sY0msNVD
         cr/1WazstLX4W9bhJviDirfzG3WVHLs0zpSZHgvQ3vr00WNgRUo31WlE+Kfz964Bo6K3
         B0z/6gtm6YAaeFHMYdhfyHpcOnwbl1dWQf/0yrriXwQuFGcARP94OP2PsFk7NhoNxgc2
         QMIY7He2UxcZ92aLV1io1ieUF3Ej7YHdr2ptVZKuaZTPHuzh0o4yNyGP2oex+6M2PDmh
         MSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S9IZclsWLZMnGEUrKs4qZMTW9nfvF7wjMauw+lOnH+s=;
        b=Yv8FS57QOUvDB0481127Hf+pc7fSx+Acnv+ETXMoaIKsANTZC9i0VczpwzWlx1wNec
         8OQFOivN8Ipi1jMdYQmZvz979g6V20Bk3p/qEu/XyfMH+2U8TYnIAeh/snHuj0VxiX+B
         QQnERI0CTyKVBj+zdTm16T8AZE4W3Wz/4ROuX6vmu6KvD0v6UnMeO3dcM2XpKNOOXFjW
         tBGXXVi8Ahgm9hice0E9l+3M31URsq0BZ8XO4IjCZv8Rk33JdgEpZVKxQIqZOusatkfZ
         nib1n5m5kltYqCx0keHOFLqCMkJbtadcdkP7Emf6vzv5x31z+UmDY9BKiM8XbqOWXEwf
         Ue5g==
X-Gm-Message-State: ANhLgQ1upaPImCtXRJ2g04bRFTcJA2qfoHzBEHtfa4+IZ06/hfKVvvcx
        Lv8GmaOM2gedpQkhOeUnXN2xYN6nUm0=
X-Google-Smtp-Source: ADFU+vs1VgKIanoeleFKEgs1GJv+NqzdPyfuxhqZBm1JyQ0rQBwbfy5jT/0yT2/QFd2aOmCJsNi6Hw==
X-Received: by 2002:aed:25a7:: with SMTP id x36mr5606586qtc.203.1585183051464;
        Wed, 25 Mar 2020 17:37:31 -0700 (PDT)
Received: from [192.168.2.21] ([142.118.142.146])
        by smtp.googlemail.com with ESMTPSA id w132sm356308qkb.96.2020.03.25.17.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 17:37:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Git doesn't support symlinks
From:   Daniel Malendez <dmalendez@googlemail.com>
In-Reply-To: <D3B355BB-BB09-4AA7-8D8A-58B61529D617@googlemail.com>
Date:   Wed, 25 Mar 2020 20:37:30 -0400
Cc:     Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9453040-2E7D-4CAB-AA7F-0C6C04E2FC99@googlemail.com>
References: <CA8EDABA-A41C-4177-A149-51DCD07C319C@googlemail.com>
 <CAGyf7-FF0aEEiRGjZ_+RuyYnSV5cYn+-Hp5q7dZRADj_VL034g@mail.gmail.com>
 <D3B355BB-BB09-4AA7-8D8A-58B61529D617@googlemail.com>
To:     Bryan Turner <bturner@atlassian.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your feedback!

> On Mar 25, 2020, at 8:23 PM, Bryan Turner <bturner@atlassian.com> =
wrote:
>=20
> This didn't add the same thing. What does a "git status" show at this
> point? I'd expect it would show "Versions/Current/Headers/interior.h"
> as added to the index, not "Headers/interior.h".

$ git add .
$ git status
Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   Foo.framework/Headers
	new file:   Foo.framework/Versions/A/Headers/Interior.h

> It doesn't necessarily seem like a bug, to me; more like a case where
> Git could potentially be "smarter" to try and determine that, while
> "Headers/interior.h" is beyond a symlink, the target of that symlink
> is still in the repository. (Versions/Current _is_ in the same
> repository, right?)

Agree, makes sense!

I think what happens here is that `git add .` adds the =
Foo.framework/Headers directory first, to circumvent this check failing =
here?
https://github.com/git/git/blob/master/pathspec.c#L596
Whereas a single =E2=80=9Cgit add path/to/file=E2=80=9D would fail here=
