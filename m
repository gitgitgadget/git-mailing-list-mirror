Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE1C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBBC20678
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="m7URGwBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHZXCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgHZXCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 19:02:10 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A1C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 16:02:09 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i2so3022912qki.19
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=srTl2S1Lmr4gTxfC7O4hcTGuKjBG0mcQ3STb6PlbEcw=;
        b=m7URGwBIybec0XQeau80kceZX+meb9LZGe5POSZIGbYc1ZWTL3StYqHeDazNVZFQpo
         osoyXQODkHltEC0ppgP+YUXhtY8qT9PslNGljbZUCX8THRHr62sz9hngxdHiEM2t1AIs
         xNK1xToTuOHMCCHt/4GopPn8HnX8HBTkaTlzg8mOgV4ORP6UiWzhp8XdGtGIwJaES2CV
         a59QueKzitbxq9JFV8azCNhS9Ui1wdg1lFyhSR8eFagATWXevAKoMPm0POGeMJsI3n2j
         Euj/R2lR0GLksXrBRQ42/iJ1WvN+QVi1FPYk5/U0ouURvmGRUG+pp+rOgfDrno3Kckoe
         MElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=srTl2S1Lmr4gTxfC7O4hcTGuKjBG0mcQ3STb6PlbEcw=;
        b=bDQYpEKHu4LLR7Pi48C5vxqrChpdFsKsGyB5gSaoCx+m8hqSojC4H5x3t2LH26SqZr
         ZTbgCIXnrsoKGzX3CmESpqlkAY9j91Bm/Bl8ByXJCb/2JSZZ7+JlBO7cw2r9HbQBXAG1
         TXn5KqjzvheYwlU8p0GRhds3lOqluIPba27ymsNdu6C08f07JEoiYT7rZU1RAfXqIxjt
         dck6tTOn1w5o+n8P3ZoAtRRAad+v0NkmFbuKka4+0kVw/yhkpeqy2Vz3jyv7K559xizm
         DmGFsPulB/JLmw7eClDrv5ZJr5/pF+tHD1U0WYDKASg8hrxk4W2KcHFBR/+zee/LtRNr
         /QIw==
X-Gm-Message-State: AOAM530U4duOXE2H46zWE2b9GuQg/eIf39K14v5t7dtGvLgmdX1I4o99
        oG9zjoqxeZJ8BsOg7CaGEZgAS2J7VpFNzgVHZXek
X-Google-Smtp-Source: ABdhPJwJnpq30bGhyo9/1TmkLYAkx6bjepg668JlBm70bD4xWZf3T8YCa+kePaPb6W+lbY37eAwU9FkB4AXhca/ZyT1o
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4f13:: with SMTP id
 fb19mr16442780qvb.54.1598482927438; Wed, 26 Aug 2020 16:02:07 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:02:05 -0700
In-Reply-To: <3d513acdd8885d90393cbfa847c38e802ffddac9.1598380427.git.gitgitgadget@gmail.com>
Message-Id: <20200826230205.1444446-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <3d513acdd8885d90393cbfa847c38e802ffddac9.1598380427.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: [PATCH v3 07/11] maintenance: take a lock on the objects directory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If the lock file already exists, then fail with a warning. If '--auto'
> is specified, then instead no warning is shown and no tasks are attempted.

Maybe just delete these 2 lines - you're not failing, and you're
refraining from attempting all tasks regardless.

With or without this change, patches 1-7 look good.
