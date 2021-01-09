Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918A1C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486D223AA8
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAIAH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 19:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbhAIAH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 19:07:56 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D5FC0613C1
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 16:07:15 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id y13so4098655ilm.12
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 16:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=IExO+7XXSGviBdoP0kJT4+5Dzp5ExhfLVZft+r2NUj8=;
        b=pc5RcC+xoG6lcF6WfyoNLgkyZw7meg367wRgoHc8DSfRK6cr6TxdZKjzaCS585GhWg
         59D+88aWbHb0DUr3dXgPecE3FBWWfiBNrzGE+hyTwWOrr7D1XS6stkKKeixzxBjodiwx
         8A710agdugRlh+UqtGJqv2bEWB9DKhvk5ffSVf2mi5nTsXY0xty19bdOLuQMxmYqu/mQ
         l708i7VOdceFt2zMEsJO44EG4QSnM9HvmmcV47rD0nwwHkzFX5GqL3jcRBzr/mwmQCTx
         ew7eM3zbMGoaxNJ22e9qMkCrp/PBUd6xVTLvAH48+2mgvBIXVzzYeJXXT9WG6AhmkuOY
         t3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=IExO+7XXSGviBdoP0kJT4+5Dzp5ExhfLVZft+r2NUj8=;
        b=XGRHlBXTJ2KoW/yGuQOCNxBAPyN8CN4qgjTUv5pAUN9hxrdMlkZdf3XlSG+DlDcPz0
         tYDGfCSNKmLTO75VEdFtx2+WOgemdoLYDHudQAJPmdKCd8qR4zyeHiC5Sp2qXfLH8eyh
         VFP+k/oRDW6y14TLz+MOd5uAbol3NGkb7nxBZaO/LS6hjD+W52YyqToljuI8egLkU/D7
         R/MICt2A5p0UXod2GbjUQqhDOUhos+ceSBd/ntMZZSWhwBzZJwlpTP3BSVdbJph2uXXy
         M5OwchR5u5PXrMBf6w8uKD87CuNKuKBwymJBT2D2u1Bd6eP7a86TBSHMwFyfeg9Q78OG
         GEJQ==
X-Gm-Message-State: AOAM531k2tJZB3US1IBMuA8nLTk8dUe7AGRQh2e5W8O43YC5GP7zqz0k
        koZn3lT2EqXBQpiPm0SiyWdX7yLbwoevwvtLl/gZhx/comE=
X-Google-Smtp-Source: ABdhPJxXMNTf51L5NTWBifcIXoWe2PCPtrk7LsI/JeWfFL/3Nzm6zW9ew8sk7n0gmJ3IgFzsGPxdOWZYJ0Ua9WRlG1g=
X-Received: by 2002:a92:cb52:: with SMTP id f18mr6087058ilq.41.1610150835256;
 Fri, 08 Jan 2021 16:07:15 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 8 Jan 2021 19:07:04 -0500
Message-ID: <CAH8yC8km6mHsrCD6sW+Z2ERpyO_X8Xp6fJbYKV+JF2gaqYakgQ@mail.gmail.com>
Subject: Git 2.30.0 and failed self tests
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm seeing some failed self tests with 2.30.0 on Fedora 33 x86_64
fully patched. They seem to be centered around email.

    *** t9001-send-email.sh ***
    ok 1 - prepare reference tree
    ok 2 - Setup helper tool
    ok 3 - Extract patches
    not ok 4 - No confirm with --suppress-cc
    #
    #        test_no_confirm --suppress-cc=sob &&
    #        check_no_confirm
    #
    ...

    not ok 174 - test forbidSendmailVariables behavior override
    #
    #        test_config sendmail.program sendmail &&
    #        test_config sendemail.forbidSendmailVariables false &&
    #        git send-email \
    #            --from="Example <nobody@example.com>" \
    #            --to=nobody@example.com \
    #            --smtp-server="$(pwd)/fake.sendmail" \
    #            HEAD^
    #
    # failed 132 among 174 test(s)

Jeff
