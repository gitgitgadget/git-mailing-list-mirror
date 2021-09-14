Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8340C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 04:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3AA610A6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 04:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhINEB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 00:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhINEBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 00:01:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E69C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 21:00:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so7910297pjv.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 21:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dsgivPhu7TwhIiZUylx5jjH2bnzkUBIYzYNObr3RJIQ=;
        b=gcCi6ht2tpTgXEaTHD6L2V8fZdwQp/HOqeG2U4vXV/Gr0TmLFav2jWpsO9EE/klGvD
         nh+txhsyFyJXyBfX+LxsDIaukMijQ58/20eT+NPOb/3cTIvWiPJP5jLXjaDGNvFfSOw1
         /QCn3gfuK4JQVSR6RY7thDCqAjQjwwHnmQIFukAGjhOy5AT5stDLFm34eyEj+IH01tXA
         Kkj+vyzLfCLSnQ54EwXO5WSgRZi7esQ1ukbEsgxPjKNvU0YfDDXPMFij9BY82eYy1LzG
         mXKNRtTO+PdiRummCcy7oAugnrNAPCp/9FxDr8SqPnlfV77LygRqMaHs2dG16CGwzNak
         V2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dsgivPhu7TwhIiZUylx5jjH2bnzkUBIYzYNObr3RJIQ=;
        b=dotxpCKq2JFeWcVUhexPQX6ze4RKniP8mNuaF+CA3u+4V3ufXTVPuMX+72L6fjCxIT
         NZV4UqIZsI7CQUE1WPBfh35YwFmnBZV70HFkeX8r+kBy0R0FJ0GlJwxQsuAgOLB8YGtH
         YHoZVYlcvrmrIuCAsrw5cJqPZNvy6tWdHExaP1a/H+6sqfxoJ6PLQz58y4cmHaE25bse
         zmlDs+cAbenvJEhKj+iF3oLmHBkoT0STeVPgNKTEBv0liCYSV6JeyPEyn6eOt/wvWV7W
         THthDxXlv4gjh9L5L+ItDzkYUAidDJvMDRz3saU0sFN957iakpTM1yPkBHvp81YJvua2
         IRJQ==
X-Gm-Message-State: AOAM5332v2hNQmO/o7HGNtN6vJspCd7NT7P0QYqTV5JbIH7W0ywJ7rZz
        rVLPEfm/ME3raR59SFh+KMxqiPJlqRTxSA==
X-Google-Smtp-Source: ABdhPJwHvGX+Dbd0PBP9mqWHdnG9/p2Qtk1Cy9fLldvRjvCvlltvCdCUbuOVx7+kZ9VOzX59skCSJA==
X-Received: by 2002:a17:902:a38b:b0:138:d329:27ac with SMTP id x11-20020a170902a38b00b00138d32927acmr13324893pla.7.1631592037978;
        Mon, 13 Sep 2021 21:00:37 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id t13sm8247660pjg.25.2021.09.13.21.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 21:00:37 -0700 (PDT)
Subject: Re: [PATCH 3/3] gc: perform incremental repack when implictly enabled
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-4-chooglen@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e890300b-4a9d-8c08-84f2-c20b28214da2@gmail.com>
Date:   Tue, 14 Sep 2021 11:00:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913181221.42635-4-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/21 01.12, Glen Choo wrote:
> builtin/gc.c has two ways of checking of multi-pack-index is enabled:
> - git_config_get_bool() in incremental_repack_auto_condition()
> - the_repository->settings.core_multi_pack_index in
>    maintenance_task_incremental_repack()
> 
> the_repository->settings.core_multi_pack_index should be preferred
> because it has default values from prepare_repo_settings().
> 
> Standardize on the_repository->settings.core_multi_pack_index to check
> if multi-pack-index is enabled.

I was wonder what the correlations between checking if MIDX is enabled 
and performing incremental repack are. What are these?

-- 
An old man doll... just what I always wanted! - Clara
