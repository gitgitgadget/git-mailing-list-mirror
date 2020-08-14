Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B36C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32010208E4
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCWbOei7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHNMN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNMN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:13:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007DCC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:13:25 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so6699800qtn.7
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mx4kQ4DpRBo8yqMtS+BnResr73R+m0a1wttmTj5HUkU=;
        b=fCWbOei7i6yqhRf9XENf7XgWvtwApDJ5rDgICLqACALktfbOiAEw3gy5ZnRBB0tI17
         0DZQr1MrYXZr2/4mKx2lqRTVrChZZhCTiWmv1Yz3jaqxS9D9xynMRDsgFpjyQNbDh97T
         8Var2BkNqwOuE8V2MDqHvLcYraA07rlx3Nn1VT5GeKoo22NfvasVgca/C/ShmB043r0I
         8bTZJ9qkafDz2ljQfA44azzGh9rTOLO1XdpRYqx8x7X4syL1yujELNgrv7xuOHItGNih
         EEKL3k8oBxEs1O/k2aet/I2arZOifnpyavO2tv9z/5uLimQE0AmLedplrNwx0HZv49DW
         njBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mx4kQ4DpRBo8yqMtS+BnResr73R+m0a1wttmTj5HUkU=;
        b=QK9WOFOqqv4I7Ixyw+5gNwVCGhfvKMxDOSPFkjjkUFykvUHvD0RoTkPHbcp3O5bZQ0
         ywDxcZ01i/b68Is3zMMB8aE65yvRtNtyBVRycDn1qohitUiNnb0bBghhITot+JlvXNJ/
         SoMRkK9lOSV2OMagijs9I5//8SMUtDg6I/FDUBj2RiAQSC96vyRmvNSj+QSPc5SdaXum
         l0EkY4xUcEu5k0ij3pc8M4irv9fDyNddCTt8PTKEimip973c3OtQIc9hmuL69ZRi9hcZ
         UEkLe6KXKegWsfkbQwjQXc5El6i0aCrofwp0nSZdfcrf8SZ2ssYiGcqt0T+pou3oMXtv
         Z6aw==
X-Gm-Message-State: AOAM531AXvc0K7Ue2dp97LA0cU3Oy9aLxydHEz0YZuK5Oy5d4Ep9mQhq
        H0KQcs6prNREIE2QBsV8A6I=
X-Google-Smtp-Source: ABdhPJz3u3jUeho6tjLk7DxXZLQrXHFS1iibnH6Vs9gzzlp5ty91OagUohUUywn3MYEl1jlbFKWe+Q==
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr1696497qtr.254.1597407204999;
        Fri, 14 Aug 2020 05:13:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id h13sm9791197qtu.7.2020.08.14.05.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 05:13:24 -0700 (PDT)
Subject: Re: [PATCH] clear_pattern_list(): clear embedded hashmaps
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <20200814111049.GA4101811@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e0c102e9-57fd-ac0e-72ee-8be5f2095160@gmail.com>
Date:   Fri, 14 Aug 2020 08:13:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200814111049.GA4101811@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 7:10 AM, Jeff King wrote:
> Commit 96cc8ab531 (sparse-checkout: use hashmaps for cone patterns,
> 2019-11-21) added some auxiliary hashmaps to the pattern_list struct,
> but they're leaked when clear_pattern_list() is called.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I have no idea how often this leak triggers in practice. I just noticed
> it while poking at LSan output (which we remain depressingly far
> from getting a clean run on).

Good find. The impact of the leak is likely low since we don't create
multiple pattern_list structs per process (with these hashmaps) very
often. The sparse-checkout builtin is likely the only place where
multiple could be instantiated at the same time.

I also double-checked that hashmap_free_entries() handles a NULL
hashmap pointer or uninitialized hashmap, which is what happens
when cone mode is not enabled _or_ the pattern_list corresponds to
something like a .gitignore file.

Thanks,
-Stolee

>  dir.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/dir.c b/dir.c
> index fe64be30ed..9411b94e9b 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -916,6 +916,8 @@ void clear_pattern_list(struct pattern_list *pl)
>  		free(pl->patterns[i]);
>  	free(pl->patterns);
>  	free(pl->filebuf);
> +	hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
> +	hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
>  
>  	memset(pl, 0, sizeof(*pl));
>  }
> 

