Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB7C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLOIiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLOIiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:38:14 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF991A222
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:38:13 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x11so4574661qtv.13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newsbridge-io.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b4D6KCQCy9v/jfKTLxNxEiAGUINqe6JNyw3RmLl9vvw=;
        b=to2ZcIwdE7iHSwtvii4ieYQ/erJi1tM5tcjgNEFtF3QMINM1CikgPB/+4TR0pvYygw
         GKQyKv3BiA9YjkSD7dDqqJinhK7DTjtFmUaCg8EVAr3BLkzge0mR5vQub9NdCz98KUdl
         MRbAMJxCFC7rzerCJDrAFMcm7xrra0G99TdVFUfo24PeapmgcaisNxO5uZ55J5h+ghUc
         UmAUx3EOHhTbLdpwDS6p3GMZ5oRXF8Dovdru1m3hDYqhTvOVY5j0ijyVi8ISMQpscAzR
         Or8hkOuGQXNJL58M+bep1iFDC4drAF3ufc3jFdbwgqNnRcQ1H++nh+sgmWP2YfxFqtrb
         vIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4D6KCQCy9v/jfKTLxNxEiAGUINqe6JNyw3RmLl9vvw=;
        b=PUc/HWpKQIZjghV3ylZ5yhFjBkXQd3oCH/6Hxq0Isv9glnS8IV9OE0FC2FUTiEFiNk
         j1ShAjtfryvv1eCsYyNMF4z5VS8YtyM4KbSHj/JI8Sn2dBnX9htyE98sGtGyrNKjTXKR
         IxNQ9CYGFKhayT9bZjKTv/TfSoAf+7GlEwvGpAye8rGtzI5g4AIK3JDDUIUKpouGa95u
         RFsYb+ZaBTCt3ICM9O7iPZuUof4r5D6pTcce2+zmx3whC1q+wFIk/SxP/Or9bCiCvxfp
         SDEf2ptrZQ4Geczxxg4h1cs+VyDHd7X9k0GINWuKL2Z972qz75Tk4332zp1DSFNbNLND
         jh6A==
X-Gm-Message-State: ANoB5pldd21+7pX5wqMni1I572gAOBeEtlu6zysgLvnr+VzuTwKHoxgV
        3yTm2pMpbA0FlYEnQgFuY0hckrXNyEtIchpZQsqe0iZuRoYd1g==
X-Google-Smtp-Source: AA0mqf4ZB9gm2V4oibIOxuVfh4MWILpHhP0FO0M/jsNKkif2TRnaD863+aX0ysMks2fkNnOK1b2fPRPH56XY58LbLWM=
X-Received: by 2002:ac8:64d:0:b0:3a6:94d0:c378 with SMTP id
 e13-20020ac8064d000000b003a694d0c378mr26784399qth.635.1671093492130; Thu, 15
 Dec 2022 00:38:12 -0800 (PST)
MIME-Version: 1.0
From:   Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>
Date:   Thu, 15 Dec 2022 09:38:01 +0100
Message-ID: <CAOLx1BgQinzZBkHvvmDrGUedEyQa_7ZVsyVGmWjF4gYhxc3P+w@mail.gmail.com>
Subject: feature-request: silently stops ssh-agent.exe when upgrading (windows)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I've looked in the public-inbox archive without finding any similar request.

I believe it is a bit annoying that upgrading git-scm always generates
an error when ssh-agent.exe is still running. User than have to open
the Task Manager, find the task and kill it.

Could you consider silently stopping ssh-agent during an upgrade, and
may be restarting it afterward ?
Most installer do that or at least offer the user to do it to allow
seamless upgrading.

Thanks for considering.

All the best and good end of the year.

Best regards

Jean-Michel
