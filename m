Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF3C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 14:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8A64F0C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 14:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBYOVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYOVU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 09:21:20 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20F5C061756
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 06:20:39 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id h17so6208491oih.5
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 06:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5S0yYD5AevtflsfUSFgXlmXYEbbNOsj2YvvnYFgJ9hU=;
        b=MXwBeDyTa8OFizVF7BGU+cLdGXSM36e9F2NiA2TlvpISdrm389pNreQWr40cciMvaz
         60UAXi8lWGjWmO0oqDmqqtm2oZO94yuXFm3GtS4HUqmZtwXliXG86UZG/uWgQL1chs6f
         oVEAuWH+ri7zBSAJZr18s7LL9H1pI3WzASZ55KWGHhHMsQd/+h2a+4kcDULcqvW72EOB
         KB1u//MjysuxVw7Yw/hGbVcJZ/isjCMFKZmPMstN8eIHRO8dPkZJsAjbBbfXqlejmJFV
         yjpdDs/N2amfDxhpjeJYgfcaHC8Ggis/trybIUKL6cMZ9j+zpvxGw/Nn0yR7vVo6nuMI
         kqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5S0yYD5AevtflsfUSFgXlmXYEbbNOsj2YvvnYFgJ9hU=;
        b=TQ36/nLSg4tVV9iqlJmJOEWqPaZNnjNCytEUJzPRKzeXMHycCpdZsDB/OQs06VENCh
         tXy/dm43d+Rr86vX0ewel3Scp3vsLw9EkrHQAJusuTLxuuZ6708S8EsWspE+eJ5Bh/fA
         5JjUEXvF4OwJkkObCubjG05jcTyMjWp6tXHWHPk2V/sm+8kvqpfZEtE2Z3/sdVV7vNSJ
         XOMhCyZ+y2i/DQ5wlSyyCvHmvmlz3bO9r6HYeIls9m1RxwqaNXT01WlN2dG2zj/qpScW
         8WNt1JIH40U3aeYMlC0as0gxUFN270rA3agJSGkWzzwAqhJ1EdFRGD4t6tQ8PMb3Wdpn
         No8w==
X-Gm-Message-State: AOAM531pMVlwMvs7FhVV4nmPjYffOiI4+MtDb58mv6Zw7CHgyYygHUGU
        qVT5oanc+2AXcifAjhQzWlApDpYziFBMfA==
X-Google-Smtp-Source: ABdhPJx5uld41zSuPIAW64DRWIOw2oolhqk+ZsCMUaEHdYheddeoYBXeJQVqQDnw5ZAHNud3tjQDHA==
X-Received: by 2002:aca:3383:: with SMTP id z125mr2071830oiz.48.1614262838802;
        Thu, 25 Feb 2021 06:20:38 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:89d4:92f7:793a:6399? ([2600:1700:e72:80a0:89d4:92f7:793a:6399])
        by smtp.gmail.com with UTF8SMTPSA id b7sm1011043oiy.29.2021.02.25.06.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 06:20:38 -0800 (PST)
Message-ID: <fc8a2c0f-24b7-5884-b669-bb9700f3ba84@gmail.com>
Date:   Thu, 25 Feb 2021 09:20:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: Commit graph chains with no corresponding files?
Content-Language: en-US
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Users <git@vger.kernel.org>
References: <20200629220744.1054093-1-jonathantanmy@google.com>
 <92b218ca-f2b4-db9d-9f9c-1d071ea4fa97@gmail.com>
 <CAGyf7-G_OdS_0o7j64HA79n9Qv13SxciQSG+gfY7Qj8kNRQS5Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAGyf7-G_OdS_0o7j64HA79n9Qv13SxciQSG+gfY7Qj8kNRQS5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2021 11:54 PM, Bryan Turner wrote:
> On Mon, Jun 29, 2020 at 6:51 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/29/2020 6:07 PM, Jonathan Tan wrote:
>>> At $DAYJOB, a few people have reported "warning: unable to find all
>>> commit-graph files" warnings. Their commit-graph-chain files have a few
>>> lines, but they only have one commit graph file with very few commits. I
>>> suspected something happening during fetch, because (as far as I know) a
>>> fetch may cause an incremental commit graph to be written, but I ran a
>>> fetch on a large repository myself and didn't run into this problem.
>>>
>>> Has anyone ran into this problem before, and know how to reproduce?
> 
> I don't have any specific reproduction steps, but we've just run into
> our first case of this on Git 2.29. I ended up kicking off a full `git
> commit-graph write` to fix it. That displayed the same warning, but
> commands run after it no longer do. Prior to writing the new graph, I
> had this:
> $ ls
> commit-graph-chain  graph-88f5fe6e0c659e3742e556982263813d528ead81.graph

The contents of the 'commit-graph-chain' file are critical to diagnosing
the problems here. Likely it had multiple lines.

> Afterward, the `objects/info/commits-graphs` directory still exists
> but is empty, and there is now an `objects/commit-graph` that didn't
> exist before. `git commit-graph verify` seems happy with the state of
> things.

Yes, a full rewrite without "--split" will get you to this state.

>> The incremental commit-graph code deletes any commit-graph files
>> that do not appear in the chain. I believe this is done by comparing
>> the contents of the ".git/objects/info/commit-graphs/" directory to
>> the contents of the chain file.
>>
>> These appear to be case-sensitive, full-path comparisons.
>>
>> It is _possible_ that something like a case switch or a symlink
>> could be causing a problem here. That's where I would look on
>> the affected systems.
> 
> Are commit graphs potentially problematic in repositories that are
> borrowing objects from other repositories via alternates?

This was definitely part of the design, with the intention of
working with a common base in the alternate. However, if the
alternate collapses layers, then the repo that is borrowing
from that alternate may have a broken chain.

It is likely a better setup to have the alternate keep a
commit-graph file and leave the dependent repos clear of a
commit-graph. _Or_ the dependent repos should use a full
commit-graph instead of a chain.

If you have a better idea for how to make this work, then there
is room for improvement.

For example, if we ensure during the commit-graph write that
all layers of the chain are within our local repo, then these
dependency issues go away without breaking any old Git versions
that are reading the data.

> Have there
> been important changes to commit graphs since 2.29?

Not in the area of commit-graph chains.

Thanks,
-Stolee
