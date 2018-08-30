Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B5B1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 15:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeH3T2y (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 15:28:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37257 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3T2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 15:28:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so2435304wmc.2
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QmV0SbC1fvynr+FLWviy3je8Q31PTg3U54agwu6KOlk=;
        b=QtOjxLa43pEwxVqrd3vMK+JSXjLRFekG9N9hiVegq8HK5DwMTuHRSKs+MRyYVT6Kgd
         PyegYhwLqvZNX+0wrcBELO/eSqGEfqmJ90kShx8+S4BTMKkxDKNQo79JfY+cMRjEdpjc
         JCJaGLLdmw6L9YjNATLJFYoU/er7kIpD+irsBLGobBetPXG5IYxB4Smiszo4y3D75aLz
         Oc6bwpW8MOXKLDYab2tzxPnGHg7yDNEm7cZe6WHKm5umsmZiAF5xgPRt4rYj/DHx+XPE
         Mn2LH3uUPv1OVX7v/MHvvJBeSGOMHqPxrm9E23jYM/wlAGVkOfLVCtGwqSstG66UCEIZ
         vk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QmV0SbC1fvynr+FLWviy3je8Q31PTg3U54agwu6KOlk=;
        b=HIrSyAzacKJerHJAQ3smsqRwr+zqMEhNz0/qA7kqWaLCEHMFevDeRFT8SbrwKNhPCV
         DUkOc/EZkYtImfnbnJ806NSgzBIc+GGBtu1dbVbjU9cj+t/QQLcSOJPpyQpKc/HHw6O6
         lhgp/9YXV0PTMk3Qt6kdEprAo54V9Jz+9JRCMvv6L723psjFyDJtM3hTPrF66bYwL9m3
         kRMLhmRwjFhIOohNusVBF0Wp9ajhe4y2s7lQavEQrUXkd8QYaC99nK6KhYeAK45LWQHs
         eSLhPzqrWOGhtfauzRjOrEpz1mp2HIlq+ZxBEKjRo8lgFy4Sf1vPp51j1Fy7KXWYc2jy
         BClw==
X-Gm-Message-State: APzg51AYVNzJWw8oU3oXtGVpjfRusYxhUVxnzYhXDtMqIsgqsW/CT5K/
        +qIpzwwpWTCVbGw7TF+uofg19YnD
X-Google-Smtp-Source: ANB0VdaF/HS2oH+zhiq6Z+ITrh9z/KI+1Bqodhvy9PIFy8pWNMHuG0i6/7qztuRzmr822vWeNPL34Q==
X-Received: by 2002:a1c:c4ce:: with SMTP id u197-v6mr2088638wmf.10.1535642771403;
        Thu, 30 Aug 2018 08:26:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v133-v6sm2515903wma.36.2018.08.30.08.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 08:26:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com
Subject: Re: [PATCH 0/1] v2.19.0-rc1 Performance Regression in 'git merge-base'
References: <pull.28.git.gitgitgadget@gmail.com>
Date:   Thu, 30 Aug 2018 08:26:10 -0700
In-Reply-To: <pull.28.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Thu, 30 Aug 2018 05:58:07 -0700 (PDT)")
Message-ID: <xmqqd0tz7u5p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As I was testing the release candidate, I stumbled across a regression in
> 'git merge-base' as a result of the switch to generation numbers. The commit
> message in [PATCH 1/1] describes the topology involved,...

I do not recall having seen this kind of updates during the
pre-release freeze of previous development cycles, and you are
starting a new trend with two findings so far in this cycle.
Hopefully this can become a good tradition.

Thanks.
