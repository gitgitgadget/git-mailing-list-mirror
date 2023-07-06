Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C0BEB64DD
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjGFRhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGFRhj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 13:37:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD3119
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 10:37:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992ace062f3so124227066b.2
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688665056; x=1691257056;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/mYHw7sMDn/hlz1sJ0DaZmC5QMDdyNolnwkYBYXODM=;
        b=X1d9CtFb8fh6oHIpelmGfpjv05O+zqpu2CzuaAdypsnUWImMi3NJcZh8rzJ1lTo4vT
         a+amQe2aAZkHmSW2EEFbPYAuMi1uhhRAj/p161WIwIk/IqD81EVAAruRAOQCc97rthm1
         40ybE7jqPazZZh2VMM4FCsXYzx4NUqK+Y5FrfMY8kmnWM0Q8XjytTWZxhAMoVO352pTK
         dEhxQDNmXbiUIm8JmcFk3SvljvfRNRO/o8NKZ2K7tvMw/wyFD0ym0XLf4PtFF82x6enO
         GwOMX15/mVjWzjCgyH97SNtYhy8phRtdf2McA9iEN/QmcKrDDqoDWFkx1viS8B/mnXbp
         L6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665056; x=1691257056;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/mYHw7sMDn/hlz1sJ0DaZmC5QMDdyNolnwkYBYXODM=;
        b=mBu9NTjgHxsRIu4OkM+HL5JlsLIcSNZQvu5EJsX8yAKhon+DFqaSZJnFbUsFXr/WXR
         BQ409PVTTauejLSlmH9Tiq9jF/eJeT0xAKuDBfL0Kw/nenMrjaI73oF7+vbsRj+GCdUs
         CJtWMOp1OWXN9byb4p9TbY8G6hwZg6ihO/3BZC19a+Eb78tSmovYVUxlVvqUWRUxFR07
         tjyxPb9u2wn7x0vCukWt2GfuwKjCuQrHGb71WXDtm88ek1J23tmuewnT0Ffs33AqDxDO
         a1RAkp2CLbqsEK+Iv+qtJAH8QmdVF1Pyhcrc36cyAdopbEXRnaKgD7dkSoei/WhAyg7J
         tbHg==
X-Gm-Message-State: ABy/qLaUIAzwgqR7oidtJ3qG24I/bXKfMshzk79mYsl1Kq3C9+g5demy
        ZKpNaJiWV91JASmBDGM/4jQD0fNcA8kpG4cJU5gTyK5yCV0=
X-Google-Smtp-Source: APBJJlFWQ6QE+kC6m/gfKDyuABhWUbNtn3uNA0PU4QkGdwVK3BFp+IGZKfJnJn5GmVoaxogt2rqJAEvy/dVReHTW8K4=
X-Received: by 2002:a17:906:5185:b0:96f:a891:36cb with SMTP id
 y5-20020a170906518500b0096fa89136cbmr1664213ejk.0.1688665055591; Thu, 06 Jul
 2023 10:37:35 -0700 (PDT)
MIME-Version: 1.0
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Thu, 6 Jul 2023 13:37:22 -0400
Message-ID: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
Subject: t2400 on freebsd12
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CI for an i18n PR [1] is failing on freebsd12, but I cannot reproduce
it. Is this known (a search of archives and the master branch doesn't
reveal anything)?

Summary output:

Test Summary Report
-------------------
t2400-worktree-add.sh                            (Wstat: 256 Tests:
227 Failed: 27)
  Failed tests:  50-52, 91-93, 107-109, 123-125, 139-141
                159-161, 175-177, 191-193, 207-209
  Non-zero exit status: 1

Proximate log entry:

[16:19:43] t2400-worktree-add.sh ..............................
Dubious, test returned 1 (wstat 256, 0x100)
Failed 27/227 subtests

I can see no mention of git-bundle in these tests, so I don't think my
PR is responsible for the breakage. I don't have a system on which to
bisect, however.

-- 
D. Ben Knoble

[1]: https://github.com/gitgitgadget/git/pull/1550/
