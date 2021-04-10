Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJ_BUY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404ABC433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 22:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E43610E5
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 22:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhDJWtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhDJWtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 18:49:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB55C06138A
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 15:48:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s2so7111398qtx.10
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ampliffy-com.20150623.gappssmtp.com; s=20150623;
        h=date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jykGrU5P8idetVgKdzwIrjt7HfIbGzNbdFxsgbxNnx8=;
        b=rIow3mW6Rh5vwdll5quPfi0IbWJctZ4RU8hpxnDyhuCXwEdAGFspbINx33l+XwvHUL
         TG6oPpk9d+1hqpoBJal4yOCD9eXQ62qW5xuzgruwhcWPfImXbnjVZ+OXuPiIAIUVdMCk
         cm3l04ejBse/RyyoPOpindZv5KRK/GoHS70XPj1OG/Lo1LvHP97bIv34OSgTSzg3NgYi
         N5ybwDSu0TI/MAEQWTI8W6n+NZUqVrZzX6f/OXg+8A6IRfFG+d/F7e5aWNrU6Y031kVY
         098Qr2ig7sTJs7b9Ye/zW9HYOhv0G4GKP3ny8mkwB4esg5suIm8C/XiQS4yCGLWtCO1e
         +P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jykGrU5P8idetVgKdzwIrjt7HfIbGzNbdFxsgbxNnx8=;
        b=AnJx0caYBNl9YnJ2dCu3VCh76cN2re7RMp1ikVYhfc5sBbM4eST3PBbGrxwTqAU1BF
         jsPiVvzGuIMvplzzMVIqMVyR7ExxpeXMCR2PG4mRdpqPW93M8a9YWAH+8YB4R7JYJ8dh
         QQWC/cPMo0yGz6QKSQcT9p0OSW/OKEd/f28odHH+B9/065c2N6azGM1fwgK4SYl5hsna
         8WDxux4UjZi9cep6cQSpCnCsRKJ90pavTMqwcst7qYNZ4ZOpgn2ahqhHnzYWDBuuGMSP
         DLNT8HWpe7n6owRFKslREDsGHx3fGl4GB/hukEumLsy8f6eeWSnfAxFgCfjqMmVvF7ot
         siQg==
X-Gm-Message-State: AOAM532sXrlkiOxm3HTeW1pf8WswG6o5eyn6+ewNpOQaXJJheJLeJObo
        vr37g9Hrcvxhs25Il/b5bbVOfoZSbyIpuQ==
X-Google-Smtp-Source: ABdhPJy8L7GblVV5pEl6ftvmdU9Q5IeF9HD+RhY9wlsgEeHE3avodZfn4MSd6qn79My1i0qEu7e5Uw==
X-Received: by 2002:ac8:4f06:: with SMTP id b6mr19431191qte.255.1618094927399;
        Sat, 10 Apr 2021 15:48:47 -0700 (PDT)
Received: from intranet.smilethink.com (ec2-34-201-120-238.compute-1.amazonaws.com. [34.201.120.238])
        by smtp.gmail.com with ESMTPSA id f9sm4755001qkk.115.2021.04.10.15.48.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 15:48:46 -0700 (PDT)
Date:   Sun, 11 Apr 2021 00:48:37 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Diana_Gonz=C3=A1lez_-_Ampliffy=2Ecom?= 
        <diana@ampliffy.com>
Subject: Buy In-Stream preroll video
Message-ID: <2f150222b53757741e12e0d6aadf1d20@intranet.smilethink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello ,

How are you? I hope that very good!

I would be interested in buying preroll video advertising on your site.

Who should I talk to to explain how we work and explore a possible agreement?

Thank you very much for your help,

Diana González
Media Buyer
----------------------------------
Ampliffy
Access to a Young Audience
Barcelona - Madrid - San Francisco
----------------------------------
Email: diana@ampliffy.com
Mobile: +34.611.693.613
Skype: Dianagon90
Site: http://www.ampliffy.com
-----------------------------------

