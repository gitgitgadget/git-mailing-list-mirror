Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C3AC1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E9520714
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=economicmodeling-com.20150623.gappssmtp.com header.i=@economicmodeling-com.20150623.gappssmtp.com header.b="utHcuylt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQSeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:34:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43555 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQSeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:34:23 -0400
Received: by mail-io1-f65.google.com with SMTP id n21so22096732ioo.10
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=economicmodeling-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=dCttjFSTcrhRkwXqgbEhp+30zkpzNVobGK90omspPd0=;
        b=utHcuyltKqVcZoBPVUh3lLe4LfMZnthhzo2h6QSr26atOPNtMbeA/8owMNY2m88YDq
         xWhWhRDqdGmfeFap2ka338Fgig8cFIaEkjxbIYB5zRi2QQzz5OP8Lcx0m6JXV7M7uyxk
         hKMrJCFhHFyWeSiS3VPlB+bHfVOPp2mENfpQTE2lVeAATjJr7twuCouSnOXKtqlxjpdm
         G5Yg4jNgSE02ZhMD/suult8EYj90d8d7ib8tukdlA5CrfGPbqbd8XU8wGMBXS2Tzxhob
         bRH0tK+BoXDWTqCoMdRA8Fb05zUb9e0VF1Aqpc7SZUxULuOcU+hovDsE8f0+dn1IHsHn
         cKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dCttjFSTcrhRkwXqgbEhp+30zkpzNVobGK90omspPd0=;
        b=SnAtQuYq2RvPQe+K8xFPgP79NwkEjuIqwIyejLqMq1JMCB8gLpC0RCsYpqKIVVBX7f
         BMjN8P5FRILbJl9xvpMPrQ9Y4elZBZfx5w3buaG2pi8UiulHZmlF8sUw8tuKybdbcQ1S
         U97u/DNxrw+c6qfnyyvApCnJXGgxANlcucyDwYLO3jHCCu3jyhzaKpbTdEYQqmiJUfgQ
         B60XlfbYFD+cRrviPwoRc3FNqeBUAPUoAVym3m24fIDMn3vt6F8w+zTxonII3jVimIB6
         uEHIFK9RsLnTXrLcxAj/OxwMvLM56NEMpLfahd1DB6hy5KbfRpxEBixxZJfpc/UIp2hW
         EATA==
X-Gm-Message-State: ANhLgQ0sc0OokDq9bIV3A6a2b3g/0rjP1gXtlKqZElP0kkxhSoldZwua
        Lokcu5Wb0MS8R35Do1uGWC/znAsNj4QDMoM6WD+gxmTD/No=
X-Google-Smtp-Source: ADFU+vtI+ed+RK1aNXcs8UYQras7zS8/B9m3dqzMg7zh+JLA8OoSWypHXU+ZdHkGZi1KYC0ItmZZ2Hs0qFbjalPfq/E=
X-Received: by 2002:a6b:7407:: with SMTP id s7mr125877iog.11.1584470060490;
 Tue, 17 Mar 2020 11:34:20 -0700 (PDT)
MIME-Version: 1.0
From:   Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>
Date:   Tue, 17 Mar 2020 11:34:09 -0700
Message-ID: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
Subject: Relative url values in .gitmodules confusingly sensitive to clone via
 ssh vs https.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From my perspective, this is a bug.

If I clone a repo twice like this:

git clone https://github.com/user/repo.git ./https
git clone git@github.com:user/repo.git ./ssh

And if it contains a .gitmodules like this:

[submodule "x"]
    path = xxx
    url = ../../different-user/something.git

When I `git submodule update --init --recursive` in each, only the
HTTPS version works. the SSH version confusingly seems to try to find
something at ~/different-user/something.git or some other path in the
local file system.

this seems consistent with the URL parsing resulting in different
segmentation and thus the ../../ ending up in different places:

https =[..., 'github.com', 'user', 'repo.git']
ssh=['git@github.com:user', 'repo.git']

# ../../
https[:-2] -> [..., 'github.com']
ssh[:-2] -> []

This theory is supported by the fact that this works:

git clone ssh://git@github.com/user/repo.git ./ssh
cd ssh
git submodule update --init --recursive

----
See also: https://stackoverflow.com/questions/36564696/how-to-use-same-protocol-for-git-submodules
