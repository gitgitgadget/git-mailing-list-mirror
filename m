Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B4C1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeKDA3K (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 20:29:10 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:38144 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeKDA3K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 20:29:10 -0400
Received: by mail-it1-f174.google.com with SMTP id k141-v6so5230504itk.3
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2el+E03N5NjDXpOpPi0X23TNDm/yrZctZR5VD6lQPhw=;
        b=B3Hf81wTd4k8QaNOUJvTHS/I4KCgx7/wNDuKb8YmdGrqRfV6o1YOTYeSG9Komlf1A2
         Wglzr2c/oBSLVAILAzV8qS24vDuKj3TRv4FDM8cNhwLtk28GIk2UqNf0eTN5Dt1m71jD
         FIZbUGCW492jNmYG/GLzuWj963LWKIHub2O/YUp4XSEH102ijcdFm+heX0VuCym0dTUV
         La5RPfRqTnDY1q3eH+fmftofNqNEameQnDGaDeL9B3+P2t0qNLKm01O5gGE2fHitmW2S
         PjpvY5IcI5/WK/46Mo8RIe7f/FYOcLmns2jIT2Ex0CV1ZoTsSgrgW9b64Zo82xDgixAj
         8j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2el+E03N5NjDXpOpPi0X23TNDm/yrZctZR5VD6lQPhw=;
        b=Tly5hfjT6m4UDyNgPk1O4fqyVGWq151w+qKnA9ViwcjNKkgEC02aIgczt3OlMOCLR3
         NW0HwLQPShUoY6xpky4O4g41VZOpHPa9RyXt/8wPPNk33Zd6YNtNcgWj8JPc5JriDYSr
         oGo01kTLFUcUFdRyUKQ/3uCo+PVlKCcOvNk2PopkIRM8Nab8IGbGITm58QsHYaQBU/hb
         xcNIglmPh37zhSzijI/XWsuhhL9fDcg+dYJtr5vF2CAxwjCKv5xk6Yef/QUarDvqWQmS
         JbRmfM/pyf3jSmKcGYdP7yKB+9AeCOjyC847GCIIXCXx0nwbPkoPDBDxlnQEsMLauGyf
         +vkg==
X-Gm-Message-State: AGRZ1gK0bef34boVHJw53vds1ANY5GJtEU+4XhPbQQGxc0G6Fh0xn8q8
        kKbnDUyMqcmIRogYV9bL3Qp2dNdTlHvdiHYqwXk=
X-Google-Smtp-Source: AJdET5cjAYW90KvapO0R/qE2tWEUP1wKWuN2ddHuwxSYLYDs/pOBRFVD2+awq1usKRdjAMPVZ8esNCbXlM6XjvEk0w0=
X-Received: by 2002:a24:fec3:: with SMTP id w186-v6mr799244ith.10.1541258253582;
 Sat, 03 Nov 2018 08:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181020193020.28517-1-mgorny@gentoo.org>
In-Reply-To: <20181020193020.28517-1-mgorny@gentoo.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Nov 2018 16:17:07 +0100
Message-ID: <CACsJy8DKD3F3o74gTHW-WEL_hpB8x+oaWX8_SwN01Nmz3W9Z_w@mail.gmail.com>
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple signatures
 on commits
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 9:31 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> =
wrote:
> +test_expect_success GPG 'detect fudged commit with double signature' '
> +       sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
> +       sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
> +               sed -e "s/^gpgsig//;s/^ //" | gpg --dearmor >double-sig1.=
sig &&
> +       gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
> +       cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combi=
ned.asc &&
> +       sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/gpgsig /;2,\$s/^=
/ /" \
> +               double-combined.asc > double-gpgsig &&
> +       sed -e "/committer/r double-gpgsig" double-base >double-commit &&
> +       git hash-object -w -t commit double-commit >double-commit.commit =
&&
> +       test_must_fail git verify-commit $(cat double-commit.commit) &&
> +       git show --pretty=3Dshort --show-signature $(cat double-commit.co=
mmit) >double-actual &&
> +       grep "BAD signature from" double-actual &&
> +       grep "Good signature from" double-actual
> +'

This test fails on 'master' today for me

gpg: WARNING: multiple signatures detected.  Only the first will be checked=
.
gpg: Signature made Sat Nov  3 15:13:28 2018 UTC
gpg:                using DSA key 13B6F51ECDDE430D
gpg:                issuer "committer@example.com"
gpg: BAD signature from "C O Mitter <committer@example.com>" [ultimate]
gpg: BAD signature from "C O Mitter <committer@example.com>" [ultimate]
not ok 16 - detect fudged commit with double signature

Perhaps my gpg is too old?

$ gpg --version
gpg (GnuPG) 2.1.15
libgcrypt 1.7.3
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.ht=
ml>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: /home/pclouds/.gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2
--=20
Duy
