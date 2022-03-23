Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F81EC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 19:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245348AbiCWT22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244807AbiCWT2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 15:28:25 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBF075228
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:26:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z8so2685971oix.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9q0w0AuLtALCZIoFXAzyn3ApGmB5abpFdMtL7NNHZu4=;
        b=K5Xiig9dzTVCNyhKhxqRAwqklvzSUC87Ey4z79fC6vFTdEVuMqzPKqj2gXW38BmETW
         ozJzoXuHrqarqxHicg5ti47xZ/uVjWWIbkZ8OGwR9rOZ1sdrrleoFgB2PEIyU0QCi9jC
         R33VGOTf66PM1PotBiVeULSBxQtd1o0mdO0QZM0eUL+OuvQ4W73LyfNaf9hQ2T2i61KU
         XB5GQq0zwzip6M0OvLNwcKG51qFBW++D15miDL3YtT0iOb2zzt/ZMqyDeX7ks1sxRWWw
         9CDSy5ZvcXoxQ7Ry+Sdu03a7a28gvWIKGupMi4XKpdzPGJ0c2U8Wz0zOWXJYnUFOFnMu
         hV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9q0w0AuLtALCZIoFXAzyn3ApGmB5abpFdMtL7NNHZu4=;
        b=E2oB+asloqUaa4IGDxjI0fvBDSbwZDwrVRkk/d+BmM62UrKHd2aviMLepi3sD+44x4
         /8UC48L/3hl6B0HkWFbJzUZboR/c3sKHT2IDBEWOrGhs1b5ugJ3UEsu2WjfIEzOAZd1T
         nx0Y5FWU93YEqILRf1cmGf+f5pAM9Fz2saiWTxmRAELkCtp1+WAVbwgYadZK2EjDSt4U
         Z1Xrmc9DXq87oqsOILrJnqyhx5jTOc3nNCS3fOAJugSuL7tTFlP8i5eFDOauNRsQXswW
         dRdvFlWS6cYuT3BDcQ5fA+YAcB5GOJsd1NJ+HqeGjYYOTBbbqht0AUHlIulFsR2m+C/x
         mcig==
X-Gm-Message-State: AOAM532c+BvjaI0md+JuF31Zbu3P/xpWdW1RRCjQoRk64NgQCs00kHjb
        ZkeFQLIfgHvPj01sGJPVE6UJ
X-Google-Smtp-Source: ABdhPJx5LjuZ9Po3mzuu8f0TcsU2G1gfyzFWQB4aOVqqirKVpSqT4YfoB06qLl+lDPQOVYNSqrpiuA==
X-Received: by 2002:a05:6808:238e:b0:2ec:d381:5fac with SMTP id bp14-20020a056808238e00b002ecd3815facmr893851oib.248.1648063614913;
        Wed, 23 Mar 2022 12:26:54 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i28-20020a056870891c00b000de777f1a41sm345411oao.46.2022.03.23.12.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 12:26:54 -0700 (PDT)
Message-ID: <d279c648-36e4-2fd9-90ee-b3cff7d9a1e2@github.com>
Date:   Wed, 23 Mar 2022 15:26:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2022 2:17 PM, Victoria Dye via GitGitGadget wrote:
> This is a follow-up to the changes in vd/stash-silence-reset [1], in which
> index refreshing behavior was decoupled from log silencing in the '--quiet'
> option to 'git reset --mixed' by introducing a '--[no-]refresh' option and
> 'reset.refresh' config setting.

> Changes since V1
> ================
> 
>  * Dropped patch that removed '--refresh', again allowing both
>    '--no-refresh' and '--refresh' as valid options.
>  * Updated documentation of "--refresh" option to remove unnecessary
>    "proactively".
>  * Reworded commit titles to change "deprecate" to the more accurate
>    "remove".

I read through the patches in v2 along with the discussion from v1
and the changes due to that discussion. This version looks good to me.

Thanks,
-Stolee
