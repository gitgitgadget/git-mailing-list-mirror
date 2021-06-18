Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34B8C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92C161279
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhFRVua (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFRVu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:50:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B3C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:48:20 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b17-20020a63a1110000b02902231e33459dso1409990pgf.17
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n+hiDmU7QvdacyHHSH5WR58p32RYdPV7IWaEVxmb6GI=;
        b=Sx8vSS7tlX4bp5Ms6a0em48TdazRHbktEGJ4jt70rZ6ld6dGs/vuk6f/D8Eqn8fqgT
         4TnI73IitqzPtMd4H1zJ9CkWnI2iNwcyJr+YJ3tTXeQEZZLF9ybFBvASdJHSgGXOD5B4
         q+gfj/QgZ8MllZfhSBo+Q7Q1guCKL+gxSu1lHGRIGJ45g+PdKMLoABb3lurM9QQN7llR
         9KT6eGvSvviYCGrs24uwsTLvffBWxzDMFwuOunsobtFHLoOT9HWnJc9r+9kVZ8NsneyS
         8vmCjONUPt8HuzsWX3owABWsg0kDnd76rYGahAee8eEEMT9oKRckdiokeXQlRFOJQoxB
         Y6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n+hiDmU7QvdacyHHSH5WR58p32RYdPV7IWaEVxmb6GI=;
        b=VTRgcJ007Ze7xoHo3y4Q5wX6hCy1TZN3V3vpu4yhSG5+olfuNz3/GCydg1geqeuobk
         +8vYrMzJe00Y8IS3XBF3+hfMPbg+c5rfIgOLXI5kaml5KWyVZ9Vhm5J0VoaU9gvy8y5e
         n/zNC8t5OMGA/KBkFLjf75zE52hqx8WxhfAvlRLx0o3w8H1qWMJdmGv0dWjAHsFBc+l2
         URIqLMU0c7XRnX1thwiLvoWDNn8mOL5LxW4XLctLXzDtL77orTkXLoO9RA6bj796Z2eg
         Zanm2nFd5bOoGCb8Z+eCyP+De2T+JVU/rZVxo07HkUUN3zHcHtx719b5GiKZNMst1eRz
         2NgQ==
X-Gm-Message-State: AOAM530ztp2FehVHdgMjWiE2vP8iuyiOfAWYKXxXgTw1BvYUGfe0KD00
        dJ5Q9/ee8oSadMJYXwYJCBtiJpWLHqOV9WkHZW0P
X-Google-Smtp-Source: ABdhPJzWkLgf2TzsTjdLbX8oSTYAAgHu9UnI3sZZpdqt3hnPDBFIQkXkFlZY3n9Or6BupDzmKEM3Q+QE2O9WS+Uapy3Z
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bcc3:b029:11c:5ffb:61fb with
 SMTP id o3-20020a170902bcc3b029011c5ffb61fbmr6569304pls.18.1624052899500;
 Fri, 18 Jun 2021 14:48:19 -0700 (PDT)
Date:   Fri, 18 Jun 2021 14:48:16 -0700
In-Reply-To: <YM0JOyxPGYmzynoc@google.com>
Message-Id: <20210618214816.793345-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YM0JOyxPGYmzynoc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [RFC PATCH 1/2] hook: move list of hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jun 16, 2021 at 04:31:48PM -0700, Jonathan Tan wrote:
> > 
> > The list of hooks will need to be used outside bugreport, so move it to
> > a central location.
> 
> Hm, does this fight with
> https://lore.kernel.org/git/cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com
> ?
> 
> This patch itself looks pretty straightforward, but I think it is a good
> idea to take a look at avarab's change first.
> 
>  - Emily

Hmm...you might be right. In any case, this is just an RFC patch set so
I presume avarab's will be merged first (and then I can use his hook
list in a subsequent version of my patch set).
