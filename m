Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861B71F404
	for <e@80x24.org>; Thu, 16 Aug 2018 12:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbeHPPG0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 11:06:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36442 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHPPG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 11:06:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so4117176wmc.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=OwC5gxNtuzLxOCdLncdyslLefVfueVuGzdEI/LG8jlE=;
        b=t99SXTILTKXtZfC1GWPpxX2t3HnR4rQ0chfI8dbDJfcfE39S3YXc9KJAVbvhRDML1/
         kF5z2lT5qcOpmHAsUiGe8TN8KMay9KyZoACnNKfdHtCqZO6SE6+9Jl1KvwLJaB/GIbS0
         4nl9LMPcirigadeXCDxQc+L/FU7GAKrVVjpQ1IoiN66df7AFNHzmdLZhajM2JXP9DUzD
         GEUTDcDzQMB5F9fPRNBkGopH+HAXgZaZgtV++WDdt8QYs0/FjKa5hqQS7UzpwacPdPM/
         nkXV4FJf0l9u1Ft85T8FTqDCMzwYEqiqDsV3KZzuNHx8l8VazOOuu9077pn6W0Tg1KGU
         Nd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=OwC5gxNtuzLxOCdLncdyslLefVfueVuGzdEI/LG8jlE=;
        b=mADmAYFGyiRB3ANwaHEOUhr4QoEvrxs2Sk2eYlqPle3Hs909FXGlUoQFRL7zcbTvHI
         imtRlcxzIPlrAIqfxQOklkIgzrmhg5bPPGrWJjYPD7IzCYsVDu+EBs2rRT06cLAXFAp2
         L/WZ9pvVGwSC8v2KiW2dEpx3sK59AH2IoHmvs2LjWv9EypJjTckdXW/Rn9TX95lFbRuj
         VNqZhRKrNZsQJs01A2SO4LKZ7zucNaB4Tlz72BWwkj36jXLBRmHOHDplZtIo8NGr3em0
         w7hcyPa0liuH8Li9KIwXlVQ2e8zXGjYBs7Ok647ZoFvvLXF3nHlLyfaQyN24H5IWoxsN
         TvsA==
X-Gm-Message-State: AOUpUlEdeFDiEzUtnEiE8NKcNmokb9kmYIlvdf1nJJj2qCDeviAHlwkL
        UNHwoIoJwogY0pd0uD/MTmqgapeD
X-Google-Smtp-Source: AA+uWPyxBBqCO7eTmDalRPbZk0bJYdJ1SoZtLHCdLHoBQIJicUjyJ5WnIVkbYc3P4hMAIWkH+de8iA==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr16738364wmg.102.1534421294542;
        Thu, 16 Aug 2018 05:08:14 -0700 (PDT)
Received: from agis.ws.skroutz.gr (agis.ws.skroutz.gr. [185.6.78.155])
        by smtp.gmail.com with ESMTPSA id l72-v6sm2959714wma.17.2018.08.16.05.08.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 05:08:13 -0700 (PDT)
From:   Agis <agis.anast@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: git-clone removes destination path after permission deny
Message-Id: <A1C23FEE-55CC-4888-9BD5-1C4566E83A38@gmail.com>
Date:   Thu, 16 Aug 2018 15:08:11 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

I've recently observed the following:

    $ mkdir foo
    $ # try to clone from a repository that you have no access to
    $ git clone git@github.com:agis/private.git foo
    Cloning into 'foo'...
    Permission denied (publickey).
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
    $ ls foo
    ls: cannot access 'foo': No such file or directory

Is this expected behavior?

Thanks in advance,
Agis

P.S. If this is something that should be fixed, I'd be happy to prepare =
a patch

