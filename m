Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213FEC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbiCWRAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCWRAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 13:00:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923DC4F45D
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:58:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so1935937pfh.8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g/8++IeP2jrpcjOV0A5lA1//jfLsItXRUWzqm3I+ZxM=;
        b=V0PLYKCt3UNLzTxLdf0reLZmfhFUgTu0FHrOJz1k7gvA1t44KF2h4zOfT6viiw0RWm
         hgIeIRa122F5i8+6tc2O/xKHqSQVRrbu9smpWFOXf/wAfwO22/0F/+h+RStyBGNCqlXR
         ahVlWEULWxMVJJEF/ff3hyt66C7Nkpw7rhUP5UlJWnlEXJX+Z7Hp3qTyGoYK0VpEwa8B
         l2nzVPzyZ4LaAqxniMSQU68i5rMrpLKuvrboF4c1/Zc6HFPLinwvuq4OLDqJy2m02jS/
         YZ3UcmbQvP/S/lz8WFMU35BIV3XzLTcBQIT/eZ8MT/NmqcAB5S0lGornDLZHXwpxQ4PR
         Rj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g/8++IeP2jrpcjOV0A5lA1//jfLsItXRUWzqm3I+ZxM=;
        b=m1JHoNudkDtGQbXoBxXkgw/ruKmnd4YiPDCknh0ggrAGWL4ztPVvvJKyQTyr/aHhn2
         90o/56OLFD1f9NncZBd8Su9hSQLjby08tFfnS51/DifBkwzCcqfvJcRna6d9+DUfxBYi
         Cz4V1qJZ1YpgN+REnzHqRECcYON5Oko5QoG1drmwyVfeN2XE59Og41DJqmQUVVtR4UZV
         6qUEtRmvtUmaHHuXdZaRdLgMhqP1tX8/ZBJELfXUB0FtJ1PpoGmpskSWxDrm2m46yWly
         3GlTXP0yLkXuPiPVPBYcyALbhYizuxa5oqQ65I3vtJHeovnBnZ3sAw2p/B2usuou+Bk7
         YNGQ==
X-Gm-Message-State: AOAM532ZDPwlTWG2vjRkRtYSLKNH9WmcGmO8EqS9VqMMmdOI/eicLxKG
        IXSQZJ2vBHj0Gj4R+DReIRY9jy631Oqk
X-Google-Smtp-Source: ABdhPJwustfZy1McFYP+7kRDTlY/a9Cxz6qN1K+oKoy5+s3mrrwWKjrMc4fjPv3OSXEXshKx5CXGfg==
X-Received: by 2002:a63:d306:0:b0:34e:4330:efea with SMTP id b6-20020a63d306000000b0034e4330efeamr667162pgg.174.1648054718839;
        Wed, 23 Mar 2022 09:58:38 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d80-20020a621d53000000b004fae1119955sm427242pfd.213.2022.03.23.09.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:58:38 -0700 (PDT)
Message-ID: <017dd12a-7b9e-4150-1327-8ca45435a097@github.com>
Date:   Wed, 23 Mar 2022 09:58:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] reset: deprecate '--refresh', leaving only
 '--no-refresh'
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <dbb63c4caa83cc764535a739d20736b706ee44a5.1647894889.git.gitgitgadget@gmail.com>
 <3f8c28c6-5f99-e9ac-e356-48182e269b5c@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <3f8c28c6-5f99-e9ac-e356-48182e269b5c@gmail.com>
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
>> The explicit '--refresh' option was needed in the past when '--quiet',
>> 'reset.quiet', and/or 'reset.refresh' disabled the index refresh in 'reset
>> --mixed'. Those options have since either been deprecated or made to always
>> refresh the index by default, leaving only '--[no-]refresh' determining
>> whether the index is refreshed or not.
>>
>> Because there is nothing other than '--no-refresh' to disable index refresh,
>> we do not need a '--refresh' option to counteract some other refresh
>> disabling.
> 
> '--refresh' could be used to countermand a previous '--no-refresh' (typically when using an alias that includes '--no-refresh'). Usually we have '--foo' even when it is enabled by default e.g. 'commit --verify'. I think the code below does actually support '--refresh' as parse_options() is smart enough to recognize option names beginning with '--no-' and creates an inverse option by removing the prefix rather than adding '--no-' as it normally does.
> 

Makes sense, I didn't think of the alias use-case/generally wanting to
counteract the negative version of the option. Thanks! 

>> To ensure users don't use what is effectively a no-op, remove '--refresh'
>> from the set of 'reset' options, as well as its usage in 'git stash'.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>   Documentation/git-reset.txt | 3 +--
>>   builtin/reset.c             | 6 +++---
>>   builtin/stash.c             | 4 ++--
>>   t/t7102-reset.sh            | 5 ++---
>>   4 files changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
>> index df167eaa766..ba8dece0c03 100644
>> --- a/Documentation/git-reset.txt
>> +++ b/Documentation/git-reset.txt
>> @@ -107,9 +107,8 @@ OPTIONS
>>   --quiet::
>>       Be quiet, only report errors.
>>   ---refresh::
>>   --no-refresh::
>> -    Proactively refresh the index after a mixed reset. Enabled by default.
>> +    Disable refreshing the index after a mixed reset.
>>     --pathspec-from-file=<file>::
>>       Pathspec is passed in `<file>` instead of commandline args. If
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 54324217f93..d9427abc483 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -392,7 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
>>   int cmd_reset(int argc, const char **argv, const char *prefix)
>>   {
>>       int reset_type = NONE, update_ref_status = 0, quiet = 0;
>> -    int refresh = -1;
>> +    int refresh = 1;
>>       int patch_mode = 0, pathspec_file_nul = 0, unborn;
>>       const char *rev, *pathspec_from_file = NULL;
>>       struct object_id oid;
>> @@ -400,8 +400,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>       int intent_to_add = 0;
>>       const struct option options[] = {
>>           OPT__QUIET(&quiet, N_("be quiet, only report errors")),
>> -        OPT_BOOL(0, "refresh", &refresh,
>> -                N_("skip refreshing the index after reset")),
>> +        OPT_SET_INT(0, "no-refresh", &refresh,
>> +                N_("skip refreshing the index after reset"), 0),
> 
> I'm confused why we need to change the option type here - am I missing something?
> 

This was to explicitly prevent a user from specifying "--refresh", only
allowing "--no-refresh". But, based on your earlier comments, there's still
some value in having "--refresh", so I'll drop this patch entirely.

> 
> Best Wishes
> 
> Phillip

