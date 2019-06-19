Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608751F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFSJ7H (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSJ7H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so9429035pfe.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHxgScSs4VIgZMCQVDluIaeUIDf43l35QHJwuNc72ek=;
        b=rRUI9Jb5emW6GfpgqLpOcefhuAGxi8QNiiRXtq44J9F+hQz1gXgb72OPiKw2b58sAx
         X7qehxgDU1stL8HScAj6HRfQ3QdDHboQuNu/cgAfOSzEVzqF9nURaFF4WGVVao5n72iN
         LTMKm6tnbalOndF400c6441iwGx4W8FDwffYB2/P8/0h5B1Ovj8Fggjj95UBCMHuU9a7
         RaTBQCGHFjseJK+Y7u63eFLNf2GAD7g/h9wTOvScqSujJPopkkW86XGctk+kRW+A7wzD
         qQ0I0i4awyX2GE408Zto9T4hROPHHsAhdKJyxIOp2HyXtxLCNMnPAfNwmEh6/MjabJTV
         OKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHxgScSs4VIgZMCQVDluIaeUIDf43l35QHJwuNc72ek=;
        b=cK9LK+8SdZ3FHI/hgfuSwrGjMoGfkspUdqXCyLbe85Ucz0gaKwFuUNfGHoqSTbfzvG
         4vavKtA+elPTayCyCQrtyNQm6VwF3Kf0d4V19QnnhbGlpsy04V4OB1idr8Bb+oo4r1E4
         S7AgbpX9Trf8hFpCREq0Bm7bhsdolZzuElEnsjcwKCgzM/5lPUsQrFAgZwt/59gGTJrK
         b4rodlHsk8uswx2mOxPh8c1j3r1Epr8udWtbvISrgRhr2L7E9no7RUsZ05zbRPpMIEaP
         4hWo9oLQX34o1xhVC390Hu27gBJXzGGibU9O80jB2CyerYbFWsB5T9IsyR3Fzbc6R5i5
         MnMw==
X-Gm-Message-State: APjAAAXVRHfVT1XlnZb7/OV0mPJz4cw6i6mQ+jXg20t0wE0EOCvJFdiO
        Q2aSw9RlR3OlxoQW+UrB+kGSPZkw
X-Google-Smtp-Source: APXvYqwOYKe52qyR4pCWLepQ0CUzp4PGOOQOhtwzdOTNh2KO0zbSKHx+ZrpIGd95nzompWDmrdzOsw==
X-Received: by 2002:a62:a509:: with SMTP id v9mr123699140pfm.82.1560938346419;
        Wed, 19 Jun 2019 02:59:06 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id x14sm23366675pfq.158.2019.06.19.02.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
Date:   Wed, 19 Jun 2019 16:58:50 +0700
Message-Id: <20190619095858.30124-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is probably just my itch. Every time I have to do something with
the index, I need to add a little bit code here, a little bit there to
get a better "view" of the index.

This solves it for me. It allows me to see pretty much everything in the
index (except really low detail stuff like pathname compression). It's
readable by human, but also easy to parse if you need to do statistics
and stuff. You could even do a "diff" between two indexes.

I'm not really sure if anybody else finds this useful. Because if not,
I guess there's not much point trying to merge it to git.git just for a
single user. Maintaining off tree is still a pain for me, but I think
I can manage it.

Nguyễn Thái Ngọc Duy (8):
  ls-files: add --json to dump the index
  split-index.c: dump "link" extension as json
  fsmonitor.c: dump "FSMN" extension as json
  resolve-undo.c: dump "REUC" extension as json
  read-cache.c: dump "EOIE" extension as json
  read-cache.c: dump "IEOT" extension as json
  cache-tree.c: dump "TREE" extension as json
  dir.c: dump "UNTR" extension as json

 Documentation/git-ls-files.txt |   5 ++
 builtin/ls-files.c             |  30 +++++--
 cache-tree.c                   |  41 ++++++++--
 cache-tree.h                   |   5 +-
 cache.h                        |   2 +
 dir.c                          |  56 ++++++++++++-
 dir.h                          |   4 +-
 fsmonitor.c                    |   9 +++
 json-writer.c                  |  30 +++++++
 json-writer.h                  |  29 +++++++
 read-cache.c                   | 139 ++++++++++++++++++++++++++++++---
 resolve-undo.c                 |  36 ++++++++-
 resolve-undo.h                 |   4 +-
 split-index.c                  |  13 ++-
 14 files changed, 376 insertions(+), 27 deletions(-)

-- 
2.22.0.rc0.322.g2b0371e29a

