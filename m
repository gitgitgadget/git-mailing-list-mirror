Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiCWQyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiCWQyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:54:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9816840E47
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:52:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bx5so2285611pjb.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G1Ul0GfKif+6rSToPONT7T/frptF8eune9jPFCPCm14=;
        b=GbvNrPhqScaoQcyHHky7QG7JhuVcNI2sBtlzxQYI/UuWvCMrUWIGRUky91IAmMTJMK
         VBORPmT4b+nn4nizMS2SJNmza5M66Bbaacy5KEfS/pG/f6qHatrtC9Et+hSRAs61482i
         cCkIol1PDMYX4UWQxsX/xA9978Lcknc0MsVk//SyjeTfLLR6v43o72HZ1D/2OOXTHH9b
         jGqpTGmYCXhW9g3UpkAw3etInR+WJ230xXus1L250fSxWVduGuYR9yvJxh5Fnqg9Ux7T
         YfGHWeb5wKOofxjJlFe/n3KVsOAcZv4F7acCtVdg+JCRKx2OGsfiCi56XK+6ZMAl1XK2
         SQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G1Ul0GfKif+6rSToPONT7T/frptF8eune9jPFCPCm14=;
        b=Fvp9qEymbdN5wmYpsvw28e80PBbtZsytCug/Qo+g1Qepi4vGodCCaGLDL3UqlYTnN1
         l8/MVur9b4YuX31ddcfnfW/ks6xU4e7uMT5lPzTdSEOfydtXaOqWFya/uLqPaL/BangL
         fzSI3NeFokhdp4ecGP/e1a2V8zgrJLZrK1gPgoagSlE80oqI7Q/j+nu5jTTgzWVkI40P
         bUkXDkX94cU+qzraXyMTsUEXFZu94YVkna4UoSUImjf9ph3y+9Ahnpc0mGkAe/gsVidq
         gy5Sm4uKFwMGHs3Mg0j7NNBTXKlFSDkQnVEWTKqYKYk8a7PVGk4spc71iExc+JwUL7IQ
         D17w==
X-Gm-Message-State: AOAM5303nVuCVHgXKBTcpge+Jv2SHlynNwS8H2lUc3P9fq9rx9Tv6fB4
        qSm4FaXf3yzxq1MOpMJtSLKg
X-Google-Smtp-Source: ABdhPJzNP/SWfClejc9Rpi5vschwAQPdULNWtHS7w2PMl3F2f3jYWj+2NCJfKjHsAiQDXgG1TEhBJw==
X-Received: by 2002:a17:903:240f:b0:153:dd42:fd73 with SMTP id e15-20020a170903240f00b00153dd42fd73mr939258plo.173.1648054352005;
        Wed, 23 Mar 2022 09:52:32 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm478247pfl.140.2022.03.23.09.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:52:31 -0700 (PDT)
Message-ID: <96e386f9-01b5-a231-f1f6-4d9ffefc8f8d@github.com>
Date:   Wed, 23 Mar 2022 09:52:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] reset: do not make '--quiet' disable index refresh
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <f89e9b4ae24718116d0275333f4ece1d4024ab6b.1647894889.git.gitgitgadget@gmail.com>
 <355f36d5-7153-42a4-6db8-b9ba5fcac422@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <355f36d5-7153-42a4-6db8-b9ba5fcac422@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> Hi Victoria
> 
> On 21/03/2022 20:34, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Update '--quiet' to no longer implicitly skip refreshing the index in a
>> mixed reset. Users now have the ability to explicitly disable refreshing the
>> index with the '--no-refresh' option, so they no longer need to use
>> '--quiet' to do so. Moreover, we explicitly remove the refresh-skipping
>> behavior from '--quiet' because it is completely unrelated to the stated
>> purpose of the option: "Be quiet, only report errors."
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>   Documentation/git-reset.txt |  5 +----
>>   builtin/reset.c             |  7 -------
>>   t/t7102-reset.sh            | 32 +++++---------------------------
>>   3 files changed, 6 insertions(+), 38 deletions(-)
>>
>> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
>> index 89ddc85c2e4..bc1646c3016 100644
>> --- a/Documentation/git-reset.txt
>> +++ b/Documentation/git-reset.txt
>> @@ -114,10 +114,7 @@ OPTIONS
>>   --no-refresh::
>>       Proactively refresh the index after a mixed reset. If unspecified, the
>>       behavior falls back on the `reset.refresh` config option. If neither
>> -    `--[no-]refresh` nor `reset.refresh` are set, the default behavior is
>> -    decided by the `--[no-]quiet` option and/or `reset.quiet` config.
>> -    If `--quiet` is specified or `reset.quiet` is set with no command-line
>> -    "quiet" setting, refresh is disabled. Otherwise, refresh is enabled.
>> +    `--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
>>     --pathspec-from-file=<file>::
>>       Pathspec is passed in `<file>` instead of commandline args. If
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index c8a356ec5b0..7c3828f6fc5 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -430,13 +430,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>                           PARSE_OPT_KEEP_DASHDASH);
>>       parse_args(&pathspec, argv, prefix, patch_mode, &rev);
>>   -    /*
>> -     * If refresh is completely unspecified (either by config or by command
>> -     * line option), decide based on 'quiet'.
>> -     */
>> -    if (refresh < 0)
>> -        refresh = !quiet;
> 
> Does this mean we can stop initializing refresh to -1?
> 
> Best Wishes
> 
> Phillip

Yes, thanks for catching that! It should be initialized to 1 in this patch
(rather than later in patch 4).
