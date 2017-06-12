Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65D120282
	for <e@80x24.org>; Mon, 12 Jun 2017 03:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdFLDNk (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 23:13:40 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33265 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdFLDNj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 23:13:39 -0400
Received: by mail-wr0-f181.google.com with SMTP id v104so81343655wrb.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zeJ1e+Cx8ANPlOggExUIAbx9gfMlcrwurSU6Wx7RzmM=;
        b=T8Rm0DGhWhNhvUm+50295b/WYiVB6dyUpZWSAo8ZzeV30Y28WafMfhpST/yYg3XMJW
         RSTnndya8Vem6tC6gVk6EKoc/xiUx3yATgmuVwz2fc9ZlNJR70yb6AMlmvZFV3IcXtw8
         NUggBofz24YMeIK9eg9AyaIPmoqfxcQZX4HLT9J7o4loRuc5x96df+alko764eW2LdKE
         9kZq2XbDLHZVJGEbT65bgiwe6TuzjPrDjnjsm7sbeQ6vBlQ0R2sZlm6YBPwI4ckE1qIO
         bsy8q7jaEz7/EEWrFkG6WQowabLTJOU5eOu534ukC4cfc0LwDmFKd4/KxDNprji9sy5H
         ZGMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zeJ1e+Cx8ANPlOggExUIAbx9gfMlcrwurSU6Wx7RzmM=;
        b=Z3BcFBcEIlHQjkQrqvv9qQagDq5FMDjJVoeUom2v/inrtXi2Ymaap9W3/tRAPE3xdJ
         Xd/iBEyqFaWSJfIvdjijacyOnLjkpl8OuGRrEKO9+ods1gOfQKCv8cR+c1BH8mXN77m3
         fOSr8Bj6ogT1ER8y0Fh/9rhVoR5iKeJZ3vKMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc:content-transfer-encoding;
        bh=zeJ1e+Cx8ANPlOggExUIAbx9gfMlcrwurSU6Wx7RzmM=;
        b=Mxn/LXg6xT2Y6y5/K/c7q3E67Ng2ZgN//08OfARBXXCQRdwBLtaHfMDULdJXOBIV8r
         Ixxn2cFr/iSvucaRpNosbEqVdSrAIT0tE54i5GMcCOU4Wo5xf+37GevFK6YxGCHYKYz5
         OanKJwjMM6RQLlAWsDCygzUFMWuphzc/VJDaWytHEAQqiCNrxj5nswCNc33wgaGxb1gd
         IEMDl/THg83dyeggt19Rg46h4TCFFPoh1ybet9mcsDSUsK0IrRHpcPzqnmeK0wxjau4i
         49Y35DkuvMGNfg6FMosSXAXOnRepoiYycGBsyLFN1h8bYpNanPeh4laZQm5RH9SOgJmp
         ZZnw==
X-Gm-Message-State: AKS2vOyEe5R5ap+ypc7WzmSN6LCob3TLhogYSzuYjP2lKKJk/bSuLAfm
        LvNldtwyDNK+wEon4jW139j3ESpJlXeMqi/AJQ==
X-Received: by 10.28.208.207 with SMTP id h198mr2748864wmg.40.1497237217516;
 Sun, 11 Jun 2017 20:13:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.151.22 with HTTP; Sun, 11 Jun 2017 20:13:16 -0700 (PDT)
From:   Michael Giuffrida <michaelpg@chromium.org>
Date:   Sun, 11 Jun 2017 20:13:16 -0700
X-Google-Sender-Auth: DByLxQRpxG6bMmLrJzvNFOeLntY
Message-ID: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
Subject: [BUG] add_again() off-by-one error in custom format
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a custom pretty format, using the '+' or ' ' combinators to prefix
a non-empty expansion with whitespace will erroneously truncate
subsequent expansions of the same type.

Normally '%+X' inserts a newline before <X>, IFF the expansion of X is
non-empty:

    $ git log -n 1 --pretty=3D'format:newline:%+an'
    newline:
    MyName

For the abbreviated commit hash placeholder ('h'), pretty.c uses
add_again() to cache the result of the expansion, and then uses that
result in future expansions. This causes problems when the expansion
includes whitespace:

    $ git log -n 1 --pretty=3D'format:newline:%+h%nno_newline:%h'
    newline:
    a0b1c2d
    no_newline:
    a0b1c2

The second expansion of the hash added an unwanted newline and removed
the final character. It seemingly used the cached expansion *starting
from the inserted newline*.

The expected output is:

    $ git log -n 1 --pretty=3D'format:newline:%+h%nno_newline:%h'
    newline:
    a0b1c2d
    no_newline:a0b1c2d


/CC Ren=C3=A9 from commit b9c62321 and Junio from 9fa708d
