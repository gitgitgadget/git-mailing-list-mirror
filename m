Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB7C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9852D60F91
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 13:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245169AbhH0NOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245091AbhH0NOY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 09:14:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC2C061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 06:13:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j2so3922364pll.1
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mhr+5UXLkVvxzoi6xQrghOVu7jT6K87Z9bGXNX/m1nU=;
        b=c3KOk8Q+wlHqQjLjDhcTZjLh7+vGKDoY28Aik6/UahjJ22uj29E1yqLiifnmYnTeQN
         3r+4LV/jLUweQpy8y4GZB5VfSRMUAV8YwULVUoKHByEtKSMEkVqFrJQ9NXC13lxJVZdD
         GZfuty2X+XZOv1irHlKTPkpvtGJya2LZw3w93tYGBRgk8GW6BH5jHHr4k/ZOg1zWw8j2
         JNwoRssGO4KBBdwdNMC9lKqfX/S0+ROxWX+ddfdHIURKoc/ij3ySprA/hu7a55i907O4
         kgQHFlThf9xrkekFpP5UUEj53quAY3QeAReuN5EsYgZXXfOkZdk3GARJiiG1SVM5TLFZ
         58Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mhr+5UXLkVvxzoi6xQrghOVu7jT6K87Z9bGXNX/m1nU=;
        b=E+o3RhamNL8OsFJweq4nvDmCHFW8mtiZ1WzoKyRTuImNVzfqrM4X5LLk4tPcjUAopb
         dKYfEIiTAUlnv8C5Z8WxeRkkIj+YPWQb4eX30sCPT0Nna7O0y70qOWo04aP7eO+UOFd1
         EqFzEQ98CCfMJoZ34NIO9xT/WU/BMlOk/we/ZhHnTu1BxLL2tWxI4GSTPUczFK5gFerN
         xK8ab/xAeIZ/ntGTtIHVUJHbWMg/vyQbujkzdrjO+/JcTa5GhXWEDK5yh12NtvRu85Qb
         KpTfdMI7Yb/iKSPCNBjzIrBNj725RpJtyv2HMjz4eMUZIwlychRiXAIT/9NKLH1Cmh0x
         mVhg==
X-Gm-Message-State: AOAM530vpyUXXwaM+wtehs+XGbCGiNRkU1YbBB59C13hkG1u1IGZqS49
        dDo3UBltap5QIU0wYoMPNWGgQF4R6p/0bblS/+s=
X-Google-Smtp-Source: ABdhPJxaGqwHivIb7IbFrUUw+wf6mINM6/PpUsiYHCORYWcq4kVpOzMhUEKeelYl42BFPBq/IpSCHTgrETrOYHZxhgo=
X-Received: by 2002:a17:902:d713:b0:132:b283:37cf with SMTP id
 w19-20020a170902d71300b00132b28337cfmr8490820ply.59.1630070014885; Fri, 27
 Aug 2021 06:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com> <10db0fb4-56c7-670f-c208-adf5cec4b0fc@gmail.com>
In-Reply-To: <10db0fb4-56c7-670f-c208-adf5cec4b0fc@gmail.com>
From:   Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Date:   Fri, 27 Aug 2021 18:43:19 +0530
Message-ID: <CAA4dvxj+TqWGW83yD0nvdZOuevwPC=LN0ByHrCTsz3sVX6_5Eg@mail.gmail.com>
Subject: Re: [PATCH] submodule: absorb git dir instead of dying on deinit
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 1:21 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Maybe the case of "repo inside the repo", with submodule as repo?

I am not certain what exactly you meant, but this patch deals with "Old-form"
submodules. This link (https://git-scm.com/docs/gitsubmodules#_forms)
states that old-style submodules, when deinitialized or deleted, have its Git
directory automatically moved to $GIT_DIR/modules/<name>/ of the
superproject. This is what this patch sets to achieve. Earlier, running deinit
on such a submodule would cause it to fail.

--
Mugdha
