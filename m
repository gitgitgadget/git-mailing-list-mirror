Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088AC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB5120B1F
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfiEMC3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHNMYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMYk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:24:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D71FC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:24:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so6726680qtg.4
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=THe7QGtkfl7Ot7PnJU30YWGaOcYImCtkeb6rqzq3+OI=;
        b=sfiEMC3OaSRtJuVOLKAgYRcCVpVyT2H6j2V9mxx/uApQaLVK3He+Xepkb0kL8GeGKs
         mz4uTUIMvYNzKOHV8QBBKSCTzLVguZxROpG/Z3sAdsdz8PGdnpBkSnvMqoS63lUKzY9/
         vb8WwKitVPexDSc3q+Io4AOTQms8d+xcJh2zzAfh/CIE/jjA/7OI9ePVSIQ1cOTaoHbK
         fe92mYTJK3Ys4s/RKa0SFwN9cp+kQ8NTLkbNuEwkqScP+V7CP4a/8SFE91WmnyDQJKvS
         5NRYgITZXNl2U3L9ReKemU9l+6yFxbNlBdXqcPc9QlEta41tCfVeEyX/LdoDf6a+3yze
         M+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=THe7QGtkfl7Ot7PnJU30YWGaOcYImCtkeb6rqzq3+OI=;
        b=ZUVvm5sqAxf5aDJEr5ssNuGu8XSPQ2uiP7LrW7gDrXtswPSZSZ95OKyytnR7efPYQA
         adI07uFOzMmZp8XR3cfHIL1DvNtDR9hI6+9AldZLGDzDAdkYOJniDWatT58zxLMTeeOw
         rB8Y7caxyoqqf/6ljWY6E9a4msw8+81uY5p6Epw06SmX7mya2xNZD9Nv5004xFTq0Pd5
         EZmyituFn+rqnK0aEN9L7Ki6OP/9iHZpgNm0UYIwBJ7xFr61avoUU0qsllGA3eM81nuO
         HaoGvXL2sj3UPLquKn2TXqaQYzZsEDDZfePTPpuzP7j8nUKTudGFFuZNV/1G2TPeXPGW
         iCng==
X-Gm-Message-State: AOAM531qtAev86QgONvfFwAHklve5lKpznJ3GDzessWS0nOsBJ8HgISm
        NpiF02D39u/OQmKiY8nykPc=
X-Google-Smtp-Source: ABdhPJzgIca9a78jV7mkgXnj1EBte4qC8/zj8otdgkbK1xY5RfyOHsMjETnMUqVaHiztA4x2K//dkA==
X-Received: by 2002:ac8:7a66:: with SMTP id w6mr1776376qtt.242.1597407879386;
        Fri, 14 Aug 2020 05:24:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id k55sm9065136qtf.17.2020.08.14.05.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 05:24:38 -0700 (PDT)
Subject: Re: [PATCH v2 07/10] commit-graph: implement corrected commit date
To:     a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
        me@ttaylorr.com, gitgitgadget@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <bfe14732014807ff19f943cdf51068f0d3043c30.1596941625.git.gitgitgadget@gmail.com>
 <a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com>
 <20200814045957.GA1380@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2c7ee14e-1c80-9860-7bcc-633ac43910a6@gmail.com>
Date:   Fri, 14 Aug 2020 08:24:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200814045957.GA1380@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 12:59 AM, Abhishek Kumar wrote:
> I solved the issue by adding a new member to struct commit_graph
> `read_generation_data` to maintain the "global" state of the entire
> commit-graph chain instead.
> 
> The relevant changes are in validate_mixed_generation_chain(),
> read_commit_graph_one() and fill_commit_graph_info().

I think this is a good way to go. Adding that restriction about
the tip commit-graph was short-sighted of me and was likely to
break in the future.

I think your solution here to store extra state from the entire
chain into each layer makes a lot of sense.

Thanks!
-Stolee
