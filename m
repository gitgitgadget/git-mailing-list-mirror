Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE859C433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B488D65011
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCEION (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCEIOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 03:14:12 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A6C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 00:14:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o2so628383wme.5
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 00:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ylzCn+8a/+C0xjx7gQOXglVTIqkX4M14AjgPhmVNXvM=;
        b=WinT8sdk1ckUGC49nvGL7RclDPM/Meh8wbgzi7FHrX22WUXKlHOx31fYKgqlj4Vymi
         k0zo15OWUEyCECBRfiaZWzTVNHkbKgQGy3AoJ6jpwxZzyQ4pMPtJbD3ZtQnuszrURnb2
         JlfP2yj91BdGS6G1iGOXCwFSnp3Gt8/Q3IkzJEHkAEeqlWHlKHWEJP7nyRSCJyzGv8nY
         o62JE+N2NUlFeFzksw5+FoA2rw9W97K8vgz0CErtKasT922i5memdHij49gcgPf1kezJ
         Tt4mTnsNapGJMZ2SU5t4m2CGwR2Qrmlu7dfKvpSul0hvTr5J/Vl5eU1rcZy0ArjZEOug
         8k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ylzCn+8a/+C0xjx7gQOXglVTIqkX4M14AjgPhmVNXvM=;
        b=G5jHcRXFPzYmqbE91IjHAiJONyjWcPtqCcGuA1ni3X/BzSjPY2V+HbuwGYFOFpoRlp
         d8rbR9r/vTUA4zds7sfHPp6bFHXePnl2s3WGu7SDYBtyQ6MregZaDekPdP2CvXDq0NQl
         hfP0ro9YjDpuBDYgm/3jYrPGkM8AlUyjkTL19o4E34MVu7ZgLtq8xLQSkwt63bVeilPk
         SR6i4jzV7HN+TFikDNk4hFESnEqU4VWPiU7U5bZUB3EPyUlyxVLhy7uske0H6vO11cE2
         OvN71QVTwhxE4Yw0mW5pi4xH07WHllKmONh8fQYI/HjZ+57wB8bz+wxmIdNACKwXXTxx
         Jxfg==
X-Gm-Message-State: AOAM530sYXxSVS0KYhS1qLFQyPaG6t5bGI/fj09HjSqmyRhBpe3TGlDJ
        tMYs4VV0cBw/q4GNx0K98f6CQLBcTr35agE/DLR12a0=
X-Google-Smtp-Source: ABdhPJypbMJXlv596sXWjWJ3VFg/KXr7bcUJ4WqWqTn+XpKV11/rBi7rX2uGKdk/QcfYt7OTo5w4pE3kvKfXTGbOY4U=
X-Received: by 2002:a1c:1d82:: with SMTP id d124mr7725720wmd.1.1614932049289;
 Fri, 05 Mar 2021 00:14:09 -0800 (PST)
MIME-Version: 1.0
From:   Stef Bon <stefbon@gmail.com>
Date:   Fri, 5 Mar 2021 09:13:58 +0100
Message-ID: <CANXojczh98ax2KwsaJg4CkusgrUWvhH0yG-u6oSW9nwwMLz_iA@mail.gmail.com>
Subject: Possible to use git over custom ssh libraries?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working on a set of network services using SSH, like SFTP, backup,
fsnotify, (text/video) chat, connection forwarding using my own SSH
implementation. See:

https://github.com/stefbon/OSNS

Now I want to also provide support for browsing remote git
repositories using my ssh libraries, which will provide the transport
layer.

Is it possible to use git in combination with my own libraries? Or do
I have to use libgit2 for that or something else?

Thanks in advance,

Stef Bon
