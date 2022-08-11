Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D27C25B06
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 15:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiHKPr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiHKPqV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 11:46:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB546EF07
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:40:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 17so17220153plj.10
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Q4PsDWAGIy12Ip9AaWa6/x+vD6RzJ/9Nab39ntuzG04=;
        b=FXlzx3kEhMC1MTfC50BQeEtxS5XvhF2/KSXDP42J6mD3iyQ0/5DgMXW8qiUmsHL7PL
         84L8oglD37cz1oL28TGw5VwFla+T1ipBPaTHYkoAy4x8tZ12pgnwfl/p/Mblt5phZ/XZ
         4S4qX/WpIVgsezEbqBIr0Tx9NsWzKne41wSNBcnBG9khXFMMjLVSTOHmvuoCHb0gjcPF
         86utl22dvmYGw5QsTHHx2XWwVp5cH0mRbC9jGuv2SbYoTjm99+UUmsqV1uH2I6LfY9XQ
         Ek0+gOUg6ZxWkxAoN47QBs9cnpB2e38/jy2BolTjq+gVdK2tZ6/I/qDzDPMKi1Ugtdqv
         OK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Q4PsDWAGIy12Ip9AaWa6/x+vD6RzJ/9Nab39ntuzG04=;
        b=mDhAXcCmgY5GvEJJyFvK2ZtyycnrvdHo/E5Y7ll9OFP82QB6ra+H4fybGn+04xga+a
         LoTcd271viVvhCuJjQDOCecYBfevUK2dPzEgR5fOyxVLEMdXyLoI8aod7+XJKAPiOS7/
         mpb5EFS5j9/7xCEKUb6D8Yr66ldDjo6hDWk8MRqGKSbowNVPOS6jdWofyS0n5Uw4uiIi
         7st3hcGFtfc5VaTmmfCvC5JulbOp5jNHmnxHJozfU9IgoeE00JmXlKUb4o6BcM4f61E1
         qVGzFePkVclVqSHOC0UUMpOSxXvsQWFieYueaQOs24d9On+JVjzW/gHdFd/hd9dXCfwx
         CIig==
X-Gm-Message-State: ACgBeo2PC1S3iJijOgD+jBS70EThUA9oYH+Zp2HG2pjTnFcBbKP6wuvy
        mTNngN6aM3NAtXBiK/8E8ta/
X-Google-Smtp-Source: AA6agR49OeaTog5EIluIE2GZ/d/SlwAb98zBxA9Dc6TB1vtUIxvjpca9Qt1+BqY+f/O13wYe3MQd1Q==
X-Received: by 2002:a17:90a:cb8b:b0:1f8:b7d8:8887 with SMTP id a11-20020a17090acb8b00b001f8b7d88887mr1054541pju.106.1660232444713;
        Thu, 11 Aug 2022 08:40:44 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id bi1-20020a170902bf0100b0016f02fceff4sm11714233plb.57.2022.08.11.08.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:40:44 -0700 (PDT)
Message-ID: <f9a5f658-7c6f-bb3a-d6df-0ab7d2908395@github.com>
Date:   Thu, 11 Aug 2022 08:40:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v3 09/11] builtin/bugreport.c: create '--diagnose' option
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <1a1eb2c980635415c04d5c8d9a62bd972482d7dc.1660174473.git.gitgitgadget@gmail.com>
 <220811.86edxnqcdk.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220811.86edxnqcdk.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Aug 10 2022, Victoria Dye via GitGitGadget wrote:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Create a '--diagnose' option for 'git bugreport' to collect additional
>> information about the repository and write it to a zipped archive.
>> [...]
>>  'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
>> +		[--diagnose[=<mode>]]
>> [...]
>>  static const char * const bugreport_usage[] = {
>> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
>> +	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
>>  	NULL
>>  };
> 
> This still has the SYNOPSIS v.s. -h discrepancy noted in
> https://lore.kernel.org/git/220804.86v8r8ec4s.gmgdl@evledraar.gmail.com/

The discrepancy you pointed out was on 'git diagnose' (which has since been
fixed), this is a pre-existing one in 'git bugreport'. I decided against
fixing *this* one because it didn't really fit into any of the patches in
this series, so it would need its own patch. When balancing "leave things
better than you found them" vs. "stay focused on the purpose of the series",
I leaned towards the latter to avoid setting a precedent for other 'git
bugreport'-related scope creep.

If you have the patches to audit this sort of thing, I think a nice place to
fix this might be in a dedicated series fixing discrepancies tree-wide. Even
better, you could include the patches in your tree that detect them as part
of e.g. the 'static-analysis' CI job.
