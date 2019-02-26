Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B543C20248
	for <e@80x24.org>; Tue, 26 Feb 2019 05:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfBZFSP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 00:18:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42459 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBZFSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id u7so4310364qtg.9
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 21:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=erOxxYzSC0ZYOOLqx/nqefV3u2RFvLBb2D6uWuYqnZ4=;
        b=iqxGBa/WHqB2PSNYSAizuef+Z5EBFT8knTqzcFvovSmq4CMZvfKWDlibMzeSD6vy75
         mGH1wS697+D6uyCeEiO+UG2PIV8gklU0oT/4tZxyyVNvCjczB3YMWFWn88Rxa/i9QrTe
         ndBTk2C7nRM47uMit4MgcE7FpxDkg7Ony2VkOwTwEZxqa2ZbrZTvsuj2uGX0pYMItowA
         Q7uQ1OyCwgtfVsbAdcu2BeAERdeTGfFXDoeHkmK9hVxm11gQcNTCv+8/evWZr1X0jT5U
         dIDneQYfNCnaL/hhXYhSEorhVcHUuDfuRAmmN7daD0m3mbjS1umsAuPD9Q9IP3OEini0
         bk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=erOxxYzSC0ZYOOLqx/nqefV3u2RFvLBb2D6uWuYqnZ4=;
        b=Jyxrw8ycgCq7NhELnUR9fpMaWOX4fL4SAaJG49J3IHLIn07150W+VLRchMJEch8S78
         hbb9k2iEmOh8FZLQROk75IvwPG2TGC6KvIHPTpOuG7z4WDVs+3Fde8B22cgUz1ZjFkvv
         A/DseeLV2yRPUSn310+98T7fle3B7PmOhNKFVSs23aC0C4f25IYEKzK6cee2T2+uNbda
         4HSvSqBBKQMoI7F0S4xF1A5MAek9ZntQZC7C7X+c/bwzQyP0esvskg1Wqp5meg7tlZru
         j2gaRDpkSnF7X7icAxJ7iTv4/VzuxITxTWoTB4M3Z87cUp7h4gq15kf8mUmUcqsOk2/w
         5oeg==
X-Gm-Message-State: AHQUAubK63jo1DsRAuUrhEPvuWGcgSt1DBATqC/09eE0U7/IIFSuVUST
        09UIFSO9jHhKAZuQBOMg9zbDdmmCJpc=
X-Google-Smtp-Source: AHgI3IbK1hN7TNCQcqTY9JdOJSiYv1FcWj6SWujPYFgMwViNJTj0PqOJIP7vwektaVq18qESxd67Uw==
X-Received: by 2002:a0c:b527:: with SMTP id d39mr16677383qve.201.1551158293777;
        Mon, 25 Feb 2019 21:18:13 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id k39sm7698738qtb.37.2019.02.25.21.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:18:13 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>
Subject: [WIP RFC PATCH v2 0/5] clone: dir iterator refactoring with tests
Date:   Tue, 26 Feb 2019 02:17:59 -0300
Message-Id: <20190226051804.10631-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar sent v1: https://public-inbox.org/git/20190226002625.13022-1-avarab@gmail.com/

Based on Ævar's work and comments, I refactored my previous series[1],
so that clone's original behaviour regarding symlinks is kept untouched.
So, keeping this behaviour, having tests for this, changing local clone
to use dir-iterator's API and modifing hidden paths behaviour (which we
agreed to seem like unintentional), I think this version addresses all
the comments and concerns raised in this thread:
https://public-inbox.org/git/CAP8UFD2xrfMHNxcmeYf8G+d53SL26N07FFAoDP+e0h3r-tvKQw@mail.gmail.com/
And also addresses the comments I made in WIP's v1.

[1]: https://public-inbox.org/git/20190223190309.6728-1-matheus.bernardino@usp.br/

Matheus Tavares (4):
  dir-iterator: add flags parameter to dir_iterator_begin
  clone: copy hidden paths at local clone
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal

Ævar Arnfjörð Bjarmason (1):
  clone: test for our behavior on odd objects/* content

 builtin/clone.c            | 70 ++++++++++++++++++++++----------------
 dir-iterator.c             | 28 +++++++++++++--
 dir-iterator.h             | 40 +++++++++++++++++-----
 refs/files-backend.c       |  2 +-
 t/t5604-clone-reference.sh | 69 +++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 41 deletions(-)

-- 
2.20.1

