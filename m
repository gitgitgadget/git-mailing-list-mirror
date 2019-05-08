Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF191F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfEHLNY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35583 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfEHLNY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so9957393pgs.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GoSZjKWQLH05qQtY0a7xYfoBlYzQ/cT2s1cCFPLRNnI=;
        b=B7l9b4FH1cMV4A4gkI7JBcxcv9NimorwDRk1y0KTJWTPUATsm67XNVWdivTXcEbqeR
         PMmuokC20+q6AqDHG+0LdedyaeingW1uviZSZYUrCUySNzfZq2bffSFZ91qc5rqsqzpX
         DTYpsn8CNzXZchrbBDNkhIROKsEmgkxWL+ZONXc24d54YNgFOI66xHklHrJkvaOon3ia
         WOLDemklEy2+JW+OuRwv7qBBitUk8sSRFhMs2l6a7Vo8T7WxMz1jPGYnbAQOE92YtBoI
         htA37WYiZmF7YDBqAB0LmuBQRfUGeDx9NZRnHsh+pyh1cQK/vQop9rZ2MDpD4s0TFxPK
         NlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GoSZjKWQLH05qQtY0a7xYfoBlYzQ/cT2s1cCFPLRNnI=;
        b=F68oNJS35R8hxd7jtaRCnMYhxSXGMRUb6Fji93KWLaeyVpqFzmSBAYV760ZP4T3D+c
         7n7WysSKditpsOH2kmojwoHu1cRJm/Vur9K1ranmqVSf8Dyl+1Jw9PpMEVG2qdDpZq5d
         iajWUBJBEuEQP2uu2B90h7USZ/RNjUxQaW5K27b7bBYf/6GFunuWUiFJTligjR8HSJD9
         iOhOp9PQxw7QQ7jJBtwl8Uk0a6ueLDNccIXgM5uI5eTfG4jbcQx+Lr2WNO73tCW7nSg6
         /6yHnBDVIW8r4OiMmWG5qrqXM+6dWbz9RVGf66mqERnGWqVOY5rIywGC2UZ0620lKFFb
         +wzQ==
X-Gm-Message-State: APjAAAUd20Qs2sYXFsCxuUBq2BvCtYszvgMq2Ly6jDftk1bDFJgoOTNG
        Amijzc/J8ze4LdKOCC5mf6Z35G1q
X-Google-Smtp-Source: APXvYqyi0qy8PzBWNHYSa3shVjRxVGpEMJvjxZfDkRm3NXO9O06/ZNiJ8NZGoeWXx6bSu8RY2hyK/g==
X-Received: by 2002:a63:5d3:: with SMTP id 202mr44773977pgf.363.1557314003332;
        Wed, 08 May 2019 04:13:23 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id y3sm20272508pfe.9.2019.05.08.04.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/19] Convert revision.c to parseopt part 1/4
Date:   Wed,  8 May 2019 18:12:30 +0700
Message-Id: <20190508111249.15262-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the conversion in diff.c to use parse_options, this time it's
revision.c. There are about 76 patches to convert all options, split in
4 parts. After that there are about 10 more to convert rev users to use
parse_options() directly.

Full 76 patches are available here [1]. I'm not quite done with those
last "10 more" patches yet [2], still stuck at that ancient blame UI.
But I should be done by the 76 patches are merged.

[1] https://gitlab.com/pclouds/git/commits/revision-opt-parse-options
[2] https://gitlab.com/pclouds/git/commits/parse-options-step-no-more


Nguyễn Thái Ngọc Duy (19):
  revision.h: avoid bit fields in struct rev_info
  revision.h: move repo field down
  revision.c: prepare to convert handle_revision_pseudo_opt()
  rev-parseopt: convert --all
  rev-parseopt: convert --branches
  rev-parseopt: convert --bisect
  rev-parseopt: convert --tags
  rev-parseopt: convert --remotes
  rev-parseopt: convert --glob
  rev-parseopt: convert --exclude
  rev-parseopt: convert --reflog
  rev-parseopt: convert --indexed-objects
  rev-parseopt: convert --not
  rev-parseopt: convert --no-walk and --do-walk
  rev-parseopt: convert --single-worktree
  rev-parseopt: prepare to convert handle_revision_opt()
  rev-parseopt: convert --max-count
  rev-parseopt: convert --skip
  rev-parseopt: convert --min-age and --max-age

 Documentation/technical/api-diff.txt |   6 +-
 diff.c                               |  16 -
 diff.h                               |   1 -
 parse-options-cb.c                   |   8 +
 parse-options.h                      |   4 +
 revision.c                           | 465 +++++++++++++++++++--------
 revision.h                           | 172 +++++-----
 7 files changed, 441 insertions(+), 231 deletions(-)

-- 
2.21.0.1141.gd54ac2cb17

