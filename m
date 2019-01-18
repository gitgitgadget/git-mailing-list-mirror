Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C3B1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfARJuS (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:50:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40337 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfARJuS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:50:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so10642488edr.7
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ApSa0HbMprkFrbJ4zcTzMF2MqeAUrUIk1djCAznN2qw=;
        b=K0cdP4ncddPauIqa8qTdG8CoQOKmOcfCAN3guky4cV5HkS0/oZ+hnYHTg4n8GBjnp4
         IPFLs/3m/8X2BLfFbTq6LgNazXhVsw29zxP9VZEuh581UAVFElP7QXErarsAtKqWzEq8
         c2nkSIu1uZp1HwlcCWOB7MTYNR6hAJ28rIaQIwwqA0Aylc84POcy6jDMgSkMeNAigv4N
         LDMKJOTgAXuGdwIeRGxma5Mhu4PfAnpwqp50+t0ebzANlbTDxm2VNWAIUNEdJvPlvhOm
         jNt3e2LSiqUk+MbAxRXObiNSf14gvQWrSR/FH7gu4B1lSTYLHAzuRPMuHBBh0CgPuGp7
         NwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ApSa0HbMprkFrbJ4zcTzMF2MqeAUrUIk1djCAznN2qw=;
        b=FmWw8rxfAISxcVNdmm2PtJ2UtK2uvCv/e1eqFY23BbpabF230LrdlTI3rBG0VULH48
         aOIOxGix23I3nmKtjv20SVRJwfU8KL97Cv1UK5/0KTl8jaXJ00aQwjUvPRtjSb8N5Q7N
         An6E6selxb3KRlGJiGSuDV2YLA7K5ZKgrI4AGA8h8p/pkpus3OJIvKE+h6Vm5bjL+wcA
         6VeOXXbBqs07kCTq727Pljv3UjkOtpnLYL7lVatI4ALuaaN2HV69C9VNJ701tYX6rsAj
         MDhg0/PtMf2jwmZ95xRcvqkvmvbKNrquWM3adhmFwIn6JkZS7Z8NVCvMhMxAHGeOgg93
         WYiQ==
X-Gm-Message-State: AJcUukdWWrXCXVDgHsO4vPOZeMgjduki9C7Ye6bxFHqvqsov/2rgCxVx
        MrX2FckpjgkGA720R5JDtjF8d4kY
X-Google-Smtp-Source: ALg8bN64t9EhCFoXKW/YBL0U/dEif93HK7/OGXz6+hqN2KY+AdD54u+TD10CW9APT/TkRX6apENl7Q==
X-Received: by 2002:a17:906:51d4:: with SMTP id v20-v6mr13782258ejk.184.1547805016448;
        Fri, 18 Jan 2019 01:50:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm3869719ejb.53.2019.01.18.01.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 01:50:15 -0800 (PST)
Date:   Fri, 18 Jan 2019 01:50:15 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 09:50:14 GMT
Message-Id: <pull.110.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] built-in stash: fix segmentation fault when files were added with intent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git for Windows offered the built-in stash early: in v2.19.0 it was offered
as an experimental option, and in v2.20.0 it was enabled by default.

One corner case was identified
[https://github.com/git-for-windows/git/issues/2006] and fixed
[https://github.com/git-for-windows/git/pull/2008] in the meantime, and this
contribution brings it to the Git mailing list (with a commit message that
was "lightly edited for clarity", as they say).

This patch applies on top of ps/stash-in-c.

Granted, it fixes a regression in that patch series, but as Paul is busy
with University, I would suggest accepting this bug fix on top, just this
time, as if we had stash-in-c already in next.

Matthew Kraai (1):
  stash: fix segmentation fault when files were added with intent

 builtin/stash.c  | 3 ++-
 t/t3903-stash.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)


base-commit: bec65d5b783ef5ce4c655c26ad8f25c04b001dd1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-110%2Fdscho%2Fstash-ita-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-110/dscho/stash-ita-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/110
-- 
gitgitgadget
