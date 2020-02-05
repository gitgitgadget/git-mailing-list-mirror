Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B341C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AD420702
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPrSA7L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgBEPLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:11:47 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41647 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgBEPLr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 10:11:47 -0500
Received: by mail-qv1-f67.google.com with SMTP id s7so1240768qvn.8
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rHxWRomDtenn4xmIht0S78XhSRMl7TDnInYJ6kv62dU=;
        b=EPrSA7L5/fLzZla2j0tiZPnHOvlvoDAYseC4uPQYA7BzeT8rtIpemV/4xVxwtr0OcC
         1PmeXQlnRA+1G7J0oTMwdn3+9dk1ATH8INRQWO0zc8UBrZsOE1MFPNeWo3j3NA6eUH4q
         7d1i5TPEqV6MEatfXCK9+lTkrmIFAE3jjSds8dl7FqdQH6JBoUETqbYyEG8SvDFV2vZq
         RUGC2Kgp72Z7RL0ZTiQpEAjtTQIK03YL3RYmbY8O4sEkHN7ioSFkGjxrc/RaLV7vMxaW
         Z778Mz4uZUws0UIFG2dWa7BD078woisskK4+pNhLpfF5gK2fozOryiy7qQiTeNVszoBD
         rMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rHxWRomDtenn4xmIht0S78XhSRMl7TDnInYJ6kv62dU=;
        b=qEmXBOZ/Q9DM2idsR4Yk1FlORu+tS94H60OPRp9D17Q4AcHovpLQgM6RRRhO5yfERc
         fyqXPoRrkoA7b4XahSTKNr5+sDfZMb7MA4ITrVy3JoeTc7ME2BRvKgm31yIY3jBfPLTG
         GWDxmss+zQ0ZPDtcs13PAQGodBZJj/3MrBnI9+uvaDsKyhITdI76q+aOKOEW8mxsGD1O
         y7SLSjH9V3MDTsMYoFCXv/NWjTpv8iO7tw8JIajGl/q/L+tgplEYqiZxPHvQGxDGo930
         MHOlryNrnxsMGOyXfDu0kb9D5ykQt3o5a+xFHXDklk42eJu6lQWKz8KZJsS0+QbqeX33
         TpVg==
X-Gm-Message-State: APjAAAXxwf23FsS2WRwVOCOvXDDMkhRzlY6p8sX7VS9uzzjzas6W5b27
        l397gVh9TBZovWOs5HxaInU=
X-Google-Smtp-Source: APXvYqzWZPlATePNFM4aTQtAyfXNk2NcSBinAweSfSXkO3abE9LgqXeKz9ym4nDqgo+18maqO7dCbw==
X-Received: by 2002:a0c:f412:: with SMTP id h18mr33213716qvl.124.1580915505931;
        Wed, 05 Feb 2020 07:11:45 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c9b5:7cd5:1ee4:5066? ([2001:4898:a800:1010:7aeb:7cd5:1ee4:5066])
        by smtp.gmail.com with ESMTPSA id t23sm11748qtp.82.2020.02.05.07.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:11:45 -0800 (PST)
Subject: Re: [PATCH 09/10] name-rev: generate name strings only if they are
 better
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <77d1d053-8680-5cbe-9182-b6aec9e9b446@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a59d8b4-3c3d-3812-9b7e-ac7e331ccd1c@gmail.com>
Date:   Wed, 5 Feb 2020 10:11:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <77d1d053-8680-5cbe-9182-b6aec9e9b446@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2020 4:25 PM, René Scharfe wrote:
> -			if (create_or_update_name(parent, new_name, taggerdate,
> -						  generation, distance,
> -						  from_tag)) {
> +			parent_name = create_or_update_name(parent, taggerdate,
> +							    generation,
> +							    distance, from_tag);
> +			if (parent_name) {

As someone unfamiliar with the name-rev code, it took me a while to see why
the algorithm isn't exponential in complexity. It technically _is_, but it
is of the form 2^{N / MERGE_TRAVERSAL_WEIGHT} = 2^{N / 65535} and only if
we create a particularly nasty commit history that would never appear in the wild.

But, the critical section is the block above. The confusing part was that
create_or_update_name() returns NULL if the name is updated, but non-NULL if
a better name is created. That makes it clear that this change is saving
allocations.

Thanks,
-Stolee
