Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCA9C3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 20:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjAMUHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjAMUHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 15:07:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE5F54702
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:07:02 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy8so54639499ejc.13
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkyCP2F+bgGKDoBMMMZx0a0ho6cr5ZgDG1huZRg+mPk=;
        b=Uf2ortSKi29TjbWmJY8NQ2bq3DAqPiv3Diva1rRPBXopvGuYn3R4SUfXgRCFvq6I4i
         n7ez6eZThQTBXZ4WFavtbaL0nEoOkpf7tv//6HUYeyCsaaBfaKzn7HWR18Z3+NAjgxfk
         XagrcXVRWhKT0KaMklRDBxwgKxY7xRFsK5P5FZlQ3YS3GaL0unzey4ow1o+6KoyPusyO
         TlkNBkOTsECAUQHYB3z2o2wdncf5tbFd6MhDkI9vcVTGWJDNb30ATFfdbFlFKnZZPZmG
         Q3iM9zIQVAO8+tsDjhKuJF8LIJ5VZ58urJ73ueZqjE7ZQ/m6YhZCGfHYLAONbWpNwNEM
         Yeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkyCP2F+bgGKDoBMMMZx0a0ho6cr5ZgDG1huZRg+mPk=;
        b=YUVgA4emAUCM6SxfkbtEJpGbFqRTDXHKel8knusAXKl72i0jWVZq5c83t+kNlz/+sR
         I2kA1N5m2JcJkPFwx2IqttZQUL4PNXdvTUsvPTHApp9nXHmiqgn0L3uoJgPrPDbvltSV
         cpxBr3PAze5HfsK/aNPbJITvTGSbN/KgHXBSNqztSDpc/i+yWsxW79S30+EXvF+FhbKI
         F706p1KJUpiqyw0URFrZKEy8hKjPCbt/EdoTrfj5ujNyB1rgifegCPcwHY7rJrd6B7HK
         Q+mtHR6wLUXbXfIQyQpUuCFEEdflS3D5h//esGHKlrc7VLhotEfJqKFD0UH7Bvob1/AM
         T4EA==
X-Gm-Message-State: AFqh2kpeCIj9v7X5zU3FsRXOOeZ/3YnUhste3kC/leizXfSfeIW5wXKD
        APoQ5eIeW5QRjJyqNlRyYtwppQv4EzZOXIawSoE=
X-Google-Smtp-Source: AMrXdXvdJjXG0liO41X9o5w75RwwCme5dNPKsmUpOI3rQrbImD+T7DE2O3vCov4wBRcSgjbVkuOYtQ==
X-Received: by 2002:a17:906:6881:b0:84d:4d6c:a462 with SMTP id n1-20020a170906688100b0084d4d6ca462mr15695265ejr.25.1673640421254;
        Fri, 13 Jan 2023 12:07:01 -0800 (PST)
Received: from [10.12.18.155] ([45.88.97.218])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b007aece68483csm8914644ejc.193.2023.01.13.12.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 12:07:00 -0800 (PST)
Message-ID: <c17dfab8-5cc6-dbff-547d-08a3d7c289a7@gmail.com>
Date:   Fri, 13 Jan 2023 21:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] rebase: cleanup "--exec" option handling
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1461.git.1673542201452.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <pull.1461.git.1673542201452.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01/2023 17:50, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When handling "--exec" rebase collects the commands into a struct
> string_list, then prepends "exec " to each command creating a multi line
> string and finally splits that string back into a list of commands. This
> is an artifact of the scripted rebase and the need to support "rebase
> --preserve-merges". Now that "--preserve-merges" no-longer exists we can
> cleanup the way the argument is handled. There is no need to add the
> "exec " prefix to the commands as that is added by todo_list_to_strbuf().
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>      rebase: cleanup "--exec" option handling
>      
>      A small cleanup following the removal of "--preserve-merges"
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1461%2Fphillipwood%2Frebase-cleanup-exec-handling-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1461/phillipwood/rebase-cleanup-exec-handling-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1461
> 
>   builtin/rebase.c | 45 +++++++++++----------------------------------
>   sequencer.c      |  4 ++--
>   2 files changed, 13 insertions(+), 36 deletions(-)
> 

I can't really comment on code, but I appreciate any simplifications
around `rebase --exec`, because it will probably make it easier for
me to revive the topic about `rebase --edit-todo --exec` from the
end of 2019:

     https://lore.kernel.org/git/20191114163549.7648-1-rybak.a.v@gmail.com/T/#u

It's current state (experimented a bit a week ago) is on GitHub:

     https://github.com/rybak/git/tree/edit-todo-exec

Thank you.
