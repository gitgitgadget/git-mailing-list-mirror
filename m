Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C684AC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 23:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbiECXPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 19:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiECXPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 19:15:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F7326E2
        for <git@vger.kernel.org>; Tue,  3 May 2022 16:11:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d22-20020a25add6000000b00645d796034fso16815557ybe.2
        for <git@vger.kernel.org>; Tue, 03 May 2022 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=kBeayws+jLeG3DKCErWCnmC69SwmsH7YKWTFGxPERw0=;
        b=WOovkhcJdgbZQXhve25X9stsURb+alJDr4LbpUi3tfN40xiEuRca4JE2n23Y5JJlwX
         7NUvQvwLBI6A3Hg0iDTXhJFCOrhuf3lU7vl+Jb4nrQ4djlPfaol4U62I8C2+rv4ZBna7
         gwWcruaY2TODvP0aY/B3lmRXvvQnDthucg9nnXFrcHlMMPcEMScuG4uAIYGXztaZ7i6i
         B5kYXL0T6UWaNOEFAYxGhq1Hveso+n6lqv9vFLw76YWvRYOvc/nzmGMtKZL+dpJaxCi+
         wXYu5EHaemL7X7Od6c9D9qQum/9PLSs5/YtHSZzZT3Lj0/PCwqJlgwBgYZTk3tc6ntHB
         B8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=kBeayws+jLeG3DKCErWCnmC69SwmsH7YKWTFGxPERw0=;
        b=8PKmIZfKIZFfRGMKwTHPaoTujPKk1mrPBs93XHvzQf8o1jL6QRHQBM4l5iFqcIKMp/
         XABpXJtsVB/bWw8+mH+ZgkYiHHlXFUnJWgyHvrz2DLwan6jHqygI8yPB+5sZaVnM8H05
         /E4gmJoRUbIoiJ6spiYwxIYU7NifeQm7fHx5fty8lLqAmxPU6FdtLWYSGqqhNDBMhy1e
         AOSJbLBCrWrDEriuv6kazpTTSfxtPXax+48gvkyNQwWwQf+xHokPUJuR4pnA2JxWgL/c
         ONzUDJM1LiOejAEomKMULCdoHCeKL8DXApScI2tzjom+rmbhYCK31RPJicne0KMb1BCL
         Pcfg==
X-Gm-Message-State: AOAM532NgASrv0TZV3bNTJqBcGCkGx8zkdoUsrkQknyRvM3SzWQdYEIs
        NHXz7QHcC8+rSpTu8IpC1XYOiab9FF9tmR4MDkTl
X-Google-Smtp-Source: ABdhPJw/XbJmc5u0+MaMpCVQDFC+TRmeVkiYvEbsuOsFY6qgbnbdOSU8UnCYfdmpvrQBHpibAcssbPvi2DSjGU760ymV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:215:0:b0:64a:c05:7082 with SMTP
 id 21-20020a250215000000b0064a0c057082mr691556ybc.188.1651619501601; Tue, 03
 May 2022 16:11:41 -0700 (PDT)
Date:   Tue,  3 May 2022 16:11:39 -0700
In-Reply-To: <20220502170904.2770649-5-calvinwan@google.com>
Message-Id: <20220503231139.4171524-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: Re: [PATCH v4 4/8] object-info: send attribute packet regardless of
 object ids
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, philipoakley@iee.email, johncai86@gmail.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Currently on the server side of object-info, if the client does not send
> any object ids in the request or if the client requests an attribute the
> server does not support, the server will either not send any packets
> back or error out. Consider the scenario where the client git version is
> ahead of the server git version, and the client can request additional
> object-info besides 'size'. There needs to be a way to tell whether the
> server can honor all of the client attribute requests before the client
> sends a request with all of the object ids.  

This part explains the problem...

> In a future patch, if the
> client were to make an initial command request with only attributes, the
> server would be able to confirm which attributes it could return.

...and this part explains what we want to do in the future, but this
commit message doesn't explain what this commit does. (The commit
subject has something related, but does not have enough detail. For
example, is it an empty attribute packet?)

Having said that, the way we usually communicate client-server version
differences is through capabilities - is there a reason why we can't use
that here?
