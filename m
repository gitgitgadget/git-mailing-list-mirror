Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FCD20285
	for <e@80x24.org>; Wed, 28 Jun 2017 21:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdF1V63 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:58:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35316 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbdF1V61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:58:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id 131so13850660wmq.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mynhT74IsyvizzbsiMudgTAb20MRf91VSRwjNvwLSLM=;
        b=ex2EI7zwbwCV1NXDDvZo9GOffSlXXavPnYjJXqvM5/iEv7L0bHzsMj0oam6XMBRJsR
         oWN/roSJox/GlQ/eAarhm1OtV4FbfFXeU7vHXZn4QUw5Iw2HwsZVrzoSzEQNH6XswnMl
         g1rAThBguRkqI3E6+q2lw6f0tUr2oGtknr0zkMu4JVZV4ahNw+Nzs9bF4C1SewQZMNNV
         gktSD4oWWJVXaTeKXKnoRK9SeX0mCTWt1YKtiqB2rKvo5u9+sVWWyYf6EQDiP44Y5VS/
         vqXCCjsP/IIRw2mue/zostPQNNxU6fW1Z4u/O/a/5fMrAtL0MDr7DzAFyL2fN+0fgX8B
         6FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mynhT74IsyvizzbsiMudgTAb20MRf91VSRwjNvwLSLM=;
        b=YRdPVUXJ4bUsQJiDGDyvWVXrV6WVGdxs++5AdLwI6EidnGkzATrwvo/OmmpJW1E6yk
         6JG+eDNIv7LPRnL0h+A1GBjkOEqmttw5HgWaCnjaxJP2htfCOXRM0JkDgxeHtWBeEvGb
         +ttdIdiKY/dR39Wre6wzHsAtGcy8GyozYB/xbzFfYVHwF/H/pAWGgXP4YqohAtawnzpE
         Pd+83p3M4uTHzvEGujb1F1d+Hs3RY3OqIUNiapsXbNXvdJixFsJMgrTtZOjfrfxIWBqF
         n0ii1zzgSaB9UAKhbIdS3wU0YFPlfNt8wRqIeXWdkYq7iTlMgXhHZ+3QgS8dYseryG9Z
         0q2A==
X-Gm-Message-State: AKS2vOz/eWWFzKnGW7yvomAGaYBwbm7fnISv66sOP5goqeGnxfwilWFR
        BkxhefOwvF3jh6WMd4U=
X-Received: by 10.80.141.83 with SMTP id t19mr9114631edt.75.1498687100462;
        Wed, 28 Jun 2017 14:58:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g25sm1926975eda.59.2017.06.28.14.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:58:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] grep: remove redundant code & reflags from API
Date:   Wed, 28 Jun 2017 21:58:04 +0000
Message-Id: <20170628215809.23060-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a follow-up to a small tangent of discussion in my ~30 patch
grep cleanup series.

There are no functional changes here, just getting rid of dead code,
and removing the POSIX `regflags` variable from the grep API used by
grep/log, which was the cause of the long-standing bug of "-i" not
working with PCRE when used via git-log.

Ævar Arnfjörð Bjarmason (5):
  grep: remove redundant double assignment to 0
  grep: remove redundant grep pattern type assignment
  grep: remove redundant "fixed" field re-assignment to 0
  grep: remove redundant and verbose re-assignments to 0
  grep: remove regflags from the public grep_opt API

 builtin/grep.c |  2 --
 grep.c         | 59 +++++++++++++++++++++++++++++++++-------------------------
 grep.h         |  1 -
 revision.c     |  2 --
 4 files changed, 34 insertions(+), 30 deletions(-)

-- 
2.13.1.611.g7e3b11ae1

