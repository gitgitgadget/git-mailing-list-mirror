Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676AAC2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3656D2075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNs1pVTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgAXWdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:33:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53641 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgAXWdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 17:33:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so967568wmc.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7PF0xtLeYk9BPsTBFhETBwzzx3z7ICBCvKFRH9GnX1Y=;
        b=CNs1pVTJSxH7lFFgNZnBvo/K2vQ9oknUvo3hi+lIjYaU7ZCvFFkb6nUhCuVpf3Mjfs
         a57GN1jh4Uair+qXKtBKFSkg/AnwIaU4hgFp5q0XwAlIshkhu8qQfJzPVtJkuL1/Mjqt
         m9rdp/JJK4tQxPz8SbPQZZFnfAJ+Q4l98t+gqcto68n0DC1OcWLhBbRk8oVJL/zjduNF
         mXlXspbUexIXMpoVBwOkX2m8OKrrWuHWxzb/NKpbNKHHonx6NwFmpGzNS1TOgigbEAb9
         u/dPubFNPKHq113lwZ6ReAT8+Tc95wje+T4m59ayTUGyxGp1vgyEAOoXw8UhLWEV2U8h
         H3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7PF0xtLeYk9BPsTBFhETBwzzx3z7ICBCvKFRH9GnX1Y=;
        b=lLSZsLd7Ln9EhiibcIshodpaKLXzb6jss9wQ5xjgrpDjbBfBy/inxjev5YjjVKuDnl
         kXmFD1N7atiq9bITGS2pYwm886z/LkFBpRddqNG9QPgZWC9EbkVKG8qz26IBTdnc9MpN
         qJtACtLOv5HMNHUxlpoWH8bystLJBMYXRmcTvKailc0Tg7qdMyL26DM3Oe2nbhRy07Pm
         t/qOV0MBeNHAWyOsrGZoBXi7TqLQKFXoodu6EAmKX/MD8eTfIfhIP1qEZEvhDY24bbZp
         USVqZGW77sAkySfzz81/xFqZRa3a9FMj0ViQmHIaU61o30vV+H/4O498pBnUPWhIJ9m1
         d9iA==
X-Gm-Message-State: APjAAAVN6mFSFEfNNM2pZWuwS6Fa1c3x/xQa9soDJvIamUnu6BA+QWvd
        wtojjcMV3+xE7RToPR2OGJ309Db5
X-Google-Smtp-Source: APXvYqwAVMMokSV11/7toJ6g7Fhq7GZsO7n3Y5J/gQu8k2r1IqwuXAKjc+6psmXC3dSuni5HU5mIwQ==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr1208950wmq.142.1579905219750;
        Fri, 24 Jan 2020 14:33:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm8750718wmb.9.2020.01.24.14.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:33:39 -0800 (PST)
Message-Id: <pull.525.git.1579905218.gitgitgadget@gmail.com>
From:   "Christian Stimming via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 22:33:35 +0000
Subject: [PATCH 0/3] git gui: improve German translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Stimming <christian@cstimming.de>,
        Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update German translation to recent code additions, but also switch several
terms from uncommon translations back to English vocabulary.

This most prominently concerns "commit" (noun, verb), "repository" (both in
the second commit), and "branch" (this and others in the third commit).
These uncommon translations have been introduced long ago and never been
changed since. In fact, the whole German translation here hasn't been
touched for a long time. However, in German literature and magazines,
git-gui is regularly noted for its uncommon choice of translated vocabulary.
This somewhat distracts from the actual benefits of this tool. So it is
probably better to abandon the uncommon translations and rather stick to the
common English vocabulary in git version control.

The glossary is adapted to the git-core glossary at
https://github.com/ruester/git-po-de/wiki/Translation-Guidelinesand the
changed and updated terms are used in the actual translation accordingly.

Christian Stimming (3):
  git-gui: update german translation to most recently created pot
    templates
  git-gui: update german translation
  git-gui: completed german translation

 po/de.po          | 3617 ++++++++++++++++++++++++---------------------
 po/glossary/de.po |  172 ++-
 2 files changed, 2068 insertions(+), 1721 deletions(-)


base-commit: 0d2116c6441079a5a1091e4cf152fd9d5fa9811b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-525%2Fcstim%2Fcstim-gitgui-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-525/cstim/cstim-gitgui-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/525
-- 
gitgitgadget
