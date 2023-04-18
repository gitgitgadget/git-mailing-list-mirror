Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD6C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjDROCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjDROCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:02:46 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869C13846
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:02:45 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe82d8bf5so145694947b3.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681826565; x=1684418565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnEKHVTxD8V/L4Gzq/sALI3clkfe+l8BvahH35lacM4=;
        b=QZhmUAgBUEdYBQhoQL7/qCs7YpmgJ0WybqrZGPj8G82AoWX6zEueMafQb1iTJOuDK+
         6YwPXtfwMWIPFCRw86WYz8HFItN0ROj9hXakdBA+WB3hZnQ6RpwDa1sjDz2mhdWD9rYG
         ErzOZztYdZHyDf/mEYX55pDa0umUHRVtPS/M4MpmK9eFPFAx6KlG6vwQ2TkK/tgbGi7y
         K8l8QH2iv2dRd7grurybB4PO3gtXK8+Rh2EX39xHUb8o8tTL7rdRZ7aK9dpHoTUhIXjk
         irERoVRzZdpMY+EIDaECXuI5XDgn+8VK5ZBzvB2w29IPN0VS6ypvPH/A6guC0a11zs4E
         w6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681826565; x=1684418565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnEKHVTxD8V/L4Gzq/sALI3clkfe+l8BvahH35lacM4=;
        b=l1pmKs+ZBZy5m0w4cxquVjZ8IEqSXTiyqS4LmJM27Q5qjEA4BL8y3/EXXMWnc3eGxU
         8knTfxR7KNiYBuc2ZI0YP+x6erKj2yVupBIdAf04FizG+klnPZScPkFZ0Nvh0XCh5c2i
         lXHpD9qLYoz2UC4fhioX3UwhEn9yyO9kzOEY8B0Eg10BL4f+tNbmmTJXAid9i5CJirxr
         r+TjFR2HXieKaiCNxGTcvS2wntQHUjDpgBnHVT3yqYPaTR06fXAPZ9qk7URn/isRj4QL
         x/hSLfupWJ9yziEW6KFXIKHvuJb/scJPA8j7CAF5Vtsk351/a1XPILh7h48WhCLYrY3B
         aN4Q==
X-Gm-Message-State: AAQBX9daf+6iei7hZOjZTrlWyXTWcNCWO4fqUgNBiay6HxKZIOfTqhHS
        Xo1FwIS5eoYS5Va8oFeYOpMC
X-Google-Smtp-Source: AKy350Yqz5D3XtAZFZiDCWhInvap0fSHwY8nBmm8u+RkrL6oC8yhVgp9niTKJ9ZTzJN/v/Timbsz5g==
X-Received: by 2002:a81:a005:0:b0:544:f3ca:1c5a with SMTP id x5-20020a81a005000000b00544f3ca1c5amr18424254ywg.2.1681826564969;
        Tue, 18 Apr 2023 07:02:44 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id da6-20020a05690c0d8600b00545a08184b0sm3758335ywb.64.2023.04.18.07.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:02:44 -0700 (PDT)
Message-ID: <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
Date:   Tue, 18 Apr 2023 10:02:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>, git@vger.kernel.org
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g> <20230418041253.GD60552@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230418041253.GD60552@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2023 12:12 AM, Jeff King wrote:

> One thing the commit graph perhaps _could_ do is omit the commit, or
> mark it as "this one is broken in some way". And then fall back to
> parsing those few instead (which is slower, but if it's a small minority
> of commits, that's OK). But I don't think there's any code for that.

The "broken" commit would need to be included in the commit-graph file
so its children can point to it using a graph position, but then it
would revert to parsing from the commit object (due to some new concept
storing "this is a bad commit").

If we decided to treat a timestamp of 0 as "probably broken, artificial
at best" then we wouldn't need the new indicator in the commit-graph
file, but this seems like quite a big hammer for a small case.

Thanks,
-Stolee
