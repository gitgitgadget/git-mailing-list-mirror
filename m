Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EB1C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C42364FAA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhCKPUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbhCKPUV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:20:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871EC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:20:20 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id x78so23504670oix.1
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veWb3XEIJWEzmB5Cp0YlvMYlls6l5P2DbQZY8Uv/e1k=;
        b=DFKf6Aiuz87XFLCd12jV8/sUnXtg3cPoUP0apmD26gJN+nlmEH+jhSJh0HukoCcOTn
         UUGAeVLvvvRpsvbqcOMeFZynXgAW+p/aJgcZRPzE1JhrKS9+q/qGVPlhc+AeqKQjldjz
         NeXB+PIRp+1tLiRKUke+Y4bUCUh3ZHRrbPQYCR6Z1lhh6cYtUXc1CLuXivrXeDxTXOTm
         lXOpZytkpantr4s0zIXKbZ05ziG/FwrGOIXXZ4/HixIFpqdWkLe68SrzFChhG/isdDdM
         qJqgPmobzrnYRKMC8vfndUozB35yXB+jCu4fLA6POe9XyygHgY1k0ICDF9VttkFLw7oI
         eu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veWb3XEIJWEzmB5Cp0YlvMYlls6l5P2DbQZY8Uv/e1k=;
        b=AXHxQOxUr9CRA+cDY2KKjMwiz3SY1kB77C6B7m9hc7/sn4VBvi/optLb/erQC8ETXy
         jx1pVu7hG0Tg8Mc2y9UWnWmJEe/biBcfke8L7XY3FWKT8H6WUyFFekhqRHTYZdMTX84D
         Ub1gsRyi/AzfH5uw/JnvsZwEuL+MURmtoQHFJ10jdSZdWkiIG1qjkwyOWccclO3KyOtI
         W1ANTvybDfj41YScvjJ96owpSQhQIEK6Icy2m3sQueX76PEqkkyt5NJMMcO4EqrvMIjD
         HkPOjEdz3PMSNo+PfIuxlAHotQzEIYwuFHfpjmlkME8Aoego3Q/SJERKdUs9xNSbsuOJ
         VuVg==
X-Gm-Message-State: AOAM530thRmti/pxl+f7bxunUpLO+QqaafGU0N3iDvWcOhgBG7tnYrby
        1VuNKSJxb+Cb6oc7yJc6fyE=
X-Google-Smtp-Source: ABdhPJzsVcyspRbbNI7ITpOQ1AUaNOSEpfoDmdXgBxCPYpROgt8vPoChrVF+ujnP1/hNeJMZGargPw==
X-Received: by 2002:a05:6808:148a:: with SMTP id e10mr6693894oiw.138.1615476020244;
        Thu, 11 Mar 2021 07:20:20 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id y7sm596671oiy.57.2021.03.11.07.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 07:20:19 -0800 (PST)
Subject: Re: [PATCH v2 00/10] Complete merge-ort implementation...almost
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cbf2716a-afbf-0b36-2f45-4c13ade38768@gmail.com>
Date:   Thu, 11 Mar 2021 10:20:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 1:24 AM, Elijah Newren via GitGitGadget wrote:
> This series (nearly) completes the merge-ort implementation, cleaning up
> testsuite failures. The exceptions are some t6423 failures being addressed
> independently[1].

I like that most of the patches here are small and straight-forward, and
are backed up by tests.

I'm concerned about the coupling of the "index with one entry" mechanism.
I'd like to see that built differently by creating methods that can
operate on an attributes file directly. If this method extraction is truly
too difficult, then I'm willing to concede this point. It is worth some
effort to try, though.

Thanks,
-Stolee
