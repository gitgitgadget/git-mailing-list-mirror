Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515B91FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755013AbcLNIRe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:17:34 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34608 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754875AbcLNIRd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:17:33 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so2861473wjc.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ccdxmfIIAWnJlei6p6HZ4VxZqluQjaQffSgMZ/o23zU=;
        b=a1ynv4jFbk8plKHH+DIyxR145Ry88sWC0nO/m50F7FuJR4vwrCCaczcaWWWRzyfXA+
         NW/ydc8GC7sTzNWkxbHmIzRFP37OSUlD/O8FGwTAB39fUzerj0AUJ7SIylNK7XzEeoCl
         ZSzL3LHCFeZNDg4kA1Y71nozLKFXtK/+TofI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ccdxmfIIAWnJlei6p6HZ4VxZqluQjaQffSgMZ/o23zU=;
        b=C8QppfjGuY16u0iX3sN9TnqvJtB0M7m+qLzjmZLEOZ9pll5/jFHJNsFfwX3+mmoU2W
         kCDIpNv2nubMw0vHw4TvGtwChxXUa7dPojYyVoCuvFiL1mYSdB+OkZX6SlJSFLx3tZp1
         cuMtTgitwnl+ATlYgdC653/dUuEx+8qBNwBskEEpi/mclnbIS2oiNVQJg92VQmx0Xg3i
         1p5bY9rN/32BN6eTU6R+S1C3OMcqVjgKAqLA5cFZLg/nfJ+OhFhZSmwyG1UZDmw/hNSv
         kwcror3jOnipTjEUAZY+3Ed5+n3WHLq68oJLc2rCqGzZFiWip9B8X7Vcs5lZr9cbvN+g
         UzJw==
X-Gm-Message-State: AKaTC031KqR+xVM/6tSJX3SbiBhufr2KMxvNKQRBiCIu7oQpDrmCOJJgUdgXHZ0W0NBJ7Q==
X-Received: by 10.28.31.65 with SMTP id f62mr6150743wmf.108.1481703451960;
        Wed, 14 Dec 2016 00:17:31 -0800 (PST)
Received: from lgd-kipper.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id c133sm6381484wme.12.2016.12.14.00.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2016 00:17:31 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, aoakley@roku.com,
        Duy Nguyen <pclouds@gmail.com>, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/1] git-p4: handle symlinked directories
Date:   Wed, 14 Dec 2016 08:17:23 +0000
Message-Id: <20161214081724.16663-1-luke@diamand.org>
X-Mailer: git-send-email 2.11.0.274.g0ea315c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a long-standing bug around handling of symlinked directories
in git-p4.

If in git you create a directory, and then symlink it, when git-p4
tries to create the diff-summary of what it's about to do, it
tries to open the symlink as a regular file, and fails.

Luke Diamand (1):
  git-p4: avoid crash adding symlinked directory

 git-p4.py                     | 26 ++++++++++++++++++++------
 t/t9830-git-p4-symlink-dir.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100755 t/t9830-git-p4-symlink-dir.sh

-- 
2.11.0.274.g0ea315c

