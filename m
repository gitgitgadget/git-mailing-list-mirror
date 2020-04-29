Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2502CC83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 05:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF185206F0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 05:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsppyWLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgD2F5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 01:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgD2F5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 01:57:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9CC03C1AC
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 22:57:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 7so1975002pjo.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fnBNsS+0KnGqHA3IQ9Ivc0tAsj5fApM20G5Ziuc9/dQ=;
        b=qsppyWLMRUG3StP5MnEy25veMTm1Q2LRqWNerxQCHXyHJKNwu7jRFnqBa9kz58T8oW
         5MXvqbQQl4JYf15xtySON5WSbDD2CqMNiee3zksyEnrdFMrsrGnwOtS/dXi9DbALha8x
         r5nE4B+zVR6AXQfbvytkBAiAA4K0Im10guC8Gs4lpS5FLy1N07UiQBABIl0/MMEusGOb
         vO718tyJC4vCZrAmfZU3uyOkrAW+F8OMQAIwEqKLA+FyVvfV9NGb/swWOp//Um4+Mn1V
         c3jZ4bWzhqbIIX8gMS8ahlZM7vUWH0SqqEw5B/YbwOXcKBkBrQeQFV2YwCx0l1VwjTsw
         UPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fnBNsS+0KnGqHA3IQ9Ivc0tAsj5fApM20G5Ziuc9/dQ=;
        b=lDQJ7aODI3R5yq+PhtKO9vkqqfw4fHmAgxhcOT9Xg2qQgY0HY2wsK6nDB9BM0oyTXu
         7W/NVpGa+dKm74zCgL+so6R57Y65/SfN7lb2ypSw1WUEI6NEjknmZdH7NgV+yY3bnSg2
         WQTYt4A0rMA60D9zabWxaxArDqky6qJ1oMHAAqVJHTpJokiK6EUah4OG0lTYzpHhER3V
         rnow3ry75CcxfDBO4aWLJzRskeY+oIlZeWQlAhSqdLgifixoNZj8X+Gnz1whC8D50HCg
         2mxztPYgQRFJRPEcGXVV6+OmHeE3GzU+b92bCuJTa8/Uq8vtEhzQyEQFt4oeeI0k+bKT
         yyWQ==
X-Gm-Message-State: AGi0PuZbcRYY0HLpRqJgUf+BwdWcjbDWmFdLt8J5bWRwnnEGuyzSpIiw
        fVWglDnD01e4TrqcI8i77eI=
X-Google-Smtp-Source: APiQypLzhE9kizFrBPbEdxk938sqXVOeqWpFNd8s8IK0RSL6kKecy+EGaTDJBf98Z/m8H6ORmQ5uKA==
X-Received: by 2002:a17:90b:23c7:: with SMTP id md7mr1168931pjb.165.1588139821943;
        Tue, 28 Apr 2020 22:57:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 23sm3669760pjb.11.2020.04.28.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 22:57:00 -0700 (PDT)
Date:   Tue, 28 Apr 2020 22:56:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: proto v2 fixes for maint (was Re: Preparing for a Git 2.26.3
 release)
Message-ID: <20200429055659.GC42649@google.com>
References: <20200428055514.GB201501@google.com>
 <xmqq7dxz4j62.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7dxz4j62.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The protocol version change was painful for users that fetch in the
>> same repo from linux-next and other linux remotes[5].  The problem has
>> been isolated and fixed, so we could either apply the revert or apply
>> the fixes[6].
>
> The demote patch hasn't even hit 'master'.
>
> My preference is to merge the demotion down to 'master' and 'maint'
> while merging down this fix to 'next' and to 'master'.
>
> And immediately revert the demotion on 'master', which will make the
> tip of 'master' with v2 as the default, with "this" fix.

Yes, sounds good to me.

By the way, the diagnosis in the demotion patch

    Users fetching from linux-next and other kernel remotes are reporting
    that the limited ref advertisement causes negotiation to reach
    MAX_IN_VAIN, resulting in too-large fetches.

turned out to be false, as Peff noticed.  It wasn't due to the ref
advertisement but was due to the protocol v2 code's reimplementation
of negotiation.  It's probably not worth amending the commit message,
given that it's already in "next"; we can correct the record in the
revert for 'master', which I should probably write during the day when
I am less likely to make more errors.

Michal Suchánek wrote:

>                                   Why not merge the fixes for v2,
> though? Even if it is not the default keeping it broken in maint does
> not sound great.

Yes, I like the "demote and fix" approach you're recommending.

Thanks,
Jonathan
