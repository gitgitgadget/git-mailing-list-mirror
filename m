Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DF1C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD761183
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhHXQzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHXQzy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:55:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18741C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:55:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d2so17379750qto.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MS6ST4kJ/jmqylKQK9SLkAPj2xjJ5j6JIN8/goP6HZY=;
        b=Za/wRxjrwuLeD8pzpBIYUBxoNDVRRgQSggNktJluTfxbwRpxV4GT7gLfMRjlKALZDc
         YhmhtxEAWA8081kqogt0FHbnCTdXVhNa146eztXiqMI4B1cFBndEtIt8QY6lvHxgmpGW
         FnrkxyDX39KCQpHQEKnfP6R7kDRj61faGInGhG1C2PXqaQveVW4A39FQ7iBzLY0gFYl9
         gs63JL7vHR5WpWEfSIbw3mwinEQtkaZzzqQSRwjfgyDcfwg0RMICr7Nur50wCeSLUj2E
         WfCOnc1TxgzRj+WBrHjZR4cEiGcLiJqoolzK0mNzC7X5CKYGwX2lv7YoRaqpZ3Yqf4ug
         /WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MS6ST4kJ/jmqylKQK9SLkAPj2xjJ5j6JIN8/goP6HZY=;
        b=ELih9ORm3G1fTyij+yM7KhT93JZY85xv4YCTcSHb7sWIjDuHsZYO+m4Ggi1bURPknV
         xLa2yAU7VXPNHg/I4Dyn0eEDqmoyBDZ+Qu5WG9HgxkHzhCsA/T1jkjZ4HS82jfmF9ToB
         OkDIM/ruM4l0PLFaMlMAys2fy9ybLp1eh6D+wagwcOcwOu05i41go6b/uhWX2900k2MM
         EWijgqvKgxb09qJT1EhspJrGab1BG5GTv/IsW86WRQjdaHS4VplMOUmgS5ofQuY/zRaZ
         AlqKGqBoE3/Tl4ViX0qfsOR9tsB60asADDKcIIKpNGbmETaY9Ugwek+wUlhvAOrc8dMV
         mEqg==
X-Gm-Message-State: AOAM531BSjdBTN6rkaAra5Dq/6ztStDZALuVnmkb9zDwdanq+k3YhXZl
        16iy+ahbVQ5ZHlZhLjQ00KM=
X-Google-Smtp-Source: ABdhPJxBKFcG3iAyv83mhcjeN/xTViLM78UopgZ04fbbdwFTA7ezIqWjKJlscEx6RsAU2p3u6KOMvA==
X-Received: by 2002:a05:622a:1d4:: with SMTP id t20mr11393302qtw.67.1629824109196;
        Tue, 24 Aug 2021 09:55:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id h13sm10819428qkk.67.2021.08.24.09.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:55:08 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] serve.[ch]: general API cleanup +
 --advertise-refs cleanup
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
 <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ab23d3dc-bec3-9ab8-87d3-264b158aabba@gmail.com>
Date:   Tue, 24 Aug 2021 12:55:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2021 9:25 PM, Ævar Arnfjörð Bjarmason wrote:
> This is a general API cleanup and simplifiction of of serve.[ch] and
> its interaction with "upload-pack --advertise-refs".

s/simplifiction/simplification/ (not that it matters much)

The changes included in this series seem innocent enough. The added
tests are nice. Organizing struct initializers is good to do before
adding options, which I see are coming later.

This version LGTM.

Thanks,
-Stolee
