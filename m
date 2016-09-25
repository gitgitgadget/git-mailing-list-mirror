Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5403F1F935
	for <e@80x24.org>; Sun, 25 Sep 2016 06:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938732AbcIYGGJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 02:06:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35195 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934317AbcIYGGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 02:06:05 -0400
Received: by mail-io0-f195.google.com with SMTP id 92so3997684iom.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=Of+5okrx30JTucZJzLwqCA62VN5RyQP5TGZZcfhyPN4=;
        b=JWyhIz9UIbhWXBUmT7Oe3FPSK3hCHAgrqaCGnW5TCz00jqREdKtPHZGr4336OPGqzQ
         05rCHg2AJUZ3QHcThRNpfJJ4Pf2InjvLCeh4eH4h3QD5PJ4fkKr1LgcuRSrKi3kYXduQ
         yFU0ohc+bP0xpYHDK2dAy1yif1hpwvaUeWek5hOxLrz9HvSZXYps+FGQ8oP0av0jlaMs
         BKfZwcehyaAAFdtpw9DTVMtOBj4lwR0pjgzKqgFkaiVBHZvXogxlnIO3/kD0f/M8hGBi
         +qjfbHTboMYghJA+jRnTTRONpXqmYh1Zjyo+1ShpzN2aq/tHIbfp7ow2ei+3y3mn0ndA
         mBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=Of+5okrx30JTucZJzLwqCA62VN5RyQP5TGZZcfhyPN4=;
        b=bo8Kfi1RWA7cekRjS4Cy8fFZP7oTy6B7aFUZ3nFdDgE299Z+ooOsJ463CImaf5Sd8a
         dBk+I8+OmLUE4zP+YlVrGev105E92MJO4jMy5K0aP47WuQAP/TGtyXFlKD9u4lHCoIPM
         pvErrtiC2Mystm44FZYcWf3goMzz4/9TxmJT6gcx3ESlADQp/z+7dxdtMDpdejGF96su
         C4uw9DmagPEt87olZpFdoVLH8W0fhTzbzzDaGSkp1w8FUlqvCzjpmfWcQEutT2KhrGlH
         VS55gdUn6mB6UqhJ9fo61jQOpQ3njZYhLb7LI3b14D2GUkP98yfu4jSWTtICpvjjTWuU
         3nTA==
X-Gm-Message-State: AE9vXwPs3RuC8B9t9ttm7VcEtCh867FI2kB9nVR0/cZhAzAi/l7AP4Nb7EaeEfYjwVsyLA==
X-Received: by 10.107.18.74 with SMTP id a71mr16119840ioj.126.1474783564648;
        Sat, 24 Sep 2016 23:06:04 -0700 (PDT)
Received: from lylat (S01061859339e9903.ss.shawcable.net. [174.2.107.88])
        by smtp.gmail.com with ESMTPSA id b36sm5925682iod.36.2016.09.24.23.06.03
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Sep 2016 23:06:04 -0700 (PDT)
From:   Alex <agrambot@gmail.com>
To:     git@vger.kernel.org
Subject: Request: Extra case for %G? format
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Sun, 25 Sep 2016 00:05:46 -0600
Message-ID: <87d1js1pl1.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Could the %G? format differentiate between an unsigned commit and a
signed commit that you're missing a public key for?

If `git show --format=%GG --no-patch <commit>' produces an output like
the following:

gpg: Signature made <date> using RSA key ID <id>
gpg: Can't check signature: public key not found

Then currently %G? results in `N', the same as an unsigned commit.

In this case, could %G? please result in a new character? Perhaps `M'
for "missing public key"?
