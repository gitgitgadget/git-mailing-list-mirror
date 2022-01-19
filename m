Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337AC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 09:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353118AbiASJpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 04:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353138AbiASJo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 04:44:59 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C5C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:44:59 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f8so1907863pgf.8
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwyA8aJ49plGsds0fOCUFR8gMaLetl6waMZ42KVQo60=;
        b=RnjZx8UDhmV5V7pB3NlthW/J6yrPhEuzlfsnk8TP5H2wIASUgeirJvU7zCgPb3i8Tb
         Qc8KkZwaT/64xL/DGC7t9nuszLKrC428j1Rk859AAS1uZdFQ9kqafrCaiML2B1/qkBWh
         LBf8w/hrGQSVV8vohD67o9QRsEQUcuBjN14fgy0TfShSLDDck/6PmStEDozT/uQl8ErO
         1h9QwY0HDjwUzohOibWuoFY/SRQZtGa1UbJRrAMadU+soKuNrTFnytfsGIvReFlDP1tI
         mMYG5XhW4L/eAinhJZt3cIFQBjeWl+vcblewU/vynoWnTX3uSGLV828YXMgrSqKesOMg
         0y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwyA8aJ49plGsds0fOCUFR8gMaLetl6waMZ42KVQo60=;
        b=TfNQFwm9PSMzDlaho3KXhSzwxCz8V47nK8QdC/kmWy1RtjXyPna5annUr965B94Glr
         wTTAEw+oBCwRuWf5MLH2raWgbBT5ydg0HcfnEHA9KUc14pF+6J3mRSE6RfBi6kb7AiV4
         qGOZdxbXBC2q7bBYHSyezIhNJODt+x9tDmqRQGOVks9yg0gWWnJyQ4hx4plk0YMvT/Ce
         dgitmaHI41dSXEkcs4uFAYEaFvbcYBpQ+K3buayneL9vb+w0Q0lim92UWUkckRLxPMBd
         nsLZYD37FqmlYNVtzyr2Vham0rA02p/VA9C9vRc4C5F7evnHmRxW45n3IBQH13jco3hg
         golQ==
X-Gm-Message-State: AOAM533KzvX++z0PpD0hWYJzLo6P7KaJww8Z/NPScHbut6LaSQ2hBdc1
        rtmWHf22lJLI9P7LG3vdkux6VEUnve8=
X-Google-Smtp-Source: ABdhPJwIL80lxdTGSOE7wOoKWQoEmWwJRXIpXtqH6hzJCZKv9+WoVlimpSej0fs7CF2MmR18Di2ttg==
X-Received: by 2002:a05:6a00:803:b0:4c3:37b9:74d8 with SMTP id m3-20020a056a00080300b004c337b974d8mr19083957pfk.60.1642585498438;
        Wed, 19 Jan 2022 01:44:58 -0800 (PST)
Received: from ubuntu.mate (subs09a-223-255-225-71.three.co.id. [223.255.225.71])
        by smtp.gmail.com with ESMTPSA id b9sm17035350pgb.17.2022.01.19.01.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:44:57 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] More similar messages refactoring
Date:   Wed, 19 Jan 2022 16:44:43 +0700
Message-Id: <20220119094445.15542-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We came across the need to refactor message strings when we did l10n
work. So let's continue the factorization work done in [1].

[1]:
https://lore.kernel.org/git/pull.1088.v5.git.1641412944.gitgitgadget@gmail.com/

Bagas Sanjaya (2):
  sequencer: factor GIT_AUTHOR_* from message strings
  advice: refactor "action is not possible because you have unmerged
    files"

 advice.c    | 10 +++++-----
 sequencer.c | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)


base-commit: df3c41adeb212432c53d93ce6ace5d5374dc6e11
-- 
An old man doll... just what I always wanted! - Clara

