Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73EA81F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeKTF22 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 00:28:28 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44036 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKTF22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 00:28:28 -0500
Received: by mail-pl1-f175.google.com with SMTP id s5-v6so14999379plq.11
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nRTrMMQxqVGqzwNLH9HLdWlMdC6M5BcTH8fAGhsxF0Q=;
        b=r1S95akKGOSfMd0zeirVGnyhgTTYWja70SuNaPxvvPXA93iz56sDxvTjkndga/H+4s
         F04GiyIrH4G974HXMf8bZRg2DxN24o3+S8CTCUfflkqiZceB6M17gQNORLet/4ypMWjp
         i3AfELYeGlwzxgBN052xZRAdGTT+Kv2fwh4x0xsQtnk4r2gqFNDB/xla1VNtLSor6mIg
         4yB8aG5m7jSU2YooJUC7D+vpfNlc3Ibpj7dte6VEv6XYcHljisJMac5AKsSiB0OSVJ6k
         vmHR6WVD0VtTlnJf3Yyr1zsokcXOz1HgrH2AEjOIH6WYqu9VBzI/iRCObEAbrfCEK8j1
         twkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nRTrMMQxqVGqzwNLH9HLdWlMdC6M5BcTH8fAGhsxF0Q=;
        b=PUjxZhTfatGeSn/YruSrxDbHJ1kXlR+b/9ryc/aGjIISriSsInuZTjYg4Lv9x5TmVL
         I6QlQeasagMoxFeWxakGIL6sA7i8LnmcUm7XbicR+zshGhmIRR7PiRVPPIBGzrorIZVZ
         wI0W8M5Le74hG5mmAEAR9srTeexp9kZAgqms3HieQAiKzC0XhpJwOLUBdrKVlsHPOxVa
         p86cPcFPyPFmVcBQW7mqsLkZwTQpZ4Z2Ii0ZLe6nfDmbiAhABmr5zLmhDeMaP6hj3s8J
         9HcxxRlWcarsh92RHLUdFOb4RSM55gpUy0K2aKk0suZfcAm9SlD8mQqubTI2k8ukGDdW
         886g==
X-Gm-Message-State: AGRZ1gIItu1P2duRnyQdXSjvGqFwa4xVD6g8SF/YX9+9FISz8pbteRxg
        iqEWurCsHjmGpc75AI0oogOM4xUh
X-Google-Smtp-Source: AJdET5fsLTOw+3IzCTkx8r5xQdlE4vV6TICigju4ycANuk9DjkeHlIi4qAv4KVjECeh/75cD8wSycQ==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1mr14008273pli.64.1542654212295;
        Mon, 19 Nov 2018 11:03:32 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id t2sm25158028pfm.32.2018.11.19.11.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:03:31 -0800 (PST)
Date:   Mon, 19 Nov 2018 11:03:31 -0800 (PST)
X-Google-Original-Date: Mon, 19 Nov 2018 19:03:28 GMT
Message-Id: <pull.83.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Use new topo-order logic with GIT_TEST_COMMIT_GRAPH
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent Git test report for v2.20.0-rc0 shows that the logic around
UNINTERESTING commits is not covered by the test suite. This is because the
code is currently unreachable! See the commit message for details.

An alternate approach would be to delete the code around UNINTERESTING
commits, but that doesn't seem necessary.

Thanks, -Stolee

Derrick Stolee (1):
  revision.c: use new topo-order logic in tests

 revision.c | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: 561b583749b7428f1790f03164d0d0e75be71d7b
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-83%2Fderrickstolee%2Ftopo-order-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-83/derrickstolee/topo-order-test-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/83
-- 
gitgitgadget
