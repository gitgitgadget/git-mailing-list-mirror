Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C9FC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F9611CB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhECLQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 07:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhECLQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 07:16:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21EEC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 04:16:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m9so5136292wrx.3
        for <git@vger.kernel.org>; Mon, 03 May 2021 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liveseosolutions-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=NbJS5EUPhoEEPc/STyWdhbyA8RFRMgTQc6QvWdB1TMs=;
        b=PhmWPJIIpiYDOr9gBC3cvAczS3nBH4z4VUXs8sLGnFCqAhI0B0Waedc45vLmnFVDP3
         V3TTbESjbjnv7+nV7S/48NnfBuMXnFKldVVOY+lxQDb67r6FeyQRCiWFB5u+qcdIwyaa
         Ao7InmoO6FcxnqTsL7dZHi/zsvVDBwr+0XcPbTP5GDVQJuWk3L2o4f+Eo5I4qVrZMHqs
         HD0464ptvZjjMqIo3BNwUUQrTRw+p2Gy6FxG+o2MK6n5iwkbxPjb3EMfAefPuQh4xcjx
         YRTQma5z3z4K6q4egMHWY15fIIhM204YStGa7d3UNrk6wwgKrXxa1eNkYPl8cOXViZpC
         MYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=NbJS5EUPhoEEPc/STyWdhbyA8RFRMgTQc6QvWdB1TMs=;
        b=JxorozuBCB1V8sPHuQBIWP+XZvrJC0J4gdXIr3KXRIs0EW2YbSlt+Tj190wjf5gTkS
         LJ0DeRBBndHHpYrJ9+P2K6PXbrsJ6NeEBa50l00iAHBq+2282MLyZCfSCm7l6gX2WTtE
         4i+SMyVuGybbBsmqEA9lrzaLmfETLX2Q7xy1W+SsdzhjReM9RuPCmq6GOiKXo2e6H44K
         7CQpUxPhJn9yeTvDpEM8sfDziikgMY3xxbADc+qd+qhXaPKYpzYD6iTq0zXpZRqln4sh
         swPTgGWEwl/KR/3DN79RfiK3PWCagLEqMQ2ROJ1asCORqyy6feubzbvjEYw0HypcUr2B
         UA6A==
X-Gm-Message-State: AOAM530VzhOuv4LFcb1XgVeyUEstC0M9boD8uHuMYCJmDW47Q0gU5WBd
        KA+Hol6fhGvf9yAwlPrSkqDB/GsrdYBHYW36
X-Google-Smtp-Source: ABdhPJwordrAuRoceqcLEN77BmP/1LJNWX02W0K+uK6Es0YZBgEskZD7sMHCei5qi1BDoOrNdu0l7Q==
X-Received: by 2002:adf:f205:: with SMTP id p5mr15093623wro.170.1620040561091;
        Mon, 03 May 2021 04:16:01 -0700 (PDT)
Received: from 72.255.21.110 ([72.255.21.110])
        by smtp.gmail.com with ESMTPSA id x5sm7850286wrt.49.2021.05.03.04.15.59
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 03 May 2021 04:16:00 -0700 (PDT)
MIME-Version: 1.0
From:   "tom" <tom@liveseosolutions.com>
Reply-To: tom@liveseosolutions.com
To:     git@vger.kernel.org
Subject: Sponsored Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Mon, 3 May 2021 16:15:56 +0500
Message-ID: <65963879446002322012466@DESKTOP-6D13GTJ>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I hope this email finds you well.

I am sending this email to ask if you are interested in sponsored posts.

We are searching for relevant sites and blogs for our clients.

You will get 100% top notch content with 1 do follow link relevant to your =
site niche.

Please let me know how much do you charge per post=3F

We will pay you through Paypal or Payoneer gateway as soon our article is p=
ublished.

Looking forward to building long-term business opportunities with you.

Best Regards


Tom
