Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1F0C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 12:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5F020708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 12:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3xIQHFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGMTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgGGMTg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 08:19:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7111FC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 05:19:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h19so49655852ljg.13
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GNOKmiKDy0f993Q2FyKkjw12hmCmFqWq+ow2y+AFt6k=;
        b=d3xIQHFvEeErYpU+TlpqLibu7SKl+GtSnzw0ylTpXlMJiSW1Xz3h+hjdZZbQtjQWxl
         gC40J1AKlq5sLrMmmOxbDSEJ2xaAVGC4N0uvS2verRJyhkSuxvcPXvJPRpIq5y4+WEW/
         zyOSDaX3kL4EiANMa+BHQZl4GdUG27+5CTj19J3fqQKuiwzAPTmJ2SMBqTiZM5hTLBSk
         Q+O2DNvBkkqrXWSarkvj8hHzjATrJ2O/fALF09Lat1/Aauesl0sZwuEE6iNjtCmoRnQ/
         lpgMn8D8VNVi3ztRc57jjqYlP6O5V4/bYkNG8JOgU8yPAgdDFxgQP11NayzwZTK3P4NX
         UV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GNOKmiKDy0f993Q2FyKkjw12hmCmFqWq+ow2y+AFt6k=;
        b=bBXNzLSzhi0eoNRS4DwtwftNf5jJWNwkgYsjXTXB7nuCnfMMgadrEx2ihINZRPrZAe
         g1wVcOCyuFaKEfG3Zv0uYSOwht+6f0V3enLbc4GY1pe4EWfkrexv5bCCxYEfazQWZD+p
         /53chTzF6JdT/177gVPPDOljrY6Ddio0TCGVuYcUDt6S+HU3BqJSVzBGIHPvA0IsB6Kw
         j8k5lWraRAag9RfYvgWVvqeMDAuTkB/hZo9Kc3WG8Pp9uNRf6sLa18E9cPRNyZetdLT5
         xTg38hXT0QSW4q2SsPrNUcLLRVnzDhBqaZoS5eIGaIxeIzLBHz5Em7yAArucPdXm3xM3
         0PNA==
X-Gm-Message-State: AOAM532SPD8FSwy+EsMOxG0XL9m+yrkGYXbTK7Xz4DaZ2VnJv7jy+5Ta
        YicvEV68mtiOYXBOnTlfw6N4PtTn67GpI2OJYmZXHT4qwcZsMA==
X-Google-Smtp-Source: ABdhPJyuPf4IF600BSxv82qO5zWYiTPLBOiahOyjxOxqhEAxQcSnRPiZ3W5AZ/RsDkgGZstKCxx48QmmZJe+N7cGW6o=
X-Received: by 2002:a2e:815a:: with SMTP id t26mr8902973ljg.182.1594124374641;
 Tue, 07 Jul 2020 05:19:34 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?576O57qxTWlzaGE=?= <mishanyo1001@gmail.com>
Date:   Tue, 7 Jul 2020 20:19:23 +0800
Message-ID: <CAMZHuz-Z2HGynUY0R5YDjkN1E12ZtD8h7OsZ9W6mawsxWQODgQ@mail.gmail.com>
Subject: Bug? of gitignore pattern matching
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In document of gitignore I found

An asterisk "*" matches anything except a slash.

This description well meets what if the asterisk is at the begging or
in the middle of the pattern.

```
~/Code/github/test on =EE=82=A0 master!  20:01:11
$ git check-ignore -v data/a/b/1

~/Code/github/test on =EE=82=A0 master!  20:01:18
$ git check-ignore -v data/a/b/2
.gitignore:2:data/**/2 data/a/b/2

~/Code/github/test on =EE=82=A0 master!  20:01:19
$ git check-ignore -v data/a/b/3
.gitignore:3:data/***/3 data/a/b/3

~/Code/github/test on =EE=82=A0 master!  20:01:20
$ cat .gitignore
data/*/1
data/**/2
data/***/3

~/Code/github/test on =EE=82=A0 master!  20:01:21
$ vim .gitignore

~/Code/github/test on =EE=82=A0 master!  20:01:46
$ git check-ignore -v a/b/3
.gitignore:3:***/3 a/b/3

~/Code/github/test on =EE=82=A0 master!  20:01:51
$ git check-ignore -v a/b/2
.gitignore:2:**/2 a/b/2

~/Code/github/test on =EE=82=A0 master!  20:01:53
$ git check-ignore -v a/b/1

~/Code/github/test on =EE=82=A0 master!  20:01:54
$ cat .gitignore
*/1
**/2
***/3

```

```
~/Code/github/test on =EE=82=A0 master!  20:00:13
$ git check-ignore -v data/1/a/b
.gitignore:1:data/1/* data/1/a/b

~/Code/github/test on =EE=82=A0 master!  20:00:22
$ git check-ignore -v data/2/a/b
.gitignore:2:data/2/** data/2/a/b

~/Code/github/test on =EE=82=A0 master!  20:00:25
$ git check-ignore -v data/3/a/b
.gitignore:3:data/3/*** data/3/a/b

~/Code/github/test on =EE=82=A0 master!  20:00:26
$ cat .gitignore
data/1/*
data/2/**
data/3/***
```

But if this asterisk is at the end of the ignore pattern. Seems that
"*" equals to "**"



-----


And there is another question

Other consecutive asterisks are considered regular asterisks and will
match according to the previous rules.

And it seems that triple asterisks act like double ones. What do
regular asterisks mean, I used to believe they work as a single
asterisk before testing.  Maybe there is some ambiguity?


Best,
Yanxiang Gao
