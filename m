Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A7C28CBC
	for <git@archiver.kernel.org>; Thu,  7 May 2020 02:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEFE20663
	for <git@archiver.kernel.org>; Thu,  7 May 2020 02:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWyc2+V6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEGCDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 22:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbgEGCDP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 22:03:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4951CC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 19:03:15 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id w11so4442870iov.8
        for <git@vger.kernel.org>; Wed, 06 May 2020 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gVETCUyJrBw2WOy9EL2LOJECrN/76ysXjGO89ZGNQPQ=;
        b=UWyc2+V6wOWQY1L9ELaeWv0qeR3cbj7qe/rn02/pm3JO7f70WUVE+bsSTAPknIJN5p
         Uh97zZ7j7//EZO3yNE404M7H4azcymLSq7ZrSWmyAV7LMEJ2bx5CWW8Rix/FVPNVXj9Z
         10Z3AOGWymB9QH3FHhBKt5oFQeu2zoYaJ7x2BfemXAjdJCARVh+fPX25bGhQDvcW6g6o
         iyA7JDDTE0FjYG98sfKVyst6KSIEsRrcpiTOXne2zMJ9IueJi7ESu+KpgJPZNCZuVJLq
         xrMGbf7f0kNYgiRAHoFpuLcz+nfCWbJ/j5c1JzOI0BmX4CyYNgRLrwhrdn+sVBN32k6q
         cqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=gVETCUyJrBw2WOy9EL2LOJECrN/76ysXjGO89ZGNQPQ=;
        b=b2zDsnetO+ENOmUbhfB/PoEx0DuzaZRx1qqG8IwCAuaWxrzWUf83SAOeQEd7o9is3m
         8xmN1Fbki90VfpQyhbsMCUGkRj4IGKLdGCZhCNd/TdHZadxhk4w2NLKTI4ZVtUdlrLb6
         TGl8+hoLaEYFEk/oFuIewIEONDA/bE6FHpzVZfcCHWpKR39uO7V37gnqBYfv1OmZVQ6J
         DwxvbZmMdbnT2n1XWTkdg8hLjc7ePSaMrz00elVatgtqI2AzJzaUGPIpouJhfirtRT+2
         CdJyVqr/ROb5Wp6TljQO9ZunnEwHCSdg5lm7eRPf74QeaDX8axUX92UdaYEwpeSicHTH
         kD5g==
X-Gm-Message-State: AGi0PuZzeL9hdM/0ViAaQ6mOsPfSVwPPgNnEBPQX0bQ6E/Sz03Sm8oxz
        BkCdF/oXtXezbCCVI8ly5P/aWFnnPB+Kbnh/Y6xv6Pq1
X-Google-Smtp-Source: APiQypKaUB1s16daMZY03sBDeV3mGHm0geTI64x4l0wzlsANiSuHQYb/9vcnG47dBAqx392O537jVSzFioQLZSVW/VU=
X-Received: by 2002:a5e:d918:: with SMTP id n24mr11467349iop.28.1588816994130;
 Wed, 06 May 2020 19:03:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 6 May 2020 22:03:01 -0400
Message-ID: <CAH8yC8nAsF7HT__AhsRk08wpa_Bjsc6RXoZuomVbM1CWeG8QeA@mail.gmail.com>
Subject: =?UTF-8?B?Y2htb2Q6IG1pc3Npbmcgb3BlcmFuZCBhZnRlciDigJhhK3J3eOKAmQ==?=
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Git 2.26.2 passes its self tests on OS X using libiconv-utf8mac.

It looks like one issue remains during make install:

        for p in $remote_curl_aliases; do \
                rm -f "$execdir/$p" && \
                test -n "" && \
                ln -s "git-remote-http" "$execdir/$p" || \
                { test -z "" && \
                  ln "$execdir/git-remote-http" "$execdir/$p" 2>/dev/null |=
| \
                  ln -s "git-remote-http" "$execdir/$p" 2>/dev/null || \
                  cp "$execdir/git-remote-http" "$execdir/$p" || exit; } \
        done && \
        ./check_bindir "z$bindir" "z$execdir" "$bindir/git-add"
usage:  chmod [-fhv] [-R [-H | -L | -P]] [-a | +a | =3Da  [i][# [ n]]]
mode|entry file ...
        chmod [-fhv] [-R [-H | -L | -P]] [-E | -C | -N | -i | -I] file ...

And on Ubuntu 18.04:

for p in $remote_curl_aliases; do \
        rm -f "$execdir/$p" && \
        test -n "" && \
        ln -s "git-remote-http" "$execdir/$p" || \
        { test -z "" && \
          ln "$execdir/git-remote-http" "$execdir/$p" 2>/dev/null || \
          ln -s "git-remote-http" "$execdir/$p" 2>/dev/null || \
          cp "$execdir/git-remote-http" "$execdir/$p" || exit; } \
done && \
./check_bindir "z$bindir" "z$execdir" "$bindir/git-add"
chmod: missing operand after =E2=80=98a+rwx=E2=80=99
Try 'chmod --help' for more information.

make install stops after the messages. I'm not sure if there is more
to install at this point.

Jeff
