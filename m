Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21489C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D1D206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKVQQSGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgEEKxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEKxb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:53:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E627AC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:53:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so2139424wrm.13
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHrjojOBoWbd1g4jiLPwGKp34FQjZarqC+YL62L4Soo=;
        b=vKVQQSGHpIwi7YwnCZAEk06yZ5tPuRuVeGepgDOdiEiW/axSG00T4a9O9JtmuDRBGr
         1tmMF08i2nei1JWiU7t2R0+7+3TC/NOdElcMlbLZP0HlmF9NtdzC0HtKVINUGtA2NBQr
         DsUwbNcPgiJoM1IRc9nV9ex9BEKsg8EwTUV1pe13iE0eYvWGtlK4jNLptlVw/fTVTooY
         lSYtHUa7n4oUbPXe84puJRndGPsE+/WjCbZxm/LNzGSqbgIHdTWDtmmLX8A+PiZIExvh
         782Db92e/92i8y2vE903fn+p5LVJuHurbvLO2ss/JOa0j+NCrvybClKLADoyobWZFChy
         q6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHrjojOBoWbd1g4jiLPwGKp34FQjZarqC+YL62L4Soo=;
        b=QUcXoSLNVqvM6QBoF6kkvslk5D7yEYXQK8c1GgFxG9eCjbZleOXp24JAQtp78QNzpe
         WO5hrfxaHs3dNKxJZbzm4ky5IefvKSGcgJk7GXl/Pl0wI8DgFmQ3TuomjiT2Ys+oCBmd
         D/RMEAylldhmzlEmy77xZOoi1grGdre2fuZa+4dvQvFRX/gd3CThItSH3SHQrHSPe8nm
         SPkvA7AywgZfWn18mCn1KJo0Z9Anb+pFnLsfMaBmGSt+AdnGZjDwW3NN2rYl64DTwwT4
         UJnnrhDz/0mh23+GhKcX3wCtV6pX29UAzasFYsmd+0vRpk3yXFxA/9wOKKN/WjzwUWYp
         qizA==
X-Gm-Message-State: AGi0PubFfC3E2TNqKdAnn4hhzBPWuFQo6hOzr8Vso3LD+bVKbW4s1KyA
        K1cCuVIk69SVhgo7JZg2Gtvd4V/u
X-Google-Smtp-Source: APiQypKOPGEKe5+UwBOwFP5kyq42QR6Tks+NZ42KpsSgDd+dr2ib8oXsG14LRTMZsEpMueBWsmzkMg==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr3227810wrq.374.1588676009292;
        Tue, 05 May 2020 03:53:29 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.googlemail.com with ESMTPSA id b85sm3170326wmb.21.2020.05.05.03.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 03:53:28 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 0/6] stash: drop usage of a second index
Date:   Tue,  5 May 2020 12:48:43 +0200
Message-Id: <20200505104849.13602-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old scripted `git stash' used to create a second index to save
modified and untracked files, and restore untracked files, without
affecting the main index.  This behaviour was carried on when it was
rewritten in C, and here, most operations performed on the second index
are done by forked commands (ie. `read-tree' instead of reset_tree(),
etc.).  This works most of the time, except in some edge case with the
split-index when the split file has expired and is deleted by a forked
command: the main index may still contain a reference to the now-deleted
file, and subsequent operations on the index will fail [0].

The goal of this series is to modernise (a bit) builtin/stash.c, and to
fix the aforementionned edge case.

I have to admit that I don't really know how to test this.
GIT_TEST_SPLIT_INDEX failed on me (gdb showed me that it does not enable
the split-index at all, at least in `git stash' and its forks), and I'm
reluctant to add explicits tests on `git stash' about the split-index,
when nothing in its code explicitly does unusual things with the index
once this series is applied.  If anyone wants to share opinions about
this, I would be happy to read them.

This series is based on b34789c0b0 ("The sixth batch", 2020-05-01).

The tip of this series is tagged as "stash-remove-second-index-v1" at
https://github.com/agrn/git.

[0] https://lore.kernel.org/git/EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com/

Alban Gruin (6):
  stash: mark `i_tree' in reset_tree() const
  stash: remove the second index in stash_working_tree()
  stash: remove the second index in stash_patch()
  stash: remove the second index in save_untracked_files()
  stash: remove the second index in restore_untracked()
  stash: remove `stash_index_path'

 builtin/stash.c | 151 +++++++++++++++---------------------------------
 1 file changed, 46 insertions(+), 105 deletions(-)

-- 
2.26.2

