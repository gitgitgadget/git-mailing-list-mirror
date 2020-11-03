Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A0C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293E7206E3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK0H6YlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbgKCVXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbgKCVEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:04:09 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81332C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 13:04:09 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id e5so5013563qvr.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O/uHC/7Ttjz67ZC8viqLhSTyVfLfNC1EaYKkHZYJzfs=;
        b=XK0H6YlIB4kzBnTa/nRj/d8IEGx42aVGcFB3uWUHPQEseVGF4hvXRMd4q6wT02EZCH
         ZVkMzQgvFl7gLR678fXs0fmduvMUBwP6ial9kZ1djaBHBcABm3y8gyJGWHRrQp+IP0Dt
         jKc4HyVQ6aYhP2GnV1PFkxpMe+0nar/JTTgXQysfzi8+5YgQoyrcPOTv4db6ot31OKjs
         vIw9ruPlu+v3qIKNdgeJgCf72iULY+XC+S0T6wY0ILfiNyrHPsFgULfbXXWFzUPLGfYU
         peuddBgmghDSF/uVcUgfZS56Le/TOCdYBzwPL8PenTqo0V/Go86+TJaM+ghOyZqj20zI
         3sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/uHC/7Ttjz67ZC8viqLhSTyVfLfNC1EaYKkHZYJzfs=;
        b=ASpAqnpYDdXo1RNxlOaNid7oep3aBmiS3P4lEBxW3YaI54655pdVYnoLCrgDKoSBiy
         ErSmt9UtWyxv5oFSrS2yaEaeLoJY6woCm64e0TljaQ5soQV9o1eWhvG7DO/K+rqDLwXW
         GhXUrCc9rrSw4J8V0UimF7DIHPJEBZrLRrcOW74JahgFwkZoi6slDshOO1BqdKcFFiqk
         vdUGMDpM8zSnX69VZNSi99008FnD3yK+XF5P50eRNl6WpSdrPITtNKrLbsGBMP8ZMX30
         SXdjGY3Uvswqzu0Elnk4AYunmFDi/dy5sr/mW6gX7+TQB9To6/lDccLbUr7DflErxK8O
         bGQQ==
X-Gm-Message-State: AOAM531fTYwoqfW2TVMs/tIKRtkkN2AVB6/i7TmMld9AZKwiCgRPNE9A
        9J6zK1SFJelHjBJT/DvaRc4jNEXWKC55zw==
X-Google-Smtp-Source: ABdhPJzxtt8nOq5mcM8Hnz4UTZzmM+vfNdUM9fA75Agg44rBdBqKXlWuYfLrIou0hWX7fAz8Bbh6Fw==
X-Received: by 2002:a0c:a166:: with SMTP id d93mr28638279qva.22.1604437448327;
        Tue, 03 Nov 2020 13:04:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id q70sm11332738qka.87.2020.11.03.13.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 13:04:07 -0800 (PST)
Subject: Re: Segfault in git when using git logs
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>, Sathyajith Bhat <sathya@sathyasays.com>
Cc:     git@vger.kernel.org
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <0581272e-6ad2-42d9-0196-b804ee304619@gmail.com>
 <CAMsWJsxyW=JUh=XGCkGG3LhOsZASwFHtx9b6ziNi_uHa918Scw@mail.gmail.com>
 <20201103192327.GA462936@coredump.intra.peff.net>
 <0b6657a6-afc2-7862-de43-94868f9419a5@gmail.com>
Message-ID: <233ea345-68ea-fdfb-9c7d-1c2cb4f7e4ba@gmail.com>
Date:   Tue, 3 Nov 2020 16:04:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <0b6657a6-afc2-7862-de43-94868f9419a5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 3:07 PM, Derrick Stolee wrote:
> Thanks, both, for confirming the extension and the likely
> line of code causing this problem. I submitted an issue [1]
> on the GitLens repository. I'll continue watching it, but
> feel free to chime in yourself if you are interested.
> 
> [1] https://github.com/eamodio/vscode-gitlens/issues/1139

The issue has been fixed in GitLens, so please update your
extension to verify.

[1] https://github.com/eamodio/vscode-gitlens/commit/d980c7b831961f932ae68ed6e8ab08f71983b9a9
[2] https://twitter.com/eamodio/status/1323729485338914817?s=20

Thanks,
-Stolee
