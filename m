Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9710DC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiBTTwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 14:52:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBTTwx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 14:52:53 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56C2AF4
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:52:32 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a28so26702638qvb.10
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lHsGzY4ZowNawp3fkwaCHy8Zwl9neg10U3Lwzs/IPQ0=;
        b=jLPBn0NygNOHdITNCNXb8R8HqM3cM5i1UHRApG0E86gXhN2Muo3YzzBVIGv7O7nBnw
         3VBmuzAprn7YKdLUdomBS50Q2rm3EnGKuMBzRwybYuV/aZ0HslyyJ2nvxEjLaAYCvOVU
         7BfzN99N12Hr5CAKRxykhgSJBb5+bmXf+piedNY8Nrr8LYr8A+AXpSdxvQNPxf3887yP
         CXjzrNvWiNaEBdl3lZcNYdC/VWLPOo/LkY5jbrXVTRsIywr3UtZPA6KMKDoQy7HapTt1
         Eii+AFbgTFSxUxIQARGuvAplFIoc10TV5DfUJXWwRvk4juT7Y34j+vIrQ1NWiOepy5rJ
         t4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lHsGzY4ZowNawp3fkwaCHy8Zwl9neg10U3Lwzs/IPQ0=;
        b=JA5kic3OU9HUYyZ7lNzibLbNXs8keo9lspFjhhJEhIt6Z46M62ecSt0CdPcc7hXqSi
         W49w21kqYGAihF+04j7wqf4TVyPjAlrmi7ztrIY6yjtKm3QB0Ci8M9usPycXKb+bD5fC
         k4jw2depbzfQ4UYeuNR+Z+DPCDnVaOAWUz90pFu/4U+oQO00r9PhqSOw66WMrN5nd2g3
         AP4Kvj0tRrX/hvRyU8qrH3H/0cy/mJPIJZKX4BzM91lzjoxmSfnoFsu+CM++vpwNpP+k
         WHTuu7L4OUOf0U1ZolsRJNWXSSLM2fdJJ8hxzCcbi15ELiiYPWqrCycfgzkS2D4GO8yA
         wqHQ==
X-Gm-Message-State: AOAM530b/MiRZCFP37EBEyy0N5Q7xj2mk6pady/PPfuL/ap8KOJvgOiC
        RGsuYEozMUF6Sp1JotJg1tjTZklPncvS
X-Google-Smtp-Source: ABdhPJwyrlKkdOWO+PYEySjHWuKX9O1ZN2kZuIuANODTBLV2vn0nFRZ+J+QnUXjUxIpgKGY86D74/Q==
X-Received: by 2002:ac8:5ad2:0:b0:2cb:96f9:caa4 with SMTP id d18-20020ac85ad2000000b002cb96f9caa4mr15225896qtd.640.1645386751181;
        Sun, 20 Feb 2022 11:52:31 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h4sm8196049qtr.95.2022.02.20.11.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 11:52:30 -0800 (PST)
Message-ID: <dfa34726-6133-01e5-c591-22f3ce1f8363@github.com>
Date:   Sun, 20 Feb 2022 14:52:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] rerere-train: modernise a bit
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfsjuw8m.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfsjuw8m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/16/2022 2:05 AM, Junio C Hamano wrote:
> The script wants to create a list of merges using "rev-list" and
> filters commits that do not have more than one parent, but if we
> always pass "--merges" to "rev-list", there is no need to filter.
> 
> The command uses "git show --pretty=format:..." on a single commit
> while generating progress reports, which means this title line is
> left unterminated.  It should have used --pretty=tformat:...
> instead, or better yet, use the more modern --format=... to ensure
> that the title line is properly terminated.

I'm unfamiliar with the rerere-train.sh script, but the changes
are pretty clearly achieving what you describe here.

Thanks,
-Stolee
