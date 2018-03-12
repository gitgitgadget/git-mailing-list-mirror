Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADC71F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeCLCIP (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:08:15 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:46398 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbeCLCIO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 22:08:14 -0400
Received: by mail-qk0-f170.google.com with SMTP id o184so4745100qkd.13
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 19:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=gj4oTawGUmPcgLHE1qMGJ7GqqLajXZoU8hpfCO82+Io=;
        b=Md/UiwHyZUxW+oFDXaNpS7hA1/yfqGtqkDhwp1xHWWGOzfrB3oMTeAu5udJSsvtZex
         G/Am+f4wa4nhs3rgFsobM8pfwjeTOEYC954/9WH31tOr4QSOYKAMztxPacLREED2uQy1
         /65Ww5dVja96gx40HxF9PsR1Aq1djOBr0+HznlT/Fwg5ABrJlRJm3/pNwxkosoTK8noe
         ZLfB1JbryGWy8zK9swqhmzC8y72I1xo8GaUhCwvGo3pLocalt15q2XuSfmmmE+l8BLaL
         P44fRyFEDUKMxq23jjbEb1PM7qJOtGgvYDugXjz59NZgpOdBVGNZCk/Kw20ClzYuAqmb
         efyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=gj4oTawGUmPcgLHE1qMGJ7GqqLajXZoU8hpfCO82+Io=;
        b=K1OfqDz8rngVIOOjMgDAISTLqggqrOVJT7c68QbbsbCrHI9oMn+OzHQlMDmE/ubblX
         dmUaP3u7U4Taql9foLWOCeXsgz2cJ00LBt6B2dkma5aIbfygDQvuOehwbmRUN5cCszvr
         jY24D6Y7sjBwADan0wDbOS1X4JuticAg0Nhp15/vOyVGl+jMWzBs6E5DoqBK1xFes2CY
         6m0gOG//1mtnSqyJg6n5kWJKkc3PM8LQE1HmJptvqzRv9KEKYedCFlq1/HgbmsZOuay9
         u5mG7xA8Q02vIJByaMBEoboA91r88+JR1Kn7wMckEu0zLXMoQRv5vYz5eSSZqFdfQaUZ
         mVnQ==
X-Gm-Message-State: AElRT7EbsHYyPwz8fgECNhRFq3Ip+5hkW3Bv3YGTSD/cxh80iy4m++6E
        KZbmUEgRaXp9QsE8g9v27Vkt1Q==
X-Google-Smtp-Source: AG47ELsJ+L1PGiu41e56voiMQ0VcrrUDWRdxIgEFa8w4KKePOEe9nbCfU1IS2v8OCmUFH0j3UeWLcg==
X-Received: by 10.55.71.201 with SMTP id u192mr9117145qka.357.1520820494084;
        Sun, 11 Mar 2018 19:08:14 -0700 (PDT)
Received: from viet-VPCEA32EG.hsd1.pa.comcast.net ([2601:4a:c102:100d:4cb9:45fc:db31:c0f9])
        by smtp.gmail.com with ESMTPSA id i15sm3623605qta.18.2018.03.11.19.08.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Mar 2018 19:08:13 -0700 (PDT)
From:   Viet Hung Tran <viethtran1620@gmail.com>
To:     Git List <git@vger.kernel.org>
Subject: [PATCH] git-ci: use pylint to analyze the git-p4 code
Date:   Sun, 11 Mar 2018 22:08:12 -0400
Message-Id: <20180312020812.7883-1-viethtran1620@gmail.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new job named Pylint to .travis.yml in order to analyze git-p4 Python code.
Although Travis CI have yet to implement continuous integration for multiple
languages. Python package can be installed using apt packages. From there, pylint can be
installed using pip and used to analyze git-p4.py file.

Signed-off-by: Viet Hung Tran <viethtran1620@gmail.com>
---
 .travis.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5f5ee4f3b..581d75319 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,16 @@ matrix:
         - docker
       before_install:
       script: ci/run-linux32-docker.sh
+    - env: jobname=Pylint
+      compiler:
+      addons:
+        apt:
+          packages:
+          - python
+      before_install:
+      install: pip install --user pylint
+      script: pylint git-p4.py
+      after_failure:
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
-- 
2.16.2.440.gc6284da

