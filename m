Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80AC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiF3Rfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiF3Rfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:35:52 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9901031367
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:35:51 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l9-20020a056830268900b006054381dd35so15220190otu.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/V9MH4fPs8SvPfjO9tqK0+o0fi3aKvNy2NnANEDfFUY=;
        b=PlnK3MzNTESSQ7RM4WZ9Ejqf4Qnswqi7l9nPEKIMWtY2F6Aah6PHUQ0drXz+slGrX2
         M9h6aq4tbVH7q8rYu+fgEBEZpRyAd55QuCbr3xJhYcsaAQAvSs/6bC8UsSySM0/wKhH7
         7H5gR7I7xkpyPGMNADb+HuaVXmr+EPBp656ZL17EcXmoibl6wDoF17Anq48lYIZJ/tLQ
         FCAUiAyDaX02GXzv6m62ps27C6Z7m8xL3OHGOtKC9n+d1ZbgOjZ3JtOJRTbXv4+KaJjB
         TGZt3bZRCdTg9DBgzTbopog3rULC/IWGsVrJnw2DDqnfrDRcYRq1MU8YeOIQN9Dzdkce
         Vs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/V9MH4fPs8SvPfjO9tqK0+o0fi3aKvNy2NnANEDfFUY=;
        b=MLTEPYi2o2vIxAaeYa9FKNHMksdBzxGuCdcJmtgwHXpAKszX6ydUJz/n/kRpcUsmMK
         41VvsvV2j2rtZHYfKnQ7O/k23sjuzyV9yotYZMQfhQQ1RJSZ5mZ3dUUxl+HhGvijIQPK
         aezdoHHHggIMAY/7IullZnI0IXUM0ic+g/9Rs8OrAiwJ4RqohoTLMgAbL5QvMvoz29p9
         S5FLrGDam1lEx4bL8W3rwC7EtcQIyjJ+ylXvvHGgRE55ql1OgxAD9wSSk3/sW3he2Yyt
         e1hKx25IG0u5dKS1lUYsPz0dDu36/qxNvVCiC3pHOIGOkFCDzrAnpqi4+W8ZGEHc6J4H
         Bd6w==
X-Gm-Message-State: AJIora9zHBVspaKpIR9xfbRCzDLArG2eIx9A1stLyGi8XcLGm9nqMGVk
        d976JseI/ouxhF9KR4SRRnNg
X-Google-Smtp-Source: AGRyM1vH94UKrsFDjaA6+0tmxDMswQ8SiXtdGHBMqPbzh6sNVDqY95/5fHvRc1UeAIT/CIw6cP2jAg==
X-Received: by 2002:a9d:518d:0:b0:616:ad1e:1a7a with SMTP id y13-20020a9d518d000000b00616ad1e1a7amr4626311otg.205.1656610550943;
        Thu, 30 Jun 2022 10:35:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9dd5:ad82:1c87:defd? ([2600:1700:e72:80a0:9dd5:ad82:1c87:defd])
        by smtp.gmail.com with ESMTPSA id g20-20020a544f94000000b003352223a14asm10593524oiy.15.2022.06.30.10.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:35:50 -0700 (PDT)
Message-ID: <038f1c9e-0c75-c011-22c9-a8f478e4f1bf@github.com>
Date:   Thu, 30 Jun 2022 13:35:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/8] t2407: test branches currently using apply backend
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <fbaedc7f1f02efec251cb4df665fd3cb71f1d3b3.1656422759.git.gitgitgadget@gmail.com>
 <xmqqtu84iklu.fsf@gitster.g>
 <4016eee6-0759-dece-cd7b-0ed8454faf63@github.com>
 <xmqqwncyf6dx.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwncyf6dx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/30/2022 12:44 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> I can either re-roll that series or create a new forward-fix that
>> includes the functionality of this test. Both are the same amount of
>> work for me, so let me know which you prefer.
> 
> Either is fine by me.  Other than this small glitch in the test, the
> remainder of the "should we allow this branch to be touched?" topic
> looked really cleanly done and ready to be unleashed to the public.

If you don't mind, I've got some forward-fixes prepped for the next
version of this topic. They are test-only changes and do not change
the implementation of branch_checked_out().

One thing I noticed from looking back on the series is that I wrote a
test that specifically tests a case that is impossible to construct
without modifying the .git directory directly (having two worktrees
"reserving" a branch for different reasons). That test will need to
stay as one that knows about the internals of this storage, but the
others can be replaced with more opaque steps.

In patch 2 of this series, I test the 'update-refs' storage using a
similar mechanism. I can replace that with the opaque version that
calls 'git rebase --update-refs', but only as part of patch 7, since
writing the file is not implemented yet.

I was going to ask if I should reorder the patches, but there is a
possibility that we will change the storage of these "reserved" refs
yet again, so I won't focus on this point quite yet.

Thanks,
-Stolee
