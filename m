Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074FFC761AF
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 07:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjC3HrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjC3HrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 03:47:23 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EFFFA
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 00:47:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z83so22429488ybb.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680162441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO8onz6+6OOoTlgVAQUo3DPsH1/75Tg5Er86SZsOC40=;
        b=kHCu+gW7xl/XQufyCl5w0MKqjL9Y4MAzvEUXicnUd0JLlGpfUsUfGx7T9aMbUMxfhr
         G5XlJzkxdsBnxzYgL8jqR3NkAn+ZeBlosGeZtrSb/TpQ95J9ZGuKauUq4J9nW8jRkBc9
         6yP0TNLJZIJl1ZsZEg1kWjwTffXa3uyYTY7oQvp1/Uyp8xzUm1JNn7a8l7ZdeUvvR5vJ
         hAf+vJXLUzaxA7EFwZFWw6h2A8PLc8X/XMFqyJ5uK9ZmTIHPt4FsqCoDAQE93/cFdLzk
         1K8IsKmfNZ/+x8DJC7DIEmOuYnJ3Mc1Txb6zh+L66vye62AT28Lz/YWs43bXkPyW5Obo
         16Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO8onz6+6OOoTlgVAQUo3DPsH1/75Tg5Er86SZsOC40=;
        b=ZpMtAhQOb4CI+nlJkDMZVgVdMZIMo3HuWAlW4/zyuI1kPft4dFeKwq9CREbNpdr+ZY
         H/jKX+7iBqlUagWD5KXljtYL7r+qcCs6bkT+8kji54VYc2rofvFsoDOQoioFwK2NFmmC
         4rcR4exTOl+fWquqGFK1W5WMK0uniKYhYidcHG5H7l/OXyfoLGtP4tz9kywgCU2X0/hF
         p43QcE6xGzEx2gsUD71pvtxACMQafiZIHtYGGVVP98yYsUeoKmLIKAndVINqhgaH28x+
         C6mDh/tuEbqKmHqsuexW8G04MrrbQUEF0Pl4dhHwD/EjNL1bymnIJ2+GPNoxvVYn6w6y
         FTLA==
X-Gm-Message-State: AAQBX9f5mJ8jkb2YxB8W9V5FXVTPPXVKBy1N57R78wfbyWyDM4ZE0J1w
        /um3nF1NQWeCBJzI5M4ImBfRfijO8eCuOTapOFajA8HMBx4=
X-Google-Smtp-Source: AKy350ble3ublWGnWrqBCWasEj535KYf5eFMCiUsb3D/qVNR7X4oXggrY6eFcfD6PssdWiadiJ+zmoj+RZuZgJ8VVU4=
X-Received: by 2002:a25:7403:0:b0:b7e:6118:348 with SMTP id
 p3-20020a257403000000b00b7e61180348mr3116528ybc.0.1680162441230; Thu, 30 Mar
 2023 00:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <xmqqh6u3d119.fsf@gitster.g>
 <ZCS4SXlkqnvjxidA@tapette.crustytoothpaste.net> <xmqqjzyz3p5n.fsf@gitster.g>
In-Reply-To: <xmqqjzyz3p5n.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 30 Mar 2023 01:47:09 -0600
Message-ID: <CAMP44s1Amx4raO2rzTHxCgfEXywZwPCJwJ8edzJO_+_pY8PAkg@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 9:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> If the native mode didn't impose too much burden on our developers'
> to maintain, it would have been nicer, but judging from the contents
> of these patches, I am afraid that it falls on the other side of the
> line.

There is zero burden to maintain.

What burden did this fix specific for ksh93 cause to "our developers"
0e418e568f (t0005: work around strange $? in ksh when program
terminated by a signal, 2010-07-09)?

--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -13,6 +13,7 @@ test_expect_success 'sigchain works' '
        test-sigchain >actual
        case "$?" in
        143) true ;; # POSIX w/ SIGTERM=3D15
+       271) true ;; # ksh w/ SIGTERM=3D15
          3) true ;; # Windows
          *) false ;;
        esac &&

This patch was applied once and forgotten about for 6 six years until
one developer refactored the code in 9b67c9942e (tests: factor
portable signal check out of t0005, 2016-06-30).

"Our developers" did not have to care about code that affected only
one shell. Not since 2010, not since 2016, not even today.

Even the original author admitted he didn't understand how this code
truly interacted in other situations [1]:

> Frankly, I don't know how bash's 'kill -TERM' and a Windows program
> interact.  I've avoided this topic like the plague so far.

It's not true that applying patches to fix a situation for a specific
shell causes a hypothetical burden to our developers to magically
appear.

In reality the patch is applied once and forgotten about it until a)
another developer stumbles upon a similar problem, or b) another
developer stumbles upon that specific code.

No developer cared about 0e418e568f being applied. It fixed the
situation for one shell, it didn't affect other shells negatively, and
that's all anyone needed to know.

[1] https://lore.kernel.org/git/576DA6FB.1050108@kdbg.org

--=20
Felipe Contreras
