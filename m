Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23794C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D599964F18
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhBYSnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbhBYSmU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:42:20 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A6C061574
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:41:40 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x9so2309471otp.8
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ybiX7jEACpbXRlYXVzFwhqGEtRlF/I6rYPMVNN+rq2A=;
        b=QafwuIcvpUp2A/tmsRrKb6OGRAILnq5jL3RZ4dXM1BVc1UI8TBdtPWzNftKY9ZA2ra
         JdgcIgpzjIXK4hBti5RF6GJ20iIvQB4ZAdt6Q1ZUdqKNF5mDj63KziZztlJizx0K+skl
         TdNg9SdZacu6tsW9CuZ5cd00EbLUgdLG2EZkpYd0rT3weO6d8A0fpJMKZmSH697CmzKR
         pT8P7za7hY0Gu9as9MKHCaxc9q5yh2PX/kG67oVO9Qm58sxvYVs8TU4gCF6r8/gZPYoH
         PyFGIbDrqpdelgCFyg/WLsyU+inszy6aE8jfaTbNCKMQUA/Wv/VWvIgcOlwvahi5YcRP
         y6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ybiX7jEACpbXRlYXVzFwhqGEtRlF/I6rYPMVNN+rq2A=;
        b=sw1OnosDmZhbcJLj/M38FO9iZL4lF21ITmgBcZDpGoeIE0H9ABXI08yO/AyfOK3XQk
         w8LouT81msFCHtX4yHGoZykSg5MbMBNzHh8ziIFaSNvhIPWkIqJMOII651PuhwY7dgfh
         l8GY3UoNZxi2d4kVfGdc3d0+ZVVp1Sq8mD1qAvF/XWf033p2B0DhslFZL/Aris9ha0uG
         BBkdRx5YK4r6eiJpM0BRHcfSfiQ6b0X0PXQAMt3lS6a+PsYleLXazLiJAmQdP30T3lSH
         bsfiAB2/Ta2s68EUrFSQDqYXkGWRmIujLiKFfwP4vRyJKTGsQnOx/1MLxu2Sra/PYkFD
         atNA==
X-Gm-Message-State: AOAM533/ciCMUjF/k3233/ulTdoZh08PMvTXOJRFsXGCSDOwv7ntrR3V
        4zCSdK5anXzRbK/P3e9iupvyG32DA4YiesKMnNt6hcQsYnZK3Q==
X-Google-Smtp-Source: ABdhPJwUEIJzhRexXtSJBh0aHC6T5T0o7XqoxY+aSVACeYmpnItAKAYG9Yf85w0cKOIVaVteePNtjxtSAlQpYS5w+E0=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr3483896oth.184.1614278498725;
 Thu, 25 Feb 2021 10:41:38 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 26 Feb 2021 00:11:27 +0530
Message-ID: <CAPSFM5cABjXW6wX06j1-OpCdhXrQJrHamzAUUCXp8FyyRm69kw@mail.gmail.com>
Subject: [Outreachy] Project blog-10
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone !

Here is the link to the blog post regarding updates on the project:
https://charvi-077.github.io/week11-progress/

I appreciate any suggestions and feedback.

Thanks and Regards,
Charvi
