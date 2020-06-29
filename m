Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B7C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 22:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC3320780
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 22:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+LQm12o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbgF2WH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgF2WHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 18:07:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9CC061755
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 15:07:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id bb8so2785201plb.16
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=vThDOZOKxvTkuZejgPyPzKM2/ta+RXzjk+IkIByx2Sk=;
        b=T+LQm12oO+c8mQTCAY/fWTrL7EMWscx+je6jbXlN6qItwAvMzgI5EETlC6Q80IiMP0
         aDBb4mmTDoP0AHKi8mRoniY1UBUoy9Zd7DdmmeC5Ob4WJc0F+aRVkPpJEseCKLgn+ewf
         OpWQAKfycKubs/WBwEkA63rYNwpd0nqX6lbBDdKX66LafK3QYewIBRY+rSR4ejULYesg
         NKBY5wxwX6J9+gZ1Qn7YwkQeBxmmoZ1q2ys8RyLGkiTSGSeELW+N3GQPEwwqoW4M7nQ/
         WxayAQHO1WQn8bFiNZd56MOfHTByMN6ohlXkDKgk4Pbi6xJWKC8WUEJunwnAz/5QBjjI
         DEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=vThDOZOKxvTkuZejgPyPzKM2/ta+RXzjk+IkIByx2Sk=;
        b=DzFOjcFzt3VT+tUOJqK+oepErjF7qJ43ZOV5wMDCaPeYo72jsVynPTXOMYOIqVpmhA
         GdCtigwZvUguhr7Hr3Iqf0Kq74dyk7P81mTxK+ueR9vQExdUKAqpBRJdzdJXdlhWKshC
         fuGEJSGBR4jjXoXgHAQzlZXd6hl5e7AriAFF2lyU7sGekIOJjrcXkaPyAbYY6/UgRKgC
         DyboXnaYcYYMzc+jlbiM++l2EkYPHgt3vG532J0+o+5+242mM0BpeCoF+IMBQq7sTBd6
         WphThQNQOAFnNwq4gKvzwwwtFHW0+3t4JcLNqK3VUOsjg4pXc0DtvedUTBOSGcdh/x24
         pdlg==
X-Gm-Message-State: AOAM532ot2GnH+X2DWhIXKCC8XM2gWJuBg+naN/Xez8iG4gsjW0ii2/F
        UVfS0Pe2Zo1uyD2KLGdr7bbDn105xXQFLhCAjANZ/7cPNxKQj3xQxFx7vCM6B9V/JsqCGbVLq07
        LRKM3e/ygY2aqvWXf1a7B2Sq0rQPsR9LoLhqcfsV5K5oYqODD0hrWgMoSSdE96hNoXKJ/OUj5Bz
        fg
X-Google-Smtp-Source: ABdhPJzMJWJoFnU/fUoe4XOR0JbooJ7kpcEZirgoqk03bT5/vOXaizH9csih+LEfkPov6CDANstD73+nIuCuVFySBVCz
X-Received: by 2002:a17:90a:50:: with SMTP id 16mr12799020pjb.205.1593468475100;
 Mon, 29 Jun 2020 15:07:55 -0700 (PDT)
Date:   Mon, 29 Jun 2020 15:07:43 -0700
Message-Id: <20200629220744.1054093-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: Commit graph chains with no corresponding files?
From:   Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAYJOB, a few people have reported "warning: unable to find all
commit-graph files" warnings. Their commit-graph-chain files have a few
lines, but they only have one commit graph file with very few commits. I
suspected something happening during fetch, because (as far as I know) a
fetch may cause an incremental commit graph to be written, but I ran a
fetch on a large repository myself and didn't run into this problem.

Has anyone ran into this problem before, and know how to reproduce?
