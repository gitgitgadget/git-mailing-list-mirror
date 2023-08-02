Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C35C001DE
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 07:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjHBHwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjHBHwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 03:52:02 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A335A9
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 00:50:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583b3939521so72715127b3.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690962625; x=1691567425;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=boBDKtdTAhVki4RGgl52IQF2dLKm5kB9qTV3kWpJsD0=;
        b=QMeJH1W1ytk2fqPgcVJU3EAbAEiahRI/OKeBWGtcFS7cHgSOtqGFLkvoE8dazaROwN
         ToIXFRcLKzo9g1wL7DF98+GXYiyfwGZzlEa85tiFdfFU2PZyt1HfT4lCIwOVXEQc1zmX
         KjwyPxDu0FoKg0fNnQOFDvkKjFnSs1HM9khrywI9lKEX1u61EwMK9PwjB031Gt+an41c
         jub+5lbTnu8Vm21Fviw7Igft1qzV/mpmbS0xOnRcEoPg8aZEEZnI8dzdzFiWd6sd1zpn
         F6zOObyfIHWf7JXEzD6ZRPUaqaVn3hpO8U7PTRidDPi4mEryV6C4s+K8lroYAhROzSVD
         DbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690962625; x=1691567425;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boBDKtdTAhVki4RGgl52IQF2dLKm5kB9qTV3kWpJsD0=;
        b=jsxN402Y25bGoPDfZfxGbqTmiyYZi7a8XzEzzFlJItXzTu+4NIzDi7Jgr4utxmZYB2
         OJ05CUoHNkikFfFb7GZFhSXXgadedGJL0rf5jXz4cbERWc1PMpadYY7+/nulBk3XZFty
         KpaCkmgpNMKgAMQ4bZMWIh8eeCLtc7iYWCg2bYRk2RfTZ4hArWCkGGzJryId7l5h4eLp
         WKdX3G36qvqEKBCg/huLvqSIoBUjXF/bWs7Hs0zprFELdo1Q8QgEnqNHlM9iseuNt4w6
         /B2Pr4iM69rvKeqmZ4EeJ39ns3dnG9zWxATvg3lS3tNZnvGVegFnpWJEeEWSALbETdTP
         jn/w==
X-Gm-Message-State: ABy/qLb66o1bWJJapBuu6W70/iBfJuFo8rKQzbRZZNp/YiWV9wfEbXfD
        oZgMbT/PRsaj+vmZFNfm8Mzg/ivx391LZSV3f468Rqut916ZnO/O
X-Google-Smtp-Source: APBJJlF5hyHq5eoy7wUmzG0YUiFBOzW9WRySIzqn9VR8Ivh2dau1jAnwvzIv5WNTIKEdD8r7/LCibLApuztQSw4lpTo=
X-Received: by 2002:a81:54c1:0:b0:576:a603:e733 with SMTP id
 i184-20020a8154c1000000b00576a603e733mr16110607ywb.22.1690962624810; Wed, 02
 Aug 2023 00:50:24 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 2 Aug 2023 15:50:13 +0800
Message-ID: <CAOLTT8RvAbmS1SwFja8_+NSBBoL0gTH1RgpSN5CYtDWZscMYZA@mail.gmail.com>
Subject: [Question] git rev-parse verify for non-existent object
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my case, I often need to use "git rev-parse --verify" to verify
if a revision exists in the repository, and this usually works:

git rev-parse --verify HEAD
afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3

git rev-parse --verify afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3
afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3

git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fatal: Needed a single revision

However, when I started checking for a non-existent OID that happened
to be exactly 40 characters long, something unexpected happened.
 "git rev-parse --verify" did not produce any error messages.
I consider this to be a BUG.

git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

I understand that using "git cat-file --batch-check="%(objectname)"
may be a potential solution, but I currently do not want to do it because
it would require significant changes and I am unsure if the behavior
would be consistent.

The simplest solution for me would be to fix "git rev-parse --verify".
What do you all think?

--
ZheNing Hu
