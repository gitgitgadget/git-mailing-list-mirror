Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95032C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 13:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FAD2072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 13:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xco4gooO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKKNyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgKKNyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 08:54:25 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0F0C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 05:54:25 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id n132so1687589qke.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 05:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+c1VzdtC3dk9iEgjBMIYNfXDFv6ukRHfcERXLQIgC+0=;
        b=Xco4gooO+7Mpuxan2PwDwY7xC6smeWRle4kbFmGAlB0Qko1UgZGsY0PKo6qabarxNz
         O05rhqPohcam/JU1q+0wP9r1fZpjJIs1wndjXuX9ET8Y5mRKX1WQouu37Jwc1F0S8IcJ
         mn1IzERnuhUBXveAzhTdAwzmsn5/5Pp4NkNFZz0fbG891fSpr1iT8mTjJ6dZtmSnATxi
         kV+D1r2FLYMJEA6I82FIneX2a6vTzVV5zHkqgfq8Mj4Q+Vc4oUl0Pwgy3sDVkZHCy37w
         BV7uZ1lccapNDxVn6NWuq5OBsqOqoXjCa0IMBMKDEsrgQ4gGq3EL7V7M5m5EXhGpwtW3
         AU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+c1VzdtC3dk9iEgjBMIYNfXDFv6ukRHfcERXLQIgC+0=;
        b=ZVGihh6PpqAvzU01gLAZFVoHUzlF8eHTwVVYLiq/pyYWX8wW8DrqEqekbKNhdOrvEH
         Q9xPjec0s9aCFWe7qQYSQ9JbiV6+N296ayGxWRlCrIFsRO1oUP7Byl1+nbDfcu30QU0g
         iQLDy7g5K1w7cCot5E2vbKtwuT7KnX0Uy9wt9iAaoQMDinLm5vDqc5qqZ5dkyviq5ZFf
         2wILo1UHadMq7Q0ZTz8Myrxjn2tvgqUFJlyPRDhwvjFrRAZgD+1CHNc8P/zhr8mtX8j6
         eCBykuqgtgXZgPoOKSMdTWzes91gRoMu1RdWfmwlUac5IggqEnEvASjVE7cmZDNNuuS9
         zyMQ==
X-Gm-Message-State: AOAM532aIiAOstiPrKfssghePsCPFokjAbBDoejCknayrKrcz+GnfApk
        y12zsIRJLYakfNzZst4tERbjwnOx/J7L+Q==
X-Google-Smtp-Source: ABdhPJyV2UKYlZKVCvQO68UAj2jKrbGWvtp96UktjBAJzTJSxBbPz63am3otoZKaucXGTPoKNqiGBQ==
X-Received: by 2002:a37:4692:: with SMTP id t140mr25684161qka.275.1605102864276;
        Wed, 11 Nov 2020 05:54:24 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d86f:4f77:7172:19ff? ([2600:1700:e72:80a0:d86f:4f77:7172:19ff])
        by smtp.gmail.com with UTF8SMTPSA id v16sm2125031qka.72.2020.11.11.05.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 05:54:23 -0800 (PST)
Subject: Re: [PATCH v2 04/20] merge-ort: use histogram diff
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-5-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cd05d258-a526-9843-f646-d2d42f1b8cbc@gmail.com>
Date:   Wed, 11 Nov 2020 08:54:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-5-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> I have some ideas for using a histogram diff to improve content merges,
> which fundamentally relies on the idea of a histogram.  Since the diffs
> are never displayed to the user but just used internally for merging,
> the typical user preference shouldn't matter anyway, and I want to make
> sure that all my testing works with this algorithm.
> 
> Granted, I don't yet know if those ideas will pan out and I haven't even
> tried any of them out yet, but it's easy to change the diff algorithm in
> the future if needed or wanted.  For now, just set it to histogram.

If you are not making use of the histogram yet, then could you set this
patch aside until you _do_ use it? Or are there performance implications
that are also a side benefit?

Thanks,
-Stolee
