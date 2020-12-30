Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FDEC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF7820867
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL3BUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 20:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3BUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 20:20:13 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5228C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:19:32 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q25so14045189otn.10
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yUx75BDbCptBrMcutEjdXV16zlWmV4FKjRZPjs9k7nk=;
        b=sIpqZiE4xqJMrT3s6bVWHqdEHn7yu/S6sbFV4l3/MEsi33Svtpo+41BXFZiYucJa+/
         flBG/0ZuVeYJtwUhXcYeYRTT6F6meyeR6EWRwA4e+0nOLIq5AfvOfsbMjN/+XE6dIHlD
         eTJlly5m/amflEDCKQmAygygzADwkxBoBJVLzR3JMdcXIQbIpMkOFukwJw0UoZDYKhXg
         y/G2WQteRMRJsJ38+QPPNqb94Uj9i8IB0Y2JUEHapWbwk6D5U0dYnwMTfU9jU6PcKx8L
         RhLSFxnLOvS1G2uP87UFcRInlPZXd6krLQ0yoSupNZx0g7mri3P+D67kNu71O+n6qFux
         5uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yUx75BDbCptBrMcutEjdXV16zlWmV4FKjRZPjs9k7nk=;
        b=IQAKuyruEydBieHHSm2UgsD1AqVjcTloGfKUUL+H5+ZD28CH7Xz/LGTS45gxl65Au5
         XoCy3B2rACNPqKjvsqdoNTYdv3T8ep/ksOT6yVarZXaXNScCrAn1rixmnmdd9LfFn94j
         Bwt3qQtfPPAI4vlswChqGs3KlrPezwhctVkQIV1ah4miw4NkqlSrZicPCdZgbYxgsMD1
         1W7A/fwnhmGHZLDyvz5y86Y6AG58NIx4+8o+32dwuPLsGhBe+R0AA7PfeM2tOpoxYwS4
         P/CCr3GyCNQ77kbH5CuU4h5qg8C+8zwXXyNNrajWIueBHXyDfsBYho21Lb6Zhn6Mw7Wp
         3fKA==
X-Gm-Message-State: AOAM533DgSjWRYdXd1wtb8FQBUYvLtufJD29r2htImDXpepEDf7IfWj0
        6eVNcai1FjDt98l629xrHSY=
X-Google-Smtp-Source: ABdhPJzUaNF6myOcrTOA/bIOh5BlIzoYJ00IuQ3T4VIfJRdp/VzSQaIfYH5JIvGEgxnzBTEOp598/A==
X-Received: by 2002:a05:6830:19ca:: with SMTP id p10mr37971612otp.233.1609291172063;
        Tue, 29 Dec 2020 17:19:32 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id l5sm10168861otj.57.2020.12.29.17.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 17:19:31 -0800 (PST)
Subject: Re: [PATCH 1/4] object-name.c: rename from sha1-name.c
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1609282997.git.martin.agren@gmail.com>
 <aac3a3c3e202f790f11089e2c8f814bea9943831.1609282997.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7cc9ac55-1e9a-05ed-fde6-a422804ed3b9@gmail.com>
Date:   Tue, 29 Dec 2020 20:19:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <aac3a3c3e202f790f11089e2c8f814bea9943831.1609282997.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2020 6:52 PM, Martin Ågren wrote:
> Generalize the last remnants of "sha" and "sha1" in this file and rename
> it to reflect that we're not just able to handle SHA-1 these days.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  list-objects-filter.c        |  2 +-
>  sha1-name.c => object-name.c | 14 +++++++-------
>  Makefile                     |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
>  rename sha1-name.c => object-name.c (99%)

I was tempted to recommend making the content changes to
sha1-name.c in a preperatory patch then doing a patch that
preforms an exact rename (along with edits to Makefile and
list-objects-filter.c).

However, I talked myself out of it while writing this
response. Having an exact rename won't materially change
how "git log --follow" or "git blame" behave.
 
Thanks,
-Stolee

