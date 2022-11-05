Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36161C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKERH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKERH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:07:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76CFDFAB
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:07:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y13so7078964pfp.7
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ehbg6oqzNmT3LAIRFU5Gy4AeOYbsldgOFjA1sTYy92o=;
        b=METK5fMno+m4/GKcljXFfvSCjvSplbcgXsboBC4uwYENvTxzQVAznlSw4oV9JLG0Ry
         VJnbSKip+hzWNmQLU1BBKN1MkNYrt2Paijqa07Ewaqz/Td5uHZWbsGnVc6Qrvmyeo7eA
         rZqWbe3vRilJBybGfcAntj8FSVQGeJoipkTaF/uDVBnMLtJobL1j/FNZcf0yocxmOj2b
         5XSullhKjX2Rdf3OC+b1/LXFmK0akLEfoo/Dbe8l4CvML9a47c91O4Bxovom+Mwr8SEr
         /SrekIB4KnkJr8mBpOb/IgpyPrIkN6kQHFn7G54ZoryXDjj3He6WsWwHjtI2VSFRJB1T
         14xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ehbg6oqzNmT3LAIRFU5Gy4AeOYbsldgOFjA1sTYy92o=;
        b=dBYJLwVCEj7nC/gQJhRnAP0BjD/RBVU4mW2MkDwMKgJG8Gp5V7MYVBrcsvXEkrfk1V
         noYQV+g1srwaoJ+GmIPvG7DMTtUrZZUKCPPLU2cG56Ztxdmhp+rad4daXXNuPfhTd63m
         rufYM6lWqiX1wFfViPA0ARBzKGcXbpT+fDXZKBZ1fnIH222NSfSJ2716UUAcIIy0Ml3q
         GIGaos6iEGCPxqVljrjOyznHTy7ENFEEQrOs5+Gq5u2ZlxzLXbgCht9iJO4XspTW1Zy5
         p8kAyH5p1uKbssE+RSmkQnKkOdRvakzcs0VyXY36bOOLhXCyb2dXqJJBdjNfcldqvigE
         jyRg==
X-Gm-Message-State: ACrzQf0HFwzH7ju+BsJWywewe+rjM7pA2JuiT8koKb80p0rVRxIJPfOr
        EXXso6f1WwSzaGbBEJ6xbq6gS9eTjCU=
X-Google-Smtp-Source: AMsMyM7bcLx8wPuYDCY/A1uy1N8JJ9rsvW/fBJtQXX6OUeEg1WOrimsh7r0HF8OvkJscJ8vLY49o1Q==
X-Received: by 2002:a63:d848:0:b0:46f:81cb:6d6c with SMTP id k8-20020a63d848000000b0046f81cb6d6cmr34564548pgj.453.1667668075885;
        Sat, 05 Nov 2022 10:07:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:07:55 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/13] Turn git-bisect to be builtin
Date:   Sun,  6 Nov 2022 00:07:31 +0700
Message-Id: <cover.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667058.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series finish the git-bisect porting from shell script into a C builtin.

This series can't be applied cleaned on master, it needs to be applied on top
of the series posted at:
https://lore.kernel.org/git/cover.1667667058.git.congdanhqx@gmail.com/
AND the series rs/no-more-run-command-v, which has been integrated to next.

There're two commits which were made by me, one of them is the reversal of the
other, which I don't really like it but it's there to restore old behaviour
until we justify the change of behaviours.

Johannes Schindelin (2):
  bisect--helper: make `state` optional
  Turn `git bisect` into a full built-in

Ævar Arnfjörð Bjarmason (6):
  bisect tests: test for v2.30.0 "bisect run" regressions
  bisect: refactor bisect_run() to match CodingGuidelines
  bisect: fix output regressions in v2.30.0
  bisect run: keep some of the post-v2.30.0 output
  bisect test: test exit codes on bad usage
  bisect--helper: emit usage for "git bisect"

Đoàn Trần Công Danh (5):
  bisect--helper: pass arg[cv] down to do_bisect_run
  bisect--helper: remove unused arguments from do_bisect_run
  bisect--helper: pretend we're real bisect when report error
  bisect--helper: remove subcommand state
  bisect--helper: log: allow arbitrary number of arguments

 Makefile                               |   3 +-
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 124 +++++++++++++++----------
 git-bisect.sh                          |   4 -
 git.c                                  |   2 +-
 t/t6030-bisect-porcelain.sh            | 109 ++++++++++++++++++++++
 6 files changed, 186 insertions(+), 58 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (92%)

-- 
2.38.1.157.gedabe22e0a

