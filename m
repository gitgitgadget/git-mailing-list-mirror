Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA25DC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 16:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiGZQiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGZQiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 12:38:10 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7827C186C6
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:38:09 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10cf9f5b500so19274639fac.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0/qcUJrwTi8TsbInPQsEGIIVmY4N0aWkw1Komco1xu8=;
        b=Pp8vgFNpX0L/tV5rMAaV79F7euNhf1tgl7TUpHLqpcckIfAlH/4Yzrr4qxqY4lcqTR
         TwRU4C4TLebTx+j6D0T2PDlrXN2P4wh3tsizxkrWuq5ltafQR0CuZ9r+DuRUbbbe976Z
         FF3CGizxH5M59ANlz8ENMfcvCar99MMC+d1eVKKmWLW56FV7GHFTRNkTiNEegO7xMtwZ
         +1pqYDoiVe7SWxfzB6mO7j9MMq7E6VqnlskjVaIaTN+MuLTrYv8Hp0m6nFkAPJHeTlYz
         yUn+Iahngn2AL2qHKW0+205hG+pFG0TaRz7gItNNKGyx4GANVbw16jquNxkvHFZx48El
         6XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0/qcUJrwTi8TsbInPQsEGIIVmY4N0aWkw1Komco1xu8=;
        b=FEeHehhOqFajHuw9BtOmrlTyY/qIfodULHJMW5dOSZwK0WsUhXxYQhKRcbixymA2Hh
         jiiEAuDCX0U26M4YVGxDkwGfjhq1FfDXrDcXqXofqKW4U0nEdPG5gX1jSTltKdakpt75
         YrS3fiWTEfz4anxNGjR6hnpCD2xNd7zkrlzacOE4dHHvkOeGChupMlBezUOOmJOfUp2E
         4VOdkt7MIiHFXp7ruv0M4DgBd1VOgWCFxerfOjW7u9WXXQxOcfoRQmWGhf4sTOT4YDvr
         2EkkWkZAJTTMUg2LPV2A80qWCXHyl86Vr30cWvwEgmSz3m9kBmanUKH3xPfJsmutT0S6
         AOEQ==
X-Gm-Message-State: AJIora9m9HL2PuNBtMNveutuAJby8DJN87eqI3O1M8RfOUpwPeXhXTVS
        eXBUSioeAFa8GtIGauJ6/+IdasKTBi16
X-Google-Smtp-Source: AGRyM1v9DZ2/co+Y3+GCLh6LvcJTNUSp6cJWLhV9AJM5Vh6A9f9scvb7BHqLJijyUIV74FgfQMCWLg==
X-Received: by 2002:a05:6870:c588:b0:10c:4b7c:d5cf with SMTP id ba8-20020a056870c58800b0010c4b7cd5cfmr49784oab.72.1658853488753;
        Tue, 26 Jul 2022 09:38:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:70fc:586a:b1e2:eef? ([2600:1700:e72:80a0:70fc:586a:b1e2:eef])
        by smtp.gmail.com with ESMTPSA id r3-20020a9d7503000000b0061c7adb4006sm6391866otk.13.2022.07.26.09.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 09:38:08 -0700 (PDT)
Message-ID: <c3b14045-01a1-e207-a60d-2e3290ab8001@github.com>
Date:   Tue, 26 Jul 2022 12:38:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] log: create tighter default decoration filter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <220726.86tu73ncf8.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220726.86tu73ncf8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/2022 10:44 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> This was previously reduced by adding the log.excludeDecoration config
>> option and modifying that config in git maintenance's prefetch task (to hide
>> refs/prefetch/*). I then followed that pattern again for the bundle URI
>> feature [1], but this caught some reviewers by surprise as an unfortunate
>> side-effect. This series is a way to roll back the previous decision to use
>> log.excludeDecoration and instead use tighter filters by default.
>>
>> As noted in the last patch, the current design ignores the new filters if
>> there are any previously-specified filters. This includes the
>> log.excludeDecorations=refs/prefetch/ set by the git maintenance command.
>> This means that users who ran that command in their repo will not get the
>> benefits of the more strict filters. While we stop writing
>> log.excludeDecorations, we don't remove existing instances of it.
> 
> Leaving aside the question of these magic refs, and if we need new ones
> (e.g. refs/bundle/*) I have sometimes made use of out-of-standard
> refspace refs.
> 
> E.g. when I build git I create refs/built-tags/* tag object refs
> (i.e. not in refs/tags/*), which is a neat way to get "git tag -l" and
> the like to ignore it.
> 
> But to still have it show decorated in logs (e.g. I'll see what my
> "private" branch is at), and "for-each-ref --contains" still knows about
> it.

You also have the unfortunate UX of having the refs spelled out entirely
("refs/<special-place>/..." instead of "<special-place>/..." like how
"refs/remotes/" is dropped from remote refs) and not having special color.
But that's beside the point.

> Now, that's a rather obscure use-case, and I suspect other "special
> refs" are similarly obscure (e.g. GitLab's refs/keep-around/* comes to
> mind).
> 
> But I think this change is going about it the wrong way, let's have a
> list of refs that Git knows about as magical, instead of assuming that
> we can ignore everything that's not on a small list of things we're
> including.
> 
> Wouldn't that give you what you want, and not exclude these sorts of
> custom refs unexpectedly for users?

Instead of keeping track of an ever-growing list of exclusions, instead
making a clear list of "this is what most users will want for their
decorations" is a better approach.

Users who know how to create custom refs outside of this space have the
capability to figure out how to show their special refs. My general ideas
for designing these kinds of features is to have a default that is focused
on the typical user while giving config options for experts to tweak those
defaults.

You're right that this series perhaps leaves something to be desired in
that second part, since there isn't an easy _config-based_ way to enable
all decorations (or a small additional subset).

>> I'm interested if anyone has another way around this issue, or if we
>> consider adding the default filter as long as no --decorate=refs options are
>> specified.
> 
> I think the resulting UX here is bad, in that we ship hardcoded list of
> these if you don't specify the config in 2/3. So I can do:
> 
>       -c log.excludeDecoration=this-will-never-match
> 
> To "clear" the list, but not this:
> 
>       -c log.excludeDecoration=

The thing that I forgot to do, but had considered was adding a
--decorate-all option to allow clearing the default filters from the
command line. You can already do "--decorate-refs=refs" to get everything
(except HEAD).

As far as config goes, we could also create a log.includeDecoration key,
but we'd want to consider it to populate the same part of the filtering
algorithm. Similar to having any instance of log.excludeDecoration, this
would clear the default list. To get all decorations again, you could add
this to your config file:

	[log]
		includeDecoration = refs
		includeDecoration = HEAD

Alternatively, we could instead create a "filter default" option such as
"log.decorateFilter = (core|all)" where "core" is the default set being
considered by this series, and "all" is the empty filter.

Thanks,
-Stolee
