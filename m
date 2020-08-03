Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BCAC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 12:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5288B204EC
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 12:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a70gYZbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHCMjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgHCMjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 08:39:09 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F2C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 05:39:08 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ed14so17228604qvb.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XrsSMvIfRoWnaF0vM+34c0iAl3Jm6mF5PndunVcpoiw=;
        b=a70gYZbj5JYA7tcJYbig82Gfi+tsLsMcYk4gSUMeJkQxzngCVSaNiM15fTgQXZA2Km
         1VkYBHRbWLEecwDkb2E/PsnhFIIt0F7gg4cZfJZ6nH21ikL2VnfBBupDxcjra9b8zP2I
         6VGQjGvBkPR/ucn6kmW2g0AgmdwsxNZeafoYqgqvkcnHqRZAyfgnRrzzT7cO0lYVisIx
         Rp+9dMxLgbVO6jiQ5KVyhZRfwDkCMnITOvEihUfKq5ofj7UsJYie00DY0ZLvcTQnEvQh
         1XsXNWzS/+ZQ0yU1EOWX3xPuahrU7CCccab508MZm/6ppaInJNOrf3RrrrCt7Yk2LWHb
         aH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XrsSMvIfRoWnaF0vM+34c0iAl3Jm6mF5PndunVcpoiw=;
        b=GQAtQg5VQR73M3XDoV+066xyZd6g27W+nH4E3IMAyp8h/58o7Lkov4qWt9WeHpiBnA
         vcACDPiUGtAT/s9QYapP/ZBudQt3N5NE4LJolhtqc5RK9xCgKCS6/0N3pW0L7xzcp4zc
         6FwwlPjPUlFXjtZAHdtWB12DYhYhRFurhEwmCvFAU5fQBI52kWpVHyP81yZqfXi1k+Cq
         CPKNLWPjfiqDj9h36GwJLSsKU9m3IBTd1Le+erxerPtpRq0KRQskTkkfjv7m5UvjfoSK
         A8l9xtKmDHGLSFYuaSl/9LOCl9hNqgWRB/HqjLvPGXn2ujlNqwEg+67K9tMU/iIOM4Lh
         dt1g==
X-Gm-Message-State: AOAM533E/sKVXLXz+guB7I0qV+yKZrba2rjltM2WAbTJfcoeUIePLf0E
        8bWvL2ZwcWEK6wv+ZnpSOcg=
X-Google-Smtp-Source: ABdhPJxOZafYGkQe1i8xFSu95OQ4Hrdk94bMSirASCK/0aZEFiNZ8iQbo6ZxdAPYnbacVBHt37xX+w==
X-Received: by 2002:ad4:4503:: with SMTP id k3mr16979346qvu.43.1596458348121;
        Mon, 03 Aug 2020 05:39:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bdad:2336:408b:dfdf? ([2600:1700:e72:80a0:bdad:2336:408b:dfdf])
        by smtp.gmail.com with ESMTPSA id f7sm19704103qkj.32.2020.08.03.05.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 05:39:06 -0700 (PDT)
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <90541678-f412-89a1-2ee0-4cae30e26551@gmail.com>
Date:   Mon, 3 Aug 2020 08:39:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/2020 10:38 AM, René Scharfe wrote:
> Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
> 2016-06-08), significantly reduce the number of system calls and
> simplify the code for sending object IDs to pack-objects by using
> stdio's buffering and handling errors after the loop.

Good find. Thanks for doing this important cleanup.

Outside of Chris's other feedback, this looks like an obviously
correct transformation.

Thanks,
-Stolee
