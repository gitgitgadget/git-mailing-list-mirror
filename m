Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A022CC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5F6610A8
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 01:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhDKBZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 21:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhDKBZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 21:25:29 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8132C06138B
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 18:25:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w2so7925783ilj.12
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nNy1BP3QsP5sziveWHuzUOk9uIqMraunhZaCp8mw0zI=;
        b=avFPpzQ01Ju0ZYReip4bNM7luQ5lm3LrFFk/kMHgA7aiFw6eMqXap9RmNn+MYtJQ4/
         F33ozCf/g7897aTeLdLIF2NvxtcBzhon85coYTVz7dVSsXXW70bpG2Ps28qBkwG5z8wu
         ZAwKGobG+bxP2ILy3RAY8QC3eCpgczi03SvkX7JYRXzvu/8pUQxI3lxCT+ERZmW2oWM1
         /SVhDSccSvNLBLXvyI8pECE1Fxz+Ggwo3++EFc63RyOli4ANpw49htv8nPRf3CMJeXJI
         Z2dNyMe76ykF3CWdgYF7EwPQzF/NYUI9e++wk6024RtgHFCqi3puaD3N5pH/sbocbYq+
         Hw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nNy1BP3QsP5sziveWHuzUOk9uIqMraunhZaCp8mw0zI=;
        b=NGWHhjSsM6Gj3aGfGbUd9arFqQQTSe31uFur2fCcdF72gg2jkFfaeF30SXcNiQ11pX
         Bo50/Vi/CvtMd8XM//sCD2SNB5b+6rdlJKbbnpo13fHLv9xB3V6FyV3UNn+X2VT9JNcT
         R/pxgsswODu4eEgURoM9CN3V8NjYC31FGje9I/elq1F+dFUVz6jbpsDHZwoQh1gaKUtA
         69Tyk4Tydo3X6YbpGtNL0E331RLhFx4oSbnNwaWGmT1r4x11+f+HQmpNlp8uYAd/j0Bf
         afACAmbZGdfDSMLL6TFpONyEGN7t+8kpxgZyuLd/wt1eNueuCMyyRNMIhR/eTAU3lUp5
         ZNHw==
X-Gm-Message-State: AOAM531Q3o+pfTPqPyTcJuYl8/3cwcpZeNQOnKdMXYuJYq3hhU/Kal/3
        9vTOfCawAOiYT6Wdnu5X52LCxJo8ZvDqwsi2KdDcrbq+Gqo=
X-Google-Smtp-Source: ABdhPJwX8+HpYpP83aHvDIZaQoUCpLTNLKH9T/I/G+lB1+2OOAWxeHPlMPSZ2DRbn5kSVGENnFQ7v5+c5s6kWjmE2uc=
X-Received: by 2002:a05:6e02:1351:: with SMTP id k17mr17474084ilr.37.1618104308797;
 Sat, 10 Apr 2021 18:25:08 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Sat, 10 Apr 2021 18:24:57 -0700
Message-ID: <CAOTb1wef2w_H4mwMMwR4En8665GduAMoceL45+OYC4DSBPtozQ@mail.gmail.com>
Subject: question re: git show-ref and matching ref patterns from the front
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I noticed that git-show-ref only seems to permit matching patterns
from the end of a ref name:
https://git-scm.com/docs/git-show-ref#Documentation/git-show-ref.txt-ltpatterngt82308203
For example, "git show-ref master" will include both
"refs/heads/master" and "refs/remotes/origin/master".

However, is there a way to limit Git to showing refs starting with a
prefix, and that doesn't also require Git to iterate over all refs?

It seems like that would be natural and useful e.g. for repos with
many refs and/or repos with namespaces. Am I missing something, or
would that be a useful addition?

Thanks,
--Chris
