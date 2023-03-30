Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E717C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 16:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjC3QLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjC3QLl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 12:11:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED41FE2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 09:11:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d8so11648013pgm.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680192667; x=1682784667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DE07Fjomkn7Uh8AH+QD1pSyvd1lP0ZeF9zWAHGelYyE=;
        b=iSsyp18rWgy/m+UdJV0zwy3Kz2XzoxoRLlXPFsznwNKj0rPuQNXRIZoz43VSqepfTx
         WPJFG0TwUA6TrhmwhiyaBLTZv8FGUASuo1Thxy57ol4QXnyg2it3RqveRNheY2J2jXXu
         iWwgGWl6E7qacU1jNQHzkHZZyNyiEhFO7uvDZRH1sGSJfIRH8L/ANJ3wzSjI+EAyTpnd
         TJ6Ddnh9jeF/81iyrjCRLLM4AVfoF/PrbRdsueel8ZsjzhJiwSl7cIuvXiNI1OEcJ1Os
         1Clv2IUw3/bqFnfMHjy2xM1GnNB8qaMTnWt/NyrQZmktmIJdJweV8nlI23sOV5YX4cXo
         kMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192667; x=1682784667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DE07Fjomkn7Uh8AH+QD1pSyvd1lP0ZeF9zWAHGelYyE=;
        b=OjLkRo5KZ3vAcSalBLfAkKtiCEG55xmb95pqMUrWGxdNO+Wv/UrIvGc51dFxQINUs0
         s6w1oI+kToLo1HSUxJ7XOPbCeYePIuhvNfTHSSPFcMyYEdraiG1qJs/BqstXd+s8MJKE
         1xt5rHpsJ4CW4nGlMEN235+9ynnVkJfVTi9TIer/oo4Btz0jv1jPKPM7ad3HWOvVFSW8
         m/0XivWnvOSCOya2tAI4siwumUpZnq7y5EaygUL16TPtP8fvasuPzPRiHZhT9McEWGDT
         Johu/HQ/unVhmxwb5Yb+JC+pqsonhaAceWMWUzK1/XcpCIu8puInPm9UILZdw6PI4ZoQ
         HzcQ==
X-Gm-Message-State: AAQBX9ehI0I/ft1yqSxLJeTQgcRhWh079p3Eu5UF/U87MXB42WTVT/dj
        rjoJJBpWru7wKBJ0vKtJFpuHh6VRI2dhnJU8
X-Google-Smtp-Source: AKy350YTiHFnZTPuvFUkHkczAMsYoXFDvkG9TYqh/JB0dTtS4vVJfLg4b34GHBht9qDOdi38IHBW2A==
X-Received: by 2002:a05:6a00:194e:b0:62a:5ae:3012 with SMTP id s14-20020a056a00194e00b0062a05ae3012mr3174186pfk.1.1680192666675;
        Thu, 30 Mar 2023 09:11:06 -0700 (PDT)
Received: from ?IPV6:2409:4072:6c1a:e98:4656:79f5:792e:cb? ([2409:4072:6c1a:e98:4656:79f5:792e:cb])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b00627ed4e23e0sm63958pfo.101.2023.03.30.09.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:11:06 -0700 (PDT)
Message-ID: <945ec6f2-8370-0d99-0537-a3724eefde3f@gmail.com>
Date:   Thu, 30 Mar 2023 21:40:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] describe: enable sparse index for describe
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
 <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
 <8cb2b7a2-78f2-9221-1234-62814557d2d3@github.com>
From:   Raghul Nanth <nanth.raghul@gmail.com>
In-Reply-To: <8cb2b7a2-78f2-9221-1234-62814557d2d3@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/29/23 23:19, Victoria Dye wrote:
> Raghul Nanth A via GitGitGadget wrote:
>> From: Raghul Nanth A <nanth.raghul@gmail.com>
> 
> Hello! Thanks for working on this patch, it's always nice to get more sparse
> index support. Since this is your first contribution to the mailing list,
> though, it's unclear to me whether you're working on this as an independent
> contributor or if you're interested in the Google Summer of Code project
> "More Sparse Index Integrations" [1]. If you're doing this for GSoC, could
> you please prefix the title of this patch with "[GSoC]" (as noted in the
> application details [2])?
> 
> On the topic of GSoC applications - if you are submitting this for GSoC, I'm
> a bit curious as to why you jumped right into sparse index rather than first
> submitting a microproject [3]. This is a good first pass at a sparse index
> integration, but the microproject is a better way to get acquainted with the
> conventions and requirements of contributing to Git, hence the strong
> recommendation to complete one first.
> 
> [1] https://git.github.io/SoC-2023-Ideas/
> [2] https://git.github.io/General-Application-Information/
> [3] https://git.github.io/General-Microproject-Information/
> 

Hello. So, yes, I am interested in GSOC. As for the reason for choosing 
to do sparse-index, I had just missed the part about the micro-projects. 
Sorry about that. So, do I submit a micro-project patch?

And as for the changes mentioned, I will make the changes in the title
