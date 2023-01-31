Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70900C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAaQnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAaQns (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 11:43:48 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0D268C
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:43:48 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o11-20020a17090aac0b00b0022c579ce0f0so4410409pjq.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V43UXLh3fvNZmBSPK0IM9yvAsrIBhm5hmKYWHLv6tBE=;
        b=iwWgYsgtzwT+CulWwq1QPG44l6ZtlygL2Ak+eY1gbIp69pUugR5vdQskNUQHmwqw2G
         8iQz2Jx1SOb4UVsDWi2ShEf3trFBgydZ61FCfAHG09lUHSSnEiTvDuOFZQ7haOTllXPg
         3zKTybhGaGIPRMqU7e7x1EJ+xZqCJZYLWRMXyoDzwTlqtyxZyGiQjrWxP36EfxKO1c0D
         HBqjf3cF68rJ4WZ038eJzMMOpFEZScfXUFbsSX4cxWKq838MQHnV6Q1OllCX7i4RwYQ0
         E6aQBHZvZnp4DiOGtJJoRLTbqDTqWLHTzAkxddLbRfuy0nR/qhFfL2seyB9epDk7ShVt
         +dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V43UXLh3fvNZmBSPK0IM9yvAsrIBhm5hmKYWHLv6tBE=;
        b=6q3brS6WQ6PmtgSocoe3VYC+NalniD2IuGxhziwl263wtHjXXvpp3f0uV4QjPNhUQy
         pw6VwpNuyHhFcGtzDUAEFuhNXne9aKGd6Q/Uyxwt8IwOQZ5h6wuu8k4fNZ43RMqP9yzg
         RXghIntH60YnAmjZduH1slW9VyLoRCA+KZJF0+tlZtVHWJOXu0SKVaQ3St4FNIw4JDiz
         rA9Ca9ZGF+PdpZHR8ESz5+YysR22RN8PtAEwIdJYEZ14KSM5s7PNlEqENbEJ6aCRl495
         SwATocOECFXq8k8SAuuuGRo1rUthNCO9w2eUshB4I8m6UrRWYKNlX/eN6MKQ3IJL9Tsh
         siPw==
X-Gm-Message-State: AFqh2koVLFjzFU5dMU73ugoB0oAI38TdVm5+kwgdlDCB1+UB1DH0NYeT
        SY0PkjiYRKOOWLdRlftOQwxGxnNrvmDneOUCqSvrBjpPH5vE9FhQPV2rUTKb5ZnO7rqYXm1G+kc
        n208UoM3mdUoWWz9YbENwvVR2IcaYjHnnWx59mKHD3WCPNM8+NXsPikzYeAgbmZ4=
X-Google-Smtp-Source: AMrXdXt8Gpe92kSK1R7tPE0ifUuQqw2ni/XX9/moAAsZwHszm1TRJClhG8G3m9pDeQSfRV8DdbxYOmvWhQWQZQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:6acc:b0:187:3921:2b2d with SMTP
 id i12-20020a1709026acc00b0018739212b2dmr6423982plt.13.1675183427235; Tue, 31
 Jan 2023 08:43:47 -0800 (PST)
Date:   Wed, 01 Feb 2023 00:43:45 +0800
Mime-Version: 1.0
Message-ID: <kl6l357qy7r2.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: gitformat-index.txt has a gap in the "mode" description?
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


According to gitformat-index.txt [1], "mode" is 32 bits, but we've only
documented 16 bits. I tried poking around read-cache.c, and my
impression is that other 16 are just NUL. If so, it would be worth
documenting that they're unused, especially since we documented
unused bits right in that section.

[1] https://github.com/git/git/blob/master/Documentation/gitformat-index.txt#L84
