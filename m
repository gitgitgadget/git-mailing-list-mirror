Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BAEF20966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbdDDKWL (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:22:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34036 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754097AbdDDKVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:21:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id o123so36259643pga.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irA2GhRVK169puv0gvgLyVOoabxabTWs8a0C87wpXCc=;
        b=YedxBI+o0Abv5MdDneTwq2NIg1Thr0K5J5aGEgN27+oYPtr/Ef/QSLN2DxxCpSkK4N
         JAQhkRvmXI5V2rYZvY0sRNuicdsrbNFmpDoc3KHLIn9IU2JMcPkkvYdT62S6pQ29KoLA
         1ijsFuJZ+m8Y5dnRbGPZ1FcJEgGz+0ae0G7D0T4/qT0Eb0rJNzrfC1P7PB0mLvdt6P/H
         czcXQXvs3GpI3asGEszMaYCnftqMcjvU7xuB4c3blZry0TBFrQB8lzIo2D6D7MLYufQz
         I067/vtW57wuitp+UMVY5C8h5lPt8lnobKAUWjvVXcGxL7O/Co/uGf8Hf6CcW/3Jxw5U
         i+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irA2GhRVK169puv0gvgLyVOoabxabTWs8a0C87wpXCc=;
        b=Ys1Mct006rRSi7A6SYrVcuNVGlOdWjlGjfDnfauN7KW7Us04qMRmAQWX9gubqKPqHY
         Eu+lr0iIDAOtZNeCNKdqy88URdANPgbotQ8xRMwHtiDlUBzQInnv53De8VqmCENGmmA+
         SgXWGm8QdYanrcSCPE0mTritXMCse6bfdg+mg7bWYAvDJ5CSRmoa8owN3M4u/AdP96RJ
         x5JqHTS3N2CqanTgvuqqQHXMEoCfMPKEbDtvx1/zqE0DSEnPepyvi6RE2Ayw58HvHQIa
         iqcAHjWJbqo9eIxxppsLLN1uhLRleOzs5k8izUr4h+Y3j+h8ico6GSPehbLvl9/TQRlq
         Dtuw==
X-Gm-Message-State: AFeK/H0YkBBWc/fEnaL+2mptYS0U8BuzVmgrq0Fg9QBOR3K+oeWamMb5kUJV3OCVCcxWYg==
X-Received: by 10.98.61.5 with SMTP id k5mr21889759pfa.229.1491301306922;
        Tue, 04 Apr 2017 03:21:46 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id g27sm30869969pfk.95.2017.04.04.03.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2017 03:21:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 04 Apr 2017 17:21:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 0/5] Kill manual ref parsing code in worktree.c
Date:   Tue,  4 Apr 2017 17:21:18 +0700
Message-Id: <20170404102123.25315-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318100206.5980-1-pclouds@gmail.com>
References: <20170318100206.5980-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 adds a new patch, 2/5, which makes the hashmap related functions in
refs.c generic, so I could add a new map for worktree ref stores and
not abuse submodule hashmap.

I mentioned about moving these hashmap back to submodule.c and
worktree.c where it can map more than just ref stores (in worktree
case, we can cache 'struct worktree', for example). But I'm not doing
it now to keep things small.

The commit message in 1/5 is rephrased a bit, hopefully clearer.

Nguyễn Thái Ngọc Duy (5):
  environment.c: fix potential segfault by get_git_common_dir()
  refs.c: make submodule ref store hashmap generic
  refs: introduce get_worktree_ref_store()
  worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
  refs: kill set_worktree_head_symref()

 branch.c                               |  15 ++---
 environment.c                          |   2 +
 refs.c                                 |  95 +++++++++++++++++++-----------
 refs.h                                 |  12 +---
 refs/files-backend.c                   |  44 --------------
 t/helper/test-ref-store.c              |  18 ++++++
 t/t1407-worktree-ref-store.sh (new +x) |  52 +++++++++++++++++
 worktree.c                             | 102 +++++++++------------------------
 worktree.h                             |   2 +-
 9 files changed, 173 insertions(+), 169 deletions(-)
 create mode 100755 t/t1407-worktree-ref-store.sh

-- 
2.11.0.157.gd943d85

