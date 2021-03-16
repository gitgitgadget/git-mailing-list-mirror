Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C42C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879EE65011
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhCPJpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbhCPJpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 05:45:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F322C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 02:45:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c10so70937788ejx.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VlTxSIfrDq/cV1EoZwoJq2VotUoKhxVKtA+zI7liB3M=;
        b=fS7vGlfTKQJWuwk7QH8tGQk4ueO87PdxGv2xV2VtGY9jlpZremh0e/aF6GVSUVWCHC
         Rt8dM4kh3dP7XeSzJismMA88udjEj4fyaeQHVBAMk1ABDPKmhaFzHTjKUcaTsqasjmyd
         aElBdjgQ+lq51FAOOHrBs/iz7NLaqNVX4vm+m/fptmftWHGUwQvHERKuxx2wO29jB3Ww
         te6Jv9AhlRP1DzaZrqWrrbGtfyN4nP4bIyJ1FMiASTX9E8Xy8BgZ4eE10ZvijtlwWKB3
         rTd/c3BD26o73OwKeojAwMSpO5Ms7TZ9cjYigpluZCfz6eLxlNJD16iDn9BkEm7kYWRy
         1YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VlTxSIfrDq/cV1EoZwoJq2VotUoKhxVKtA+zI7liB3M=;
        b=ghwIzA8ryp5JcNiL5gcqYcWdhhKt03cDcGlPLvShZZwuEivQQs1I+tssYzSsDw7r4/
         DMHJXR1QV3jc5islm6jYEdAIxgg92JPeodemFvbvmpO1n2lHAUipqGVC7XlIgLf2Hbk+
         Agzp6BgKy1hB3Z+C85RBn/f3SuCRUwm0DPCDHOy/h96GMEU6EMNdN5q9kLJGYjpSBqom
         4D+YysOX7R1aQbhEqx0VMKlgF1dQbA/BH9HJew7W6GG0rEkcTcCRZCwFRwDqNXTfGcGm
         IqoayrWc3HKjk2HGLL7mTy2K4vJ9bzQruxD3WtydUmsfUatNMHY7T+aPTvrrYyvHP1MC
         MU6Q==
X-Gm-Message-State: AOAM533XFe4qwGiezrBckBtQLPR8MCEsu3ruuNom5TNh544vXHbzhm3R
        1D+zuYNkwSEljdZLsPRhrdCngfEuSYYxySAAqUjZT2KLAuUGiQ==
X-Google-Smtp-Source: ABdhPJxBTGAxGn+xdk2YnAAF70MZjvqtwCKFOygJxEKFtDQ1GrBY5P/nCv3iRPnEeNF/cgfQ1sYpPkeAwVcuy+/3xZc=
X-Received: by 2002:a17:906:eb89:: with SMTP id mh9mr29202141ejb.122.1615887931599;
 Tue, 16 Mar 2021 02:45:31 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Tue, 16 Mar 2021 10:45:20 +0100
Message-ID: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
Subject: Tests failed with GIT_TEST_FAIL_PREREQS and/or GIT_TEST_PROTOCOL_VERSION
To:     git <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Running the test suit with GIT_TEST_FAIL_PREREQS=1 on master (and
next) seem to result in some failures:

  Test Summary Report
 -------------------
  t5300-pack-object.sh (Wstat: 256 Tests: 46 Failed: 2)
  Failed tests: 35-36
  Non-zero exit status: 1
  t7810-grep.sh (Wstat: 256 Tests: 229 Failed: 1)
  Failed test: 160
  Non-zero exit status: 1
  Files=924, Tests=22400, 422 wallclock secs (12.57 usr 2.52 sys +
601.02 cusr 1047.02 csys = 1663.13 CPU)
  Result: FAIL

A quick git-bisect run seems to point back to this commit:

3b1ca60f8f317b483c8c1805ab500ff2b014cbec is the first bad commit
commit 3b1ca60f8f317b483c8c1805ab500ff2b014cbec
Author: Taylor Blau <me@ttaylorr.com>
Date:   Tue Dec 8 17:03:14 2020 -0500

    ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()

    'ewah/ewah_bitmap.c:buffer_grow()' is responsible for growing the buffer
    used to store the bits of an EWAH bitmap. It is essentially doing the
    same task as the 'ALLOC_GROW()' macro, so use that instead.

    This simplifies the callers of 'buffer_grow()', who no longer have to
    ask for a specific size, but rather specify how much of the buffer they
    need. They also no longer need to guard 'buffer_grow()' behind an if
    statement, since 'ALLOC_GROW()' (and, by extension, 'buffer_grow()') is
    a noop if the buffer is already large enough.

    But, the most significant change is that this fixes a bug when calling
    buffer_grow() with both 'alloc_size' and 'new_size' set to 1. In this
    case, truncating integer math will leave the new size set to 1, causing
    the buffer to never grow.

    Instead, let alloc_nr() handle this, which asks for '(new_size + 16) * 3
    / 2' instead of 'new_size * 3 / 2'.

    Signed-off-by: Taylor Blau <me@ttaylorr.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 ewah/ewah_bitmap.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

I also found that a test is failing with protocol V1 set
(GIT_TEST_PROTOCOL_VERSION=1)

  Test Summary Report
  -------------------
  t5606-clone-options.sh (Wstat: 256 Tests: 15 Failed: 1)
  Failed test: 14
  Non-zero exit status: 1
  Files=924, Tests=22852, 568 wallclock secs (12.69 usr 2.73 sys +
842.87 cusr 1322.91 csys = 2181.20 CPU)
  Result: FAIL

Which git-bisect is telling me that was caused by the same commit.

Regards,
Son Luong.
