Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE3AC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 19:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjGMTR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjGMTRY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 15:17:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018AE2712
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:17:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so1942672e87.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689275841; x=1691867841;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNnVqf6s14dGM33M0/lVLc31fQ3N6QimQflUDfmbawk=;
        b=GmI2LlYl4/9dq8ax1CNXK6N+8ekV77so+n+9Q1c0PNQavlDFdr3LIe2AxhdsyZOZ/6
         O+oliJddlR+CpdNyinjpCQ8UUXYdh64ot4h9796KNTK2TBgxjkzYffGdW0Ibi/W9SfdL
         spO+HYtHqCX1DWU+33p+sCjOs/hvnvHyG9M6/cv1h2gktqvRurnBvGRFoXRTkjfNyZqT
         DZlzIVDuidRBRZ6aHPtZsc9xkqspo9chm5eQO+el65r4y8D4Fj1UHB4tWIkEDFSGVzNy
         tOTHWy1AWjmJ6hORTv8rOAL4Y0bkvPFuXL5u7WBShF2brB79GYzfjptb9QvmO0MG7QVD
         NOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689275841; x=1691867841;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNnVqf6s14dGM33M0/lVLc31fQ3N6QimQflUDfmbawk=;
        b=ipamex7z3uSbR9eSeaXkFXNLupt7VHbcGCVl7OZOdJ0xuNvSoNBCtD2QlfgllHG09G
         9qo/sfZNz3u0+DNMQHmChPkNGaGzUxOUcEVcefg3wd53ZiaMkcGNdbH1BwQ9LgHeuviD
         I5BcaXI0/de3um61unGKzwqNx4yhmt4oTdHg8JJQuiXBFtIh9Vb1BcT2QIBSg+ABl9ug
         S1jzMogHANznj9pOGQoNsBIg/fPyIAw4CwTnFCdjm83EMuYj9fbuB6hiGs23GFwoN3L+
         JMlfXC9EZmVWuzBP5CwfIGynd0iIBygpejzWYDqKhi49s6KSEILyMYPvkkcun8dl5iGJ
         0B9g==
X-Gm-Message-State: ABy/qLZgeNuxWGal9LKqp8KLbIoiLWklkSYeT3eqohSLI6FZts1umEq2
        7QMPzlKpRLi0coP2Z9wop7Su4QxzDaX5J13l+GpYRoC/
X-Google-Smtp-Source: APBJJlGYxeZrw+taWPGR5kf+6966h+H4YGdlZmw/fHgSdajDuY1aMvHApn/d+bWOZw2H9T1xvrzTsxOGZwKKAx2PqbU=
X-Received: by 2002:a05:6512:158d:b0:4f8:742f:3bed with SMTP id
 bp13-20020a056512158d00b004f8742f3bedmr2319563lfb.37.1689275840660; Thu, 13
 Jul 2023 12:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
In-Reply-To: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Thu, 13 Jul 2023 15:17:09 -0400
Message-ID: <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com>
Subject: Re: t2400 on freebsd12
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bump: this bug seems to affect several GitGitGadget PRs in CI, which
also renders GGG unusable for sending mail, IIUC.


-- 
D. Ben Knoble
