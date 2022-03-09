Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96767C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiCITNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiCITNR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:13:17 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703E14236D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:12:18 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id z8so3671683oix.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vVRNbRanVqX4OqjqqDDzbou8s1gKt+fa5B1S6DWaCzc=;
        b=IeN4faRRsgtC9SQdV8QtLsQwNrDAsK61qvXJ7J91wLf3fAL4K7iWjodwVQr/B8CX6c
         RFjqQlyGmDpk8Pi6G5Q0v9o7S6vd5VZ1pmK8BfEj9+v790TOc94jm9h47O/3lO+lo92u
         ItFK/uQwA2ykysG1K4JAPEnxo1yiepKOBjLdJK9JuB5cDx3SDO0aprX87Q6R2r7P8q6Y
         1wtir8ThncbM0sboKkIIlmWfKrxBKDx6NzJQR5lLHJ23NWbTcloOm5LaHjnUH29rOXgm
         wOCeLMC17SqsS7HK+DpL+aKUJ8f2/6koBq5WBqq9Yk6wrbQQKUM8/2QKeZwE+AoeCQk/
         w+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vVRNbRanVqX4OqjqqDDzbou8s1gKt+fa5B1S6DWaCzc=;
        b=ndVSTs1UsehR+x+yQMy3DtAmIqKFU4U53+ot5+IO5KuFaPfDnbgnoPMWt/ccCwczhv
         V3eBiwDrIFmKmzQ76sg0DwzUz57BSumIUNfk2x6TyShtGOIGrTE7D5PdxaiES/5cUQfz
         lrho73K9mut+c1iM07VacIf9nSEsfIpdHPmfB8hjbpChumuH/Nmf+4DTFTFs/SxuzUme
         OuhLD9N1wuzuunKqX8Phrl/fBX8GvtpENzhNK7+tbMFnfM2nNa9XUhoJqpGttISzFGvE
         6G9hNz6zZPW7V9czMb0qVmojzFeaQ0dpgLDIm6rxT3vu6GJumcO4JGGgabwJa1TX6flB
         5CHw==
X-Gm-Message-State: AOAM532ImuJ3TTEkgRH49ESMC5iSkVyegi3XFG1bxRu1mBqxVS9P+IIF
        ck/735N2fZ33lDriLYrd5qFOJ25hg/o4
X-Google-Smtp-Source: ABdhPJyaNEUnw1RlN3wvY5sP8Rwu2LXqqrxFXFNRuA7Or127zu9ywbC3rbBGbaTCrtq1mpFRkRdhvA==
X-Received: by 2002:a05:6808:2209:b0:2d5:1bb4:bb37 with SMTP id bd9-20020a056808220900b002d51bb4bb37mr678929oib.53.1646853137777;
        Wed, 09 Mar 2022 11:12:17 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm1371571oiv.21.2022.03.09.11.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:12:17 -0800 (PST)
Message-ID: <50873925-a5bc-7df8-1407-371eb904e38e@github.com>
Date:   Wed, 9 Mar 2022 14:12:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 10/24] revisions API users: use release_revisions() in
 builtin/log.c
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-10.24-a89f0da4fd7-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-10.24-a89f0da4fd7-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:

> +static int cmd_log_deinit(int ret, struct rev_info *rev)
> +{
> +	release_revisions(rev);
> +	return ret;
> +}

This pattern of passing a return value through the helper
function is a clever way to get around adding "int ret = ...;
release(); return ret;" lines.

Thanks,
-Stolee
