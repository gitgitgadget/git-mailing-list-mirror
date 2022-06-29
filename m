Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE923C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiF2M6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiF2M6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 08:58:52 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F396377E1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:58:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f14so11996690qkm.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mOsO1k79ZAwnOC8av4qtVylobeYsRt7bHCM2+ebhxh4=;
        b=DXTj+MgYhNR26No1ATrfoRu8B4y30VOEeCBQabWKAltHW/NEgRoIABZgIkb0qLD6ES
         Uv3s2lOQhMYUjjfh9FIKj0dY6LOeNVkxYNzoQZwR6CIi06mIfsSIEDfeBhOVngpnTZno
         rNGpysWt0M12CBT6otAgbPcT/UIcO3uM7V7KJ3cq7Dhm4j3nPsjyN5hn5+ioJlG9puz0
         AkVXyKqHTM20HnOfFacTU19SSw6UQ4PP0tkNA078CsSj+D6yA588eerQKZ9lpr6198ZD
         Gg8/gPurk6jS+MEPsxM+cKH8X4iNcElb4pOtmeWGruXaA+5tI3fV3H+93nLeOtBrkXI9
         sLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mOsO1k79ZAwnOC8av4qtVylobeYsRt7bHCM2+ebhxh4=;
        b=pt9MMHdKtf5zmySkkZN0j1ryddEd/o6ybq3wmC4aMnMhLBLmT7e+YQLgFZFvIA/FFu
         JqOxjwnqIoN39FPs71I7vH0zBy0Ik+v9bjmqIFPdfrL9NITA+5bjB1z3CzTbRxpM81w2
         +16ScAMjh67CwpiMmvUleaEwqWflxklW7YuJDQoig3BwaBitAM394rHO8JIzxbXIdV3x
         X+9Un+YYinVNCxghV/8Re4RZwcOodXtHsECelqUHhtLiTSOCGpnB7ibIujsDXq1W2eKo
         9KpwhEuGc7edu9EnMg2UkhAimXQBcBfM+9oZu8htjpdqPBrdfO7+5zd0j3ofCzfxtaM0
         x2Qw==
X-Gm-Message-State: AJIora/bhHmAy6yokiff6vT3pIfzOrpwueTiDClWSq5Nr1eWFsicKQAV
        cO4yETKQ6gHgUMTIfWSSSYeb
X-Google-Smtp-Source: AGRyM1tbr4sHSJY7E9vjJyQ/crlOghP5ZyaNMWwEkVlbgmf0E9eXPSNKF+HrZsFbDugdGeyWXhTfNQ==
X-Received: by 2002:a05:620a:4451:b0:6ae:fd29:149d with SMTP id w17-20020a05620a445100b006aefd29149dmr1875969qkp.724.1656507530016;
        Wed, 29 Jun 2022 05:58:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id v22-20020ac87496000000b003051f450049sm10807760qtq.8.2022.06.29.05.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 05:58:49 -0700 (PDT)
Message-ID: <9d188e11-7bb4-cae7-b38a-f9f38c8c2fe1@github.com>
Date:   Wed, 29 Jun 2022 08:58:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
 <xmqqpmisikex.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqpmisikex.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/22 4:48 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The branch_checked_out() helper helps commands like 'git branch' and
>> 'git fetch' from overwriting refs that are currently checked out in
>> other worktrees.
>>
>> A future update to 'git rebase' will introduce a new '--update-refs'
>> option which will update the local refs that point to commits that are
>> being rebased. To avoid collisions as the rebase completes, we want to
>> make the future data store for these refs to be considered by
>> branch_checked_out().
>>
>> The data store is a plaintext file inside the 'rebase-merge' directory
>> for that worktree. The file alternates refnames and OIDs. The OIDs will
>> be used to store the to-be-written values as the rebase progresses, but
>> can be ignored at the moment.
>>
>> Create a new sequencer_get_update_refs_state() method that parses this
>> file and populates a struct string_list with the ref-OID pairs. We can
>> then use this list to add to the current_checked_out_branches strmap
>> used by branch_checked_out().
>>
>> To properly navigate to the rebase directory for a given worktree,
>> extract the static strbuf_worktree_gitdir() method to a public API
>> method.
>>
>> We can test that this works without having Git write this file by
>> artificially creating one in our test script.
> 
> Hmph, I am not thrilled to see an ad-hoc text file for things like
> this.  Do the objects that appear in this file otherwise already
> anchored by existing refs, or can some of them be "floating" without
> any refs pointing at them, i.e. making the "connected" and "fsck"
> machinery also being aware of them to protect them from collected as
> garbage and reported as dangling/unreachable?

You're right that we could have this sequence of events in a todo
file:

  pick deadbeef Here is a commit that will become unreachable
  update-ref will-be-lost

  squash 1234567 make will-be-lost unreachable
  ...

So if a GC runs after this 'update-ref' step but before the rebase
completes, then that commit can be lost. The ref-update at the end
of the rebase process would fail.

I wonder how important such a situation is, though. But I'm willing
to add the extra lookups in 'git gc' and 'git fsck' to make this a
non-issue.

I'll take a look to see where the other refs in rebase-<backend>/*
are handled by these processes.

Thanks,
-Stolee
