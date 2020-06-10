Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD5C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B64206F4
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rams-colostate-edu.20150623.gappssmtp.com header.i=@rams-colostate-edu.20150623.gappssmtp.com header.b="Xyu5amXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgFJSJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgFJSJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 14:09:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E678C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:09:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 18so2855569iln.9
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rams-colostate-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=Taxp7bZEUtMGw1r8nAB8dDZlvpQadxGBIAT3jwMlwl4=;
        b=Xyu5amXWW+ZxqvqjP3zpIP+myTfsa9ghbIwqc8hpVqLbRy+h8aytRkKe3O9ahgAY6+
         BX2o5bdGm7D4tHdmpvtU1I81k2tL3bY0XtTCAfnWv6dWqT2zp0mXpA2q7yxJjVUqEQZd
         fETSs9EXgQj1l5d5Pwz75MEmcYmoKNNzUWhdx+eE+vNNb1L96PDcimLZPXD/ednSP3Y9
         PDE7xhG1k9DdigeIvIuQ8aeQQyN9tuB8DTWgMXeEWM8Ca+JKxY8+N6iiAaa5tmLdA2FQ
         yLsxAp+j2whxfeEcqkY8UbTALGb2GaLo62rPnmaONL/fjLCnt+JJfSTTgJBOEOyc6kSn
         qYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Taxp7bZEUtMGw1r8nAB8dDZlvpQadxGBIAT3jwMlwl4=;
        b=AcXxIe/lFZMsFOtLqSvS7BmFdm4p9UccqWN/Uc8kzOfgrQ/onHawlrTCYxbpMZAhQh
         nC79yFUUkik/M9k8WR5fjt2f5kC1u8vT6NYY9LhOGqYd9Tpw6qySh9CAX9X9HHkxD52M
         s7DOb8x/QVCAJD1yphboMWzXnl33sovCNCyk1hzVkTsKYskeLiNvjXV9TtdiQ6tK+YdO
         DpgUBQbip0hSt31IeTqV8JNZAqRwN1RJQmr6R/BZeeI6G7s0ZwbQkdxuezKOAXP00iO3
         6IFdY4elXqbC0mUh9FBKl5WdIFjRbmB5LJPoLuU/Ip6Iod7dfpi0CRMUP65Chm2O6nj7
         WmRA==
X-Gm-Message-State: AOAM533a6XMs6nLZcS4Ce12+Y058PEVqM60eB+a6/5SouKUrqOAL4/+w
        BN4OTPniCKyMpXkkEDFYWPU0UO0RvV4=
X-Google-Smtp-Source: ABdhPJwKDIzXl4nYxRyLawxT/5Wo4QLUv0ZmR9CGqgF1xjtk244iSk84pVaduxyMCIZqdd/nSyFjmg==
X-Received: by 2002:a92:d3ce:: with SMTP id c14mr3845448ilh.62.1591812587399;
        Wed, 10 Jun 2020 11:09:47 -0700 (PDT)
Received: from [10.180.91.128] (host-110-24.cofcdis.ftcollins.co.us.clients.pavlovmedia.net. [68.180.110.24])
        by smtp.gmail.com with ESMTPSA id t28sm306589ilb.49.2020.06.10.11.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:09:46 -0700 (PDT)
From:   Jimit Bhalavat <jimit@rams.colostate.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: GPG Commit Signing Project
Message-Id: <E7E8DC8B-BB7D-42E1-BD0E-EF59775B9E75@rams.colostate.edu>
Date:   Wed, 10 Jun 2020 12:06:07 -0600
Cc:     git@vger.kernel.org
To:     gitster@pobox.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good Afternoon,=20

I am Jimit Bhalavat, and I am a Junior at Colorado State University and =
my major is Computer Science. Recently, I accepted to work on =
Hyperledger Git Commit Signing Project through The Linux Foundation and =
my mentor is David Huseby. I am writing to you in order to ask you if =
you are the maintainer for the GPG Signing Project?=20

Which branches are for refactoring/new features in the GPG Commit =
Signing Project?

Thank you so much. Have a great rest of your day.

Best,
Jimit Bhalavat.=
