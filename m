Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE4EC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0EC20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVcmo/vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgAPVSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:18:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33607 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgAPVSa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:18:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so20668604wrq.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8Mt0lrHf0C1C6wa3VUghHmaQyMi3vzSq5WzTo9j8ZY8=;
        b=qVcmo/vZli4Vq70Jzo50I1lQ5VhW5mRDuMJOeabr671ifeyBP9GSI2k1JU+gZufoSR
         UEaSSYnj+s/aUb39apc4PODkVO8zLC83Wrb7YgeIKri6xhN+JsyOylRQzBqZtUIN2+kl
         Ca6A3Dpr3X4rqPn1nngGxXh0fD5DP0D/gDp1HJoQCxSrGkWqHnOZ5ENZ9/SLOg6bRLfX
         iD2AuKWNwdOCGkNWbJJ/IWPLU2wKkUo7xOEMGAZodt12pWsFKc8Pqai3b8odbJzFrVZw
         oTQ/4lR1h3K+z7VNgKFmOzNK12ZUcbgHDtWIMyvbyZYK3jnKGz6BmPgVlJpUcosIeAU1
         mYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Mt0lrHf0C1C6wa3VUghHmaQyMi3vzSq5WzTo9j8ZY8=;
        b=W2L48umfFKsYMwJU3j/XvaGAp4qG8/2+gP/Yo/WwX9PJpqSZO1wbgAnvXzTqrPVZ4m
         9Ri++O8Ak3/aAJ7WZWhWbZxKpoQ8p0n8u8mKGm/yD4eQuJs347e8cFlAVKzi+EPS4zkj
         NOg1an+Tdx0eTVAsuxXvR+fC3vmPRWBS13RhBbuAt7uElJakjZC2LPcWx4Ikeapq7DAt
         El2LCQ1i5JmAI7X5HicKtySh5Q0IqndbN+JaSMKjKuhQDcM5OFK35JlUkq3f3XjgKWvN
         mjTAxSdZB2iuB08ip5Nsg1xGTunttqOm+fwqgvQ5UfFBkwagBTOhdxs5uygl/7tWOice
         FEJQ==
X-Gm-Message-State: APjAAAXNW78CMombIqD+sQlICPWuZdpGmWUcuMLrHSaYAI3s0d/EvQHO
        S+DSMyfCmlUxOKme0E+/bqrQ52E3
X-Google-Smtp-Source: APXvYqz0SVeGJuNpN04sx8RbAboilFRuvhvV6hLs9BzBnx4cDHaI+YNV2SOVBZY1NKt5rxTfXA9yow==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr5541726wrm.80.1579209507801;
        Thu, 16 Jan 2020 13:18:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t81sm1702520wmg.6.2020.01.16.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:18:27 -0800 (PST)
Message-Id: <pull.529.git.1579209506.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 21:18:23 +0000
Subject: [PATCH 0/3] Re-fix rebase -i with SHA-1 collisions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Triggered by one of brian's SHA-256 patch series, I looked at the reason why
the SHA-1 collision test case passed when it shouldn't. Turns out that the
regression test was not quite thorough enough, and the interactive rebase 
did regress recently.

While in the area, I realized that the same bug exists in the code backing
the rebase.missingCommitsCheck feature: the backed-up todo list uses
shortened commit IDs that may very well become ambiguous during the rebase.
For good measure, this patch series fixes that, too.

Finally, I saw that git rebase --edit-todo reported the line in an awkward,
maybe even incorrect, way when there was an ambiguous commit ID, and I also
fixed that.

To make sure that the code can be easily adapted to SHA-256 after these
patches, I actually already made those adjustments on top and offered them
up at https://github.com/bk2204/git/pull/1.

Johannes Schindelin (3):
  parse_insn_line(): improve error message when parsing failed
  rebase -i: re-fix short SHA-1 collision
  rebase -i: also avoid SHA-1 collisions with missingCommitsCheck

 rebase-interactive.c          |  8 +++++---
 sequencer.c                   | 21 +++++++++++++++++----
 t/t3404-rebase-interactive.sh | 17 +++++++++++++++--
 3 files changed, 37 insertions(+), 9 deletions(-)


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-529%2Fdscho%2Fre-fix-rebase-i-with-sha-collisions-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-529/dscho/re-fix-rebase-i-with-sha-collisions-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/529
-- 
gitgitgadget
