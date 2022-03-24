Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1229DC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355316AbiCXWV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbiCXWVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 18:21:24 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D97CB20
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:19:52 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 77-20020a621450000000b004fa8868a49eso3203487pfu.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=tigJj70Y6OIVscQooD7mYWM1Mki6i4AhkAuvWDLghZ0=;
        b=jaSiYuXHOAUfIIVry5AoC45vHzjGx0CMi0+1/9Lldmqdt/PJi+Cof2t/1YxLKDjgQM
         EqCaO7PME+hxECteaIak3YarjZ7bfG2kvouoeGi3aHgKmYLvU3ajM4ZoNYEaXScEiabY
         Of1BlxaIrlfLJlLiONnzltWUk+hCpoegEZJ3s1MGIKPXKr3QGCXHar6YzC/JIrON7Xlz
         MQfA4XMldARq6piXCOUcBzOC8y3W/CVL+crEIth63AF4JtSP/sqHI5625TezEI98KXmZ
         e9lpzefZw68wW6YA8bULJ5iWsGhg5W3FHOPetiPac0MWjd0+cg4leek43U5s0cciATeS
         AA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=tigJj70Y6OIVscQooD7mYWM1Mki6i4AhkAuvWDLghZ0=;
        b=5pWRqFUwr1wbupuhCt24HrmGG184m512tqUNmUmlOI+8ExMlYCsgk1gjbvVlyJBU7k
         g6MhVZ02QKaoexQ1Fhv9LwJnnXEhbMGvqGu33VbvX1+kQH/UJZ3yg8rmWBC5Gmess41V
         2QaSsVPg2tCG1gPvsySyghhOn1hs5/RJSSMUxeFnNUjwuVH3o3+awZSLGQXMQ9frisi5
         wF/5o94IKvx2yKlPnBzUk0LkuIWXiFJwHrG2XFItoO4lKJKy7IQV/iocj9GOkkzxigMt
         ypo4xN1v+Nd/nLWetHUyzlToIORxaNpRRLPKuSPp+NY6UR6vapQBavG8giL6uzkfwCw3
         FLrg==
X-Gm-Message-State: AOAM531bd1dDJiRl4zZUPx23t/2RNWYGJbPJhVPM+SIM+skikhiUnVIy
        kvfgbtxZfNsXeCtGFwBgJDtDyrCt4QGzI9sOQ9Wc
X-Google-Smtp-Source: ABdhPJwzS277e19vFWCKuuLcy2uYtn4VVXoA0f/6cAZEbzgyyz/j+COMWDab08JhwDXuDJfQkjRxeDv2afOQqp9ISrrO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:c85:b0:4fa:f806:10f5 with
 SMTP id a5-20020a056a000c8500b004faf80610f5mr3680986pfv.43.1648160392014;
 Thu, 24 Mar 2022 15:19:52 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:19:49 -0700
In-Reply-To: <8f7ed9c5-9be6-55b4-f95c-40bf11d9e9ed@gmail.com>
Message-Id: <20220324221949.1325809-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:
> What about fetching with --deepen?
> 
> Will "unintended" unshallowing with --update-shallow possibly happen
> if --update-shallow is used, as opposed to --depth/--deepen?

This does change the graft status, but from grafted to ungrafted, so
instead of trying to read parents that are not there, we will not read
parents that are there. Which is also a problem, but more difficult to
demonstrate why it is a problem, I think.
