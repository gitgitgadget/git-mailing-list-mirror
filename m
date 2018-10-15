Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83B21F453
	for <e@80x24.org>; Mon, 15 Oct 2018 11:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeJOS7M (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 14:59:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44712 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOS7M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 14:59:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id p25-v6so9134635pli.11
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/F2HAK/xRuUEu05AaELvxw/KmC4LMhv1LQ8i3GRbaw=;
        b=HhSYROx8+gNZr7WvQBrlFAgNbIEPyxtVNJYtu4vWIDjCGoqUNzZb3Fu2VdCXVRRBIO
         vCJMrDvul4xOm9Rs2OrtpkzvtDwe1NCAe+AVZTK5ML747v8YhewFfR5W/WLDy141AhuH
         KZ9iZRhSOO047rjypDZzawkkiA1Q/Xp4cQeIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/F2HAK/xRuUEu05AaELvxw/KmC4LMhv1LQ8i3GRbaw=;
        b=cTWA0OhNXGp/L0FWx1M597FvcLwp5gHs5oIfWwrnw1D/K5x3iqNXWPVVBUcU3A7tnF
         KwWaVC5jSvOnWQ398yfoSUHg31Oz+p7Abqc1uoZB6nmy+uPa8IwZc29lZErwTCT6IlMa
         2IxXjDhSamOkG2KbrDvg3zidYC2cvj/eO6ZnbJ7z53U0vuvx4tKdz+DbAIIIm2B3CJQK
         7Bx/l34j2p/yUbyxnnQhOxj0O2bFVaFPOevq2apFvMsoVGqBOa0BXLftsdGpQqX7uRyi
         VLa2aFLxbG1VBX06Tj4MeM4Yjnswyj9gxoBsNHy3DeN9rirbva1F4fWWTCmIDzAhfCrQ
         nZpA==
X-Gm-Message-State: ABuFfoiCN5eIwaOg2IX4KoXz0UE4QWzcJSZk0H6tBkD/mD3H08KqKZRS
        mL6gT6kZ0LjBClkxiHD+EmkVxpov4ydgaalf
X-Google-Smtp-Source: ACcGV60UqoACGpVKuWoTi8RQsCqR7jxwcqwfvcz5EJlexpGqT5jxIrClY4/od6nEsV9x094S/p61kg==
X-Received: by 2002:a17:902:f08c:: with SMTP id go12mr16789032plb.263.1539602064310;
        Mon, 15 Oct 2018 04:14:24 -0700 (PDT)
Received: from lgd-kipper.hsd1.ca.comcast.net ([2601:646:8581:1fcf:8286:f2ff:fe24:931b])
        by smtp.gmail.com with ESMTPSA id e22-v6sm11352461pfi.61.2018.10.15.04.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 04:14:23 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/3] git-p4: improved unshelving - small fixes
Date:   Mon, 15 Oct 2018 12:14:05 +0100
Message-Id: <20181015111408.17618-1-luke@diamand.org>
X-Mailer: git-send-email 2.19.1.331.gae0ed827e6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the same as my earlier patch other than fixing the
documentation to reflect the change to the destination branch,
as noticed by Junio.

Luke Diamand (3):
  git-p4: do not fail in verbose mode for missing 'fileSize' key
  git-p4: unshelve into refs/remotes/p4-unshelved, not
    refs/remotes/p4/unshelved
  git-p4: fully support unshelving changelists

 Documentation/git-p4.txt | 10 ++---
 git-p4.py                | 90 +++++++++++++++++++++++-----------------
 t/t9832-unshelve.sh      | 75 ++++++++++++++++++++++++++-------
 3 files changed, 117 insertions(+), 58 deletions(-)

-- 
2.19.1.331.gae0ed827e6

