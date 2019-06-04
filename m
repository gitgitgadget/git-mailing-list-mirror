Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2127A1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 02:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDCNc (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 22:13:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33889 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFDCNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 22:13:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id l17so18104253otq.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdeQySvZBJFZrTnhaASYeFHK+qoCUGQbixoh83PrJMU=;
        b=t8FyMxJd0PLp9gry8NZVEMxUbN1P/B/7ALtIr1TBiHv8bwdSpj4zvWJzw43InTMl45
         6dC7iPWfIb39rY4pNGCtIlUAa6WCZHEJxGxpgPrr4LbiCqmxcTqdLRsWWitYsKsPxLtN
         a5LvCFNJ5Vk8Zx7z4LLD3gPwbK5gpZ8H7Or410n2iEvsA4NbdpG2v1yWl87C9syxiAnf
         h654BKQFMFEikCap+RU36i7bXFa8QrLjelk2pE3cYhub4oKJuWsMYUjudyjV43HNrOim
         EWfq0ChDwdUUd5+ulbJ0udUsN3pvHZbQ9B7/m+CbaDZE3GBMXrrbaaNZxxb7det7y0/k
         u/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdeQySvZBJFZrTnhaASYeFHK+qoCUGQbixoh83PrJMU=;
        b=BnVB1KsRVJ237Ns8kBaMebyiCgI2K/aRsWrFVwBk2K51JFVdteI0cXOKh2niJsVEfJ
         Qunui9GBXUA4S1VQNFzCEUn9kKWFcbNA8Lmw/Gh50p7UTbCEfxWmjTCbRAELnedt+bRq
         IGXn2dwdDKRiOv5rxBdGOg8bDJiIn6NCxDa19fG9MjIlPZa5UR3Xo1K9L89/hXOdEJRH
         OMXUo9AzsYwikIsDwmvPybCRE8kZZ+Zly0sDdbqnVU69zzjcpCYoJMmtgK+NosgZ0HOy
         ZMNJLy1LqflY2fAN1rVN25suxhpbq5BrL3zV0olJTIvtZDe1oECu9gpyPTiIrzFNY6j8
         DH9w==
X-Gm-Message-State: APjAAAUpwoip6YCWial/VZ0PeALmOOi/EJFqAbV7f0il5k0wJg3FYuY2
        LMlCyLw12VV/YAoBNGM5FPUsi8xa0IQ=
X-Google-Smtp-Source: APXvYqzmNzu/vC8ss8+bzvR87YZWUn+zdyz6e43z36+OZZ4NBMAHLiBOR92lH+5valTjm7qNeCrDqg==
X-Received: by 2002:a9d:704f:: with SMTP id x15mr3180715otj.297.1559614411776;
        Mon, 03 Jun 2019 19:13:31 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id e200sm7312669oih.6.2019.06.03.19.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 19:13:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
Date:   Mon,  3 Jun 2019 21:13:25 -0500
Message-Id: <20190604021330.16130-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed a regression with running tests for git-remote-hg; can't seem to be
able to fetch tags.

Probably all remote helpers that use the import method are affected, if not
all.

The following patches are meant to test for the issue, fix it, and get some
cleanups.

I'm not exactly sure the solution is the one we want, but hopefull it gives an
idea as to what is needed.


Felipe Contreras (5):
  t5801 (remote-helpers): cleanup refspec stuff
  t5801 (remote-helpers): add test to fetch tags
  fetch: trivial cleanup
  fetch: make the code more understandable
  fetch: fix regression with transport helpers

 builtin/fetch.c            | 28 ++++++++++++++++++----------
 t/t5801-remote-helpers.sh  | 18 ++++++++++++++----
 t/t5801/git-remote-testgit | 22 +++++++++++++---------
 3 files changed, 45 insertions(+), 23 deletions(-)

-- 
2.21.0

