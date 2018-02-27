Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769741F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeB0Val (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:30:41 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37612 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeB0Vak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:30:40 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so271953wrg.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rix874TbM7JFzedMWfjvQ1VS07Qz815qR5HtvRme7m4=;
        b=rSPmISnWcmVug41lRfKZiPhYXDMqie3SomB28he+EI8Rt0ZlKHIxPDuQXco7YmATH/
         ETwrVqPs5KJtWBaLmQfwoVXaUpMy3AdYzMZgFz+jKctAYBLVJX6tUJE4G4/z++Rhed4Q
         wOWGPsVbmQ9NSwXCcZgs1Hcjw+/AA1FotBVy2T3skWhpxphCuuoUzIE5NLvq2iLsoG0t
         04OdOEyuILNWUqVQ8tUUNEJ+qTN47YnoIeTTRUdkmDFsXerCLYaKcqZy2D9I/Blr4u3C
         XtQsy+sAVJFaspqp5Jw9rE6ceKyOy058YBjqeqqp6UeHrSmXRe4SDHd40XX5IEWKWdqE
         0nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rix874TbM7JFzedMWfjvQ1VS07Qz815qR5HtvRme7m4=;
        b=ACjkrAfkDgBbf14RvIm9sO1EEl3OE+UlP1ZEbozGGHVidzqeo0iF/wajT+aFC8KtIe
         up9z+Lr2eRaa4ChJbRVZYL5NF1bTWGRC3cTITeaJTh66sgKxuNt6lA47VMr2atemL/n6
         SwtBSNgacAe3m70jpNPMBeJt2aHAWJwf/4rseZg+d6+DVciXKU43VNEVRr2eQYMuorEp
         CsAkMLFe9Tbnvo3uZvFH/tj4utRI5dx35jIovflCoX7pGH6/kWcuwFqqGNSWBGCqYSiq
         35rpLq+1fghdlm8RBK/U1UEotahdequGY9Tc1tb++r2VTzLRV6C4ELbowoARI8GRdCbW
         Yp6Q==
X-Gm-Message-State: APf1xPC47bnieyVbFjXFn3Ti3hxa8erlTXC4ozRWlpzHygjN5n6dWY/u
        9nYXNVdA/mv5XiJjL8n/vLF0bSkI
X-Google-Smtp-Source: AH8x225EW3+f7m425D/8xpnJjbVyT/Fy3L7Y0RnSoyLcARfvCgqzlXdu1RUaFyHBMCIQczFJuXJt5A==
X-Received: by 10.223.195.204 with SMTP id d12mr14327358wrg.116.1519767039086;
        Tue, 27 Feb 2018 13:30:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t91sm126888wrc.21.2018.02.27.13.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 13:30:37 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/5] roll back locks in various code paths
Date:   Tue, 27 Feb 2018 22:30:08 +0100
Message-Id: <cover.1519763396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches 2-4 are the actual fixes where I teach some functions to always
roll back the lock they're holding. Notably, these are all in "libgit".

Patch 1 is a "while at it" to use locks on the stack instead of having
them be static. Patch 5 removes code to roll back locks which are
already rolled back.

I've based this on maint. There's a conflict on pu, with c7d4394111
(sequencer: avoid using errno clobbered by rollback_lock_file(),
2018-02-11). The conflict resolution would be to take my version for the
"could not lock HEAD"-hunk.

Martin

Martin Ågren (5):
  sequencer: make lockfiles non-static
  sequencer: always roll back lock in `do_recursive_merge()`
  merge-recursive: always roll back lock in `merge_recursive_generic()`
  merge: always roll back lock in `checkout_fast_forward()`
  sequencer: do not roll back lockfile unnecessarily

 merge-recursive.c |  4 +++-
 merge.c           | 12 +++++++++---
 sequencer.c       | 32 ++++++++++++++------------------
 3 files changed, 26 insertions(+), 22 deletions(-)

-- 
2.16.2.246.ga4ee44448f

