Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76787C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF760F13
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbhIFKSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhIFKSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 06:18:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0349C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 03:17:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso4554477wms.3
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9tgNj7s7uM/b4PzVL+M41voCZBcPFXE27eDKMWYeEPc=;
        b=UR6gVs6cLcP/3IgRCgkFocUGZOsNqxDPlKw6hE2T4WhQ5IJrULIsXo9qv9KpxUsdHH
         Xh14aWUJ+Y3ktYq47IaurVVKD6LF06CuiMZu7cXzwJIsyX8YMRjxOkmeVNDDjoMZjiHy
         JWcAiHVoX6fBjOCCzXlI+Ocf1zeSjzrqaXIRpMl+AHCYO0DolpNaz++hADOdZhGQdxIg
         rrBjKcpadGssJ+q/sk5Udtid9GqyzlZblmYG/uLSNGSrzNK9WIMyll6fQKUPe8YLMd94
         ePGYx9uXabJbcU0100PwH3gaZKjPE2yeSAKUDcYBlD88V6UioYQQ6mzxOUw2yunXPPBB
         iCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9tgNj7s7uM/b4PzVL+M41voCZBcPFXE27eDKMWYeEPc=;
        b=olsFWxW4mKELf2egGbZd4i5sRdxmhR0FwCPqc6/Ac+v2LAQtLP84pK+e6CXXjp6cZx
         i/vSBEZ7EriQEOrzNkl0PqTHd49a6ALNh8JqJ4NBhy62fb3uUIY4n2JE4zt/pJPOXR9Z
         L5HDqMKIeBJmIBbuVFvLouK9Kxp2AptdQPaS/Sc33ifr7YlgailgpkLDxeBG3nmHGura
         +KOSV3XUODTinI4m0dNF50rIUydmD7YNzOJqSt/ZbVjQhs+wqjULj4K/im1r9FfOK9xJ
         YEKb353Nm/Gyf7ICLBtkMU/hEmHBmlOQfb+kUP2QIwb8Kxs3htwqvSakkRjskaObCFvf
         Te7g==
X-Gm-Message-State: AOAM530G95WSQw/EPFQteMqpoXd/zcpKVhfdQ3ipQVRruQZu6JwhbO4S
        +VDA5pci7DB2kDbOysLG4Yc=
X-Google-Smtp-Source: ABdhPJwo0qFWyyu6rppk9TcWQc5s9AlkIvOIOyXNn7o0t0BgAzWXKsTINUv8aywc6rYjBoBAtXMLNg==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr10514732wmi.163.1630923465512;
        Mon, 06 Sep 2021 03:17:45 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.254])
        by smtp.googlemail.com with ESMTPSA id y1sm7127950wmq.43.2021.09.06.03.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 03:17:45 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
To:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5fcd3201-53d0-df5d-954e-74da1ef7e130@gmail.com>
Date:   Mon, 6 Sep 2021 11:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban and Johannes

On 04/09/2021 23:30, Alban Gruin wrote:
> Hi Johannes,
> 
> Le 01/09/2021 à 13:57, Johannes Schindelin via GitGitGadget a écrit :
>> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which was
>> included in v2.22.0), we officially deprecated the --preserve-merges
>> backend. Over two years later, it is time to drop that backend, and here is
>> a patch series that does just that.
>>
>> Changes since v1:
>>
>>   * Rebased onto v2.33.0
>>
>> Johannes Schindelin (7):
>>    t5520: do not use `pull.rebase=preserve`
>>    remote: warn about unhandled branch.<name>.rebase values
>>    tests: stop testing `git rebase --preserve-merges`
>>    pull: remove support for `--rebase=preserve`
>>    rebase: drop support for `--preserve-merges`
>>    git-svn: drop support for `--preserve-merges`
>>    rebase: drop the internal `rebase--interactive` command
>>
> 
> This is good.

I agree

> preserve-merge is the only user of `rebase--interactive'.  In
> builtin/rebase.c, it is the only producer of the following actions:
> 
>   - ACTION_SHORTEN_OIDS
>   - ACTION_EXPAND_OIDS
>   - ACTION_CHECK_TODO_LIST
>   - ACTION_REARRANGE_SQUASH
>   - ACTION_ADD_EXEC
> 
> Which in turn, are the only reason for these functions to exist:
> 
>   - transform_todo_file()
>   - check_todo_list_from_file() (from the sequencer)
>   - rearrange_squash_in_todo_file()
>   - add_exec_commands()
> 
> This is from a cursory glance, it may go a bit deeper.

I think patch 7 addresses most of that apart from the removal of the 
enum members and check_todo_list_from_file()

Best Wishes

Phillip
> 
> Should we remove these as well?
> 
> Alban
> 

