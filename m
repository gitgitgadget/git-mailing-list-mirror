Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B767A1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 12:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbeFNMbS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 08:31:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34591 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755064AbeFNMbR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 08:31:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so6263325wro.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCOhb2PWPnjh8plvwrf1328OMapONo5KID3r2h1CkNE=;
        b=L1aVygJzKduv5Fb/BUdU+yuKxnKoYBJ7yOirx8gSAeNndYyVvhxZBr8w+V5/SmCU7X
         w1HWQo8ScoL7eUnQ/667kmQwRybRrFzDOR2+R8XqT25ERaczI5F2g+j3s2C2ySXtpclQ
         tnsrVS4tKSM1EQ+1Ksc9rvzt9yj1NxnRUUkrCsje7XVlO1ZCyyXvYH5MfceWAw5R824H
         rg0xfghI5ZFXCmFDTZgIYaAxuhXbBkc+6PQYil/F7kq2mt99Ubo2wrlh+BSiu5eHl8Pl
         vusuyWtDtDMIK5H2u7CWKtRqEWtcbTeLH7yrVNF8ECYeMTsIekR8kCBMXphXTorD7kEr
         2Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCOhb2PWPnjh8plvwrf1328OMapONo5KID3r2h1CkNE=;
        b=h4zSV2QuQTPXZPm6TBYLYPO9R6CXWuscoFDykGO+cZtST9CF7bfGkma0KgP7ybJd/P
         qC4nTo32cbsJpWFKwhjdSD+aSX+e0dpRjXjXqrsJoHP+Bj2iR0aA0eq80Cr3IRxWesrk
         ubak/gJonALWZDDTOYORe0UScMBBRe+bXagUBuWi+6KvBeHUBsS9EyPZ0r17Zz5On3tq
         qPewnQerSIjRjwbcaIJkvldqlJQww0LfLd74XEEhX4ynYb/72XpyhSeQfZEnjwRNnmgR
         ipevF7Vqm7LGc8tjFkSnzi+0N19vXs+VWfK6ztKw+5/iqclh38KmJ2ap6EWbUEpX62tM
         gw8A==
X-Gm-Message-State: APt69E33V3F6iSn3rVXybTT+tAdIQO3enQg/qgCPoAmAube8D9MZJWig
        m5e9UDUMfGe2AEpWH2BdsXQsXA==
X-Google-Smtp-Source: ADUXVKLxKrkDo9pfD1EpCkcsDeDpXC67ZMuraPS9F5HP7zTqfl2TNRvj5ovWH2DcSqmtUjBwiYuf/Q==
X-Received: by 2002:adf:c104:: with SMTP id r4-v6mr2193291wre.203.1528979475932;
        Thu, 14 Jun 2018 05:31:15 -0700 (PDT)
Received: from localhost.localdomain (x4db06284.dyn.telefonica.de. [77.176.98.132])
        by smtp.gmail.com with ESMTPSA id w67-v6sm6281497wmw.0.2018.06.14.05.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 05:31:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 0/4] Fix occasional test failures in http tests
Date:   Thu, 14 Jun 2018 14:31:03 +0200
Message-Id: <20180614123107.11608-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't5561-http-backend.sh' is prone to occasional failures; luckily it's
not 'git-http-backend's fault, but the test script is a bit racy.  I
won't go into the details here, patch 4/4's commit message discusses
it at length.  4/4 also fixes this issue, but I'm not particularly
happy with that fix, the note attached to that patch explains why,
along with possible alternatives, hence the RFC.

Even if we settle for a different fix, I think the first two patches
are worthy cleanups on their own right.

SZEDER Gábor (4):
  t5541: avoid empty line when truncating access log
  t/lib-httpd: add the strip_access_log() helper function
  t/lib-httpd: add minor and patch version to $HTTPD_VERSION
  t/lib-httpd: sort log based on timestamp to avoid occasional failure

 t/lib-httpd.sh              | 24 ++++++++++++++++++++++--
 t/lib-httpd/apache.conf     |  5 +++++
 t/t5541-http-push-smart.sh  | 17 +++--------------
 t/t5551-http-fetch-smart.sh |  7 +------
 t/t5561-http-backend.sh     |  7 +------
 5 files changed, 32 insertions(+), 28 deletions(-)

-- 
2.18.0.rc0.207.ga6211da864

