Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCC81F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfHMM1G (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:06 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45435 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHMM1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:06 -0400
Received: by mail-wr1-f49.google.com with SMTP id q12so17304047wrj.12
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFePMzTdGBgBQgllCH4+lyux9+s0dgmkrXSeYzHwj34=;
        b=Wt0POPkhJx1HywnE2kaoSVuAkYTg8Qvr2YlvsOlRs/Ns+v/0atkTPyqPprkkf6x6Cg
         1dRr2H8cUQOArRnfkXnA9Go/1FQjCbj8tIHoUphMfnzxTzD3dhp3tq4uU8byMyeZXxir
         JdR/Ldn54aghX3xkyl2Lyj8+e+LCvmxU6k98EKwDTSb207wGOWWEDS31o5ztfWh/DHXM
         AYkYwykLKsbBYBRJro35RRXJw0DMmOXjNahCid+cBjGqeJRN4tChBX3CacZi65tn6CGq
         SMWdUhI+OvZgpAZOe4zsDDx3BTZj1fYuUt2GxLELU2Z96dMeq0ThuQPkcb90SuqfzUEf
         Lrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFePMzTdGBgBQgllCH4+lyux9+s0dgmkrXSeYzHwj34=;
        b=giC5KPYxA25bZRwEUnYG9bO77bGwJxeb+RXdKFu8jFSjIgL6wv2TEA3LBzIZ1JmbLs
         ioUtzA2ijWogAL/vQYtdnJm0HpJ2WG+KMkoTm22VoRMrciRh2jQ7aeLquhtgGWk8/gcg
         7GpPSzH8w3McgwKalV56eztX4qYYEC7yi84jeCmniDSANdvOQ/SyGx1BkNCpa2jAc3Zk
         Tj6XwmGCOCSA420ltVUAuMfMDYLLG2novZVXdScz/sBXfVzjh2DU9ouGxzDplcVuBb2B
         zk94xt4/Eg+/Jb2r0kcTYD4+vp/R7ZU6Ain+rhxDkUdFOO6S2d70BB5leTIiLEyaRtDq
         Mb1w==
X-Gm-Message-State: APjAAAVSp0UPPOgkR9TKKJvwV4xCT4Ac5XcRr59Kd9Saxi6ogWeHR2uU
        huJ2P1qPXIcU5ZHyov3fvAI=
X-Google-Smtp-Source: APXvYqzhZi/AULNf5IC9hHDJF7rI03IKj842SWgPKt+kKV9NNJINbN3Ndtk8Zmu98TYTVi2t26d2gg==
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr10606849wro.106.1565699224058;
        Tue, 13 Aug 2019 05:27:04 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/11] completion: complete configuration variables and values after 'git -c <TAB>'
Date:   Tue, 13 Aug 2019 14:26:41 +0200
Message-Id: <20190813122652.16468-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently I've been writing 'git -c foo.bar ...' often enough that
typing our long configuration variables got annoying...

So this patch series teaches our Bash completion script to complete
supported configuration variables and their values after 'git -c
<TAB>', and, while at it, after 'git clone -c <TAB>' as well.


SZEDER Gábor (11):
  completion: fix a typo in a comment
  completion: complete more values of more 'color.*' configuration
    variables
  completion: add tests for 'git config' completion
  completion: deduplicate configuration sections
  completion: use 'sort -u' to deduplicate config variable names
  completion: simplify inner 'case' pattern in __gitcomp()
  completion: split _git_config()
  completion: complete configuration sections and variable names for
    'git -c'
  completion: complete values of configuration variables after 'git -c
    var='
  completion: complete config variables names and values for 'git clone
    -c'
  completion: complete config variables and values for 'git clone
    --config='

 contrib/completion/git-completion.bash | 244 ++++++++++++++++++-------
 t/t9902-completion.sh                  |  63 +++++++
 2 files changed, 243 insertions(+), 64 deletions(-)

-- 
2.23.0.rc2.350.gf4fdc32db7

