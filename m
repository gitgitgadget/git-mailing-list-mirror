Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E768C433DF
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 20:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CED02077D
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 20:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htCFjQXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFFUgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgFFUgo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 16:36:44 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FACC03E96A
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 13:36:44 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m16so6850504ybf.4
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8AfZ+rXUAUDqepcwlZWeG3U4txqkpuqLLtHSHUMGhZU=;
        b=htCFjQXNcMxci/GZJKZsG++Jm8RbhqF4Ewc+uiYTSvy/uIFk4cNmrLxDBw4736uINO
         x6Tzxyo5G58t4maDTCfaLNT2O5Ru7+iiyuLbRX2g3JCrtIz1BF8+NQcQUv99ZVvhrb4r
         U42AqKfin6H2XwRGK2er414N8RSYVLvNxoBBU+7qSgBpqQRJlvEgOK7By+IzbBOFidXp
         TDvj+To8gh50de/RaZD5zcBEay5feWGkR/21b4j0cyH2j8/5LFJwJ7nf07ukJ1s/i9er
         EpfVmgDMOqp4m9zwyojtZPhvqH851zzHheU/wXcslEEdxx1tHl8zmXzNMJGDUNuQ1PXV
         pO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8AfZ+rXUAUDqepcwlZWeG3U4txqkpuqLLtHSHUMGhZU=;
        b=FmKrEBbR9soBk+HLWFPTLZK7ouj7dcSJ705kogFIP197PmiVZxOO2uIfg9bZHS6OBW
         TkZLIZlBX07fLDUTpiggoax1Nr5v/qWpBakMzHSbh1ml2h3RHKGjQ6g037FaPkVh8JLq
         i9F9hTwjZxIo6Gjfb+R3UMDlN1BGqdKe7Oy5FXDS9t1RYhAwPjryUlnlzYT46LZhQAKC
         440NuisXxwR2eBO6oPyVlreZMHylMDKS15tYAzf5rLpIeYM/Sv7100nmkhCczFkaLyl/
         EI0GgOC3OZFncFkPo1zHKKX1L+wyAFAAthgiCG56mS+bsX1D8Aoyvn3dnsOOnisJHUL9
         Bbpw==
X-Gm-Message-State: AOAM5325bxQdvJI2GFD7MyfHJorA4enin2/86NqQfyP233ctR5Ntvc7o
        vPmBXpGaRxa/IBghZAC6JwhaWTcPYTYe0dgImTDPrg4zBgA=
X-Google-Smtp-Source: ABdhPJxlTMYZze5zzdoV0xCUIe4IPOWbhxO8Nfv92tVoi/+CgCxXilZq+NvOug59umabUReZV2Qg65OxUtZAFSveGbw=
X-Received: by 2002:a25:d7cc:: with SMTP id o195mr26628820ybg.37.1591475803237;
 Sat, 06 Jun 2020 13:36:43 -0700 (PDT)
MIME-Version: 1.0
From:   bruce <badouglas@gmail.com>
Date:   Sat, 6 Jun 2020 16:36:32 -0400
Message-ID: <CAP16ngr=cTTUzSb8=beKu5wtaDCXL2tECUSUg8t+1HS12O972A@mail.gmail.com>
Subject: not sure if this is appropriate -- GH/Github question
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Testing the "create fork" process using the "GH" Github cli.

The test process is:
Trying to have a Github organization with a single test user "foo"

I create the Github org -- gets http://github.com/numinds

I create a test user "foo"

I have a test VM, with a test user "test"
For test, I create the ssh priv/pub key

On the test VM, I also install GH to use the cli
-I also have the following

cat /home/test/.config/gh/config.yml
hosts:
    github.com:
        oauth_token: 111111
        user: foo
editor: vi


I'm trying to fork the
 http://github.com/drupal/drupal   to be in the     http://github.com/numinds

I can do:
(in the /home/test/numinds dir)
  gh repo create drupal

This creates the http://github.com/numinds/drupal (blank/bare repo)
  as well as the /home/test/numinds/drupal cloned repo in the local dir

However, doing:
 gh repo fork https://github.com/drupal/drupal numinds/drupal

Doesn't work as I'd like it to:
I'm trying to have the drupal repo be http://github.com/numinds/drupal <<<

Instead, it creates the drupal repo in/under the "foo" user >>>> doing
somethig wrong!

It generates the repo as:
  https://github.com/t-smith1/drupal


Any pointers/clues on what I'm missing.

I have the latest version of GH v0.9.0

I have everything I can possibly view in the "member_privileges" page checked!
  https://github.com/organizations/numinds/settings/member_privileges

Thoughts/Pointers on this.

Thanks
