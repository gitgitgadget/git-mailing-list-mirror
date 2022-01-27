Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C0C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 14:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiA0OZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiA0OY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 09:24:58 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F9C06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:24:58 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so2703059otp.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ayR6bWynDDoN1qO9JbHh+3ZljfyEgkYJyFCyOEEtVgw=;
        b=dYWWsEm9ACDK+n9Tt2HYnHX09FbL0uEnrlrAz+ei1eGtdS20os8VImAkLj9RT9Bpmu
         2zmP5tuCjSWGYwPxMI72FpxwsXjmA6jTrczKYG22KSrTRsaQypltMEisUWNT3KJ/gJ0n
         vE1PloMQuLLLNmmDE5S1zCBO+UMIro2lcNPisMJafOFYe9+LzmRZB2QlIDmbXL40A0yw
         YpWCzPM0Epu5nEdXZdChfpzzp1ukoYPukeKC+TqvPdn5l03eVWtImYOGcPHGjG7B/crh
         Yb2i7X1VuJk8fxwwHJmDvV6Oj5lPbjtiTJ1hF+oesr+5swVa8KwgMWZZOseN8sahJEyd
         TzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ayR6bWynDDoN1qO9JbHh+3ZljfyEgkYJyFCyOEEtVgw=;
        b=riiOplrQXmxvlDxcrwZhTpfD3wwrML6EbszX84axOvqcA6LBbj+gaYzgIjQs8Ih94D
         yUyRDS4RBD/W+BJR0JgLgW6a2onRsdmsp+gntWh26efC6pHGOjJeAFmbbzuuEa8rWC34
         l04xJYr3VT65uwTVf5nyfshPwKdmGp78ghU4RdVBRp2MwERhPC6zvnTVxZfUe4RA3pWX
         8rQW7UeuQOgA7yJdnAf+LDLywwZbfFhN/cP1N8IFK2hUrgr4yVwXBvnQQQsZO2FBhJ8i
         26gDOBSd8ZxvZdcxPV1AhfAfPLBJAm5pcJoO9MYo+SeT9ms6ggLL1Tl4Z0P7BTIkpyiF
         j03Q==
X-Gm-Message-State: AOAM531unHxc9B2J64RMMOsmU5ldqbXoqt/aowIRB6+TvBCYmuN49RIp
        kAli7Kg32oVOcYnR8eeIwBc=
X-Google-Smtp-Source: ABdhPJzgKqsg73qyoTECphsWo7ar6WyCcOmkhoRmPeHWUp8vyYPW5a9nkFqsNW5VRctW6QSS4GClEg==
X-Received: by 2002:a9d:315:: with SMTP id 21mr2169844otv.271.1643293497450;
        Thu, 27 Jan 2022 06:24:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id j19sm6408856ots.21.2022.01.27.06.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:24:56 -0800 (PST)
Message-ID: <eb7e927b-b47e-1d92-164d-d0a4d30f6ac6@gmail.com>
Date:   Thu, 27 Jan 2022 09:24:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/5] sparse-checkout: set worktree-config correctly
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <fbfaa17797c023f4a86eeac200a83c2e1954daf5.1643136134.git.gitgitgadget@gmail.com>
 <CABPp-BHBMUar-ysiJsjmpqQ3NPjRUiBPKEdHty3ADBYaf0EMug@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHBMUar-ysiJsjmpqQ3NPjRUiBPKEdHty3ADBYaf0EMug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2022 2:15 AM, Elijah Newren wrote:
> On Tue, Jan 25, 2022 at 10:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>  'set'::
>> -       Enable the necessary config settings
>> -       (extensions.worktreeConfig, core.sparseCheckout,
>> -       core.sparseCheckoutCone) if they are not already enabled, and
>> -       write a set of patterns to the sparse-checkout file from the
>> -       list of arguments following the 'set' subcommand. Update the
>> -       working directory to match the new patterns.
>> +       Enable the necessary sparse-checkout config settings
>> +       (`core.sparseCheckout` and possibly `core.sparseCheckoutCone`) if
> 
> and possibly index.sparse as well, right?

Good catch.

>> +       they are not already enabled, and write a set of patterns to the
>> +       sparse-checkout file from the list of arguments following the
>> +       'set' subcommand. Update the working directory to match the new
>> +       patterns.
>> ++
>> +To ensure that adjusting the sparse-checkout settings within a worktree
>> +does not alter the sparse-checkout settings in other worktrees, the 'set'
>> +subcommand will upgrade your repository config to use worktree-specific
>> +config if not already present. The sparsity defined by the arguments to
>> +the 'set' subcommand are stored in the worktree-specific sparse-checkout
>> +file. See linkgit:git-worktree[1] and the documentation of
>> +`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
>>  +
>>  When the `--stdin` option is provided, the patterns are read from
>>  standard in as a newline-delimited list instead of from the arguments.
>> @@ -73,7 +81,9 @@ interact with your repository until it is disabled.
>>         By default, these patterns are read from the command-line arguments,
>>         but they can be read from stdin using the `--stdin` option. When
>>         `core.sparseCheckoutCone` is enabled, the given patterns are interpreted
>> -       as directory names as in the 'set' subcommand.
>> +       as directory names as in the 'set' subcommand. The sparsity defined
>> +       by the arguments to the 'add' subcommand are added to the patterns
>> +       in the worktree-specific sparse-checkout file.
> 
> This sentence addition makes your series conflict with patch 4 of my
> en/present-despite-skipped series.
> 
> The sentence also seems somewhat redundant with the first sentence of
> the paragraph (not quoted here).  Perhaps consider just dropping it to
> make it easier for Junio to integrate?

I'll just drop it. Thanks.

>>  'reapply'::
>>         Reapply the sparsity pattern rules to paths in the working tree.
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 679c1070368..314c8d61f80 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -15,6 +15,7 @@
>>  #include "wt-status.h"
>>  #include "quote.h"
>>  #include "sparse-index.h"
>> +#include "worktree.h"
>>
>>  static const char *empty_base = "";
>>
>> @@ -359,26 +360,23 @@ enum sparse_checkout_mode {
>>
>>  static int set_config(enum sparse_checkout_mode mode)
>>  {
>> -       const char *config_path;
>> -
>> -       if (upgrade_repository_format(1) < 0)
>> -               die(_("unable to upgrade repository format to enable worktreeConfig"));
> 
> Wait, this got added in mid-2020, since v2.28.0 -- and I missed it but
> it hasn't bit us yet??
> 
> I'm so sorry.  Earlier when I objected to setting this, I was worried
> it was a new change and would introduce some new failures, but clearly
> it was already introduced...and it turns out we've been fine.  So, I
> was wrong to worry about this.
> 
> (Which is to say, if you want to add it back, I'm fine with it given
> this info.  If you'd rather still take it out, I'm fine with that
> too.)

Yes, this has been around for a while. However, based on our discussion on
this topic, this was never necessary for the worktreeConfig extension.

Removing it seems to increase our compatibility, but it would be interesting
if we catch new compatibility problems. I'm thinking specifically about
third-party tools that should complain about extensions.worktreeConfig and
specifically reading sparse-checkout settings from worktree config files.

> Patch looks good; I only had a few very minor comments.

Thanks,
-Stolee
