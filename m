Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9541F463
	for <e@80x24.org>; Thu, 26 Sep 2019 16:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfIZQQU (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 12:16:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34757 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIZQQU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 12:16:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id 3so3581683qta.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J8/rVguxKSzo8ls8nkBdNJ/MdEeE1r3e0qxBWJvWUxw=;
        b=XbLeH7NymfBHh4rfHoTZwdYMGCWwyBxGn9pDxI/+R4pKUkrQFUVecDTRAzMHlY64L3
         jKcIDFzx+6d5ThRdK4kvJSs+99fKyTXJiQ5G51SCZvtuS/2OQ7N5syVg90TANMhVdogt
         68rvverr6N7rXfpXXQIZw8yMXtCGu37eUnJJU8uwMF3IM21S8WS/JwrumIOog8rmWMpE
         VWarAVmTTIPTItgPuy5MHu83vTWBtEOh5PDdINpzFCc8hO93mOYoxnwdEbIK84GRm9jj
         PPZcv5tTvLJc2/wZvS2gYf+vJsQoGUvlV9gXwW10Y3mXFRk0+/vnJsbO3zZ4PGewhrXp
         JiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8/rVguxKSzo8ls8nkBdNJ/MdEeE1r3e0qxBWJvWUxw=;
        b=UjVxbksZ9jFWHlfxAL9dinQJkBIRfnRTBZafg84VWmz6qWTihjQkAW91D/CAnhzt6J
         PXA9iQbmZShqQmQyW/sCKry5ku6jWO6F+HvnQ0t3Y3nama1dLDuiPYv8etJBQXa3Ew6C
         aVj/pHQv5lE4O1HVDzJlUp0GCjomi0haUz9ynOVKX5QkgQWdWry/lddXOP0fjqEIhVOF
         bXVPB186nazgk2U9SdTym4WqOQzXtfxAMR3gEll0GcokuRM0d+C0jt20I+GxAnaYP1HD
         8eExKStU3o4kGeS69KkmUMZv8rv/BrFFr5Jbf2SxFCsX7Cf1E4vnCIDpZT6RLt11sA53
         ijKA==
X-Gm-Message-State: APjAAAWNpn3gq620Zlzz20WMxLr4Nj4LCo3FdJTnOsR7kLBir6J/l0zk
        ILs1yLk7a0r33zLstGYV8yOQK6CsYZk=
X-Google-Smtp-Source: APXvYqxrJDnTDL7HBaE798OnEeYgHriPu7z2oj2gVtYp0yd6eH+5oG8KqS4ije3X+2T+XRV9D9MPjA==
X-Received: by 2002:ac8:51:: with SMTP id i17mr4750136qtg.283.1569514578871;
        Thu, 26 Sep 2019 09:16:18 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b594:20f6:c10f:d45d? ([2001:4898:a800:1012:66c8:20f6:c10f:d45d])
        by smtp.gmail.com with ESMTPSA id n125sm1253736qkn.129.2019.09.26.09.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 09:16:18 -0700 (PDT)
Subject: Re: sizeof(var) vs sizeof(type), was Re: [PATCH] git: use COPY_ARRAY
 and MOVE_ARRAY in handle_alias()
To:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de>
 <20190923222659.GA22645@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1909261521380.15067@tvgsbejvaqbjf.bet>
 <b79f52f7-4a7e-f7cd-ed8a-cb6cfbadd7b2@gmail.com>
 <7bbcf6fa-e36d-4a1e-86e1-437e9e92dab7@iee.email>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6ecafde8-cd1c-9457-4102-b73304a122fd@gmail.com>
Date:   Thu, 26 Sep 2019 12:16:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <7bbcf6fa-e36d-4a1e-86e1-437e9e92dab7@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2019 11:24 AM, Philip Oakley wrote:
> On 26/09/2019 14:36, Derrick Stolee wrote:
>>>> Another good reason to use "sizeof(var)" instead of sizeof(type)". :)
>>> That is indeed a very good reason, in addition to getting the type right
>>> automatically (by virtue of letting the compiler pick it).
>>>
>>> Should we make this an explicit guideline in our documentation?
>> Better yet: can we create a Coccinelle script to fix it automatically?
>>
>> -Stolee
>>
> How about 'Both'. We can't assume all contributors have Coccinelle on their OS/system.

Both is best, but I find static checkers to be more reliable than
updating documentation. For that reason, I would prioritize the
Coccinelle script over adding another bullet point to the style
guide.

The PR builds for GitGitGadget run ci/run-static-analysis.sh as a check
(see the StaticAnalysis job in [1] for an example). That provides a free
way to get feedback for users without Coccinelle.

[1] https://dev.azure.com/gitgitgadget/git/_build/results?buildId=16864&view=logs

Thanks,
-Stolee
