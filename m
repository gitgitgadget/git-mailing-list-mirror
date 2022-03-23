Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B770C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 17:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245745AbiCWRVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCWRVS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 13:21:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255B146669
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 10:19:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b130so250536pga.13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xdSvlF0B82BlgjS+0D0cgC0hMJAP93RkCEO39zM5PKQ=;
        b=go/BUrUErvrG8t+vwjdRjm49mrUbFYBfaMcd9chu60JcchrBvZ2ow29DJ5VBuLlx5r
         ZNayFk8BF0ZN1W4jmfwiSOCG8JIDQTsUXQooh/BHw7VHW3pYdPKANK8PR4pPX3Lw2BaG
         L/VCyzd4a3nEErm84d/Te76NfcyzWgRo97j1WJ/dDBdP/yrcQK/spKXlRi2YyqK2IGVJ
         73fSVF8lpOUhXywS6vJpqpu7a5Io/+CTA2XEmXtePwS4sls1a0CtcfdeNi2StCctKL7Y
         eyLoTxVGA6MNFmANMGrd3LqH3DmyFrpScJwPrZKZ4R7S3ITrlVUeS437dtcdew0mNC1T
         E/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xdSvlF0B82BlgjS+0D0cgC0hMJAP93RkCEO39zM5PKQ=;
        b=unpFn+a3OPASEmTSsHbfnlo+hWlK98DY5+xK8SqxYijhlpZqJXLihEBQJ0UQuvI9vS
         X1POFp4lQjVa7emb/pNCjLreZKNMoLeF9PP7kaOH6eyiTA+LKG8/CEcEALgMxE/dgPbt
         XyWveTu4Mw8sLTjfTYlOOmyuvaRCJ/jXlB89/xK11cP4lDi5eIYB0ZMQLwvMJDYrKoH+
         uxPGEp5GRYf4q+HbQv2Web3aS+/C2feclCnQE0fFDd+yO4cECzAO9ccE7R+Oo5CcFjik
         XlxMRtOq6J47NTqzPTLgPWgJSPYtph1PK9XyfR4VrSGsvh0jayC4x6xaFTBOy5yxdcMX
         s0MA==
X-Gm-Message-State: AOAM532ACciXWgL6JIi2YwQhQ30D6+lgyjj3Yq15k3YWmhKvcI4fwQZw
        Hotjq8x4BqavfyI+ENxxY4CZ
X-Google-Smtp-Source: ABdhPJy7mJ5vw0sPE4+gK5fNNXhs59Sao/HWXf5L9seL2EQ1oT5xKQRYFsN5X7Abtvl/JAsVqZHMoA==
X-Received: by 2002:a65:654f:0:b0:378:b8f6:ebe4 with SMTP id a15-20020a65654f000000b00378b8f6ebe4mr693146pgw.399.1648055987602;
        Wed, 23 Mar 2022 10:19:47 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f771b48736sm456412pfj.194.2022.03.23.10.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:19:47 -0700 (PDT)
Message-ID: <1d78ed3f-9644-e1c2-b95b-e1ae97df2c43@github.com>
Date:   Wed, 23 Mar 2022 10:19:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] reset: deprecate 'reset.refresh' config option
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <ecd3296fd25cc936aeb2f8ae160352a2326441c5.1647894889.git.gitgitgadget@gmail.com>
 <4f3cbfd5-65df-f44f-4867-45b1ab69c400@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <4f3cbfd5-65df-f44f-4867-45b1ab69c400@gmail.com>
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
> 
> Same concern about the title as the last patch
> 

Agreed, I'll change it to "remove" in this and the previous patch.

>> Remove the 'reset.refresh' option, requiring that users explicitly specify
>> '--no-refresh' if they want to skip refreshing the index.
>>
>> The 'reset.refresh' option was introduced in 101cee42dd (reset: introduce
>> --[no-]refresh option to --mixed, 2022-03-11) as a replacement for the
>> refresh-skipping behavior originally controlled by 'reset.quiet'.
>>
>> Although 'reset.refresh=false' functionally served the same purpose as
>> 'reset.quiet=true', it exposed [1] the fact that the existence of a global
>> "skip refresh" option could potentially cause problems for users. Allowing a
>> global config option to avoid refreshing the index forces scripts using 'git
>> reset --mixed' to defensively use '--refresh' if index refresh is expected;
>> if that option is missing, behavior of a script could vary from user-to-user
>> without explanation.
>>
>> Furthermore, globally disabling index refresh in 'reset --mixed' was
>> initially devised as a passive performance improvement; since the
>> introduction of the option, other changes have been made to Git (e.g., the
>> sparse index) with a greater potential performance impact without
>> sacrificing index correctness. Therefore, we can more aggressively err on
>> the side of correctness and limit the cases of skipping index refresh to
>> only when a user specifies the '--no-refresh' option.
> 
> Thanks for the well explained commit message
>> [1] https://lore.kernel.org/git/xmqqy2179o3c.fsf@gitster.g/
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>   Documentation/git-reset.txt |  4 +---
>>   builtin/reset.c             |  4 +---
>>   t/t7102-reset.sh            | 14 ++------------
>>   3 files changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
>> index f4aca9dd35c..df167eaa766 100644
>> --- a/Documentation/git-reset.txt
>> +++ b/Documentation/git-reset.txt
>> @@ -109,9 +109,7 @@ OPTIONS
>>     --refresh::
>>   --no-refresh::
>> -    Proactively refresh the index after a mixed reset. If unspecified, the
>> -    behavior falls back on the `reset.refresh` config option. If neither
>> -    `--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
>> +    Proactively refresh the index after a mixed reset. Enabled by default.
> 
> "Proactively" seems a but superfluous if I'm being picky. There was no entry in the config man page for reset.refresh so we don't need to do anything there. The code changes below look good
> 

Will update, thanks!

> Best Wishes
> 
> Phillip
> 
> 
>>   --pathspec-from-file=<file>::
>>       Pathspec is passed in `<file>` instead of commandline args. If
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index e824aad3604..54324217f93 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -423,7 +423,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>       };
>>         git_config(git_reset_config, NULL);
>> -    git_config_get_bool("reset.refresh", &refresh);
>>         argc = parse_options(argc, argv, prefix, options, git_reset_usage,
>>                           PARSE_OPT_KEEP_DASHDASH);
>> @@ -529,8 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>                   t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
>>                   if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
>>                       advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
>> -                         "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
>> -                         "to make this the default."), t_delta_in_ms / 1000.0);
>> +                         "'--no-refresh' to avoid this."), t_delta_in_ms / 1000.0);
>>                   }
>>               }
>>           } else {
>> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
>> index 9e4c4deee35..22477f3a312 100755
>> --- a/t/t7102-reset.sh
>> +++ b/t/t7102-reset.sh
>> @@ -493,19 +493,9 @@ test_expect_success '--mixed refreshes the index' '
>>   '
>>     test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
>> -    # Verify that --[no-]refresh and `reset.refresh` control index refresh
>> -
>> -    # Config setting
>> -    test_reset_refreshes_index "-c reset.refresh=true" &&
>> -    ! test_reset_refreshes_index "-c reset.refresh=false" &&
>> -
>> -    # Command line option
>> +    # Verify that --[no-]refresh controls index refresh
>>       test_reset_refreshes_index "" --refresh &&
>> -    ! test_reset_refreshes_index "" --no-refresh &&
>> -
>> -    # Command line option overrides config setting
>> -    test_reset_refreshes_index "-c reset.refresh=false" --refresh &&
>> -    ! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
>> +    ! test_reset_refreshes_index "" --no-refresh
>>   '
>>     test_expect_success '--mixed preserves skip-worktree' '
> 

