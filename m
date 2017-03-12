Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181771FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 07:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbdCLHyp (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 03:54:45 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34689 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933100AbdCLHyo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 03:54:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id x35so3075310qtc.1
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/xcsV5trzwlRwc2TRfl1XeuHdWJpnMUcfNRqSp6ET5A=;
        b=c+bpLWw0jKY0eGlUUfcJTuT9YnbWd8/4XoUYrLFmaPKNEtcKLVQqf1U1pnwbMWYTDL
         QcQQio3SbWZCLsVwxia4NGxn4zludKygTRJoUDyykyvp7QA3+n2pPItmPxYxJ25Wvfn2
         mT5FNJ0KkrxDToxz5zg5YpPbE6eH9snBqAdRWQg/emE53YTRyTBBUPZNBDJZ0noQ7V5Y
         gZIlZyJ8oG4/1jGp6toxAHA0VZETuXPvrkpTGtRFiUmvVe/Up7ubeNsuffXHa5x+SYLv
         SnHLohXRrE3sUDAxW42Cjfv1zHX+E8lukjHqxb9suiHRXdGv7Q5mhsvTtZcgXskDwoAe
         RXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/xcsV5trzwlRwc2TRfl1XeuHdWJpnMUcfNRqSp6ET5A=;
        b=Ea4Fy5f4M1EbKw99aVrkXty1n2cJy+rTy0vArNyHtHUdZM0YUpZ3z+VxDtduEeJukj
         7eMzpGEUFSaD1lF2RSbkWC44OIzuSxVO73PaTxgkgi+JmdAkx8KdPpTnTJaXunAtVA2m
         m1G4AKVGB6i6mDrW2ueAI/ax8C0O4R3psUjacNIHYjEf3vs43GfFNu/JbqTmQ6MCkIv0
         OQomMpiKywfVAoPWAtG7CD10lJA/s2a2LpqCLCePV9tj7mu1+SXxLGAN9eT/3hEwqzxY
         RmZ65lmSlF8g4aMPv55jlPOFC6ycv465abuarTnYdq1IlNTrOOcCflRjsGnO6xXYjXM1
         Es/A==
X-Gm-Message-State: AMke39mLllXeUS/UZ/9WyVpRFNBCawYL1jFitfk8hX2fbdRfZwBBLqouj3lEI3J06xUE1A==
X-Received: by 10.200.39.136 with SMTP id w8mr28255448qtw.284.1489305282877;
        Sat, 11 Mar 2017 23:54:42 -0800 (PST)
Received: from bonobo.com (cpe-184-152-21-78.nyc.res.rr.com. [184.152.21.78])
        by smtp.gmail.com with ESMTPSA id 143sm9824171qki.59.2017.03.11.23.54.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 11 Mar 2017 23:54:42 -0800 (PST)
From:   Nikhil Benesch <nikhil.benesch@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Hjemli <hjemli@gmail.com>,
        Nikhil Benesch <nikhil.benesch@gmail.com>
Subject: [PATCH 0/1] archive: learn to include submodules in output archive
Date:   Sun, 12 Mar 2017 03:54:03 -0400
Message-Id: <20170312075404.23951-1-nikhil.benesch@gmail.com>
X-Mailer: git-send-email 2.12.0.244.g625568cd8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviving an old patch from Lars Hjemli to teach `git archive` to
`--recurse-submodules`, which is, in my opinion, a sorely needed feature. I'm
afraid this is the first patch I've submitted for review, so I wasn't sure who
to CC. Apologies if I've gotten the wrong folks.

Nikhil Benesch (1):
  archive: learn to include submodules in output archive

 Documentation/git-archive.txt |   8 ++-
 archive.c                     |  22 +++++----
 archive.h                     |   1 +
 submodule.c                   |   2 +-
 submodule.h                   |   1 +
 t/t5005-archive-submodules.sh | 112 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 13 deletions(-)
 create mode 100755 t/t5005-archive-submodules.sh

-- 
2.12.0.244.g625568cd8.dirty

