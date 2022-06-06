Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3EC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 15:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiFFPMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiFFPMt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 11:12:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A962C26124
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 08:12:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s26so2607123ioa.3
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qbX04HPMpcMPB5hY/h9VfXBnhRWMWR62FMY/X8Q1104=;
        b=Fd8rwuP5cr28pOhO2UXdF26pTah5wPdQNFy/3U329dgtIF+8chZqxlZstYDZisX9QI
         X92WTa5xMtYHetO2CzoE/fp87GH1fQZw19ZZ5dX2Hn/rJbAHb+vj5OrDKx0JJ7vkDJk0
         E3Mthsb1n5/vSJ2o+hOuNAhzfvd74cNodtmrke/iQT5lKb0xou7XP3MB4BM2hQquNvP4
         YvBFGTHXDUPzL/wegQlPrPF/G8HNOAzs0/dHRE6AGQCQ+20wCnVdXauC8t3mdMqzNwBk
         TCgfdWCSFLM/omPDxCnuEK7+Zx9XpBynYZj7OzreU+oC3HoErGtjJjMHPdNcO/RHYd0h
         gOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qbX04HPMpcMPB5hY/h9VfXBnhRWMWR62FMY/X8Q1104=;
        b=H45VxvMLZYlGtvnZ5BPAm2BhUvzeG/oL0cYRkDR3GR4nfCb/kpT5hVWQopppu6g9Mr
         EygXMhK4WI91mTs4zmXR8cnlQRyOR/Q6pDLDwjYkwp+4z4Jo2Uh1a6HCKAWFQPYM9P71
         19SgpfBDD2xgfIqcjoSgaeKXOJx7pG+a54bWNGa0ixvtEIRRiIlYmh1gj/KxchLs4HuB
         SelQeZHj4OQeS8Q0B6KYvEE413J1p2xtqKKxSxYajvs+iRaNsjjqKsfw0/dPQjbwmOrX
         wKIX3k9spz3mj5eENNr0Co6Cygwqkdy8gHINetpaFm1neoWgMsCCMR1hJyGFhyAygXmI
         YKZA==
X-Gm-Message-State: AOAM530lPB29/jM2QMfQwynRIWgfHZAxFbJ4E+VYXsUFwU4FwsMiTRzr
        7YDUCCxsoiM8vN3EnBTQYcj0
X-Google-Smtp-Source: ABdhPJwDkBazM3FdZX03sjV1EkI4rqI5VYvOkWrNWqg7d6OTYuSAcYbsuxWNjyvIYW5/gr4jsQ0BMQ==
X-Received: by 2002:a05:6638:1350:b0:331:9b1:e917 with SMTP id u16-20020a056638135000b0033109b1e917mr13637192jad.131.1654528367977;
        Mon, 06 Jun 2022 08:12:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9db2:3a78:7e97:ec18? ([2600:1700:e72:80a0:9db2:3a78:7e97:ec18])
        by smtp.gmail.com with ESMTPSA id s13-20020a02c50d000000b00331563be3ecsm5768088jam.121.2022.06.06.08.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 08:12:47 -0700 (PDT)
Message-ID: <3bb8baa2-e3e0-5cf1-aace-b0ba3ec6eb77@github.com>
Date:   Mon, 6 Jun 2022 11:12:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <YppSl4rOvVciLuXE@nand.local>
 <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2022 11:28 AM, Phillip Wood wrote:
> On 03/06/2022 19:27, Taylor Blau wrote:
>> On Fri, Jun 03, 2022 at 01:37:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> This is a feature I've wanted for quite a while. When working on the sparse
>>> index topic, I created a long RFC that actually broke into three topics for
>>> full review upstream. These topics were sequential, so any feedback on an
>>> earlier one required updates to the later ones. I would work on the full
>>> feature and use interactive rebase to update the full list of commits.
>>> However, I would need to update the branches pointing to those sub-topics.
>>
>> This is really exciting. I'm glad that you're working on it, because I
>> have also wanted this feature a handful of times over the years.
> 
> Yes, thank you Stolee. I agree this will be useful, but I wonder if users
> will be confused that --update-refs only updates the branch heads that happen
> to be in the todo list, rather than updating all the branches that contain a
> rewritten commit. I think the latter is something we should try to add in the
> future and so we should take care to design this topic so that is possible.

At the moment, the design adds a comment to the TODO list, showing which
branches are not possible to move because they are checked out at another
worktree (or is currently checked out and will be updated by the rebase
itself). That seems like a good place to insert alternative logic in the
future if we see a need for better behavior here.

Unless: am I misunderstanding something about your concern here? Are you
worried about refs outside of refs/heads/*? Are you concerned about it
being _all_ refs/heads/* that we find?

One potential way to extend this (in the future) is to make --update-refs
take an optional string argument containing a refspec. This would replace
the default refspec of refs/heads/*.
 
>> This definitely would have come in handy when writing MIDX bitmaps,
>> where I was often editing a local branch pointing at the final topic,
>> and then trying to reconstruct all of the intermediate branches after
>> each rebase. Not ever having to do that again sounds like a delight ;-).
>>
>>> pick 2d966282ff3 docs: document bundle URI standard
>>> pick 31396e9171a remote-curl: add 'get' capability
>>> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
>>> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
>>> pick 6adaf842684 fetch: add --bundle-uri option
>>> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
>>> exec git update-ref refs/heads/bundle-redo/fetch HEAD 6c5840ed77e1bc41c1fe6fb7c894ceede1b8d730
>>
>> But I wonder if we can or should delay these update-refs as long as
>> possible. In particular: what happens if I get past this "exec" line (so
>> that I've already updated my bundle-redo/fetch branch to point at the
>> new thing), but decide at some later point to abort the rebase?
> 
> Absolutely! There is also the question of what to do if a user skips a
> commit that is a branch head. It is not obvious if they just want to drop> that commit from the branch or if they want to skip updating the ref as> well (I guess they can edit the todo list for the latter case).

>> I think users will expect us to restore bundle-redo/fetch to where it
>> was before if we end up in that case. Recovering from it manually sounds
>> like kind of a headache.
>>
>> What if instead we created labels here, and then delayed all ref updates
>> to the end by replacing this with:
>>
>>      label bundle-redo/fetch
> 
> Instead of using 'label' and 'exec' I'd prefer a new todo list command
> ('update-ref' or 'update-branch'?) used in place of 'label' that takes a
> branch name and updates the branch ref at the end of the rebase. That
> would make it easy to do all the updates in a single transaction as you
> suggested. Adding exec lines to do this makes the todo list messy and we
> have been trying to stop rebase forking all the time.

Thanks. Yes, a new 'update-refs' step at the end would be good to make
it clear we want to rewrite the refs in one go without a possible
interruption from the user.

Thanks,
-Stolee
