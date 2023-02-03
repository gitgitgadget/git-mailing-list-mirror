Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568BAC05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjBCRtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjBCRta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:49:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D5AD33F
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:49:14 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s13so2492588pgc.10
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 09:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZswNGISldswyH8mE9nW2+TTvcNm4XA50RvTXpIYxZQ=;
        b=KRGmCAnV0GZVSzVmOiFV8ioaFgECm6iJsO7eTHesmLTAwybIiRKH66b6CElzqtf94y
         3G/9skGoE5ICFYz6HSpeWeI1FABK1XtBVai+OeFjOpqTooOB1J450h8fQ4U/XRBK56Ei
         92r3La8wc4ZFgSAlDR+HK2FoIkns9ZAvPTlliQdgmJquVOqro/fymIK+ircChaK3zu/N
         gUVbODkrJyzsGQTJI9rkzdNuKUSNGmpclht5ClQavzim9rPD8KMYW/IEvsX7BxiRjd4/
         O2T5A8lDqYK9u5AjNUsID5g2IdHGt5GyKi1kvxkomDiROUEmkPxPgN8mkY7pxDdsxMMe
         SHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZswNGISldswyH8mE9nW2+TTvcNm4XA50RvTXpIYxZQ=;
        b=OQH8CcQY6gcV8+WoSxjHKcbUUgX0fTPS1v8Rnmqp0C1M1+YcrHT2wTSIAy5dT10OA9
         mfYioR4xxpb9ksxSZn5glQGvnRlchtJmHBTVevrLPDXy1idZ8TGvShscyRI9+kigXwUB
         ziHxjcZ2JXBSxNicTW/YQbdSF0VkRrz+KJQ/GPo/DIRlznX3JwXF44BBM5fCZ+J3OgAY
         lsvY/C3JYAwdR3HoMAZf1e7R0wapicjks/XKAFhxvX38HE2P/RNCOVDLefvpP45HsckJ
         My92PGHU+0UG3X1vfAO5Jlu5wwC9HcxOlyBrjldmRgJVB917zLhwXH4t69mBUn3KhCEn
         A2Pg==
X-Gm-Message-State: AO0yUKW9OQtnzJY3qAj0GpJVfveA9iQJUPKrnF/mYO0oOJS1N3y8uuxG
        R8fiAL0c8GsLikF3VSjSRm/9sLdfW6ZuYzt2
X-Google-Smtp-Source: AK7set8pexCb+UQW7AFXLuEIr+OyeIdYXZJNXIbNlczk9hQItoyQWq0raKDh3ySirrCzeWIhJY7dOg==
X-Received: by 2002:aa7:9f87:0:b0:593:af5d:7c26 with SMTP id z7-20020aa79f87000000b00593af5d7c26mr10081791pfr.20.1675446554225;
        Fri, 03 Feb 2023 09:49:14 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.182])
        by smtp.gmail.com with ESMTPSA id q23-20020a056a0002b700b0058d9730ede0sm2067947pfs.210.2023.02.03.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:49:13 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     newren@gmail.com
Cc:     five231003@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
Date:   Fri,  3 Feb 2023 23:19:10 +0530
Message-Id: <20230203174910.123441-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABPp-BHE=zGT_vPW8+TZn-wqmufhVdGQT-=LXoLQkto6TMrnrA@mail.gmail.com>
References: <CABPp-BHE=zGT_vPW8+TZn-wqmufhVdGQT-=LXoLQkto6TMrnrA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now, I think I understand the mistake that I did. Even if it did work
for one merge strategy, the code would not be good as the helper function
is not doing what it is intended to do. In any case, I should have been
more careful submitting the patch.

On a side note, I think we can now close the issue #1156 on gitgitgadget? As
with builtin/merge.c out of the way, the only other case is in revision.c
and the use of the helper function there is inapproriate.

Thanks for the explanation.
