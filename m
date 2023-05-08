Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD11C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjEHVkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjEHVkb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:40:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B59015
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:40:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaebed5bd6so35571065ad.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683582007; x=1686174007;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYvHdlkcVL8Lm1YHu2LmUYx5Zn6V9tGHfdD6ZZHyK7g=;
        b=O0edikJ0WF4MRL/Hs+d0yfkhQkPHOH7f4aA0aEDcQOYnn6d5S3lIfXWqCxPLJqXtby
         OFFvZacSBHzrc2Dlu0rxO5s0qqIQSimE25ZfBpvCS2iLJzTcQFYx+v7sJ0ruZ3Ug/YkT
         rgRCBGM1ElSLFQUSvoFFzUZUmdzbllsq/Jkufll1XwnqRHGQC0O4LCJN82ml1LHCX1ZE
         mKcF/9mOGdAy2k2WdACWQi/Fw9viif+dEWdCPW9NH9IVfwYIKCpuDtUbBi1KExsh30Tu
         lYl8imkX7P3ILjwT6mr82RUoz9YV6c9XFB5Osknjgk79w7giW1Wm/JBvxAqYrQyXVIjV
         D8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683582007; x=1686174007;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYvHdlkcVL8Lm1YHu2LmUYx5Zn6V9tGHfdD6ZZHyK7g=;
        b=OZc+EwnbV/ZE0Dm4oFJQOWJ5Gsg+73f/ZbjvLACOVTbn+36gIEXns6KYflqM5+ZIrc
         pIhpAQ1OAwEfljKv4IYW/H1/0G6lLAnO56xX16/cnXUORxUulidj20i5KyKNztQj8ukX
         GB/WBbnGSQkvjHw5DEG4L5S0Jv1Xo2I5OisbBG4dLXp2C0igDCYaaMqALtSYE7cEs0gG
         k9ymEcn+FKMRNdYRwPJRE1XJgZp73PICw7qVvJ9PFzANlLtXbSJXwmzfz/JWXhRdB8hp
         j8rPvIqxMkRt30UAIX5PViVfwxTWHvBZVtjxL/nhY8NXwL3aP2qsdNQiDUkZK5IUPkl7
         SwCQ==
X-Gm-Message-State: AC+VfDzAc6gfKB9HAtjlcWNrPIA59Ek4VO7onuPDDhW0AOqXPFyyyKkJ
        zQLprCa9gR2dj4fAoezknjoAdTw5GEI=
X-Google-Smtp-Source: ACHHUZ78AvAhtTupKXskoXIVWjmw9AEIENoc2o6/t3O08FUCxxQKl+F3+gkOSdf5SoZ1snsZwb9WDg==
X-Received: by 2002:a17:903:10c:b0:1ab:2b41:613 with SMTP id y12-20020a170903010c00b001ab2b410613mr9816672plc.32.1683582007467;
        Mon, 08 May 2023 14:40:07 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b0019719f752c5sm7684011plf.59.2023.05.08.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:40:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #02; Fri, 5)
References: <xmqqmt2ibcq2.fsf@gitster.g>
        <cfb5fe88-d270-62e3-01f8-ac53049ebb63@github.com>
Date:   Mon, 08 May 2023 14:40:06 -0700
In-Reply-To: <cfb5fe88-d270-62e3-01f8-ac53049ebb63@github.com> (Derrick
        Stolee's message of "Mon, 8 May 2023 16:59:49 -0400")
Message-ID: <xmqq5y92mrih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This has been marked as "Will merge to 'master'" for a few cooking
> emails, but as far as I can tell it hasn't even hit 'next'. Is
> there a reason for that?

Thanks for pinging.  Buried in a huge pile of topics.
