Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0965C43219
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 12:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiKHML7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 07:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbiKHML4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 07:11:56 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9B12AEC
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 04:11:56 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id n83so15277574oif.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 04:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnmRZE6BRMFcB8xj3AbP+4s4KiCxZgZ7i8no2aYey28=;
        b=SyktTZ/jymrh8EqkAL0/dY/1SQbnNdZAozcwx2SORrNpIFnTn+KJTiOTfP93m3/T6F
         yBJr4NAzYW0UTY+A63/kOjfH77k9JglKwm8GpyKjUJQ4rQOerGJnRvKzeyp5HLp49Pyk
         PZyya9TWL1L6tyn9xBcmdh3yQHhR6O4hHsHwcIuFJj4dvQRSCLPu6HR/YLHKLJAHWBke
         2UwrbGsGej45Yl+8XAf09hqs0BcK37VPkG8dPEmglxs1ZQVRoa52ZisZ/azCzjX8axIH
         ZsOh8C2a4TbXsIi+YqFuI9dpv+ZkQizcyRPphJXDoMVSwdmKYBCCleamhCYOfvTjtfgs
         kIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnmRZE6BRMFcB8xj3AbP+4s4KiCxZgZ7i8no2aYey28=;
        b=IMCVP1qWtQsDRSYEkrQ5M5Jlq4IUTjEw5ktNVoX9+42PRHH4cvfQw0VZ7EpoaylElE
         DDAxiE284wx6fiRrCA2XHeAzdpbVllu0Qj3eDIHjjWPKU+cpd0HmUS4+e3+f0nlX236p
         3WKZPnJFRSTVr3sbYS5oS+NY55M492/t9nTt1ZH52EtY0NqojNU0P8CwYk9ePmr2wOkx
         Yev6/8QjPIEoxT9MKs/FmyMx1rDDnUdti09FNV1KYMl5RX63FcTpuyTzvgNLpIO7ztKb
         /a53fs9MIVIO8TNM3lYaFaIc9+FqZ9kgLBcg0QyE1asBXbfkGlnQsBnyzKUGsCbavDvq
         DP0w==
X-Gm-Message-State: ACrzQf1tY8JH4DUtOgXT/0ob8NsIIbJSW0BLr3lJLPI8s97VZYQbGACA
        D64fSWIjDy1F08gpsd29LBUoNVk1gWpFUs9uZSo=
X-Google-Smtp-Source: AMsMyM4fxQfg83KDaa4lXrT0s3elMQg1A0iD3ORrTqMCbPXDeGWhFh7zQMo5p40fdjYbefMzClBJA1P1x/imSs1jYNM=
X-Received: by 2002:a05:6808:11c1:b0:353:f1a5:207a with SMTP id
 p1-20020a05680811c100b00353f1a5207amr37743154oiv.183.1667909515243; Tue, 08
 Nov 2022 04:11:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
 <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com> <CAPig+cQ2Tqt8rzvXsRjCsPFTkbq7B06gq2pourKXi5dKNx8oAA@mail.gmail.com>
 <CAPc5daXmnkGpScihLpTPDXEFOAQF0vm-aWOpeym90X=tktLC2w@mail.gmail.com>
In-Reply-To: <CAPc5daXmnkGpScihLpTPDXEFOAQF0vm-aWOpeym90X=tktLC2w@mail.gmail.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 8 Nov 2022 12:11:18 +0000
Message-ID: <CAGJzqsmazghu9qWx6QXaSsQqgMVXDVhd1W-STv+D9p=NJF1-EQ@mail.gmail.com>
Subject: Re: [PATCH v2] Mention that password could be a personal access token.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2 Nov 2022 at 15:45, Junio C Hamano <gitster@pobox.com> wrote:
>
> Or more directly, say "password" and parenthetically add that some hosting
> sites may call it with different names like "personal tokens"?

Right, Git asks for a "password", but the user might enter a personal
access token instead.
