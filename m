Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB40C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 14:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbiBGOuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392432AbiBGOai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:38 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FBEC0401C1
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 06:30:37 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d8so11479701qvv.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K6WlhOmI/17RZcb2egJVO4ve9PTX15gAq9bMwHUlviE=;
        b=FgbObxLTKr1gGRWdKzZElWOwqiQ/u1E3bfny48kSEF3Ydcsnq3Shz3JWmLnmtQP3p6
         fZfiwalqHtYv+I+ijjDOpgr4ruS6k0Nz/UHOklwoB/uUnQWLmsRhTMzoAa3ce8s6I1YT
         dYFUdBXHQh91CiE3xFr98pOcxMGeUQlTfbKzlfuucLmieYAEjuqrP+sxj4G/e+QH0sTM
         95yPumMV7/WPAA3reWBq6lBfsChIvYJowVOhMbDl8eRLViTLSCBq6vEKOD9MyKoysYA2
         CBo4mQcMigcZGxvHj8FO9UvSR13NXGs53Z7pRsmGB1oQv4bZuNcpd6Tgpq0Hfa4HEvTD
         RAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K6WlhOmI/17RZcb2egJVO4ve9PTX15gAq9bMwHUlviE=;
        b=ezLQzPrpR1fay463dQkXt87rvXnGjrpXq9EnZzon6BSRBV5jZITp5fG+3E51iqoMP7
         sQHCxZ6Bh6Gyc9I2GihFvnuKTRvYq3y3R9cQTubv6H/LemrEFu84FeVRLnWp6Y8pkdqD
         ZjHetQyqiy9AyF8mKCApy4jkOeo7clHKOxiCFJTdEjkzLv5lxqbO6ThibakbVYuGl08m
         ZkaEsbCIzVBYXL5GQJrSjmZwDjSf+MIn3Lfm5MCfshhIjd4Fxio1sbhnTVWoz7nBLTY1
         Vo3oYGGAiRbgRg25m3CbaB1jrNbB2peq+PwZpQQ/2DudOa3I7oK1dSprrCKbSL7+/0mm
         gXHw==
X-Gm-Message-State: AOAM533V2/qIjUWvRcdZcAaYMABuuallfUHMazauY+f1M+VZDQabo2Xa
        WSm2fuSqlMn+jJmDFz2AM3c=
X-Google-Smtp-Source: ABdhPJwEvEhbMShRqrgxZjfdk5ko54pvx2gH35zuq5BNrt3FHVNFC049+4OeQVHROGGFU9FP6TxMKA==
X-Received: by 2002:ad4:5b8a:: with SMTP id 10mr10633035qvp.18.1644244236902;
        Mon, 07 Feb 2022 06:30:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2d61:adc7:f4c3:dd65? ([2600:1700:e72:80a0:2d61:adc7:f4c3:dd65])
        by smtp.gmail.com with ESMTPSA id w22sm5984539qtk.7.2022.02.07.06.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:30:36 -0800 (PST)
Message-ID: <93747eca-08d6-0be9-08c7-42c81340b788@gmail.com>
Date:   Mon, 7 Feb 2022 09:30:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
 <CAPig+cQOieO3cmZv42G_8XRiMwkh4v3cO1AYg5VR9SiPNMwxhw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cQOieO3cmZv42G_8XRiMwkh4v3cO1AYg5VR9SiPNMwxhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/6/2022 6:30 AM, Eric Sunshine wrote:
> On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +       /*
>> +        * If we are using worktree config, then copy all current config
>> +        * values from the current worktree into the new one, that way the
>> +        * new worktree behaves the same as this one.
>> +        */
> 
> As an aid for future readers, it might be helpful to extend this
> content to explain _why_ the new worktree should behave the same as
> the current one. Reproducing the important bits from the commit
> message here in the comment could make it more useful.

Here, I think I disagree. The comment is intentionally short to say
"we need to be careful here" but the reason behind it can be found
in the commit message from history spelunking.

>> +                           git_config_set_multivar_in_file_gently(
>> +                                       to_file, "core.bare", NULL, "true", 0))
>> +                               error(_("failed to unset 'core.bare' in '%s'"), to_file);
>> +                       if (!git_configset_get_value(&cs, "core.worktree", &str_value) &&
> 
> In patch [2/5] you used git_configset_get_string_tmp() to retrieve
> this setting, but here you're using git_configset_get_value(). Is
> there a reason for the inconsistency?

I'm not sure why I chose to use one over the other, but looking at
the code, it seems that my use in patch 2 is the only use of
git_configset_get_string_tmp() that is not internal to config.c.

I should convert the one in patch 2 to use git_configset_get_value()
and then we can remove the declaration of git_configset_get_string_tmp()
in config.h.

>> +               git worktree add ../there3 main &&
>> +               cd ../there3 &&
>> +               git status
>> +       ) &&
> 
> Is this some debugging code you forgot to remove or was `git status`
> failing due to the bug(s) fixed by this patch series? I'm guessing the
> latter since you also use `git status` in more tests below. Anyhow,
> it's not very clear what the `git-status` is meant to be testing. An
> in-code comment _might_ help. Even better, perhaps, would be to add a
> new single-purpose test or a well-named function which explicitly
> checks the conditions you want to test (i.e. that git-config doesn't
> report core.bare as true or core.worktree as having a value).

Basically, in the old code any Git command would immediately fail
because of the interpretation of core.bare or core.worktree. So
this check is just a check that a basic Git command doesn't fail

>> +               git config --worktree bogus.key value &&
>> +               git config --unset core.bare &&
> 
> Why is this being unset? (Genuine question. Am I missing something obvious?)

I'm moving it out of the common config file. Earlier commands
enabled it in the config.worktree file for this working tree.

Thanks,
-Stolee
