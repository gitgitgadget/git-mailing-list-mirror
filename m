Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7F2C54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbjAZJdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAZJdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 04:33:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95A44BF
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:33:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso1209868pjb.4
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8zSVi/uRKBysItCBio7L3XH/SBDg+xmEP5cCayfEPFQ=;
        b=KUcyqwCO82Xe/wnqu/zoNYsvVYI3/SsHySLdSvp0KWrgYZW/+g93UlQ9wHM486JZA4
         3FvO166bZyluJaKodez/Qa8XAji4aZ9+tnh9qJHdE3EfMsgrd7C8vAwU4gyhGcQQ4TxJ
         bYERzREAPcp3sW55Mb559GJxNqgsFUBnMEoLcWgp0R1OnUT7rMB4sxxVfZdC42coZBdU
         nRcdnVtQZqZPE56pUFKa7AbQzqhfrWPNXqcFyPfW9Xs7wunKdqPNWlKF5yjLlyyFyA7K
         X8pa/kbjvYQG4sjyP2gnqxPtUOChO5lWWdmSjw9Yd5p/UO5lsh9C3eoRj4Dyi+C7/iJo
         TvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zSVi/uRKBysItCBio7L3XH/SBDg+xmEP5cCayfEPFQ=;
        b=evr6duud2nErOJ8kSPvda+v8/VYtbm+BdMAQ9kx0beN16jfmj4oI7F09o8sd1o9D60
         mgwOGQh+uhL/NusQMVDSrvfs/3W7R2hTwG5EFYqP6HVEE8kYh/FLIGZv6+5ZadGHsMcr
         KD5UpkT/Srr9F3OX9crlbVqDYS8yDoPjH3UK2fvka9Mr3wqfw7zzOFgkeaurY51KV54b
         ODDxiKaMoWs35Q59mXOtBkkTiXKxNCUQcpeyuKbfg0mQ7wkXJAbnVh7PpzwfBpW6sSEi
         xBvjBgneIT0CbtuAbCe7VaWrp2PyLvcsVwmr94YGr6ZJ6T8Eo6RXVc8CNxLWAOo7saAV
         n+bQ==
X-Gm-Message-State: AFqh2kpUVafIA85m3C+0LQR70zFrJnNoZXI8JdnXGQAyOj5ZDz5WRXWb
        XWitSQzN3BvuWo8Bp7dxYaCz5fH9GKO/ugEJH7AbKjlb+14=
X-Google-Smtp-Source: AMrXdXvJVCAXA57Pgs1c63bF1Tpi3maTH0V/66APUn/xhhDNFkFO1l/+wy+DA47X7zGE0JLC0h/x/x9siAaK3fvhr1o=
X-Received: by 2002:a17:902:8f85:b0:194:6e99:dc8a with SMTP id
 z5-20020a1709028f8500b001946e99dc8amr4142167plo.1.1674725610786; Thu, 26 Jan
 2023 01:33:30 -0800 (PST)
MIME-Version: 1.0
From:   Michal Aron <aronmgv@gmail.com>
Date:   Thu, 26 Jan 2023 10:33:20 +0100
Message-ID: <CAHoQa4-o-=pB4zPR-1SG96KB02rixQG23mFgh0H9ojWrQ_pREg@mail.gmail.com>
Subject: Feature Request - GIT config - Reference value of init.defaultBranch
 in alias
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am curious why it is not possible to reference other variables in git config.

Useful scenario:

Global git config containing all useful aliases which often reference
the default main branch. I discovered the config variable
init.defaultBranch and I would like to reference it in the aliases.

1) global config having init.defaultBranch = master
2) global config having alias com = checkout [ init.defaultBranch ]
3) local repos replacing this value e.g. to init.defaultBranch = main
4) using this alias in local repo git com, which will checkout me to
the init.defaultBranch of this repository..

This would allow us to use global aliases independently on the
repositories.. If this has not yet been discussed I believe it is the
time since many repositories are being customized to the company
team/company culture.

Appreciate and thanks, Michal
