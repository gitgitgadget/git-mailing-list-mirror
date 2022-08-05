Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7101C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 19:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbiHETLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 15:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiHETLR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 15:11:17 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D1D10F
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 12:11:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id l18so2361859qvt.13
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=uTON9pmZqujaWsUEJMhNYmZQNNFD8PlTXz4VUHhfka8=;
        b=Os8j9Uskwp/dX9ISz/RF5C0i22zFWud5aNzVqdkJ68SQeyNMmSkb2yVTzQYdlFySVi
         FRbSc5q1ev7/zWXqmRWx5llziXxb9Wafd0+On0GwdPM+7rIF1Q6L16dObYdIHkvcNnuh
         2/ibtVXWPC64P5k+gfrOO+koxoRqofgxjUDaeMU+iuQf73EUNw9+hkDJA37DOTg9sn1R
         4lcFteTSUFSqshokJ8pDCOazyeAV2PXTKqUI2w0Le7uA+TUz8UMhxZjChzoSfpdzn67Y
         Hs0fviTfDovktn7ki7gwyTiML+TlWSJu3lWHSTU6n4/gIConfTXouekG1H3KXP52P4Mv
         ZXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uTON9pmZqujaWsUEJMhNYmZQNNFD8PlTXz4VUHhfka8=;
        b=4yoZLW5f6p/LrPy0w0CG8S3ljBBDUWdxSvHkDeE1Eob01RixfsmeuFkviNo35+/kD1
         +zsPkfGwY4MZW/bQDxCrucaX9k2Luxx5KZ//0NYmnonH2z1KtUT8t8JPPiV9hncZ/bC2
         LBIXt3j2DyOdRrmNzYjjS1y4DPUUsAkdJtAlSse8bienRR0BBnGXBl4cmlJSW5LsTPTN
         d8adLSdDqL+7q2eC+m/J4PYv7QG3rU9JACoEx3TsT1558ccrycYfVHDmnKiLWZSgadMg
         rhxDNStLkBGA9YqrCiOfq81Moe286PlprM7iOCoavuh+w+0QT7CZ+GbiT1cyIXUSoxXH
         OBog==
X-Gm-Message-State: ACgBeo1CZw+o7o2seH3q8hIPMJg13W457v1WcuDSrCaJk+hGtDqVFO0O
        f2RCHQykbXP8FoGDMr5I7Oct
X-Google-Smtp-Source: AA6agR74lgn4gDHJ0EH0IrTV3PT4+yF/z0GCCQwPf65hPpn3aWVL8XTglLKvgQHAorAlhsMHEvCZdQ==
X-Received: by 2002:a0c:9bda:0:b0:474:73b0:b3ec with SMTP id g26-20020a0c9bda000000b0047473b0b3ecmr7057207qvf.84.1659726674806;
        Fri, 05 Aug 2022 12:11:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a248500b006b5fc79427fsm3777612qkn.77.2022.08.05.12.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 12:11:14 -0700 (PDT)
Message-ID: <7cd85665-3827-4f83-4e39-564e161fdea7@github.com>
Date:   Fri, 5 Aug 2022 15:11:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 06/10] builtin/diagnose.c: create 'git diagnose'
 builtin
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <73e139ee377f9c50e671b0d94a28b93c1db28a69.1659577543.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <73e139ee377f9c50e671b0d94a28b93c1db28a69.1659577543.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 9:45 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Create a 'git diagnose' builtin to generate a standalone zip archive of
> repository diagnostics.

> +  * The contents of the `.git`, `.git/hooks`, `.git/info`, `.git/logs`, and
> +    `.git/objects/info` directories

You remove these lines in the next patch, which is called "gate certain data
behind '--all'" but maybe we shouldn't have this functionality now and
instead add it in the future.

The biggest reason for the --all option is that these contents will likely
include private IP (path names and branch names, but not file contents) that
the user would probably not want to share with the public mailing list, but
might want to share with a trusted Git expert in order to resolve a problem.
You mention earlier that

  The generated archive can then, for example, be shared with the
  Git mailing list to help debug an issue or serve as a reference for
  independent debugging.

So, if you're sending a v3, then moving this out of this patch and into the
next one would be a good way to be sure that this possibly-private data is
not mentioned as something to share super publicly.

(Of course, this requires making the change to create_diagnostics_archive()
in advance of creating the builtin, so maybe this reorganization isn't
worth it.)

> @@ -0,0 +1,58 @@
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "diagnose.h"
> +
> +

nit: double empty line

> +++ b/t/t0092-diagnose.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +
> +test_description='git diagnose'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success UNZIP 'creates diagnostics zip archive' '
> +	test_when_finished rm -rf report &&
> +
> +	git diagnose -o report -s test >out &&
> +
> +	zip_path=report/git-diagnostics-test.zip &&
> +	grep "Available space" out &&
> +	test_path_is_file "$zip_path" &&

nit: 'grep' the output immediately after the 'git diagnose' command and
keep the zip_path use immediately after its definition.

Thanks,
-Stolee
