Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603A0C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176AA20678
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cps8FFH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbgJLNvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390164AbgJLNuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 09:50:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16BC0613D2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 06:50:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id l2so18486640lfk.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=u2Az3yUO7GI6ngWYwR2B3FZ15sGs6MrEfM2V+DBqmuE=;
        b=cps8FFH63gAgKAr/qxJf4EB5crWg7uNp5GfcDHHS9QZXvryaMIFnlxf+RYoQrAWqDL
         wCDijAHvV//Guuh5+KWGADXHnf/yKwhqtpXnTg0bEa1hYhCMq6VyWOBShiC9dwFgU+DV
         bi7S9sKLQ7Z2izE1NZXHEYxARyrP713rX9CNrNrStWy74itQGpJKc57hG2pGrMmZoei2
         TFH343vOZT4S7MWP8nN/FU7NDbctuLLT89g3OrteKaHFWJ4YkUZChr1i2D63flmWxRoO
         oQHBuOCxLzquhwAXHb48NLjgr+umZyc2nAWj2GICXbUOTUB6Z7cXaLHYB3gr+ebwlNBv
         L/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u2Az3yUO7GI6ngWYwR2B3FZ15sGs6MrEfM2V+DBqmuE=;
        b=I4AO3/hBwlg3k26DTpyVAa6elyeBS1t3RJUGx8nQX4UzeaS4Fzvu45GX7FVBQQOsTk
         ZAxQw5Y/A0B9d8dCqG8jVGBgiwTdu9Xogzc6/+wXJxWxOQYJ5m2SXHcVlGwL01RpxMZd
         Pu6rN4oWQh0MoGerkbDqm3f48HiK7ZNOaHLFo8dsqkGplmqT+yf+MdgVU4WC2/gQ1dNl
         jQnPcKaYcTWga/otSstNbX4y0K3d4fkPiPmBI5ZRDcpuQucEl+OCTYUQJ5TvBnb3evTO
         y1KidBfI13Nt0Ly7ZLnuQqCMtrpoA5iXFFUsxc26IJGICTWCQr+k+yzRiTRjVgV84SYR
         4Xiw==
X-Gm-Message-State: AOAM5319g2oiMroAjEmQaIZsqchOMbQs17UDM7B6afeVjdbv0brhwH++
        ZyI9pdkKbBeGk9caQHPDnGOvAmvWvYKKbzX2qr9jYnaQlGZpYg==
X-Google-Smtp-Source: ABdhPJzapIX045nNBa7rY17qs5v+C2HEYsL0pp9decnm3wks11HfF1bHhvzC7MoRfLZE06sPeOA38B/Oj1P1JT7rV6Q=
X-Received: by 2002:a19:8256:: with SMTP id e83mr7664497lfd.530.1602510653213;
 Mon, 12 Oct 2020 06:50:53 -0700 (PDT)
MIME-Version: 1.0
From:   Deepak Patankar <patankardeepak04@gmail.com>
Date:   Mon, 12 Oct 2020 19:20:42 +0530
Message-ID: <CABmmNJOGBdEO+AT0_8dSwmFxomFE7A5x354+YgfxiU5N+mOroA@mail.gmail.com>
Subject: How to Verify the Git Credentials supplied by the User
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!!

I am writing an application in which we will support git integration.
The user will provide us with his/her git credentials so that we can
push some files on his git. The git credentials which user will supply
can be

HTTP (Username and Password/ Kerberos)
SSH

Before saving the user credentials I want to validate that the
credentials entered is valid.

The user might be using GithHub/BitBucket/GitLab. I am trying to find
some git command which I can use to validate the credentials. Can you
please point me to some command/logic which I can try?

What I have tried?
I tried git ls-remote command, but it requires the repo name/url. In
one of our use case, the user won't specify the repository name
beforehand. Because of which I am not able to use this command.


Thanks
Deepak Patankar
