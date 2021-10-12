Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D35FC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323336058D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhJLW7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLW7c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:59:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41829C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:57:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so1049079ybm.18
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MQm/u+8Jc3RONcFsUJyUx9afK/9i8ufmFEapwQ/ii5U=;
        b=oG6sAtpeL2qcBnHMUdXo4IRZrIyYjuQGm0ctQ8X2HkWXIKYvMLVciTrtC0O11q3DZ4
         4ro4b4rKLDhTCk/AyqtBEyvUbobPbpci3K6hDpqBymfG2HAzUl4PRrRezPhEX4rTUwDf
         qwnwU2wQBe0TD8AWFKdQhw9RWlFD+GPw5X33RGLArp0/t1zE0kteuxe/8AguUeu6XmuS
         C/lE5sPm7Sc3Isf5O5hb5COzVOkwSzHzwXgpGoTUxfFUeuG0qFNIqZLRwytwkaNAQoLR
         nDYZjKanhNVVBTtcMZZOtNq5GGCEQ98jbbBgBAjnyMDbYNxchvsl9PUzZ10FLt+xJFbn
         vPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MQm/u+8Jc3RONcFsUJyUx9afK/9i8ufmFEapwQ/ii5U=;
        b=QCDUFIqDchrf/dWg4kslbaR0eX4I1ANfifxNKEOqqGlpl2HVfBwYdzvd5R4vwRcP20
         RZIGqnB2JS4lo79X51tkXdAjlZ00a7Tmf20JG2/cn4qeRCGwOp+YlsZ37QpATK++Qrna
         xFWOHMTY+INVTHfaEoAEtXpksmftYvfFlCoUHRviHt/24WPnzac/+wZGglSam61hvzdA
         3LcarokmRhJlRy3uWxTqo4oNbxEzwKKZ31mxFqYDSBSudrVc+tX3RMrvNusmoDeFLCsb
         CQ/rUxU1r1kLKdpvbepK/ctqKxnGhFjdFLdczCiMDCdVWpMheY07atKJ7Q2mgee/328U
         Zbnw==
X-Gm-Message-State: AOAM533OUkBca68spH2XfmhkPyl9uu3qGY/St0+DJnd6WIzjFc9f5g7n
        +mOAShRfPlfGFKJ5rDmkFZzXZa9DO6ED/dldEOPHTKPH76n9P4WfjiN2z8rokjpisDHbrktAnWL
        8K7nDj9+iJbzDiuA8VSTr/DwVBui+1yipy07V45hZmuaAEmshmLrvj8fckbmQbj7kqi62axR4l7
        zR
X-Google-Smtp-Source: ABdhPJxxdb3DqfreGUhXaFHUXN/VjRW924eaSbqQerClMAsLVvQBusXOhJL3f6r5nyfflt4PPo0bchVhYXa/Di1BWCVc
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:1d86:: with SMTP id
 d128mr30422363ybd.447.1634079449282; Tue, 12 Oct 2021 15:57:29 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:57:21 -0700
Message-Id: <cover.1634077795.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously [1], I sent a patch set for remote-suggested configs that are
transmitted when fetching, but there were some security concerns. Here
is another way that remote repo administators can provide recommended
configs - through conditionally included files based on the configured
remote. Git itself neither transmits nor prompts for these files, which
hopefully reduces people's concerns.

More information is in the commit message of patch 2.

[1] https://lore.kernel.org/git/cover.1623881977.git.jonathantanmy@google.com/

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 config.c          | 80 ++++++++++++++++++++++++++++++++++++++++++-----
 config.h          | 37 +++-------------------
 t/t1300-config.sh | 27 ++++++++++++++++
 3 files changed, 103 insertions(+), 41 deletions(-)

-- 
2.33.0.882.g93a45727a2-goog

