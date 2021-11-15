Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6769C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93806321B
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbhKOXBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350825AbhKOWdq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 17:33:46 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C991C0F26F3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:44:57 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e9-20020a170902ed8900b00143a3f40299so3606732plj.20
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sx+iRBE4mJLjlyNaur0Q7w0XmxyxKbHANQ/xvT8/mD0=;
        b=s2tYpPLVidGowSzLX04KeSLWNwQeYRHp9/zBZCJVu0Eyr5s/zj344aHWmX54JIoZjt
         fD5b2IJLDzDPveWvX/R7X1UZ6yBYN51Sd3Yrj2c0Nq70oJUJRz7q33N/BEEPDwstXOKK
         6KVBHZRZhmxStVGELDEnIhEpxz4BkMYu5CWmVSlqHegZBzry8B5UBXCsrBVXLdUfoIjh
         r6TLS42asxP1kNtouF2YOXF455kfZofnng7ZT7MkDEQd1hlpg2J3cagNS98n7z0vZOOC
         58A8Te0y56MK3d7B73arlquOa5lbjbY6ZzQ0faWobkdoO5/yF3wh0OeYxXIdnuHdxepP
         pU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sx+iRBE4mJLjlyNaur0Q7w0XmxyxKbHANQ/xvT8/mD0=;
        b=CrhbNVp6Orb+JYNWVVvChyxzqX9t5AI4Ym6usWSlhARfR1EEdvBNg37VpG0VytexF0
         Hue7qxFqXnf07Pt18xRM/cfdmZvc5mvqfPDgMV5qgO6SJT2TRLDQXgg8V4vbOyq8qjJh
         fDuwaR8LwkdzDx6aCgJ7DqsZP2rYgmK4l4OkBiM8CKrLbFVlNwvYNfRUgVX95bulL6e9
         ytICh2dORllU/HuaUy1JUgjuyTPC2cmZz8uYgnKUWJ29On+FlChvP896gWybwllOexxX
         phGgKmPSinoq9qMKlUVNM3vxSNmTxO8N5P+X5Z20uIPsiKIDFNvzQSEBZLjW8zyK/P3v
         IKbQ==
X-Gm-Message-State: AOAM531KBZxYgRYlFby15ukrGX2CA10ncVsuc6iWzcePGfYHJRtxlq/O
        I2O4elU3OUQEJZjur1/bGFZhLbZJ7YKtoA==
X-Google-Smtp-Source: ABdhPJzgt/+36ZqvHAZG4f9BhMS5AfMICfRRNX1tf80GKrSp60Jbrh7sXcI6uKVTVMcsxSdmj9EHrHrAvwx0TA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:3d4b:: with SMTP id
 o11mr9pjf.0.1637012694573; Mon, 15 Nov 2021 13:44:54 -0800 (PST)
Date:   Mon, 15 Nov 2021 13:44:52 -0800
In-Reply-To: <20211115185545.1082815-1-jonathantanmy@google.com>
Message-Id: <kl6lilwtt7or.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211028183101.41013-7-chooglen@google.com> <20211115185545.1082815-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 6/6] remote: add struct repository parameter to
 external functions
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I don't feel as confident about this patch as I do about the patches
> that remove the global variables - as you said, some functions might use
> the_repository to parse OIDs (or do other things). I think that part of
> this patch should go into the next series you have planned (as you
> describe in the original cover letter [1], when you make future
> submodule commands be run in-process), so that they can be tested.
> (Removing the global variables was more of a mechanical code change, so
> it was easier to see what's going on by just looking at "before" and
> "after".)

Thanks! I think that thematically, this patch belongs in this series.
But that is not worth leaving the code untested, so I will move this
patch into my future series.
