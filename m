Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D8C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiKKWZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbiKKWZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:25:39 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C23654C8
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:25:29 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r81so4566344iod.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apdYcTN2DS3Iumio3/anz7kVywMUMccF9py1gHPU+to=;
        b=IMTDqh19kfkTvXN3/ItWaVYFIVtk6zBvsv4llUebVncRl34AJQdV4uQLx+N9IQDVav
         PgRjOwqSUk31GD5dQlmM3T902b9gWTd94BFUkRy6bioQnXH7oNzSKwqDpXw0x0YrTN9/
         e6Gtm1jvWQ5SuD8Y1g0+0t9oqSxlVto8g6q5e4W4uzxoOMNNfPl3XljYLf6ACbwIR8D6
         N8DEFKRefGGVTrN0xAbeMaW34XLh+aUYyru/ye4zGP5UhtrS5i33PIASaKjGtxFZq+6o
         pjuVTtMhswVynjtOAiLMb3i03naYQ3HP0xcYnINs4AQ0ubADUF0KYmvJZ/4LGVkzOaA7
         aNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apdYcTN2DS3Iumio3/anz7kVywMUMccF9py1gHPU+to=;
        b=5/X85Szsx5dM65sUET1LRqFnwhnpOpuP7Y/v4g19Q4IJBzYlewCv3tBKHCfUPCAkiG
         517mNI54/sirNbrVkpeM616m7bFNcecyD5OswkVh8HZafcV5YfU4dzmYK948xSXWtSbz
         bYGmnUFXQT0Y6i0SeIkE6UaXmeojqsaNRo3XgZYHz1hru0XzUCZbW8sRZa5y38CvDWHX
         1JLF8hWkKDwPKCaVcGw+hK61NkgfAcFMlzAAYOfOlaJq8nJl6k+qx2Tl6E6g51QuR604
         R635y5MlEnb79Rp/S1Qd269+CqVMhZjYz0uy6b5HfIdEeEiQG6UMUYE/lE/AZEpgCU8Q
         /49A==
X-Gm-Message-State: ANoB5pkK0xpTyBoWmQ+wDop49JTRf5xZbfC6ZFYLjT1USp6b8RwLqHHh
        jVbmi0YZZriK2l4N+c73/wEFkg==
X-Google-Smtp-Source: AA0mqf4Wj/cLA+SKyk2A6CittpQbT13F6HLr0mjqaJrn29C8Oj3s0p03lOyJbe/nvCVJDU7FfIyq9g==
X-Received: by 2002:a05:6602:418d:b0:6a3:8925:be51 with SMTP id bx13-20020a056602418d00b006a38925be51mr1881664iob.51.1668205529233;
        Fri, 11 Nov 2022 14:25:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p1-20020a92d481000000b002f9f001de24sm1302623ilg.21.2022.11.11.14.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:25:28 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:25:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests(scalar): tighten the stale `scalar.repo` test some
Message-ID: <Y27L1+tS8yvGlMSZ@nand.local>
References: <pull.1415.git.1668065327120.gitgitgadget@gmail.com>
 <83b9ff0b-a655-714e-a8f9-44b0d1ac3177@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83b9ff0b-a655-714e-a8f9-44b0d1ac3177@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 08:56:41AM -0500, Derrick Stolee wrote:
> On 11/10/2022 2:28 AM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > As pointed out by Stolee, the previous incarnation of this test case was
> > not stringent enough: we want to verify that _only_ the stale entries
> > are removed (previously, the test case would have succeeded even if all
> > entries had been removed).
>
> Thanks for tightening the test!

Thanks, both. I merged this back into 'js/remove-stale-scalar-repos' and
will re-merge it back into 'next' during the next push-out (probably on
Monday or Tuesday of next week).

Thanks,
Taylor
