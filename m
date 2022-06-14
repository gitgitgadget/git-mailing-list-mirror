Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA213C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 13:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiFNNsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFNNsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 09:48:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDE35DF4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 06:48:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 19so9385627iou.12
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=32lBLchqzidHKexEVw0oEK7eucpLVsoCT3eQeyU0bw8=;
        b=K3nmkki30st9OiJ0Dw+ady+8qsXke2E76M7lOAM8CehFcj/5tAsJERrMPWxmOiwQ5/
         AkT9FEQu0l59PgodJmB7NS/0xDSmmGJcvkrkR1998BOAmOpu+i1GsExsUJYERLOjGw6M
         3K/zfzSLzLQN6WjW5Wq+0MPiChtwrdktOrHujv6DZDWZLjGfyl2cnvTLD+C0oomkcQHv
         j7dbO+B6NzzQq8tnywedhzhylD+SAbte2DB1tfeAuZT2c/Qci55SHi5P0krThtBcNy31
         +fJlRZSjVLV6tzrvIAvA0Q7idFgjuEQ3zpfO4lyRimGUwfLClOsUonEcmkOMxO2mXjy8
         7Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=32lBLchqzidHKexEVw0oEK7eucpLVsoCT3eQeyU0bw8=;
        b=dQLqQ3U7yGh4FdLguOuDEpt+uW6wttLYk7Yn7u6/j67go5V/XA+Ucqh0m8PiZGkYJu
         Dc5yJqV4hQYaskp5jWJbeSfCioQuCKhfRzleZmMI8ElzaP7fOFay+3Ziw+xitRsgFspG
         06DdRL63gR64grow9UXsJ9xzSSXiu8xAyqKZFenz3T1+f3P17qXXgiPr1OH+lqazV+aB
         qhFdQXeIGmL/HZeHLxS5HoSYiSZtfMjUKNzU9ZBpnvbsjknceaQQGt9i9eRjutww7bb8
         vwZ1kv1Tbu+e4TzWMriZZu4/YTKAl4pWOH9T+bWhbC92ETTqje2P6O0fSdxZy8hCfafD
         DP8g==
X-Gm-Message-State: AOAM532bELmfAfwxAAc56nk77omEBpt5oVesLsyOtC0EOMt0b6RFHqw8
        JRQjx+Dl+w6iRzLCFWpaUbsM
X-Google-Smtp-Source: ABdhPJz5oUD2u7efkFFwn2Bj8WoDX+QNutuErmNoukcJY9sSayGIOqakrZPFEYefehvCV1UeQywOEA==
X-Received: by 2002:a05:6638:2694:b0:332:913:4c1c with SMTP id o20-20020a056638269400b0033209134c1cmr2942398jat.171.1655214487917;
        Tue, 14 Jun 2022 06:48:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id a10-20020a027a0a000000b003318783c940sm4849082jac.113.2022.06.14.06.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 06:48:07 -0700 (PDT)
Message-ID: <526fd647-4d8c-7773-06e3-011db173fe28@github.com>
Date:   Tue, 14 Jun 2022 09:48:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] branch: add branch_checked_out() helper
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
 <42ada1a3-adc2-2c43-9aa1-7854858865ae@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <42ada1a3-adc2-2c43-9aa1-7854858865ae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 6:09 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 08/06/2022 21:08, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> +        if (wt->head_ref)
>> +            strmap_put(&current_checked_out_branches,
>> +                   wt->head_ref,
>> +                   xstrdup(wt->path));
> 
> STRMAP_INIT sets .strdup_strings = 1, so the xstrdup() is unnecessary.

That .strdup_strings is only for the key, not the value (since the
value could be anything, not necessarily a string).

>> +    }
>> +
>> +    free_worktrees(worktrees);
>> +}
>> +
>> +int branch_checked_out(const char *refname, char **path)
>> +{
>> +    const char *path_in_set;
>> +    prepare_checked_out_branches();
>> +
>> +    path_in_set = strmap_get(&current_checked_out_branches, refname);
>> +    if (path_in_set && path)
>> +        *path = xstrdup(path_in_set);
>> +
>> +    return !!path_in_set;
>> +}
> 
> I like the idea of having a specific function to see if a branch is
> checkout out rather than Ævar's suggestion of forcing all callers to do
>     strmap_get(get_worktree_refs_strmap(), ref)
> which will quickly get tiresome. I do wonder though if we'd be better
> off with a thin wrapper around strmap_get() such as
> 
> const char* branch_checked_out(const char *refname)
> {
>     prepare_checked_out_branches();
>     return strmap_get(&current_checked_out_branches, refname);
> }
> 
> so that the user can choose whether to copy the path or not.

This is an interesting suggestion. It changes callers a bit, but not
too much. The pattern currently is:

	if (branch_checked_out(name, &path)) {
		/* do something */
		free(path);
	}

but would become

	if ((path = branch_checked_out(name))) {
		/* do something */
	}

Sounds good to me.

Thanks,
-Stolee
