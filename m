Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF52C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51446144E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbhD2Rni (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhD2Rni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 13:43:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC3C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:42:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so47658535pgj.10
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Cc1aVkroNzfnWdE0aUiZH3TQ0p27L7SaZolMeWXJqHQ=;
        b=n9imdoyhB3OvpOk5+19sOXTHPtRkv7fTr34hh7NyWBEwqyovgiT9w0YjddmbRqJBBZ
         PXvSvOmTescDiY082wSiKWXHesoXE6O8l8wdNubzgSfPVUKZM7Wz0Vgc/IVIBIatiAKG
         BcMnz1ZBJL7OzPY9T2PkRq5FV8WjbnK4okayCfd8Kwpj24bg9EaBYYCFoAD+g2CVbXwI
         CSGgeY8n4XdnBpcODPP8FU1FXqHQFFBu30Em5RVZ1egQQY55heC0TTK4MUX8mTn2wkci
         P8o4pgO9wy6ykX38+m6Nt4MnQ0ouLwzMFrtlcwFNURl35DIH+LHrEbIlvgkLF9NLcIyu
         6dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Cc1aVkroNzfnWdE0aUiZH3TQ0p27L7SaZolMeWXJqHQ=;
        b=sAbudNKq8QvzJIImyOzNgXGYkv6v9DRhpwqFvewr8FLCqzoo+3vlMepYDUSYN4Us28
         +vThKAhJHjCITTP4JLzNLcEr4F1zUpcDF0OOPRVR6c6z/Dhj9jHdNBtH2kVqCHUPvwrz
         JYfSfYPnRuNJe/JIXEV5GoTwwEpwCFGIgEgEpLoDWzV4GVfi4isRKFkcorWgagefNkCO
         wyiKbMmeJC37JtDbVIxRRvYIsUkqWsIc7zSiTtzRC/WzQfqzbjClhbvsG8xIl5JZ4ke2
         zBbhurdy61vex0r6vMRwn2d2sqDgT+Lh3diY2oGF1Bc529NKEv4RQKHXDnFBwlI0y3z2
         6ugw==
X-Gm-Message-State: AOAM533CLAEwicPJuUdSMHHBiZGfMvSYZi3P1JXh0gjKdRaXpBclITeU
        QZs9YB5awHABkAGsSJiJfZJbu4TAPW/vztAshZeGGfxs26Ndbg==
X-Google-Smtp-Source: ABdhPJzQqmSTDla1lw9rH9mS2IOSjDPqnYxmMPNnhKSUIU+yWqY+FqpdRTwBI/YLGGMplHrd+768VMkx68kLPEq67K0=
X-Received: by 2002:a62:7ace:0:b029:25e:fcfc:4873 with SMTP id
 v197-20020a627ace0000b029025efcfc4873mr872311pfc.4.1619718169665; Thu, 29 Apr
 2021 10:42:49 -0700 (PDT)
MIME-Version: 1.0
From:   Igor Korot <ikorot01@gmail.com>
Date:   Thu, 29 Apr 2021 12:42:39 -0500
Message-ID: <CA+FnnTz8ryv0C03tA0DAayo6hV=NQ-DRJRoxDj20Kp6X6dmQHw@mail.gmail.com>
Subject: Can I use it with sURROUNDscm?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, list,
Can I use this to work with Surround SCM repositories?
https://git-scm.com/docs/git-p4

Or it is only for the Perforce based ones?

Thank you.
